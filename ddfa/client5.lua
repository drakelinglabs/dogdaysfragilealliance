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
local spawn_garage=nil

local garages_enabled=true
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
    {x=79.461723327637,y=-2533.6181640625,z=6.2260570526123,angle=209.33934020996}, --truck 1 , 2 , 3 not 4 and 5
    {x=75.011390686035,y=-2539.6477050781,z=6.2269997596741,angle=209.05969238281},
    {x=77.192329406738,y=-2536.3874511719,z=6.2266731262207,angle=209.86859130859},
    {x=139.22319030762,y=-2536.3791503906,z=6.2258954048157,angle=205.90068054199},
    {x=143.77529907227,y=-2498.9580078125,z=6.2272624969482,angle=235.09417724609},
    {x=139.51182556152,y=-2448.6220703125,z=6.2255501747131,angle=300.40008544922}, --truck1
    {x=146.34170532227,y=-2496.169921875,z=6.2246561050415,angle=234.27124023438}, --truck2
    {x=148.25201416016,y=-2492.4084472656,z=6.2231516838074,angle=234.32827758789},    --truck3
    {x=-1269.5834960938,y=-3377.4714355469,z=14.0,angle=330}, --hangar1
    {x=-1647.2069091797,y=-3134.2456054688,z=14.0,angle=330}, --hangar2
    {x=-1644.7590332031,y=-3148.1198730469,z=14.0,angle=330}, --hangar2.1
    {x=-1660.5771484375,y=-3139.12109375,z=14.0,angle=330}, --hangar2.2
    {x=-1181.6462402344,y=-2379.2512207031,z=14.0,angle=50}, --open 1
    {x=-797.32495117188,y=-1501.8538818359,z=-0.47531151771545,angle=109}, --boats 1
    {x=-804.322265625,y=-1485.7386474609,z=-0.475227445364,angle=109}, --boats 2
    {x=1733.7906494141,y=3301.3681640625,z=41.22350692749,angle=191.01606750488}, --sandyshores
    {x=2131.849609375,y=4786.2827148438,z=40.970283508301,angle=29.885553359985}, --makenzie
    {x=-1593.8843994141,y=5259.2700195313,z=1.5794897079468,angle=19.289232254028}, --morthwest coast
    {x=3851.8952636719,y=4477.4018554688,z=3.0,angle=273.72241210938}, --northeast coast
    {x=3091.7487792969,y=2188.46875,z=3.0,angle=181.06353759766}, --cave
    {x=-1729.671875,y=-3066.1174316406,z=15.0,angle=319.92343}, --lsia open 2
    {x=283.40374755859,y=75.906845092773,z=93.987991333008,angle=67.80687713623},
    {x=146.83709716797,y=320.70883178711,z=111.76653289795,angle=114.86211395264}
}

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

local function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

local function get_vehicle_from_plate(plate)
    for veh in EnumerateVehicles() do
        if GetVehicleNumberPlateText(veh)==plate then
            return veh
        end
    end
    return 0
end

local function addcarblip(veh)
    local carblip=AddBlipForEntity(veh)
    SetBlipSprite(carblip, 326)
    SetBlipDisplay(carblip, 2)
    SetBlipScale(carblip, 0.6)
    SetBlipColour(carblip, 3)
end

-- local function NetworkUnregisterNetworkedEntity(entity)
    -- return Citizen.InvokeNative(0x7368E683BB9038D6,entity)
-- end

-- local function NetworkRegisterEntityAsNetworked(entity)
    -- return Citizen.InvokeNative(0x06FAACD625D80CAA,entity)
-- end

-- local function NetworkSetNetworkIdDynamic(netID,toggle)
    -- return Citizen.InvokeNative(0x2B1813ABA29016C5,netID,toggle)
-- end

local function networkingshit(entity)
    --while not 
    SetEntityAsMissionEntity(entity,true,true)
    local netID=NetworkGetNetworkIdFromEntity(entity)
    if netID==0 then
        NetworkRegisterEntityAsNetworked(entity)
        Wait(0)
        netID=NetworkGetNetworkIdFromEntity(entity)
    end
    SetNetworkIdExistsOnAllMachines(netID, true)
    NetworkSetNetworkIdDynamic(netID,true)
    Wait(0)
    netID=NetworkGetNetworkIdFromEntity(entity)
    return netID
end

local function fix_vehicles_using_plates()
    local lost_cars={}
    local something_lost=false
    local i=0
    if mycar.plate and mycar.net~=NetworkGetNetworkIdFromEntity(mycar.veh) then
        i=i+1
        lost_cars[i]=mycar
        something_lost=true
    end
    if mycar_old.plate and mycar_old.net~=NetworkGetNetworkIdFromEntity(mycar_old.veh) then
        i=i+1
        lost_cars[i]=mycar_old
        something_lost=true
    end
    if rentcar.plate and rentcar.net~=NetworkGetNetworkIdFromEntity(rentcar.veh) then
        i=i+1
        lost_cars[i]=rentcar
        something_lost=true
    end
    if something_lost then
        for veh in EnumerateVehicles() do
            for key,car in pairs(lost_cars) do
                if GetVehicleNumberPlateText(veh)==car.plate then
                    car.veh=veh
                    NetworkUnregisterNetworkedEntity(veh)
                    car.net=networkingshit(veh)
                    addcarblip(veh)
                    if car.gps and car.gps.blip then
                        RemoveBlip(car.gps.blip)
                        car.gps.blip=nil
                    end
                    lost_cars[key]={}
                    lost_cars[key]=nil
                    break
                end
            end
        end
    end
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
                    local netnew=networkingshit(vehnew)
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
            fix_vehicles_using_plates()
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

-- Citizen.CreateThread(function()
-- Wait(5000)
    -- while true do
        -- Wait(1000)
        -- if debug_mode then
            -- local test="debug:m="
            -- if mycar.veh then
             -- test=test..mycar.veh
            -- else
             -- test=test.."nil"
            -- end
            -- test=test.." o="
            -- if mycar_old.veh then
             -- test=test..mycar_old.veh
            -- else
             -- test=test.."nil"
            -- end
            -- test=test.." r="
            -- if rentcar.veh then
             -- test=test..rentcar.veh
            -- else
             -- test=test.."nil"
            -- end
            -- if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
             -- test=test.." "..GetVehiclePedIsUsing(GetPlayerPed(-1))
            -- end
            -- SetNotificationTextEntry("STRING");
            -- AddTextComponentString(test)
            -- DrawNotification(false, false);
            -- Wait(1000)
            -- test="ent2n:m="
            -- if mycar.veh then
             -- test=test..NetworkGetNetworkIdFromEntity(mycar.veh)
            -- else
             -- test=test.."nil"
            -- end
            -- test=test.." o="
            -- if mycar_old.veh then
             -- test=test..NetworkGetNetworkIdFromEntity(mycar_old.veh)
            -- else
             -- test=test.."nil"
            -- end
            -- test=test.." r="
            -- if rentcar.veh then
             -- test=test..NetworkGetNetworkIdFromEntity(rentcar.veh)
            -- else
             -- test=test.."nil"
            -- end
            -- if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
             -- test=test.." "..NetworkGetNetworkIdFromEntity(GetVehiclePedIsUsing(GetPlayerPed(-1)))
            -- end
            -- SetNotificationTextEntry("STRING");
            -- AddTextComponentString(test)
            -- DrawNotification(false, false)
            -- Wait(1000)
            -- test="net2e:m="
            -- if mycar.net then
             -- test=test..NetworkGetEntityFromNetworkId(mycar.net)
            -- else
             -- test=test.."nil"
            -- end
            -- test=test.." o="
            -- if mycar_old.net then
             -- test=test..NetworkGetEntityFromNetworkId(mycar_old.net)
            -- else
             -- test=test.."nil"
            -- end
            -- test=test.." r="
            -- if rentcar.net then
             -- test=test..NetworkGetEntityFromNetworkId(rentcar.net)
            -- else
             -- test=test.."nil"
            -- end
            -- SetNotificationTextEntry("STRING");
            -- AddTextComponentString(test)
            -- DrawNotification(false, false);
            -- Wait(1000)
            -- test="netdb:m="
            -- if mycar.net then
             -- test=test..mycar.net
            -- else
             -- test=test.."nil"
            -- end
            -- test=test.." o="
            -- if mycar_old.net then
             -- test=test..mycar_old.net
            -- else
             -- test=test.."nil"
            -- end
            -- test=test.." r="
            -- if rentcar.net then
             -- test=test..rentcar.net
            -- else
             -- test=test.."nil"
            -- end
            -- SetNotificationTextEntry("STRING");
            -- AddTextComponentString(test)
            -- DrawNotification(false, false);
            -- Wait(1000)
            -- if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            -- SetNotificationTextEntry("STRING")
            -- AddTextComponentString("bhp="..GetVehicleBodyHealth(GetVehiclePedIsUsing(GetPlayerPed(-1))).." Your ID: "..PlayerId())
            -- DrawNotification(false, false)
            -- end
        -- end
    -- end
-- end)

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

RegisterNetEvent(event.notification)
AddEventHandler(event.notification, function(text)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is BURRIED.");
    DrawNotification(false, false);
end)

RegisterNetEvent("fragile-alliance:helptext")
AddEventHandler("fragile-alliance:helptext", function(text)
    SetTextComponentFormat("STRING");
    AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0,0,1,-1)
end)

Citizen.CreateThread(function()
Wait(5000)
    while true do
        while player_is_cop do Wait(5000) end
        if not money_drops[-1] and not player_is_cop then
            SetTextComponentFormat("STRING")
            AddTextComponentString("Press ~INPUT_PHONE~ to use your phone.")
            DisplayHelpTextFromStringLabel(0,0,1,-1)
            Wait(600000)
        end
		if not player_is_cop then
	        SetTextComponentFormat("STRING")
	        AddTextComponentString("Money:\n~INPUT_REPLAY_START_STOP_RECORDING~ hide\n~INPUT_REPLAY_START_STOP_RECORDING_SECONDARY~ take")
	        DisplayHelpTextFromStringLabel(0,0,1,-1)
	        Wait(600000)
		end
		if not player_is_cop then
	        SetTextComponentFormat("STRING")
	        AddTextComponentString("~INPUT_REPLAY_START_STOP_RECORDING~ to hide money in any place.")
	        DisplayHelpTextFromStringLabel(0,0,1,-1)
	        Wait(600000)
		end
		if not player_is_cop then
	        SetTextComponentFormat("STRING")
	        AddTextComponentString("~INPUT_REPLAY_START_STOP_RECORDING_SECONDARY~ to take money from hideout.")
	        DisplayHelpTextFromStringLabel(0,0,1,-1)
	        Wait(600000)
		end
		Wait(0)
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
    if id<0 then
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
        fix_vehicles_using_plates()
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
   local ped =  CreatePed(4, hash, x, y, z, 0.0, true, false)
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
   if weapon then
    GiveWeaponToPed(ped, weapon, 1000, false, true)
   end
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
       SetEntityAsMissionEntity(ped,true,true)
       Wait(500)
    end
    SetPedAsGroupLeader(ped, group);
    SetGroupFormation(group, 1);
end

RegisterNetEvent(event.spawnpeds)
AddEventHandler(event.spawnpeds, function(x,y,z,n,skins,weapons)
       --GetHashKey( "g_m_y_famca_01") --a_c_mtlion" ) --"mp_m_shopkeep_01" )
    ReserveNetworkMissionPeds(n)
    while n>8 do
       createpedgroup(x,y,z,8,skins,weapons,enemies)
       n=n-8
    end
    if n>1 then
       createpedgroup(x,y,z,n,skins,weapons,enemies)
    elseif n>0 then
       local ped=spawnped(skins[math.random(#skins)],x,y,z,weapons[math.random(#weapons)],enemies)
       SetPedAsEnemy(ped, true);
       SetPedRelationshipGroupHash(ped, relationship_enemy)
       SetEntityAsMissionEntity(ped,true,true)
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

local hash2fac={}
    hash2fac[GetHashKey("COP")]="COP"
    hash2fac[GetHashKey("PLAYER")]="PLAYER"
    hash2fac[GetHashKey("AMBIENT_GANG_LOST")]="AMBIENT_GANG_LOST"
    hash2fac[GetHashKey("PRIVATE_SECURITY")]="PRIVATE_SECURITY"
    hash2fac[GetHashKey("CIVMALE")]="CIVMALE"
    hash2fac[GetHashKey("CIVFEMALE")]="CIVFEMALE"	
    hash2fac[GetHashKey("SECURITY_GUARD")]="SECURITY_GUARD"
    hash2fac[GetHashKey("FIREMAN")]="FIREMAN"
    hash2fac[GetHashKey("GANG_1")]="GANG_1"
    hash2fac[GetHashKey("GANG_2")]="GANG_2"
    hash2fac[GetHashKey("GANG_9")]="GANG_9"
    hash2fac[GetHashKey("GANG_10")]="GANG_10"
    hash2fac[GetHashKey("AMBIENT_GANG_LOST")]="AMBIENT_GANG_LOST"
    hash2fac[GetHashKey("AMBIENT_GANG_MEXICAN")]="AMBIENT_GANG_MEXICAN"
    hash2fac[GetHashKey("AMBIENT_GANG_FAMILY")]="AMBIENT_GANG_FAMILY"
    hash2fac[GetHashKey("AMBIENT_GANG_BALLAS")]="AMBIENT_GANG_BALLAS"
    hash2fac[GetHashKey("AMBIENT_GANG_MARABUNTE")]="AMBIENT_GANG_MARABUNTE"
    hash2fac[GetHashKey("AMBIENT_GANG_CULT")]="AMBIENT_GANG_CULT"
    hash2fac[GetHashKey("AMBIENT_GANG_SALVA")]="AMBIENT_GANG_SALVA"
    hash2fac[GetHashKey("AMBIENT_GANG_WEICHENG")]="AMBIENT_GANG_WEICHENG"
    hash2fac[GetHashKey("AMBIENT_GANG_HILLBILLY")]="AMBIENT_GANG_HILLBILLY"
    hash2fac[GetHashKey("DEALER")]="DEALER"
    hash2fac[GetHashKey("HATES_PLAYER")]="HATES_PLAYER"
    hash2fac[GetHashKey("HEN")]="HEN"
    hash2fac[GetHashKey("WILD_ANIMAL")]="WILD_ANIMAL"
    hash2fac[GetHashKey("SHARK")]="SHARK"
    hash2fac[GetHashKey("COUGAR")]="COUGAR"
    hash2fac[GetHashKey("NO_RELATIONSHIP")]="NO_RELATIONSHIP"
    hash2fac[GetHashKey("SPECIAL")]="SPECIAL"
    hash2fac[GetHashKey("MISSION2")]="MISSION2"
    hash2fac[GetHashKey("MISSION3")]="MISSION3"
    hash2fac[GetHashKey("MISSION4")]="MISSION4"
    hash2fac[GetHashKey("MISSION5")]="MISSION5"
    hash2fac[GetHashKey("MISSION6")]="MISSION6"
    hash2fac[GetHashKey("MISSION7")]="MISSION7"
    hash2fac[GetHashKey("MISSION8")]="MISSION8"
    hash2fac[GetHashKey("ARMY")]="ARMY"
    hash2fac[GetHashKey("GUARD_DOG")]="GUARD_DOG"
    hash2fac[GetHashKey("AGGRESSIVE_INVESTIGATE")]="AGGRESSIVE_INVESTIGATE"
    hash2fac[GetHashKey("MEDIC")]="MEDIC"

local function copy_relationship_group(source,dest)
    for k,v in pairs(hash2fac) do
        if k==source then
            local a=GetRelationshipBetweenGroups(source,source)
            SetRelationshipBetweenGroups(a, dest, dest)
        elseif k==dest then
            local a=GetRelationshipBetweenGroups(source,dest)
            local b=GetRelationshipBetweenGroups(dest,source)
            SetRelationshipBetweenGroups(a, dest, source)
            SetRelationshipBetweenGroups(b, source, dest)
        else
            local a=GetRelationshipBetweenGroups(source,k)
            local b=GetRelationshipBetweenGroups(k,source)
            SetRelationshipBetweenGroups(a, dest, k)
            SetRelationshipBetweenGroups(b, k, dest)
        end
    end
end

local function relationship_mutual(rel,a,b)
   SetRelationshipBetweenGroups(rel, a, b)
   SetRelationshipBetweenGroups(rel, b, a)
end

Citizen.CreateThread(function()
    Wait(1000)
    --DisplayCash(false)
    while not NetworkIsSessionStarted() do Wait(100) end
    ReserveNetworkMissionVehicles(5) -- 3 personal + 1 carjacked + 1 trailer
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_LOST"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AGGRESSIVE_INVESTIGATE"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_BALLAS"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_FAMILY"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_MEXICAN"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_MARABUNTE"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_WEICHENG"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_SALVA"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("MISSION3"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("MISSION4"))
    
    relationship_mutual(0, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey("AMBIENT_GANG_FAMILY"))
    
    relationship_mutual(4, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey("AMBIENT_GANG_FAMILY"))
    relationship_mutual(4, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey("AMBIENT_GANG_SALVA"))
    relationship_mutual(4, GetHashKey("AMBIENT_GANG_WEICHENG"), GetHashKey("AMBIENT_GANG_LOST"))
    -- SetNotificationTextEntry("STRING");
    -- local new=AddRelationshipGroup("ANARCHY")
    -- if hash2fac[new] then
    -- AddTextComponentString(new.." "..GetHashKey("ANARCHY").." "..hash2fac[new])
    -- else
    -- AddTextComponentString(new.." "..GetHashKey("ANARCHY"))
    -- end
    -- DrawNotification(false, false);
    copy_relationship_group(GetHashKey("PLAYER"),GetHashKey("MISSION2"))
    relationship_mutual(GetRelationshipBetweenGroups(GetHashKey("PLAYER"),GetHashKey("PLAYER")),GetHashKey("PLAYER"),GetHashKey("MISSION2"))
    Wait(1000)
    TriggerServerEvent(event.connected)
    Wait(1000)
    TriggerEvent('fragile-alliance:playerspawn',ped)
    SetNotificationTextEntry("STRING");
    AddTextComponentString("PvP is on, don't trust anyone. You can cooperate or betray players. Use ~g~phone~s~ to start.");
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

local join_faction={},switch_to_criminal,switch_to_cop,switch_to_lost,switch_to_merc,switch_to_anarchy,switch_to_ballas,switch_to_fams,switch_to_vagos,switch_to_salva,switch_to_triads,switch_to_armmob,switch_to_heister,switch_to_cartel,switch_to_elite

AddEventHandler("fragile-alliance:playerspawn",function(ped)
    --local ped = PlayerPedId()
    switch_to_criminal()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(ped, true, false)
    local melee={WEAPON.KNIFE,WEAPON.NIGHTSTICK,WEAPON.HAMMER,WEAPON.BAT,WEAPON.GOLFCLUB,WEAPON.CROWBAR,WEAPON.BOTTLE,WEAPON.DAGGER,WEAPON.KNUCKLE,WEAPON.HATCHET,WEAPON.MACHETE,WEAPON.SWITCHBLADE,WEAPON.BATTLEAXE,WEAPON.POOLCUE,WEAPON.WRENCH}
    local guns={WEAPON.MUSKET,WEAPON.MARKSMANPISTOL,WEAPON.SNSPISTOL,WEAPON.VINTAGEPISTOL,WEAPON.DBSHOTGUN}
    local ammo={    15,            15,       42,           35,       16}
    local i=math.random(#guns)
    GiveWeaponToPed(ped, guns[i], ammo[i], false, true)
    i=math.random(#melee)
    GiveWeaponToPed(ped, melee[i], 0, false, true)
    SetPedRandomComponentVariation(ped, false)
    --if garages then
        if spawn_garage then
            if not spawn_garage.car then
                spawn_garage={}
                spawn_garage=nil
            end
        end
        if not spawn_garage then
            local spawnpoints={}
            local i=0
            for k,v in pairs(garages) do
                if v.car then
                    i=i+1
                    spawnpoints[i]=k
                end
            end
            if i>1 then
                spawn_garage=garages[spawnpoints[math.random(i)]]
            elseif i==1 then
                spawn_garage=garages[spawnpoints[1]]
            end
        end
        if spawn_garage then
            SetEntityCoords(ped,spawn_garage.x,spawn_garage.y,spawn_garage.z)
        end
    --end
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
                local dx,dy,dz=v.x-pos.x,v.y-pos.y,v.z-pos.z
                local square=dx*dx+dy*dy+dz*dz
                if square<100 then
                    local r_color=51*v.wanted
                    local g_color=255-r_color
                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.r, v.r, 1.0, r_color, g_color, 0, 128, false, true, 2, false, false, false, false)
                    if not isDead then
                        if square<9 then
                            if v.wanted>GetPlayerWantedLevel(PlayerId()) then
                                SetPlayerWantedLevel(PlayerId(), v.wanted, false)
                                SetPlayerWantedLevelNow(PlayerId(),false)
                            end
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
                        elseif key<0 then
                            if v.wanted>GetPlayerWantedLevel(PlayerId()) then
                                SetPlayerWantedLevel(PlayerId(), v.wanted, false)
                                SetPlayerWantedLevelNow(PlayerId(),false)
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
Wait(5000)
  while true do
    while player_is_cop do --or GetPedRelationshipGroupHash(PlayerdPed(-1))==GetHashKey("AGGRESSIVE_INVESTIGATE")  do
        if IsControlPressed(0,101) or IsControlPressed(0,288) or IsControlPressed(0,289) then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("This faction can't find or make money stashes; or start heists.")
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
    SetVehicleUndriveable(veh,true)
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
        Wait(10)
    end
end

local function showblips(shops)
    for k,v in pairs(shops) do
        local blip=v.blip
        if blip then
            SetBlipSprite(blip, v.sprite)
            SetBlipColour(blip, v.color)
            SetBlipDisplay(blip, 2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end

local function hideblips(shops)
    for k,v in pairs(shops) do
        local blip=v.blip
        if blip then
            SetBlipSprite(blip, 406)
            SetBlipDisplay(blip, 0)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("")
            EndTextCommandSetBlipName(blip)
        end
    end
end

local criminal_weaponshops={
{x=35.239,y=-1459.373,z=29.3116,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL},
                                                                                   ammo={           7}},
{x=85.802757263184,y=-1959.5242919922,z=21.121673583984,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- ballas
                                                                                                               ammo={           7}},
{x=-16.671392440796,y=-1430.4289550781,z=31.101531982422,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- grove
                                                                                                                ammo={           7}},
{x=971.63922119141,y=-1811.396484375,z=31.256795883179,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- vagos
                                                                                                                ammo={           7}},
{x=1205.7526855469,y=-1607.6594238281,z=50.736503601074,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- salva
                                                                                                                ammo={           7}},
{x=-728.63909912109,y=-879.87927246094,z=22.710916519165,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- triad
                                                                                                            ammo={           7}},
{x=-456.61401367188,y=-1734.1893310547,z=16.763284683228,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- armenian
                                                                                                            ammo={           7}},
{x=485.409,y=-1529.096,z=29.2950,name="Pistol shop",sprite=156,color=2,cost=500,weapon={WEAPON.COMBATPISTOL},
                                                                                   ammo={             72}},
{x=49.747,y=-1453.323,z=29.3116,name="Free shotgun",sprite=158,color=0,cost=0,weapon={WEAPON.DBSHOTGUN},
                                                                                   ammo={         2}},
{x=583.83941650391,y=137.73428344727,z=99.47477722168,name="Automatic shotguns shop",sprite=158,color=1,cost=3350,weapon={WEAPON.ASSAULTSHOTGUN,WEAPON.AUTOSHOTGUN},
                                                                                                                        ammo={        16,         20}},   
{x=350.215,y=-995.235,z=29.4194,name="Revolver shop",sprite=156,color=2,cost=650,weapon={WEAPON.REVOLVER},
                                                                                  ammo={       60}},
{x=709.479,y=-886.535,z=23.3898,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.SNSPISTOL},
                                                                                   ammo={        6}},
{x=896.422,y=-1035.682,z=35.1090,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.MARKSMANPISTOL},
                                                                                        ammo={        1}},
{x=-794.145,y=-726.691,z=27.2788,name="Free shotgun",sprite=158,color=0,cost=0,weapon={WEAPON.MUSKET},
                                                                                  ammo={        3}},
{x=-1382.847,y=-640.499,z=28.6733,name="Shotguns shop",sprite=158,color=2,cost=1200,weapon={WEAPON.BULLPUPSHOTGUN},
                                                                                               ammo={       40}},
{x=-683.299,y=-172.938,z=37.8213,name="PDW shop",sprite=159,color=2,cost=1300,weapon={WEAPON.MINISMG},
                                                                                     ammo={     100}}, 
{x=488.65438842773,y=-1524.8050537109,z=29.29439163208,name="PDW shop",sprite=159,color=2,cost=700,weapon={WEAPON.MICROSMG},
                                                                                     ammo={      48}}, 
{x=-1502.926,y=130.437,z=55.6528,name="Assault shop",sprite=150,color=1,cost=3500,weapon={WEAPON.SMG,WEAPON.ASSAULTRIFLE},
                                                                                   ammo={      150,         150}},
{x=-425.912,y=535.400,z=122.2750,name="Automatic snipers shop",sprite=150,color=1,cost=5000,weapon={WEAPON.MARKSMANRIFLE},
                                                                                                              ammo={36}},
{x=189.880,y=308.841,z=105.390,name="Snipers shop",sprite=160,color=2,cost=3000,weapon={WEAPON.SNIPERRIFLE},
                                                                                                ammo={45}},  
{x=218.93112182617,y=-6.5031986236572,z=73.833969116211,name="Machine pistol shop",sprite=159,color=2,cost=1800,weapon={WEAPON.MACHINEPISTOL},
                                                                                                                              ammo={72}}, 
{x=223.21469116211,y=-7.9395785331726,z=73.768821716309,name="Assault rifle shop",sprite=150,color=2,cost=4000,weapon={WEAPON.BULLPUPRIFLE},
                                                                                                                              ammo={60}}, 
{x=230.89967346191,y=-10.898548126221,z=73.775741577148,name="Pipe bomb shop",sprite=152,color=2,cost=850,weapon={WEAPON.PIPEBOMB},
                                                                                                                       ammo={1}},
{x=260.4328918457,y=-15.770009040833,z=73.676902770996,name="Automatic pistol shop",sprite=159,color=1,cost=2500,weapon={WEAPON.APPISTOL},
                                                                                                                              ammo={36}},
{x=-718.22180175781,y=-1119.5183105469,z=10.652349472046,name="Grenade shop",sprite=152,color=2,cost=500,weapon={WEAPON.GRENADE},
                                                                                                                     ammo={1}},
{x=-723.23449707031,y=-1112.4810791016,z=10.652400970459,name="RPG shop",sprite=157,color=2,cost=5000,weapon={WEAPON.RPG},
                                                                                                                ammo={1}},
{x=239.01609802246,y=-14.013869285583,z=73.715599060059,name="Pistol shop",sprite=156,color=1,cost=2000,weapon={WEAPON.PISTOL50},
                                                                                                                     ammo={36}},
{x=1002.2705078125,y=-2160.6635742188,z=30.551578521729,name="Hunting shotgun shop",sprite=158,color=1,cost=1000,weapon={WEAPON.HEAVYSHOTGUN},
                                                                                                                                  ammo={36}},
{x=1013.5016479492,y=-2150.90234375,z=31.533716201782,name="Machinegun shop",sprite=173,color=2,cost=4200,weapon={WEAPON.MG},
                                                                                                                ammo={108}},
{x=257.08120727539,y=-1981.6202392578,z=21.430465698242,name="Free grenade",sprite=152,color=0,cost=0,weapon={WEAPON.MOLOTOV},
                                                                                                                   ammo={1}},
{x=268.04974365234,y=-1979.8137207031,z=21.466508865356,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.SNSPISTOL},
                                                                                                            ammo={        6}},
{x=-325.39294433594,y=-1348.5595703125,z=31.349042892456,name="Shotgun shop",sprite=158,color=2,cost=900,weapon={WEAPON.SAWNOFFSHOTGUN},
                                                                                                                    ammo={       40}},
{x=139.07206726074,y=324.00939941406,z=112.13865661621,name="Shotgun shop",sprite=158,color=2,cost=400,weapon={WEAPON.SAWNOFFSHOTGUN}, -- profs
                                                                                                                    ammo={       20}},
{x=-324.84808349609,y=-1356.3480224609,z=31.295696258545,name="Pistol shop",sprite=156,color=2,cost=300,weapon={WEAPON.PISTOL},
                                                                                                               ammo={    60}},
{x=-1017.3052368164,y=-2864.7678222656,z=13.951531410217,name="Parachute shop",sprite=377,color=0,cost=100,weapon={0xFBAB5776}, --parachute
                                                                                                               ammo={    1}}
}
local fbi_weaponshops={
{x=452.3713684082,y=-980.02044677734,z=30.689594268799,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.PISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={          36,                1,            1}},
{x=849.65454101563,y=-1284.3083496094,z=28.004722595215,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.PISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={          36,                1,            1}},
{x=-1106.8883056641,y=-845.83972167969,z=19.316970825195,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.PISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={          36,                1,            1}},
{x=535.39477539063,y=-22.057580947876,z=70.629531860352,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.PISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={          36,                1,            1}},
{x=-1057.9964599609,y=-840.76361083984,z=5.04252576828,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.PISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={          36,                1,            1}},
{x=369.66665649414,y=-1607.6519775391,z=29.29193687439,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.PISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={          36,                1,            1}},
{x=142.2840423584,y=-769.47924804688,z=242.1520690918,fbi=true,name="Free FBI weapons",sprite=150,color=3,cost=0,weapon={WEAPON.HEAVYPISTOL,WEAPON.CARBINERIFLE,WEAPON.SNIPERRIFLE,WEAPON.PUMPSHOTGUN},
                                                                                                                    ammo={         36,          60,         10,         16}}
}
local lost_weaponshops={
{x=977.75482177734,y=-101.76627349854,z=74.845115661621,name="Double barrel shotgun",sprite=158,color=62,cost=300,weapon={WEAPON.DBSHOTGUN},
                                                                                                                    ammo={      20}},
{x=977.36364746094,y=-92.444755554199,z=74.84513092041,name="Compact Rifle",sprite=150,color=62,cost=2800,weapon={WEAPON.COMPACTRIFLE},
                                                                                                            ammo={         90}},
{x=975.68902587891,y=-94.825485229492,z=74.84513092041,name="Pipe bomb",sprite=152,color=62,cost=800,weapon={WEAPON.PIPEBOMB},
                                                                                                       ammo={      1}},
{x=994.84680175781,y=-107.53675842285,z=74.07746887207,name="Molotov",sprite=152,color=62,cost=0,weapon={WEAPON.MOLOTOV},
                                                                                                   ammo={     1}},
{x=986.86175537109,y=-144.59301757813,z=74.271423339844,name="Automatic shotgun",sprite=158,color=62,cost=3000,weapon={WEAPON.AUTOSHOTGUN},
                                                                                                                 ammo={        20}}
}
local merc_weaponshops={
{x=581.33917236328,y=-3119.0949707031,z=18.768585205078,name="Free mercenary weapons",sprite=150,color=65,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.ADVANCEDRIFLE,WEAPON.ASSAULTSHOTGUN,WEAPON.COMBATMG},
                                                                                                                   ammo={                36,                 60,                     20,            100}}
}
local cartel_weaponshops={
{x=1410.2515869141,y=1145.1909179688,z=114.33390045166,name="Assault rifle",sprite=150,color=47,cost=2000,weapon={WEAPON.ASSAULTRIFLE},
                                                                                                                   ammo={      90}},
{x=1410.1848144531,y=1147.421875,z=114.33404541016,name="Shotgun",sprite=158,color=47,cost=800,weapon={WEAPON.PUMPSHOTGUN},
                                                                                                       ammo={      30}},
{x=1410.2707519531,y=1149.6201171875,z=114.33406066895,name="Pistol",sprite=156,color=47,cost=300,weapon={WEAPON.PISTOL},
                                                                                                       ammo={      60}},
{x=1409.2731933594,y=1164.7584228516,z=114.33419799805,name="Sniper rifle",sprite=160,color=47,cost=2000,weapon={WEAPON.SNIPERRIFLE},
                                                                                                                 ammo={      45}}
}
local elite_weaponshops={
{x=-589.04089355469,y=-135.42288208008,z=39.610240936279,name="Automatic pistol",sprite=156,color=4,cost=2000,weapon={WEAPON.APPISTOL},
                                                                                                                   ammo={      36}},
{x=-578.3896484375,y=-128.23263549805,z=40.008121490479,name="Assault rifle",sprite=150,color=4,cost=4000,weapon={WEAPON.SPECIALCARBINE},
                                                                                                                    ammo={      60}},
{x=-564.67071533203,y=-118.09973907471,z=40.008327484131,name="Sniper rifle",sprite=160,color=47,cost=5500,weapon={WEAPON.MARKSMANRIFLE},
                                                                                                       ammo={      42}}
}
local weaponshops=criminal_weaponshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_weaponshops)
    makeblips(fbi_weaponshops)
    makeblips(lost_weaponshops)
    makeblips(merc_weaponshops)
    makeblips(cartel_weaponshops)
    makeblips(elite_weaponshops)
    hideblips(fbi_weaponshops)
    hideblips(lost_weaponshops)
    hideblips(merc_weaponshops)
    hideblips(cartel_weaponshops)
    hideblips(elite_weaponshops)
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

local weapon_upgrades={}
weapon_upgrades.silencer={}
weapon_upgrades.silencer[WEAPON.PISTOL]=0x65EA7EBB

weapon_upgrades.silencer[WEAPON.VINTAGEPISTOL]=0xC304849A
weapon_upgrades.silencer[WEAPON.COMBATPISTOL]=0xC304849A
weapon_upgrades.silencer[WEAPON.APPISTOL]=0xC304849A
weapon_upgrades.silencer[WEAPON.HEAVYPISTOL]=0xC304849A
weapon_upgrades.silencer[WEAPON.SMG]=0xC304849A

weapon_upgrades.silencer[WEAPON.CARBINERIFLE]=0x837445AA
weapon_upgrades.silencer[WEAPON.ADVANCEDRIFLE]=0x837445AA
weapon_upgrades.silencer[WEAPON.BULLPUPRIFLE]=0x837445AA
weapon_upgrades.silencer[WEAPON.ASSAULTSHOTGUN]=0x837445AA
weapon_upgrades.silencer[WEAPON.MARKSMANRIFLE]=0x837445AA

weapon_upgrades.silencer[WEAPON.PISTOL50]=0xA73D4664
weapon_upgrades.silencer[WEAPON.MICROSMG]=0xA73D4664
weapon_upgrades.silencer[WEAPON.ASSAULTSMG]=0xA73D4664
weapon_upgrades.silencer[WEAPON.ASSAULTRIFLE]=0xA73D4664
weapon_upgrades.silencer[WEAPON.SPECIALCARBINE]=0xA73D4664
weapon_upgrades.silencer[WEAPON.BULLPUPRIFLE]=0xA73D4664
weapon_upgrades.silencer[WEAPON.HEAVYSHOTGUN]=0xA73D4664
weapon_upgrades.silencer[WEAPON.SNIPERRIFLE]=0xA73D4664

weapon_upgrades.silencer[WEAPON.PUMPSHOTGUN]=0xE608B35E


weapon_upgrades.extendedmag={}
weapon_upgrades.extendedmag[WEAPON.HEAVYSNIPER]=0xBC54DA77
weapon_upgrades.extendedmag[WEAPON.SNIPERRIFLE]=0xBC54DA77

weapon_upgrades.extendedmag[WEAPON.APPISTOL]=0x249A17D5
weapon_upgrades.extendedmag[WEAPON.HEAVYPISTOL]=0x64F9C62B
weapon_upgrades.extendedmag[WEAPON.SNSPISTOL]=0x7B0033B3
weapon_upgrades.extendedmag[WEAPON.SPECIALCARBINE]=0x7C8BD10E
weapon_upgrades.extendedmag[WEAPON.ASSAULTSHOTGUN]=0x86BD7F72
weapon_upgrades.extendedmag[WEAPON.ADVANCEDRIFLE]=0x8EC1C979
weapon_upgrades.extendedmag[WEAPON.BULLPUPRIFLE]=0xB3688B0F
weapon_upgrades.extendedmag[WEAPON.COMBATMG]=0xD6C59CD6
weapon_upgrades.extendedmag[WEAPON.PISTOL]=0xED265A1C
weapon_upgrades.extendedmag[WEAPON.COMBATPISTOL]=0xD67B4F2D
weapon_upgrades.extendedmag[WEAPON.PISTOL50]=0xD9D3AC92
weapon_upgrades.extendedmag[WEAPON.VINTAGEPISTOL]=0x33BA12E8
weapon_upgrades.extendedmag[WEAPON.MICROSMG]=0x10E6BA2B
weapon_upgrades.extendedmag[WEAPON.SMG]=0x350966FB
weapon_upgrades.extendedmag[WEAPON.ASSAULTSMG]=0xBB46E417
weapon_upgrades.extendedmag[WEAPON.COMBATPDW]=0x334A5203
weapon_upgrades.extendedmag[WEAPON.MG]=0x82158B47
weapon_upgrades.extendedmag[WEAPON.GUSENBERG]=0xEAC8C270
weapon_upgrades.extendedmag[WEAPON.ASSAULTRIFLE]=0xB1214F9B
weapon_upgrades.extendedmag[WEAPON.CARBINERIFLE]=0x91109691
weapon_upgrades.extendedmag[WEAPON.MARKSMANRIFLE]=0xCCFD2AC5
weapon_upgrades.extendedmag[WEAPON.HEAVYSHOTGUN]=0x971CF6FD


weapon_upgrades.flashlight={}
weapon_upgrades.flashlight[WEAPON.PISTOL]=0x359B7AAE
weapon_upgrades.flashlight[WEAPON.COMBATPISTOL]=0x359B7AAE
weapon_upgrades.flashlight[WEAPON.APPISTOL]=0x359B7AAE
weapon_upgrades.flashlight[WEAPON.HEAVYPISTOL]=0x359B7AAE
weapon_upgrades.flashlight[WEAPON.PISTOL50]=0x359B7AAE
weapon_upgrades.flashlight[WEAPON.MICROSMG]=0x359B7AAE

weapon_upgrades.flashlight[WEAPON.SMG]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.ASSAULTSMG]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.COMBATPDW]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.ASSAULTRIFLE]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.CARBINERIFLE]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.ADVANCEDRIFLE]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.SPECIALCARBINE]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.BULLPUPRIFLE]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.PUMPSHOTGUN]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.ASSAULTSHOTGUN]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.BULLPUPSHOTGUN]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.HEAVYSHOTGUN]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.MARKSMANRIFLE]=0x7BC4CDDC
weapon_upgrades.flashlight[WEAPON.GRENADELAUNCHER]=0x7BC4CDDC


weapon_upgrades.grip={}
weapon_upgrades.grip[WEAPON.COMBATPDW]=0xC164F53
weapon_upgrades.grip[WEAPON.ASSAULTRIFLE]=0xC164F53
weapon_upgrades.grip[WEAPON.CARBINERIFLE]=0xC164F53
weapon_upgrades.grip[WEAPON.SPECIALCARBINE]=0xC164F53
weapon_upgrades.grip[WEAPON.BULLPUPRIFLE]=0xC164F53
weapon_upgrades.grip[WEAPON.COMBATMG]=0xC164F53
weapon_upgrades.grip[WEAPON.ASSAULTSHOTGUN]=0xC164F53
weapon_upgrades.grip[WEAPON.BULLPUPSHOTGUN]=0xC164F53
weapon_upgrades.grip[WEAPON.HEAVYSHOTGUN]=0xC164F53
weapon_upgrades.grip[WEAPON.MARKSMANRIFLE]=0xC164F53
weapon_upgrades.grip[WEAPON.GRENADELAUNCHER]=0xC164F53


weapon_upgrades.regularclip={}
weapon_upgrades.regularclip[WEAPON.BULLPUPRIFLE]=0xC5A12F80
weapon_upgrades.regularclip[WEAPON.SPECIALCARBINE]=0xC6C7E581
weapon_upgrades.regularclip[WEAPON.HEAVYPISTOL]=0xD4A969A
weapon_upgrades.regularclip[WEAPON.COMBATMG]=0xE1FFB34A
weapon_upgrades.regularclip[WEAPON.SNSPISTOL]=0xF8802ED9

                                
weapon_upgrades.scope={}
weapon_upgrades.scope[WEAPON.MICROSMG]=0x9D2FBF29
weapon_upgrades.scope[WEAPON.ASSAULTSMG]=0x9D2FBF29
weapon_upgrades.scope[WEAPON.ASSAULTRIFLE]=0x9D2FBF29

weapon_upgrades.scope[WEAPON.CARBINERIFLE]=0xA0D89C42
weapon_upgrades.scope[WEAPON.SPECIALCARBINE]=0xA0D89C42
weapon_upgrades.scope[WEAPON.COMBATMG]=0xA0D89C42

weapon_upgrades.scope[WEAPON.COMBATPDW]=0xAA2C45B4
weapon_upgrades.scope[WEAPON.ADVANCEDRIFLE]=0xAA2C45B4
weapon_upgrades.scope[WEAPON.BULLPUPRIFLE]=0xAA2C45B4
weapon_upgrades.scope[WEAPON.GRENADELAUNCHER]=0xAA2C45B4

weapon_upgrades.scope[WEAPON.SNIPERRIFLE]=0xD2443DDC
weapon_upgrades.scope[WEAPON.HEAVYSNIPER]=0xD2443DDC

weapon_upgrades.scope[WEAPON.SMG]=0x3CC6BA57

weapon_upgrades.scope[WEAPON.MG]=0x3C00AFED
local criminal_weapon_upgrade_shops={
{x=1010.5590209961,y=-2190.1262207031,z=31.533477783203,name="Extended magazine",color=4,sprite=313,cost=200,upgrade=weapon_upgrades.extendedmag},
{x=-313.05096435547,y=-1332.7655029297,z=31.350290298462,name="Flashlight",color=4,sprite=313,cost=100,upgrade=weapon_upgrades.flashlight},
{x=214.48263549805,y=-1.5807383060455,z=74.25813293457,name="Grip",color=4,sprite=313,cost=50,upgrade=weapon_upgrades.grip},
{x=306.30133056641,y=-141.36608886719,z=67.770805358887,name="Scope",color=4,sprite=313,cost=500,upgrade=weapon_upgrades.scope},
{x=-169.53044128418,y=-1027.6402587891,z=27.27357673645,name="Silencer",color=4,sprite=313,cost=500,upgrade=weapon_upgrades.silencer}
}
local fbi_weapon_upgrade_shops={
{x=464.49899291992,y=-983.98010253906,z=39.891845703125,name="Flashlight",color=4,sprite=313,cost=0,upgrade=weapon_upgrades.flashlight},
{x=464.65417480469,y=-983.98345947266,z=35.891902923584,name="Scope",color=4,sprite=313,cost=0,upgrade=weapon_upgrades.scope}
}
local elite_weapon_upgrade_shops={
{x=-610.60870361328,y=-100.4864730835,z=42.934608459473,name="Silencer",color=4,sprite=313,cost=2000,upgrade=weapon_upgrades.silencer}
}
local cartel_weapon_upgrade_shops={
}
local merc_weapon_upgrade_shops={
}
local lost_weapon_upgrade_shops={
}

local weapon_upgrade_shops=criminal_weapon_upgrade_shops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_weapon_upgrade_shops)
    makeblips(fbi_weapon_upgrade_shops)
    makeblips(merc_weapon_upgrade_shops)
    makeblips(lost_weapon_upgrade_shops)
    makeblips(cartel_weapon_upgrade_shops)
    makeblips(elite_weapon_upgrade_shops)
    
    hideblips(fbi_weapon_upgrade_shops)
    hideblips(lost_weapon_upgrade_shops)
    hideblips(merc_weapon_upgrade_shops)
    hideblips(cartel_weapon_upgrade_shops)
    hideblips(elite_weapon_upgrade_shops)
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(weapon_upgrade_shops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 255, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        if player_money>=v.cost then
                            local ped=GetPlayerPed(-1)
                            local curweap=GetSelectedPedWeapon(GetPlayerPed(-1));
                            local upgradehash=v.upgrade[curweap]
                            if upgradehash then
                                if IsPedWeaponComponentActive(GetPlayerPed(-1),curweap,upgradehash) then
                                    SetNotificationTextEntry("STRING")
                                    AddTextComponentString("You already have "..v.name.." on this weapon.")
                                    DrawNotification(false, false)
                                    Wait(800)
                                else
                                    GiveWeaponComponentToPed(GetPlayerPed(-1),curweap,upgradehash)
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
                                AddTextComponentString("You can't attach "..v.name.." to this weapon.")
                                DrawNotification(false, false);
                                Wait(800)
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to buy weapon upgrade.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
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
{x=147.40942382813,y=-738.14141845703,z=242.15194702148,name="Armor",color=3,sprite=175,cost=0}
}
local lost_armorshops={
}
local merc_armorshops={
{x=566.830078125,y=-3117.5048828125,z=18.768550872803,name="Armor",color=65,sprite=175,cost=500}
}
local anarchy_armorshops={
{x=712.4091796875,y=-959.44964599609,z=30.39533996582,name="Armor",color=25,sprite=175,cost=500}
}
local cartel_armorshops={
{x=1409.0297851563,y=1159.9927978516,z=114.33424377441,name="Armor",color=47,sprite=175,cost=900}
}
local elite_armorshops={
{x=-615.16345214844,y=-110.46703338623,z=40.00834274292,name="Armor",color=4,sprite=175,cost=2000}
}
local armorshops=criminal_armorshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_armorshops)
    makeblips(fbi_armorshops)
    makeblips(merc_armorshops)
    makeblips(lost_armorshops)
    makeblips(anarchy_armorshops)
    makeblips(cartel_armorshops)
    makeblips(elite_armorshops)
    hideblips(fbi_armorshops)
    hideblips(lost_armorshops)
    hideblips(merc_armorshops)
    hideblips(anarchy_armorshops)
    hideblips(cartel_armorshops)
    hideblips(elite_armorshops)
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
{x=-17.331335067749,y=-1436.7751464844,z=31.101551055908,name="Medic",color=23,sprite=153,cost=1100}, -- grove
{x=84.54956817627,y=-1966.9985351563,z=20.747440338135,name="Medic",color=23,sprite=153,cost=1100}, -- ballas
{x=962.09649658203,y=-1830.5832519531,z=36.055534362793,name="Medic",color=23,sprite=153,cost=1100}, -- vagos
{x=1211.0631103516,y=-1607.6319580078,z=50.348274230957,name="Medic",color=23,sprite=153,cost=1100}, -- salva
{x=-787.1318359375,y=-911.865234375,z=18.091592788696,name="Medic",color=23,sprite=153,cost=1100}, -- triad
{x=-453.3876953125,y=-1736.9869384766,z=16.763284683228,name="Medic",color=23,sprite=153,cost=1100}, -- armenian
{x=253.44336,y=-1808.50635,z=27.113144,name="Medic",color=23,sprite=153,cost=1000},
{x=245.78915,y=-16.6738986,z=73.757812,name="Medic",color=23,sprite=153,cost=1500},
{x=1003.4803466797,y=-2143.5036621094,z=30.551580429077,name="Medic",color=23,sprite=153,cost=1150}
}
local fbi_medics={
{x=470.98806762695,y=-984.88824462891,z=30.689607620239,name="Medic",color=3,sprite=153,cost=0},
{x=139.62872314453,y=-747.20422363281,z=242.15194702148,name="Medic",color=3,sprite=153,cost=0},
{x=855.63909912109,y=-1285.5286865234,z=26.796737670898,name="Medic",color=3,sprite=153,cost=0},
{x=-1112.6473388672,y=-848.40319824219,z=13.440620422363,name="Medic",color=3,sprite=153,cost=0},
{x=-1078.9779052734,y=-856.30047607422,z=5.0424327850342,name="Medic",color=3,sprite=153,cost=0},
{x=371.49307250977,y=-1612.5402832031,z=29.291933059692,name="Medic",color=3,sprite=153,cost=0}
}
local lost_medics={
{x=980.94506835938,y=-98.249252319336,z=74.845077514648,name="Medic",color=62,sprite=153,cost=2200}
}
local merc_medics={
{x=562.81048583984,y=-3123.0014648438,z=18.768636703491,name="Medic",color=65,sprite=153,cost=0}
}
local anarchy_medics={
{x=705.71612548828,y=-966.90264892578,z=30.395343780518,name="Medic",color=25,sprite=153,cost=400}
}
local cartel_medics={
{x=1406.9233398438,y=1127.4875488281,z=114.33421325684,name="Medic",color=47,sprite=153,cost=600}
}
local elite_medics={
{x=-624.17456054688,y=-119.14496612549,z=39.608596801758,name="Medic",color=4,sprite=153,cost=2000}
}
local medics=criminal_medics

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_medics)
    makeblips(fbi_medics)
    makeblips(lost_medics)
    makeblips(merc_medics)
    makeblips(anarchy_medics)
    makeblips(cartel_medics)
    makeblips(elite_medics)
    hideblips(fbi_medics)
    hideblips(lost_medics)
    hideblips(merc_medics)
    hideblips(anarchy_medics)
    hideblips(cartel_medics)
    hideblips(elite_medics)
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

local criminal_clothes={
{x=71.19051361084,y=-1387.8325195313,z=29.376081466675,name="Change clothes",color=3,sprite=366},
{x=64.321250915527,y=-80.226173400879,z=62.507694244385,name="Change clothes",color=3,sprite=366},
{x=-613.09985351563,y=-599.75042724609,z=29.880842208862,name="Change clothes",color=3,sprite=366},
{x=268.81893920898,y=-1985.9591064453,z=20.413900375366,name="Change clothes",color=3,sprite=366},
{x=895.34643554688,y=-896.27484130859,z=27.791017532349,name="Change clothes",color=3,sprite=366},
{x=74.944374084473,y=-1970.9249267578,z=20.76586151123,name="Change clothes",color=3,sprite=366}, -- ballas
{x=938.88885498047,y=-1877.0637207031,z=32.473220825195,name="Change clothes",color=3,sprite=366}, -- vagos
{x=1214.3400878906,y=-1643.9964599609,z=48.64599609375,name="Change clothes",color=3,sprite=366}, -- SALVA
{x=-766.28356933594,y=-917.10601806641,z=21.279684066772,name="Change clothes",color=3,sprite=366}, -- china
{x=153.57015991211,y=306.04556274414,z=112.13385009766,name="Change clothes",color=3,sprite=366} -- HEISTERS
}
local fbi_clothes={
 {x=459.09851074219,y=-992.99127197266,z=30.689598083496,sprite=366,color=3,name="Change clothes"},
 {x=149.44277954102,y=-759.59631347656,z=242.1519317627,sprite=366,color=3,name="Change clothes"}
}
local lost_clothes={
 {x=971.94183349609,y=-98.397148132324,z=74.846138000488,sprite=366,color=62,name="Change clothes"}
}
local merc_clothes={
 {x=503.78283691406,y=-3121.8564453125,z=6.0697917938232,sprite=366,color=65,name="Change clothes"}
}
local anarchy_clothes={
 {x=704.94195556641,y=-962.00787353516,z=30.395341873169,sprite=366,color=25,name="Change clothes"}
}
local cartel_clothes={
 {x=1394.7595214844,y=1141.8107910156,z=114.61865997314,sprite=366,color=47,name="Change clothes"}
}
local elite_clothes={
 {x=-625.57727050781,y=-131.6939239502,z=39.008563995361,sprite=366,color=4,name="Change clothes"}
}
local clothes=criminal_clothes

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_clothes)
    makeblips(fbi_clothes)
    makeblips(lost_clothes)
    makeblips(merc_clothes)
    makeblips(anarchy_clothes)
    makeblips(cartel_clothes)
    makeblips(elite_clothes)
    hideblips(fbi_clothes)
    hideblips(lost_clothes)
    hideblips(merc_clothes)
    hideblips(anarchy_clothes)
    hideblips(cartel_clothes)
    hideblips(elite_clothes)
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
                        if math.random(0,1)==1 then
                            ClearAllPedProps(GetPlayerPed(-1));
                        else
                            SetPedRandomProps(GetPlayerPed(-1))
                        end
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
--{x=459.09851074219,y=-992.99127197266,z=30.689598083496,sprite=366,color=3,name="Change model",models={2072724299}}
}
local lost_skinshops={
--{x=971.94183349609,y=-98.397148132324,z=74.846138000488,sprite=366,color=62,name="Change model",models={1330042375,1032073858,850468060}}
}
local merc_skinshops={

}
local anarchy_skinshops={

}
local cartel_skinshops={

}
local elite_skinshops={

}
local criminal_skinshops={
--{x=-21.047414779663,y=-215.00874328613,z=46.176471710205,name="Change skin",color=3,sprite=362,models={-781039234,1567728751,1644266841,-252946718,
-- -198252413,588969535,361513884,599294057,-1022961931,-1868718465,-442429178,797459875,2014052797,1380197501,1250841910,189425762,808859815,-945854168,
-- 1077785853,-2077764712,-771835772,2021631368,600300561,-408329255,2114544056,-900269486,-994634286,1464257942,-1113448868,-1106743555,1146800212,
-- 1423699487,1982350912,-1606864033,1546450936,1068876755,1720428295,549978415,920595805,1984382277,-96953009,848542878,-933295480,1004114196,-1613485779,
-- 933205398,1633872967,-1954728090,-654717625,-1697435671,664399832,2120901815,-912318012,532905404,826475330,-1280051738,-1366884940,-1589423867,-1211756494,
-- -1382092357,-2063996617,1975732938,-1932625649,-907676309,261586155,-1176698112,275618457,2119136831,-9308122,-1463670378,610290475,1825562762,-1660909656,
-- -429715051,436345731,-1230338610,-673538407,-973145378,755956971,-37334073,1182012905,365775923,-459818001,-321892375,1952555184,-1688898956,-12678997,
-- 349680864,-2039072303,-730659924,-1674727288,579932932,1699403886,766375082,-628553422,-872673803,1976765073,-175076858,-1656894598,-173013091,-106498753,
-- -1538846349,1674107025,70821038,131961260,377976310,1371553700,712602007,1755064960,2010389054,-1434255461,1161072059,-795819184,-398748745,866411749,
-- -613248456,-2077218039,1309468115,-1806291497,-88831029,1641152947,951767867,373000027,728636342,1189322339,1165780219,331645324,-1313761614,466359675,
-- -2078561997,-294281201,-1453933154,1240094341,-775102410,-1519253631,115168927,330231874,793439294,1640504453,-1386944600,-1736970383,891398354,411102470,
-- 1169888870,2111372120,-1444213182,-685776591,-1001079621,815693290,-20018299,-396800478,-961242577,-1289578670,-1715797768,1099825042,1704428387,1809430156,
-- -512913663,813893651,1358380044,1822107721,2064532783,-264140789,343259175,2097407511,-2109222095,587703123,-1745486195,349505262,-1514497514,1312913862,
-- 429425116,42647445,348382215,51789996,-1768198658,-837606178,-1160266880,153984193,-573920724,706935758,225287241,-1452549652,2050158196,-835930287,
-- 767028979,-254493138,257763003,-422822692,-308279251,1459905209,-1105179493,-518348876,2040438510,-619494093,-1849016788,1530648845,891945583,611648169,
-- -1880237687,2093736314,1388848350,1204772502,-782401935,355916122,452351020,1090617681,696250687,1706635382,-1635724594,321657486,-538688539,1302784073,
-- 1401530684,-570394627,666718676,-610530921,-44746786,1330042375,1032073858,850468060,1985653476,-52653814,-527186490,803106487,-927261102,-46035440,
-- 2124742566,479578891,411185872,-1552967674,1005070462,1768677545,1466037421,1226102803,-578715987,-1109568186,653210662,832784782,-1773333796,-1302522190,
-- 810804565,-715445259,-317922106,1191548746,-886023758,1095737979,1573528872,-1358701087,1694362237,2007797722,-1922568579,1270514905,894928436,587253782,
-- -664900312,1822283721,-304305299,946007720,503621995,1264920838,-920443780,-568861381,-1124046095,-927525251,1746653202,1906124788,-283816889,1625728984,
-- 768005095,648372919,357551935,-322270187,1346941736,-1717894970,921110016,-2114499097,-982642292,1329576454,-1561829034,-1445349730,-2088436577,645279998,
-- 602513566,1681385341,1650036788,1936142927,-756833660,-449965460,1165307954,-554721426,-424905564,1624626906,-178150202,-1067576423,-709209345,-951490775,
-- 623927022,-2076336881,1064866854,1001210244,1024089777,-569505431,-855671414,1328415626,539004493,-681546704,1626646295,-1299428795,-1872961334,663522487,
-- 846439045,62440720,1794381917,-614546432,-1689993,-1371020112,416176080,-1452399100,1846684678,1055701597,1283141381,1767892582,-640198516,-1044093321,
-- -1342520604,-1332260293,32417469,193817059,-2034368986,1951946145,1039800368,744758650,1750583735,718836251,-417940021,-215821512,-1519524074,1519319503,
-- -1620232223,1082572151,-1398552374,-2018356203,-1948675910,238213328,-1007618204,-1023672578,-1976105999,-840346158,-1408326184,1535236204,-1852518909,
-- -812470807,-1731772337,941695432,-2039163396,-1029146878,915948376,469792763,-48477765,228715206,-829353047,-1837161693,605602864,919005580,-1222037748,
-- -356333586,824925120,-2063419726,-409745176,226559113,-597926235,2089096292,-1709285806,-1800524916,1426880966,1416254276,-1573167273,1728056212,847807830,
-- -892841148,-1661836925,1347814329,1446741360,-929103484,-1859912896,-566941131,1461287021,1787764635,1224306523,516505552,390939205,-1935621530,1404403376,
-- -521758348,-150026812,1498487404,1382414087,1614577886,-792862442,-905948951,1520708641,-995747907,-100858228,999748158,-1047300121,435429221,1264851357,
-- -625565461,1561705728,1561705728,933092024,534725268,-85696186,835315305,-1835459726,-1387498932,-1427838341,-1871275377,1426951581,1142162924,-1105135100,
-- -1643617475,233415434,-815646164,-236444766,-39239064,-984709238,-412008429,68070371,-261389155,1752208920,-1004861906,-1425378987,188012277}}
}
local skinshops=criminal_skinshops
    
Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_skinshops)
    makeblips(fbi_skinshops)
    makeblips(lost_skinshops)
    makeblips(merc_skinshops)
    makeblips(anarchy_skinshops)
    makeblips(cartel_skinshops)
    makeblips(elite_skinshops)
    hideblips(fbi_skinshops)
    hideblips(lost_skinshops)
    hideblips(merc_skinshops)
    hideblips(anarchy_skinshops)
    hideblips(cartel_skinshops)
    hideblips(elite_skinshops)
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
                        SetPedRandomProps(GetPlayerPed(-1));
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
--{x=-44.801700592041,y=-706.75598144531,z=32.727561950684,name="Mercenary",color=2,sprite=280,skins={275618457},weapons={WEAPON.PISTOL,WEAPON.SAWNOFFSHOTGUN,WEAPON.ASSAULTRIFLE,WEAPON.MACHINEPISTOL},cost=9500,armor=20,health=700},
--{x=-1153.6383056641,y=-1249.3861083984,z=7.1956105232239,name="Mercenary",color=2,sprite=280,skins={1746653202,1024089777,1794381917,193817059},weapons={WEAPON.PISTOL,WEAPON.SNSPISTOL,WEAPON.PUMPSHOTGUN},cost=5000,armor=0,health=300},
--{x=373.76196289063,y=-738.09985351563,z=29.269620895386,name="Bodyguard",color=2,sprite=280,skins={-245247470,691061163},weapons={WEAPON.COMBATPISTOL,WEAPON.HEAVYPISTOL,WEAPON.SMG,WEAPON.ADVANCEDRIFLE,WEAPON.BULLPUPSHOTGUN},cost=18000,armor=100,health=1300},
--{x=-1577.1640625,y=2101.6176757813,z=68.072256469727,name="Kisos",color=17,sprite=406,skins={307287994,1462895032},weapons={148160082,2578778090},cost=1000,armor=100}
}
local fbi_mercenaries={
--{x=459.51971435547,y=-989.71301269531,z=24.914873123169,name="Sidekick",color=3,sprite=280,skins={2072724299},weapons={WEAPON.HEAVYPISTOL,WEAPON.SMG,WEAPON.PUMPSHOTGUN},cost=0,armor=100,health=300}
}
local lost_mercenaries={
--{x=459.51971435547,y=-989.71301269531,z=24.914873123169,name="Sidekick",color=3,sprite=280,skins={2072724299},weapons={HEAVYPISTOL,SMG,PUMPSHOTGUN},cost=0,armor=100,health=300}
}
local merc_mercenaries={

}
local cartel_mercenaries={

}
local elite_mercenaries={

}
local mercenaries=criminal_mercenaries

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_mercenaries)
    makeblips(fbi_mercenaries)
    makeblips(lost_mercenaries)
    makeblips(merc_mercenaries)
    makeblips(cartel_mercenaries)
    makeblips(elite_mercenaries)
    hideblips(fbi_mercenaries)
    hideblips(lost_mercenaries)
    hideblips(merc_mercenaries)
    hideblips(cartel_mercenaries)
    hideblips(elite_mercenaries)
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
    {x=2964.9196777344,y=2747.6323242188,z=43.310658111572,name="Armored weaponized truck",color=1,sprite=229,cars={2434067162},cost=87500},
    {x=1463.7440185547,y=1128.9432373047,z=114.33376373291,name="Weaponized truck",color=2,sprite=229,cars={2198148358},cost=22000},
    {x=486.37924194336,y=-2159.6452636719,z=5.9258829498291,name="Armored car",color=1,sprite=380,cars={3406724313,1922255844,470404958,666166960,3862958888},cost=37500},
    {x=33.801235198975,y=-2671.1713867188,z=6.0175901794434,name="Armored truck",color=2,sprite=67,cars={1747439474,3089277354},cost=30000},
    {x=21.298585891724,y=-210.41683959961,z=52.857303619385,name="Offroad minivan",color=2,sprite=326,cars={1475773103},cost=17500},
    
    {x=-1798.862,y=2958.326,z=32.987,name="Besra",color=2,sprite=424,cars={1824333165},cost=2000},
    {x=-1830.172,y=2958.542,z=32.987,name="Hydra",color=2,sprite=424,cars={970385471},cost=8000},
    {x=-1816.536,y=2980.209,z=32.987,name="Laser",color=2,sprite=424,cars={-1281684762},cost=5000},
    {x=-944.155,y=-2975.342,z=13.954,name="Velum",color=2,sprite=251,cars={-1673356438,1077420264},cost=2000},
    {x=-932.973,y=-2981.526,z=13.954,name="Vestra",color=2,sprite=423,cars={1341619767},cost=2000},
    {x=-947.736,y=-3035.898,z=13.954,name="Mammatus",color=2,sprite=251,cars={-1746576111},cost=2000},
    {x=-955.232,y=-3031.343,z=13.954,name="Shamal",color=2,sprite=423,cars={-1214505995,621481054,-1214293858},cost=2000},
    {x=-970.393,y=-3022.119,z=13.954,name="Miljet",color=2,sprite=423,cars={165154707},cost=2000},
    --{x=-988.169,y=-3011.304,z=13.954,name="Titan",color=2,sprite=423,cars={1981688531},cost=0},
    {x=-931.253,y=-3003.082,z=13.954,name="Cuban",color=2,sprite=251,cars={-644710429},cost=500},
    {x=-961.615,y=-2966.009,z=13.954,name="Duster",color=2,sprite=251,cars={970356638},cost=500},
    {x=-916.020,y=-3012.285,z=13.954,name="Dodo",color=2,sprite=251,cars={-901163259},cost=1000},
    {x=-941.129,y=-2997.301,z=13.954,name="Nimbus",color=2,sprite=423,cars={-1295027632},cost=2000},
    --{x=-966.258,y=-2982.929,z=13.954,name="Jet",color=2,sprite=423,cars={1058115860},cost=0},
    {x=-852.734,y=-3322.492,z=13.954,name="Andromada",color=2,sprite=423,cars={368211810},cost=2000},
    {x=-977.706,y=-2999.949,z=13.954,name="Titan",color=2,sprite=423,cars={1981688531},cost=2000},
    {x=-1043.383,y=-3484.475,z=13.954,name="Jet",color=2,sprite=423,cars={1058115860},cost=2000},
    {x=-3335.1613769531,y=948.35125732422,z=.5,angle=106.388,name="Yacht",sprite=410,cars={-1043459709},cost=2000},
    {x=-1514.7365722656,y=-1441.3170166016,z=.5,name="Dinghy",cost=1000,sprite=404,cars={1033245328,276773164,509498602,867467158}},
    {x=-1510.7969970703,y=-1423.6053466797,z=.5,name="Suntrap",cost=1000,sprite=404,cars={-282946103}},
    {x=-1802.4645996094,y=-1236.2015380859,z=.5,angle=226,name="Seashark",cost=1000,sprite=471,cars={-1030275036,-616331036,-311022263}},
    {x=-1784.6004638672,y=-1229.9450683594,z=.5,name="Boat",cost=1000,sprite=404,cars={861409633,231083307,437538602,400514754,1070967343,908897389,290013743,1448677353}},
    {x=-81.586608886719,y=-2753.0405273438,z=.5,angle=181.54084777832,name="Tug",cost=1000,sprite=455,cars={-2100640717}},
    {x=580.20471191406,y=-3254.029296875,z=.5,angle=177.01123046875,name="Rent submarine",cost=500,sprite=308,cars={771711535,-1066334226},rent=true},
    {x=836.14477539063,y=-3192.9958496094,z=14.891183853149,angle=89.570419311523,name="Rent cargobob",cost=500,sprite=481,cars={-50547061,1621617168,1394036463,2025593404},rent=true},
    {x=-1621.7149658203,y=-3197.1267089844,z=14.0,angle=151.6248626709,name="Rent skylift",color=1,cost=3000,sprite=481,cars={1044954915},rent=true},
    {x=-7.4814505577087,y=-1072.8524169922,z=38.152011871338,sprite=326,name="Compact car shop",cost=6250,cars={-344943009,1039032026,1549126457,-1130810103,-1177863319,-431692672,-1450650718,841808271}},
    {x=-5.2188544273376,y=-1067.3846435547,z=38.152011871338,sprite=326,name="Two seat car shop",cost=12500,cars={1830407356,1078682497,-2124201592,330661258,-5153954,-591610296,-89291282,1349725314,873639469,-1122289213,-1193103848,2016857647}},
    {x=-3.1182959079742,y=-1062.6424560547,z=38.152011871338,sprite=326,name="Four seat car shop",cost=10000,cars={970598228,-391594584,-624529134,1348744438,-511601230,-1930048799,-1809822327,-1903012613,906642318,-2030171296,-685276541,1909141499,75131841,-1289722222,886934177,-1883869285,-1150599089,-1477580979,1723137093,-1894894188,-1008861746,1373123368,1777363799,-310465116,-1255452397,970598228}},
    {x=-1.2373449802399,y=-1058.4499511719,z=38.152011871338,sprite=326,name="Muscle car shop",cost=10000,cars={464687292,1531094468,-1205801634,-682211828,349605904,80636076,723973206,-2119578145,-1800170043,-1943285540,-2095439403,1507916787,-227741703,-1685021548,1923400478,972671128,-825837129,-498054846,2006667053}},
    {x=0.60717076063156,y=-1054.0606689453,z=38.152011871338,sprite=326,name="Off road car shop",cost=10000,cars={914654722,1645267888,-2045594037,-1189015600,989381445,850565707,-808831384,142944341,1878062887,634118882,2006918058,-789894171,683047626,1177543287,-1137532101,-1775728740,-1543762099,884422927,486987393,1269098716,-808457413,-1651067813,2136773105,1221512915,1337041428,1203490606,-16948145,1069929536}},
    {x=2.5292096138,y=-1048.0963134766,z=38.152011871338,sprite=326,name="Vans car shop",cost=7500,cars={-1346687836,1162065741,-119658072,-810318068,65402552,1026149675}},
    {x=507.46719360352,y=-1842.5042724609,z=27.686410903931,sprite=326,name="Used car shop",cost=300,cars={-2033222435,-667151410,523724515,-1435919434,1770332643,-1207771834,-1883002148,-14495224,1762279763,-120287622,-1311240698}},
    {x=186.72326660156,y=-1256.9447021484,z=29.198457717896,sprite=68,name="Rent tow truck",cost=100,cars={-1323100960,-442313018},rent=true},
    {x=-478.01977539063,y=-614.94030761719,z=31.1744556427,sprite=326,name="Sport car shop",cost=37500,cars={-1622444098,1123216662,767087018,-1041692462,1274868363,736902334,2072687711,-1045541610,108773431,196747873,-566387422,-1995326987,-1089039904,499169875,-1297672541,544021352,-1372848492,482197771,-142942670,-1461482751,-777172681,-377465520,-1934452204,1737773231,1032823388,719660200,-746882698,-1757836725,1886268224,384071873,-295689028}},
    {x=-1792.1674804688,y=458.46810913086,z=128.30819702148,sprite=326,name="Classic sport car shop",cost=60000,cars={-982130927,-1566741232,-1405937764,1887331236,941800958,223240013,1011753235,784565758,1051415893,-1660945322,-433375717,1545842587,-2098947590,1504306544}},
    {x=-64.245101928711,y=886.47015380859,z=235.82223510742,sprite=326,name="Super car shop",cost=200000,cars={-1216765807,-1696146015,-1311154784,-1291952903,1426219628,1234311532,418536135,-1232836011,1034187331,1093792632,1987142870,-1758137366,-1829802492,2123327359,234062309,819197656,1663218586,272929391,408192225,2067820283,338562499,1939284556,-1403128555,-2048333973,-482719877,917809321}},
    {x=-866.72729492188,y=-1122.9127197266,z=6.6089086532593,sprite=348,name="Motorcycle shop",cost=3500,cars={1672195559,-2140431165,86520421,1753414259,627535535,640818791,-1523428744,-634879114,-909201658,-893578776,-1453280962,788045382,1836027715,-140902153,-1353081087}},
    {x=103.67114257813,y=-2189.1770019531,z=5.9722423553467,sprite=477,name="Truck shop",cost=20000,cars={1518533038,569305213,-2137348917}},
    {x=845.18511962891,y=-2358.1569824219,z=30.337574005127,sprite=477,color=1,name="Upgraded Truck shop",cost=75000,cars={387748548,177270108}},
    {x=2380.8640136719,y=3039.5324707031,z=47.689258575439,angle=0.3908,sprite=477,color=1,name="Special modified truck",cost=60000,cars={-1649536104}}
    --{x=163.18153381348,y=-1282.4031982422,z=29.146518707275,name="KITT",color=2,sprite=460,cars={941494461},cost=300000},
    --{x=196.76313781738,y=-1498.1608886719,z=29.141607284546,name="Oppressor",color=2,sprite=226,cars={884483972},cost=400000}
}
local fbi_carshops={
    {x=447.36117553711,y=-997.20043945313,z=25.704141616821,angle=180.58967590332,fbi=true,sprite=56,color=3,name="Unmarked police car",cost=0,cars={-1973172295}},
    {x=452.33187866211,y=-997.36022949219,z=25.702560424805,angle=180.09335327148,fbi=true,sprite=56,color=3,name="Unmarked fast police car",cost=0,cars={1127131465}},
    {x=462.2532043457,y=-1014.6189575195,z=28.020277023315,angle=91.622131347656,fbi=true,sprite=56,color=3,name="Unmarked off road police car",cost=0,cars={-1647941228}},
    {x=462.19750976563,y=-1019.5223999023,z=28.034339904785,angle=92.353416442871,fbi=true,sprite=56,color=3,name="Fast police car",cost=0,cars={-1627000575}},
    {x=454.84698486328,y=-993.29400634766,z=43.691650390625,angle=87.682159423828,fbi=true,sprite=43,color=3,name="Helicopter",cost=0,cars={353883353}},
    {x=838.80291748047,y=-1265.0863037109,z=25.69623374939,angle=90.622627258301,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={2046537925}},
    {x=838.80291748047,y=-1265.0863037109,z=25.69623374939,angle=90.622627258301,fbi=true,sprite=56,color=3,name="Armored police car",cost=0,cars={456714581}},
    {x=-1124.6624755859,y=-839.30310058594,z=13.01847076416,angle=131.89108276367,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={1912215274}},
    {x=-1072.4680175781,y=-855.62969970703,z=4.4742360115051,angle=217.37126159668,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={1912215274}},
    {x=838.80291748047,y=-1265.0863037109,z=25.69623374939,angle=90.622627258301,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={2046537925}}
    
}
local lost_carshops={
    {x=985.50256347656,y=-137.88551330566,z=72.506202697754,angle=57.032344818115,rent=true,sprite=348,color=62,name="Bike",cost=500,cars={390201602,-1404136503,2006142190,741090084,301427732,-159126838,-1606187161,1873600305,-618617997,-1009268949,-570033273}}
}
local merc_carshops={
    {x=465.02291870117,y=-3191.2585449219,z=5.8632893562317,angle=359.83975219727,rent=true,sprite=326,color=65,name="Vehicle",cost=500,cars={-2064372143}}
}
local cartel_carshops={
    {x=1361.0843505859,y=1165.1298828125,z=113.19039154053,angle=181.92126464844,rent=true,sprite=326,color=47,name="Vehicle",cost=0,cars={-808831384,2006918058,486987393}}
}
local elite_carshops={
    {x=-607.05718994141,y=-128.43869018555,z=38.599277496338,angle=153.37510681152,rent=true,sprite=326,color=4,name="Vehicle",cost=0,cars={3406724313,1922255844,470404958,666166960,3862958888}}
}
local carshops=criminal_carshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_carshops)
    makeblips(fbi_carshops)
    makeblips(lost_carshops)
    makeblips(merc_carshops)
    makeblips(cartel_carshops)
    makeblips(elite_carshops)
    hideblips(fbi_carshops)
    hideblips(lost_carshops)
    hideblips(merc_carshops)
    hideblips(cartel_carshops)
    hideblips(elite_carshops)
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
                                    --TaskEnterVehicle(GetPlayerPed(-1),veh,1,-1,2.0,16,0)
                                    TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
                                    SetVehicleAsNoLongerNeeded(veh)
                                elseif v.rent then
                                    rentcar.veh=createcar(v.cars[math.random(#v.cars)],v.x,v.y,v.z,angle)
                                    local carblip=AddBlipForEntity(rentcar.veh)
                                    SetBlipSprite(carblip, v.sprite)
                                    SetBlipDisplay(carblip, 2)
                                    SetBlipScale(carblip, 0.6)
                                    SetBlipColour(carblip, 32)
                                    --TaskEnterVehicle(GetPlayerPed(-1),rentcar.veh,1,-1,2.0,16,0)
                                    TaskWarpPedIntoVehicle(GetPlayerPed(-1),rentcar.veh,-1)
                                    rentcar.net=networkingshit(rentcar.veh)
                                    rentcar.plate=GetVehicleNumberPlateText(rentcar.veh)
                                    sendcarplates()
                                else
                                    --TaskEnterVehicle(GetPlayerPed(-1),createmycar(v.cars[math.random(#v.cars)],v.x,v.y,v.z,angle),1,-1,2.0,16,0)
                                    TaskWarpPedIntoVehicle(GetPlayerPed(-1),createmycar(v.cars[math.random(#v.cars)],v.x,v.y,v.z,angle),-1)
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
    {x=938.67657470703,y=-1495.4936523438,z=29.806707382202,sprite=72,name="Car paint",cost=500,flags=repair_paint},
    {x=-25.218566894531,y=-1427.4871826172,z=30.051826477051,sprite=72,color=69,color1=53,color2=53,name="Car paint (green)",cost=300,flags=repair_paint},
    {x=86.025238037109,y=-1971.1588134766,z=20.80552482605,sprite=72,color=83,color1=145,color2=145,name="Car paint (purple)",cost=300,flags=repair_paint},
    {x=976.76489257813,y=-1828.8614501953,z=30.669563293457,sprite=72,color=46,color1=42,color2=42,name="Car paint (yellow)",cost=300,flags=repair_paint},
    {x=1252.4379882813,y=-1618.8044433594,z=52.929946899414,sprite=72,color=18,color1=68,color2=68,name="Car paint (light blue)",cost=300,flags=repair_paint},
    --{x=-763.970703125,y=-912.88842773438,z=18.307744979858,sprite=72,color=49,color1=39,color2=39,name="Car paint",cost=300,flags=repair_paint},
    {x=137.8140411377,y=316.54156494141,z=111.76704406738,sprite=72,color=45,color1=3,color2=3,name="Car paint (grey)",cost=300,flags=repair_paint}
    
}
local fbi_repairshops={
    {x=435.72744750977,y=-997.92150878906,z=25.358324050903,name="Full repair",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full},
    {x=431.58267211914,y=-998.01678466797,z=25.357425689697,name="Full repair",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full},
    {x=529.88568115234,y=-28.615762710571,z=69.973480224609,name="Full repair",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full},
    {x=-1121.361328125,y=-843.36505126953,z=12.998027801514,name="Full repair",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full},
    {x=377.84707641602,y=-1630.1400146484,z=27.98410987854,name="Full repair",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full}
}
local lost_repairshops={
    {x=964.72741699219,y=-119.6036529541,z=73.823089599609,name="Full repair",color=62,sprite=446,cost=100,flags=repair_full}
}
local merc_repairshops={
    { x=596.19378662109,y=-3134.685546875,z=5.8618764877319,name="Full repair",color=65,color1=133,color2=133,sprite=446,cost=500,flags=repair_full}
}
local anarchy_repairshops={
    { x=743.66284179688,y=-966.14147949219,z=23.924823760986,name="Full repair",color=25,sprite=446,cost=1500,flags=repair_full}
}
local cartel_repairshops={
    { x=1408.4490966797,y=1117.8303222656,z=114.46551513672,name="Full repair",color=47,sprite=446,cost=1500,flags=repair_full}
}
local elite_repairshops={
    { x=-576.98608398438,y=-130.2956237793,z=34.674560546875,name="Full repair",color=4,sprite=446,cost=2500,flags=repair_full}
}
local repairshops=criminal_repairshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(criminal_repairshops)
    makeblips(fbi_repairshops)
    makeblips(lost_repairshops)
    makeblips(merc_repairshops)
    makeblips(anarchy_repairshops)
    makeblips(cartel_repairshops)
    makeblips(elite_repairshops)
    hideblips(fbi_repairshops)
    hideblips(lost_repairshops)
    hideblips(merc_repairshops)
    hideblips(anarchy_repairshops)
    hideblips(cartel_repairshops)
    hideblips(elite_repairshops)
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
                                    if v.color1 and v.color2 then
                                        SetVehicleColours(veh,v.color1,v.color2)
                                    else
                                        SetVehicleColours(veh,math.random(0,160),math.random(0,160))
                                        if GetPlayerWantedLevel(player)<4 then
                                            SetPlayerWantedLevel(player,0,false)
                                        end
                                    end
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
        garages[k].color=3
    else
        garages[k].car=nil
        garages[k].name="Garage"
        garages[k].color=4
    end
    if garages[k].blip then
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(garages[k].name);
        EndTextCommandSetBlipName(garages[k].blip)
        SetBlipColour(garages[k].blip, garages[k].color)
    end
end)
    
Citizen.CreateThread(function()
    for k,v in pairs(garages) do
     v.name="Garage"
     v.sprite=357
     v.color=4
    end
    Wait(3000)
    makeblips(garages)
    while true do
        Wait(0)
        while not garages_enabled do Wait(5000) end --GetHashKey("PLAYER")
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(garages) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 1.5, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<16) and (not isDead) then
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
                            --TaskEnterVehicle(GetPlayerPed(-1),veh,1,-1,2.0,16,0)
                            TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
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

local allies_cops={}
allies_cops[GetHashKey("COP")]="cop"
allies_cops[GetHashKey("SECURITY_GUARD")]="security guard"
allies_cops[GetHashKey("CIVMALE")]="civilian"
allies_cops[GetHashKey("CIVFEMALE")]="civilian"
allies_cops[GetHashKey("FIREMAN")]="civilian"
allies_cops[GetHashKey("ARMY")]="soldier"
allies_cops[GetHashKey("MEDIC")]="civilian"

local allies_lost={}
--allies_lost[GetHashKey("AMBIENT_GANG_LOST")]="lost"
allies_lost[1330042375]="lost"
allies_lost[1032073858]="lost"
allies_lost[850468060]="lost"

local allies_mercs={}
--allies_mercs[GetHashKey("AGGRESSIVE_INVESTIGATE")]="merc"
allies_mercs[-1275859404]="merc"
allies_mercs[2047212121]="merc"
allies_mercs[1349953339]="merc"

local allies_anarchy={}
--allies_anarchy[GetHashKey("MISSION2")]="anarchist"
allies_anarchy[-1105135100]="anarchist"

local allies_ballas={}
--allies_ballas[GetHashKey("AMBIENT_GANG_BALLAS")]="ballas"
allies_ballas[-198252413]="ballas"
allies_ballas[588969535]="ballas"
allies_ballas[599294057]="ballas"

local allies_fams={}
--allies_fams[GetHashKey("AMBIENT_GANG_FAMILY")]="family member"
allies_fams[-398748745]="family member"
allies_fams[-613248456]="family member"
allies_fams[-2077218039]="family member"

local allies_vagos={}
--allies_vagos[GetHashKey("AMBIENT_GANG_MEXICAN")]="vagos"
allies_vagos[653210662]="vagos"
allies_vagos[832784782]="vagos"
allies_vagos[-1773333796]="vagos"

local allies_salva={}
--allies_salva[GetHashKey("AMBIENT_GANG_SALVA")]="salva"
allies_salva[-1872961334]="salva"
allies_salva[663522487]="salva"
allies_salva[846439045]="salva"
allies_salva[62440720]="salva"

local allies_triads={}
--allies_triads[GetHashKey("AMBIENT_GANG_WEICHENG")]="triad member"
allies_triads[891945583]="triad member"
allies_triads[611648169]="triad member"
allies_triads[-1880237687]="triad member"
allies_triads[2093736314]="triad member"
allies_triads[-1176698112]="triad member"
allies_triads[275618457]="triad member"
allies_triads[2119136831]="triad member"
allies_triads[-9308122]="triad member"

local allies_armmob={}
--allies_armmob[GetHashKey("AMBIENT_GANG_MARABUNTE")]="armenian mob"
allies_armmob[-236444766]="armenian mob"
allies_armmob[-39239064]="armenian mob"
allies_armmob[-984709238]="armenian mob"
allies_armmob[-412008429]="armenian mob"

local allies_heister={}
--allies_heister[GetHashKey("MISSION3")]="heister"
allies_heister[1822283721]="heister"

local allies_cartel={}
--allies_cartel[GetHashKey("AMBIENT_GANG_MEXICAN")]="cartel member"
allies_cartel[1329576454]="cartel member"
allies_cartel[-1561829034]="cartel member"

local allies_elite={}
--allies_elite[GetHashKey("MISSION4")]="elite security"
allies_elite[-245247470]="elite security"
allies_elite[691061163]="elite security"

local dont_kill_those=nil

local hide_phone_now=false

local function hide_blips_criminal() 
    hideblips(criminal_weaponshops)
    hideblips(criminal_armorshops)
    hideblips(criminal_medics)
    hideblips(criminal_clothes)
    hideblips(criminal_skinshops)
    hideblips(criminal_mercenaries)
    hideblips(criminal_carshops)
    hideblips(criminal_repairshops)
    hideblips(garages)
    hideblips(criminal_weapon_upgrade_shops)
end

local function show_blips_criminal()
    showblips(criminal_weaponshops)
    showblips(criminal_armorshops)
    showblips(criminal_medics)
    showblips(criminal_clothes)
    showblips(criminal_skinshops)
    showblips(criminal_mercenaries)
    showblips(criminal_carshops)
    showblips(criminal_repairshops)
    showblips(garages)
    showblips(criminal_weapon_upgrade_shops)
end

local function show_blips_lost()
    showblips(lost_carshops)
    showblips(lost_weaponshops)
    showblips(lost_medics)
    showblips(lost_skinshops)
    showblips(lost_repairshops)
    showblips(lost_mercenaries)
    showblips(lost_armorshops)
    showblips(lost_clothes)
    showblips(lost_weapon_upgrade_shops)
end

local function hide_blips_lost()
    hideblips(lost_carshops)
    hideblips(lost_weaponshops)
    hideblips(lost_medics)
    hideblips(lost_skinshops)
    hideblips(lost_repairshops)
    hideblips(lost_mercenaries)
    hideblips(lost_armorshops)
    hideblips(lost_clothes)
    hideblips(lost_weapon_upgrade_shops)
end

local function show_blips_fbi()
    showblips(fbi_carshops)
    showblips(fbi_weaponshops)
    showblips(fbi_medics)
    showblips(fbi_skinshops)
    showblips(fbi_repairshops)
    showblips(fbi_mercenaries)
    showblips(fbi_armorshops)
    showblips(fbi_clothes)
    showblips(fbi_weapon_upgrade_shops)
end

local function hide_blips_fbi()
    hideblips(fbi_carshops)
    hideblips(fbi_weaponshops)
    hideblips(fbi_medics)
    hideblips(fbi_skinshops)
    hideblips(fbi_repairshops)
    hideblips(fbi_mercenaries)
    hideblips(fbi_armorshops)
    hideblips(fbi_clothes)
    hideblips(fbi_weapon_upgrade_shops)
end

local function show_blips_merc()
    showblips(merc_carshops)
    showblips(merc_weaponshops)
    showblips(merc_medics)
    showblips(merc_skinshops)
    showblips(merc_repairshops)
    showblips(merc_mercenaries)
    showblips(merc_armorshops)
    showblips(merc_clothes)
    showblips(merc_weapon_upgrade_shops)
end

local function hide_blips_merc()
    hideblips(merc_carshops)
    hideblips(merc_weaponshops)
    hideblips(merc_medics)
    hideblips(merc_skinshops)
    hideblips(merc_repairshops)
    hideblips(merc_mercenaries)
    hideblips(merc_armorshops)
    hideblips(merc_clothes)
    hideblips(merc_weapon_upgrade_shops)
end

local function show_blips_anarchy()
    showblips(anarchy_medics)
    showblips(anarchy_skinshops)
    showblips(anarchy_repairshops)
    showblips(anarchy_armorshops)
    showblips(anarchy_clothes)
end

local function hide_blips_anarchy()
    hideblips(anarchy_medics)
    hideblips(anarchy_skinshops)
    hideblips(anarchy_repairshops)
    hideblips(anarchy_armorshops)
    hideblips(anarchy_clothes)
end

local function show_blips_cartel()
    showblips(cartel_carshops)
    showblips(cartel_weaponshops)
    showblips(cartel_medics)
    showblips(cartel_skinshops)
    showblips(cartel_repairshops)
    showblips(cartel_mercenaries)
    showblips(cartel_armorshops)
    showblips(cartel_clothes)
    showblips(cartel_weapon_upgrade_shops)
end

local function hide_blips_cartel()
    hideblips(cartel_carshops)
    hideblips(cartel_weaponshops)
    hideblips(cartel_medics)
    hideblips(cartel_skinshops)
    hideblips(cartel_repairshops)
    hideblips(cartel_mercenaries)
    hideblips(cartel_armorshops)
    hideblips(cartel_clothes)
    hideblips(cartel_weapon_upgrade_shops)
end

local function show_blips_elite()
    showblips(elite_carshops)
    showblips(elite_weaponshops)
    showblips(elite_medics)
    showblips(elite_skinshops)
    showblips(elite_repairshops)
    showblips(elite_mercenaries)
    showblips(elite_armorshops)
    showblips(elite_clothes)
    showblips(elite_weapon_upgrade_shops)
end

local function hide_blips_elite()
    hideblips(elite_carshops)
    hideblips(elite_weaponshops)
    hideblips(elite_medics)
    hideblips(elite_skinshops)
    hideblips(elite_repairshops)
    hideblips(elite_mercenaries)
    hideblips(elite_armorshops)
    hideblips(elite_clothes)
    hideblips(elite_weapon_upgrade_shops)
end

switch_to_criminal=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("PLAYER")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    show_blips_criminal()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_merc()
    hide_blips_anarchy()
    showblips(join_faction)
    medics=criminal_medics
    skinshops=criminal_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=criminal_repairshops
    mercenaries=criminal_mercenaries
    armorshops=criminal_armorshops
    clothes=criminal_clothes
    weapon_upgrade_shops=criminal_weapon_upgrade_shops
    garages_enabled=true
    player_is_cop=false
    dont_kill_those=nil
    SetMaxWantedLevel(5);
end

switch_to_lost=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("AMBIENT_GANG_LOST")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_criminal()
    hide_blips_fbi()
    hide_blips_merc()
    hide_blips_anarchy()
    show_blips_lost()
    hideblips(join_faction)
    medics=lost_medics
    skinshops=lost_skinshops
    weaponshops=lost_weaponshops
    carshops=lost_carshops
    repairshops=lost_repairshops
    mercenaries=lost_mercenaries
    armorshops=lost_armorshops
    clothes=lost_clothes
    weapon_upgrade_shops=lost_weapon_upgrade_shops
    garages_enabled=false
    player_is_cop=false
    dont_kill_those=allies_lost
    SetMaxWantedLevel(5);
end

switch_to_cop=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_criminal()
    show_blips_fbi()
    hide_blips_lost()
    hide_blips_merc()
    hide_blips_anarchy()
    hideblips(join_faction)
    medics=fbi_medics
    skinshops=fbi_skinshops
    weaponshops=fbi_weaponshops
    carshops=fbi_carshops
    repairshops=fbi_repairshops
    mercenaries=fbi_mercenaries
    armorshops=fbi_armorshops
    clothes=fbi_clothes
    weapon_upgrade_shops=fbi_weapon_upgrade_shops
    garages_enabled=false
    player_is_cop=true
    dont_kill_those=allies_cops
    SetMaxWantedLevel(0);
end

switch_to_merc=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("AGGRESSIVE_INVESTIGATE")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_criminal()
    show_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    hideblips(join_faction)
    medics=merc_medics
    skinshops=merc_skinshops
    weaponshops=merc_weaponshops
    carshops=merc_carshops
    repairshops=merc_repairshops
    mercenaries=merc_mercenaries
    armorshops=merc_armorshops
    clothes=merc_clothes
    weapon_upgrade_shops=merc_weapon_upgrade_shops
    garages_enabled=false
    player_is_cop=false
    dont_kill_those=allies_mercs
    SetMaxWantedLevel(5);
end

switch_to_anarchy=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("MISSION2")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hideblips(criminal_medics)
    hideblips(criminal_skinshops)
    hideblips(criminal_repairshops)
    hideblips(criminal_armorshops)
    hideblips(criminal_clothes)
    showblips(criminal_weaponshops)
    showblips(criminal_mercenaries)
    showblips(criminal_carshops)
    showblips(criminal_weapon_upgrade_shops)
    show_blips_anarchy()
    showblips(garages)
    hideblips(join_faction)
    medics=anarchy_medics
    skinshops=anarchy_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=anarchy_repairshops
    mercenaries=criminal_mercenaries
    armorshops=anarchy_armorshops
    clothes=anarchy_clothes
    weapon_upgrade_shops=criminal_weapon_upgrade_shops
    garages_enabled=true
    player_is_cop=false
    dont_kill_those=allies_anarchy
    SetMaxWantedLevel(5);
end

switch_to_ballas=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("AMBIENT_GANG_BALLAS")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    hide_blips_cartel()
    hide_blips_elite()
    show_blips_criminal()
    hideblips(join_faction)
    medics=criminal_medics
    skinshops=criminal_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=criminal_repairshops
    mercenaries=criminal_mercenaries
    armorshops=criminal_armorshops
    clothes=criminal_clothes
    weapon_upgrade_shops=criminal_weapon_upgrade_shops
    garages_enabled=true
    player_is_cop=false
    dont_kill_those=allies_ballas
    SetMaxWantedLevel(5);
end

switch_to_fams=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("AMBIENT_GANG_FAMILY")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    hide_blips_cartel()
    hide_blips_elite()
    show_blips_criminal()
    hideblips(join_faction)
    medics=criminal_medics
    skinshops=criminal_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=criminal_repairshops
    mercenaries=criminal_mercenaries
    armorshops=criminal_armorshops
    clothes=criminal_clothes
    weapon_upgrade_shops=criminal_weapon_upgrade_shops
    garages_enabled=true
    player_is_cop=false
    dont_kill_those=allies_fams
    SetMaxWantedLevel(5);
end

switch_to_vagos=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("AMBIENT_GANG_MEXICAN")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    hide_blips_cartel()
    hide_blips_elite()
    show_blips_criminal()
    hideblips(join_faction)
    medics=criminal_medics
    skinshops=criminal_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=criminal_repairshops
    mercenaries=criminal_mercenaries
    armorshops=criminal_armorshops
    clothes=criminal_clothes
    weapon_upgrade_shops=criminal_weapon_upgrade_shops
    garages_enabled=true
    player_is_cop=false
    dont_kill_those=allies_vagos
    SetMaxWantedLevel(5);
end

switch_to_salva=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("AMBIENT_GANG_SALVA")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    hide_blips_cartel()
    hide_blips_elite()
    show_blips_criminal()
    hideblips(join_faction)
    medics=criminal_medics
    skinshops=criminal_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=criminal_repairshops
    mercenaries=criminal_mercenaries
    armorshops=criminal_armorshops
    clothes=criminal_clothes
    weapon_upgrade_shops=criminal_weapon_upgrade_shops
    garages_enabled=true
    player_is_cop=false
    dont_kill_those=allies_salva
    SetMaxWantedLevel(5);
end

switch_to_triads=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("AMBIENT_GANG_WEICHENG")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    hide_blips_cartel()
    hide_blips_elite()
    show_blips_criminal()
    hideblips(join_faction)
    medics=criminal_medics
    skinshops=criminal_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=criminal_repairshops
    mercenaries=criminal_mercenaries
    armorshops=criminal_armorshops
    clothes=criminal_clothes
    weapon_upgrade_shops=criminal_weapon_upgrade_shops
    garages_enabled=true
    player_is_cop=false
    dont_kill_those=allies_triads
    SetMaxWantedLevel(5);
end

switch_to_armmob=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("AMBIENT_GANG_MARABUNTE")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    hide_blips_cartel()
    hide_blips_elite()
    show_blips_criminal()
    hideblips(join_faction)
    medics=criminal_medics
    skinshops=criminal_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=criminal_repairshops
    mercenaries=criminal_mercenaries
    armorshops=criminal_armorshops
    clothes=criminal_clothes
    weapon_upgrade_shops=criminal_weapon_upgrade_shops
    garages_enabled=true
    player_is_cop=false
    dont_kill_those=allies_armmob
    SetMaxWantedLevel(5);
end

switch_to_heister=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("MISSION3")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    hide_blips_cartel()
    hide_blips_elite()
    show_blips_criminal()
    hideblips(join_faction)
    medics=criminal_medics
    skinshops=criminal_skinshops
    weaponshops=criminal_weaponshops
    carshops=criminal_carshops
    repairshops=criminal_repairshops
    mercenaries=criminal_mercenaries
    armorshops=criminal_armorshops
    clothes=criminal_clothes
    weapon_upgrade_shops=criminal_weapon_upgrade_shops
    garages_enabled=true
    player_is_cop=false
    dont_kill_those=allies_heister
    SetMaxWantedLevel(5);
end

switch_to_cartel=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("AMBIENT_GANG_MEXICAN")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_criminal()
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    --hide_blips_cartel()
    hide_blips_elite()
    show_blips_cartel()
    hideblips(join_faction)
    medics=cartel_medics
    skinshops=cartel_skinshops
    weaponshops=cartel_weaponshops
    carshops=cartel_carshops
    repairshops=cartel_repairshops
    mercenaries=cartel_mercenaries
    armorshops=cartel_armorshops
    clothes=cartel_clothes
    weapon_upgrade_shops=cartel_weapon_upgrade_shops
    garages_enabled=false
    player_is_cop=false
    dont_kill_those=allies_cartel
    SetMaxWantedLevel(5);
end

switch_to_elite=function()
    hide_phone_now=true
    Wait(30)
    relationship_friend=GetHashKey("MISSION4")
    SetPedRelationshipGroupHash(GetPlayerPed(-1),relationship_friend)
    hide_blips_criminal()
    hide_blips_merc()
    hide_blips_fbi()
    hide_blips_lost()
    hide_blips_anarchy()
    hide_blips_cartel()
    --hide_blips_elite()
    show_blips_elite()
    hideblips(join_faction)
    medics=elite_medics
    skinshops=elite_skinshops
    weaponshops=elite_weaponshops
    carshops=elite_carshops
    repairshops=elite_repairshops
    mercenaries=elite_mercenaries
    armorshops=elite_armorshops
    clothes=elite_clothes
    weapon_upgrade_shops=elite_weapon_upgrade_shops
    garages_enabled=false
    player_is_cop=false
    dont_kill_those=allies_elite
    SetMaxWantedLevel(5);
end

table.insert(join_faction,{func=switch_to_cop,x=441.19030761719,y=-981.13079833984,z=30.689605712891,sprite=60,color=3,markercolor={128, 128, 255, 128},cost=25000,name="Join FBI",models={2072724299}})
table.insert(join_faction,{func=switch_to_cop,x=115.88011169434,y=-748.78686523438,z=45.7516746521,sprite=60,color=3,markercolor={128, 128, 255, 128},cost=25000,name="Join FBI",models={2072724299}})
table.insert(join_faction,{func=switch_to_lost,x=984.76843261719,y=-91.682571411133,z=74.848892211914,sprite=378,color=62,markercolor={150, 150, 150, 128},cost=5000,name="Join Lost M.C.",models={1032073858,1330042375,850468060}})
table.insert(join_faction,{func=switch_to_merc,x=484.337890625,y=-3052.2468261719,z=6.2286891937256,sprite=431,color=65,markercolor={150, 150, 200, 128},cost=25000,name="Join Mercs",models={-1275859404,2047212121,1349953339}})
table.insert(join_faction,{func=switch_to_anarchy,x=707.38952636719,y=-967.00140380859,z=30.412853240967,sprite=442,color=25,markercolor={150, 150, 200, 128},cost=15000,name="Join Anarchists",models={-1105135100}})
table.insert(join_faction,{func=switch_to_ballas,x=78.277633666992,y=-1974.7937011719,z=20.911375045776,sprite=491,color=83,markercolor={200, 0, 200, 128},cost=0,name="Join Ballas",models={-198252413,588969535,599294057}})
table.insert(join_faction,{func=switch_to_fams,x=-11.148657798767,y=-1433.2587890625,z=31.116823196411,sprite=491,color=69,markercolor={0, 200, 0, 128},cost=0,name="Join Families",models={-398748745,-613248456,-2077218039}})
table.insert(join_faction,{func=switch_to_vagos,x=967.79791259766,y=-1828.583984375,z=31.236526489258,sprite=491,color=46,markercolor={200, 200, 0, 128},cost=0,name="Join Vagos",models={653210662,832784782,-1773333796}})
table.insert(join_faction,{func=switch_to_salva,x=1230.8974609375,y=-1591.1851806641,z=53.820705413818,sprite=491,color=18,markercolor={0, 0, 200, 128},cost=0,name="Join Salva",models={-1872961334,663522487,846439045,62440720}})
table.insert(join_faction,{func=switch_to_triads,x=-775.37646484375,y=-890.73687744141,z=21.605070114136,sprite=491,color=49,markercolor={200, 0, 0, 128},cost=0,name="Join Triads",models={891945583,611648169,-1880237687,2093736314,-1176698112,275618457,2119136831,-9308122}})
table.insert(join_faction,{func=switch_to_armmob,x=-429.05123901367,y=-1728.0805664063,z=19.783840179443,sprite=491,color=65,markercolor={200, 0, 0, 128},cost=0,name="Join Armenian Mobs",models={-236444766,-39239064,-984709238,-412008429}})
table.insert(join_faction,{func=switch_to_heister,x=134.90467834473,y=323.68109130859,z=116.72046661377,sprite=362,color=45,markercolor={125, 125, 125, 128},cost=10000,name="Join Heisters",models={1822283721}})
table.insert(join_faction,{func=switch_to_cartel,x=1394.7595214844,y=1141.8107910156,z=114.61865997314,sprite=84,color=47,markercolor={125, 125, 125, 128},cost=15000,name="Join Cartel",models={1329576454,-1561829034}})
table.insert(join_faction,{func=switch_to_elite,x=-625.57727050781,y=-131.6939239502,z=39.008563995361,sprite=432,color=4,markercolor={255, 255, 255, 128},cost=50000,name="Join Elite Security",models={-245247470,691061163}})


local function kick_from_faction(reason)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(reason)
    DrawNotification(false, false);
    --DoScreenFadeOut(1000);
    if not IsPedInAnyVehicle(GetPlayerPed(-1),false) then
        Wait(2000)
        local animdict="combat@damage@injured_pistol@to_writhe"
        local anim="variation_b"
        if not HasAnimDictLoaded(animdict) then
         RequestAnimDict(animdict)
         while not HasAnimDictLoaded(animdict) do Wait(10) end
        end
        TaskPlayAnim(GetPlayerPed(-1), animdict, anim, 1.0, 1.0, 10000, 0, 0, 0, 0, 0);
    end
    Wait(6250)
    SetEntityHealth(GetPlayerPed(-1),0.0)
    switch_to_criminal()
end

-- local function cop_killed_ped(ped,how)
    -- local relgroup=GetPedRelationshipGroupHash(ped)
    -- if relgroup==1862763509 then --GetHashKey("PLAYER")
        -- if GetEntityModel(ped)==2072724299 then --FBI model
            -- kick_from_faction("~r~You "..how.." another FIB agent.")
        -- end
    -- elseif dont_kill_those[relgroup] then
        -- kick_from_faction("~r~You "..how.." "..dont_kill_those[relgroup]..".")
    -- end
-- end

-- local function gang_member_killed_ped(ped,how)
    -- local relgroup=GetPedRelationshipGroupHash(ped)
    -- if relgroup==1862763509 then --GetHashKey("PLAYER")
        -- local hash=GetEntityModel(ped)
        -- if dont_kill_those[hash] then --check model
            -- kick_from_faction("~r~You "..how.." another "..dont_kill_those[hash]..".")
        -- end
    -- elseif dont_kill_those[relgroup] then
        -- kick_from_faction("~r~You "..how.." "..dont_kill_those[relgroup]..".")
    -- end
    
    -- local hash=GetEntityModel(ped)
    -- if hash==1330042375 or hash==1032073858 or hash==850468060 then --1 2 3
        -- kick_from_faction("~r~You "..how.." another lost.")
    -- elseif relationship_friend==GetPedRelationshipGroupHash(ped) then
        -- kick_from_faction("~r~You "..how.." another lost.")
    -- end
-- end

local function cop_killed_ped(ped,how)
    local name=dont_kill_those[GetPedRelationshipGroupHash(ped)]
    if name then
        kick_from_faction("~r~You "..how.." "..name..".")
    else
        name=dont_kill_those[GetEntityModel(ped)]
        if name then
            kick_from_faction("~r~You "..how.." "..name..".")
        end
    end
end

local function gang_member_killed_ped(ped,how)
    local name=dont_kill_those[GetEntityModel(ped)]
    if name then
        kick_from_faction("~r~You "..how.." "..name..".")
    else
        name=dont_kill_those[GetPedRelationshipGroupHash(ped)]
        if name then
            kick_from_faction("~r~You "..how.." "..name..".")
        end
    end
end

Citizen.CreateThread(function()
Wait(6500)
    makeblips(join_faction)
    while true do
        Wait(10)
        local you=GetPlayerPed(-1)
        local faction=GetPedRelationshipGroupHash(you)
        if player_is_cop then
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
        elseif faction~=1862763509 and dont_kill_those then --GetHashKey("PLAYER")
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
                        gang_member_killed_ped(ped,"killed")
                    elseif killer==your_car then
                        gang_member_killed_ped(ped,"ran over")
                    end
                end
            else
                for ped in EnumeratePeds() do
                    local killer=GetPedKiller(ped)
                    if killer==you then
                        gang_member_killed_ped(ped,"killed")
                    end
                end
            end
        else
            pos=GetEntityCoords(GetPlayerPed(-1))
            for k,v in pairs(join_faction) do
                local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
                if square<100 then
                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, v.markercolor[1],v.markercolor[2],v.markercolor[3],v.markercolor[4], false, true, 2, false, false, false, false)
                    if (square<4) and (not isDead) then
                        if IsControlPressed(0, 86) and player_wanted==0 and player_money and player_money>=v.cost then
                            local model=v.models[math.random(#v.models)]
                            RequestModel(model)
                            while not HasModelLoaded(model) do Wait(10) end
                            SetPlayerModel(PlayerId(),model)
                            SetModelAsNoLongerNeeded(model)
                            SetPedRandomComponentVariation(GetPlayerPed(-1), false)
                            SetPedRandomProps(GetPlayerPed(-1));
                            v.func()
                            Wait(1000)
                        else
                            SetTextComponentFormat("STRING")
                            AddTextComponentString("You need to have ~g~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to ~g~"..v.name.."~s~.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                            --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                            DisplayHelpTextFromStringLabel(0,0,1,-1)
                        end
                    end
                end
            end
        end
    end
end)

local function phone_background(phone)
    DrawSprite(phone.dict,phone.sprite,.5,.5,1.0,1.0,.0,phone.bgcolor[1],phone.bgcolor[2],phone.bgcolor[3],phone.bgcolor[4])
end

local function phone_text(text,offset,phone,multilines)
    SetTextColour(255, 255, 255, 255);
    --SetTextDropshadow(3, 0, 0, 0, 255);
    --SetTextDropShadow();
    --SetTextEdge(1000, 255, 0, 0, 255);
    if type(text)~='string' then
        SetTextWrap(0.0,10.0)
        local o=offset
        for k,v in pairs(text) do
            if o>-phone.cursor_step then
                SetTextFont(phone.font)
                SetTextOutline()
                SetTextScale(phone.scale[1], phone.scale[2])
                SetTextEntry("STRING")
                AddTextComponentString(v)
                EndTextCommandDisplayText(.05, o)
            end
            if multilines then
                o=o+phone.cursor_step*multilines[k]
            else
                o=o+phone.cursor_step
            end
            if o>1.0 then break end
        end
        SetTextWrap(0.0,1.0)
    else
        SetTextFont(phone.font)
        SetTextOutline()
        SetTextScale(phone.scale[1], phone.scale[2])
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(.05, offset)
    end
end

local function phone_print(text,phone)
    SetTextRenderId(GetMobilePhoneRenderId());
    phone_background(phone)
    phone_text(text,phone.text_offset,phone)
    SetTextRenderId(1);
end

local function phone_menu(text,func,phone)
    local half_step=phone.cursor_step*.5
    local cursor=1
    local offset=phone.text_offset
    local cursor_offset=offset-half_step
    local multilines={}
    SetTextRenderId(GetMobilePhoneRenderId());
    for k,v in pairs(text) do
        SetTextFont(phone.font)
        SetTextScale(phone.scale[1], phone.scale[2])
        --BeginTextCommandLineCount("STRING")
        --AddTextComponentString(v)
        --multilines[k]=EndTextCommandGetLineCount(.05,.0)
        BeginTextCommandWidth("STRING")
        AddTextComponentString(v)
        multilines[k]=EndTextCommandGetWidth(phone.font)
        print(multilines[k],phone.scale[1],phone.scale[2])
        if multilines[k]<phone.width then
        multilines[k]=1
        else
        multilines[k]=2
        end
    end
    SetTextRenderId(1);
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if IsControlJustPressed(0,172) then --up
         if cursor>1 then
          cursor=cursor-1
         else
          cursor=#func
         end
        elseif IsControlJustPressed(0,173) then --down
         if cursor<#func then
          cursor=cursor+1
         else
          cursor=1
         end
        elseif IsControlJustPressed(0,176) then --select phone
         Wait(0)
         func[cursor](phone)
        end
        if cursor>phone.maxlines then
         offset=phone.text_offset-(cursor-phone.maxlines)*phone.cursor_step
         cursor_offset=phone.text_offset-half_step+phone.maxlines*phone.cursor_step
        else
         offset=phone.text_offset
         cursor_offset=offset-half_step+cursor*phone.cursor_step
        end
        SetTextRenderId(GetMobilePhoneRenderId());
        phone_background(phone)
        DrawRect(.5, cursor_offset, .9, phone.cursor_step*multilines[cursor],phone.cursor_color[1],phone.cursor_color[2],phone.cursor_color[3],phone.cursor_color[4]);
        phone_text(text,offset,phone,multilines)
        SetTextRenderId(1);
        Wait(10)
    end
end

local hitman_mission_is_active=false
local hitman_mission_ped=nil
local hitman_mission_net=nil
local hitman_mission_trackify=false

local function get_to_random_coords()
    local x,y --x=-44.801700592041,y=-706.75598144531,z=32.727561950684
    while true do
        x=math.random(-1450,1450)
        y=math.random(-1450,1450)
        if x*x+y*y<2102500 then break end --1450*1450
        Wait(0)
    end
    x=x-44.8
    y=y-706.756
    local blip=AddBlipForCoord(x,y,50.0)
    SetBlipDisplay(blip, 2)
    --SetBlipColour(blip,2)
    SetBlipSprite(blip,4)
    while true do
        local pos=GetEntityCoords(GetPlayerPed(-1))
        local dx,dy=pos.x-x,pos.y-y
        if dx*dx+dy*dy<2500 then break end --50*50
        SetBlipCoords(blip,x,y,pos.z)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("Go to target area.")
        DrawNotification(false, false)
        Wait(100)
    end
    RemoveBlip(blip)
end

local function get_far_human_ped_2d_no_players(x,y,radius)
    radius=radius*radius
    local ret=0
    for ped in EnumeratePeds() do
        local invehicle=IsPedInAnyVehicle(ped)
        if GetPedRelationshipGroupHash(ped)~=1862763509 and IsPedHuman(ped) and not IsPedInAnyPlane(ped) and not IsPedInAnyHeli(ped) and GetEntityHealth(ped)>0 and ((not invehicle) or IsAnyVehicleSeatEmpty(GetVehiclePedIsUsing(ped))) then
            local pos=GetEntityCoords(ped)
            if invehicle or pos.z>.0 then
                local dx,dy=pos.x-x,pos.y-y
                local r=dx*dx+dy*dy
                if r>radius then
                    radius=r
                    ret=ped
                end
            end
        end
    end
    return ret
end

local function hitman_mission()
    local reward=2000
    local hash=nil
    ReserveNetworkMissionPeds(1)
    get_to_random_coords()
    while true do
        hitman_mission_ped=get_far_human_ped_2d_no_players(pos.x,pos.y,50.0)
        if hitman_mission_ped then
            hash=GetEntityModel(hitman_mission_ped)
            RequestModel(hash)
            break
        end
        Wait(0)
    end
    while not HasModelLoaded(hash) do Wait(0) end
    while true do
        local pos=GetEntityCoords(GetPlayerPed(-1))
        hitman_mission_ped=get_far_human_ped_2d_no_players(pos.x,pos.y,50.0)
        if hitman_mission_ped then
            pos=GetEntityCoords(hitman_mission_ped)
            if IsPedInAnyVehicle(hitman_mission_ped) then
                local veh=GetVehiclePedIsUsing(hitman_mission_ped)
                for i=-1,GetVehicleMaxNumberOfPassengers(veh)-1 do
                    if IsVehicleSeatFree(veh,i) then
                        hitman_mission_ped=CreatePedInsideVehicle(veh,4,hash,i,true,false);
                        if hitman_mission_ped then
                            SetEntityAsMissionEntity(hitman_mission_ped,true,true)
                            TaskEnterVehicle(hitman_mission_ped,veh,0,i,2.0,16,0)
                            hitman_mission_net=networkingshit(hitman_mission_ped)
                            if i==-1 then
                                Wait(100)
                                TaskVehicleDriveWander(hitman_mission_ped, veh, 1.0, 786603);
                            end
                            goto spawned_target_ped
                        end
                    end
                end
            else
                hitman_mission_ped=CreatePed(4,hash,pos.x,pos.y,pos.z,0.0,true,false)
                if hitman_mission_ped then
                    SetEntityAsMissionEntity(hitman_mission_ped,true,true)
                    hitman_mission_net=networkingshit(hitman_mission_ped)
                    TaskWanderStandard(hitman_mission_ped, 10.0, 10);
                    goto spawned_target_ped
                end
            end
        end
        Wait(1000)
    end
    ::spawned_target_ped::
    SetModelAsNoLongerNeeded(hash)
            -- SetNotificationTextEntry("STRING");
            -- AddTextComponentString("ped="..hitman_mission_ped.."\nnetid="..hitman_mission_net)
            -- DrawNotification(false, false)
    hitman_mission_trackify=true
    while GetEntityHealth(hitman_mission_ped)>0 do
        SetNotificationTextEntry("STRING");
        AddTextComponentString("Signal detected. Use ~r~Hitman ~s~app on you phone to measure distance to target.");
        DrawNotification(false, false);
        Wait(1000)
    end
    hitman_mission_trackify=false
    if hitman_mission_ped==0 or hash~=GetEntityModel(hitman_mission_ped) then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Signal lost.");
            DrawNotification(false, false);
            hitman_mission_ped=nil
            hitman_mission_net=nil
            hitman_mission_is_active=false
            return
    end
    RemovePedElegantly(hitman_mission_ped)
    SetNotificationTextEntry("STRING");
    AddTextComponentString("~g~Target is dead. $"..reward);
    DrawNotification(false, false);
    player_money=player_money+reward
    addmoney(player_money,reward)
    TriggerServerEvent('fragile-alliance:sell',reward)
    Wait(10000)
    DeletePed(hitman_mission_ped);
    hitman_mission_ped=nil
    hitman_mission_net=nil
    hitman_mission_is_active=false
end

local function start_hitman_mission(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if hitman_mission_trackify then
            local pos1=GetEntityCoords(hitman_mission_ped)
            local pos2=GetEntityCoords(GetPlayerPed(-1))
            local dx,dy,dz=pos1.x-pos2.x,pos1.y-pos2.y,pos1.z-pos2.z
            local text=string.format("%.1fm",math.sqrt(dx*dx+dy*dy+dz*dz))
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Distance:\n"..text,.05,phone)
            SetTextRenderId(1);
        elseif hitman_mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Scanning...",.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            hitman_mission_is_active=true;
            Citizen.CreateThread(hitman_mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local carjack_mission_is_active=false
local carjack_mission_veh=nil
local carjack_mission_net=nil
local carjack_mission_plate=nil
local carjack_mission_trackify=false

local function get_far_empty_veh(x,y,radius)
    radius=radius*radius
    local plate=nil
    local ret=0
    for veh in EnumerateVehicles() do
        if GetVehicleClass(veh)<10 then
            local pl=GetVehicleNumberPlateText(veh)
            if pl then
                local pos=GetEntityCoords(veh)
                local dx,dy=pos.x-x,pos.y-y
                local r=dx*dx+dy*dy
                if GetPedInVehicleSeat(veh, -1)==0 then
                    r=r+r
                end
                if r>radius then
                    radius=r
                    ret=veh
                    plate=pl
                end
            end
        end
    end
    return plate,ret
end

local function carjack_mission()
    local reward=2000
    get_to_random_coords()
    while true do
        local pos=GetEntityCoords(GetPlayerPed(-1))
        carjack_mission_plate,carjack_mission_veh=get_far_empty_veh(pos.x,pos.y,100.0)
        if carjack_mission_veh then break end
        Wait(1000)
    end
    carjack_mission_net=networkingshit(carjack_mission_veh)
            -- SetNotificationTextEntry("STRING");
            -- AddTextComponentString("veh="..carjack_mission_veh.."\nnetid="..carjack_mission_net)
            -- DrawNotification(false, false)
    carjack_mission_trackify=true
    local blip=AddBlipForCoord(-255.311,-2586.180,5.3760)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip,2)
    SetBlipSprite(blip,89)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Get carjacked vehicle here");
    EndTextCommandSetBlipName(blip)
    while GetVehicleEngineHealth(carjack_mission_veh)>1.0 do
        if carjack_mission_net~=NetworkGetNetworkIdFromEntity(carjack_mission_veh) or GetVehicleNumberPlateText(carjack_mission_veh)~=carjack_mission_plate then
            carjack_mission_trackify=false
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Losing signal! Get closer if possible.")
            DrawNotification(false, false)
            for i=1,120 do
                local new_veh=get_vehicle_from_plate(carjack_mission_plate)
                if new_veh~=nil and new_veh~=0 then
                    carjack_mission_veh=new_veh
                    carjack_mission_net=NetworkGetNetworkIdFromEntity(carjack_mission_veh)
                    carjack_mission_trackify=true
                    SetNotificationTextEntry("STRING")
                    AddTextComponentString("Found it again!")
                    -- AddTextComponentString("found\nveh="..carjack_mission_veh.."\nnetid="..carjack_mission_net.."\nv2n="..NetworkGetNetworkIdFromEntity(carjack_mission_veh).."\nn2v="..NetworkGetEntityFromNetworkId(carjack_mission_net))
                    DrawNotification(false, false)
                    break
                end
                Wait(250)
            end
            if not carjack_mission_trackify then
                abandoncar(carjack_mission_plate)
                SetNotificationTextEntry("STRING");
                AddTextComponentString("Signal lost.");
                DrawNotification(false, false);
                Wait(1000)
                SetNotificationTextEntry("STRING");
                AddTextComponentString("Carjack mission over.");
                DrawNotification(false, false);
                carjack_mission_veh=nil
                carjack_mission_net=nil
                carjack_mission_plate=nil
                carjack_mission_is_active=false
                return
            end
        end
        SetNotificationTextEntry("STRING");
        AddTextComponentString("Signal detected. Use ~g~Carjack ~s~app on you phone to measure distance to target.");
        DrawNotification(false, false);
        local pos=GetEntityCoords(carjack_mission_veh)
        local dx,dy,dz=pos.x+255.311,pos.y+2586.180,pos.z-5.3760
        if dx*dx+dy*dy+dz*dz<25 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Mission success.");
            DrawNotification(false, false);
            player_money=player_money+reward
            addmoney(player_money,reward)
            TriggerServerEvent('fragile-alliance:sell',reward)
            carjack_mission_trackify=false
            SetVehicleUndriveable(carjack_mission_veh, true);
            DeleteVehicle(carjack_mission_veh)
            carjack_mission_veh=nil
            carjack_mission_net=nil
            carjack_mission_plate=nil
            carjack_mission_is_active=false
            RemoveBlip(blip)
            return
        end
        Wait(1000)
    end
    SetNotificationTextEntry("STRING");
    AddTextComponentString("~r~Vehicle is broken.");
    DrawNotification(false, false);
    carjack_mission_trackify=false
    Wait(1000)
    DeleteVehicle(carjack_mission_veh)
    carjack_mission_veh=nil
    carjack_mission_net=nil
    carjack_mission_plate=nil
    carjack_mission_is_active=false
end

local function start_carjack_mission(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if carjack_mission_trackify then
            local pos1=GetEntityCoords(carjack_mission_veh)
            local pos2=GetEntityCoords(GetPlayerPed(-1))
            local dx,dy,dz=pos1.x-pos2.x,pos1.y-pos2.y,pos1.z-pos2.z
            local text=math.floor(math.sqrt(dx*dx+dy*dy+dz*dz))
            text="Distance:"..text.."m\n"
            text=text..carjack_mission_plate
            local street1,street2=GetStreetNameAtCoord(pos1.x,pos1.y,pos1.z);
            text=text.."\n"..GetStreetNameFromHashKey(street1);
            text=text.."\n"..GetStreetNameFromHashKey(street2);
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text(text,.05,phone)
            SetTextRenderId(1);
        elseif carjack_mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Scanning...",.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            carjack_mission_is_active=true;
            Citizen.CreateThread(carjack_mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local pilot_mission_is_active=false
local pilot_mission_state="Error"

local function pilot_mission()
    pilot_mission_state="Not available yet."
    Wait(1000)
    pilot_mission_is_active=false
end

local function start_pilot_mission(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if pilot_mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text(pilot_mission_state,.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            pilot_mission_is_active=true;
            Citizen.CreateThread(pilot_mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?\nYou will need a plane.",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local trucker_mission_is_active=false
local trucker_mission_state="Error"

local function trucker_mission()
    local trailers={
    -2140210194, 	--крамный контейрен
    -1207431159, 	--camouflage liquid
    -1476447243,	--empty camo
    -1637149482,	--campty pilit vhod v bank cherez metro
    ---399841706,	--seno
    --1019737494,	--samosval
    --356391690,	--dom s antennoi
    2078290630,	--pustaya fignya для машин
    --1784254509,	--лодка 
    2091594960,	--машины
    -1352468814,	--платформа пустая
    -1770643266,	--тв трейлер
    -730904777,	--бензин
    1956216962,	--бензин без обозначений
    2016027501,	--бревна
    -877478386,	--белый контейнер
    -1579533167,	--что-то про атом
    -2058878099	-- неизвестный контейнер
    }
    local places={
    {x=1180.5511474609,y=-3243.6540527344,z=6.0287680625916,angle=173.47682189941},	--порт
    {x=514.30084228516,y=-3028.4931640625,z=5.7183485031128,angle=91.194473266602},	--мерривезер
    {x=209.55111694336,y=-3327.1547851563,z=5.7933807373047,angle=269.31860351563},	--док
    {x=-525.61871337891,y=-2902.2983398438,z=5.6917433738708,angle=22.932670593262},	--док около аэропорт
    {x=-438.03256225586,y=-2268.783203125,z=7.2989959716797,angle=269.51089477539},	-- cnhfyysq док
    {x=-1223.6895751953,y=-2341.8015136719,z=13.636587142944,angle=328.10488891602},	-- airport
    {x=-2579.615234375,y=1929.2371826172,z=167.07209777832,angle=256.46075439453},	-- somewhere near left edge
    {x=-2529.7067871094,y=2340.224609375,z=32.750713348389,angle=213.58680725098},	-- left gas station
    {x=-2010.7397460938,y=3425.7580566406,z=30.804550170898,angle=84.078025817871},	-- zancudo
    {x=-2199.2419433594,y=4256.52734375,z=47.539615631104,angle=22.102794647217},	-- bikers
    {x=-1576.3927001953,y=5152.7412109375,z=19.627981185913,angle=190.47175598145},	-- left small dock
    {x=-577.72412109375,y=5325.7646484375,z=69.929847717285,angle=340.39096069336}	-- lumber
    }
    local source=math.random(#places)
    local dest=math.random(#places-1)
    if source==dest then source=#places end
    source=places[source]
    dest=places[dest]
    local dx,dy,dz=source.x-dest.x,source.y-dest.y,source.z-dest.z
    local reward=math.sqrt(dx*dx+dy*dy+dz*dz)
    local pos=GetEntityCoords(GetPlayerPed(-1))
    dx,dy,dz=source.x-pos.x,source.y-pos.y,source.z-pos.z
    reward=math.floor((reward+math.sqrt(dx*dx+dy*dy+dz*dz))*1.5)
    local blip=AddBlipForCoord(source.x,source.y,source.z);
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip,2)
    SetBlipSprite(blip,479)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Trailer");
    EndTextCommandSetBlipName(blip)
    trucker_mission_state="Get the trailer"
    while true do
        local pos=GetEntityCoords(GetPlayerPed(-1))
        if math.abs(pos.x-source.x)<30.0 and math.abs(pos.y-source.y)<30.0 and math.abs(pos.z-source.z)<30.0 then break end
        Wait(500)
    end
    SetBlipCoords(blip,dest.x,dest.y,dest.z)
    SetBlipSprite(blip,79)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Leave trailer here");
    EndTextCommandSetBlipName(blip)
    local trailer=createcar(trailers[math.random(#trailers)],source.x,source.y,source.z,source.angle)
    local plate=GetVehicleNumberPlateText(trailer)
    SetEntityAsMissionEntity(trailer,true,true)
    local blip2=AddBlipForEntity(trailer)
    SetBlipSprite(blip2, 479)
    SetBlipDisplay(blip2, 2)
    SetBlipColour(blip2,2)
    trucker_mission_state="Get trailer to\nthe destination"
    while true do
        local pos=GetEntityCoords(trailer)
        if math.abs(pos.x-dest.x)<30.0 and math.abs(pos.y-dest.y)<30.0 and math.abs(pos.z-dest.z)<30.0 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Mission success.");
            DrawNotification(false, false);
            RemoveBlip(blip)
            player_money=player_money+reward
            addmoney(player_money,reward)
            TriggerServerEvent('fragile-alliance:sell',reward)
            trucker_mission_state="Success"
            Wait(10000)
            DeleteVehicle(trailer)
            trucker_mission_is_active=false
            return
        end
        Wait(1000)
    end
end

local function start_trucker_mission(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if trucker_mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text(trucker_mission_state,.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            trucker_mission_is_active=true;
            Citizen.CreateThread(trucker_mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?\nYou will need a truck.",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local current_waypoint=nil

local function show_way_to_blip(phone,blips)
    local names={}
    local filtered={}
    local functions={}
    local i=0
    for k,v in pairs(blips) do
        if money_drops[k] then
            local name=money_drops[k].name
            if name then
                if filtered[name] then
                    local x1,y1,z1=pos.x-filtered[name].x,pos.y-filtered[name].y,pos.z-filtered[name].z
                    local x2,y2,z2=pos.x-v.x,pos.y-v.y,pos.z-v.z
                    if x2*x2+y2*y2+z2*z2<x1*x1+y1*y1+z1*z1 then
                        filtered[name].blip=v
                        filtered[name].x=money_drops[k].x
                        filtered[name].y=money_drops[k].y
                        filtered[name].z=money_drops[k].z
                        filtered[name].color=money_drops[k].color
                    end
                else
                    filtered[name]={}
                    filtered[name].blip=v
                    filtered[name].x=money_drops[k].x
                    filtered[name].y=money_drops[k].y
                    filtered[name].z=money_drops[k].z
                    filtered[name].color=money_drops[k].color
                end
            end
        end
    end
    for k,v in pairs(filtered) do
        if v.blip then
            i=i+1
            names[i]=k
            local blip=v.blip
            local color=v.color
            functions[i]=function(phone)
                if current_waypoint==blip then
                    current_waypoint={}
                    current_waypoint=nil
                    SetBlipRoute(blip, false)
                else
                    current_waypoint=blip
                    SetBlipRoute(blip, true)
                    SetBlipRouteColour(blip, color)
                end
            end
        end
    end
    if i>0 then
        phone_menu(names,functions,phone)
    end
    -- local state=false
    -- while not IsControlJustPressed(0,177) and not hide_phone_now do
        -- if IsControlJustPressed(0,176) then
            -- state=not state
            -- if state then
                -- for k,v in pairs(blips) do
                    -- if GetBlipSprite(v)~=406 then
                        -- SetBlipRoute(v, true)
                        -- SetBlipRouteColour(v, GetBlipColour(v))
                    -- end
                -- end
            -- else
                -- for k,v in pairs(blips) do
                    -- SetBlipRoute(v, false)
                -- end
            -- end
        -- end
        -- if state then
            -- phone_print("Turn off\nwaypoints",phone)
        -- else
            -- phone_print("Turn on\nwaypoints",phone)
        -- end
        -- Wait(0)
    -- end
end

local function show_way_to(phone,blips)
    local names={}
    local filtered={}
    local functions={}
    local pos=GetEntityCoords(GetPlayerPed(-1))
    local i=0
    for k,v in pairs(blips) do
        local name=v.name
        if filtered[name] then
            local x1,y1,z1=pos.x-filtered[name].x,pos.y-filtered[name].y,pos.z-filtered[name].z
            local x2,y2,z2=pos.x-v.x,pos.y-v.y,pos.z-v.z
            if x2*x2+y2*y2+z2*z2<x1*x1+y1*y1+z1*z1 then
                filtered[name]=v
            end
        else
            filtered[name]=v
        end
    end
    for k,v in pairs(filtered) do
        if v.blip then
            i=i+1
            names[i]=k
            local blip=v.blip
            local color=v.color
            functions[i]=function(phone)
                if current_waypoint==blip then
                    current_waypoint={}
                    current_waypoint=nil
                    SetBlipRoute(blip, false)
                else
                    current_waypoint=blip
                    SetBlipRoute(blip, true)
                    SetBlipRouteColour(blip, color)
                end
            end
        end
    end
    if i>0 then
        phone_menu(names,functions,phone)
    end
    -- local state=false
    -- while not IsControlJustPressed(0,177) and not hide_phone_now do
        -- if IsControlJustPressed(0,176) then
            -- state=not state
            -- if state then
                -- for k,v in pairs(blips) do
                    -- if v.sprite~=406 then
                        -- SetBlipRoute(v.blip, true)
                        -- SetBlipRouteColour(v.blip, v.color)
                    -- end
                -- end
            -- else
                -- for k,v in pairs(blips) do
                    -- SetBlipRoute(v.blip, false)
                -- end
            -- end
        -- end
        -- if state then
            -- phone_print("Turn off\nwaypoints",phone)
        -- else
            -- phone_print("Turn on\nwaypoints",phone)
        -- end
        -- Wait(0)
    -- end
end

local function toggle_blips(phone,blips)
    local state=false
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if IsControlJustPressed(0,176) then
            state=not state
            if state then
                showblips(blips)
            else
                hideblips(blips)
            end
        end
        if state then
            phone_print("Turn off\nblips",phone)
        else
            phone_print("Turn on\nblips",phone)
        end
        Wait(0)
    end
end

local tetris_figure
local tetris_all

local function tetris_check(fig,x,y,all)
 if all[x][y] then return false end
 for i=1,3 do
  if all[fig[i][1]+x][fig[i][2]+y] then return false end
 end
 return true
end

local function tetris_init(maxx,maxy)
     local all={}
     all[-1]={}
     all[0]={}
     for i=1,maxx do
      all[i]={}
      for j=-3,maxy do
       all[i][j]=false
      end
      all[i][maxy+1]=true
     end
     all[maxx+1]={}
     all[maxx+2]={}
     for i=-4,maxy do
      all[0][i+1]=true
      --all[-1][i+1]=true
      all[maxx+1][i+1]=true
      --all[maxx+2][i+1]=true
     end
     return all
end

local function tetris(phone)
    local maxx=30
    local maxy=40
    local mx=1.0/maxx
    local my=1.0/maxy
    local figs={{{0,1},{0,2},{0,-1}},
                {{0,1},{1,1},{-1,0}},
                {{0,1},{1,1},{-1,0}},
                {{1,0},{0,1},{-1,1}},
                {{0,1},{1,1},{ 1,0}},
                {{0,1},{0,2},{ 1,2}},
                {{0,1},{0,2},{-1,2}}}
    local x=15
    local y=0
    local timer=0
    local color={0,0,127}
    if not tetris_all then
     tetris_all=tetris_init(maxx,maxy)
    end
    if not tetris_figure then
     tetris_figure=figs[math.random(#figs)]
    end
    while not IsControlPressed(0,177) and not hide_phone_now do
        if IsControlPressed(0,172) then --up
         local new={{tetris_figure[1][2],-tetris_figure[1][1]},
                    {tetris_figure[2][2],-tetris_figure[2][1]},
                    {tetris_figure[3][2],-tetris_figure[3][1]}}
         if tetris_check(new,x,y,tetris_all) then tetris_figure=new end
         timer=3
        elseif IsControlPressed(0,174) then --left
         if tetris_check(tetris_figure,x-1,y,tetris_all) then x=x-1 end
        elseif IsControlPressed(0,175) then --right
         if tetris_check(tetris_figure,x+1,y,tetris_all) then x=x+1 end
        end
        if IsControlPressed(0,173) then --down
         timer=4
        end
         for i=1,3 do
          SetTextRenderId(GetMobilePhoneRenderId());
          for j=1,maxx do
           for k=1,maxy do
            if tetris_all[j][k] then
             DrawRect((j-.5)*mx,(k-.5)*my,mx,my,128+color[1],128+color[2],128+color[3],255)
            end
           end
          end
          DrawRect((x-.5)*mx,(y-.8+.1*timer)*my,mx,my,color[1]+color[1],color[2]+color[2],color[3]+color[3],255)
          for i=1,3 do
           DrawRect((tetris_figure[i][1]+x-.5)*mx,(tetris_figure[i][2]+y-.8+.1*timer)*my,mx,my,color[1]+color[1],color[2]+color[2],color[3]+color[3],255)
          end
          SetTextRenderId(1);
            if color[1]==0 and color[3]<127 then
            color[2],color[3]=color[2]-1,color[3]+1
            elseif color[2]==0 and color[1]<127 then
            color[3],color[1]=color[3]-1,color[1]+1
            elseif color[3]==0 and color[2]<127 then
            color[1],color[2]=color[1]-1,color[2]+1
            end
          Wait(10)
         end
        if timer==4 then
         if tetris_check(tetris_figure,x,y+1,tetris_all) then
          y=y+1
         else 
          tetris_all[x][y]=true
          for i=1,3 do
           tetris_all[tetris_figure[i][1]+x][tetris_figure[i][2]+y]=true
          end
          local dropped=false
          for j=maxy,1,-1 do
           while true do
            local full=true
            for i=maxx,1,-1 do
             if not tetris_all[i][j] then full=false end
            end
            if full then
             for i=maxx,1,-1 do
              for k=j,1,-1 do
               tetris_all[i][k]=tetris_all[i][k-1]
              end
             end
             dropped=true
            else
             break
            end
           end
          end
          if y<1 and not dropped then tetris_all=tetris_init(maxx,maxy) end
          tetris_figure=figs[math.random(#figs)]
          x=15
          y=0
         end
         timer=0
        else
         timer=timer+1
        end
    end
end

Citizen.CreateThread(function()
    local phone={}
    Wait(200)
    --if string.find(GetPlayerName(PlayerId()), "Nexerade") then
    while true do
        while not IsControlJustPressed(0,27) do Wait(10) end
        local main_menu={"Heist","Trucker","~c~Pilot","Hitman","Carjack","Waypoints","Hide blips"}
        hide_phone_now=false
        if player_is_cop then
         CreateMobilePhone(0);
         phone.width=.3
         phone.height=.4
         phone.text_offset=.05
         phone.font=0
         phone.dict="3dtextures"
         phone.sprite="mpgroundlogo_cops"
         phone.bgcolor={0,64,128,255}
         phone.cursor_color={100,160,255,64}
         phone.cursor_step=0.1175
         phone.maxlines=8
         phone.scale={5.0,0.625}
         main_menu={"Tetris"}
        elseif player_money==nil or player_money==0 then
         CreateMobilePhone(4);
         phone.text_offset=.05
         phone.width=.18
         phone.font=4
         phone.dict="commonmenu"
         phone.sprite="interaction_bgd"
         phone.bgcolor={25,25,25,255}
         phone.cursor_color={100,100,100,125}
         phone.cursor_step=.17
         phone.maxlines=5
         phone.scale={1.0,1.0}
        elseif player_money<5000 then
         CreateMobilePhone(1);
         phone.text_offset=.05
         phone.width=.18
         phone.font=0
         phone.dict="commonmenu"
         phone.sprite="interaction_bgd"
         phone.bgcolor={255,0,0,255}
         phone.cursor_color={255,100,0,125}
         phone.cursor_step=0.15
         phone.maxlines=6
         phone.scale={0.9,0.8}
        elseif player_money<15000 then
         CreateMobilePhone(2);
         phone.text_offset=.05
         phone.width=.18
         phone.font=0
         phone.dict="commonmenu"
         phone.sprite="interaction_bgd"
         phone.bgcolor={75,225,75,255}
         phone.cursor_color={0,255,0,64}
         phone.cursor_step=.15
         phone.maxlines=6
         phone.scale={0.9,0.8}
        else
         CreateMobilePhone(0);
         phone.text_offset=.05
         phone.width=.1888
         phone.font=0
         phone.dict="commonmenu"
         phone.sprite="interaction_bgd"
         phone.bgcolor={255,255,255,255}
         phone.cursor_color={100,160,255,64}
         phone.cursor_step=0.1175
         phone.maxlines=8
         phone.scale={5.0,0.625} -- 4 > $0, 1 > $1, 2 >$5000, 0 > $15000
        end
        RequestStreamedTextureDict(phone.dict, false)
        --TaskPlayAnim(GetPlayerPed(-1), animdict, anim, 1.0, 1.0, 10000, 0, 0, 0, 0, 0);
        for i=90,0,-3 do
         SetMobilePhonePosition(130.0,-70.0-i,-150.0);
         SetMobilePhoneRotation(i-90.0, .0-i, .0, 0);
         if HasStreamedTextureDictLoaded(phone.dict) then
          phone_print(main_menu,phone)
         end
         Wait(5)
        end
        --Wait(20)
        while not HasStreamedTextureDictLoaded(phone.dict) do Wait(10) end
        if player_is_cop then
            phone_menu(main_menu,{
                tetris
            },phone)
        else
            phone_menu(main_menu,{
                function(phone) --heist
                    TriggerServerEvent(event.startheist)
                end,
                start_trucker_mission, --trucker
                start_pilot_mission, --pilot
                start_hitman_mission, --hitman
                start_carjack_mission, --carjack
                function(phone) --waypoints
                    phone_menu({"Factions","Heist","Change clothes","Weapon shop","Car shop","Armor shop","Medic","Garage"},{
                        function(phone) --faction
                            show_way_to(phone,join_faction)
                        end,
                        function(phone) --heist
                            show_way_to_blip(phone,money_blips)
                        end,
                        function(phone) --clothes
                            show_way_to(phone,clothes)
                        end,
                        function(phone) --weapons
                            show_way_to(phone,weaponshops)
                        end,
                        function(phone) --carshop
                            show_way_to(phone,carshops)
                        end,
                        function(phone) --armor
                            show_way_to(phone,armorshops)
                        end,
                        function(phone) --medic
                            show_way_to(phone,medics)
                        end,
                        function(phone) --garage
                            show_way_to(phone,garages)
                        end,
                    },phone)
                end,
                function(phone) --blips
                    phone_menu({"Heist","Change clothes","Weapon shop","Car shop","Armor shop","Medic","Garage","Hide All","Show all"},{
                        function(phone) --heist
                            for k,v in pairs(money_blips) do
                                SetBlipSprite(v,406)
                            end
                        end,
                        function(phone) --clothes
                            hideblips(clothes)
                        end,
                        function(phone) --weapons
                            hideblips(weaponshops)
                        end,
                        function(phone) --carshop
                            hideblips(carshops)
                        end,
                        function(phone) --armor
                            hideblips(armorshops)
                        end,
                        function(phone) --medic
                            hideblips(medics)
                        end,
                        function(phone) --garage
                            hideblips(garages)
                        end,
                        function(phone) --hide all
                            hideblips(clothes)
                            hideblips(weaponshops)
                            hideblips(carshops)
                            hideblips(armorshops)
                            hideblips(medics)
                            hideblips(garages)
                        end,
                        function(phone) --show all
                            showblips(clothes)
                            showblips(weaponshops)
                            showblips(carshops)
                            showblips(armorshops)
                            showblips(medics)
                            showblips(garages)
                            if not player_is_cop then TriggerServerEvent(event.startheist) end
                        end
                    },phone)
                end
            },phone)
        end
        for i=0,90,3 do
         SetMobilePhonePosition(130.0,-70.0-i,-150.0);
         SetMobilePhoneRotation(i-90.0, .0-i, .0, 0);
         phone_print(main_menu,phone)
         Wait(5)
        end
        DestroyMobilePhone();
        SetStreamedTextureDictAsNoLongerNeeded(phone.dict);
      --end
    end
end)

Citizen.CreateThread(function()
    Wait(5300)
    local teleport={
    --{{x=136.19645690918,y=-761.76068115234,z=45.752017974854},{x=136.01150512695,y=-761.57867431641,z=242.15190124512}}, --fbi old
    {{x=136.1,y=-761.66,z=45.752017974854},{x=136.1,y=-761.66,z=242.15190124512}}, --fbi
    {{x=10.514255523682,y=-671.0830078125,z=33.449558258057},{x=-0.14778167009354,y=-705.87750244141,z=16.131242752075}}, --bank
    {{x=3540.58,y=3675.33,z=20.991785049438},{x=3540.58,y=3675.33,z=28.121145248413}} --humane
    }
    while true do
        while not IsControlPressed(0,86) do Wait(10) end
        local pos=GetEntityCoords(GetPlayerPed(-1))
        local x,y,z=pos.x,pos.y,pos.z
        for k,v in pairs(teleport) do
            local dx,dy,dz=x-v[1].x,y-v[1].y,z-v[1].z
            if dz<.2 and dz>-.2 and dx*dx+dy*dy<1.0 then
                SetEntityCoords(GetPlayerPed(-1),v[2].x+dx,v[2].y+dy,v[2].z+dz)
                Wait(1000)
                break
            end
            dx,dy,dz=x-v[2].x,y-v[2].y,z-v[2].z
            if dz<.2 and dz>-.2 and dx*dx+dy*dy<1.0 then
                SetEntityCoords(GetPlayerPed(-1),v[1].x+dx,v[1].y+dy,v[1].z+dz)
                Wait(1000)
                break
            end
            -- SetTextComponentFormat("STRING")
            -- AddTextComponentString("~s~Press ~INPUT_VEH_HORN~ to use elevator.")
            -- DisplayHelpTextFromStringLabel(0,0,1,-1)
        end
        Wait(0)
    end
end)