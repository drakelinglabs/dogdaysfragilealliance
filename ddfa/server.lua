
local snq_foldername=         GetConvar("ddfa_savenquit_folder",   "f9a611ea11142c3_characters/")
local players_foldername=     GetConvar("ddfa_playerdata_folder",  "f9a611ea11142c3/")
local factions_filename=      GetConvar("ddfa_factions_file",      "f9a611ea11142c3/factions.txt")
local top20_filename=         GetConvar("ddfa_top20_file",         "f9a611ea11142c3/top20.txt")
local racing_records_filename=GetConvar("ddfa_racing_records_file","f9a611ea11142c3/racing_records.txt")
local geocaching_foldername=  GetConvar("ddfa_geocaching_folder",  "630ca54126/")
local properties_foldername=  GetConvar("ddfa_properties_folder",  "ddfa_properties/")
local clothes_foldername=     GetConvar("ddfa_clothes_folder",     "ddfa_clothes/")
local server_stopped=false

local player_data={} --file path
local player_steamid={}
local player_garage={}
local player_clothes={}
local player_properties={}
local money_drops={}
local player_money={}
local player_wanted={}
local player_punished={}
local player_pos={}
local player_plates={} --uses steamid as key
local player_faction={}
local player_missions={}
local player_timeouts={}
local current_heist=0
local heists_running=0
local factions={}
local top20={}
local top20_lowest
local top20_count


local discord_webhook='https://discordapp.com/api/webhooks/413773801114042368/aphu_icHA-MPRFqOGGiz13k9j8KOjEcZFbWQuvwEfsVmoXiNYC62SLsP9yU21ad5TXFF'
local discord_callback=function(err,text,headers)
    if err~=nil and err~=204 then
        print("error sending error report:"..err)
    end
    print("callback text="..text)
end
local function discord_log_error(text)
    PerformHttpRequest(discord_webhook,discord_callback,'POST',json.encode({username=Error,content=text}),{['Content-Type']='application/json'})
end

local function two_decimal_digits(a)
    local b=math.floor(a)
    local c=math.floor((a-b)*100+.5)
    if c>99 then
        return ""..(b+1)
    elseif c>9 then
        return b.."."..c
    elseif c==0 then
        return b
    else
        return b..".0"..c
    end
end
local function loadfactions()
    local i=0
    local file,err = io.open(factions_filename,"r")
    if file then
     for i=1,13 do
        local score=math.tointeger(file:read())
        if score then
            factions[i]=score
        else
            factions[i]=0
        end
     end
     file:close()
    end
end

loadfactions()

local function savefactions_really()
    local i=0
    local file,err = io.open(factions_filename,"w")
    if file then
     for i=1,13 do
      file:write(factions[i].."\n")
     end
     file:close()
    --print("faction top updated")
    else
    print(err)
    end
end

local savefactions_scheduled=false
Citizen.CreateThread(function()
    while true do
        Wait(60000)
        if savefactions_scheduled then
            savefactions_scheduled=false
            savefactions_really()
        end
    end
end)
local function savefactions()
    savefactions_scheduled=true
end

local function update_factions(i,amount)
    if i then
    --print("faction "..i.." updated")
        i=gang_economy[i][1]
        if factions[i]>0 or amount>0 then
            factions[i]=factions[i]+amount
            if factions[i]<0 then factions[i]=0 end
            savefactions()
        end
     --else
     --print("faction nil")
    end
end

local function GetPlayerSteamID(player)
    local identifiers=GetPlayerIdentifiers(player)
    local steamid=nil
    --local ros=nil
    for k,v in pairs(identifiers) do
        if string.sub(v,1,6)=="steam:" then
            steamid=string.sub(v,7)
            if(steamid:match("%W")) then steamid=nil end
        --elseif string.sub(v,1,4)=="ros:" then
        --    ros=string.sub(v,5)
        --    if(ros:match("%W")) then ros=nil end
        end
    end
    if steamid==nil then
        steamid=player_steamid[player]
    elseif player_steamid[player]==nil then
        player_steamid[player]=steamid
    end
    return steamid
end

local check_for_multijoin

Citizen.CreateThread(function()
    while true do
        local getplayers=GetPlayers()
        local players={}
        for k,v in pairs(getplayers) do
            players[math.tointeger(v)]=true
        end
        for k,v in pairs(kick_queue) do
            if players[k] then
                DropPlayer(k,v)
                kick_queue[k]=nil
                break
            else
                kick_queue[k]=nil
            end
        end
        Wait(20000)
    end
end)

local function loadtop20()
    top20={}
    top20_count=0
    local lowest=nil
    local file,err = io.open(top20_filename,"r")
    if file then
     while true do
        local steamid=file:read()
        if (not steamid) or steamid=="" then break end
        top20[steamid]={}
        top20[steamid].money=tonumber(file:read())
        top20[steamid].name=file:read()
        top20_count=top20_count+1
        if (not lowest) or top20[steamid].money<top20[lowest].money then
            lowest=steamid
        end
     end
     file:close()
    end
    if not lowest then
        lowest='test'
        top20[lowest]={}
        top20[lowest].money=15
        top20[lowest].name=lowest
        top20_count=1
    end
    top20_lowest=lowest
end

loadtop20()

local function savetop20()
    local file,err = io.open(top20_filename,"w")
    for k,v in pairs(top20) do
     file:write(k.."\n"..v.money.."\n"..v.name.."\n")
    end
    file:close()
end

local function updatetop20lowest()
    local lowest=nil
    for k,v in pairs(top20) do
     if (not lowest) or v.money<top20[lowest].money then
      lowest=k
     end
    end
    return lowest
end

local function updatetop20(player)
    if player_money[player]>top20[top20_lowest].money then
     local steamid=GetPlayerSteamID(player)
     local name=GetPlayerName(player)
     if steamid==nil then return end
     if top20[steamid] then
      if player_money[player]>top20[steamid].money then
       top20[steamid].money=player_money[player]
       top20[steamid].name=name:gsub('%W','')
       savetop20()
      end
     else
      top20[steamid]={}
      top20[steamid].money=player_money[player]
      top20[steamid].name=name:gsub('%W','')
      top20_lowest=updatetop20lowest()
      while 15<top20_count do
       top20[top20_lowest]=nil
       top20_lowest=updatetop20lowest()
       top20_count=top20_count-1
      end
      savetop20()
     end
    end
end

local function check_timeout(index,diff)
    local timeouts=player_timeouts[source]
    if timeouts~=nil then
        local timeout=timeouts[index]
        if timeout~=nil and (GetGameTimer()-timeout)<diff then
            return false
        end
    end
    return true
end

local function set_timeout(index)
    if player_timeouts[source]==nil then
        player_timeouts[source]={}
    end
    player_timeouts[source][index]=GetGameTimer()
end

local function set_money_drop_wanted(drop,wanted)
     if drop.money<5000 then
      drop.wanted=0
     elseif drop.money<10000 then
      drop.wanted=math.min(wanted,1)
     elseif drop.money<25000 then
      drop.wanted=math.min(wanted,2)
     elseif drop.money<50000 then
      drop.wanted=math.min(wanted,3)
     elseif drop.money<100000 then
      drop.wanted=math.min(wanted,4)
     else
      drop.wanted=wanted
     end
end

function drop_money(player,pos,sprite,name)
  --TriggerClientEvent("chatMessage", -1, "Death", {128,128,0}, name)
  if (player_money[player]~=nil) and (player_money[player]>0) then
    --TriggerClientEvent("chatMessage", -1, "Fragile Alliance:", {128,128,0}, " dropped loot")
    local index=player
    while money_drops[index]~=nil do index=index+32 end
    local dropped_money=player_money[player]
    player_money[player]=0
    money_drops[index]={}
    --TriggerClientEvent(event.money, source, 0)
    money_drops[index].money=dropped_money
    money_drops[index].x=pos.x
    money_drops[index].y=pos.y
    if pos.z<-198.0 then
     money_drops[index].z=-198.0
    else
     money_drops[index].z=pos.z
    end
    money_drops[index].sprite=sprite
    money_drops[index].name=name
    if dropped_money<5000 then
     money_drops[index].singletake=500
    else
     money_drops[index].singletake=math.floor(dropped_money/10)
    end
    if player_wanted[player]==nil then
     money_drops[index].wanted=0
    else
     set_money_drop_wanted(money_drops[index],player_wanted[player])
    end
    money_drops[index].r=.5
    money_drops[index].bs=.5
    --coordinatearray[current_heist].singletake;
    TriggerClientEvent(event.startheist, -1, index, money_drops[index])
    update_factions(player_faction[player],-dropped_money)
    player_faction[player]=nil
  --else
    --TriggerClientEvent("chatMessage", -1, "Fragile Alliance:", {128,128,0}, "Type /heist to start mission.")
    --TriggerClientEvent("chatMessage", -1, "Fragile Alliance:", {128,128,0}, "Press Z to check your money.")
  end
end

AddEventHandler('playerConnecting', function(playerName, setKickReason) if server_stopped then return end
    local steamid=GetPlayerSteamID(source)
    if not steamid then
        setKickReason('bad steamid')
        CancelEvent()
    --else
        -- local player_data="f9a611ea11142c3/"..steamid..".dat"
        -- local file,err = io.open(player_data "r")
        -- if file then
         -- file:read()
         -- file:close()
         -- setKickReason('not too fast, you left while in combat')
        -- else
         -- print(err)
        -- end
    end
end)

local function save_player(src)
    if player_data[src]~=nil then
        local file,err = io.open(player_data[src], "w")
        if file then
         if player_money[src]~=nil then
          file:write(player_money[src])
         else
          file:write("0");
         end
         if player_wanted[src]~=nil then
          file:write("\n"..player_wanted[src])
         else
          file:write("\n0")
         end
         if player_garage[src]~=nil then
            for k,v in pairs(player_garage[src]) do
              file:write("\n"..k.."\n")
              file:write(v.hash.."\n")
              file:write(v.body.."\n")
              file:write(v.engine.."\n")
              file:write(v.tank.."\n")
              file:write(v.windows.."\n")
              file:write(v.tyresdoors.."\n")
              file:write(v.color1.."\n")
              file:write(v.color2.."\n")
              file:write(v.wanted)
            end
         end
         file:close()
         print("player "..src.." saved")
        else
         print(err)
        end
    else
        print("cant save player "..src.." data")
    end
end

local valid_property_names={
 ["stilt_2045nc"]={x=373.63525390625,y=423.69442749023,z=145.90788269043,cost=5000000,maxstash=10000000}, -- stilt
 ["stilt_2044nc"]={x=342.12084960938,y=437.84649658203,z=149.38078308105,cost=5000000,maxstash=10000000}, -- stilt
 ["stilt_3677wd"]={x=117.28005218506,y=560.03479003906,z=184.30487060547,cost=5000000,maxstash=10000000}, -- stilt
 ["stilt_3655wod"]={x=-174.20683288574,y=497.61782836914,z=137.66532897949,cost=5000000,maxstash=10000000}, -- stilt
 ["stilt_2217mr"]={x=-571.88372802734,y=661.82110595703,z=145.83985900879,cost=5000000,maxstash=10000000}, -- stilt
 ["stilt_2862ha"]={x=-682.48516845703,y=592.6767578125,z=145.37977600098,cost=5000000,maxstash=10000000}, -- stilt
 ["stilt_2868ha"]={x=-758.14813232422,y=618.96325683594,z=144.14060974121,cost=5000000,maxstash=10000000}, -- stilt
 ["stilt_2874ha"]={x=-859.95843505859,y=691.35089111328,z=152.86073303223,cost=5000000,maxstash=10000000}, -- stilt
 ["stilt_2113mwtd"]={x=-1289.7043457031,y=449.69128417969,z=97.902519226074,cost=5000000,maxstash=10000000}, -- stilt
 ["bomjatnya_1"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- very low end
 ["bomjatnya_2"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- very low end
 ["bomjatnya_3"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- very low end
 ["bomjatnya_4"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- very low end
 ["bomjatnya_paleto"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- paleto
 ["bomjatnya_sandy"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- sandy
 ["bomjatnya_chumash"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- very low end
 ["bomjatnya_harmony"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- very low end
 ["bomjatnya_senora_hotel"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- very low end
 ["bomjatnya_grapeseed"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- very low end
 ["bomjatnya_paletoforest"]={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,cost=10000,maxstash=100000}, -- very low end
 ["dno_1"]={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,cost=100000,maxstash=1000000}, -- low end
 ["dno_2"]={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,cost=100000,maxstash=1000000}, -- low end
 ["dno_3"]={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,cost=100000,maxstash=1000000}, -- low end
 ["dno_4"]={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,cost=100000,maxstash=1000000}, -- low end
 ["dno_banham"]={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,cost=100000,maxstash=1000000}, -- low end
 ["dno_chumash"]={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,cost=100000,maxstash=1000000}, -- low end
 ["dno_paleto"]={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,cost=100000,maxstash=1000000}, -- low end
 ["norm_1"]={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,cost=300000,maxstash=2000000}, -- mid end
 ["norm_2"]={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,cost=300000,maxstash=2000000}, -- mid end
 ["norm_3"]={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,cost=300000,maxstash=2000000}, -- mid end
 ["norm_4"]={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,cost=300000,maxstash=2000000}, -- mid end
 ["norm_banham"]={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,cost=300000,maxstash=2000000}, -- mid end
 ["altahotel"]={x=-269.96142578125,y=-941.06811523438,z=92.510902404785,cost=1000000,maxstash=4000000,unlocks={
  ["bodyarmor"]={cost=300000},
  ["bzgas"]={cost=325000},
  ["grenade"]={cost=380000},
  ["stickybomb"]={cost=500000},
  ["proxmine"]={cost=500000},
  ["pistol"]={cost=150000},
  ["combatpistol"]={cost=300000},
  ["heavypistol"]={cost=600000},
  ["appistol"]={cost=1500000},
  ["pistol50"]={cost=1500000},
  ["pistol_mk2"]={cost=1500000},
  ["heavyrevolver"]={cost=1000000},
  ["sawnoffshotgun"]={cost=320000},
  ["pumpshotgun"]={cost=350000},
  ["bullpupshotgun"]={cost=180000},
  ["heavyshotgun"]={cost=750000},
  ["assaultshotgun"]={cost=2000000},
  ["smg"]={cost=500000},
  ["assaultsmg"]={cost=900000},
  ["smg_mk2"]={cost=1300000},
  ["combatpdw"]={cost=1700000},
  ["assaultrifle"]={cost=600000},
  ["bullpuprifle"]={cost=800000},
  ["carbinerifle"]={cost=900000},
  ["specialcarbine"]={cost=1100000},
  ["carbinerifle_mk2"]={cost=1600000},
  ["advancedrifle"]={cost=1800000},
  ["assaultrifle_mk2"]={cost=2100000},
  ["mg"]={cost=1100000},
  ["combatmg"]={cost=1400000},
  ["combatmg_mk2"]={cost=2500000},
  ["sniperrifle"]={cost=1300000},
  ["marksmanrifle"]={cost=1800000},
  ["heavysniper"]={cost=2700000},
  ["heavysniper_mk2"]={cost=3500000},
  ["grenadelauncher"]={cost=4000000},
}},
}
local function save_property(filename,property_data)
    local file,err = io.open(filename,"w")
    file:write(property_data.money)
    for k,v in pairs(property_data.unlocks) do
        file:write("\n"..k)
    end
    file:close()
end

local wipe_at_logon=false --store active players only in RAM
local save_player_red
local save_property_red
--if wipe_at_logon then
 save_player_red=function(...) end
--else
-- save_player_red=save_player --redundand saves
--end
 save_property_red=function(...) end
-- save_property_red=save_property --redundand saves

local path_separator='/'
repeat
 local windir=os.getenv('WINDIR')
 if windir~=nil then
  print("i think we are on windows")
  path_separator='\\'
 end
 local home=os.getenv('HOME')
 if home~=nil then
  local sep=home:sub(1,1)
  if sep=='/' or sep=='\\' then path_separator=sep break end
 end
 local homepath=os.getenv('HOMEPATH')
 if homepath~=nil then 
  local sep=homepath:sub(1,1)
  if sep=='/' or sep=='\\' then path_separator=sep break end
 end
 print("error, can't find path separator")
until true
print("path separator is "..path_separator)

local function create_folder(path)
    local newpath
    if path_separator=='/' then
        newpath=path
    else
        newpath=path:gsub('/',path_separator)
    end
    local msg,ret=os.execute("mkdir "..newpath)
    if ret==0 then
        print("created folder "..newpath)
    else
        print(msg)
    end
end
for k,v in pairs(valid_property_names) do
    create_folder(properties_foldername..k)
end
local function save_all_properties(src)
    if player_properties[src]~=nil then
        local steamid=GetPlayerSteamID(src)
        for propertyname,property_data in pairs(player_properties[src]) do
            local filename=properties_foldername..propertyname.."/"..steamid..".txt"
            save_property(filename,property_data)
        end
    end
end
local function unlock_or_load_property(src,propertyname,steamid,dont_buy)
    if steamid==nil then
        print("error, steamid is nil",src)
        return properties_foldername..propertyname.."/error.txt"
    end
    local filename=properties_foldername..propertyname.."/"..steamid..".txt"
    if player_properties[src]==nil then
        player_properties[src]={}
    end
    if player_properties[src][propertyname] then
        return filename
    end
    local file,err = io.open(filename,"r")
    if file then
        local line=file:read()
        if line~=nil then
            player_properties[src][propertyname]={}
            player_properties[src][propertyname].money=math.tointeger(line)
            player_properties[src][propertyname].unlocks={}
            if valid_property_names[propertyname].unlocks then
                local i=0
                local temp_unlocks={}
                while true do
                    local line=file:read()
                    if not line then break end
                    i=i+1
                    player_properties[src][propertyname].unlocks[line]=true
                    temp_unlocks[i]=line
                end
                TriggerClientEvent(event.property_unlock,src,propertyname,temp_unlocks)
            end
            TriggerClientEvent(event.property_stash,src,propertyname,player_properties[src][propertyname].money)
            TriggerClientEvent(event.property_owned,src,propertyname)
        end
        file:close()
    elseif dont_buy==nil and player_money[src]~=nil and player_money[src]>=valid_property_names[propertyname].cost then
        player_money[src]=player_money[src]-valid_property_names[propertyname].cost
        player_properties[src][propertyname]={}
        player_properties[src][propertyname].money=0
        player_properties[src][propertyname].unlocks={}
        TriggerClientEvent(event.money,src,player_money[src])
        save_player_red(src)
        local file,err = io.open(filename,"w")
        file:write("0\n")
        file:close()
        TriggerClientEvent(event.property_owned,src,propertyname)
    end
    return filename
end
RegisterServerEvent(event.property_check)
AddEventHandler(event.property_check, function(propertyname) if server_stopped then return end
    local property=valid_property_names[propertyname]
    if property then
        unlock_or_load_property(source,propertyname,GetPlayerSteamID(source),true)
        if player_properties[source][propertyname] then
            TriggerClientEvent(event.property_owned,source,propertyname)
        end
    end
end)
RegisterServerEvent(event.property_enter)
AddEventHandler(event.property_enter, function(propertyname) if server_stopped then return end
    local property=valid_property_names[propertyname]
    if player_wanted[source]~=nil and player_wanted[source]==5 then
        TriggerClientEvent(event.notification,source,"You can't use this with 5 stars.")
    elseif property then
        unlock_or_load_property(source,propertyname,GetPlayerSteamID(source))
        if player_properties[source][propertyname] then
            TriggerClientEvent(event.teleport,source,property.x,property.y,property.z,propertyname)
        end
    end
end)
RegisterServerEvent(event.property_unlock)
AddEventHandler(event.property_unlock, function(propertyname,unlock) if server_stopped then return end
    local property=valid_property_names[propertyname]
    if player_wanted[source]~=nil and player_wanted[source]==5 then
        TriggerClientEvent(event.notification,source,"You can't use this with 5 stars.")
    elseif property and property.unlocks and property.unlocks[unlock] then
        local filename=unlock_or_load_property(source,propertyname,GetPlayerSteamID(source))
        if player_properties[source][propertyname]~=nil then
            if player_properties[source][propertyname].unlocks[unlock] then
                TriggerClientEvent(event.property_unlock,source,propertyname,{unlock})
                print(unlock.." was already unlocked in "..propertyname)
            elseif player_money[source]~=nil and player_money[source]>=property.unlocks[unlock].cost then
                player_money[source]=player_money[source]-property.unlocks[unlock].cost
                player_properties[source][propertyname].unlocks[unlock]=true
                TriggerClientEvent(event.property_unlock,source,propertyname,{unlock})
                print(unlock.." unlocked in "..propertyname)
                TriggerClientEvent(event.money,source,player_money[source])
                save_player_red(source)
                save_property_red(filename,player_properties[source][propertyname])
            end
        end
    end
end)
RegisterServerEvent(event.property_stash)
AddEventHandler(event.property_stash, function(propertyname,deposit) if server_stopped then return end
    deposit=math.tointeger(deposit)
    if player_wanted[source]~=nil and player_wanted[source]==5 then
        TriggerClientEvent(event.notification,source,"You can't use this with 5 stars.")
    elseif deposit==nil then
        print("deposit is nil or not a number")
    else
        local property=valid_property_names[propertyname]
        if property then
            local filename=unlock_or_load_property(source,propertyname,GetPlayerSteamID(source))
            if player_properties[source][propertyname] then
                if deposit>0 and player_money[source]~=nil and player_money[source]>0 then
                    if deposit>property.maxstash-player_properties[source][propertyname].money then
                        deposit=property.maxstash-player_properties[source][propertyname].money
                    end
                    if player_faction[source]~=nil and gang_economy[player_faction[source]][2]>0 then
                        local treshold=player_money[source]-gang_economy[player_faction[source]][2]
                        if deposit>treshold then
                            if treshold>0 then
                                deposit=treshold
                            else
                                deposit=0
                            end
                        end
                    elseif deposit>player_money[source] then
                        deposit=player_money[source]
                    end
                elseif deposit<0 and player_properties[source][propertyname].money>0 then
                    if deposit<-player_properties[source][propertyname].money then
                        deposit=-player_properties[source][propertyname].money
                    end
                else
                    return
                end
                if deposit~=0 then
                    if player_money[source]==nil then
                        player_money[source]=0
                    end
                    player_money[source]=player_money[source]-deposit
                    player_properties[source][propertyname].money=player_properties[source][propertyname].money+deposit
                    save_player_red(source)
                    save_property_red(filename,player_properties[source][propertyname])
                    TriggerClientEvent(event.money,source,player_money[source])
                    TriggerClientEvent(event.property_stash,source,propertyname,player_properties[source][propertyname].money)
                end
            end
        end
    end
end)

RegisterServerEvent(event.wanted)
AddEventHandler(event.wanted, function(wanted) if server_stopped then return end
    player_wanted[source]=math.tointeger(wanted)
    save_player_red(source)
end)

RegisterServerEvent(event.pos)
AddEventHandler(event.pos, function(x,y,z) if server_stopped then return end
    if x~=nil and y~=nil and z~=nil then
        player_pos[source]={x=x,y=y,z=z}
    end
end)

RegisterServerEvent(event.gang)
AddEventHandler(event.gang, function(gang) if server_stopped then return end
    gang=math.tointeger(gang)
    --print("gang="..gang)
    if gang==nil or gang_economy[gang]==nil then
        player_faction[source]=nil
    else
        player_faction[source]=gang
    end
end)

RegisterServerEvent(event.join_gang)
AddEventHandler(event.join_gang, function(gang) if server_stopped then return end
    gang=math.tointeger(gang)
    --print("gang="..gang)
    if gang==nil or gang_economy[gang]==nil then
        player_faction[source]=nil
    elseif gang_economy[gang][2]==0 or player_money[source]~=nil and player_money[source]>=gang_economy[gang][2] then
        player_faction[source]=gang
        TriggerClientEvent(event.join_gang,source,gang)
    else
        TriggerClientEvent(event.money,source,player_money[source])
    end
end)

RegisterServerEvent(event.gangwarscore)
AddEventHandler(event.gangwarscore, function() if server_stopped then return end
    TriggerClientEvent(event.gangwarscore,source,factions)
end)

RegisterServerEvent(event.abandoncar)
AddEventHandler(event.abandoncar, function(plate) if server_stopped then return end
    
end)

RegisterServerEvent(event.plates)
AddEventHandler(event.plates, function(p1,p2,p3,p4,p5,p6) if server_stopped then return end
    local steamid=GetPlayerSteamID(source)
    if steamid then
        if not player_plates[steamid] then
            player_plates[steamid]={}
        end
        player_plates[steamid][1]=p1
        player_plates[steamid][2]=p2
        player_plates[steamid][3]=p3
        player_plates[steamid][4]=p4
        player_plates[steamid][5]=p5
        player_plates[steamid][6]=p6
        -- local dbg=steamid.." plates ["
        -- if p1 then dbg=dbg..p1.."][" else dbg=dbg.."nil][" end
        -- if p2 then dbg=dbg..p2.."][" else dbg=dbg.."nil][" end
        -- if p3 then dbg=dbg..p3.."][" else dbg=dbg.."nil][" end
        -- if p4 then dbg=dbg..p4.."][" else dbg=dbg.."nil][" end
        -- if p5 then dbg=dbg..p5.."][" else dbg=dbg.."nil][" end
        -- if p6 then dbg=dbg..p6.."]" else dbg=dbg.."nil]" end
        -- print(dbg)
    end
end)

RegisterServerEvent(event.connected)
AddEventHandler(event.connected, function() if server_stopped then return end
    if player_data[source]==nil then
        local steamid=GetPlayerSteamID(source)
        if steamid then
            if check_for_multijoin(source,steamid) then return end
            print("attempting to load "..source)
            --player_steamid[source]=steamid --moved to GetPlayerSteamID
            player_data[source]=players_foldername..steamid..".dat"
            local file,err = io.open(player_data[source],"r")
            if file then
             local loaded_money=tonumber(file:read())
             if loaded_money then
              local garages=0
              local loaded_wanted=tonumber(file:read())
              if player_garage[source]==nil then player_garage[source]={} end
              while true do
               local garage_name=file:read()
               if garage_name==nil then break end
               local garage_index=tonumber(garage_name)
               local garage={}
               garage.hash=tonumber(file:read())
               garage.body=tonumber(file:read())
               garage.engine=tonumber(file:read())
               garage.tank=tonumber(file:read())
               garage.windows=tonumber(file:read())
               garage.tyresdoors=tonumber(file:read())
               garage.color1=tonumber(file:read())
               garage.color2=tonumber(file:read())
               garage.wanted=tonumber(file:read())
               player_garage[source][garage_index]=garage
               TriggerClientEvent(event.garage,source,garage_index,garage)
               garages=garages+1
              end
              print("loaded $"..loaded_money.." and "..garages.." garages")
              if loaded_money>0 then
               if player_money[source]~= nil then
                player_money[source]=player_money[source]+loaded_money
               else
                player_money[source]=loaded_money
               end
              end
              if player_money[source] then
               TriggerClientEvent(event.money,source,player_money[source])
              else
               TriggerClientEvent(event.money,source,0)
              end
              if loaded_wanted then
               TriggerClientEvent(event.wanted,source,loaded_wanted)
              end
              if wipe_at_logon then
               file:close()
               file,err=io.open(player_data[source], "w")
               file:write("0\n0")
              end
             else
              print("file was empty")
             end
             file:close()
            else
             TriggerClientEvent(event.money,source,0)
             print(err)
            end
            if player_plates[steamid] then
                TriggerClientEvent(event.plates,source,player_plates[steamid][1],player_plates[steamid][2],player_plates[steamid][3],player_plates[steamid][4],player_plates[steamid][5],player_plates[steamid][6])
            end
        else
            DropPlayer(source,'bad steamid')
        end
    else
        print("already loaded "..player_data[source])
    end
    -- if playerName:match("troll") then
        -- setKickReason('no trolls allowed')
        -- CancelEvent()
    -- end
end)

local function save_player_clothes(src)
    local clothes=player_clothes[src]
    if clothes~=nil and clothes.changed then
        local filename=clothes_foldername..player_steamid[src]..".txt"
        local file,err = io.open(filename, "w")
        if file then
            file:write(clothes.model.."\n")
            for i=1,12 do -- 0,11 +1
                file:write(clothes.components[i]..'\n')
            end
            for i=1,12 do -- 0,11 +1
                file:write(clothes.textures[i]..'\n')
            end
            for i=1,4 do -- 0,3 +1
                file:write(clothes.props[i]..'\n')
            end
            for i=1,4 do -- 0,3 +1
                file:write(clothes.prop_textures[i]..'\n')
            end
            file:close()
            TriggerClientEvent(event.notification,src,"Clothes ~g~saved~s~.")
        else
            TriggerClientEvent(event.notification,src,"Clothes ~r~not saved~s~. ~r~Contact server administrator!")
        end
    end
end

local function save_dropped_player(src)
    save_player(src)
    save_all_properties(src)
    save_player_clothes(src)
    player_properties[src]=nil
    player_clothes[src]=nil
    player_garage[src]=nil
    player_money[src]=nil
    player_pos[src]=nil
    player_wanted[src]=nil
    player_faction[src]=nil
    player_missions[src]=nil
    player_timeouts[src]=nil
    player_punished[src]=nil
    
    player_data[src]=nil
end

check_for_multijoin=function(src,steam)
    local getplayers=GetPlayers()
    local multijoin=false
    for k,v in pairs(getplayers) do
        online[math.tointeger(v)]=true
    end
    --for k,v in pairs(player_steamid) do
    --    if steam==v and k~=src and not online[k] and player_data[k] then
    --        save_dropped_player(k)
    --    end
    --end
    for k,v in pairs(player_data) do
        if not online[k] then
            TriggerClientEvent(event.notification,-1,"~r~Critical error!~s~ Player "..k.." was dropped without playerDropped event!")
            print("player "..k.." was dropped without playerDropped event")
            save_dropped_player(k)
        end
    end
    for k,v in pairs(online) do
        if k~=src and GetPlayerSteamID(k)==steam then
            multijoin=true
            DropPlayer(k,"critical network error")
        end
    end
    if multijoin then
        DropPlayer(src,"network error")
    end
    return multijoin
end

AddEventHandler('playerDropped', function()
    --RconLog({ msgType = 'playerDropped', netID = source, name = GetPlayerName(source) })
    print("attempting to save "..source)
   if not server_stopped then
    if player_money[source]~=nil and player_pos[source]~=nil then
     if player_wanted[source]~=nil and player_wanted[source]>0 then
      local msg
      if player_wanted[source]==1 then
       msg="Player left with 1 star"
      else
       msg="Player left with "..player_wanted[source].." stars"
      end
      drop_money(source,player_pos[source],303,msg)
     elseif player_punished[source]~=nil and player_punished[source]>os.time() then
      drop_money(source,player_pos[source],303,"Player left while punished")
     end
    end
   end
   save_dropped_player(source)
end)

RegisterServerEvent(event.punishment)
AddEventHandler(event.punishment, function(seconds,x,y,z) if server_stopped then return end
    seconds=math.tointeger(seconds)
    x=tonumber(x)
    y=tonumber(y)
    z=tonumber(z)
    player_pos[source]={x=x,y=y,z=z}
    if seconds~=nil then
        local release=os.time()+seconds
        if player_punished[source]==nil or player_punished[source]<release then
            player_punished[source]=release
            --print("player "..source.." punished for "..seconds)
        end
    end
end)

RegisterServerEvent(event.take_car)
AddEventHandler(event.take_car, function(k) if server_stopped then return end
    if player_garage[source]~=nil then
        player_garage[source][k]=nil
        save_player_red(source)
    end
end)

RegisterServerEvent(event.save_car)
AddEventHandler(event.save_car, function(k,car) if server_stopped then return end
    if player_garage[source]==nil then player_garage[source]={} end
    player_garage[source][k]=car
    save_player_red(source)
end)

-- function deepcopy(orig)
    -- local orig_type = type(orig)
    -- local copy
    -- if orig_type == 'table' then
        -- copy = {}
        -- for orig_key, orig_value in next, orig, nil do
            -- copy[deepcopy(orig_key)] = deepcopy(orig_value)
        -- end
        -- setmetatable(copy, deepcopy(getmetatable(orig)))
    -- else -- number, string, boolean, etc
        -- copy = orig
    -- end
    -- return copy
-- end

local coordinatearray={
   {x=-119.616,y=-1576.976,z=34.1848,sprite=496,name="Steal weed",wanted=1,money=2500,singletake=500,enemies=6,skins={1064866854,1001210244,1768677545},weapons={WEAPON.MICROSMG,WEAPON.MACHINEPISTOL}},
   {x=-334.763,y=-1317.364,z=31.4004,sprite=496,name="Steal weed",wanted=2,money=9000,singletake=300,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.COMPACTRIFLE,WEAPON.DBSHOTGUN,WEAPON.MINISMG}},
   {x=271.251,y=-1737.183,z=35.2965,sprite=408,name="Steal jewelry",wanted=4,money=25000,singletake=1000,enemies=1,skins={-422822692},weapons={WEAPON.SPECIALCARBINE}},
    {x=-129.715,y=-1421.568,z=31.3002,sprite=498,name="Steal documents",wanted=3,money=15000,singletake=500,enemies=5,skins={-1538846349},weapons={WEAPON.KNIFE,WEAPON.SMG,WEAPON.CARBINERIFLE,WEAPON.COMBATPISTOL,WEAPON.ASSAULTSMG}},
    {x=866.311,y=-964.121,z=26.2829,sprite=440,name="Steal meth",wanted=3,money=15000,singletake=500,enemies=6,skins={-712602007,377976310,-294281201,411102470},weapons={WEAPON.SWITCHBLADE,WEAPON.SNSPISTOL,WEAPON.SAWNOFFSHOTGUN,WEAPON.COMBATPISTOL}},
    {x=2.485,y=-1309.374,z=30.1653,sprite=496,name="Steal weed",wanted=2,money=20000,singletake=500,enemies=6,skins={1064866854,1001210244,1768677545},weapons={WEAPON.CROWBAR,WEAPON.MICROSMG,WEAPON.HEAVYPISTOL,WEAPON.BULLPUPSHOTGUN}},
    {x=291.864,y=-990.509,z=36.6019,sprite=500,name="Steal money",wanted=1,money=20000,singletake=500,enemies=5,skins={648372919,666086773},weapons={WEAPON.NIGHTSTICK,WEAPON.SNIPERRIFLE,WEAPON.HEAVYPISTOL,WEAPON.BULLPUPRIFLE}},
    {x=117.887,y=-238.717,z=53.3560,sprite=500,name="Steal money",wanted=2,money=22500,singletake=500,enemies=8,skins={-46035440,1226102803,-664900312,-927525251,768005095},weapons={WEAPON.HAMMER,WEAPON.PISTOL50,WEAPON.PISTOL,WEAPON.COMBATPISTOL}},
    {x=-190.3955078125,y=-1183.1065673828,z=23.030401229858,sprite=498,name="Steal information",wanted=3,money=13500,singletake=500,enemies=8,skins={-322270187,-2088436577,1936142927,-709209345,-2076336881},weapons={WEAPON.DAGGER,WEAPON.SNSPISTOL,WEAPON.PISTOL,WEAPON.REVOLVER,WEAPON.COMBATPISTOL}},
    {x=-29.127,y=162.592,z=94.9908,sprite=498,name="Steal information",wanted=4,money=5000,singletake=2500,enemies=2,skins={1064866854,1001210244,1768677545,874722259},weapons={WEAPON.COMBATPISTOL,WEAPON.REVOLVER}},
    {x=-158.659,y=-156.255,z=43.6212,sprite=500,name="Steal money",wanted=3,money=25000,singletake=500,enemies=6,skins={-1613485779,-520477356,988062523,1189322339},weapons={WEAPON.HEAVYPISTOL,WEAPON.PISTOL50,WEAPON.PUMPSHOTGUN,WEAPON.MICROSMG,WEAPON.PISTOL,WEAPON.SMG}},
    {x=-391.218,y=-146.258,z=38.5322,sprite=501,name="Steal heroin",wanted=3,money=25000,singletake=1000,enemies=6,skins={1520708641,-995747907,-100858228},weapons={WEAPON.BAT,WEAPON.MINISMG,WEAPON.AUTOSHOTGUN,WEAPON.ASSAULTRIFLE}},
    {x=-970.061,y=104.434,z=55.6658,sprite=501,name="Steal heroin",wanted=3,money=40000,singletake=1000,enemies=6,skins={1626646295,1794381917,193817059,1750583735},weapons={WEAPON.MG,WEAPON.CARBINERIFLE,WEAPON.MACHETE,WEAPON.ADVANCEDRIFLE}},
    {x=1663.5278320313,y=-27.433429718018,z=173.77473449707,sprite=500,name="Steal money",wanted=1,money=15000,singletake=500,enemies=4,skins={-1613485779,-520477356,988062523,1189322339},weapons={WEAPON.HEAVYPISTOL,WEAPON.PISTOL50,WEAPON.PUMPSHOTGUN,WEAPON.MICROSMG,WEAPON.PISTOL,WEAPON.SMG}},
    {x=2755.1301269531,y=1578.1528320313,z=50.686878204346,sprite=499,name="Steal chemicals",wanted=3,money=18000,singletake=600,enemies=3,skins={-1395868234,-907676309},weapons={WEAPON.REVOLVER,WEAPON.MICROSMG}},
    {x=46.64128112793,y=-1036.7197265625,z=37.18327331543,sprite=498,name="Steal information",wanted=2,money=13000,singletake=1300,enemies=1,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL50}},
    {x=-139.0888671875,y=-1283.7889404297,z=47.898109436035,sprite=498,name="Steal information",wanted=3,money=18000,singletake=500,enemies=10,skins={-277325206,-1047300121,-1427838341},weapons={WEAPON.PISTOL,WEAPON.MACHINEPISTOL,WEAPON.SAWNOFFSHOTGUN}},
    {x=477.71426391602,y=-890.33056640625,z=35.972190856934,sprite=496,name="Steal weed",wanted=2,money=13000,singletake=500,enemies=7,skins={-277325206,-1047300121,-1427838341},weapons={WEAPON.PISTOL,WEAPON.MACHINEPISTOL,WEAPON.SAWNOFFSHOTGUN}},
    {x=-94.882675170898,y=-68.186668395996,z=56.638584136963,sprite=496,name="Steal weed",wanted=2,money=13000,singletake=500,enemies=7,skins={-277325206,-1047300121,-1427838341},weapons={WEAPON.PISTOL,WEAPON.MACHINEPISTOL,WEAPON.SAWNOFFSHOTGUN}},
    {x=3537.7434082031,y=3665.2736816406,z=28.121868133545,sprite=521,name="Steal data",wanted=5,money=400000,singletake=4000,enemies=7,skins={1092080539,788443093,2120901815,-912318012,-1589423867,-1211756494,-1366884940},weapons={WEAPON.PISTOL,WEAPON.COMBATPISTOL,WEAPON.HEAVYPISTOL,WEAPON.SNSPISTOL,WEAPON.PISTOL50,WEAPON.COMBATPDW,WEAPON.PISTOL,WEAPON.COMBATPISTOL,WEAPON.HEAVYPISTOL,WEAPON.SNSPISTOL,WEAPON.PISTOL50,WEAPON.COMBATPDW,WEAPON.RAILGUN}},
    {x=2673.5876464844,y=3286.1796875,z=55.241138458252,sprite=500,name="Steal money",wanted=2,money=5000,singletake=500,enemies=1,skins={666086773},weapons={WEAPON.HEAVYPISTOL}},
    {x=1392.9525146484,y=3602.6538085938,z=38.941883087158,sprite=499,name="Steal chemicals",wanted=3,money=25000,singletake=500,enemies=1,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}},
    {x=1595.3160400391,y=3586.9951171875,z=38.766494750977,sprite=501,name="Steal heroin",wanted=3,money=50000,singletake=500,enemies=11,skins={1064866854,1001210244,1768677545},weapons={WEAPON.ASSAULTRIFLE,WEAPON.MACHINEPISTOL,WEAPON.PISTOL}},
    {x=263.72430419922,y=214.30860900879,z=101.6834564209,sprite=500,name="Steal money",wanted=5,money=600000,singletake=6000,enemies=4,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.SMG,WEAPON.PUMPSHOTGUN,WEAPON.CARBINERIFLE}},
    {x=-352.12054443359,y=-59.182289123535,z=49.014862060547,sprite=500,name="Steal money",wanted=4,money=70000,singletake=700,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}}, --fleeca city NORTH
    {x=-1206.7475585938,y=-337.98840332031,z=37.759311676025,sprite=500,name="Steal money",wanted=4,money=80000,singletake=800,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}}, --fleeca city west
    {x=312.95599365234,y=-288.32565307617,z=54.14306640625,sprite=500,name="Steal money",wanted=4,money=130000,singletake=650,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}}, --fleeca city
    {x=-2953.3364257813,y=484.60232543945,z=15.675382614136,sprite=500,name="Steal money",wanted=4,money=140000,singletake=700,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}}, --fleeca highway
    {x=1173.0432128906,y=2715.95703125,z=38.066314697266,sprite=500,name="Steal money",wanted=4,money=140000,singletake=700,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}}, --fleeca desert
    {x=-103.9347076416,y=6477.5419921875,z=31.626724243164,sprite=500,name="Steal money",wanted=4,money=90000,singletake=900,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}}, --blane country savings
    {x=148.57748413086,y=-1049.9956054688,z=29.346368789673,sprite=500,name="Steal money",wanted=4,money=140000,singletake=700,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}}, --fleeca city near aps
    {x=440.03012084961,y=-991.51953125,z=30.689594268799,sprite=498,name="Steal information",wanted=4,money=100000,singletake=1000,enemies=3,skins={368603149,1581098148,1939545845},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}},
    {x=-635.13677978516,y=-1728.6335449219,z=24.190845489502,sprite=501,name="Steal heroin",wanted=3,money=50000,singletake=500,enemies=11,skins={1064866854,1001210244,1768677545},weapons={WEAPON.ASSAULTRIFLE,WEAPON.MACHINEPISTOL,WEAPON.PISTOL}},
    {x=29.880146026611,y=-98.098907470703,z=56.020793914795,sprite=500,name="Steal money",wanted=2,money=22500,singletake=500,enemies=8,skins={-46035440,1226102803,-664900312,-927525251,768005095},weapons={WEAPON.HAMMER,WEAPON.PISTOL50,WEAPON.PISTOL,WEAPON.COMBATPISTOL}},
    {x=9.2347011566162,y=-1102.7471923828,z=29.797012329102,sprite=478,name="Steal weapons",wanted=2,money=17500,singletake=500,enemies=3,skins={-46035440,1226102803,-664900312,-927525251,768005095},weapons={WEAPON.MACHETE,WEAPON.PISTOL50,WEAPON.ASSAULTSHOTGUN,WEAPON.AUTOSHOTGUN}},
   {x=-154.88626098633,y=6140.0922851563,z=32.335090637207,sprite=408,name="Steal jewelry",wanted=3,money=100000,singletake=1000,enemies=4,skins={-712602007,377976310,-294281201,411102470},weapons={WEAPON.MACHINEPISTOL,WEAPON.COMBATPISTOL,WEAPON.MACHETE}},
   {x=-622.14739990234,y=-230.87982177734,z=38.057033538818,sprite=408,name="Steal jewelry",wanted=4,money=150000,singletake=1500,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}},
    {x=706.89807128906,y=-966.12646484375,z=30.412851333618,sprite=498,name="Steal information",wanted=3,money=50000,singletake=500,enemies=3,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --lester warhouse
    {x=-1050.1361083984,y=-240.94955444336,z=44.021053314209,sprite=521,name="Steal data",wanted=4,money=70000,singletake=500,enemies=2,skins={-681004504},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}},
    {x=-226.19862365723,y=-2000.8435058594,z=24.685342788696,sprite=521,name="Steal servers",wanted=4,money=20000,singletake=500,enemies=2,skins={-681004504},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}},
    {x=-5.8843197822571,y=-676.626953125,z=16.130626678467,sprite=500,name="Steal money",wanted=5,money=1000000,singletake=10000,enemies=2,skins={-681004504},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}},
    {x=2440.4934082031,y=4977.3095703125,z=46.810592651367,sprite=501,name="Steal heroin",wanted=2,money=130000,singletake=1300,enemies=15,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --o neil
    {x=2435.2084960938,y=4967.380859375,z=42.347560882568,sprite=501,name="Steal heroin",wanted=2,money=250000,singletake=2500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --o neil
    {x=-580.12377929688,y=-1627.791015625,z=33.074031829834,sprite=501,name="Steal heroin",wanted=2,money=50000,singletake=500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --rogers FACTORY
    {x=-607.42205810547,y=-1631.2557373047,z=33.010551452637,sprite=501,name="Steal heroin",wanted=2,money=50000,singletake=500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --FACTORY
    {x=-616.59869384766,y=-1623.3514404297,z=33.010581970215,sprite=498,name="Steal information",wanted=2,money=20000,singletake=500,enemies=1,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL50}}, --rogers FACTORY
    {x=952.03198242188,y=-2124.2270507813,z=31.446039199829,sprite=501,name="Steal heroin",wanted=2,money=20000,singletake=500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --FACTORY
    {x=244.09912109375,y=366.92520141602,z=105.73815155029,sprite=498,name="Steal information",wanted=2,money=20000,singletake=500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --epsilon storage
    {x=-1562.9124755859,y=-3236.3403320313,z=26.336172103882,sprite=501,name="Steal heroin",wanted=2,money=25000,singletake=500,enemies=3,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --airport
    {x=-56.118892669678,y=-2521.0046386719,z=7.4011745452881,sprite=498,name="Steal information",wanted=2,money=30000,singletake=500,enemies=6,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --docks
    {x=-1219.9185791016,y=-916.04528808594,z=11.326193809509,sprite=500,name="Steal money",wanted=2,money=18000,singletake=500,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.COMPACTRIFLE,WEAPON.DBSHOTGUN,WEAPON.MINISMG}}, -- shop 
    {x=-143.81394958496,y=-969.58282470703,z=115.23302459717,sprite=514,name="Steal coke",wanted=5,money=1200000,singletake=5000,enemies=6,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- building skyscrapper
    {x=-460.30767822266,y=2052.3601074219,z=122.27303314209,sprite=269,name="Steal gold",wanted=5,money=2000000,singletake=5000,enemies=3,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- mine
    {x=3063.2666015625,y=2217.435546875,z=3.1399157047272,sprite=269,name="Steal gold",wanted=5,money=1000000,singletake=5000,enemies=4,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- hollow cave
    {x=-2243.9621582031,y=261.2451171875,z=174.61312866211,sprite=269,name="Steal gold",wanted=4,money=600000,singletake=3000,enemies=4,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- low rotunda
    {x=-3110.0463867188,y=374.52053833008,z=11.992931365967,sprite=500,name="Steal money",wanted=3,money=200000,singletake=1000,enemies=6,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --balcony near beard party
    {x=-2949.3349609375,y=57.456722259521,z=11.608504295349,sprite=500,name="Steal money",wanted=3,money=80000,singletake=400,enemies=2,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, --tennis near banhan
    {x=-3005.9196777344,y=752.03131103516,z=31.59236907959,sprite=500,name="Steal money",wanted=3,money=60000,singletake=600,enemies=3,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --banhan balcony requires car
    {x=-3106.9052734375,y=754.09301757813,z=28.762506484985,sprite=500,name="Steal money",wanted=3,money=80000,singletake=400,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --banhan near small bridge across road
     {x=-3239.4709472656,y=915.99774169922,z=17.456972885132,sprite=514,name="Steal coke",wanted=3,money=140000,singletake=1000,enemies=0,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- chumash double balcony
     {x=-3245.3576660156,y=945.45715332031,z=20.786796569824,sprite=514,name="Steal coke",wanted=3,money=140000,singletake=1000,enemies=0,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- chumash roof near double balcony
    {x=-3265.1586914063,y=1054.8557128906,z=11.214871406555,sprite=500,name="Steal money",wanted=3,money=180000,singletake=1000,enemies=0,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- chumash flamingo balcony 
     {x=-2004.2524414063,y=545.20861816406,z=115.50409698486,sprite=500,name="Steal money",wanted=3,money=60000,singletake=600,enemies=2,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- rusty thing on north
     {x=-1522.1928710938,y=844.83685302734,z=186.12351989746,sprite=500,name="Steal money",wanted=3,money=80000,singletake=800,enemies=2,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- richman glen
     {x=-436.35620117188,y=1112.8083496094,z=332.54086303711,sprite=500,name="Steal money",wanted=3,money=150000,singletake=1000,enemies=2,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- observatory
     {x=-99.379180908203,y=986.81237792969,z=240.94128417969,sprite=500,name="Steal money",wanted=3,money=135000,singletake=1000,enemies=3,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- near super cars
     {x=696.080078125,y=592.42852783203,z=137.29547119141,sprite=521,name="Steal data",wanted=2,money=60000,singletake=600,enemies=3,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- scena
     {x=1049.2613525391,y=184.57731628418,z=84.991065979004,sprite=500,name="Steal money",wanted=3,money=120000,singletake=1000,enemies=5,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- near casino
    {x=1734.1779785156,y=-1646.9752197266,z=112.59952545166,sprite=499,name="Steal chemicals",wanted=3,money=50000,singletake=500,enemies=1,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --near racing vehicles
     {x=2549.9482421875,y=385.48822021484,z=108.62294006348,sprite=514,name="Steal coke",wanted=3,money=80000,singletake=800,enemies=0,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- gas station near swat
    {x=2369.0187988281,y=2188.1723632813,z=140.41632080078,sprite=269,name="Steal gold",wanted=3,money=100000,singletake=1000,enemies=0,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- windmill
    {x=2357.5417480469,y=2594.9838867188,z=47.11251449585,sprite=501,name="Steal heroin",wanted=2,money=20000,singletake=500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --north of windmill hippy
     {x=2107.1267089844,y=2923.984375,z=57.427074432373,sprite=521,name="Steal data",wanted=2,money=60000,singletake=600,enemies=3,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- radars
    {x=1563.0794677734,y=2182.4057617188,z=78.900382995605,sprite=501,name="Steal heroin",wanted=2,money=25000,singletake=500,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --redneck farm
    {x=1221.7388916016,y=1899.0299072266,z=77.918098449707,sprite=499,name="Steal chemicals",wanted=3,money=35000,singletake=500,enemies=1,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --near redneck farm
    {x=-50.055248260498,y=1892.0738525391,z=195.36177062988,sprite=499,name="Steal chemicals",wanted=3,money=50000,singletake=500,enemies=4,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --grand senoray checkens
    {x=201.29138183594,y=2435.0185546875,z=60.463306427002,sprite=501,name="Steal heroin",wanted=3,money=40000,singletake=500,enemies=4,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --auto repair
    {x=-126.44757843018,y=2791.0014648438,z=53.107711791992,sprite=499,name="Steal chemicals",wanted=1,money=20000,singletake=500,enemies=4,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --ambar near glitched grave
     {x=263.95520019531,y=2590.8186035156,z=44.927703857422,sprite=500,name="Steal money",wanted=3,money=30000,singletake=600,enemies=1,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- left of prison between houses
     {x=950.64001464844,y=2410.283203125,z=77.886276245117,sprite=500,name="Steal money",wanted=3,money=30000,singletake=600,enemies=1,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- STROY KRAN
     {x=272.49133300781,y=2864.0903320313,z=64.928047180176,sprite=514,name="Steal coke",wanted=3,money=60000,singletake=600,enemies=2,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- cement pererabotka
    {x=157.23419189453,y=3130.5590820313,z=43.584102630615,sprite=501,name="Steal heroin",wanted=3,money=80000,singletake=500,enemies=4,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --burned house
    {x=435.80679321289,y=2997.3715820313,z=41.282833099365,sprite=499,name="Steal chemicals",wanted=3,money=20000,singletake=500,enemies=4,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --grand senora house s paketom sverhu
    {x=2353.2414550781,y=3116.8088378906,z=48.208744049072,sprite=499,name="Steal chemicals",wanted=3,money=60000,singletake=600,enemies=4,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --airfield scrapyard
     {x=2634.0900878906,y=2933.5512695313,z=44.738983154297,sprite=514,name="Steal coke",wanted=3,money=60000,singletake=600,enemies=2,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- railway switch near quarry
    {x=2870.7202148438,y=4379.6962890625,z=72.189208984375,sprite=499,name="Steal chemicals",wanted=1,money=60000,singletake=600,enemies=0,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --union grain supply
    {x=2939.1721191406,y=4621.0361328125,z=48.721004486084,sprite=499,name="Steal chemicals",wanted=3,money=60000,singletake=600,enemies=1,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --railway to weird house black oil
     {x=1346.4468994141,y=4385.4184570313,z=45.095581054688,sprite=500,name="Steal money",wanted=1,money=90000,singletake=600,enemies=0,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- boatshop galili
    {x=713.11212158203,y=4101.4331054688,z=35.785186767578,sprite=501,name="Steal heroin",wanted=3,money=40000,singletake=400,enemies=4,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --alamo sea pierce
     {x=1547.7338867188,y=6334.0346679688,z=25.070280075073,sprite=514,name="Steal coke",wanted=3,money=60000,singletake=600,enemies=2,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- communism
    {x=-68.881858825684,y=6221.5678710938,z=47.304481506348,sprite=499,name="Steal chemicals",wanted=3,money=60000,singletake=600,enemies=1,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --chicken fabric above
     {x=-172.55706787109,y=6143.7612304688,z=43.806774139404,sprite=514,name="Steal coke",wanted=3,money=80000,singletake=800,enemies=2,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- chicken factory coke
     {x=-381.6823425293,y=6087.5473632813,z=39.614902496338,sprite=500,name="Steal money",wanted=3,money=30000,singletake=600,enemies=0,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- paleto firefighters tower
     {x=-542.66296386719,y=5327.869140625,z=77.054061889648,sprite=514,name="Steal coke",wanted=2,money=50000,singletake=500,enemies=0,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- sawmill
     {x=-2166.3630371094,y=5197.0532226563,z=16.880392074585,sprite=521,name="Steal data",wanted=4,money=120000,singletake=1200,enemies=3,skins={-1395868234,-907676309},weapons={WEAPON.HEAVYPISTOL,WEAPON.COMBATPISTOL}}, -- Avi
};
--for i = 1, 10 do
--   MsgBox ("i равно "..i)
--end

--AddEventHandler('playerConnecting', function(playerName, setKickReason)
    --RconLog({ msgType = 'customConnect', ip = GetPlayerEP(source), name = playerName })
    --player_money[source]=0
--end)

local function startheist(player)
    if heists_running<5 then
        if heists_running==0 then
            math.randomseed(os.time())
        end
        current_heist=math.random(#coordinatearray)
        if money_drops[-current_heist]==nil then
            heists_running=heists_running+1
            money_drops[-current_heist]={}
            money_drops[-current_heist].x=coordinatearray[current_heist].x
            money_drops[-current_heist].y=coordinatearray[current_heist].y
            money_drops[-current_heist].z=coordinatearray[current_heist].z
            money_drops[-current_heist].sprite=coordinatearray[current_heist].sprite
            money_drops[-current_heist].name=coordinatearray[current_heist].name
            money_drops[-current_heist].money=coordinatearray[current_heist].money
            money_drops[-current_heist].singletake=coordinatearray[current_heist].singletake
            money_drops[-current_heist].wanted=coordinatearray[current_heist].wanted
            money_drops[-current_heist].r=2.75
            money_drops[-current_heist].bs=1.5
            TriggerClientEvent(event.spawnpeds,player,money_drops[-current_heist].x,money_drops[-current_heist].y,money_drops[-current_heist].z,coordinatearray[current_heist].enemies,coordinatearray[current_heist].skins,coordinatearray[current_heist].weapons)
        end
    end
    for key, val in pairs(money_drops) do
        TriggerClientEvent(event.startheist, -1, key, val)
    end
end

RegisterServerEvent(event.startheist)
AddEventHandler(event.startheist, function() if server_stopped then return end
    startheist(source)
end)

AddEventHandler('chatMessage', function(player, playerName, message)
    if source~='' then
        player=source
    end
    if message:sub(1, 6) == '/heist' then
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Use your phone to start a heist.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "The more reddish heist color is, the harder it is.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Get a team to complete harder heists.")
        --startheist(player)
    elseif message:sub(1, 6) == '/money' then
         --player_money[player]=tonumber(message:sub(7))
         --TriggerClientEvent(event.money, player, player_money[player])
        if player_money[player] then
         TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "$"..player_money[player])
        else
         TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "You don't have money.")
        end
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Use your money to buy gear and cars.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "When you die - you loose all of your money, and other players")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "can pick it up, just like you; search for green and white skull blips.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "You can hide money with ^3F1 ^0button and pick it back with ^3F2 ^0button.")
    elseif message:sub(1, 5) == '/help' or message:sub(1, 9) == '/commands' or message:sub(1, 4) == '/cmd' then
        TriggerClientEvent(event.help,player)
        -- TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "^5/cops ^7 Info about cops.")
        -- TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "^5/cars ^7 Info about cars.")
        -- TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "^5/money ^7 Info about money.")
        -- TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "^5/discord ^7 Discord link.")
        -- TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "^5/missions ^7 Missions info.")
        -- TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "^5/rules ^7 Server rules.")
    elseif message:sub(1, 8) == '/discord' then
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "discord.gg/VZG5Nvk")
    -- elseif message:sub(1, 7) == '/facwar' then
        -- TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "~r~Test ")
    elseif message:sub(1, 5) == '/cops' then
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Cops are always searching for stolen cars.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "You can loose 1 or 2 wanted level by changing clothes.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "If you have 5 wanted level, you need to leave Los-Santos")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "by plane or boat.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Press H to surrender to FIB player.")
    elseif message:sub(1, 5) == '/cars' then
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "If you're driving stolen car - you'll get wanted level.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Different cars will give you different wanted levels.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Buy your own car or cops will always chase you.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "If your car is dead - you can't fix it, it's gone.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Place your can in ^1garage ^7before leaving server to ^5save it^7.")
    elseif message:sub(1, 9) == '/missions' then
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Once heist is started - you'll get big green icon.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Go there and stay in green circle to get money.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "Watch out for other players, because they can easily kill you.")
    elseif message:sub(1, 6) == '/rules' then
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "1) Don't use cheats.")
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "2) There are no other rules and you are free do to whatever you want.")
    elseif message:sub(1, 4) == '/top' then
        TriggerClientEvent(event.top,player,top20)
    elseif message:sub(1, 4) == '/ooc' then
        TriggerClientEvent("chatMessage", player, "Help", {0,150,255}, "This is not RP server, no rules here.")
    end
end)

local stash_unit=5000

RegisterServerEvent(event.stash_hide)
AddEventHandler(event.stash_hide, function(x,y,z) if server_stopped then return end
 x=math.tointeger(x)
 y=math.tointeger(y)
 z=math.tointeger(z)
 if x==nil or y==nil or z==nil then
  print("stash_hide: incorrect coords\n")
 elseif z<-90 or (math.abs(x+277.69100952148)+math.abs(y+952.26770019531)<40 and z>85 and z<95) then
  TriggerClientEvent(event.notification,source,"You can't hide money here, try something else.")
 elseif check_timeout(1,900) and player_money[source]~=nil and (player_wanted[source]==nil or player_wanted[source]==0)
 and player_money[source]>=stash_unit and (player_faction[source]==nil or gang_economy[player_faction[source]][2]==0 or player_money[source]-gang_economy[player_faction[source]][2]>=stash_unit) then
  local filename=geocaching_foldername..x.."_"..y.."_"..z..".dat"
  local file,err = io.open(filename, "r")
  if file then
   local loaded_money=math.tointeger(file:read())
   file:close()
   if loaded_money then
    loaded_money=loaded_money+stash_unit
    file,err = io.open(filename, "w")
    if file then
     file:write(loaded_money)
     file:close()
     player_money[source]=player_money[source]-stash_unit
     TriggerClientEvent(event.money,source,player_money[source])
     set_timeout(1)
     save_player_red(source)
    end
   else
    file,err = io.open(filename, "w")
    if file then
     file:write(stash_unit)
     file:close()
     player_money[source]=player_money[source]-stash_unit
     TriggerClientEvent(event.money,source,player_money[source])
     set_timeout(1)
     save_player_red(source)
    end
   end
  else
   file,err = io.open(filename, "w")
   if file then
    file:write(stash_unit)
    file:close()
    player_money[source]=player_money[source]-stash_unit
    TriggerClientEvent(event.money,source,player_money[source])
    set_timeout(1)
    save_player_red(source)
   end
  end
 else
  TriggerClientEvent(event.notification,source,"You need at least $"..stash_unit.." and zero stars to create money stash.")
 end
end)

RegisterServerEvent(event.stash_take)
AddEventHandler(event.stash_take, function(x,y,z) if server_stopped then return end
 x=math.tointeger(x)
 y=math.tointeger(y)
 z=math.tointeger(z)
 if check_timeout(1,900) and x~=nil and y~=nil and z~=nil then
  local filename=geocaching_foldername..x.."_"..y.."_"..z..".dat"
  local file,err = io.open(filename, "r")
  if file then
   local loaded_money=math.tointeger(file:read())
   file:close()
   if loaded_money and loaded_money>=stash_unit then
    loaded_money=loaded_money-stash_unit
    file,err = io.open(filename, "w")
    if file then
     file:write(loaded_money)
     file:close()
     if player_money[source] then
      player_money[source]=player_money[source]+stash_unit
     else
      player_money[source]=stash_unit
     end
     TriggerClientEvent(event.money,source,player_money[source])
     set_timeout(1)
     save_player_red(source)
    end
   elseif loaded_money==nil or loaded_money==0 then
    os.remove(filename)
   elseif loaded_money<stash_unit then
    if player_money[source] then
     player_money[source]=player_money[source]+loaded_money
    else
     player_money[source]=loaded_money
    end
    TriggerClientEvent(event.money,source,player_money[source])
    set_timeout(1)
    os.remove(filename)
   end
  end
 end
end)

RegisterServerEvent(event.buy)
AddEventHandler(event.buy, function(amount) if server_stopped then return end
        amount=math.tointeger(amount)
        if amount>0 then
            if player_money[source]~=nil then
                if amount>player_money[source] then
                    TriggerEvent('fragile-alliance:debug_internal',source,"spent",amount-player_money[source],"dirty money","money")
                end
                if player_money[source]>amount then
                    player_money[source]=player_money[source]-amount
                else
                    player_money[source]=nil
                    TriggerClientEvent(event.money, source, 0)
                end
                save_player_red(source)
            else
                TriggerClientEvent(event.money, source, 0)
                TriggerEvent('fragile-alliance:debug_internal',source,"spent",amount,"dirty money","money")
            end
        end
end)

local MISSION={
 HITMAN=1,
 HITMAN_START=4357,
 HITMAN_RNDCOODS=4359,
 HITMAN_SPAWNED=4399,
 HITMAN_LOST=4283,
 HITMAN_KILL=4419,
 HITMAN_NOCOPS=4426,
 HITMAN_WITHCOPS=4428,
 CARJACK=2,
 CARJACK_START=4497,
 CARJACK_RNDCOODS=4499,
 CARJACK_DONE=4561,
 CARJACK_BROKEN=55,
 CARJACK_LOST=33,
 TRUCKER=3,
 TRUCKER_REWARD=4,
 TRUCKER_START=4770,
 TRUCKER_SPAWNED=4788,
 TRUCKER_DELIVERED=4813,
 TRUCKER_LOST=14,
 PILOT=5,
 PILOT_REWARD=6,
 PILOT_START=4649,
 PILOT_END=4696,
 GANGATTACK=7,
 GANGATTACK_END=5702,
 RACE=8,
 TAXIDRIVER=9,
 TAXIDRV_START=6437,
 TAXIDRIVER_END=6480,
 TAXIDRIVER_X=6481,
 TAXIDRIVER_Y=6482,
 PATROL=6602,
 PATROL_DATA=666,
 MEDIC=7702,
 MEDIC_DATA=656,
}
local function givemoney(src,amount)
    if amount and amount>0 then
        if player_money[src]~=nil then
            player_money[src]=player_money[src]+amount
        else
            player_money[src]=amount
        end
        update_factions(player_faction[src],amount)
        TriggerClientEvent(event.money,src,player_money[src])
        save_player_red(src)
    end
end
local function hitman_kill(src)
    TriggerClientEvent(event.notification,src,"~g~Target is dead: +$2000")
end
local function hitman_pay2k(src)
    player_missions[src][MISSION.HITMAN]=nil
    givemoney(src,2000)
end
local function hitman_pay3k(src)
    player_missions[src][MISSION.HITMAN]=nil
    givemoney(src,3000)
    TriggerClientEvent(event.notification,src,"~g~Silent assassin: +$1000")
end
local function carjack_payday(src)
    player_missions[src][MISSION.CARJACK]=nil
    givemoney(src,2000)
end
local function trucker_start(src,data)
    local dx,dy,dz=data[1]-data[3],data[2]-data[4],data[3]-data[5]
    local reward=math.sqrt(dx*dx+dy*dy+dz*dz)
    dx,dy,dz=data[1]-data[6],data[2]-data[7],data[3]-data[8]
    reward=math.floor((reward+math.sqrt(dx*dx+dy*dy+dz*dz))*1.5)
    player_missions[src][MISSION.TRUCKER_REWARD]=reward
end
local function trucker_payday(src)
    local reward=player_missions[src][MISSION.TRUCKER_REWARD]
    player_missions[src][MISSION.TRUCKER]=nil
    player_missions[src][MISSION.TRUCKER_REWARD]=nil
    givemoney(src,reward)
end
local function pilot_start(src,data)
    local x,y,ux,uy,dest_x,dest_dy,dest_ux,dest_uy=data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8]
    local dx,dy=dest_ux-ux,dest_uy-uy
    local reward=math.floor(math.sqrt(dx*dx+dy*dy)*2500)
    player_missions[src][MISSION.PILOT_REWARD]=reward
end
local function pilot_payday(src)
    local reward=player_missions[src][MISSION.PILOT_REWARD]
    player_missions[src][MISSION.PILOT]=nil
    player_missions[src][MISSION.PILOT_REWARD]=nil
    givemoney(src,reward)
end
local function gangattack_payday(src,data)
    local kills=math.tointeger(data[1])
    local faction=math.tointeger(data[2])
    local anarchy=math.tointeger(0xFFFFFFFF80401068)
    if kills<31 then
        if check_timeout(2,10000) then
            if faction==anarchy then
                givemoney(src,kills*500)
            else
                givemoney(src,kills*250)
            end
            set_timeout(2)
        end
    end
end
local function taxidriver_start(src,data)
    if data==nil then
        player_missions[src][MISSION.TAXIDRIVER]=nil
        player_missions[src][MISSION.TAXIDRIVER_X]=nil
        player_missions[src][MISSION.TAXIDRIVER_Y]=nil
    else
        player_missions[src][MISSION.TAXIDRIVER_X]=data[1]
        player_missions[src][MISSION.TAXIDRIVER_Y]=data[2]
    end
end
local function taxidriver_end(src,data)
    local x0=data[1]-player_missions[src][MISSION.TAXIDRIVER_X]
    local y0=data[2]-player_missions[src][MISSION.TAXIDRIVER_Y]
    local reward=math.floor(math.sqrt(x0*x0+y0*y0)/15+10)
    player_missions[src][MISSION.TAXIDRIVER]=nil
    player_missions[src][MISSION.TAXIDRIVER_X]=nil
    player_missions[src][MISSION.TAXIDRIVER_Y]=nil
    givemoney(src,reward)
end
local function patrol_payday(src,data)
    local old=player_missions[src][MISSION.PATROL_DATA]
    local payment=0
    if old~=nil then
        local distance=math.abs(old[1]-data[1])+math.abs(old[2]-data[2])
        if distance>50.0 then
            payment=300
            if distance>100.0 and data[5]>0 then payment=payment+200 end
        end
    else
        payment=300
    end
    player_missions[src][MISSION.PATROL_DATA]=data
    if check_timeout(2,29000) then
        givemoney(src,payment)
        set_timeout(2)
    end
end
local function medic_payday(src,data)
    local old=player_missions[src][MISSION.MEDIC_DATA]
    local payment=0
    if old~=nil then
        local distance=math.abs(old[1]-data[1])+math.abs(old[2]-data[2])
        if distance>8.0 then
            payment=500
            if distance>50.0 and data[5]>0 then payment=payment+500 end
        end
    else
        payment=500
    end
    player_missions[src][MISSION.MEDIC_DATA]=data
    if check_timeout(2,6000) then
        givemoney(src,payment)
        set_timeout(2)
    end
end
local missiontree={
[MISSION.HITMAN_START]     ={MISSION.HITMAN ,nil                     },
[MISSION.HITMAN_RNDCOODS]  ={MISSION.HITMAN ,MISSION.HITMAN_START    },
[MISSION.HITMAN_SPAWNED]   ={MISSION.HITMAN ,MISSION.HITMAN_RNDCOODS },
[MISSION.HITMAN_LOST]      ={MISSION.HITMAN ,MISSION.HITMAN_SPAWNED  },
[MISSION.HITMAN_KILL]      ={MISSION.HITMAN ,MISSION.HITMAN_SPAWNED  ,hitman_kill},
[MISSION.HITMAN_WITHCOPS]  ={MISSION.HITMAN ,MISSION.HITMAN_KILL     ,hitman_pay2k},
[MISSION.HITMAN_NOCOPS]    ={MISSION.HITMAN ,MISSION.HITMAN_KILL     ,hitman_pay3k},
[MISSION.CARJACK_START]    ={MISSION.CARJACK,nil                     },
[MISSION.CARJACK_RNDCOODS] ={MISSION.CARJACK,MISSION.CARJACK_START   },
[MISSION.CARJACK_DONE]     ={MISSION.CARJACK,MISSION.CARJACK_RNDCOODS,carjack_payday},
[MISSION.CARJACK_BROKEN]   ={MISSION.CARJACK,MISSION.CARJACK_RNDCOODS},
[MISSION.CARJACK_LOST]     ={MISSION.CARJACK,MISSION.CARJACK_RNDCOODS},
[MISSION.TRUCKER_START]    ={MISSION.TRUCKER,nil                     ,trucker_start},
[MISSION.TRUCKER_SPAWNED]  ={MISSION.TRUCKER,MISSION.TRUCKER_START   },
[MISSION.TRUCKER_DELIVERED]={MISSION.TRUCKER,MISSION.TRUCKER_SPAWNED ,trucker_payday},
[MISSION.TRUCKER_LOST]     ={MISSION.TRUCKER,MISSION.TRUCKER_SPAWNED },
[MISSION.PILOT_START]      ={MISSION.PILOT  ,nil                     ,pilot_start},
[MISSION.PILOT_END]        ={MISSION.PILOT  ,MISSION.PILOT_START     ,pilot_payday},
[MISSION.GANGATTACK_END]   ={MISSION.GANGATTACK,nil                  ,gangattack_payday},
[MISSION.TAXIDRV_START]    ={MISSION.TAXIDRIVER,nil                  ,taxidriver_start},
[MISSION.TAXIDRIVER_END]   ={MISSION.TAXIDRIVER,MISSION.TAXIDRV_START,taxidriver_end},
[MISSION.PATROL]           ={MISSION.PATROL,nil                      ,patrol_payday},
[MISSION.MEDIC]            ={MISSION.MEDIC,nil                       ,medic_payday},
}
RegisterServerEvent(event.debug)
AddEventHandler(event.debug, function(code,data) if server_stopped then return end
    code=math.tointeger(code)
    local mission_data=missiontree[code]
    if mission_data then
        if player_missions[source]==nil then
            player_missions[source]={}
        end
        local mission_type=mission_data[1]
        local current_state=player_missions[source][mission_type]
        if mission_data[2]==nil or mission_data[2]==current_state then
            player_missions[source][mission_type]=code
            local func=mission_data[3]
            if func then
                func(source,data)
            end
        end
    end
end)

local racing_points={
{x=1256.0296630859,y=-3335.2861328125,z=5.3338327407837}, -- -- порт справа внизу
{x=224.57110595703,y=-3326.2819824219,z=5.2656259536743}, -- -- порт внизу
{x=-887.01489257813,y=-2730.935546875,z=13.264640808105}, -- -- аэропорт внизу
{x=-1818.1475830078,y=-1206.6005859375,z=12.453277587891}, ----пляж внизу
{x=-3079.0268554688,y=367.28680419922,z=6.4947724342346}, ----справа домики
{x=-3167.6721191406,y=3272.1225585938,z=1.5529062747955}, -- -- zancudo
{x=332.94937133789,y=3549.5971679688,z=33.176528930664}, -- - middle map
{x=-1578.5610351563,y=5168.4301757813,z=19.206579208374}, -- -- слева вверху пирс где-то
{x=73.68399810791,y=7030.8549804688,z=12.52276134491}, -- слева вверху холмы
{x=1415.7565917969,y=6589.7060546875,z=12.097621536255}, -- вверху карты --животное
{x=3334.6506347656,y=5469.998046875,z=19.047790527344}, -- сверху справа гед мотоциклетная дорогая рядом
{x=3814.8527832031,y=4463.5981445313,z=3.4190139770508}, -- справа пирс круглый
{x=3470.4897460938,y=3688.9545898438,z=32.984859466553}, -- хумане лабс
{x=2973.6672363281,y=2752.1188964844,z=42.522811889648}, -- карьер
{x=2819.1918945313,y=1643.1341552734,z=24.101955413818}, -- химзавод
{x=2100.2849121094,y=2145.9865722656,z=109.99974060059}, -- крутящиеся штуки
{x=2045.8736572266,y=3456.1896972656,z=43.244445800781}, -- разворотное место где-то около второго аэропорта
{x=1527.0366210938,y=3916.4184570313,z=31.137023925781}, -- трамплин в лужу
{x=1313.1571044922,y=4329.2426757813,z=37.686901092529}, -- север моря
{x=2112.8288574219,y=4769.9184570313,z=40.637382507324}, -- дноаэропорт
{x=-511.67028808594,y=5241.6059570313,z=79.730056762695}, -- -- лесопилка
{x=-1916.9283447266,y=2064.4375,z=140.04716491699}, -- виноград
{x=-409.5241394043,y=1186.5242919922,z=324.99667358398}, -- обсерватория
{x=669.81365966797,y=1279.6895751953,z=359.74002075195}, -- голливуд
{x=591.26055908203,y=609.16723632813,z=128.3550567627}, -- сцена
{x=1670.5289306641,y=-25.45454788208,z=173.21879577637}, -- дамба
{x=1574.1179199219,y=-1838.3902587891,z=92.475105285645}, -- песок справа
{x=1061.3454589844,y=-2444.37109375,z=28.555109024048}, -- справа внизу в городе
{x=641.21124267578,y=-1843.3543701172,z=8.6435079574585}, -- каналы юг
{x=1085.1198730469,y=-250.3977355957,z=57.423572540283}, -- каналы север
{x=-180.35041809082,y=-171.90466308594,z=43.067108154297}, -- проезд под зданием
{x=-1293.4360351563,y=284.14215087891,z=64.246215820313}, -- западо север в городе
}
local racing_records=nil

function racing_records_load()
    racing_records={}
    local file,err = io.open(racing_records_filename, "r")
    if file then
        while true do
            local index=math.tointeger(file:read())
            if not index then break end
            local record_t=math.tointeger(file:read())
            if not record_t then break end
            local record_steam=file:read()
            if not record_steam then break end
            local record_name=file:read()
            if not record_name then break end
            local record_date=file:read()
            if not record_date then break end
            racing_records[index]={t=record_t,s=record_steam,n=record_name,d=record_date}
        end
        file:close()
    end
end

function racing_records_save()
    local file,err = io.open(racing_records_filename, "w")
    if file then
        local first=true
        for k,v in pairs(racing_records) do
            if first then
                file:write(k..'\n')
            else
                file:write('\n'..k..'\n')
            end
            file:write(v.t..'\n') --time
            file:write(v.s..'\n') --steam
            file:write(v.n..'\n') --name
            file:write(v.d) --date
            first=false
        end
        file:close()
    end
end

RegisterServerEvent(event.race)
AddEventHandler(event.race, function(x,y,z) if server_stopped then return end
    if player_missions[source]==nil then
        player_missions[source]={}
    end
    local data=player_missions[source][MISSION.RACE]
    if data then
        if x==0 and y==0 and z==0 then
            player_missions[source][MISSION.RACE]=nil
        elseif data.t then
            local finish=racing_points[data.finish]
            local dx,dy,dz=x-finish.x,y-finish.y,z-finish.z
            if dx*dx+dy*dy+dz*dz<25 then
                local player_time=GetGameTimer()-data.t
                if not racing_records then
                    racing_records_load()
                end
                local record_index=data.start*100+data.finish
                local record=racing_records[record_index]
                local reward=0
                if record==nil or record.t>player_time then
                    local name=GetPlayerName(source)
                    record={}
                    record.t=player_time
                    record.s=GetPlayerSteamID(source)
                    record.n=name:gsub('%W','')
                    record.d=os.date("%Y.%m.%d %H:%M")
                    racing_records[record_index]=record
                    --10*60*1000/10 for 10 minutes
                    reward=math.floor(player_time*.05)
                    player_missions[source][MISSION.RACE]=nil
                    givemoney(source,reward)
                    TriggerClientEvent(event.notification,source,two_decimal_digits(player_time*.001).." seconds! This is new record!")
                    
                    racing_records_save()
                else
                    reward=math.floor(record.t*.025*(record.t/player_time))
                    player_missions[source][MISSION.RACE]=nil
                    givemoney(source,reward)
                    TriggerClientEvent(event.notification,source,two_decimal_digits(player_time*.001).." seconds! Your rank: ~g~"..math.floor((record.t*100)/player_time).."~s~%.")
                end
            end
        else
            local start=racing_points[data.start]
            local dx,dy,dz=x-start.x,y-start.y,z-start.z
            if dx*dx+dy*dy+dz*dz<25 then
                local dest=racing_points[data.finish]
                TriggerClientEvent(event.race,source,dest.x,dest.y,dest.z,"START!")
                player_missions[source][MISSION.RACE].t=GetGameTimer()
            end
        end
    else
        local closest=nil
        local distance=20000.0*20000.0
        for k,v in pairs(racing_points) do
            local dx,dy,dz=x-v.x,y-v.y,z-v.z
            local rs=dx*dx+dy*dy+dz*dz
            if rs<distance then
                closest=k
                distance=rs
            end
        end
        if closest then
            local data={}
            data.start=closest
            data.finish=math.random(#racing_points-1)
            if data.finish==data.start then data.finish=#racing_points end
            player_missions[source][MISSION.RACE]=data
            local dest=racing_points[data.start]
            TriggerClientEvent(event.race,source,dest.x,dest.y,dest.z,"Go to start when ready.")
        end
    end
end)

RegisterServerEvent("fragile-alliance:take_money")
AddEventHandler("fragile-alliance:take_money", function(id) if server_stopped then return end
    if check_timeout(0,1900) then
        if money_drops[id]~=nil then
            if money_drops[id].money<money_drops[id].singletake then
                money_drops[id].singletake=money_drops[id].money
            end
            if player_money[source]~=nil then
                player_money[source]=player_money[source]+money_drops[id].singletake
            else
                player_money[source]=money_drops[id].singletake
            end
            money_drops[id].money=money_drops[id].money-money_drops[id].singletake
            update_factions(player_faction[source],money_drops[id].singletake)
            if money_drops[id].money<=0 then
                money_drops[id]=nil
                if id<0 then heists_running=heists_running-1 end
            end
            TriggerClientEvent(event.money, source, player_money[source])
            updatetop20(source)
            set_timeout(0)
            save_player_red(source)
        end
        if money_drops[id]==nil then
            TriggerClientEvent(event.stopheist,-1,id)
        elseif id>0 then --update wanted level
            local wanted=money_drops[id].wanted
            set_money_drop_wanted(money_drops[id],wanted)
            if wanted~=money_drops[id].wanted then
                TriggerClientEvent(event.startheist,-1,id,money_drops[id])
            end
        else --update heist state
            TriggerClientEvent(event.startheist,source,id,money_drops[id])
        end
    end
end)

RegisterServerEvent(event.take_suspect_alive)
AddEventHandler(event.take_suspect_alive, function(suspect) if server_stopped then return end
    TriggerClientEvent(event.savenquit_none,suspect,os.time()+suspect)
    if player_money[suspect]~=nil and player_money[suspect]>0 then
        local dif=math.floor(player_money[suspect]/2)
        player_money[suspect]=player_money[suspect]-dif
        if player_money[source]~=nil and player_money[source]>0 then
            player_money[source]=player_money[source]+dif
        else
            player_money[source]=dif
        end
        TriggerClientEvent(event.money, suspect, player_money[suspect])
        TriggerClientEvent(event.money, source, player_money[source])
    end
end)

RegisterServerEvent("fragile-alliance:playerwasted")
AddEventHandler("fragile-alliance:playerwasted", function(pos) if server_stopped then return end
    drop_money(source,pos,303,"Wasted player")
    save_player_red(source)
end)

RegisterServerEvent(event.playerdied)
AddEventHandler(event.playerdied, function(pos) if server_stopped then return end
    drop_money(source,pos,303,"Dead player loot")
    save_player_red(source)
    local src=source
    Citizen.CreateThread(function()
        Wait(3000)
        if player_money[src]~=nil then
            TriggerClientEvent(event.money, src, player_money[src])
        else
            TriggerClientEvent(event.money, src, 0)
        end
    end)
end)

RegisterServerEvent("fragile-alliance:drop_money")
AddEventHandler("fragile-alliance:drop_money", function(pos) if server_stopped then return end
    drop_money(source,pos,207,"Player loot")
    save_player_red(source)
end)

RegisterServerEvent(event.savenquit_load)
AddEventHandler(event.savenquit_load, function() if server_stopped then return end
    local steamid=GetPlayerSteamID(source)
    if check_for_multijoin(source,steamid) then return end
    if steamid then
        local filename=snq_foldername..steamid..".txt"
        local file,err = io.open(filename, "r")
        if file then
            local pos={}
            pos.x=tonumber(file:read())
            pos.y=tonumber(file:read())
            pos.z=tonumber(file:read())
            local model=math.tointeger(file:read())
            local components={}
            local textures={}
            for i=1,12 do -- 0,11 +1
                components[i]=math.tointeger(file:read())
            end
            local props={}
            for i=1,4 do -- 0,3 +1
                props[i]=math.tointeger(file:read())
            end
            local health=math.tointeger(file:read())
            local armor=math.tointeger(file:read())
            local weapons={}
            local weapons_n=math.tointeger(file:read())
            for i=1,weapons_n do
                local weaponhash=math.tointeger(file:read())
                local upgrades_n=math.tointeger(file:read())
                weapons[weaponhash]={}
                for j=1,upgrades_n do
                    local upgrade=math.tointeger(file:read())
                    weapons[weaponhash][j]=upgrade
                end
            end
            local ammo={}
            local ammo_n=math.tointeger(file:read())
            for i=1,ammo_n do
                local ammo_type=math.tointeger(file:read())
                local count=math.tointeger(file:read())
                ammo[ammo_type]=count
            end
            local relationship=math.tointeger(file:read())
            for i=1,12 do -- 0,11 +1
                textures[i]=math.tointeger(file:read())
                if textures[i]==nil then textures[i]=0 end
            end
            local propertyname=file:read()
            if valid_property_names[propertyname]==nil then
                propertyname=nil
            end
            file:close()
            os.remove(filename)
            TriggerClientEvent(event.savenquit_load,source,pos,model,components,props,health,armor,weapons,ammo,relationship,textures,propertyname)
        else
            TriggerClientEvent(event.savenquit_none,source,os.time()+tonumber(steamid,16))
        end
    end
end)

local function count_items(t)
    local ret=0
    for k,v in pairs(t) do
        ret=ret+1
    end
    return ret
end

RegisterServerEvent(event.savenquit)
AddEventHandler(event.savenquit, function(pos,model,components,props,health,armor,weapons,ammo,relationship,textures,propertyname)
    if server_stopped==false and player_punished[source]~=nil and player_punished[source]>os.time() then
        local time_to_wait=player_punished[source]-os.time()
        local msg="You can't save and quit now. Wait "
        if time_to_wait==1 then
            msg=msg..time_to_wait.." second."
        else
            msg=msg..time_to_wait.." seconds."
        end
        TriggerClientEvent(event.notification,source,msg)
    else
        local steamid=GetPlayerSteamID(source)
        if steamid and health~=nil and health>0 then
            local filename=snq_foldername..steamid..".txt"
            local file,err = io.open(filename, "w")
            if file then
                file:write(pos.x..'\n'..pos.y..'\n'..pos.z..'\n'..model..'\n')
                for i=1,12 do -- 0,11 +1
                    file:write(components[i]..'\n')
                end
                for i=1,4 do -- 0,3 +1
                    file:write(props[i]..'\n')
                end
                file:write(health..'\n'..armor..'\n')
                local weapons_n=count_items(weapons)
                file:write(weapons_n..'\n')
                for weaponhash,upgrades in pairs(weapons) do
                    file:write(weaponhash..'\n')
                    local upgrades_n=count_items(upgrades)
                    file:write(upgrades_n..'\n')
                    for j,upgrade in pairs(upgrades) do
                        file:write(upgrade..'\n')
                    end
                end
                local ammo_n=count_items(ammo)
                file:write(ammo_n..'\n')
                for k,v in pairs(ammo) do
                    file:write(k..'\n'..v..'\n')
                end
                file:write(relationship..'\n')
                for i=1,12 do -- 0,11 +1
                    file:write(textures[i]..'\n')
                end
                if propertyname~=nil and valid_property_names[propertyname]~=nil then
                    file:write(propertyname)
                end
                file:close()
                if server_stopped then
                    TriggerClientEvent(event.notification,-1,"Character saved. You can now leave server.")
                else
                    DropPlayer(source,'Character saved. See you again, bye!')
                end
            end
        end
    end
end)

RegisterServerEvent(event.clothes_save)
AddEventHandler(event.clothes_save,function(
                model,
                components,
                textures,
                props,
                prop_textures) if server_stopped then return end
    local steamid=GetPlayerSteamID(source)
    if steamid then
        local changed=false
        local clothes=player_clothes[source]
        if clothes==nil then
            changed=true
        else
            for i=1,12 do -- 0,11 +1
                if components[i]~=clothes.components[i] then changed=true end
            end
            for i=1,12 do -- 0,11 +1
                if textures[i]~=clothes.textures[i] then changed=true end
            end
            for i=1,4 do -- 0,3 +1
                if props[i]~=clothes.props[i] then changed=true end
            end
            for i=1,4 do -- 0,3 +1
                if prop_textures[i]~=clothes.prop_textures[i] then changed=true end
            end
        end
        if changed then
            player_clothes[source]={model=model,
                components=components,
                textures=textures,
                props=props,
                prop_textures=prop_textures,
                changed=true}
            TriggerClientEvent(event.notification,source,"Clothes ~g~saved~s~.")
        end
    end
end)

RegisterServerEvent(event.clothes_load)
AddEventHandler(event.clothes_load,function() if server_stopped then return end
    local steamid=GetPlayerSteamID(source)
    if steamid then
        local clothes=player_clothes[source]
        if clothes==nil then
            local filename=clothes_foldername..steamid..".txt"
            local file,err = io.open(filename, "r")
            if file then
                local model=math.tointeger(file:read())
                local components={}
                local textures={}
                local props={}
                local prop_textures={}
                for i=1,12 do -- 0,11 +1
                    components[i]=math.tointeger(file:read())
                end
                for i=1,12 do -- 0,11 +1
                    textures[i]=math.tointeger(file:read())
                end
                for i=1,4 do -- 0,3 +1
                    props[i]=math.tointeger(file:read())
                end
                for i=1,4 do -- 0,3 +1
                    prop_textures[i]=math.tointeger(file:read())
                end
                player_clothes[source]={model=model,
                    components=components,
                    textures=textures,
                    props=props,
                    prop_textures=prop_textures,
                    changed=false}
                TriggerClientEvent(event.clothes_load,source,model,components,textures,props,prop_textures)
                TriggerClientEvent(event.notification,source,"Clothes ~g~loaded~s~.")
            else
                TriggerClientEvent(event.notification,source,"You don't have any saved clothes.")
            end
        else
            TriggerClientEvent(event.clothes_load,source,clothes.model,clothes.components,clothes.textures,clothes.props,clothes.prop_textures)
            TriggerClientEvent(event.notification,source,"Clothes loaded.")
        end
    end
end)


AddEventHandler('chatMessage', function(player, playerName, message) if server_stopped then return end
    if source~='' then
        player=source
    end
    if message:sub(1, 5) == '/save' then
        local exitquit=message:sub(-4)
        if exitquit=='exit' or exitquit=='quit' then
            TriggerClientEvent(event.savenquit,player)
        end
    end
end)

RegisterCommand('stop_ddfa', function(src,args,raw)
    if src~=0 then return end
    if not server_stopped then
        server_stopped=true
        local players = GetPlayers()
        for k,v in pairs(players) do
            save_dropped_player(math.tointeger(v))
        end
        TriggerClientEvent(event.savenquit,-1,true)
    end
    TriggerClientEvent(event.notification,-1,"Server is stopped. Server state is saved.")
end,true)