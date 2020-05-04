-- in-memory spawnpoint array for this script execution instance
local spawnPoints = {}

-- auto-spawn enabled flag
local autoSpawnEnabled = false
local autoSpawnCallback

--x=-1028.6033935547,y=-1083.7547607422
local randomspawns_x=-44.8
local randomspawns_y=-706.756
local randomspawns_radius=1500.1

--nui
local showmenu=true

--global 
nextspawn=nil

--randomspawns_x,randomspawns_y=-3032.8419189453,-1071.7670898438
--randomspawns_radius=1.1
local randomspawns_models={
"A_M_M_MexLabor_01",
"S_M_M_AutoShop_01",
"A_M_Y_Beach_02",
"A_M_Y_BeachVesp_01",
"A_M_Y_BeachVesp_02",
"A_M_M_BevHills_01",
"A_M_Y_BevHills_01",
"A_M_M_BevHills_02",
"A_M_Y_BevHills_02",
"A_M_Y_BusiCas_01",
"A_M_Y_Business_02",
"A_M_Y_Business_03",
"S_M_O_Busker_01",
"A_M_Y_Cyclist_01",
"S_M_Y_Dealer_01",
"A_M_Y_Downtown_01",
"A_M_M_EastSA_01",
"A_M_Y_EastSA_01",
"A_M_M_EastSA_02",
"A_M_Y_EastSA_02",
"U_M_M_Edtoh",
"A_M_Y_Gay_01",
"A_M_M_GenFat_01",
"A_M_M_GenFat_02",
"A_M_Y_GenStreet_01",
"A_M_Y_GenStreet_02",
"A_M_Y_Golfer_01",
"A_M_Y_Indian_01",
"A_M_M_KTown_01",
"A_M_O_KTown_01",
"A_M_Y_KTown_01",
"A_M_Y_KTown_02",
"A_M_Y_Latino_01",
"U_M_Y_Party_01",
"A_M_M_Polynesian_01",
"A_M_Y_Polynesian_01",
"S_M_Y_Robber_01",
"A_M_Y_Runner_02",
"A_M_M_Skater_01",
"A_M_Y_Skater_01",
"A_M_Y_Skater_02",
"A_M_M_Skidrow_01",
"A_M_M_SoCenLat_01",
"A_M_M_SouCent_01",
"A_M_M_SouCent_02",
"A_M_M_SouCent_03",
"A_M_M_SouCent_04",
"A_M_O_SouCent_01",
"A_M_O_SouCent_02",
"A_M_O_SouCent_03",
"A_M_Y_SouCent_01",
"A_M_Y_SouCent_02",
"A_M_Y_SouCent_03",
"A_M_Y_SouCent_04",
"A_M_Y_StBla_01",
"A_M_Y_StBla_02",
"A_M_Y_StLat_01",
"A_M_M_StLat_02",
"G_M_Y_StrPunk_01",
"G_M_Y_StrPunk_02",
"S_M_Y_StrVend_01",
"A_M_Y_StWhi_01",
"A_M_Y_StWhi_02",
"A_M_Y_Sunbathe_01",
"U_M_Y_Tattoo_01",
"A_M_Y_VinDouche_01"
}

-- tries to generate random spawn coordinates
local function getRandomSpawnCoordsInRadiusSquared(spawn,radius)
    local squared=radius*radius
    local double=radius+radius
    spawn.x=math.random()*double-radius
    spawn.y=math.random()*double-radius
    if spawn.x*spawn.x+spawn.y*spawn.y<squared then return end
    spawn.x=math.random()*double-radius
    spawn.y=math.random()*double-radius
    if spawn.x*spawn.x+spawn.y*spawn.y<squared then return end
    spawn.x=math.random()*double-radius
    spawn.y=math.random()*double-radius
    if spawn.x*spawn.x+spawn.y*spawn.y<squared then return end
    spawn.x=math.random()*double-radius
    spawn.y=math.random()*double-radius
    if spawn.x*spawn.x+spawn.y*spawn.y<squared then return end
    spawn.x=math.random()*double-radius
    spawn.y=math.random()*double-radius
    if spawn.x*spawn.x+spawn.y*spawn.y<squared then return end
    --if we got here, we suck
    double=radius*1.41421356237 --exactly that hard
    spawn.x=math.random()*double
    spawn.y=math.random()*double
    double=double*.5
    spawn.x=spawn.x-double
    spawn.y=spawn.y-double
end

local function checkForBadSpawn()
    local timer=GetGameTimer()
    while GetTimeDifference(GetGameTimer(),timer)<5000 do
        local ped=PlayerPedId()
        local pos=GetEntityCoords(ped)
        if pos.z>.0 then return end
        if GetEntityHealth(ped)<150 or IsEntityInWater(ped) then
            local spawn={}
            getRandomSpawnCoordsInRadiusSquared(spawn,randomspawns_radius)
            SetEntityCoords(ped,spawn.x,spawn.y,-200.1)
            Wait(10)
            while GetTimeDifference(GetGameTimer(),timer)<5000 do
                ped=PlayerPedId()
                pos=GetEntityCoords(ped)
                if pos.z>.0 then return end
                if GetEntityHealth(ped)<150 or IsEntityInWater(ped) then
                    SetEntityCoords(ped,pos.x,pos.y,1000.0)
                    Citizen.CreateThread(function() Wait(1000) GiveWeaponToPed(PlayerPedId(),0xFFFFFFFFFBAB5776,1,false,true) end) --parachute
                    return
                end
            end
        end
        Wait(10)
    end
end

-- support for mapmanager maps
AddEventHandler('getMapDirectives', function(add)
    -- call the remote callback
    add('spawnpoint', function(state, model)
        -- return another callback to pass coordinates and so on (as such syntax would be [spawnpoint 'model' { options/coords }])
        return function(opts)
            local x, y, z, heading

            local s, e = pcall(function()
                -- is this a map or an array?
                if opts.x then
                    x = opts.x
                    y = opts.y
                    z = opts.z
                else
                    x = opts[1]
                    y = opts[2]
                    z = opts[3]
                end

                x = x + 0.0001
                y = y + 0.0001
                z = z + 0.0001

                -- get a heading and force it to a float, or just default to null
                heading = opts.heading and (opts.heading + 0.01) or 0

                -- add the spawnpoint
                addSpawnPoint({
                    x = x, y = y, z = z,
                    heading = heading,
                    model = model
                })

                -- recalculate the model for storage
                if not tonumber(model) then
                    model = GetHashKey(model, _r)
                end

                -- store the spawn data in the state so we can erase it later on
                state.add('xyz', { x, y, z })
                state.add('model', model)
            end)

            if not s then
                Citizen.Trace(e .. "\n")
            end
        end
        -- delete callback follows on the next line
    end, function(state, arg)
        -- loop through all spawn points to find one with our state
        for i, sp in ipairs(spawnPoints) do
            -- if it matches...
            if sp.x == state.xyz[1] and sp.y == state.xyz[2] and sp.z == state.xyz[3] and sp.model == state.model then
                -- remove it.
                table.remove(spawnPoints, i)
                return
            end
        end
    end)
end)


-- loads a set of spawn points from a JSON string
function loadSpawns(spawnString)
    -- decode the JSON string
    local data = json.decode(spawnString)

    -- do we have a 'spawns' field?
    if not data.spawns then
        error("no 'spawns' in JSON data")
    end

    -- loop through the spawns
    for i, spawn in ipairs(data.spawns) do
        -- and add it to the list (validating as we go)
        addSpawnPoint(spawn)
    end
end

local spawnNum = 1

function addSpawnPoint(spawn)
    -- validate the spawn (position)
    if not tonumber(spawn.x) or not tonumber(spawn.y) or not tonumber(spawn.z) then
        error("invalid spawn position")
    end

    -- heading
    if not tonumber(spawn.heading) then
        error("invalid spawn heading")
    end

    -- model (try integer first, if not, hash it)
    local model = spawn.model

    if not tonumber(spawn.model) then
        model = GetHashKey(spawn.model)
    end

    -- is the model actually a model?
    if not IsModelInCdimage(model) then
        error("invalid spawn model")
    end

    -- is is even a ped?
    -- not in V?
    --[[if not IsThisModelAPed(model) then
        error("this model ain't a ped!")
    end]]

    -- overwrite the model in case we hashed it
    spawn.model = model

    -- add an index
    spawn.idx = spawnNum
    spawnNum = spawnNum + 1

    -- all OK, add the spawn entry to the list
    table.insert(spawnPoints, spawn)

    return spawn.idx
end

-- removes a spawn point
function removeSpawnPoint(spawn)
    for i = 1, #spawnPoints do
        if spawnPoints[i].idx == spawn then
            table.remove(spawnPoints, i)
            return
        end
    end
end

-- changes the auto-spawn flag
function setAutoSpawn(enabled)
    autoSpawnEnabled = enabled
end

-- sets a callback to execute instead of 'native' spawning when trying to auto-spawn
function setAutoSpawnCallback(cb)
    autoSpawnCallback = cb
    autoSpawnEnabled = true
end

-- function as existing in original R* scripts
local function freezePlayer(id, freeze)
    local player = id
    SetPlayerControl(player, not freeze, false)

    local ped = GetPlayerPed(player)

    if not freeze then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end

        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        --SetCharNeverTargetted(ped, false)
        --SetPlayerInvincible(player, false) --hack detection
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end

        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        --SetCharNeverTargetted(ped, true)
        --SetPlayerInvincible(player, true) --hack detection
        --RemovePtfxFromPed(ped)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

function loadScene(x, y, z)
    NewLoadSceneStart(x, y, z, 0.0, 0.0, 0.0, 20.0, 0)

    while IsNewLoadSceneActive() do
        networkTimer = GetNetworkTimer()

        NetworkUpdateLoadScene()
    end
end

-- to prevent trying to spawn multiple times
local spawnLock = false

DecorRegister("nowantedforstealing",3)

-- spawns the current player at a certain spawn point index (or a random one, for that matter)
function spawnPlayer(class)
    if spawnLock then
        return
    end

    spawnLock = true

    Citizen.CreateThread(function()
        DoScreenFadeOut(500)
        local spawn

        while IsScreenFadingOut() do
            Citizen.Wait(0)
        end

        -- if the spawn isn't set, select a random one

            --spawnIdx = GetRandomIntInRange(1, #spawnPoints + 1)
            spawn={}
            if not_randomspawn and nextspawn~=nil and nextspawn.x~=nil then
                if spawn.angle==nil then
                    spawn={x=nextspawn.x,y=nextspawn.y,z=nextspawn.z,angle=math.random()*360.0}
                else
                    spawn=nextspawn
                end
            else
                spawn.x=.0
                spawn.y=.0
                --math.randomseed(GetRandomIntInRange(0, 0xFFFFFFFF))
                --math.randomseed(GetGameTimer())
                spawn.angle=math.random()*360.0
                getRandomSpawnCoordsInRadiusSquared(spawn,randomspawns_radius)
                spawn.z=-200.1
                spawn.x=spawn.x+randomspawns_x
                spawn.y=spawn.y+randomspawns_y
            end
            if not tonumber(class.models[1]) then
                for k,v in pairs(class.models) do
                    if not tonumber(v) then
                        local hash=GetHashKey(v)
                        class.models[k]=hash
                    end
                end
            end
            spawn.model=class.models[math.random(#class.models)]

        
        -- freeze the local player
        freezePlayer(PlayerId(), true)

        -- if the spawn has a model set
        if spawn.model then
            RequestModel(spawn.model)

            -- load the model for this spawn
            while not HasModelLoaded(spawn.model) do
                RequestModel(spawn.model)

                Wait(0)
            end

            -- change the player model
            SetPlayerModel(PlayerId(), spawn.model)

            -- release the player model
            SetModelAsNoLongerNeeded(spawn.model)
        end

        -- preload collisions for the spawnpoint
        if spawn.z<-199.0 then
            RequestCollisionAtCoord(spawn.x, spawn.y, 50.0)
        else
            RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
        end

        -- spawn the player
        --ResurrectNetworkPlayer(GetPlayerId(), spawn.x, spawn.y, spawn.z, spawn.angle)
        local ped = GetPlayerPed(-1)

        -- V requires setting coords as well
        SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)

        NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.angle, false) --, true, true, false)
        


        -- gamelogic-style cleanup stuff
        ClearPedTasksImmediately(ped)
        SetPedMaxHealth(ped, 200) -- TODO: allow configuration of this?
        SetEntityHealth(ped, 200)
        RemoveAllPedWeapons(ped) -- TODO: make configurable (V behavior?)
        ClearPlayerWantedLevel(PlayerId())
        


        -- why is this even a flag?
        --SetCharWillFlyThroughWindscreen(ped, false)

        -- set primary camera angle
        --SetGameCamHeading(spawn.angle)
        --CamRestoreJumpcut(GetGameCam())

        -- load the scene; streaming expects us to do it
        --ForceLoadingScreen(true)
        --loadScene(spawn.x, spawn.y, spawn.z)
        --ForceLoadingScreen(false)

        while not HasCollisionLoadedAroundEntity(ped) do
            Citizen.Wait(0)
        end

        ShutdownLoadingScreen()

        DoScreenFadeIn(500)

        while IsScreenFadingIn() do
            Citizen.Wait(0)
        end

        -- and unfreeze the player
            
        freezePlayer(PlayerId(), false)
        checkForBadSpawn()

        TriggerEvent('playerSpawned', spawn)
        
        if class.faction~=nil then
            print("joining faction "..class.faction)
            TriggerServerEvent(event.join_gang,class.faction,true)
            Wait(700)
            ped=PlayerPedId()
        end
        SetPedRandomComponentVariation(ped, false)
        
        if class.weapons~=nil then
            if class.wepchance~=nil then
                if math.random(1,100)<class.wepchance then
                    if class.allweapons then
                        for k,v in pairs(class.weapons) do
                            GiveWeaponToPed(ped,v[1],v[2],false,true)
                            if v[3] then
                                GiveWeaponComponentToPed(ped, v[1], v[3])
                            end
                        end
                    else
                        local weprand=class.weapons[math.random(1,#class.weapons)]
                        GiveWeaponToPed(ped,weprand[1],weprand[2],false,true)
                        if weprand[3] then
                            GiveWeaponComponentToPed(ped, weprand[1], weprand[3])
                        end
                    end
                end
            end
        end
        if class.vehicles~=nil then
            local vehrand=class.vehicles[math.random(1,#class.vehicles)]
            local ppos=GetEntityCoords(ped)
            local heading=GetEntityHeading(ped)
            if ppos.z>300 then
            else
                RequestModel(vehrand[1]) while not HasModelLoaded(vehrand[1]) do Wait(0) end
                local veh
                if class.spawninair then
                    veh=CreateVehicle(vehrand[1], ppos.x, ppos.y, ppos.z+999.9, heading, true, false)
                    SetHeliBladesFullSpeed(veh)
                else
                    veh=CreateVehicle(vehrand[1], ppos.x, ppos.y, ppos.z-0.5, heading, true, false)
                end
                SetModelAsNoLongerNeeded(vehrand[1])
                SetVehicleDoorsLocked(veh,0)
                SetVehicleHasBeenOwnedByPlayer(veh,true)
                SetVehicleNeedsToBeHotwired(veh,false)
                SetPedIntoVehicle(ped,veh,-1)
                DecorSetInt(veh, "nowantedforstealing", GetPlayerServerId(PlayerId()))
                SetVehicleDirtLevel(veh,0.0)
                SetEntityAsNoLongerNeeded(veh)
                if class.vehrandmods then
                   local fueltank=GetVehiclePetrolTankHealth(veh)
                   local engine=GetVehicleEngineHealth(veh)
                   local body=GetVehicleBodyHealth(veh)
                   SetVehicleModKit(veh,0)
                   
                    local liverycount=GetVehicleLiveryCount(veh)
                    if liverycount>1 then
                        local livery=math.random(1,liverycount)
                        SetVehicleLivery(veh,livery)
                    end
                        
                   for modtype=0,100 do
                       local mods=GetNumVehicleMods(veh,modtype)
                       if mods>0 and modtype~=14 and modtype~=53 then
                           local mod=math.random(0,mods)
                           SetVehicleMod(veh,modtype,mod,math.random(0,1)==1)
                       end
                   end
                   SetVehiclePetrolTankHealth(veh,fueltank)
                   SetVehicleEngineHealth(veh,engine)
                   SetVehicleBodyHealth(veh,body)
                end
                if class.vehcolor~=nil then
                    SetVehicleColours(veh,class.vehcolor,class.vehcolor)
                    SetVehicleExtraColours(veh,class.vehcolor,class.vehcolor)
                end
            end
        end
        if class.armor~=nil then
            SetPedArmour(ped,class.armor)
        end
        if class.withdraw~=nil and class.property~=nil and class.property[1]~=nil then
            TriggerServerEvent(event.property_stash,class.property[1],-class.withdraw)
        end
        
        spawnLock = false
    end)
end

function SetNextSpawnPoint(x,y,z)
    nextspawn={x=x,y=y,z=z}
end

-- automatic spawning monitor thread, too
local respawnForced
local diedAt


local waitforserverbantimeresponse=false
local serverbantimeresponse
local expectedfactionbanresponse
local preventdoubleclick=false

local function RequestBanTimeFromFaction(factionid)
    expectedfactionbanresponse=factionid
    waitforserverbantimeresponse=true
    TriggerServerEvent(event.requestfactionbantime,factionid)
    while waitforserverbantimeresponse do Wait(0) end
    return serverbantimeresponse
end

RegisterNetEvent('factionbantime')
AddEventHandler('factionbantime',function(factionid,bantime)
    if expectedfactionbanresponse==factionid then
        serverbantimeresponse=bantime
        waitforserverbantimeresponse=false
    else
        TriggerServerEvent(event.requestfactionbantime,expectedfactionbanresponse)
    end
end)

local waitforchosecharacter=true
local classes={
    unknown={
        models=randomspawns_models,
        not_randomspawn=true,
    },
    thug={
        models={-1007618204},
        wepchance=25,
        weapons={
            {WEAPON.COMBATPISTOL,12},
            {WEAPON.PISTOL,12},
            {WEAPON.SNSPISTOL,6},
            {WEAPON.VINTAGEPISTOL,7},
        },
    },
    driver={
        models={-1067576423},
        wepchance=100,
        weapons={
            {WEAPON.BAT,1},
            {WEAPON.CROWBAR,1},
            {WEAPON.WRENCH,1},
            {WEAPON.KNUCKLE,1},
        },
        vehicles={
            {-808831384},
            {2006918058},
            {1039032026},
            {1348744438},
            {-1122289213},
            {-682211828},
            {-2095439403},
            {1507916787},
            {1923400478},
            {-825837129},
            {1645267888},
            {-1809822327},
            {-685276541},
            {-1289722222},
            {886934177},
            {-1883869285},
            {-1150599089},
            {-14495224},
            {-1477580979},
            {1723137093},
            {-1008861746},
            {464687292},
            {1221512915},
            {-1346687836},
            {1162065741},
            {-810318068},
            {699456151},
            {65402552},
            {-988501280},
        },
    },
    dealer={
        models={-459818001},
        wepchance=100,
        weapons={
            {WEAPON.SWITCHBLADE,1},
            {WEAPON.KNIFE,1},
            {WEAPON.DAGGER,1},
        },
        armor=50,
    },
    security={
        models={-681004504},
        vehicles={
        {1682114128},
        },
        wepchance=100,
        weapons={
            --{WEAPON.STUNGUN,1},
            {WEAPON.FLASHLIGHT,1},
            {WEAPON.NIGHTSTICK,1},
        },
        allweapons=true,
        faction=28,
    },
    resident={
        withdraw=15000,
        models={-1589423867},
        -- weapons={
            -- {WEAPON.PISTOL,24},
            -- {WEAPON.COMBATPISTOL,24},
            -- {WEAPON.PISTOL50,18},
            -- {WEAPON.PISTOLMK2,24},
            -- {WEAPON.HEAVYPISTOL,18},
        -- },
        vehicles={
        {1777363799},
        {-1008861746},
        {-1894894188},
        {1909141499},
        {-2030171296},
        {1203490606},
        {1337041428},
        {2136773105},
        {-1651067813},
        {-808457413},
        {1269098716},
        {486987393},
        {884422927},
        {-1543762099},
        {-1137532101},
        {1177543287},
        {142944341},
        {850565707},
        {972671128},
        {-1685021548},
        {-1800170043},
        {80636076},
        {142944341},
        {142944341},
        {-310465116},
        },
        property={"altahotel"},
    },
    hitman={
        models={-912318012},
        wepchance=100,
        weapons={
            {WEAPON.PISTOL,24,0x65EA7EBB}, --silencer
        },
        property={"altahotel"},
    },
    heister={
        models={1822283721},
        wepchance=25,
        weapons={
            {WEAPON.CARBINERIFLE,90},
        },
        faction=20,
        armor=100,
        property={"altahotel"},
    },
    elite={
        models={-245247470,691061163},
        wepchance=25,
        weapons={
            {WEAPON.APPISTOL,54},
        },
        vehicles={
        {3406724313},
        {1922255844},
        {470404958},
        {666166960},
        {3862958888},
        {-604842630},
        {704435172},
        },
        armor=100,
        faction=22,
        property={"stilt_2045nc","stilt_2044nc","stilt_3677wd","stilt_3655wod",
        "stilt_2217mr","stilt_2862ha","stilt_2868ha","stilt_2874ha","stilt_2113mwtd"},
    },
    ballas={
        models={-198252413,588969535,599294057,361513884},
        wepchance=100,
        weapons={
            {WEAPON.BAT,1},
            {WEAPON.KNIFE,1},
            {WEAPON.HAMMER,1},
            {WEAPON.GOLFCLUB,1},
            {WEAPON.CROWBAR,1},
            {WEAPON.KNUCKLE,1},
            {WEAPON.HATCHET,1},
            {WEAPON.MACHETE,1},
            {WEAPON.POOLCUE,1},
        },
        faction=14,
        vehicles={
            {1131912276},
            {-682211828},
            {-685276541},
            {-391594584},
            {-2124201592},
            {1830407356},
            {-624529134},
            {464687292},
            {-808831384},
            {1348744438},
            {-1150599089},
            {-893578776},
            {-114291515},
            {1836027715},
            {2006667053},
            {349605904},
            {525509695},
            {-2119578145},
        },
        vehcolor=145,
        property={"bomjatnya_1","bomjatnya_2","bomjatnya_3","bomjatnya_4","bomjatnya_paleto","bomjatnya_sandy",
        "bomjatnya_chumash","bomjatnya_harmony","bomjatnya_senora_hotel","bomjatnya_grapeseed","bomjatnya_paletoforest",
        "bomjatnya_colortv"},
    },
    family={
        models={-398748745,-613248456,-2077218039,1309468115},
        wepchance=100,
        weapons={
            {WEAPON.BAT,1},
            {WEAPON.KNIFE,1},
            {WEAPON.HAMMER,1},
            {WEAPON.GOLFCLUB,1},
            {WEAPON.CROWBAR,1},
            {WEAPON.KNUCKLE,1},
            {WEAPON.HATCHET,1},
            {WEAPON.MACHETE,1},
            {WEAPON.POOLCUE,1},
        },
        faction=15,
        vehicles={
            {-685276541},
            {-2124201592},
            {464687292},
            {-682211828},
            {1830407356},
            {2006918058},
            {-808831384},
            {1131912276},
            {-634879114},
        },
        vehcolor=57,
        property={"bomjatnya_1","bomjatnya_2","bomjatnya_3","bomjatnya_4","bomjatnya_paleto","bomjatnya_sandy",
        "bomjatnya_chumash","bomjatnya_harmony","bomjatnya_senora_hotel","bomjatnya_grapeseed","bomjatnya_paletoforest",
        "bomjatnya_colortv"},
    },
    helipilot={
        spawninair=true,
        models={411102470},
        vehicles={
        {744705981},
        },
        property={"helihangar"},
    },
    lostmc={
        models={-44746786,1330042375,1032073858,850468060},
        wepchance=100,
        weapons={
            {WEAPON.SWITCHBLADE,1},
            {WEAPON.KNIFE,1},
            {WEAPON.DAGGER,1},
            {WEAPON.BAT,1},
            {WEAPON.HAMMER,1},
            {WEAPON.GOLFCLUB,1},
            {WEAPON.CROWBAR,1},
            {WEAPON.KNUCKLE,1},
            {WEAPON.HATCHET,1},
            {WEAPON.MACHETE,1},
            {WEAPON.BATTLEAXE,1},
            {WEAPON.POOLCUE,1},
            {WEAPON.BOTTLE,1},
            {WEAPON.WRENCH,1},
        },
        vehicles={
        {390201602},{-1404136503},{2006142190},{741090084},{301427732},{-159126838},{-1606187161},{1873600305},{-618617997},{-1009268949},{-570033273},
        },
        faction=11,
        property={"mcclub"},
    },
    sportbiker={
        models={1794381917},--,-12678997,1694362237,2007797722},
        wepchance=25,
        weapons={
            {WEAPON.MICROSMG,32},
            {WEAPON.MACHINEPISTOL,36},
            {WEAPON.MINISMG,40},
            {WEAPON.SMGMK2,30},
        },
        vehicles={
        {-891462355},{-114291515},{11251904},{-1670998136},{1265391242},
        },
        property={"sportbikeclub"},
    },
    paramedic={
        models={-1286380898},
        vehicles={
        {1171614426},
        },
        faction=23,
        property={"pillbox"},
    },
    firefighter={
        models={-1229853272},
        vehicles={
        {1938952078},
        },
        faction=24,
        property={"pillbox"},
    },
    racer={
        models={1264851357},
        vehicles={
        {-1622444098},{1123216662},{767087018},{-1041692462},{1274868363},{736902334},{2072687711},
        {-1045541610},{108773431},{-566387422},{-1995326987},{-1089039904},{499169875},{-1297672541},
        {544021352},{-1372848492},{482197771},{-142942670},{-1461482751},{-377465520},
        {-1934452204},{1737773231},{1032823388},{719660200},{-746882698},{-1757836725},{1886268224},
        {384071873},{2765724541},
        },
        vehrandmods=true,
        wepchance=25,
        weapons={
            {WEAPON.COMBATPISTOL,12},
            {WEAPON.PISTOL,12},
            {WEAPON.VINTAGEPISTOL,7},
        },
        property={"premiumdeluxemotorsport"},
    },
}

local property_owned={}
RegisterNetEvent(event.property_owned)
AddEventHandler(event.property_owned,function(property_name)
    property_owned[property_name]=true
end)

RegisterNUICallback('chosecharacter', function(data, cb)
    print("clicked "..data.name)
    if waitforchosecharacter and not preventdoubleclick then
        preventdoubleclick=true
        cb('ok')
        SetNuiFocus(false,false)
        local class=classes[data.name]
        
        if class==nil then
            SendNUIMessage({
                chosecharacter=true
            })
            Wait(0)
            preventdoubleclick=false
            return
        end
        if class.property and not class.unlocked then
            for k,v in pairs(class.property) do
                if property_owned[v] then
                    class.unlocked=true
                    break
                end
            end
            if not class.unlocked then
                for k,v in pairs(class.property) do
                    TriggerServerEvent(event.property_check,v)
                end
                Wait(800)
                for k,v in pairs(class.property) do
                    if property_owned[v] then
                        class.unlocked=true
                        break
                    end
                end
            end
            if not class.unlocked then
                SendNUIMessage({
                    chosecharacter=true
                })
                Wait(0)
                preventdoubleclick=false
                SetNuiFocus(true,true)
                return
            end
        end
        if class.faction then
            if RequestBanTimeFromFaction(class.faction) then
                --banned
                print("banned from faction "..class.faction)
                SendNUIMessage({
                    chosecharacter=true
                })
                Wait(0)
                preventdoubleclick=false
                SetNuiFocus(true,true)
            else
                --not banned
                print("not banned from faction "..class.faction)
                SetNuiFocus(false,false)
                spawnPlayer(class)
                waitforchosecharacter=false
                preventdoubleclick=false
            end
        else
            SetNuiFocus(false,false)
            spawnPlayer(class)
            waitforchosecharacter=false
            preventdoubleclick=false
        end
    --spawnPlayer(data.name)
    else
        cb('ok')
    end
end)
                            
local function main_loop()
    --while not IsEntityDead(GetPlayerPed(-1)) do
    --    Wait(1000)
    --end
    local lastpos
    while true do
        Wait(50)

        local playerPed = GetPlayerPed(-1)

        if playerPed and playerPed ~= -1 then
            -- check if we want to autospawn
            if autoSpawnEnabled then
                if NetworkIsPlayerActive(PlayerId()) then
                    if (diedAt and (GetTimeDifference(GetGameTimer(), diedAt) > 10000)) or respawnForced then
                        if autoSpawnCallback then
                            autoSpawnCallback()
                        elseif showmenu and not spawnLock then
                            waitforchosecharacter=true
                            SendNUIMessage({
                            chosecharacter=true
                            })
                            Wait(0)
                            SendNUIMessage({
                            chosecharacter=true
                            })
                            Wait(0)
                            SendNUIMessage({
                            chosecharacter=true
                            })
                            Wait(0)
                            while waitforchosecharacter do
                                SetNuiFocus(true,true)
                                Wait(0)
                            end
                        else
                            spawnPlayer()
                        end

                        respawnForced = false
                    end
                end
            end

            if IsEntityDead(playerPed) then
                if not diedAt then
                    local pos = GetEntityCoords(playerPed)
                    if math.abs(GetEntityHeightAboveGround(playerPed))<4.0 then
                        diedAt = GetGameTimer()
                    else
                        if lastpos~=nil then
                            local step=math.abs(pos.x-lastpos.x)+math.abs(pos.y-lastpos.y)+math.abs(pos.z-lastpos.z)
                            if step<.01 or (IsEntityInWater(playerPed) and step<.1) then
                                diedAt = GetGameTimer()
                            end
                        end
                    end
                    lastpos={x=pos.x,y=pos.y,z=pos.z}
                end
            else
                diedAt = nil
                lastpos = nil
            end
        end
    end
end

-- Citizen.CreateThread(function()
    -- -- main loop thing
    -- Citizen.Wait(50)
    -- while true do
        -- Citizen.Wait(50)
        -- local playerPed = GetPlayerPed(-1)

        -- if playerPed and playerPed ~= -1 then
            -- if NetworkIsPlayerActive(PlayerId()) then
                -- TriggerServerEvent(event.savenquit_load)
                -- break
            -- end
        -- end
    -- end
-- end)

local snq_handler1,snq_handler2,snq_handler3

RegisterNetEvent(event.savenquit_none)
snq_handler1=AddEventHandler(event.savenquit_none,function(seed)
    RemoveEventHandler(snq_handler1)
    RemoveEventHandler(snq_handler2)
    Wait(10000)
    math.randomseed(seed)
    math.random()
    math.random()
    math.random()
    math.random()
    math.random()
    spawnLock = false
    respawnForced=false
    autoSpawnEnabled=true
    Citizen.CreateThread(main_loop)
end)

RegisterNetEvent(event.savenquit_load)
snq_handler2=AddEventHandler(event.savenquit_load,function()
    RemoveEventHandler(snq_handler2)
    RemoveEventHandler(snq_handler1)
    Wait(10000)
    math.randomseed(GetGameTimer())
    math.random()
    math.random()
    math.random()
    math.random()
    math.random()
    spawnLock = false
    respawnForced=false
    autoSpawnEnabled=true
    Citizen.CreateThread(main_loop)
end)

RegisterNetEvent('savenquit:use_map_resource')
snq_handler3=AddEventHandler('savenquit:use_map_resource',function()
    randomspawns_models=nil
    RemoveEventHandler(snq_handler3)
end)

function forceRespawn()
    spawnLock = false
    respawnForced = true
end
