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
--require "defines.lua"
-- Citizen.CreateThread(function()

    -- local mht=1;
    -- local coordinatearray[mht]={
    -- {x=-119.616,y=-1576.976,z=34.1848,sprite=351,name="Steal drugs",wanted=2,money=2500,enemies=3},
    -- {x=-334.763,y=-1317.364,z=31.4004,sprite=351,name="Steal drugs",wanted=2,money=9000,enemies=5},
    -- {x=271.251,y=-1737.183,z=35.2965,sprite=351,name="Steal diamonds",wanted=4,money=25000,enemies=1}
    -- {x=-129.715,y=-1421.568,z=31.3002,sprite=351,name="Steal documents",wanted=3,money=15000,enemies=7}
    -- };
    -- local blip=0;
    
    -- while true do
      -- ---create new heist
        -- local heisttype=math.random(mht);
        -- local heist_pos=coordinatearray[heisttype];
        -- local heist_money=9000;
        
        -- if blip==0 then
         -- blip=AddBlipForCoord(heist_pos.x,heist_pos.y,heist_pos.z);
        -- else
         -- SetBlipCoords(blip,heist_pos.x,heist_pos.y,heist_pos.z);
         
        -- SetBlipSprite(blip, heist_pos.sprite);
        -- SetBlipDisplay(blip, 2);
        -- SetBlipScale(blip, 1.0)
        -- SetBlipAsShortRange(info.blip, false)
        -- SetBlipColour(blip, 2);
        -- BeginTextCommandSetBlipName("STRING")
        -- AddTextComponentString(heist_pos.name)
        -- EndTextCommandSetBlipName(blip)
      -- ---heist in progress
        -- while heist_money>0 do
            -- for i = 0, 31 do
             -- if NetworkIsPlayerActive(i) then
                    -- SetNotificationTextEntry("STRING");
                    -- AddTextComponentString("testmessage");
                    -- SetNotificationMessage("CHAR_STRIPPER_CHEETAH", "CHAR_STRIPPER_INFERNUS", false, 1, "test", "coords");
                    -- DrawNotification(false, false);
             -- end
            -- end
            -- heist_money=heist_money-1000;
            -- Wait(1000);
        -- end
      -- ---heist ended
        -- SetBlipSprite(blip, 406);
        -- Wait(30000);
    -- end
    
-- end);

local player_is_cop=false
local debug_mode=false
local money_drops={}
local money_blips={}
local player_money=0
local player_wanted=0
local pos
local isDead = false
local relationship_enemy=GetHashKey("PRISONER")
local relationship_friend=GetHashKey("PLAYER")
--NetworkEarnFromNotBadsport(2000)
 -- NetworkSetFriendlyFireOption(true)
 -- SetCanAttackFriendly(GetPlayerPed(-1), true, false)
 
      -- SetNotificationTextEntry("STRING");
      -- AddTextComponentString(GetRelationshipBetweenGroups(relationship_friend, relationship_friend));
      -- SetNotificationMessage("CHAR_LESTER", "CHAR_LESTER", false, 1, "Relationship", "Before");
      -- DrawNotification(false, false);
--Citizen.Wait(1000)
--TriggerServerEvent('_chat:messageEntered', "Rel before", {255,128,128}, "ationship="..GetRelationshipBetweenGroups(relationship_friend, relationship_friend))
--ClearRelationshipBetweenGroups(0, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(1, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(2, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(3, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(4, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(5, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(255, relationship_friend, relationship_friend)
--SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), relationship_friend)
--SetRelationshipBetweenGroups(5, relationship_friend, GetHashKey('PLAYER'))
      -- SetNotificationTextEntry("STRING");
      -- AddTextComponentString(GetRelationshipBetweenGroups(relationship_friend, relationship_friend));
      -- SetNotificationMessage("CHAR_LESTER", "CHAR_LESTER", false, 1, "Relationship", "After");
      -- DrawNotification(false, false);
--TriggerServerEvent('_chat:messageEntered', "Rel after", {255,128,128}, "ationship="..GetRelationshipBetweenGroups(relationship_friend, relationship_friend))
    --int GET_RELATIONSHIP_BETWEEN_GROUPS(Hash group1, Hash group2);
    --void SET_RELATIONSHIP_BETWEEN_GROUPS(int relationship, Hash group1, Hash group2);
local mycar={}
local mycar_old={}
local rentcar={}
local enemies={}
local friends={}
local jail_pos={x=1655.9542236328,y=2544.7395019531,z=45.564891815186}
math.randomseed(os.time())
math.random()

-- Citizen.CreateThread(function()
    -- local blip=AddBlipForCoord(money_drops[-1].x, money_drops[-1].y, money_drops[-1].z)
    -- SetBlipSprite(blip, 27) --heist.sprite
    -- SetBlipDisplay(blip, 2)
    -- SetBlipScale(blip, 0.9)
    -- --SetBlipColour(money_blips[id].blip, info.colour)
    -- --SetBlipAsShortRange(money_blips[id].blip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString("test")
    -- EndTextCommandSetBlipName(blip)
    -- --SetPedMoney(GetPlayerPed(-1), 50000);
    -- money_blips[-1]=blip
-- end)

-- function showmoney()
	-- N_0xc2d15bef167e27bc()
	-- SetPlayerCashChange(1, 0)
	-- Citizen.InvokeNative(0x170F541E1CADD1DE, true)
	-- SetPlayerCashChange(player_money, 0)
-- end

--Entity NETWORK_GET_ENTITY_FROM_NETWORK_ID(int netId);
--BOOL NETWORK_GET_ENTITY_IS_LOCAL(Entity entity);
--BOOL NETWORK_GET_ENTITY_IS_NETWORKED(Entity entity);
--int NETWORK_GET_NETWORK_ID_FROM_ENTITY(Entity entity);
--void NETWORK_REGISTER_ENTITY_AS_NETWORKED(Entity entity);
--void NETWORK_SET_ENTITY_CAN_BLEND(Entity entity, BOOL toggle);
--void NETWORK_UNREGISTER_NETWORKED_ENTITY(Entity entity);
--void _SET_NETWORK_VEHICLE_NON_CONTACT(Vehicle vehicle, BOOL toggle);

local function addcarblip(veh)
    local carblip=AddBlipForEntity(veh)
    SetBlipSprite(carblip, 326)
    SetBlipDisplay(carblip, 2)
    SetBlipScale(carblip, 0.6)
    SetBlipColour(carblip, 3)
end

local function NetworkUnregisterNetworkedEntity(entity)
    return Citizen.InvokeNative(0x7368E683BB9038D6,entity)
end

local function NetworkRegisterEntityAsNetworked(entity)
    return Citizen.InvokeNative(0x06FAACD625D80CAA,entity)
end

local function networkingshit(veh)
    NetworkRegisterEntityAsNetworked(veh)
    SetEntityAsMissionEntity(veh,true,true)
    return NetworkGetNetworkIdFromEntity(veh)
end

local function forgetgps(car)
    if car.gps then
        if car.gps.blip then
            RemoveBlip(car.gps.blip)
            car.gps.blip=nil
        end
        car.gps.x=nil
        car.gps.y=nil
        car.gps.z=nil
        car.gps.name=nil
    end
end

local function rotategps(car1,car2)
    if car1.gps then
        if not car2.gps then
            car2.gps={}
        end
        car2.gps.x=car1.gps.x
        car2.gps.y=car1.gps.y
        car2.gps.z=car1.gps.z
        car2.gps.blip=car1.gps.blip
        car2.gps.name=car1.gps.name
    else
        car2.gps={}
    end
end

local function sendcarplates()
    TriggerServerEvent(event.plates,mycar.plate,mycar_old.plate,rentcar.plate)
end

local function abandoncar(car)
    if car.veh~=nil and car.net~=nil and car.net~=0 and car.plate then
        if net~=NetworkGetNetworkIdFromEntity(car.veh) then
            TriggerServerEvent(event.abandoncar,car.plate)
        else
            SetVehicleAsNoLongerNeeded(car.veh)
        end
    end
end

local function trytofixvehid(car)
    if car.plate then
        if car.veh~=nil and car.net~=nil and car.net~=0 then
            if car.net~=NetworkGetNetworkIdFromEntity(car.veh) then
                car.veh=nil
            else
                local pos=GetEntityCoords(car.veh)
                if not car.gps then
                    car.gps={}
                end
                car.gps.x,car.gps.y,car.gps.z=pos.x,pos.y,pos.z
                if not car.gps.name then
                    car.gps.name=GetDisplayNameFromVehicleModel(GetEntityModel(car.veh))
                end
            end
        end
        if car.veh==nil then
            if car.gps and not car.gps.blip then
                local carblip=AddBlipForCoord(car.gps.x, car.gps.y, car.gps.z)
                local name
                local text
                if car.gps.name then
                    name="GPS signal lost:"..car.gps.name.."("..car.plate..")"
                    text="~r~GPS signal lost:\n"..car.gps.name.."("..car.plate..")"
                else
                    name="GPS signal lost:"..car.plate
                    text="~r~"..name
                end
                SetBlipSprite(carblip, 326)
                SetBlipDisplay(carblip, 2)
                SetBlipScale(carblip, 0.6)
                SetBlipColour(carblip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(name);
                EndTextCommandSetBlipName(carblip)
                car.gps.blip=carblip
                SetNotificationTextEntry("STRING");
                AddTextComponentString(text)
                DrawNotification(false, false);
            end
            if IsPedInAnyVehicle(GetPlayerPed(-1),false) then
                vehnew=GetVehiclePedIsUsing(GetPlayerPed(-1))
                local platenew=GetVehicleNumberPlateText(vehnew)
                --SetNotificationTextEntry("STRING")
                --AddTextComponentString(plate.." "..platenew.." "..NetworkHasControlOfEntity(vehnew))
                --DrawNotification(false, false);
                if platenew==car.plate then
                    NetworkUnregisterNetworkedEntity(vehnew)
                    NetworkRegisterEntityAsNetworked(vehnew)
                    SetEntityAsMissionEntity(vehnew,true,true)
                    local netnew=NetworkGetNetworkIdFromEntity(vehnew)
                    addcarblip(vehnew)
                    if car.gps and car.gps.blip then
                        RemoveBlip(car.gps.blip)
                        car.gps.blip=nil
                    end
                    car.veh=vehnew
                    car.net=netnew
                end
            end
        end
    end
end

-- local function trytofixvehid(veh,net,plate)
    -- if veh~=nil and net~=nil and net~=0 and plate~="" then
        -- local vehnew=NetworkGetEntityFromNetworkId(net)
        -- if veh~=vehnew then
            -- if vehnew~=nil and vehnew~=0 then
                -- addcarblip(vehnew)
                -- return vehnew,net
            -- elseif IsPedInAnyVehicle(GetPlayerPed(-1),false) then
                -- vehnew=GetVehiclePedIsUsing(GetPlayerPed(-1))
                -- local netnew=NetworkGetNetworkIdFromEntity(vehnew)
                -- if netnew==net then
                    -- addcarblip(vehnew)
                    -- return vehnew,net
                -- else
                    -- local platenew=GetVehicleNumberPlateText(vehnew)
                    -- if platenew==plate then
                        -- return vehnew,netnew
                    -- end
                -- end
            -- end
        -- end
    -- end
    -- return veh,net
-- end

Citizen.CreateThread(function()
Wait(5000)
    local classes={
    [0]=1, --Compacts
    [1]=1, --Sedans
    [2]=1, --SUVs
    [3]=1, --Coupes
    [4]=2, --Muscle
    [5]=2, --Sports Classics
    [6]=2, --Sports
    [7]=4, --Super
    [8]=1, --Motorcycles
    [9]=1, --Off-road
    [10]=2, --Industrial
    [11]=1, --Utility
    [12]=1, --Vans
    [13]=1, --Cycles
    [14]=1, --Boats
    [15]=3, --Helicopters
    [16]=3, --Planes
    [17]=1, --Service
    [18]=3, --Emergency
    [19]=5, --Military
    [20]=2, --Commercial
    [21]=2 --Trains
    }
    while true do
        Citizen.Wait(300000)
        local player=PlayerId()
        local ped=GetPlayerPed(-1)
        if IsPedInAnyVehicle(ped, false) and not player_is_cop then
            local veh=GetVehiclePedIsUsing(ped)
            trytofixvehid(mycar)
            trytofixvehid(mycar_old)
            trytofixvehid(rentcar)
            if (veh~=mycar.veh) and (veh~=mycar_old.veh) and (veh~=rentcar.veh) and ped==GetPedInVehicleSeat(veh,-1) then
                local wanted=classes[GetVehicleClass(veh)]
                if GetPlayerWantedLevel(player)<wanted then
                    SetPlayerWantedLevel(player,wanted,false)
                    SetNotificationTextEntry("STRING");
                    AddTextComponentString("This vehicle is ~r~stolen~s~. Police is searching for it.")
                    DrawNotification(false, false);
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
Wait(5000)
    while true do
        Wait(1000)
        if debug_mode then
            local test="debug:m="
            if mycar.veh then
             test=test..mycar.veh
            else
             test=test.."nil"
            end
            test=test.." o="
            if mycar_old.veh then
             test=test..mycar_old.veh
            else
             test=test.."nil"
            end
            test=test.." r="
            if rentcar.veh then
             test=test..rentcar.veh
            else
             test=test.."nil"
            end
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
             test=test.." "..GetVehiclePedIsUsing(GetPlayerPed(-1))
            end
            SetNotificationTextEntry("STRING");
            AddTextComponentString(test)
            DrawNotification(false, false);
            Wait(1000)
            test="ent2n:m="
            if mycar.veh then
             test=test..NetworkGetNetworkIdFromEntity(mycar.veh)
            else
             test=test.."nil"
            end
            test=test.." o="
            if mycar_old.veh then
             test=test..NetworkGetNetworkIdFromEntity(mycar_old.veh)
            else
             test=test.."nil"
            end
            test=test.." r="
            if rentcar.veh then
             test=test..NetworkGetNetworkIdFromEntity(rentcar.veh)
            else
             test=test.."nil"
            end
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
             test=test.." "..NetworkGetNetworkIdFromEntity(GetVehiclePedIsUsing(GetPlayerPed(-1)))
            end
            SetNotificationTextEntry("STRING");
            AddTextComponentString(test)
            DrawNotification(false, false)
            Wait(1000)
            test="net2e:m="
            if mycar.net then
             test=test..NetworkGetEntityFromNetworkId(mycar.net)
            else
             test=test.."nil"
            end
            test=test.." o="
            if mycar_old.net then
             test=test..NetworkGetEntityFromNetworkId(mycar_old.net)
            else
             test=test.."nil"
            end
            test=test.." r="
            if rentcar.net then
             test=test..NetworkGetEntityFromNetworkId(rentcar.net)
            else
             test=test.."nil"
            end
            SetNotificationTextEntry("STRING");
            AddTextComponentString(test)
            DrawNotification(false, false);
            Wait(1000)
            test="netdb:m="
            if mycar.net then
             test=test..mycar.net
            else
             test=test.."nil"
            end
            test=test.." o="
            if mycar_old.net then
             test=test..mycar_old.net
            else
             test=test.."nil"
            end
            test=test.." r="
            if rentcar.net then
             test=test..rentcar.net
            else
             test=test.."nil"
            end
            SetNotificationTextEntry("STRING");
            AddTextComponentString(test)
            DrawNotification(false, false);
            Wait(1000)
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            SetNotificationTextEntry("STRING")
            AddTextComponentString("bhp="..GetVehicleBodyHealth(GetVehiclePedIsUsing(GetPlayerPed(-1))).." Your ID: "..PlayerId())
            DrawNotification(false, false)
            end
        end
    end
end)

-- RegisterNUICallback('chatResult', function(data, cb)
    -- if data.message:sub(1, 6) == '/debug' then
        -- debug_mode=~debug_mode
    -- end
-- end)

local function getvehhp(enginehp,bodyhp,tankhp,fuellevel)
    SendNUIMessage({
        enginehp = enginehp,
        bodyhp = bodyhp,
        tankhp = tankhp
    })
end

-- Citizen.CreateThread(function()
    -- while true do
        -- Citizen.Wait(10)
        -- local ped=GetPlayerPed(-1)
        -- if IsPedInAnyVehicle(ped, false) then
            -- local veh = GetVehiclePedIsUsing(ped)
            -- getvehhp(GetVehicleEngineHealth(veh),GetVehicleBodyHealth(veh),GetVehiclePetrolTankHealth(veh))
        -- else
            -- local health = GetEntityHealth(ped)
            -- getvehhp(0,health,0)
        -- end
    -- end
-- end)

local function setmoney(new)
    SendNUIMessage({
            showmoney = true,
			setmoney = new
	})
    --SetSingleplayerHudCash(new,0)
end

local function addmoney(new,change)
    SendNUIMessage({
            showmoney = true,
            setmoney = new,
			addcash = change
	})
end

local function removemoney(new,change)
    SendNUIMessage({
            showmoney = true,
			setmoney = new,
			removecash = change
	})
    -- SetNotificationTextEntry("STRING");
    -- AddTextComponentString("~r~-$"..v.cost)
    -- DrawNotification(false, false);
end
    
RegisterNetEvent(event.money)
AddEventHandler(event.money, function(money)
    --SetPedMoney(GetPlayerPed(-1), money);
      --SetNotificationTextEntry("STRING");
      if money==nil then money=0 end
      
      if player_money and money<player_money then
        removemoney(money,player_money-money)
     -- AddTextComponentString("~r~-$"..(player_money-money));
      else
        addmoney(money,money-player_money)
     -- AddTextComponentString("~g~+$"..(money-player_money));
      end
      player_money=money;
      --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, "Your money", "$"..player_money);
      --DrawNotification(false, false);
end)

Citizen.CreateThread(function()
Wait(5000)
    while true do
        while player_is_cop do Wait(5000) end
        if not money_drops[-1] then
            SetTextComponentFormat("STRING")
            AddTextComponentString("Press ~INPUT_VEH_ROOF~ to start ~g~heist~s~.")
            DisplayHelpTextFromStringLabel(0,0,1,-1)
            Wait(30000)
        else
            Wait(1000)
        end
        -- SetTextComponentFormat("STRING")
        -- AddTextComponentString("Money:\n~INPUT_REPLAY_START_STOP_RECORDING~ hide\n~INPUT_REPLAY_START_STOP_RECORDING_SECONDARY~ take")
        -- DisplayHelpTextFromStringLabel(0,0,1,-1)
        -- Wait(30000)
        -- SetTextComponentFormat("STRING")
        -- AddTextComponentString("~INPUT_REPLAY_START_STOP_RECORDING~ to hide money in any place.")
        -- DisplayHelpTextFromStringLabel(0,0,1,-1)
        -- Wait(30000)
        -- SetTextComponentFormat("STRING")
        -- AddTextComponentString("~INPUT_REPLAY_START_STOP_RECORDING_SECONDARY~ to take money from hideout.")
        -- DisplayHelpTextFromStringLabel(0,0,1,-1)
        -- Wait(30000)
    end
end)

-- Citizen.CreateThread(function()
    -- local show=false
    -- while true do
        -- if (money_drops[-1]~=nil) and show then
            -- show=nil
            -- SetTextComponentFormat("STRING")
            -- AddTextComponentString("Press ~INPUT_VEH_ROOF~ to start ~g~heist~s~.")
            -- DisplayHelpTextFromStringLabel(0,0,1,-1)
        -- elseif (money_drops[-1]==nil) and (not show) then
            -- show=true
            -- SetTextComponentFormat("STRING")
            -- AddTextComponentString("Press ~INPUT_VEH_ROOF~ to start ~g~heist~s~.")
            -- DisplayHelpTextFromStringLabel(0,0,1,-1)
        -- end
        -- Wait(1000)
    -- end
-- end)

RegisterNetEvent(event.startheist)
AddEventHandler(event.startheist, function(id,heist)
    money_drops[id]=heist;
    if money_blips[id]~=nil then
        SetBlipCoords(money_blips[id], heist.x, heist.y, heist.z)
    else
        money_blips[id]=AddBlipForCoord(heist.x, heist.y, heist.z)
    end
    SetBlipSprite(money_blips[id], heist.sprite) --heist.sprite
    SetBlipDisplay(money_blips[id], 2)
    SetBlipScale(money_blips[id], heist.bs)
    local wantcolors={[0]=4,[1]=2,[2]=2,[3]=46,[4]=51,[5]=1}
    SetBlipColour(money_blips[id], wantcolors[heist.wanted])
    --SetBlipAsShortRange(money_blips[id].blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(heist.name)
    EndTextCommandSetBlipName(money_blips[id])
    if id==-1 then
      SetNotificationTextEntry("STRING");
      AddTextComponentString(heist.name.." ~g~$"..heist.money.."~s~");
      --SetNotificationMessage("CHAR_LESTER", "CHAR_LESTER", false, 1, "Heist", "$"..heist.money);
      DrawNotification(false, false);
      --SetBlipRoute(money_blips[id], true)
      --SetBlipRouteColour(money_blips[id], wantcolors[heist.wanted])
    end
end)

RegisterNetEvent(event.stopheist)
AddEventHandler(event.stopheist, function(id)
    money_drops[id]=nil;
    if money_blips[id] then
        SetBlipSprite(money_blips[id], 406)
        SetBlipDisplay(money_blips[id], 2)
        -- if id==-1 then
            -- SetBlipRoute(money_blips[id], false)
        -- end
    end
end)

local function removeenemycorpse(milliseconds,ped)
    Wait(milliseconds)
    SetPedAsNoLongerNeeded(ped)
end

local function removefriendcorpse(milliseconds,ped)
    local name="Friend"
    SetNotificationTextEntry("STRING");
    AddTextComponentString(name.." ~r~died~s~.");
   -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
    DrawNotification(false, false);
    local coords=GetEntityCoords(ped)
    local blip=AddBlipForCoord(coords.x,coords.y,coords.z)
    SetBlipSprite(blip, 310)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name);
    EndTextCommandSetBlipName(blip)
    Wait(milliseconds)
    RemoveBlip(blip)
    SetPedAsNoLongerNeeded(ped)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(name.." corpse removed.");
    --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is BURRIED.");
    DrawNotification(false, false);
end

Citizen.CreateThread(function()
Wait(5000)
    while true do
        Wait(500)
        for key, v in pairs(friends) do
            if IsPedFatallyInjured(v) then
                Citizen.CreateThread(function() removefriendcorpse(120000,v) end)
                friends[key]=nil
            end
        end
        for key, v in pairs(enemies) do
            if IsPedFatallyInjured(v) then
                Citizen.CreateThread(function() removeenemycorpse(120000,v) end)
                enemies[key]=nil
            end
        end
        Wait(500)
        trytofixvehid(mycar)
        trytofixvehid(mycar_old)
        trytofixvehid(rentcar)
        if rentcar.veh and (GetVehicleEngineHealth(rentcar.veh)<-3999) then
            local name=GetDisplayNameFromVehicleModel(GetEntityModel(rentcar.veh))
            SetVehicleAsNoLongerNeeded(rentcar.veh)
            rentcar.veh=nil
            rentcar.net=nil
            forgetgps(rentcar)
            rentcar.plate=nil
            sendcarplates()
            SetNotificationTextEntry("STRING")
            AddTextComponentString("Rented ~r~"..name.."~s~ destroyed, shame on you!")
           -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
            DrawNotification(false, false);
        end
        if mycar.veh and (GetVehicleEngineHealth(mycar.veh)<-3999) then
            local name=GetDisplayNameFromVehicleModel(GetEntityModel(mycar.veh))
            SetVehicleAsNoLongerNeeded(mycar.veh)
            mycar.veh=nil
            mycar.net=nil
            forgetgps(mycar)
            mycar.plate=nil
            sendcarplates()
            SetNotificationTextEntry("STRING")
            AddTextComponentString("Your last bought vehicle(~r~"..name.."~s~) is destroyed.")
           -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
            DrawNotification(false, false);
        end
        if mycar_old.veh and (GetVehicleEngineHealth(mycar_old.veh)<-3999) then
            local name=GetDisplayNameFromVehicleModel(GetEntityModel(mycar_old.veh))
            SetVehicleAsNoLongerNeeded(mycar_old.veh)
            mycar_old.veh=nil
            mycar_old.net=nil
            forgetgps(mycar_old)
            mycar_old.plate=nil
            sendcarplates()
            SetNotificationTextEntry("STRING")
            AddTextComponentString("Your previously bought vehicle(~r~"..name.."~s~) is destroyed.")
           -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
            DrawNotification(false, false);
        end
    end
end)

local function spawnped(hash,x,y,z,weapon,pedlist)
   RequestModel(hash)
   while not HasModelLoaded(hash) do Wait(10) end
   local ped =  CreatePed(4, hash, x, y, z, 0.0, true, true)
   --SetBlockingOfNonTemporaryEvents(ped, true)
   SetPedCombatAttributes(ped, 0, true)
   SetPedCombatAttributes(ped, 1, true)
   SetPedCombatAttributes(ped, 2, true)
   SetPedCombatAttributes(ped, 3, true)
   SetPedCombatAttributes(ped, 46, true)
   SetPedCombatAttributes(ped, 1424, true)
   SetPedFleeAttributes(ped, 1, 0)
   SetPedFleeAttributes(ped, 2, 0)
   SetPedFleeAttributes(ped, 4, 0)
   SetPedFleeAttributes(ped, 8, 0)
   SetPedFleeAttributes(ped, 16, 0)
   SetPedFleeAttributes(ped, 32, 0)
   SetPedFleeAttributes(ped, 64, 0)
   SetDriverAbility(ped, 1.0);
   GiveWeaponToPed(ped, weapon, 1000, false, true)
   SetModelAsNoLongerNeeded(hash)
   table.insert(pedlist,ped)
   return ped
end

local function createpedgroup(x,y,z,n,skins,weapons,pedlist)
    local ped
    local group=CreateGroup()
    for i=1,n do
       ped=spawnped(skins[math.random(#skins)],x,y,z,weapons[math.random(#weapons)],pedlist)
       SetPedAsGroupMember(ped, group);
       SetPedAsEnemy(ped, true);
       SetPedRelationshipGroupHash(ped, relationship_enemy)
       TaskWanderInArea(ped,x,y,z,10.0,5.0,5.0)
       Wait(500)
    end
    SetPedAsGroupLeader(ped, group);
    SetGroupFormation(group, 1);
end

RegisterNetEvent(event.spawnpeds)
AddEventHandler(event.spawnpeds, function(x,y,z,n,skins,weapons)
       --GetHashKey( "g_m_y_famca_01") --a_c_mtlion" ) --"mp_m_shopkeep_01" )
    while n>8 do
       createpedgroup(x,y,z,8,skins,weapons,enemies)
       n=n-8
    end
    if n>1 then
       createpedgroup(x,y,z,n,skins,weapons,enemies)
    elseif n>0 then
       spawnped(skins[math.random(#skins)],x,y,z,weapons[math.random(#weapons)],enemies)
       SetPedAsEnemy(ped, true);
       SetPedRelationshipGroupHash(ped, relationship_enemy)
    end
    --int GET_PLAYER_GROUP(Player player);
    --SET_PED_AS_GROUP_LEADER(ped, groupId);
    --SET_PED_CAN_TELEPORT_TO_GROUP_LEADER(Ped pedHandle, int groupHandle, BOOL toggle);
    --void SET_PED_NEVER_LEAVES_GROUP(Ped ped, BOOL toggle);
    --void SET_PED_DEFENSIVE_AREA_DIRECTION(Ped ped, float p1, float p2, float p3, BOOL p4);
    --Hash GET_PED_RELATIONSHIP_GROUP_DEFAULT_HASH(Ped ped);
    --void SET_PED_RELATIONSHIP_GROUP_DEFAULT_HASH(Ped ped, Hash hash);
    --Ped GET_PED_AS_GROUP_MEMBER(int groupID, int memberNumber);
    --BOOL IS_PED_IN_GROUP(Ped ped);
    --BOOL IS_PED_GROUP_MEMBER(Ped ped, int groupId);
    --Ped _GET_PED_AS_GROUP_LEADER(int groupID);
    --BOOL DOES_GROUP_EXIST(int groupId);
    --void GET_GROUP_SIZE(int groupID, Any* unknown, int* sizeInMembers); p1 may be a BOOL representing whether or not the group even exists
    --void REMOVE_GROUP(int groupId);
    --void REMOVE_PED_FROM_GROUP(Ped ped);
    --int CREATE_GROUP(int unused); Groups can contain up to 8 peds.
    --void CLEAR_RELATIONSHIP_BETWEEN_GROUPS(int relationship, Hash group1, Hash group2); This should be called twice (once for each group).
    --int GET_RELATIONSHIP_BETWEEN_GROUPS(Hash group1, Hash group2);
    --void SET_RELATIONSHIP_BETWEEN_GROUPS(int relationship, Hash group1, Hash group2);
    -- 0 = Companion
    -- 1 = Respect
    -- 2 = Like
    -- 3 = Neutral
    -- 4 = Dislike
    -- 5 = Hate
    -- 255 = Pedestrians
    --void SET_PED_AS_GROUP_MEMBER(Ped ped, int groupId);
    --int GET_PED_GROUP_INDEX(Ped ped);
    --Any ADD_RELATIONSHIP_GROUP(char* name, Hash* groupHash);
    --void REMOVE_PED_ELEGANTLY(Ped* ped);
    --void REMOVE_RELATIONSHIP_GROUP(Hash groupHash);
    --void SET_PED_RELATIONSHIP_GROUP_HASH(Ped ped, Hash hash);
    --void SET_GROUP_FORMATION(int groupId, int formationType);
    --Hash GET_PED_RELATIONSHIP_GROUP_HASH(Ped ped);
    --int GET_RELATIONSHIP_BETWEEN_PEDS(Ped ped1, Ped ped2);
    
    --void SET_ENTITY_ONLY_DAMAGED_BY_RELATIONSHIP_GROUP(Entity entity, BOOL p1, Any p2);
    --void SET_ENTITY_CAN_BE_DAMAGED_BY_RELATIONSHIP_GROUP(Entity entity, BOOL bCanBeDamaged, int relGroup);
end)

-- Citizen.CreateThread(function()
    -- while true do
      -- Wait(500)
      -- if #friends>0 then
        -- local player = PlayerPedId()
        -- if IsPedInAnyVehicle(player, false) then
          -- local myveh=GetVehiclePedIsUsing(player)
          -- local maxpas=0
          -- local free=Citizen.InvokeNative(0x2D34FC3BC4ADB780,veh);
          -- if not free then
            -- local style=6 --1+4+16+32+4194304
            -- local idiots=0
            -- local lost={}
            -- for key, v in pairs(friends) do
              -- if not IsPedInAnyVehicle(v,false) then
                -- lost[key]=v
                -- idiots=idiots+1
              -- end
            -- end
            -- local banned={}
            -- banned[myveh]=myveh
            -- local veh=nil
            -- while idiots>0 do
                -- for key, v in pairs(lost) do
                  -- if IsPedInAnyVehicle(v,false) then
                    -- lost[key]=nil
                    -- idiots=idiots-1
                  -- else
                    -- if not veh then
                      -- local p=GetEntityCoords(v)
                      -- veh=GetClosestVehicle(p.x,p.y,p.z,20.0,0,4)
                      -- if banned[veh]==nil then
                        -- TaskEnterVehicle(v,veh,5000,-1,2.0,1,0)
                        -- TaskVehicleEscort(v,veh,myveh,-1,50.0,style,5.0, 0, 20.0)
                        -- maxpas=GetVehicleMaxNumberOfPassengers(veh)
                        -- lost[key]=nil
                        -- idiots=idiots-1
                        -- p=GetEntityCoords(veh)
                        -- DrawMarker(2, p.x, p.y, p.z-.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 255, 0, 64, false, true, 2, false, false, false, false)
                      -- else
                        -- veh=nil
                      -- end
                    -- elseif maxpas>0 then
                        -- TaskEnterVehicle(v,veh,5000,0,2.0,1,0)
                        -- maxpas=maxpas-1
                        -- lost[key]=nil
                        -- idiots=idiots-1
                    -- else
                        -- banned[veh]=veh
                        -- veh=nil
                    -- end
                  -- end
                -- end
                -- if idiots>0 then
                  -- SetNotificationTextEntry("STRING");
                  -- AddTextComponentString(idiots.." friends didnt find a seat.");
                  -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, "Shame on", "you idiots!");
                  -- DrawNotification(false, false);
                  -- Wait(5000)
                -- end
            -- end
          -- end
        -- end
      -- end
    -- end
-- end)

Citizen.CreateThread(function()
    Wait(5000)
    --DisplayCash(false)
    TriggerServerEvent(event.connected)
    ReserveNetworkMissionVehicles(4)
    Wait(3000)
    TriggerEvent('fragile-alliance:playerspawn',ped)
    SetNotificationTextEntry("STRING");
    AddTextComponentString("PvP is on, don't trust anyone. You can cooperate or betray players. Type ~g~/heist~s~ to start.");
    DrawNotification(false, false);
    Wait(5000)
    SetNotificationTextEntry("STRING");
    AddTextComponentString("When you die - you loose everything, don't be greedy. Good luck.");
    DrawNotification(false, false);
    for i=1,3 do
        Wait(5000)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~b~discord.gg/VZG5Nvk~s~");
        DrawNotification(false, false);
    end
end)

Citizen.CreateThread(function()
Wait(5000)
 local maxx=8000.0-10
 local maxy=9000.0-10
 local minx=-8000.0+10
 local miny=-8000.0+10
 local repair=0
 while true do
  Wait(50)
  local player=PlayerId()
  local ped=GetPlayerPed(-1)
  local teleport=false
  local v3=GetEntityCoords(ped)
  local pos={x=v3.x,y=v3.y,z=v3.z}
  if pos.x>maxx then
   pos.x=(pos.x+minx-maxx)
   teleport=true
  elseif pos.x<minx then
   pos.x=(pos.x+maxx-minx)
   teleport=true
  end
  if pos.y>maxy then
   pos.y=(pos.y+miny-maxy)
   teleport=true
  elseif pos.y<miny then
   pos.y=(pos.y+maxy-miny)
   teleport=true
  end
  if teleport then
   if GetPlayerWantedLevel(player)>0 then
    SetPlayerWantedLevel(player, 0, false);
    SetPlayerWantedLevelNow(player, false);
    player_wanted=0
    TriggerServerEvent(event.wanted, 0)
   end
   if IsPedInAnyVehicle(ped) then
    local veh=GetVehiclePedIsUsing(ped)
    local vel=GetEntityVelocity(veh)
    local engine = GetVehicleEngineHealth(veh)
    SetPedCoordsKeepVehicle(ped,pos.x,pos.y,pos.z)
    if engine<1000 then
     SetVehicleEngineHealth(veh,1000.0)
     SetVehicleFixed(veh)
     repair=repair+1
     SetNotificationTextEntry("STRING");
     AddTextComponentString("Vehicle repaired "..repair.." times");
     DrawNotification(false, false);
    end
    SetEntityVelocity(veh,vel.x,vel.y,vel.z)
   else
    SetPedCoordsKeepVehicle(ped,pos.x,pos.y,pos.z)
   end
  elseif player_wanted==5 then
   if isDead then
    SetPlayerWantedLevel(player, 0, false)
    SetPlayerWantedLevelNow(player, false)
    TriggerServerEvent(event.wanted,0)
    player_wanted=0
   elseif GetPlayerWantedLevel(player)~=5 then
    SetPlayerWantedLevel(player, 5, false)
    SetPlayerWantedLevelNow(player, false)
   end
   TriggerServerEvent(event.pos, pos)
  else
   local wanted_now=GetPlayerWantedLevel(player)
   if wanted_now~=player_wanted then
    player_wanted=wanted_now
    --if wanted_now==5 then
     --SetPlayerWantedLevelNoDrop(player, 5, false);
    --end
    TriggerServerEvent(event.wanted, wanted_now)
   end
  end
 end
end)

RegisterNetEvent(event.top)
AddEventHandler(event.top, function(data)
    --local top="test<br>test"
    local i=1
    while true do
        local maximum=0
        local key
        for k,v in pairs(data) do
         if v.money>maximum then
          maximum=v.money
          key=k
         end
        end
        if maximum>0 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString(i..". ~g~$"..maximum.." ~s~"..data[key].name)
            DrawNotification(false, false)
            data[key]=nil
            Wait(50)
            i=i+1
        else
            break
        end
    end
    --SendNUIMessage({top_players='test'})
end)

Citizen.CreateThread(function()
Wait(5000)
    while true do 
        Citizen.Wait(5000)
        if player_wanted == 5 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("~r~You have 5 wanted level! Leave Los-Santos to loose it.")
            DrawNotification(false, false);
        end
        Citizen.Wait(5000)
        if player_wanted == 5 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("~r~If you would leave server - all your current money would be dropped.")
            DrawNotification(false, false);
        end 
    end
end)

Citizen.CreateThread(function()
Wait(5000)
    local hasBeenDead = false
	local diedAt

    while true do
        Wait(0)

        local player = PlayerId()

        if NetworkIsPlayerActive(player) then
            local ped = PlayerPedId()

            if IsPedFatallyInjured(ped) and not isDead then
                isDead = true
                if not diedAt then
                	diedAt = GetGameTimer()
                end
                --ondeath1 vvv
                removemoney(0,player_money)
                player_money=0
                local repack={}
                repack.x=pos.x
                repack.y=pos.y
                repack.z=pos.z
                TriggerEvent(event.playerdied,repack)
                TriggerServerEvent(event.playerdied,repack)
                --ondeath1 ^^^
                hasBeenDead = true
            elseif not IsPedFatallyInjured(ped) then
                if isDead then --onspawn1 vvv
                  TriggerEvent('fragile-alliance:playerspawn',ped)
                  SetNotificationTextEntry("STRING");
                  AddTextComponentString("You lost everything, but you can pick up your money back; search ~g~green skull~s~ icon on map.");
                  --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, "Respawned", "PVP IS NOW ON");
                  DrawNotification(false, false);
                end --onspawn1 ^^^
                isDead = false
                diedAt = nil
            end

            -- check if the player has to respawn in order to trigger an event
            if not hasBeenDead and diedAt ~= nil and diedAt > 0 then
                --ondeath2 vvv
                removemoney(0,player_money)
                player_money=0
                local repack={}
                repack.x=pos.x
                repack.y=pos.y
                repack.z=pos.z
                TriggerEvent(event.wasted, repack)
                TriggerServerEvent(event.wasted, repack)
                --ondeath2 ^^^
                hasBeenDead = true
            elseif hasBeenDead and diedAt ~= nil and diedAt <= 0 then
                --onspawn2 vvv
                TriggerEvent('fragile-alliance:playerspawn',ped)
                SetNotificationTextEntry("STRING");
                AddTextComponentString("respawn2");
                SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, "test", "message");
                DrawNotification(false, false);
                --onspawn2 ^^^
                hasBeenDead = false
            end
            
            -- local wanted_now=GetPlayerWantedLevel(player)
            -- if wanted_now~=player_wanted then
                -- player_wanted=wanted_now
                -- TriggerServerEvent(event.wanted, wanted_now)
            -- end
        end
    end
end)

RegisterNetEvent(event.wanted)
AddEventHandler(event.wanted,function(level)
    local player=PlayerId()
    if GetPlayerWantedLevel(player)<level then
        SetPlayerWantedLevel(player,level,false)
        SetPlayerWantedLevelNow(player,false)
    end
end)

--Hash GET_SELECTED_PED_WEAPON(Ped ped);
--GET_CURRENT_PED_WEAPON(Ped ped, Hash* weaponHash, BOOL p2);
--SET_CURRENT_PED_WEAPON(Ped ped, Hash weaponHash, BOOL equipNow);
--GET_PED_WEAPONTYPE_IN_SLOT(Ped ped, Hash weaponSlot);
--GET_PED_AMMO_BY_TYPE(Ped ped, Any ammoType);
--GET_PED_AMMO_TYPE_FROM_WEAPON(Ped ped, Hash weaponHash);

AddEventHandler("fragile-alliance:playerspawn",function(ped)
    --local ped = PlayerPedId()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(ped, true, false)
    local melee={KNIFE,NIGHTSTICK,HAMMER,BAT,GOLFCLUB,CROWBAR,BOTTLE,DAGGER,KNUCKLE,HATCHET,MACHETE,SWITCHBLADE,BATTLEAXE,POOLCUE,WRENCH}
    local guns={MUSKET,MARKSMANPISTOL,SNSPISTOL,VINTAGEPISTOL,DBSHOTGUN}
    local ammo={    15,            15,       42,           35,       16}
    local i=math.random(#guns)
    GiveWeaponToPed(ped, guns[i], ammo[i], false, true)
    i=math.random(#melee)
    GiveWeaponToPed(ped, melee[i], 0, false, true)
end)

-- AddEventHandler("fragile-alliance:playerwasted",function(pos)
    -- player_money=0
    -- TriggerServerEvent('fragile-alliance:drop_money',pos)
-- end)
-- AddEventHandler(event.playerdied,function(pos)
    -- player_money=0
    -- TriggerServerEvent('fragile-alliance:drop_money',pos)
-- end)

Citizen.CreateThread(function()
Wait(5000)
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for key, v in pairs(money_drops) do
            if v then
                local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
                if square<100 then
                    local r_color=51*v.wanted
                    local g_color=255-r_color
                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.r, v.r, 1.0, r_color, g_color, 0, 128, false, true, 2, false, false, false, false)
                    if v.wanted>GetPlayerWantedLevel(PlayerId()) then
                        SetPlayerWantedLevel(PlayerId(), v.wanted, false)
                        SetPlayerWantedLevelNow(PlayerId(),false)
                    end
                    if square<9 and not isDead then
                        TriggerServerEvent('fragile-alliance:take_money',key)
                        local delay=200
                        if player_is_cop then
                            delay=700
                        end
                        for i=delay,1,-1 do
                            Wait(10)
                            DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.r, v.r, 1.0, r_color, g_color, 0, 32, false, true, 2, false, false, false, false)
                        end
                        pos=GetEntityCoords(GetPlayerPed(-1))
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
Wait(5000)
  while true do
    while player_is_cop do
        if IsControlPressed(0,101) or IsControlPressed(0,288) or IsControlPressed(0,289) then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Cops can't find or make money stashes or start heists.")
            DrawNotification(false, false);
            Wait(5000)
        else
            Wait(0)
        end
    end
    if IsControlPressed(0,101) then
        TriggerServerEvent(event.startheist)
        Wait(500)
    elseif IsControlPressed(0,288) then
        if player_money==nil or player_money<10000 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("You need at least $10000 to hide money.")
            DrawNotification(false, false);
        end
        pos=GetEntityCoords(GetPlayerPed(-1))
        local x,y,z=math.floor(pos.x),math.floor(pos.y),math.floor(pos.z)
        TriggerServerEvent(event.stash_hide,x,y,z)
        for i=1,100 do
            DrawBox(x-.0,y-.0,z-.0,x+1.0,y+1.0,z+1.0,255,255,255,64)
            Wait(10)
        end
    elseif IsControlPressed(0,289) then
        pos=GetEntityCoords(GetPlayerPed(-1))
        local x,y,z=math.floor(pos.x),math.floor(pos.y),math.floor(pos.z)
        TriggerServerEvent(event.stash_take,x,y,z)
        for i=1,100 do
            DrawBox(x-.0,y-.0,z-.0,x+1.0,y+1.0,z+1.0,255,255,255,64)
            Wait(10)
        end
    else
        Wait(0)
    end
  end
end)

local function createcar(hash,x,y,z,angle)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(10) end
    local car=CreateVehicle(hash,x,y,z,angle,true,false)
    SetModelAsNoLongerNeeded(hash)
    return car
end

local function createmycar(hash,x,y,z,angle)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(10) end
    if mycar.plate and mycar_old.plate then
     if mycar_old.plate then
      abandoncar(mycar_old)
     end
     mycar_old.veh=mycar.veh
     mycar_old.net=mycar.net
     --forgetgps(mycar_old)
     rotategps(mycar,mycar_old)
     mycar_old.plate=mycar.plate
    end
    mycar.veh=CreateVehicle(hash,x,y,z,angle,true,false)
    SetModelAsNoLongerNeeded(hash)
    local carblip=AddBlipForEntity(mycar.veh)
    SetBlipSprite(carblip, 326)
    SetBlipDisplay(carblip, 2)
    SetBlipScale(carblip, 0.6)
    SetBlipColour(carblip, 3)
    mycar.net=networkingshit(mycar.veh)
    mycar.plate=GetVehicleNumberPlateText(mycar.veh)
    sendcarplates()
    return mycar.veh
end

local returnwindowflags=0

local function savecar(veh)
    local car={}
    car.wanted=1
    if veh==mycar.veh then
     mycar.veh=nil
     mycar.net=nil
     forgetgps(mycar)
     mycar.plate=nil
     car.wanted=0
     sendcarplates()
    end
    if veh==mycar_old.veh then
     mycar_old.veh=nil
     mycar_old.net=nil
     forgetgps(mycar_old)
     mycar_old.plate=nil
     car.wanted=0
     sendcarplates()
    end
    if veh==rentcar.veh then
     rentcar.veh=nil
     rentcar.net=nil
     forgetgps(rentcar)
     rentcar.plate=nil
     sendcarplates()
    end
    car.hash=GetEntityModel(veh)
    car.body=GetVehicleBodyHealth(veh)
    car.engine=GetVehicleEngineHealth(veh)
    car.tank=GetVehiclePetrolTankHealth(veh)
    car.color1,car.color2=GetVehicleColours(veh)
    local flags=0
    local f=1
    returnwindowflags=0
    for i=0,26 do
     Citizen.CreateThread(function()
      if not IsVehicleWindowIntact(veh, i) then
       returnwindowflags=returnwindowflags+f
      end
     end)
     f=f+f
    end
    Wait(100)
    flags=returnwindowflags
    car.windows=flags
    flags=0
    if IsVehicleTyreBurst(veh, 0, false) then flags=flags+1 end
    if IsVehicleTyreBurst(veh, 1, false) then flags=flags+2 end
    if IsVehicleTyreBurst(veh, 2, false) then flags=flags+4 end
    if IsVehicleTyreBurst(veh, 3, false) then flags=flags+8 end
    if IsVehicleTyreBurst(veh, 4, false) then flags=flags+16 end
    if IsVehicleTyreBurst(veh, 5, false) then flags=flags+32 end
    if IsVehicleTyreBurst(veh, 6, false) then flags=flags+64 end
    if IsVehicleTyreBurst(veh, 7, false) then flags=flags+128 end
    if IsVehicleTyreBurst(veh, 45, false) then flags=flags+256 end
    if IsVehicleTyreBurst(veh, 47, false) then flags=flags+512 end
    f=1024
    for i=0,6 do
     if IsVehicleDoorDamaged(veh,i) then
      flags=flags+f
     end
     f=f+f
    end
    car.tyresdoors=flags
    SetEntityAsMissionEntity(veh,true,true)
    DeleteVehicle(veh)
    return car
end

local function loadcar(x,y,z,angle,car)
    local veh
    if car.wanted>0 then
     veh=createcar(car.hash,x,y,z,angle)
    else
     veh=createmycar(car.hash,x,y,z,angle)
    end
    SetVehicleBodyHealth(veh, car.body)
    SetVehicleEngineHealth(veh, car.engine)
    SetVehiclePetrolTankHealth(veh, car.tank)
    SetVehicleColours(veh,car.color1,car.color2)
    local flags=tonumber(car.windows)
    local f=1
    for i=0,26 do
     if (flags&f)==f then
      Citizen.CreateThread(function()
       SmashVehicleWindow(veh, i)
      end)
     end
     f=f+f
    end
    flags=tonumber(car.tyresdoors)
    if (flags&1)==1 then SetVehicleTyreBurst(veh, 0, false, 1000.0) end
    if (flags&2)==2 then SetVehicleTyreBurst(veh, 1, false, 1000.0) end
    if (flags&4)==4 then SetVehicleTyreBurst(veh, 2, false, 1000.0) end
    if (flags&8)==8 then SetVehicleTyreBurst(veh, 3, false, 1000.0) end
    if (flags&16)==16 then SetVehicleTyreBurst(veh, 4, false, 1000.0) end
    if (flags&32)==32 then SetVehicleTyreBurst(veh, 5, false, 1000.0) end
    if (flags&64)==64 then SetVehicleTyreBurst(veh, 6, false, 1000.0) end
    if (flags&128)==128 then SetVehicleTyreBurst(veh, 7, false, 1000.0) end
    if (flags&256)==256 then SetVehicleTyreBurst(veh, 45, false, 1000.0) end
    if (flags&512)==512 then SetVehicleTyreBurst(veh, 47, false, 1000.0) end
    f=1024
    for i=0,6 do
     if (flags&f)==f then
      SetVehicleDoorBroken(veh,i,true)
     end
     f=f+f
    end
    if car.wanted>0 then
     SetVehicleAsNoLongerNeeded(veh)
    end
    return veh
end

local function makeblips(shops)
    for k,v in pairs(shops) do
        local blip
        if not v.blip then
            blip=AddBlipForCoord(v.x,v.y,v.z)
        else
            blip=v.blip
        end
        SetBlipSprite(blip, v.sprite)
        SetBlipDisplay(blip, 2)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, v.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
        v.blip=blip
    end
end

local function showblips(shops)
    for k,v in pairs(shops) do
        SetBlipSprite(v.blip, v.sprite)
        SetBlipColour(v.blip, v.color)
        SetBlipDisplay(v.blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(v.blip)
    end
end

local function hideblips(shops)
    for k,v in pairs(shops) do
        SetBlipSprite(v.blip, 406)
        SetBlipDisplay(v.blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("")
        EndTextCommandSetBlipName(v.blip)
    end
end

local criminal_weaponshops={
[1]={x=35.239,y=-1459.373,z=29.3116,name="Free pistol",sprite=156,color=0,cost=0,weapon={VINTAGEPISTOL},
                                                                                   ammo={           7}},
[2]={x=485.409,y=-1529.096,z=29.2950,name="Pistol shop",sprite=156,color=2,cost=500,weapon={COMBATPISTOL},
                                                                                   ammo={             72}},
[3]={x=49.747,y=-1453.323,z=29.3116,name="Free shotgun",sprite=158,color=0,cost=0,weapon={DBSHOTGUN},
                                                                                   ammo={         2}},
[4]={x=-2203.245,y=4245.414,z=47.9707,name="Automatic shotguns shop",sprite=158,color=1,cost=3350,weapon={ASSAULTSHOTGUN,HEAVYSHOTGUN,AUTOSHOTGUN},
                                                                                                        ammo={        16,          18,         20}},   
[5]={x=350.215,y=-995.235,z=29.4194,name="Revolver shop",sprite=156,color=2,cost=650,weapon={REVOLVER},
                                                                                  ammo={       60}},
[6]={x=709.479,y=-886.535,z=23.3898,name="Free pistol",sprite=156,color=0,cost=0,weapon={SNSPISTOL},
                                                                                   ammo={        6}},
[7]={x=896.422,y=-1035.682,z=35.1090,name="Free pistol",sprite=156,color=0,cost=0,weapon={MARKSMANPISTOL},
                                                                                        ammo={        1}},
[8]={x=-794.145,y=-726.691,z=27.2788,name="Free shotgun",sprite=158,color=0,cost=0,weapon={MUSKET},
                                                                                  ammo={        3}},
[9]={x=-1382.847,y=-640.499,z=28.6733,name="Shotguns shop",sprite=158,color=2,cost=1200,weapon={BULLPUPSHOTGUN},
                                                                                               ammo={       40}},
[10]={x=-683.299,y=-172.938,z=37.8213,name="PDWs shop",sprite=159,color=2,cost=1300,weapon={MINISMG},
                                                                                     ammo={     100}}, 
[11]={x=-1502.926,y=130.437,z=55.6528,name="Assault shop",sprite=150,color=1,cost=3500,weapon={SMG,ASSAULTRIFLE},
                                                                                   ammo={      150,         150}},
[12]={x=-425.912,y=535.400,z=122.2750,name="Automatic snipers shop",sprite=150,color=1,cost=5000,weapon={MARKSMANRIFLE},
                                                                                                              ammo={36}},
[13]={x=189.880,y=308.841,z=105.390,name="Snipers shop",sprite=160,color=2,cost=3000,weapon={SNIPERRIFLE},
                                                                                                ammo={45}},  
[14]={x=218.93112182617,y=-6.5031986236572,z=73.833969116211,name="Machine pistol shop",sprite=159,color=2,cost=1800,weapon={MACHINEPISTOL},
                                                                                                                              ammo={72}}, 
[15]={x=223.21469116211,y=-7.9395785331726,z=73.768821716309,name="Assault rifle shop",sprite=150,color=2,cost=4000,weapon={BULLPUPRIFLE},
                                                                                                                              ammo={60}}, 
[16]={x=230.89967346191,y=-10.898548126221,z=73.775741577148,name="Pipe bomb shop",sprite=152,color=2,cost=850,weapon={PIPEBOMB},
                                                                                                                       ammo={1}},
[17]={x=260.4328918457,y=-15.770009040833,z=73.676902770996,name="Automatic pistol shop",sprite=159,color=1,cost=2500,weapon={APPISTOL},
                                                                                                                              ammo={36}},
[18]={x=-718.22180175781,y=-1119.5183105469,z=10.652349472046,name="Grenade shop",sprite=152,color=2,cost=500,weapon={GRENADE},
                                                                                                                     ammo={1}},
[19]={x=-723.23449707031,y=-1112.4810791016,z=10.652400970459,name="RPG shop",sprite=157,color=2,cost=5000,weapon={RPG},
                                                                                                                ammo={1}},
[20]={x=239.01609802246,y=-14.013869285583,z=73.715599060059,name="Pistol shop",sprite=156,color=1,cost=2000,weapon={PISTOL50},
                                                                                                                     ammo={36}},
[21]={x=1002.2705078125,y=-2160.6635742188,z=30.551578521729,name="Hunting shotgun shop",sprite=158,color=1,cost=1000,weapon={HEAVYSHOTGUN},
                                                                                                                                  ammo={36}},
[22]={x=1013.5016479492,y=-2150.90234375,z=31.533716201782,name="Machinegun shop",sprite=173,color=2,cost=4200,weapon={MG},
                                                                                                                ammo={108}},
[23]={x=257.08120727539,y=-1981.6202392578,z=21.430465698242,name="Free grenade",sprite=152,color=0,cost=0,weapon={MOLOTOV},
                                                                                                                   ammo={1}},
[24]={x=268.04974365234,y=-1979.8137207031,z=21.466508865356,name="Free pistol",sprite=156,color=0,cost=0,weapon={SNSPISTOL},
                                                                                                            ammo={        6}},
[25]={x=-325.39294433594,y=-1348.5595703125,z=31.349042892456,name="Shotgun shop",sprite=158,color=2,cost=900,weapon={SAWNOFFSHOTGUN},
                                                                                                                    ammo={       40}},
[26]={x=-324.84808349609,y=-1356.3480224609,z=31.295696258545,name="Pistol shop",sprite=156,color=2,cost=300,weapon={PISTOL},
                                                                                                               ammo={    60}}
}
local fbi_weaponshops={
{x=452.3713684082,y=-980.02044677734,z=30.689594268799,fbi=true,name="Free FBI pistol",sprite=156,color=3,cost=0,weapon={HEAVYPISTOL},
                                                                                                                       ammo={         36}}
}
local weaponshops=criminal_weaponshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_weaponshops)
    makeblips(fbi_weaponshops)
    hideblips(fbi_weaponshops)
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(weaponshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 255, 255, 255, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        if player_money>=v.cost then
                            local ped=GetPlayerPed(-1)
                            local i=math.random(#v.weapon)
                            GiveWeaponToPed(ped, v.weapon[i], v.ammo[i], false, true)
                            player_money=player_money-v.cost
                            removemoney(player_money,v.cost)
                            TriggerServerEvent(event.buy,v.cost)
                            for i=1,50 do
                                Wait(10)
                                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 255, 255, 255, 128, false, true, 2, false, false, false, false)
                            end
                            pos=GetEntityCoords(GetPlayerPed(-1))
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to buy weapon.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local criminal_armorshops={
{x=29.81608581543,y=-1019.036315918,z=29.435953140259,name="Armor shop",color=3,sprite=175,cost=1000},
{x=225.98530578613,y=-9.1169500350952,z=73.777046203613,name="Armor shop",color=3,sprite=175,cost=1400},
{x=1004.0308837891,y=-2140.5986328125,z=30.551580429077,name="Armor shop",color=3,sprite=175,cost=1200}
}
local fbi_armorshops={
}
local armorshops=criminal_armorshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_armorshops)
    makeblips(fbi_armorshops)
    hideblips(fbi_armorshops)
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(armorshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 255, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        if player_money>=v.cost then
                            local ped=GetPlayerPed(-1)
                            if GetPedArmour(ped)<100 then
                                SetPedArmour(ped, 100);
                                player_money=player_money-v.cost
                                removemoney(player_money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                SetBlipColour(v.blip, 20)
                                for i=1,500 do
                                    Wait(10)
                                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                end
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(GetPlayerPed(-1))
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to buy armor.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local criminal_medics={
{x=253.44336,y=-1808.50635,z=27.113144,name="Medic",color=23,sprite=153,cost=1000},
{x=245.78915,y=-16.6738986,z=73.757812,name="Medic",color=23,sprite=153,cost=1500},
{x=1003.4803466797,y=-2143.5036621094,z=30.551580429077,name="Medic",color=23,sprite=153,cost=1150}
}
local fbi_medics={
{x=470.98806762695,y=-984.88824462891,z=30.689607620239,name="Medic",color=3,sprite=153,cost=0}
}
local medics=criminal_medics

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_medics)
    makeblips(fbi_medics)
    hideblips(fbi_medics)
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(medics) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        if player_money>=v.cost then
                            local ped=GetPlayerPed(-1)
                            local maxhealth=GetPedMaxHealth(ped)
                            if GetEntityHealth(ped)<maxhealth then
                                SetEntityHealth(ped,maxhealth);
                                player_money=player_money-v.cost
                                removemoney(player_money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                SetBlipColour(v.blip, 20)
                                for i=1,500 do
                                    Wait(10)
                                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                end
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(GetPlayerPed(-1))
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to heal.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local clothes={
{x=71.19051361084,y=-1387.8325195313,z=29.376081466675,name="Change clothes",color=3,sprite=366},
{x=64.321250915527,y=-80.226173400879,z=62.507694244385,name="Change clothes",color=3,sprite=366},
{x=-613.09985351563,y=-599.75042724609,z=29.880842208862,name="Change clothes",color=3,sprite=366},
{x=268.81893920898,y=-1985.9591064453,z=20.413900375366,name="Change clothes",color=3,sprite=366},
{x=895.34643554688,y=-896.27484130859,z=27.791017532349,name="Change clothes",color=3,sprite=366}
}

Citizen.CreateThread(function()
Wait(5000)
    makeblips(clothes)
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(clothes) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 255, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        local ped=GetPlayerPed(-1)
                        SetPedRandomComponentVariation(ped, false)
                        if GetPlayerWantedLevel(PlayerId())<3 then
                                SetPlayerWantedLevel((PlayerId()),0,false)
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You have changed your clothes and cops now ~b~doesn't recognize ~s~you.")
                                DrawNotification(false, false);
                        else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You have too ~r~high wanted level~s~, you can't change your close to loose cops.")
                                DrawNotification(false, false);
                        end
                        
                        --SetPlayerModel(PlayerId(),GetEntityModel(ped));
                        --SetPedComponentVariation(PlayerId(), 0-11, int drawableId, int textureId, int paletteId) 
                        --GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(playerPed, PED_VARIATION_FACE)
                        --GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(playerPed, PED_VARIATION_FACE, 0), 2);
                        --int GET_PED_PALETTE_VARIATION(Ped ped, int componentId)
                        Wait(100)
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("Press ~INPUT_VEH_HORN~ to change clothes.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)


local fbi_skinshops={
{x=459.09851074219,y=-992.99127197266,z=30.689598083496,sprite=366,color=3,name="Change clothes",models={2072724299}}
}
local criminal_skinshops={{x=-21.047414779663,y=-215.00874328613,z=46.176471710205,name="Change skin",color=3,sprite=362,models={-781039234,1567728751,1644266841,-252946718,
-198252413,588969535,361513884,599294057,-1022961931,-1868718465,-442429178,797459875,2014052797,1380197501,1250841910,189425762,808859815,-945854168,
1077785853,-2077764712,-771835772,2021631368,600300561,-408329255,2114544056,-900269486,-994634286,1464257942,-1113448868,-1106743555,1146800212,
1423699487,1982350912,-1606864033,1546450936,1068876755,1720428295,549978415,920595805,1984382277,-96953009,848542878,-933295480,1004114196,-1613485779,
933205398,1633872967,-1954728090,-654717625,-1697435671,664399832,2120901815,-912318012,532905404,826475330,-1280051738,-1366884940,-1589423867,-1211756494,
-1382092357,-2063996617,1975732938,-1932625649,-907676309,261586155,-1176698112,275618457,2119136831,-9308122,-1463670378,610290475,1825562762,-1660909656,
-429715051,436345731,-1230338610,-673538407,-973145378,755956971,-37334073,1182012905,365775923,-459818001,-321892375,1952555184,-1688898956,-12678997,
349680864,-2039072303,-730659924,-1674727288,579932932,1699403886,766375082,-628553422,-872673803,1976765073,-175076858,-1656894598,-173013091,-106498753,
-1538846349,1674107025,70821038,131961260,377976310,1371553700,712602007,1755064960,2010389054,-1434255461,1161072059,-795819184,-398748745,866411749,
-613248456,-2077218039,1309468115,-1806291497,-88831029,1641152947,951767867,373000027,728636342,1189322339,1165780219,331645324,-1313761614,466359675,
-2078561997,-294281201,-1453933154,1240094341,-775102410,-1519253631,115168927,330231874,793439294,1640504453,-1386944600,-1736970383,891398354,411102470,
1169888870,2111372120,-1444213182,-685776591,-1001079621,815693290,-20018299,-396800478,-961242577,-1289578670,-1715797768,1099825042,1704428387,1809430156,
-512913663,813893651,1358380044,1822107721,2064532783,-264140789,343259175,2097407511,-2109222095,587703123,-1745486195,349505262,-1514497514,1312913862,
429425116,42647445,348382215,51789996,-1768198658,-837606178,-1160266880,153984193,-573920724,706935758,225287241,-1452549652,2050158196,-835930287,
767028979,-254493138,257763003,-422822692,-308279251,1459905209,-1105179493,-518348876,2040438510,-619494093,-1849016788,1530648845,891945583,611648169,
-1880237687,2093736314,1388848350,1204772502,-782401935,355916122,452351020,1090617681,696250687,1706635382,-1635724594,321657486,-538688539,1302784073,
1401530684,-570394627,666718676,-610530921,-44746786,1330042375,1032073858,850468060,1985653476,-52653814,-527186490,803106487,-927261102,-46035440,
2124742566,479578891,411185872,-1552967674,1005070462,1768677545,1466037421,1226102803,-578715987,-1109568186,653210662,832784782,-1773333796,-1302522190,
810804565,-715445259,-317922106,1191548746,-886023758,1095737979,1573528872,-1358701087,1694362237,2007797722,-1922568579,1270514905,894928436,587253782,
-664900312,1822283721,-304305299,946007720,503621995,1264920838,-920443780,-568861381,-1124046095,-927525251,1746653202,1906124788,-283816889,1625728984,
768005095,648372919,357551935,-322270187,1346941736,-1717894970,921110016,-2114499097,-982642292,1329576454,-1561829034,-1445349730,-2088436577,645279998,
602513566,1681385341,1650036788,1936142927,-756833660,-449965460,1165307954,-554721426,-424905564,1624626906,-178150202,-1067576423,-709209345,-951490775,
623927022,-2076336881,1064866854,1001210244,1024089777,-569505431,-855671414,1328415626,539004493,-681546704,1626646295,-1299428795,-1872961334,663522487,
846439045,62440720,1794381917,-614546432,-1689993,-1371020112,416176080,-1452399100,1846684678,1055701597,1283141381,1767892582,-640198516,-1044093321,
-1342520604,-1332260293,32417469,193817059,-2034368986,1951946145,1039800368,744758650,1750583735,718836251,-417940021,-215821512,-1519524074,1519319503,
-1620232223,1082572151,-1398552374,-2018356203,-1948675910,238213328,-1007618204,-1023672578,-1976105999,-840346158,-1408326184,1535236204,-1852518909,
-812470807,-1731772337,941695432,-2039163396,-1029146878,915948376,469792763,-48477765,228715206,-829353047,-1837161693,605602864,919005580,-1222037748,
-356333586,824925120,-2063419726,-409745176,226559113,-597926235,2089096292,-1709285806,-1800524916,1426880966,1416254276,-1573167273,1728056212,847807830,
-892841148,-1661836925,1347814329,1446741360,-929103484,-1859912896,-566941131,1461287021,1787764635,1224306523,516505552,390939205,-1935621530,1404403376,
-521758348,-150026812,1498487404,1382414087,1614577886,-792862442,-905948951,1520708641,-995747907,-100858228,999748158,-1047300121,435429221,1264851357,
-625565461,1561705728,1561705728,933092024,534725268,-85696186,835315305,-1835459726,-1387498932,-1427838341,-1871275377,1426951581,1142162924,-1105135100,
-1643617475,233415434,-815646164,-236444766,-39239064,-984709238,-412008429,68070371,-261389155,1752208920,-1004861906,-1425378987,188012277}}
}
local skinshops=criminal_skinshops
    
Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_skinshops)
    makeblips(fbi_skinshops)
    hideblips(fbi_skinshops)
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(skinshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 255, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        local model=v.models[math.random(#v.models)]
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(10) end
                        SetPlayerModel(PlayerId(),model)
                        SetModelAsNoLongerNeeded(model)
                        SetPedRandomComponentVariation(GetPlayerPed(-1), false)
                        Wait(100)
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("Press ~INPUT_VEH_HORN~ to change skin. Current "..GetEntityModel(GetPlayerPed(-1))) --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local criminal_mercenaries={
[1]={x=-44.801700592041,y=-706.75598144531,z=32.727561950684,name="Mercenary",color=2,sprite=280,skins={275618457},weapons={PISTOL,SAWNOFFSHOTGUN,ASSAULTRIFLE,MACHINEPISTOL},cost=9500,armor=20,health=700},
[2]={x=-1153.6383056641,y=-1249.3861083984,z=7.1956105232239,name="Mercenary",color=2,sprite=280,skins={1746653202,1024089777,1794381917,193817059},weapons={PISTOL,SNSPISTOL,PUMPSHOTGUN},cost=5000,armor=0,health=300},
[3]={x=373.76196289063,y=-738.09985351563,z=29.269620895386,name="Bodyguard",color=2,sprite=280,skins={-245247470,691061163},weapons={COMBATPISTOL,HEAVYPISTOL,SMG,ADVANCEDRIFLE,BULLPUPSHOTGUN},cost=18000,armor=100,health=1300},
[4]={x=-1577.1640625,y=2101.6176757813,z=68.072256469727,name="Kisos",color=17,sprite=406,skins={307287994,1462895032},weapons={148160082,2578778090},cost=1000,armor=100}
}
local fbi_mercenaries={
{x=459.51971435547,y=-989.71301269531,z=24.914873123169,name="Sidekick",color=3,sprite=280,skins={2072724299},weapons={HEAVYPISTOL,SMG,PUMPSHOTGUN},cost=0,armor=100,health=300}
}
local mercenaries=criminal_mercenaries

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_mercenaries)
    makeblips(fbi_mercenaries)
    hideblips(fbi_mercenaries)
    while true do
        Wait(0)
        --while player_is_cop do Wait(5000) end
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(mercenaries) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        if player_money>=v.cost then
                            local group=GetPlayerGroup(PlayerId())
                            local ped,groupsize=GetGroupSize(group)
                            if groupsize<7 then
                                ped=spawnped(v.skins[math.random(#v.skins)],v.x,v.y,v.z,v.weapons[math.random(#v.weapons)],friends)
                                SetPedAsGroupMember(ped, group);
                                SetPedCanRagdoll(ped, false);
                                SetPedRelationshipGroupHash(ped, relationship_friend)
                                if v.armor~=nil then
                                  SetPedArmour(ped, v.armor);
                                end
                                if v.health~=nil then
                                  SetPedMaxHealth(ped,v.health)
                                  SetEntityHealth(ped,v.health);
                                end
                                player_money=player_money-v.cost
                                removemoney(player_money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                groupsize=groupsize+1
                                SetBlipColour(v.blip, 20)
                                Wait(500)
                                SetNotificationTextEntry("STRING")
                                AddTextComponentString("New member joined your group.")
                                SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 3, "Group "..group, groupsize.."/7")
                                DrawNotification(false, false)
                                for i=1,450 do
                                    Wait(10)
                                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                end
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(GetPlayerPed(-1))
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You can't have more guys in your group.");
                                SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 8, v.name, "Sorry.");
                                DrawNotification(false, false);
                                Wait(10)
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                            Wait(10)
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to hire.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                        Wait(10)
                    end
                end
            end
        end
    end
end)

local criminal_carshops={
    {x=2964.9196777344,y=2747.6323242188,z=43.310658111572,name="Armored weaponized truck",color=1,sprite=229,cars={2434067162},cost=175000},
    {x=1463.7440185547,y=1128.9432373047,z=114.33376373291,name="Weaponized truck",color=2,sprite=229,cars={2198148358},cost=44000},
    {x=486.37924194336,y=-2159.6452636719,z=5.9258829498291,name="Armored car",color=1,sprite=380,cars={3406724313,1922255844,470404958,666166960,3862958888},cost=75000},
    {x=33.801235198975,y=-2671.1713867188,z=6.0175901794434,name="Armored truck",color=2,sprite=67,cars={1747439474,3089277354},cost=60000},
    {x=21.298585891724,y=-210.41683959961,z=52.857303619385,name="Offroad minivan",color=2,sprite=326,cars={1475773103},cost=35000},
    
    {x=-1798.862,y=2958.326,z=32.987,name="Besra",color=2,sprite=424,cars={1824333165},cost=0},
    {x=-1830.172,y=2958.542,z=32.987,name="Hydra",color=2,sprite=424,cars={970385471},cost=0},
    {x=-1816.536,y=2980.209,z=32.987,name="Laser",color=2,sprite=424,cars={-1281684762},cost=0},
    {x=-944.155,y=-2975.342,z=13.954,name="Velum",color=2,sprite=423,cars={-1673356438,1077420264},cost=0},
    {x=-932.973,y=-2981.526,z=13.954,name="Vestra",color=2,sprite=423,cars={1341619767},cost=0},
    {x=-947.736,y=-3035.898,z=13.954,name="Mammatus",color=2,sprite=423,cars={-1746576111},cost=0},
    {x=-955.232,y=-3031.343,z=13.954,name="Shamal",color=2,sprite=423,cars={-1214505995,621481054,-1214293858},cost=0},
    {x=-970.393,y=-3022.119,z=13.954,name="Miljet",color=2,sprite=423,cars={165154707},cost=0},
    --{x=-988.169,y=-3011.304,z=13.954,name="Titan",color=2,sprite=423,cars={1981688531},cost=0},
    {x=-931.253,y=-3003.082,z=13.954,name="Cuban",color=2,sprite=423,cars={-644710429},cost=0},
    {x=-961.615,y=-2966.009,z=13.954,name="Duster",color=2,sprite=423,cars={970356638},cost=0},
    {x=-916.020,y=-3012.285,z=13.954,name="Dodo",color=2,sprite=423,cars={-901163259},cost=0},
    {x=-941.129,y=-2997.301,z=13.954,name="Nimbus",color=2,sprite=423,cars={-1295027632},cost=0},
    --{x=-966.258,y=-2982.929,z=13.954,name="Jet",color=2,sprite=423,cars={1058115860},cost=0},
    {x=-852.734,y=-3322.492,z=13.954,name="Andromada",color=2,sprite=423,cars={368211810},cost=0},
    {x=-977.706,y=-2999.949,z=13.954,name="Titan",color=2,sprite=423,cars={1058115860},cost=0},
    {x=-1043.383,y=-3484.475,z=13.954,name="Jet",color=2,sprite=423,cars={1058115860},cost=0},
    {x=-7.4814505577087,y=-1072.8524169922,z=38.152011871338,sprite=326,name="Compact car shop",cost=12500,cars={-344943009,1039032026,1549126457,-1130810103,-1177863319,-431692672,-1450650718,841808271}},
    {x=-5.2188544273376,y=-1067.3846435547,z=38.152011871338,sprite=326,name="Two seat car shop",cost=25000,cars={1830407356,1078682497,-2124201592,330661258,-5153954,-591610296,-89291282,1349725314,873639469,-1122289213,-1193103848,2016857647}},
    {x=-3.1182959079742,y=-1062.6424560547,z=38.152011871338,sprite=326,name="Four seat car shop",cost=20000,cars={970598228,-391594584,-624529134,1348744438,-511601230,-1930048799,-1809822327,-1903012613,906642318,-2030171296,-685276541,1909141499,75131841,-1289722222,886934177,-1883869285,-1150599089,-1477580979,1723137093,-1894894188,-1008861746,1373123368,1777363799,-310465116,-1255452397,970598228}},
    {x=-1.2373449802399,y=-1058.4499511719,z=38.152011871338,sprite=326,name="Muscle car shop",cost=20000,cars={464687292,1531094468,-1205801634,-682211828,349605904,80636076,723973206,-2119578145,-1800170043,-1943285540,-2095439403,1507916787,-227741703,-1685021548,1923400478,972671128,-825837129,-498054846,2006667053}},
    {x=0.60717076063156,y=-1054.0606689453,z=38.152011871338,sprite=326,name="Off road car shop",cost=20000,cars={914654722,1645267888,-2045594037,-1189015600,989381445,850565707,-808831384,142944341,1878062887,634118882,2006918058,-789894171,683047626,1177543287,-1137532101,-1775728740,-1543762099,884422927,486987393,1269098716,-808457413,-1651067813,2136773105,1221512915,1337041428,1203490606,-16948145,1069929536}},
    {x=2.5292096138,y=-1048.0963134766,z=38.152011871338,sprite=326,name="Vans car shop",cost=15000,cars={-1346687836,1162065741,-119658072,-810318068,65402552,1026149675}},
    {x=507.46719360352,y=-1842.5042724609,z=27.686410903931,sprite=326,name="Used car shop",cost=300,cars={-2033222435,-667151410,523724515,-1435919434,1770332643,-1207771834,-1883002148,-14495224,1762279763,-120287622,-1311240698}},
    {x=186.72326660156,y=-1256.9447021484,z=29.198457717896,sprite=68,name="Rent tow truck",cost=100,cars={-1323100960,-442313018},rent=true},
    {x=-478.01977539063,y=-614.94030761719,z=31.1744556427,sprite=326,name="Sport car shop",cost=75000,cars={-1622444098,1123216662,767087018,-1041692462,1274868363,736902334,2072687711,-1045541610,108773431,196747873,-566387422,-1995326987,-1089039904,499169875,-1297672541,544021352,-1372848492,482197771,-142942670,-1461482751,-777172681,-377465520,-1934452204,1737773231,1032823388,719660200,-746882698,-1757836725,1886268224,384071873,-295689028}},
    {x=-1792.1674804688,y=458.46810913086,z=128.30819702148,sprite=326,name="Classic sport car shop",cost=120000,cars={-982130927,-1566741232,-1405937764,1887331236,941800958,223240013,1011753235,784565758,1051415893,-1660945322,-433375717,1545842587,-2098947590,1504306544}},
    {x=-64.245101928711,y=886.47015380859,z=235.82223510742,sprite=326,name="Super car shop",cost=400000,cars={-1216765807,-1696146015,-1311154784,-1291952903,1426219628,1234311532,418536135,-1232836011,1034187331,1093792632,1987142870,-1758137366,-1829802492,2123327359,234062309,819197656,1663218586,272929391,408192225,2067820283,338562499,1939284556,-1403128555,-2048333973,-482719877,917809321}},
    {x=-866.72729492188,y=-1122.9127197266,z=6.6089086532593,sprite=348,name="Motorcycle shop",cost=8000,cars={1672195559,-2140431165,86520421,1753414259,627535535,640818791,-1523428744,-634879114,-909201658,-893578776,-1453280962,788045382,1836027715,-140902153,-1353081087}},
    {x=103.67114257813,y=-2189.1770019531,z=5.9722423553467,sprite=477,name="Truck shop",cost=40000,cars={1518533038,569305213,-2137348917}},
    {x=845.18511962891,y=-2358.1569824219,z=30.337574005127,sprite=477,color=1,name="Upgraded Truck shop",cost=110000,cars={387748548,177270108}}
    --{x=163.18153381348,y=-1282.4031982422,z=29.146518707275,name="KITT",color=2,sprite=460,cars={941494461},cost=300000},
    --{x=196.76313781738,y=-1498.1608886719,z=29.141607284546,name="Oppressor",color=2,sprite=226,cars={884483972},cost=400000}
}
local fbi_carshops={
    {x=447.36117553711,y=-997.20043945313,z=25.704141616821,angle=180.58967590332,fbi=true,sprite=56,color=3,name="Unmarked police car",cost=0,cars={-1973172295}},
    {x=452.33187866211,y=-997.36022949219,z=25.702560424805,angle=180.09335327148,fbi=true,sprite=56,color=3,name="Unmarked fast police car",cost=0,cars={1127131465}},
    {x=462.2532043457,y=-1014.6189575195,z=28.020277023315,angle=91.622131347656,fbi=true,sprite=56,color=3,name="Unmarked off road police car",cost=0,cars={-1647941228}},
    {x=462.19750976563,y=-1019.5223999023,z=28.034339904785,angle=92.353416442871,fbi=true,sprite=56,color=3,name="Fast police car",cost=0,cars={-1627000575}},
    {x=454.84698486328,y=-993.29400634766,z=43.691650390625,angle=87.682159423828,fbi=true,sprite=56,color=3,name="Helicopter",cost=0,cars={353883353}}
}
local carshops=criminal_carshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_carshops)
    makeblips(fbi_carshops)
    hideblips(fbi_carshops)
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(carshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                            if v.rent and rentcar.plate then
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You must return rented car first.");
                                DrawNotification(false, false);
                            elseif player_money>=v.cost then
                                -- if mycar then
                                    -- SetNotificationTextEntry("STRING");
                                    -- AddTextComponentString("You need to store your current vehicle in ~b~garage ~s~or ~r~destroy ~s~it.");
                                    -- DrawNotification(false, false);
                                    -- Wait(1000)
                                    -- break
                                -- end
                                local angle=v.angle
                                if not angle then
                                    angle=GetEntityHeading(GetPlayerPed(-1))
                                end
                                if v.fbi then
                                    local veh=createcar(v.cars[math.random(#v.cars)],v.x,v.y,v.z,angle)
                                    TaskEnterVehicle(GetPlayerPed(-1),veh,1,-1,2.0,16,0)
                                    SetVehicleAsNoLongerNeeded(veh)
                                elseif v.rent then
                                    rentcar.veh=createcar(v.cars[math.random(#v.cars)],v.x,v.y,v.z,angle)
                                    local carblip=AddBlipForEntity(rentcar.veh)
                                    SetBlipSprite(carblip, v.sprite)
                                    SetBlipDisplay(carblip, 2)
                                    SetBlipScale(carblip, 0.6)
                                    SetBlipColour(carblip, 32)
                                    TaskEnterVehicle(GetPlayerPed(-1),rentcar.veh,1,-1,2.0,16,0)
                                    rentcar.net=networkingshit(rentcar.veh)
                                    rentcar.plate=GetVehicleNumberPlateText(rentcar.veh)
                                    sendcarplates()
                                else
                                    TaskEnterVehicle(GetPlayerPed(-1),createmycar(v.cars[math.random(#v.cars)],v.x,v.y,v.z,angle),1,-1,2.0,16,0)
                                    SetNotificationTextEntry("STRING");
                                    AddTextComponentString("You've bought a vehicle. When leaving server your vehicle has to be ~b~in garage~s~ to be saved.");
                                    DrawNotification(false, false);
                                end
                                player_money=player_money-v.cost
                                removemoney(player_money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                SetBlipColour(v.blip, 20)
                                for i=1,500 do
                                        Wait(10)
                                        DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                end
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(GetPlayerPed(-1))
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You don't have enough money.");
                                --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                                DrawNotification(false, false);
                            end
                        elseif rentcar.veh==GetVehiclePedIsUsing(GetPlayerPed(-1)) then
                            SetEntityAsMissionEntity(rentcar.veh,true,true)
                            DeleteVehicle(rentcar.veh)
                            rentcar.veh=nil
                            rentcar.net=nil
                            forgetgps(rentcar)
                            rentcar.plate=nil
                            sendcarplates()
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("Thank you for returning rented vehicle.");
                            DrawNotification(false, false);
                            SetBlipColour(v.blip, 20)
                                for i=1,100 do
                                        Wait(10)
                                        DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                end
                            SetBlipColour(v.blip, v.color)
                            pos=GetEntityCoords(GetPlayerPed(-1))
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("Clear this area of any vehicles before buying.");
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to buy.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local repair_wheels,repair_windows,repair_engine,repair_body,repair_paint,repair_full=1,2,4,8,16,31;
local criminal_repairshops={
    {x=888.95196533203,y=-889.42864990234,z=26.414888381958,name="Repair engine and wheels",color=2,sprite=446,cost=2000,flags=repair_wheels+repair_windows+repair_engine},
    {x=471.21493530273,y=-578.73657226563,z=28.49973487854,name="Full repair",color=1,sprite=446,cost=10000,flags=repair_full},
    {x=938.67657470703,y=-1495.4936523438,z=29.806707382202,sprite=72,name="Car paint",cost=500,flags=repair_paint}
}
local fbi_repairshops={
    {x=435.72744750977,y=-997.92150878906,z=25.358324050903,name="Full repair",color=3,sprite=446,cost=0,flags=repair_full},
    {x=431.58267211914,y=-998.01678466797,z=25.357425689697,name="Full repair",color=3,sprite=446,cost=0,flags=repair_full}
}
local repairshops=criminal_repairshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_repairshops)
    makeblips(fbi_repairshops)
    hideblips(fbi_repairshops)
    while true do
        Wait(0)
        --while player_is_cop do Wait(5000) end
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(repairshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        local veh=nil
                        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                            veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
                        else
                            local dx,dy,dz
                            local dist1=100
                            local dist2=100
                            if mycar.veh then
                                local pos2=GetEntityCoords(mycar.veh)
                                dx,dy,dz=pos2.x-pos.x,pos2.y-pos.y,pos2.z-pos.z
                                dist1=dx*dx+dy*dy+dz*dz
                                if dist1<100 then veh=mycar.veh end
                            end
                            if mycar_old.veh then
                                local pos2=GetEntityCoords(mycar_old.veh)
                                dx,dy,dz=pos2.x-pos.x,pos2.y-pos.y,pos2.z-pos.z
                                dist2=dx*dx+dy*dy+dz*dz
                                if dist2<dist1 then veh=mycar_old.veh end
                            end
                        end
                        if veh then
                            if player_money>=v.cost then
                                --ResetVehicleWheels(veh,true)
                                --ResetVehicleWheels(veh,false)
                                if (v.flags&repair_paint)==repair_paint then
                                    --SetVehicleColours(veh,-1,-1)
                                    SetVehicleColours(veh,math.random(0,160),math.random(0,160))
                                end
                                if v.flags==repair_full then
                                    SetVehicleFixed(veh)
                                else
                                    if (v.flags&repair_wheels)==repair_wheels then
                                        SetVehicleTyreFixed(veh,0)
                                        SetVehicleTyreFixed(veh,1)
                                        SetVehicleTyreFixed(veh,2)
                                        SetVehicleTyreFixed(veh,3)
                                        SetVehicleTyreFixed(veh,4)
                                        SetVehicleTyreFixed(veh,5)
                                        SetVehicleTyreFixed(veh,45)
                                        SetVehicleTyreFixed(veh,47)
                                    end
                                --local engine = GetVehicleEngineHealth(veh)
                                --if engine<1000 then
                                
                                --SetVehicleBodyHealth(veh,1000.0)
                                    if (v.flags&repair_engine)==repair_engine then
                                        SetVehicleEngineHealth(veh,1000.0)
                                        SetVehiclePetrolTankHealth(veh,1000.0)
                                    end
                                --
                                    if (v.flags&repair_windows)==repair_windows then
                                        for i=0,26 do
                                            Citizen.CreateThread(function() FixVehicleWindow(veh,i) end)
                                        end
                                    end
                                end
                                player_money=player_money-v.cost
                                removemoney(player_money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                SetBlipColour(v.blip, 20)
                                for i=1,500 do
                                        Wait(10)
                                        DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                end
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(GetPlayerPed(-1))
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You don't have enough money.");
                                --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                                DrawNotification(false, false);
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You need to be in a vehicle or have your bought vehicle nearby.");
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to repair.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local garages={
    {x=-1039.685546,y=-412.2041320800,z=33.27317810058,angle=21.64019203186},
    {x=-1043.722778,y=-403.6976623535,z=33.27317810058,angle=205.1398315429},
    {x=-1037.418823,y=-399.1575927734,z=33.27317810058,angle=204.7279205322},
    {x=-1033.457275,y=-406.8182678222,z=33.27318191528,angle=26.94477653503},
    {x=-1398.044555,y=-461.5809326171,z=34.47920227050,angle=11.11164569854},
    {x=-1409.498413,y=-459.4078063964,z=34.48365020752,angle=213.3029479980},
    {x=-1443.468017,y=-523.6984863281,z=31.58182525634,angle=31.02633476257},
    {x=-1446.421875,y=-519.0927124023,z=31.58182525634,angle=33.07036972045},
    {x=-1449.182861,y=-514.4866333007,z=31.58182525634,angle=30.47829246521},
    {x=-1538.055541,y=-576.7301635742,z=25.70781898498,angle=31.74063491821},
    {x=-833.9008789,y=-400.1473693847,z=30.70482826232,angle=294.7731933593},
    {x=-835.4608764,y=-395.6582946777,z=30.70537567138,angle=295.4821166992},
    {x=-839.2616577,y=-391.5639343261,z=30.70547485351,angle=295.3235778808},
    {x=-185.8487701,y=166.23648071289,z=69.70829772949,angle=84.55401611328},
    {x=-184.9401092,y=171.38264465332,z=69.70859527587,angle=86.48316955566},
    {x=-187.4133300,y=144.57749938965,z=69.70964813232,angle=163.0818023681},
    {x=-144.5423736,y=-577.6981201171,z=31.80375671386,angle=161.1910552978},
    {x=-20.22202682,y=-705.7244262695,z=31.71716499328,angle=342.9769287109},
    {x=-36.26410675,y=-700.7737426757,z=31.71798515319,angle=341.0366210937},
    {x=-4.271838188,y=-711.8181762695,z=31.71798896789,angle=338.9836120605},
    {x=255.88787841,y=-751.6263427734,z=30.20108985900,angle=71.71109771728},
    {x=155.72358703,y=-692.1958618164,z=32.50947189331,angle=158.1769714355},
    {x=168.42227172,y=-698.0588989257,z=32.50762939453,angle=163.1546478271},
    {x=371.42916870,y=-1651.860839843,z=26.67752075195,angle=138.9389038085},
    {x=364.21832275,y=-1683.089599609,z=26.68415260314,angle=138.7008514404},
    {x=393.04489135,y=-1670.743286132,z=26.69096946716,angle=137.1209716796},
    {x=520.65783691,y=168.94683837891,z=98.74963378906,angle=250.6946868896},
    {x=-1379.385498,y=-474.6076660156,z=31.28181838989,angle=99.054794311523},
    {x=-29.67472458,y=3.541065454483,z=70.656951904297,angle=159.71878051758},
    {x=-1269.5834960938,y=-3377.4714355469,z=15,angle=330}, --hangar1
    {x=-1647.2069091797,y=-3134.2456054688,z=15,angle=330}, --hangar2
    {x=-1644.7590332031,y=-3148.1198730469,z=13.333193778992,angle=330}, --hangar2.1
    {x=-1660.5771484375,y=-3139.12109375,z=13.333325386047,angle=330}, --hangar2.2
    {x=-1181.6462402344,y=-2379.2512207031,z=13.287142753601,angle=50}, --open
    {x=-797.32495117188,y=-1501.8538818359,z=-0.47531151771545,angle=109}, --boats 1
    {x=-804.322265625,y=-1485.7386474609,z=-0.475227445364,angle=109}, --boats 2
    {x=1733.7906494141,y=3301.3681640625,z=41.22350692749,angle=191.01606750488}, --sandyshores
    {x=2131.849609375,y=4786.2827148438,z=40.970283508301,angle=29.885553359985}, --makenzie
    {x=-1593.8843994141,y=5259.2700195313,z=1.5794897079468,angle=19.289232254028}, --morthwest coast
    {x=3851.8952636719,y=4477.4018554688,z=3.6427760124207,angle=273.72241210938}, --northeast coast
    {x=3091.7487792969,y=2188.46875,z=3.9013569355011,angle=181.06353759766} --cave
}

local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

RegisterNetEvent(event.plates)
AddEventHandler(event.plates, function(plate_m,plate_o,plate_r)
    if plate_m then print("mycar ["..plate_m.."]") end
    if plate_o then print("oldcar ["..plate_o.."]") end
    if plate_r then print("rentcar ["..plate_r.."]") end
    mycar.plate=plate_m
    mycar_old.plate=plate_o
    rentcar.plate=plate_r
    if plate_m or plate_o or plate_r then
        Wait(5000)
        for veh in EnumerateVehicles() do
            local plate=GetVehicleNumberPlateText(veh)
            if plate then
             print("plate "..plate)
            else
             print("no plate "..veh)
            end
            if plate==mycar.plate then
                mycar.veh=veh
                mycar.net=NetworkGetNetworkIdFromEntity(veh)
                addcarblip(veh)
            end
            if plate==mycar_old.plate then
                mycar_old.veh=veh
                mycar_old.net=NetworkGetNetworkIdFromEntity(veh)
                addcarblip(veh)
            end
            if plate==rentcar.plate then
                rentcar.veh=veh
                rentcar.net=NetworkGetNetworkIdFromEntity(veh)
                addcarblip(veh)
            end
        end
    end
end)

RegisterNetEvent(event.garage)
AddEventHandler(event.garage, function(k,car)
    if car~=nil then
        garages[k].name=GetDisplayNameFromVehicleModel(car.hash)
        garages[k].car=car
        SetBlipColour(garages[k].blip, 3)
    else
        garages[k].car=nil
        garages[k].name="Garage"
        SetBlipColour(garages[k].blip, 4)
    end
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(garages[k].name);
        EndTextCommandSetBlipName(garages[k].blip)
end)
    
Citizen.CreateThread(function()
    for k,v in pairs(garages) do
     v.name="Garage"
     v.sprite=357
     v.color=4
    end
    Wait(5000)
    makeblips(garages)
    while true do
        Wait(0)
        while player_is_cop do Wait(5000) end
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(garages) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 1.5, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        if v.car and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                            -- if mycar and (v.car.wanted==0) then
                                -- SetNotificationTextEntry("STRING");
                                -- AddTextComponentString("You need to store your current vehicle in ~b~garage ~s~or ~r~destroy ~s~it.");
                                -- DrawNotification(false, false);
                                -- Wait(1000)
                                -- break
                            -- end
                            local c=v.car
                            local veh=loadcar(v.x,v.y,v.z,v.angle,c)
                            v.car=nil
                            v.name="Garage"
                            TaskEnterVehicle(GetPlayerPed(-1),veh,1,-1,2.0,16,0)
                            TriggerServerEvent(event.take_car,k)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(v.name);
                            EndTextCommandSetBlipName(v.blip)
                            SetBlipColour(v.blip, 20)
                            for i=1,500 do
                                    Wait(10)
                                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 1.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                            end
                            SetBlipColour(v.blip, 4)
                            pos=GetEntityCoords(GetPlayerPed(-1))
                        elseif (not v.car) and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                            local veh=GetVehiclePedIsUsing(GetPlayerPed(-1))
                            if veh==rentcar.veh then
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("Did you just stole rented vehicle?");
                                DrawNotification(false, false);
                            end
                            v.car=savecar(veh)
                            v.name=GetDisplayNameFromVehicleModel(v.car.hash)
                            TriggerServerEvent(event.save_car,k,v.car)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(v.name);
                            EndTextCommandSetBlipName(v.blip)
                            SetBlipColour(v.blip, 20)
                            for i=1,500 do
                                    Wait(10)
                                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 1.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                            end
                            SetBlipColour(v.blip, 3)
                            pos=GetEntityCoords(GetPlayerPed(-1))
                        else
                            SetNotificationTextEntry("STRING");
                            if v.car then
                                AddTextComponentString("You need to be on foot to take vehicle.");
                            else
                                AddTextComponentString("You need to be in a vehicle to store it.");
                            end
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        if v.car then
                                AddTextComponentString("Press ~INPUT_VEH_HORN~ to take "..v.name..".")
                        else
                                AddTextComponentString("Press ~INPUT_VEH_HORN~ to save one vehicle in this garage.");
                        end
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local become_a_cop={
    {x=441.19030761719,y=-981.13079833984,z=30.689605712891,sprite=60,color=3,name="Become policeman",models={2072724299}}
}

local dont_kill_those={}
dont_kill_those[GetHashKey("COP")]="cop"
dont_kill_those[GetHashKey("SECURITY_GUARD")]="security guard"
dont_kill_those[GetHashKey("CIVMALE")]="civilian"
dont_kill_those[GetHashKey("CIVFEMALE")]="civilian"
dont_kill_those[GetHashKey("FIREMAN")]="civilian"
dont_kill_those[GetHashKey("ARMY")]="soldier"
dont_kill_those[GetHashKey("MEDIC")]="civilian"

local function switch_to_criminal()
    showblips(criminal_weaponshops)
    showblips(armorshops)
    showblips(criminal_medics)
    showblips(clothes)
    showblips(criminal_skinshops)
    showblips(criminal_mercenaries)
    showblips(criminal_carshops)
    showblips(criminal_repairshops)
    showblips(garages)
    hideblips(fbi_carshops)
    hideblips(fbi_weaponshops)
    hideblips(fbi_medics)
    hideblips(fbi_skinshops)
    hideblips(fbi_repairshops)
    hideblips(fbi_mercenaries)
    showblips(become_a_cop)
    medics=criminal_medics
    skinshops=criminal_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=criminal_repairshops
    mercenaries=criminal_mercenaries
    player_is_cop=false
    SetMaxWantedLevel(5);
end

local function switch_to_cop()
    hideblips(criminal_weaponshops)
    hideblips(armorshops)
    hideblips(criminal_medics)
    hideblips(clothes)
    hideblips(criminal_skinshops)
    hideblips(criminal_mercenaries)
    hideblips(criminal_carshops)
    hideblips(criminal_repairshops)
    hideblips(garages)
    showblips(fbi_carshops)
    showblips(fbi_weaponshops)
    showblips(fbi_medics)
    showblips(fbi_skinshops)
    showblips(fbi_repairshops)
    showblips(fbi_mercenaries)
    hideblips(become_a_cop)
    medics=fbi_medics
    skinshops=fbi_skinshops
    weaponshops=fbi_weaponshops
    carshops=fbi_carshops
    repairshops=fbi_repairshops
    mercenaries=fbi_mercenaries
    player_is_cop=true
    SetMaxWantedLevel(0);
end

local function kick_from_police(reason)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(reason)
    DrawNotification(false, false);
    --DoScreenFadeOut(1000);
    if not IsPedInAnyVehicle(GetPlayerPed(-1),false) then
        Wait(2000)
        local animdict="combat@damage@injured_pistol@to_writhe"
        local anim="variation_b"
        RequestAnimDict(animdict)
        while not HasAnimDictLoaded(animdict) do Wait(10) end
        TaskPlayAnim(GetPlayerPed(-1), animdict, anim, 1.0, 1.0, 10000, 0, 0, 0, 0, 0);
    end
    Wait(6250)
    SetEntityHealth(GetPlayerPed(-1),0.0)
    switch_to_criminal()
end

local function cop_killed_ped(ped,how)
    local relgroup=GetPedRelationshipGroupHash(ped)
    if relgroup==1862763509 then --GetHashKey("PLAYER")
        if GetEntityModel(ped)==2072724299 then --FBI model
            kick_from_police("~r~You "..how.." another FIB agent.")
        end
    elseif dont_kill_those[relgroup] then
        kick_from_police("~r~You "..how.." "..dont_kill_those[relgroup]..".")
    end
end

Citizen.CreateThread(function()
Wait(5000)
    makeblips(become_a_cop)
    while true do
        Wait(10)
        if player_is_cop then
            local you=GetPlayerPed(-1)
            local your_car=nil
            if IsPedInAnyVehicle(you) then
                local car=GetVehiclePedIsUsing(you)
                if you==GetPedInVehicleSeat(car,-1) then
                    your_car=car
                end
            end
            if your_car~=nil then
                for ped in EnumeratePeds() do
                    local killer=GetPedKiller(ped)
                    if killer==you then
                        cop_killed_ped(ped,"killed")
                    elseif killer==your_car then
                        cop_killed_ped(ped,"ran over")
                    end
                end
            else
                for ped in EnumeratePeds() do
                    local killer=GetPedKiller(ped)
                    if killer==you then
                        cop_killed_ped(ped,"killed")
                    end
                end
            end
        else
            pos=GetEntityCoords(GetPlayerPed(-1))
            for k,v in pairs(become_a_cop) do
                local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
                if square<100 then
                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 255, 128, false, true, 2, false, false, false, false)
                    if (square<4) and (not isDead) then
                        if IsControlPressed(0, 86) and player_wanted==0 and player_money and player_money>=15000 then
                            local model=v.models[math.random(#v.models)]
                            RequestModel(model)
                            while not HasModelLoaded(model) do Wait(10) end
                            SetPlayerModel(PlayerId(),model)
                            SetModelAsNoLongerNeeded(model)
                            SetPedRandomComponentVariation(GetPlayerPed(-1), false)
                            switch_to_cop()
                            Wait(1000)
                        else
                            SetTextComponentFormat("STRING")
                            AddTextComponentString("You need to have ~g~$15000\n~s~Press ~INPUT_VEH_HORN~ to become FBI agent.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                            --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                            DisplayHelpTextFromStringLabel(0,0,1,-1)
                        end
                    end
                end
            end
        end
    end
end)