local WEAPON={}
WEAPON.KNIFE=0xFFFFFFFF99B507EA --2578778090	--0x99B507EA
WEAPON.NIGHTSTICK=1737195953	--0x678B81B1
WEAPON.HAMMER=1317494643	--0x4E875F73
WEAPON.BAT=0xFFFFFFFF958A4A8F --2508868239	--0x958A4A8F
WEAPON.GOLFCLUB=1141786504	--0x440E4788
WEAPON.CROWBAR=0xFFFFFFFF84BD7BFD --2227010557	--0x84BD7BFD
WEAPON.BOTTLE=0xFFFFFFFFF9E6AA4B --4192643659	--0xF9E6AA4B
WEAPON.DAGGER=0xFFFFFFFF92A27487 --2460120199	--0x92A27487
WEAPON.KNUCKLE=0xFFFFFFFFD8DF3C3C --3638508604	--0xD8DF3C3C
WEAPON.HATCHET=0xFFFFFFFFF9DCBF2D --4191993645	--0xF9DCBF2D
WEAPON.MACHETE=0xFFFFFFFFDD5DF8D9 --3713923289	--0xDD5DF8D9
WEAPON.SWITCHBLADE=0xFFFFFFFFDFE37640 --3756226112	--0xDFE37640
WEAPON.BATTLEAXE=0xFFFFFFFFCD274149 --3441901897	--0xCD274149
WEAPON.POOLCUE=0xFFFFFFFF94117305 --2484171525	--0x94117305
WEAPON.WRENCH=419712736	--0x19044EE0

WEAPON.PISTOL=453432689	--0x1B06D571
WEAPON.COMBATPISTOL=1593441988	--0x5EF9FEC4
WEAPON.APPISTOL=584646201	--0x22D8FE39
WEAPON.PISTOL50=0xFFFFFFFF99AEEB3B --2578377531	--0x99AEEB3B
WEAPON.MICROSMG=324215364	--0x13532244
WEAPON.SMG=736523883	--0x2BE6766B
WEAPON.ASSAULTSMG=0xFFFFFFFFEFE7E2DF --4024951519	--0xEFE7E2DF
WEAPON.ASSAULTRIFLE=0xFFFFFFFFBFEFFF6D --3220176749	--0xBFEFFF6D
WEAPON.CARBINERIFLE=0xFFFFFFFF83BF0278 --2210333304	--0x83BF0278
WEAPON.ADVANCEDRIFLE=0xFFFFFFFFAF113F99 --2937143193	--0xAF113F99
WEAPON.MG=0xFFFFFFFF9D07F764 --2634544996	--0x9D07F764
WEAPON.COMBATMG=2144741730	--0x7FD62962
WEAPON.PUMPSHOTGUN=487013001	--0x1D073A89
WEAPON.SAWNOFFSHOTGUN=2017895192	--0x7846A318
WEAPON.ASSAULTSHOTGUN=0xFFFFFFFFE284C527 --3800352039	--0xE284C527
WEAPON.BULLPUPSHOTGUN=0xFFFFFFFF9D61E50F --2640438543	--0x9D61E50F
WEAPON.STUNGUN=911657153	--0x3656C8C1
WEAPON.SNIPERRIFLE=100416529	--0x05FC3C11
WEAPON.HEAVYSNIPER=205991906	--0x0C472FE2
WEAPON.SNSPISTOL=0xFFFFFFFFBFD21232 --3218215474	--0xBFD21232
WEAPON.GUSENBERG=1627465347	--0x61012683
WEAPON.SPECIALCARBINE=0xFFFFFFFFC0A3098D --3231910285	--0xC0A3098D
WEAPON.HEAVYPISTOL=0xFFFFFFFFD205520E --3523564046	--0xD205520E
WEAPON.BULLPUPRIFLE=2132975508	--0x7F229F94
WEAPON.VINTAGEPISTOL=137902532	--0x083839C4
WEAPON.MUSKET=0xFFFFFFFFA89CB99E --2828843422	--0xA89CB99E
WEAPON.HEAVYSHOTGUN=984333226	--0x3AABBBAA
WEAPON.MARKSMANRIFLE=0xFFFFFFFFC734385A --3342088282	--0xC734385A
WEAPON.GRENADELAUNCHER=0xFFFFFFFFA284510B --2726580491	--0xA284510B
WEAPON.RPG=0xFFFFFFFFB1CA77B1 --2982836145	--0xB1CA77B1
WEAPON.BZGAS=0xFFFFFFFFA0973D5E --2694266206	--0xA0973D5E
WEAPON.GRENADE=0xFFFFFFFF93E220BD --2481070269	--0x93E220BD
WEAPON.STICKYBOMB=741814745	--0x2C3731D9
WEAPON.MOLOTOV=615608432	--0x24B17070
WEAPON.HOMINGLAUNCHER=1672152130	--0x63AB0442
WEAPON.PROXMINE=0xFFFFFFFFAB564B93 --2874559379	--0xAB564B93
WEAPON.COMBATPDW=171789620	--0x0A3D4D34
WEAPON.MARKSMANPISTOL=0xFFFFFFFFDC4DB296 --3696079510	--0xDC4DB296
WEAPON.RAILGUN=1834241177	--0x6D544C99
WEAPON.MACHINEPISTOL=0xFFFFFFFFDB1AA450 --3675956304	--0xDB1AA450
WEAPON.REVOLVER=0xFFFFFFFFC1B3C3D1 --3249783761	--0xC1B3C3D1
WEAPON.DBSHOTGUN=0xFFFFFFFFEF951FBB --4019527611	--0xEF951FBB
WEAPON.COMPACTRIFLE=1649403952	--0x624FE830
WEAPON.AUTOSHOTGUN=317205821	--0x12E82D3D
WEAPON.COMPACTLAUNCHER=125959754	--0x0781FE4A
WEAPON.MINISMG=0xFFFFFFFFBD248B55 --3173288789	--0xBD248B55
WEAPON.PIPEBOMB=0xFFFFFFFFBA45E8B8 --3125143736	--0xBA45E8B8

WEAPON.PARACHUTE=0xFFFFFFFFFBAB5776

local player_data={} --file path
local player_garage={}
local money_drops={}
local player_money={}
local player_wanted={}
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

local function loadfactions()
    local i=0
    local file,err = io.open("f9a611ea11142c3/factions.txt","r")
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

local function savefactions()
    local i=0
    local file,err = io.open("f9a611ea11142c3/factions.txt","w")
    if file then
     for i=1,13 do
      file:write(factions[i].."\n")
     end
     file:close()
    print("faction top updated")
    else
    print(err)
    end
end

local function update_factions(i,amount)
    if i then
    print("faction "..i.." updated")
        if factions[i]>0 or amount>0 then
            factions[i]=factions[i]+amount
            if factions[i]<0 then factions[i]=0 end
            savefactions()
        end
     else
     print("faction nil")
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
    return steamid
end

local function loadtop20()
    top20={}
    top20_count=0
    local lowest=nil
    local file,err = io.open("f9a611ea11142c3/top20.txt","r")
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
    local file,err = io.open("f9a611ea11142c3/top20.txt","w")
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
     if string.sub(steamid,1,6)~="steam:" then return end
     steamid=string.sub(steamid,7)
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
    money_drops[index].z=pos.z
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

AddEventHandler('playerConnecting', function(playerName, setKickReason)
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

local function save_player(source)
    if player_data[source]~=nil then
        local file,err = io.open(player_data[source], "w")
        if file then
         if player_money[source]~=nil then
          file:write(player_money[source])
         else
          file:write("0");
         end
         if player_wanted[source]~=nil then
          file:write("\n"..player_wanted[source])
         else
          file:write("\n0")
         end
         if player_garage[source]~=nil then
            for k,v in pairs(player_garage[source]) do
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
        else
         print(err)
        end
    else
        print("cant save player data")
    end
end

local wipe_at_logon=false --store active players only in RAM
local save_player_red
--if wipe_at_logon then
 save_player_red=function(...) end
--else
-- save_player_red=save_player --redundand saves
--end

RegisterServerEvent(event.wanted)
AddEventHandler(event.wanted, function(wanted)
    player_wanted[source]=math.tointeger(wanted)
    save_player_red(source)
end)

RegisterServerEvent(event.pos)
AddEventHandler(event.pos, function(x,y,z)
    if x~=nil and y~=nil and z~=nil then
        player_pos[source]={x=x,y=y,z=z}
    end
end)

RegisterServerEvent(event.gang)
AddEventHandler(event.gang, function(gang)
    gang=math.tointeger(gang)
    --print("gang="..gang)
    if gang then
        if gang<1 or gang>13 then gang=nil end
    end
    player_faction[source]=gang
end)

RegisterServerEvent(event.gangwarscore)
AddEventHandler(event.gangwarscore, function()
    TriggerClientEvent(event.gangwarscore,source,factions)
end)

RegisterServerEvent(event.abandoncar)
AddEventHandler(event.abandoncar, function(plate)
    
end)

RegisterServerEvent(event.plates)
AddEventHandler(event.plates, function(p1,p2,p3,p4,p5,p6)
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
AddEventHandler(event.connected, function()
    if player_data[source]==nil then
        local steamid=GetPlayerSteamID(source)
        if steamid then
            print("attempting to load "..source)
            player_data[source]="f9a611ea11142c3/"..steamid..".dat"
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

AddEventHandler('playerDropped', function()
    --RconLog({ msgType = 'playerDropped', netID = source, name = GetPlayerName(source) })
    print("attempting to save "..source)
    if player_money[source]~=nil and player_wanted[source] and player_wanted[source]==5 and player_pos[source]~=nil then
         drop_money(source,player_pos[source],303,"Player left with 5 stars")
    end
    save_player(source)
    player_garage[source]=nil
    player_money[source]=nil
    player_pos[source]=nil
    player_wanted[source]=nil
    player_faction[source]=nil
    player_missions[source]=nil
    player_timeouts[source]=nil
end)

RegisterServerEvent(event.take_car)
AddEventHandler(event.take_car, function(k)
    if player_garage[source]~=nil then
        player_garage[source][k]=nil
        save_player_red(source)
    end
end)

RegisterServerEvent(event.save_car)
AddEventHandler(event.save_car, function(k,car)
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
   {x=-119.616,y=-1576.976,z=34.1848,sprite=496,name="Steal drugs",wanted=1,money=2500,singletake=500,enemies=6,skins={1064866854,1001210244,1768677545},weapons={WEAPON.MICROSMG,WEAPON.MACHINEPISTOL}},
   {x=-334.763,y=-1317.364,z=31.4004,sprite=496,name="Steal drugs",wanted=2,money=9000,singletake=300,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.COMPACTRIFLE,WEAPON.DBSHOTGUN,WEAPON.MINISMG}},
   {x=271.251,y=-1737.183,z=35.2965,sprite=408,name="Steal diamonds",wanted=4,money=25000,singletake=1000,enemies=1,skins={-422822692},weapons={WEAPON.SPECIALCARBINE}},
   {x=-129.715,y=-1421.568,z=31.3002,sprite=498,name="Steal documents",wanted=3,money=15000,singletake=500,enemies=5,skins={-1538846349},weapons={WEAPON.KNIFE,WEAPON.SMG,WEAPON.CARBINERIFLE,WEAPON.COMBATPISTOL,WEAPON.ASSAULTSMG}},
   {x=866.311,y=-964.121,z=26.2829,sprite=501,name="Steal meth",wanted=3,money=15000,singletake=500,enemies=6,skins={-712602007,377976310,-294281201,411102470},weapons={WEAPON.SWITCHBLADE,WEAPON.SNSPISTOL,WEAPON.SAWNOFFSHOTGUN,WEAPON.COMBATPISTOL}},
   {x=2.485,y=-1309.374,z=30.1653,sprite=496,name="Steal drugs",wanted=2,money=20000,singletake=500,enemies=6,skins={1064866854,1001210244,1768677545},weapons={WEAPON.CROWBAR,WEAPON.MICROSMG,WEAPON.HEAVYPISTOL,WEAPON.BULLPUPSHOTGUN}},
   {x=291.864,y=-990.509,z=36.6019,sprite=500,name="Steal money",wanted=1,money=20000,singletake=500,enemies=5,skins={648372919,666086773},weapons={WEAPON.NIGHTSTICK,WEAPON.SNIPERRIFLE,WEAPON.HEAVYPISTOL,WEAPON.BULLPUPRIFLE}},
   {x=117.887,y=-238.717,z=53.3560,sprite=500,name="Steal money",wanted=2,money=22500,singletake=500,enemies=8,skins={-46035440,1226102803,-664900312,-927525251,768005095},weapons={WEAPON.HAMMER,WEAPON.PISTOL50,WEAPON.PISTOL,WEAPON.COMBATPISTOL}},
   {x=-190.3955078125,y=-1183.1065673828,z=23.030401229858,sprite=521,name="Steal electronics",wanted=3,money=13500,singletake=500,enemies=8,skins={-322270187,-2088436577,1936142927,-709209345,-2076336881},weapons={WEAPON.DAGGER,WEAPON.SNSPISTOL,WEAPON.PISTOL,WEAPON.REVOLVER,WEAPON.COMBATPISTOL}},
   {x=-29.127,y=162.592,z=94.9908,sprite=521,name="Steal information",wanted=4,money=5000,singletake=2500,enemies=2,skins={-306416314,874722259},weapons={WEAPON.COMBATPISTOL,WEAPON.REVOLVER}},
   {x=-158.659,y=-156.255,z=43.6212,sprite=500,name="Steal money",wanted=3,money=25000,singletake=500,enemies=6,skins={-1613485779,-520477356,988062523,1189322339},weapons={WEAPON.HEAVYPISTOL,WEAPON.PISTOL50,WEAPON.PUMPSHOTGUN,WEAPON.MICROSMG,WEAPON.PISTOL,WEAPON.SMG}},
   {x=-391.218,y=-146.258,z=38.5322,sprite=501,name="Steal coke",wanted=3,money=15000,singletake=500,enemies=6,skins={1520708641,-995747907,-100858228},weapons={WEAPON.BAT,WEAPON.MINISMG,WEAPON.AUTOSHOTGUN,WEAPON.ASSAULTRIFLE}},
   {x=-970.061,y=104.434,z=55.6658,sprite=501,name="Steal coke",wanted=3,money=20000,singletake=500,enemies=6,skins={1626646295,1794381917,193817059,1750583735},weapons={WEAPON.MG,WEAPON.CARBINERIFLE,WEAPON.MACHETE,WEAPON.ADVANCEDRIFLE}},
   {x=1663.5278320313,y=-27.433429718018,z=173.77473449707,sprite=500,name="Steal money",wanted=1,money=15000,singletake=500,enemies=4,skins={-1613485779,-520477356,988062523,1189322339},weapons={WEAPON.HEAVYPISTOL,WEAPON.PISTOL50,WEAPON.PUMPSHOTGUN,WEAPON.MICROSMG,WEAPON.PISTOL,WEAPON.SMG}},
   {x=2755.1301269531,y=1578.1528320313,z=50.686878204346,sprite=499,name="Steal chemicals",wanted=3,money=18000,singletake=600,enemies=3,skins={-1395868234,-907676309},weapons={WEAPON.REVOLVER,WEAPON.MICROSMG}},
   {x=46.64128112793,y=-1036.7197265625,z=37.18327331543,sprite=521,name="Steal information",wanted=2,money=13000,singletake=1300,enemies=1,skins={-306416314},weapons={WEAPON.PISTOL50}},
   {x=-139.0888671875,y=-1283.7889404297,z=47.898109436035,sprite=521,name="Steal information",wanted=3,money=18000,singletake=500,enemies=10,skins={-277325206,-1047300121,-1427838341},weapons={WEAPON.PISTOL,WEAPON.MACHINEPISTOL,WEAPON.SAWNOFFSHOTGUN}},
   {x=477.71426391602,y=-890.33056640625,z=35.972190856934,sprite=496,name="Steal drugs",wanted=2,money=13000,singletake=500,enemies=7,skins={-277325206,-1047300121,-1427838341},weapons={WEAPON.PISTOL,WEAPON.MACHINEPISTOL,WEAPON.SAWNOFFSHOTGUN}},
   {x=-94.882675170898,y=-68.186668395996,z=56.638584136963,sprite=496,name="Steal drugs",wanted=2,money=13000,singletake=500,enemies=7,skins={-277325206,-1047300121,-1427838341},weapons={WEAPON.PISTOL,WEAPON.MACHINEPISTOL,WEAPON.SAWNOFFSHOTGUN}},
   {x=3537.7434082031,y=3665.2736816406,z=28.121868133545,sprite=521,name="Steal data",wanted=5,money=400000,singletake=4000,enemies=7,skins={1092080539,788443093,2120901815,-912318012,-1589423867,-1211756494,-1366884940},weapons={WEAPON.PISTOL,WEAPON.COMBATPISTOL,WEAPON.HEAVYPISTOL,WEAPON.SNSPISTOL,WEAPON.PISTOL50,WEAPON.COMBATPDW,WEAPON.PISTOL,WEAPON.COMBATPISTOL,WEAPON.HEAVYPISTOL,WEAPON.SNSPISTOL,WEAPON.PISTOL50,WEAPON.COMBATPDW,WEAPON.RAILGUN}},
   {x=2673.5876464844,y=3286.1796875,z=55.241138458252,sprite=500,name="Steal money",wanted=2,money=5000,singletake=500,enemies=1,skins={666086773},weapons={WEAPON.STUNGUN}},
   {x=1392.9525146484,y=3602.6538085938,z=38.941883087158,sprite=499,name="Steal chemicals",wanted=3,money=25000,singletake=500,enemies=1,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}},
   {x=1595.3160400391,y=3586.9951171875,z=38.766494750977,sprite=501,name="Steal heroin",wanted=3,money=30000,singletake=500,enemies=11,skins={1064866854,1001210244,1768677545},weapons={WEAPON.ASSAULTRIFLE,WEAPON.MACHINEPISTOL,WEAPON.PISTOL}},
   {x=255.81332397461,y=225.77488708496,z=101.8757019043,sprite=500,name="Steal money",wanted=5,money=600000,singletake=6000,enemies=4,skins={-681004504,1558115333,368603149,1581098148},weapons={WEAPON.PISTOL,WEAPON.SMG,WEAPON.PUMPSHOTGUN,WEAPON.CARBINERIFLE}},
   {x=310.66033935547,y=-283.29971313477,z=54.1745262146,sprite=500,name="Steal money",wanted=4,money=65000,singletake=650,enemies=2,skins={-681004504},weapons={WEAPON.PISTOL,WEAPON.STUNGUN}},
   {x=440.03012084961,y=-991.51953125,z=30.689594268799,sprite=521,name="Steal information",wanted=4,money=100000,singletake=1000,enemies=3,skins={368603149,1581098148,1939545845},weapons={WEAPON.PISTOL,WEAPON.STUNGUN}},
   {x=-635.13677978516,y=-1728.6335449219,z=24.190845489502,sprite=501,name="Steal heroin",wanted=3,money=30000,singletake=500,enemies=11,skins={1064866854,1001210244,1768677545},weapons={WEAPON.ASSAULTRIFLE,WEAPON.MACHINEPISTOL,WEAPON.PISTOL}},
   {x=29.880146026611,y=-98.098907470703,z=56.020793914795,sprite=500,name="Steal money",wanted=2,money=22500,singletake=500,enemies=8,skins={-46035440,1226102803,-664900312,-927525251,768005095},weapons={WEAPON.HAMMER,WEAPON.PISTOL50,WEAPON.PISTOL,WEAPON.COMBATPISTOL}},
   {x=9.2347011566162,y=-1102.7471923828,z=29.797012329102,sprite=478,name="Steal weapons",wanted=2,money=17500,singletake=500,enemies=3,skins={-46035440,1226102803,-664900312,-927525251,768005095},weapons={WEAPON.MACHETE,WEAPON.PISTOL50,WEAPON.ASSAULTSHOTGUN,WEAPON.AUTOSHOTGUN}},
   {x=-154.88626098633,y=6140.0922851563,z=32.335090637207,sprite=408,name="Steal diamonds",wanted=3,money=100000,singletake=1000,enemies=4,skins={-712602007,377976310,-294281201,411102470},weapons={WEAPON.MACHINEPISTOL,WEAPON.COMBATPISTOL,WEAPON.MACHETE}},
   {x=-622.14739990234,y=-230.87982177734,z=38.057033538818,sprite=408,name="Steal diamonds",wanted=4,money=150000,singletake=1500,enemies=2,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PISTOL,WEAPON.HEAVYPISTOL}},
   {x=706.89807128906,y=-966.12646484375,z=30.412851333618,sprite=521,name="Steal information",wanted=3,money=50000,singletake=500,enemies=3,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --lester warhouse
   {x=-1050.1361083984,y=-240.94955444336,z=44.021053314209,sprite=521,name="Steal data",wanted=4,money=70000,singletake=500,enemies=2,skins={-681004504},weapons={WEAPON.PISTOL,WEAPON.STUNGUN}},
   {x=-226.19862365723,y=-2000.8435058594,z=24.685342788696,sprite=408,name="Steal servers",wanted=4,money=20000,singletake=500,enemies=2,skins={-681004504},weapons={WEAPON.PISTOL,WEAPON.STUNGUN}},
   {x=-5.8843197822571,y=-676.626953125,z=16.130626678467,sprite=500,name="Steal money",wanted=5,money=1000000,singletake=10000,enemies=2,skins={-681004504},weapons={WEAPON.PISTOL,WEAPON.STUNGUN}},
   {x=2440.4934082031,y=4977.3095703125,z=46.810592651367,sprite=501,name="Steal drugs",wanted=2,money=130000,singletake=1300,enemies=15,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --o neil
   {x=2435.2084960938,y=4967.380859375,z=42.347560882568,sprite=501,name="Steal drugs",wanted=2,money=250000,singletake=2500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --o neil
   {x=-580.12377929688,y=-1627.791015625,z=33.074031829834,sprite=501,name="Steal drugs",wanted=2,money=50000,singletake=500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --rogers FACTORY
   {x=-607.42205810547,y=-1631.2557373047,z=33.010551452637,sprite=501,name="Steal drugs",wanted=2,money=50000,singletake=500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --FACTORY
   {x=-616.59869384766,y=-1623.3514404297,z=33.010581970215,sprite=521,name="Steal information",wanted=2,money=20000,singletake=500,enemies=1,skins={-306416314},weapons={WEAPON.PISTOL50}}, --rogers FACTORY
   {x=952.03198242188,y=-2124.2270507813,z=31.446039199829,sprite=501,name="Steal drugs",wanted=2,money=20000,singletake=500,enemies=5,skins={1064866854,1001210244,1768677545},weapons={WEAPON.PUMPSHOTGUN,WEAPON.DBSHOTGUN,WEAPON.BOTTLE,WEAPON.BAT,WEAPON.KNIFE,WEAPON.SWITCHBLADE}}, --FACTORY
};
--for i = 1, 10 do
--   MsgBox ("i равно "..i)
--end

--AddEventHandler('playerConnecting', function(playerName, setKickReason)
    --RconLog({ msgType = 'customConnect', ip = GetPlayerEP(source), name = playerName })
    --player_money[source]=0
--end)

local function startheist(player)
    if heists_running<3 then
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
AddEventHandler(event.startheist, function()
    startheist(source)
end)

AddEventHandler('chatMessage', function(player, playerName, message)
    if source~='' then
        player=source
    end
    if message:sub(1, 6) == '/heist' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Use your phone to start a heist.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "The more reddish heist color is, the harder it is.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Get a team to complete harder heists.")
        --startheist(player)
    elseif message:sub(1, 6) == '/money' then
         --player_money[player]=tonumber(message:sub(7))
         --TriggerClientEvent(event.money, player, player_money[player])
        if player_money[player] then
         TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "$"..player_money[player])
        else
         TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "You don't have money.")
        end
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Use your money to buy gear and cars.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "When you die - you loose all of your money, and other players")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "can pick it up, just like you; search for green and white skull blips.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "You can hide money with ^3F1 ^0button and pick it back with ^3F2 ^0button.")
    elseif message:sub(1, 5) == '/help' or message:sub(1, 9) == '/commands' or message:sub(1, 4) == '/cmd' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/cops ^7 Info about cops.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/cars ^7 Info about cars.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/money ^7 Info about money.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/discord ^7 Discord link.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/missions ^7 Missions info.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/rules ^7 Server rules.")
    elseif message:sub(1, 8) == '/discord' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "discord.gg/VZG5Nvk")
    -- elseif message:sub(1, 7) == '/facwar' then
        -- TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "~r~Test ")
    elseif message:sub(1, 5) == '/cops' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Cops are always searching for stolen cars.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "You can loose 1 or 2 wanted level by changing clothes.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "If you have 5 wanted level, you need to leave Los-Santos")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "by plane or boat.")
    elseif message:sub(1, 5) == '/cars' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "If you're driving stolen car - you'll get wanted level.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Different cars will give you different wanted levels.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Buy your own car or cops will always chase you.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "If your car is dead - you can't fix it, it's gone.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Place your can in ^1garage ^7before leaving server to ^5save it^7.")
    elseif message:sub(1, 9) == '/missions' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Once heist is started - you'll get big green icon.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Go there and stay in green circle to get money.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "Watch out for other players, because they can easily kill you.")
    elseif message:sub(1, 6) == '/rules' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "1) Don't use cheats.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "2) There are no other rules and you are free do to whatever you want.")
    elseif message:sub(1, 4) == '/top' then
        TriggerClientEvent(event.top,player,top20)
    elseif message:sub(1, 4) == '/ooc' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "This is not RP server, no rules here.")
    end
end)

RegisterServerEvent(event.stash_hide)
AddEventHandler(event.stash_hide, function(x,y,z)
 x=math.tointeger(x)
 y=math.tointeger(y)
 z=math.tointeger(z)
 if check_timeout(1,900) and x~=nil and y~=nil and z~=nil and player_money[source]~=nil and player_money[source]>=10000 and (player_wanted[source]==nil or player_wanted[source]==0) then
  local filename="630ca54126/"..x.."_"..y.."_"..z..".dat"
  local file,err = io.open(filename, "r")
  if file then
   local loaded_money=math.tointeger(file:read())
   file:close()
   if loaded_money then
    loaded_money=loaded_money+10000
    file,err = io.open(filename, "w")
    if file then
     file:write(loaded_money)
     file:close()
     player_money[source]=player_money[source]-10000
     TriggerClientEvent(event.money,source,player_money[source])
     set_timeout(1)
     save_player_red(source)
    end
   else
    file,err = io.open(filename, "w")
    if file then
     file:write(10000)
     file:close()
     player_money[source]=player_money[source]-10000
     TriggerClientEvent(event.money,source,player_money[source])
     set_timeout(1)
     save_player_red(source)
    end
   end
  else
   file,err = io.open(filename, "w")
   if file then
    file:write(10000)
    file:close()
    player_money[source]=player_money[source]-10000
    TriggerClientEvent(event.money,source,player_money[source])
    set_timeout(1)
    save_player_red(source)
   end
  end
 else
  TriggerClientEvent(event.notification,source,"You need at least $10000 and zero stars to create money stash.")
 end
end)

RegisterServerEvent(event.stash_take)
AddEventHandler(event.stash_take, function(x,y,z)
 x=math.tointeger(x)
 y=math.tointeger(y)
 z=math.tointeger(z)
 if check_timeout(1,900) and x~=nil and y~=nil and z~=nil then
  local filename="630ca54126/"..x.."_"..y.."_"..z..".dat"
  local file,err = io.open(filename, "r")
  if file then
   local loaded_money=math.tointeger(file:read())
   file:close()
   if loaded_money and loaded_money>=10000 then
    loaded_money=loaded_money-10000
    file,err = io.open(filename, "w")
    if file then
     file:write(loaded_money)
     file:close()
     if player_money[source] then
      player_money[source]=player_money[source]+10000
     else
      player_money[source]=10000
     end
     TriggerClientEvent(event.money,source,player_money[source])
     set_timeout(1)
     save_player_red(source)
    end
   elseif loaded_money==nil or loaded_money==0 then
    os.remove(filename)
   end
  end
 end
end)

RegisterServerEvent(event.buy)
AddEventHandler(event.buy, function(amount)
        amount=math.tointeger(amount)
        if amount>0 and player_money[source]~=nil then
            if player_money[source]>amount then
                player_money[source]=player_money[source]-amount
            else
                player_money[source]=nil
                TriggerClientEvent(event.money, source, 0)
            end
            save_player_red(source)
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
 RACE=8
}
local function givemoney(source,amount)
    if amount and amount>0 then
        if player_money[source]~=nil then
            player_money[source]=player_money[source]+amount
        else
            player_money[source]=amount
        end
        update_factions(player_faction[source],amount)
        TriggerClientEvent(event.money,source,player_money[source])
        save_player_red(source)
    end
end
local function hitman_kill(source)
    TriggerClientEvent(event.notification,source,"~g~Target is dead: +$2000")
end
local function hitman_pay2k(source)
    player_missions[source][MISSION.HITMAN]=nil
    givemoney(source,2000)
end
local function hitman_pay3k(source)
    player_missions[source][MISSION.HITMAN]=nil
    givemoney(source,3000)
    TriggerClientEvent(event.notification,source,"~g~Silent assassin: +$1000")
end
local function carjack_payday(source)
    player_missions[source][MISSION.CARJACK]=nil
    givemoney(source,2000)
end
local function trucker_start(source,data)
    local dx,dy,dz=data[1]-data[3],data[2]-data[4],data[3]-data[5]
    local reward=math.sqrt(dx*dx+dy*dy+dz*dz)
    dx,dy,dz=data[1]-data[6],data[2]-data[7],data[3]-data[8]
    reward=math.floor((reward+math.sqrt(dx*dx+dy*dy+dz*dz))*1.5)
    player_missions[source][MISSION.TRUCKER_REWARD]=reward
end
local function trucker_payday(source)
    local reward=player_missions[source][MISSION.TRUCKER_REWARD]
    player_missions[source][MISSION.TRUCKER]=nil
    player_missions[source][MISSION.TRUCKER_REWARD]=nil
    givemoney(source,reward)
end
local function pilot_start(source,data)
    local x,y,ux,uy,dest_x,dest_dy,dest_ux,dest_uy=data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8]
    local dx,dy=dest_ux-ux,dest_uy-uy
    local reward=math.floor(math.sqrt(dx*dx+dy*dy)*2500)
    player_missions[source][MISSION.PILOT_REWARD]=reward
end
local function pilot_payday(source)
    local reward=player_missions[source][MISSION.PILOT_REWARD]
    player_missions[source][MISSION.PILOT]=nil
    player_missions[source][MISSION.PILOT_REWARD]=nil
    givemoney(source,reward)
end
local function gangattack_payday(source,data)
    local kills=math.tointeger(data[1])
    local faction=math.tointeger(data[2])
    local anarchy=math.tointeger(0xFFFFFFFF80401068)
    if kills<31 then
        if faction==anarchy then
            givemoney(source,kills*500)
        else
            givemoney(source,kills*250)
        end
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
[MISSION.GANGATTACK_END]   ={MISSION.GANGATTACK,nil                  ,gangattack_payday}
}
RegisterServerEvent(event.debug)
AddEventHandler(event.debug, function(code,data)
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
    local file,err = io.open("f9a611ea11142c3/racing_records.txt", "r")
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
    local file,err = io.open("f9a611ea11142c3/racing_records.txt", "w")
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
AddEventHandler(event.race, function(x,y,z)
    if player_missions[source]==nil then
        player_missions[source]={}
    end
    local data=player_missions[source][MISSION.RACE]
    if data then
        if data.t then
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
                    TriggerClientEvent(event.notification,source,(player_time*.001).." seconds! This is new record!")
                    
                    racing_records_save()
                else
                    reward=math.floor(record.t*.025*(record.t/player_time))
                    player_missions[source][MISSION.RACE]=nil
                    givemoney(source,reward)
                    TriggerClientEvent(event.notification,source,(player_time*.001).." seconds! Your rank: ~g~"..math.floor((record.t*100)/player_time).."~s~%.")
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
AddEventHandler("fragile-alliance:take_money", function(id)
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
            end
            TriggerClientEvent(event.money, source, player_money[source])
            updatetop20(source)
            set_timeout(0)
            save_player_red(source)
        end
        if money_drops[id]==nil then
            if id<0 then heists_running=heists_running-1 end
            TriggerClientEvent(event.stopheist,-1,id)
        elseif id>0 then
            local wanted=money_drops[id].wanted
            set_money_drop_wanted(money_drops[id],wanted)
            if wanted~=money_drops[id].wanted then
                TriggerClientEvent(event.startheist,-1,id,money_drops[id])
            end
        end
    end
end)

RegisterServerEvent("fragile-alliance:playerwasted")
AddEventHandler("fragile-alliance:playerwasted", function(pos)
    drop_money(source,pos,303,"Wasted player")
    save_player_red(source)
end)

RegisterServerEvent(event.playerdied)
AddEventHandler(event.playerdied, function(pos)
    drop_money(source,pos,303,"Dead player loot")
    save_player_red(source)
end)

RegisterServerEvent("fragile-alliance:drop_money")
AddEventHandler("fragile-alliance:drop_money", function(pos)
    drop_money(source,pos,207,"Player loot")
    save_player_red(source)
end)