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










local money_drops={}
local money_blips={}
local player_money=0
local pos
local isDead = false
local relationship_enemy=GetHashKey("PRISONER")
local relationship_friend=GetHashKey("PLAYER")
--NetworkEarnFromNotBadsport(2000)
 NetworkSetFriendlyFireOption(true)
 SetCanAttackFriendly(GetPlayerPed(-1), true, false)
 
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
local mycar=nil
local mycar_old=nil
local enemies={}
local friends={}
local jail={x=1655.9542236328,y=2544.7395019531,z=45.564891815186}

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

local function setmoney(new)
    SendNUIMessage({
			setmoney = true,
			money = new
	})
    --SetSingleplayerHudCash(new,0)
end

local function addmoney(new,change)
    setmoney(new)
    SendNUIMessage({
			addcash = true,
			money = change
	})
end

local function removemoney(new,change)
    setmoney(new)
    SendNUIMessage({
			removecash = true,
			money = change
	})
    -- SetNotificationTextEntry("STRING");
    -- AddTextComponentString("~r~-$"..v.cost)
    -- DrawNotification(false, false);
end
    
RegisterNetEvent(event.money)
AddEventHandler(event.money, function(money)
    --SetPedMoney(GetPlayerPed(-1), money);
      --SetNotificationTextEntry("STRING");
      if money<player_money then
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
    while true do
        if not money_drops[-1] then
            SetTextComponentFormat("STRING")
            AddTextComponentString("Press ~INPUT_VEH_ROOF~ to start ~g~heist~s~.")
            DisplayHelpTextFromStringLabel(0,0,1,-1)
            Wait(30000)
        else
            Wait(1000)
        end
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
    SetBlipColour(money_blips[id], 2)
    --SetBlipAsShortRange(money_blips[id].blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(heist.name)
    EndTextCommandSetBlipName(money_blips[id])
    if id==-1 then
      SetNotificationTextEntry("STRING");
      AddTextComponentString(heist.name.." ~g~$"..heist.money.."~s~");
      --SetNotificationMessage("CHAR_LESTER", "CHAR_LESTER", false, 1, "Heist", "$"..heist.money);
      DrawNotification(false, false);
      --CreateCheckpoint(Type, x, y, z, x2, y2, z2, radius, R, G, B, Alpha, p12)
      --SetNewWaypoint(heist.x,heist.y)
      SetBlipRoute(money_blips[id], true)
      SetBlipRouteColour(money_blips[id], 2)
    end
end)

RegisterNetEvent(event.stopheist)
AddEventHandler(event.stopheist, function(id)
    money_drops[id]=nil;
    if money_blips[id] then
        SetBlipSprite(money_blips[id], 406)
        SetBlipDisplay(money_blips[id], 2)
        if id==-1 then
            SetBlipRoute(money_blips[id], false)
        end
    end
end)

function removeenemycorpse(milliseconds,ped)
    Wait(milliseconds)
    SetPedAsNoLongerNeeded(ped)
end

function removefriendcorpse(milliseconds,ped)
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
    while true do
        for key, v in pairs(friends) do
            if IsPedFatallyInjured(v) then
                Citizen.CreateThread(function() removefriendcorpse(120000,v) end)
                friends[key]=nil
            end
            Wait(500)
        end
        for key, v in pairs(enemies) do
            if IsPedFatallyInjured(v) then
                Citizen.CreateThread(function() removeenemycorpse(120000,v) end)
                enemies[key]=nil
            end
            Wait(500)
        end
        Wait(0)
        if mycar and GetVehicleEngineHealth(mycar)==-4000 then
            SetVehicleAsNoLongerNeeded(mycar)
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Your last bought vehicle is destoryed.");
           -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
            DrawNotification(false, false);
        end
        if mycar_old and GetVehicleEngineHealth(mycar_old)==-4000 then
            SetVehicleAsNoLongerNeeded(mycar_old)
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Your previously bought vehicle is destoryed.");
           -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
            DrawNotification(false, false);
        end
    end
end)

function spawnped(hash,x,y,z,weapon,pedlist)
   while not HasModelLoaded( hash ) do
        RequestModel( hash )
        Wait(100)
   end
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

function createpedgroup(x,y,z,n,skins,weapons,pedlist)
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
    Wait(2000)
    --DisplayCash(false)
    setmoney(0)
    Wait(30000)
    TriggerEvent('fragile-alliance:playerspawn',ped)
    SetNotificationTextEntry("STRING");
    AddTextComponentString("PvP is on, don't trust anyone. You can cooperate or betray players. Type ~g~/heist~s~ to start.");
    --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, "Welcome", "PvP is on.");
    DrawNotification(false, false);
    Wait(5000)
    SetNotificationTextEntry("STRING");
    AddTextComponentString("When you die - you loose everything, don't be greedy. Good luck.");
    --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, "Hint", " ");
    DrawNotification(false, false);
end)

Citizen.CreateThread(function()
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
        end
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
    local guns={MUSKET,MARKSMANPISTOL,SNSPISTOL,REVOLVER,VINTAGEPISTOL,DBSHOTGUN}
    local ammo={     5,             5,       12,       6,            7,        4}
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
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for key, v in pairs(money_drops) do
            if v then
                local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
                if square<100 then
                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.r, v.r, 1.0, 0, 255, 0, 128, false, true, 2, false, false, false, false)
                    if v.wanted>GetPlayerWantedLevel(PlayerId()) then
                        SetPlayerWantedLevel(PlayerId(), v.wanted, false)
                        SetPlayerWantedLevelNow(PlayerId(),false)
                    end
                    if square<9 and not isDead then
                        TriggerServerEvent('fragile-alliance:take_money',key)
                        for i=1,200 do
                            Wait(10)
                            DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.r, v.r, 1.0, 0, 255, 0, 32, false, true, 2, false, false, false, false)
                        end
                        pos=GetEntityCoords(GetPlayerPed(-1))
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
  while true do
    -- if IsControlPressed(0, 48) then
      -- SetNotificationTextEntry("STRING");
      -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, "Your money", "~g~$"..player_money);
      -- DrawNotification(false, false);
      -- Wait(100)
    -- end
    if IsControlPressed(0,101) then
      TriggerServerEvent(event.startheist)
      Wait(500)
    end
    Wait(0)
  end
end)

function makeblips(shops)
    for k,v in pairs(shops) do
    local blip
    blip=AddBlipForCoord(v.x,v.y,v.z)
    SetBlipSprite(blip, v.sprite) --heist.sprite
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

Citizen.CreateThread(function()
    Wait(0)
    local weaponshops={
    [1]={x=35.239,y=-1459.373,z=29.3116,name="Free pistol",sprite=156,color=0,cost=0,weapon={VINTAGEPISTOL},
                                                                                       ammo={           7}},
    [2]={x=485.409,y=-1529.096,z=29.2950,name="Pistol shop",sprite=156,color=2,cost=500,weapon={COMBATPISTOL,HEAVYPISTOL},
                                                                                       ammo={          72,         72}},
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
    [9]={x=-1382.847,y=-640.499,z=28.6733,name="Shotguns shop",sprite=158,color=2,cost=1200,weapon={BULLPUPSHOTGUN,SAWNOFFSHOTGUN},
                                                                                                   ammo={       40,            40}},
    [10]={x=-683.299,y=-172.938,z=37.8213,name="PDWs shop",sprite=159,color=2,cost=1900,weapon={MINISMG,MACHINEPISTOL,},
                                                                                         ammo={     100,          100}}, 
    [11]={x=-1502.926,y=130.437,z=55.6528,name="Assault shop",sprite=159,color=1,cost=3500,weapon={SMG,ASSAULTRIFLE},
                                                                                       ammo={      150,         150}},
    [12]={x=-425.912,y=535.400,z=122.2750,name="Automatic snipers shop",sprite=150,color=1,cost=5000,weapon={MARKSMANRIFLE},
                                                                                                                  ammo={36}},
    [13]={x=189.880,y=308.841,z=105.390,name="Snipers shop",sprite=160,color=2,cost=3000,weapon={SNIPERRIFLE},
                                                                                                    ammo={45}}                                                                                                                   
    }
    makeblips(weaponshops)
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

Citizen.CreateThread(function()
    Wait(0)
    local armorshops={
    [1]={x=29.81608581543,y=-1019.036315918,z=29.435953140259,name="Armor shop",color=3,sprite=175,cost=1000}                                                                                                           
    }
    makeblips(armorshops)
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

Citizen.CreateThread(function()
    Wait(0)
    local medics={
    [1]={x=253.44336,y=-1808.50635,z=27.113144,name="Medic",color=23,sprite=153,cost=1000}                                                                                                           
    }
    makeblips(medics)
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

Citizen.CreateThread(function()
    Wait(0)
    local mercenaries={
    [1]={x=-44.801700592041,y=-706.75598144531,z=32.727561950684,name="Mercenary",color=2,sprite=280,skins={275618457},weapons={PISTOL,SAWNOFFSHOTGUN,ASSAULTRIFLE,MACHINEPISTOL},cost=9500,armor=20,health=700},
    [2]={x=-1153.6383056641,y=-1249.3861083984,z=7.1956105232239,name="Mercenary",color=2,sprite=280,skins={1746653202,1024089777,1794381917,193817059},weapons={PISTOL,SNSPISTOL,PUMPSHOTGUN},cost=5000,armor=0,health=300},
    [3]={x=373.76196289063,y=-738.09985351563,z=29.269620895386,name="Bodyguard",color=2,sprite=280,skins={-245247470,691061163},weapons={COMBATPISTOL,HEAVYPISTOL,SMG,ADVANCEDRIFLE,BULLPUPSHOTGUN},cost=18000,armor=100,health=1300},
    [4]={x=-1577.1640625,y=2101.6176757813,z=68.072256469727,name="Kisos",color=17,sprite=406,skins={307287994,1462895032},weapons={148160082,2578778090},cost=1000,armor=100}
    }
    makeblips(mercenaries)
    while true do
        Wait(0)
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

Citizen.CreateThread(function()
    Wait(0)
    local carshops={
    [1]={x=2964.9196777344,y=2747.6323242188,z=43.310658111572,name="Armored weaponized truck",color=1,sprite=229,cars={2434067162},cost=175000},
    [2]={x=1463.7440185547,y=1128.9432373047,z=114.33376373291,name="Weaponized truck",color=2,sprite=229,cars={2198148358},cost=14000},
    [3]={x=486.37924194336,y=-2159.6452636719,z=5.9258829498291,name="Armored car",color=1,sprite=380,cars={3406724313,1922255844,470404958,666166960,3862958888},cost=75000},
    [4]={x=33.801235198975,y=-2671.1713867188,z=6.0175901794434,name="Armored truck",color=2,sprite=67,cars={1747439474,3089277354},cost=30000},
    [5]={x=21.298585891724,y=-210.41683959961,z=52.857303619385,name="Offroad minivan",color=2,sprite=326,cars={1475773103},cost=15000},
    
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
    {x=-1043.383,y=-3484.475,z=13.954,name="Jet",color=2,sprite=423,cars={1058115860},cost=0}
    --{x=163.18153381348,y=-1282.4031982422,z=29.146518707275,name="KITT",color=2,sprite=460,cars={941494461},cost=300000},
    --{x=196.76313781738,y=-1498.1608886719,z=29.141607284546,name="Oppressor",color=2,sprite=226,cars={884483972},cost=400000}
    }
    makeblips(carshops)
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
                            if player_money>=v.cost then
                                local hash=v.cars[math.random(#v.cars)]
                                while not HasModelLoaded(hash) do
                                 RequestModel(hash)
                                 Wait(100)
                                end
                                if mycar_old then
                                  SetVehicleAsNoLongerNeeded(mycar_old)
                                  Wait(100)
                                end
                                mycar_old=mycar
                                mycar=CreateVehicle(hash,v.x,v.y,v.z, GetEntityHeading(GetPlayerPed(-1)), true, false)
                                SetModelAsNoLongerNeeded(hash)
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

Citizen.CreateThread(function()
    Wait(0)
    local repairshops={
    [1]={x=2964.9196777344,y=2747.6323242188,z=43.310658111572,name="Repair everything",color=1,sprite=229,cars={2434067162},cost=175000}
    }
    makeblips(repairshops)
    while true do
        Wait(0)
        pos=GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(repairshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not isDead) then
                    if IsControlPressed(0, 86) then
                        local veh=nil
                        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                            veh = GetVehiclePedIsUsing(ped)
                        else
                            local dx,dy,dz,dist1=100,dist2=100
                            if mycar then
                                local pos2=GetEntityCoords(mycar)
                                dx,dy,dz=pos2.x-pos.x,pos2.y-pos.y,pos2.z-pos.z
                                dist1=dx*dx+dy*dy+dz*dz
                                if dist1<100 then veh=mycar end
                            end
                            if mycar_old then
                                local pos2=GetEntityCoords(mycar_old)
                                dx,dy,dz=pos2.x-pos.x,pos2.y-pos.y,pos2.z-pos.z
                                dist2=dx*dx+dy*dy+dz*dz
                                if dist2<dist1 then veh=mycar_old end
                            end
                        end
                        if veh then
                            if player_money>=v.cost then
                                local hash=v.cars[math.random(#v.cars)]
                                while not HasModelLoaded(hash) do
                                 RequestModel(hash)
                                 Wait(100)
                                end
                                if mycar_old then
                                  SetVehicleAsNoLongerNeeded(mycar_old)
                                  Wait(100)
                                end
                                mycar_old=mycar
                                mycar=CreateVehicle(hash,v.x,v.y,v.z, GetEntityHeading(GetPlayerPed(-1)), true, false)
                                SetModelAsNoLongerNeeded(hash)
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
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to buy.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)