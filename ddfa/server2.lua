local KNIFE=2578778090	--0x99B507EA
local NIGHTSTICK=1737195953	--0x678B81B1
local HAMMER=1317494643	--0x4E875F73
local BAT=2508868239	--0x958A4A8F
local GOLFCLUB=1141786504	--0x440E4788
local CROWBAR=2227010557	--0x84BD7BFD
local BOTTLE=4192643659	--0xF9E6AA4B
local DAGGER=2460120199	--0x92A27487
local KNUCKLE=3638508604	--0xD8DF3C3C
local HATCHET=4191993645	--0xF9DCBF2D
local MACHETE=3713923289	--0xDD5DF8D9
local SWITCHBLADE=3756226112	--0xDFE37640
local BATTLEAXE=3441901897	--0xCD274149
local POOLCUE=2484171525	--0x94117305
local WRENCH=419712736	--0x19044EE0

local PISTOL=453432689	--0x1B06D571
local COMBATPISTOL=1593441988	--0x5EF9FEC4
local APPISTOL=584646201	--0x22D8FE39
local PISTOL50=2578377531	--0x99AEEB3B
local MICROSMG=432421536	--0x13532244
local SMG=736523883	--0x2BE6766B
local ASSAULTSMG=4024951519	--0xEFE7E2DF
local ASSAULTRIFLE=3220176749	--0xBFEFFF6D
local CARBINERIFLE=2210333304	--0x83BF0278
local ADVANCEDRIFLE=2937143193	--0xAF113F99
local MG=2634544996	--0x9D07F764
local COMBATMG=2144741730	--0x7FD62962
local PUMPSHOTGUN=487013001	--0x1D073A89
local SAWNOFFSHOTGUN=2017895192	--0x7846A318
local ASSAULTSHOTGUN=3800352039	--0xE284C527
local BULLPUPSHOTGUN=2640438543	--0x9D61E50F
local STUNGUN=911657153	--0x3656C8C1
local SNIPERRIFLE=100416529	--0x05FC3C11
local HEAVYSNIPER=205991906	--0x0C472FE2
local SNSPISTOL=3218215474	--0xBFD21232
local GUSENBERG=1627465347	--0x61012683
local SPECIALCARBINE=3231910285	--0xC0A3098D
local HEAVYPISTOL=3523564046	--0xD205520E
local BULLPUPRIFLE=2132975508	--0x7F229F94
local VINTAGEPISTOL=137902532	--0x083839C4
local MUSKET=2828843422	--0xA89CB99E
local HEAVYSHOTGUN=984333226	--0x3AABBBAA
local MARKSMANRIFLE=3342088282	--0xC734385A
local GRENADELAUNCHER=2726580491	--0xA284510B
local RPG=2982836145	--0xB1CA77B1
local BZGAS=2694266206	--0xA0973D5E
local GRENADE=2481070269	--0x93E220BD
local STICKYBOMB=741814745	--0x2C3731D9
local MOLOTOV=615608432	--0x24B17070
local HOMINGLAUNCHER=1672152130	--0x63AB0442
local PROXMINE=2874559379	--0xAB564B93
local COMBATPDW=171789620	--0x0A3D4D34
local MARKSMANPISTOL=3696079510	--0xDC4DB296
local RAILGUN=1834241177	--0x6D544C99
local MACHINEPISTOL=3675956304	--0xDB1AA450
local REVOLVER=3249783761	--0xC1B3C3D1
local DBSHOTGUN=4019527611	--0xEF951FBB
local COMPACTRIFLE=1649403952	--0x624FE830
local AUTOSHOTGUN=317205821	--0x12E82D3D
local COMPACTLAUNCHER=125959754	--0x0781FE4A
local MINISMG=3173288789	--0xBD248B55
local PIPEBOMB=3125143736	--0xBA45E8B8

local player_data={} --file path
local player_garage={}
local money_drops={}
local player_money={}
local player_wanted={}
local player_pos={}
local player_plates={}
local current_heist=0
local top20={}
local top20_lowest

local function loadtop20()
    top20={}
    local lowest=nil
    local file,err = io.open("f9a611ea11142c3/top20.txt","r")
    if file then
     while true do
        local steamid=file:read()
        if (not steamid) or steamid=="" then break end
        top20[steamid]={}
        top20[steamid].money=tonumber(file:read())
        top20[steamid].name=file:read()
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
     local steamid=GetPlayerIdentifiers(player)[1]
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
      if 15<#top20 then
       top20[top20_lowest]=nil
       top20_lowest=updatetop20lowest()
      end
      savetop20()
     end
    end
end

function drop_money(player,pos,sprite,name)
  --TriggerClientEvent("chatMessage", -1, "Death", {128,128,0}, name)
  if (player_money[player]~=nil) and (player_money[player]>0) then
    --TriggerClientEvent("chatMessage", -1, "Fragile Alliance:", {128,128,0}, " dropped loot")
    local index=player
    while money_drops[index]~=nil do index=index+32 end
    money_drops[index]={}
    money_drops[index].money=player_money[player];
    player_money[player]=0;
    --TriggerClientEvent(event.money, source, 0)
    money_drops[index].x=pos.x
    money_drops[index].y=pos.y
    money_drops[index].z=pos.z
    money_drops[index].sprite=sprite
    money_drops[index].name=name
    if money_drops[index].money<2000 then
     money_drops[index].singletake=200
    else
     money_drops[index].singletake=math.floor(money_drops[index].money/10)
    end
    if player_wanted[player]==nil then
     money_drops[index].wanted=0
    else
     if money_drops[index].money<10000 then
      money_drops[index].wanted=math.min(player_wanted[player],2)
     elseif money_drops[index].money<25000 then
      money_drops[index].wanted=math.min(player_wanted[player],3)
     elseif money_drops[index].money<50000 then
      money_drops[index].wanted=math.min(player_wanted[player],4)
     else
      money_drops[index].wanted=player_wanted[player]
     end
    end
    money_drops[index].r=.5
    money_drops[index].bs=.5
    --coordinatearray[current_heist].singletake;
    TriggerClientEvent(event.startheist, -1, index, money_drops[index]);
  --else
    --TriggerClientEvent("chatMessage", -1, "Fragile Alliance:", {128,128,0}, "Type /heist to start mission.")
    --TriggerClientEvent("chatMessage", -1, "Fragile Alliance:", {128,128,0}, "Press Z to check your money.")
  end
end

AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local identifiers=GetPlayerIdentifiers(source)
    local steamid=nil
    local ros=nil
    for k,v in pairs(identifiers) do
        if string.sub(v,1,6)=="steam:" then
            steamid=string.sub(v,7)
            if(steamid:match("%W")) then steamid=nil end
        elseif string.sub(v,1,4)=="ros:" then
            ros=string.sub(v,5)
            if(ros:match("%W")) then ros=nil end
        end
    end
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

RegisterServerEvent(event.wanted)
AddEventHandler(event.wanted, function(wanted)
    player_wanted[source]=wanted
end)

RegisterServerEvent(event.pos)
AddEventHandler(event.pos, function(pos)
    player_pos[source]=pos
end)

RegisterServerEvent(event.abandoncar)
AddEventHandler(event.abandoncar, function(plate)
    
end)

RegisterServerEvent(event.plates)
AddEventHandler(event.plates, function(p1,p2,p3)
    local identifiers=GetPlayerIdentifiers(source)
    local steamid=nil
    local ros=nil
    for k,v in pairs(identifiers) do
        if string.sub(v,1,6)=="steam:" then
            steamid=string.sub(v,7)
            if(steamid:match("%W")) then steamid=nil end
        -- elseif string.sub(v,1,4)=="ros:" then
            -- ros=string.sub(v,5)
            -- if(ros:match("%W")) then ros=nil end
        end
    end
    if steamid then
        if not player_plates[steamid] then
            player_plates[steamid]={}
        end
        player_plates[steamid][1]=p1
        player_plates[steamid][2]=p2
        player_plates[steamid][3]=p3
        local dbg=steamid.." plates ["
        if p1 then dbg=dbg..p1.."][" else dbg=dbg.."nil][" end
        if p2 then dbg=dbg..p1.."][" else dbg=dbg.."nil][" end
        if p3 then dbg=dbg..p1.."]" else dbg=dbg.."nil]" end
    end
end)

RegisterServerEvent(event.connected)
AddEventHandler(event.connected, function()
    if player_data[source]==nil then
        local identifiers=GetPlayerIdentifiers(source)
        local steamid=nil
        local ros=nil
        for k,v in pairs(identifiers) do
            if string.sub(v,1,6)=="steam:" then
                steamid=string.sub(v,7)
                if(steamid:match("%W")) then steamid=nil end
            elseif string.sub(v,1,4)=="ros:" then
                ros=string.sub(v,5)
                if(ros:match("%W")) then ros=nil end
            end
        end
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
              file:close()
              file,err=io.open(player_data[source], "w")
              file:write("0\n0")
             else
              print("file was empty")
             end
             file:close()
            else
             TriggerClientEvent(event.money,source,0)
             print(err)
            end
            if player_plates[steamid] then
                TriggerClientEvent(event.plates,source,player_plates[steamid][1],player_plates[steamid][2],player_plates[steamid][3])
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
    if player_data[source]~=nil then
        local file,err = io.open(player_data[source], "w")
        if file then
         if player_money[source]~=nil then
          if player_wanted[source]==nil or player_wanted[source]~=5 then
            file:write(player_money[source])
          else
            file:write("0");
            if player_pos[source]~=nil then
             drop_money(source,player_pos[source],303,"Player left with 5 stars")
            end
          end
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
            player_garage[source]=nil
         end
         file:close()
        else
         print(err)
        end
    else
        print("cant save player data")
    end
    player_money[source]=nil
    player_pos[source]=nil
    player_wanted[source]=nil
end)

RegisterServerEvent(event.take_car)
AddEventHandler(event.take_car, function(k)
    if player_garage[source]~=nil then
        player_garage[source][k]=nil
    end
end)

RegisterServerEvent(event.save_car)
AddEventHandler(event.save_car, function(k,car)
    if player_garage[source]==nil then player_garage[source]={} end
    player_garage[source][k]=car
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
   {x=-119.616,y=-1576.976,z=34.1848,sprite=496,name="Steal drugs",wanted=1,money=2500,singletake=500,enemies=6,skins={-398748745,866411749,613248456,2077218039,1309468115},weapons={MICROSMG,MACHINEPISTOL}},
   {x=-334.763,y=-1317.364,z=31.4004,sprite=496,name="Steal drugs",wanted=2,money=9000,singletake=300,enemies=5,skins={-44746786,1330042375,1032073858,850468060},weapons={COMPACTRIFLE,DBSHOTGUN,MINISMG}},
   {x=271.251,y=-1737.183,z=35.2965,sprite=408,name="Steal diamonds",wanted=4,money=25000,singletake=1000,enemies=1,skins={-422822692},weapons={SPECIALCARBINE}},
   {x=-129.715,y=-1421.568,z=31.3002,sprite=498,name="Steal documents",wanted=3,money=15000,singletake=500,enemies=5,skins={-1275859404,2047212121,1349953339},weapons={KNIFE,SMG,CARBINERIFLE,COMBATPISTOL,ASSAULTSMG}},
   {x=866.311,y=-964.121,z=26.2829,sprite=501,name="Steal meth",wanted=3,money=15000,singletake=500,enemies=6,skins={-712602007,275618457,377976310,-294281201,411102470},weapons={SWITCHBLADE,SNSPISTOL,SAWNOFFSHOTGUN,COMBATPISTOL}},
   {x=2.485,y=-1309.374,z=30.1653,sprite=496,name="Steal drugs",wanted=2,money=20000,singletake=500,enemies=6,skins={-254493138,-1176698112,275618457,2119136831,-9308122},weapons={CROWBAR,MICROSMG,HEAVYPISTOL,BULLPUPSHOTGUN}},
   {x=291.864,y=-990.509,z=36.6019,sprite=500,name="Steal money",wanted=1,money=20000,singletake=500,enemies=5,skins={-67533719,-1880237687,2093736314,648372919,666086773},weapons={NIGHTSTICK,SNIPERRIFLE,HEAVYPISTOL,BULLPUPRIFLE}},
   {x=117.887,y=-238.717,z=53.3560,sprite=500,name="Steal money",wanted=2,money=22500,singletake=500,enemies=8,skins={-46035440,1226102803,-664900312,-927525251,768005095},weapons={HAMMER,PISTOL50,PISTOL,COMBATPISTOL}},
   {x=-190.3955078125,y=-1183.1065673828,z=23.030401229858,sprite=521,name="Steal electronics",wanted=3,money=13500,singletake=500,enemies=8,skins={-322270187,-2088436577,1936142927,-709209345,-2076336881},weapons={DAGGER,SNSPISTOL,PISTOL,REVOLVER,COMBATPISTOL}},
   {x=-29.127,y=162.592,z=94.9908,sprite=521,name="Steal information",wanted=4,money=5000,singletake=2500,enemies=2,skins={-306416314,874722259},weapons={COMBATPISTOL,REVOLVER}},
   {x=-158.659,y=-156.255,z=43.6212,sprite=500,name="Steal money",wanted=3,money=25000,singletake=500,enemies=6,skins={-1613485779,-520477356,988062523,1189322339,-245247470,-245247470,691061163,691061163},weapons={HEAVYPISTOL,PISTOL50,PUMPSHOTGUN,MICROSMG,PISTOL,SMG}},
   {x=-391.218,y=-146.258,z=38.5322,sprite=501,name="Steal coke",wanted=3,money=15000,singletake=500,enemies=6,skins={1520708641,-995747907,-100858228},weapons={BAT,MINISMG,AUTOSHOTGUN,ASSAULTRIFLE}},
   {x=-970.061,y=104.434,z=55.6658,sprite=501,name="Steal coke",wanted=3,money=20000,singletake=500,enemies=6,skins={1626646295,1794381917,193817059,1750583735},weapons={MG,CARBINERIFLE,MACHETE,ADVANCEDRIFLE}},
   {x=1663.5278320313,y=-27.433429718018,z=173.77473449707,sprite=500,name="Steal money",wanted=1,money=15000,singletake=500,enemies=4,skins={-1613485779,-520477356,988062523,1189322339,-245247470,-245247470,691061163,691061163},weapons={HEAVYPISTOL,PISTOL50,PUMPSHOTGUN,MICROSMG,PISTOL,SMG}},
   {x=2755.1301269531,y=1578.1528320313,z=50.686878204346,sprite=499,name="Steal chemicals",wanted=3,money=18000,singletake=600,enemies=3,skins={-1395868234,-907676309},weapons={REVOLVER,MICROSMG}},
   {x=46.64128112793,y=-1036.7197265625,z=37.18327331543,sprite=521,name="Steal information",wanted=2,money=13000,singletake=1300,enemies=1,skins={-306416314},weapons={PISTOL50}},
   {x=-139.0888671875,y=-1283.7889404297,z=47.898109436035,sprite=521,name="Steal information",wanted=3,money=18000,singletake=500,enemies=10,skins={-277325206,-1047300121,-1427838341,-1105135100},weapons={PISTOL,MACHINEPISTOL,SAWNOFFSHOTGUN}},
   {x=477.71426391602,y=-890.33056640625,z=35.972190856934,sprite=496,name="Steal drugs",wanted=2,money=13000,singletake=500,enemies=7,skins={-277325206,-1047300121,-1427838341,-1105135100},weapons={PISTOL,MACHINEPISTOL,SAWNOFFSHOTGUN}},
   {x=-94.882675170898,y=-68.186668395996,z=56.638584136963,sprite=496,name="Steal drugs",wanted=2,money=13000,singletake=500,enemies=7,skins={-277325206,-1047300121,-1427838341,-1105135100},weapons={PISTOL,MACHINEPISTOL,SAWNOFFSHOTGUN}},
   {x=3537.7434082031,y=3665.2736816406,z=28.121868133545,sprite=521,name="Steal data",wanted=5,money=400000,singletake=4000,enemies=7,skins={1092080539,788443093,2120901815,-912318012,-1589423867,-1211756494,-1366884940},weapons={PISTOL,COMBATPISTOL,HEAVYPISTOL,SNSPISTOL,PISTOL50,COMBATPDW,PISTOL,COMBATPISTOL,HEAVYPISTOL,SNSPISTOL,PISTOL50,COMBATPDW,RAILGUN}},
   {x=2673.5876464844,y=3286.1796875,z=55.241138458252,sprite=500,name="Steal money",wanted=2,money=5000,singletake=500,enemies=1,skins={666086773},weapons={STUNGUN}},
   {x=1392.9525146484,y=3602.6538085938,z=38.941883087158,sprite=499,name="Steal chemicals",wanted=3,money=25000,singletake=500,enemies=1,skins={1064866854,1001210244,1768677545},weapons={PUMPSHOTGUN,DBSHOTGUN,BOTTLE,BAT,KNIFE,SWITCHBLADE}},
   {x=1595.3160400391,y=3586.9951171875,z=38.766494750977,sprite=501,name="Steal heroin",wanted=3,money=30000,singletake=500,enemies=11,skins={-398748745,866411749,-613248456,-2077218039,1309468115,-198252413,588969535,361513884,-1492432238,599294057},weapons={ASSAULTRIFLE,MACHINEPISTOL,PISTOL}},
   {x=255.81332397461,y=225.77488708496,z=101.8757019043,sprite=500,name="Steal money",wanted=5,money=600000,singletake=3000,enemies=4,skins={-681004504,1558115333,368603149,1581098148},weapons={PISTOL,SMG,PUMPSHOTGUN,CARBINERIFLE}},
   {x=310.66033935547,y=-283.29971313477,z=54.1745262146,sprite=500,name="Steal money",wanted=4,money=65000,singletake=650,enemies=2,skins={-681004504},weapons={PISTOL,STUNGUN}},
   {x=450.39303588867,y=-975.66790771484,z=30.689596176147,sprite=521,name="Steal information",wanted=4,money=100000,singletake=1000,enemies=3,skins={368603149,1581098148,1939545845},weapons={PISTOL,STUNGUN}},
   {x=-635.13677978516,y=-1728.6335449219,z=24.190845489502,sprite=501,name="Steal heroin",wanted=3,money=30000,singletake=500,enemies=11,skins={-398748745,866411749,-613248456,-2077218039,1309468115,-198252413,588969535,361513884,-1492432238,599294057},weapons={ASSAULTRIFLE,MACHINEPISTOL,PISTOL}},
   {x=29.880146026611,y=-98.098907470703,z=56.020793914795,sprite=500,name="Steal money",wanted=2,money=22500,singletake=500,enemies=8,skins={-46035440,1226102803,-664900312,-927525251,768005095},weapons={HAMMER,PISTOL50,PISTOL,COMBATPISTOL}}
};
--for i = 1, 10 do
--   MsgBox ("i равно "..i)
--end

--AddEventHandler('playerConnecting', function(playerName, setKickReason)
    --RconLog({ msgType = 'customConnect', ip = GetPlayerEP(source), name = playerName })
    --player_money[source]=0
--end)

local function startheist(player)
    if money_drops[-1]==nil then
        current_heist=math.random(#coordinatearray)
        money_drops[-1]={}
        money_drops[-1].x=coordinatearray[current_heist].x
        money_drops[-1].y=coordinatearray[current_heist].y
        money_drops[-1].z=coordinatearray[current_heist].z
        money_drops[-1].sprite=coordinatearray[current_heist].sprite
        money_drops[-1].name=coordinatearray[current_heist].name
        money_drops[-1].money=coordinatearray[current_heist].money
        money_drops[-1].singletake=coordinatearray[current_heist].singletake
        money_drops[-1].wanted=coordinatearray[current_heist].wanted
        money_drops[-1].r=2.75
        money_drops[-1].bs=1.5
        TriggerClientEvent(event.spawnpeds,player,money_drops[-1].x,money_drops[-1].y,money_drops[-1].z,coordinatearray[current_heist].enemies,coordinatearray[current_heist].skins,coordinatearray[current_heist].weapons)
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
    if message:sub(1, 6) == '/heist' then
        startheist(player)
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
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "can pick it up, just like you; search for green skull blips.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "You can hide money with ^3F1 ^0button and pick it back with ^3F2 ^0button.")
    elseif message:sub(1, 9) == '/commands' or message:sub(1, 4) == '/cmd' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/cops ^7 Info about cops.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/cars ^7 Info about cars.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/money ^7 Info about money.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/discord ^7 Discord link.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/missions ^7 Missions info.")
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "^5/rules ^7 Server rules.")
    elseif message:sub(1, 8) == '/discord' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance", {0,150,255}, "discord.gg/VZG5Nvk")
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
    end
end)

RegisterServerEvent(event.stash_hide)
AddEventHandler(event.stash_hide, function(x,y,z)
 x=math.tointeger(x)
 y=math.tointeger(y)
 z=math.tointeger(z)
 if x~=nil and y~=nil and z~=nil and player_money[source]~=nil and player_money[source]>=10000 and (player_wanted[source]==nil or player_wanted[source]==0) then
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
    end
   else
    file,err = io.open(filename, "w")
    if file then
     file:write(10000)
     file:close()
     player_money[source]=player_money[source]-10000
     TriggerClientEvent(event.money,source,player_money[source])
    end
   end
  else
   file,err = io.open(filename, "w")
   if file then
    file:write(10000)
    file:close()
    player_money[source]=player_money[source]-10000
    TriggerClientEvent(event.money,source,player_money[source])
   end
  end
 end
end)

RegisterServerEvent(event.stash_take)
AddEventHandler(event.stash_take, function(x,y,z)
 x=math.tointeger(x)
 y=math.tointeger(y)
 z=math.tointeger(z)
 if x~=nil and y~=nil and z~=nil then
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
    end
   elseif loaded_money==nil or loaded_money==0 then
    os.remove(filename)
   end
  end
 end
end)

RegisterServerEvent(event.buy)
AddEventHandler(event.buy, function(amount)
        if player_money[source]~=nil then
            if player_money[source]>amount then
                player_money[source]=player_money[source]-amount
            else
                player_money[source]=nil
                --TriggerClientEvent(event.money, source, 0)
            end
        end
end)

RegisterServerEvent("fragile-alliance:take_money")
AddEventHandler("fragile-alliance:take_money", function(id)
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
        if money_drops[id].money<=0 then
            money_drops[id]=nil
        end
        TriggerClientEvent(event.money, source, player_money[source])
        updatetop20(source)
    end
    if money_drops[id]==nil then
        TriggerClientEvent(event.stopheist, -1, id)
    end
end)

RegisterServerEvent("fragile-alliance:playerwasted")
AddEventHandler("fragile-alliance:playerwasted", function(pos)
    drop_money(source,pos,303,"Wasted player")
end)

RegisterServerEvent(event.playerdied)
AddEventHandler(event.playerdied, function(pos)
    drop_money(source,pos,303,"Dead player loot")
end)

RegisterServerEvent("fragile-alliance:drop_money")
AddEventHandler("fragile-alliance:drop_money", function(pos)
    drop_money(source,pos,207,"Player loot")
end)