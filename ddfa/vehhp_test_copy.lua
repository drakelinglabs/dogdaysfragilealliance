Citizen.CreateThread(function()
    local force_first_person=true
    local dont_let_me_smash=true
    local im_shooting=false
    local camera=nil
    Citizen.CreateThread(function()
        while true do
            if IsPedShooting(PlayerPedId()) then
                im_shooting=true
                Wait(100)
            else
                im_shooting=false
                Wait(0)
            end
        end
    end)
    local enable_crosshair={
    [782665360]=-1,     --tank driver
    [-2096818938]=1,        --technical shooter
    [-1860900134]={3,4,5,6,7},     --insurgent shooter
    [GetHashKey("squaddie2")]={3},     --squaddie2
    [-692292317]=0,--chernobog shooter
    [-32236122]=1,--halftruck shooter
    [-1205689942]={1,2,3,4,5,6},--riot
    [2071877360]={3,4}, --insurgent
    [-1775728740]={3,4,5,6}, --granger
    }
    local disable_weapons={
    [410882957]=true,
    --[-326143852]=true,
    }
        local sniperrifles={
        [177293209]=true,--heavymk2
        [100416529]=true,--sniper
        [205991906]=true,--heavy
        [0xFFFFFFFFC734385A]=true,--marksman
        [1672152130]=true,--hominglauncher
        }
        local explosives={
        [0xFFFFFFFFA0973D5E]=true,--bz
        [0xFFFFFFFF93E220BD]=true,--grenade
        [741814745]=true,--sticky
        [615608432]=true,--molotov
        [0xFFFFFFFFAB564B93]=true,--proxmine
        [0xFFFFFFFFBA45E8B8]=true,--pipe
        }
    local bigmapenabled=false
    local curcam
    while true do
        Wait(0)
        if IsControlJustPressed(0,20) 
        then 
            if bigmapenabled==false 
            then
                bigmapenabled=true
                SetRadarBigmapEnabled(true, false);
            else
                bigmapenabled=false
                SetRadarBigmapEnabled(false, false);
            end
        end
        
        local crosshair_default=false
        local crosshair_hidden=false
        local crosshair_show=false --force custom crosshair even if not aiming
        local ped=PlayerPedId()
        local weapon=GetSelectedPedWeapon(ped)
        if sniperrifles[weapon] then
            crosshair_default=true
            crosshair_hidden=true
        elseif IsPedInAnyVehicle(ped, false) then
            local veh=GetVehiclePedIsUsing(ped)
            local model=GetEntityModel(veh)
            if dont_let_me_smash then
                for window=0,3 do
                    if GetPedInVehicleSeat(veh,window-1)==ped then
                        if IsVehicleWindowIntact(veh,window) then
                            DisableControlAction(0,25,false)
                            DisableControlAction(0,68,false)
                            if IsDisabledControlPressed(0,68) then
                                RollDownWindow(veh,window)
                                --RemoveVehicleWindow(veh,window)
                            end
                        end
                        break
                    end
                end
            end
            crosshair_default=IsPedInAnyPlane(ped) or IsPedInAnyHeli(ped)
            if not (crosshair_default or IsPedOnAnyBike(ped) or IsThisModelAJetski(model)) then
                if enable_crosshair[model]==nil then
                    if GetFollowVehicleCamViewMode()~=4 then
                        crosshair_hidden=true
                    end
                else
                    if type(enable_crosshair[model])=='table' then
                        crosshair_hidden=true
                        for k,seat in pairs(enable_crosshair[model]) do
                            if GetPedInVehicleSeat(veh,seat)==ped then
                                crosshair_hidden=false
                                crosshair_show=true
                                break
                            end
                        end
                    elseif GetPedInVehicleSeat(veh,enable_crosshair[model])~=ped then
                        crosshair_hidden=true
                    else
                        crosshair_show=true
                    end
                end
            end
            if disable_weapons[model] then
                DisableControlAction(0,24,false)
                DisableControlAction(0,47,false)
                DisableControlAction(0,58,false)
                DisableControlAction(0,91,false)
                DisableControlAction(0,92,false)
                DisableControlAction(0,263,false)
                DisableControlAction(0,264,false)
                DisableControlAction(0,257,false)
                DisableControlAction(0,140,false)
                DisableControlAction(0,141,false)
                DisableControlAction(0,142,false)
                DisableControlAction(0,143,false)
                DisablePlayerFiring(PlayerId(),true)
            end
        end

        if not crosshair_default then
            HideHudComponentThisFrame(14)
        end

        if not crosshair_hidden then --crosshair_hidden
            if crosshair_show or GetPedConfigFlag(ped,78,1) or explosives[weapon] then
                local dict="hud_reticle" --darts
                local crosshair_zoomed="simpledotmp" --dart_reticules_zoomed
                local crosshair="simpledotmp" --dart_reticules
                if not HasStreamedTextureDictLoaded(dict) then
                    RequestStreamedTextureDict(dict,false)
                else
                    local x,y=GetActiveScreenResolution()
                    local crosshairsize=0.006 --0.03
                    if im_shooting then
                        --WriteText(0,"Shooting",0.35,255,255,255,255,0.3,0.80)
                        DrawSprite(dict, crosshair, 
                        0.5, 0.5, 
                        crosshairsize*y/x, crosshairsize, 
                        0.0, 
                        255, 255, 255, 200);
                    else
                        DrawSprite(dict, crosshair_zoomed, 
                        0.5, 0.5, 
                        crosshairsize*y/x, crosshairsize, 
                        0.0, 
                        255, 255, 255, 200);
                    end
                end
                --WriteText(0,"Flag aiming",0.35,255,255,255,255,0.3,0.75)
            end
            -- if IsFirstPersonAimCamActive() or IsAimCamActive() then
                -- WriteText(0,"First person aim",0.35,255,255,255,255,0.3,0.70)
            -- end
        end
        
                        --print(GetSeatPedIsTryingToEnter(ped))
        if force_first_person then
            --print(tostring(GetPedConfigFlag(ped,78,1)))
            --if crosshair_hidden and not crosshair_default then
                if GetPedConfigFlag(ped,78,1)~=false then
                    if curcam==nil then
                        curcam=GetFollowVehicleCamViewMode()
                        if curcam~=4 then
                            SetFollowVehicleCamViewMode(4)
                        end
                    elseif GetFollowVehicleCamViewMode()~=4 then
                        SetFollowVehicleCamViewMode(4)
                    end
                elseif curcam~=nil then
                    SetFollowVehicleCamViewMode(curcam)
                   -- print(tostring(IsControlPressed(0,68)).."  3   "..GetFollowVehicleCamViewMode())
                    curcam=nil
                end
            --end
        else
            if crosshair_hidden and not crosshair_default and GetPedConfigFlag(ped,78,1) then
                --SetFocusEntity(ped)
                if camera==nil then
                    camera=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",0.001,0.001,0.001,-90.0,.0,.0,50.0,1,2)
                    SetCamFov(camera,50.0)
                    --SetEntityCoordsNoOffset(GetPlayerPed(-1),pos[1],pos[2],pos[3], 1, 1, 1)
                    --SetEntityHeading(GetPlayerPed(-1),pos[4])
                    RenderScriptCams(true,false,1,true,true)
                    SetCamActive(camera,true)
                    SetCamAffectsAiming(camera,false)
                end
                local bob_x,bob_y=.0,.0
                local cam_pos=GetGameplayCamCoord()
                --if GetFollowPedCamViewMode()~=4 then
                local timestamp=(GetGameTimer()&0x1FFFF)*((2*math.pi)/0x20000)
                bob_x=3.0*math.sin(timestamp)
                bob_y=3.0*math.cos(timestamp*2+math.pi/2)
                --end
                --SetCamCoord(camera,cam_pos.x,cam_pos.y,cam_pos.z)
                local ent=GetVehiclePedIsUsing(ped)
                if ent==0 then ent=ped end 
                local pos=GetEntityCoords(ent)
                AttachCamToEntity(camera,ent,cam_pos.x-pos.x,cam_pos.y-pos.y,cam_pos.z-pos.z,false)
                local rot=GetGameplayCamRot(2)
                SetCamRot(camera,rot.x+bob_y,rot.y,rot.z+bob_x,2)
            elseif camera~=nil then
                --ClearFocus()
                RenderScriptCams(false,false,0,1,0)
                DestroyCam(camera,false)
                camera=nil
            end
        end
    end
end)

Citizen.CreateThread(function()
    local tank_buff={
    [-1649536104]=true,
    [782665360]=true,
    }
    local engine_nerf={
    [410882957]=true,--kuruma2
    [-326143852]=true,--dukes2
    [433954513]=true,--nightshark
    }
    local planes_maxspeed={
    [-1281684762]=500.0 --lazer
    }
    local planes_buff={
    [970385471]=.09, --hydra
    [-1281684762]=.12, --lazer
    [1824333165]=.1, --besra
    [1341619767]=.05 --vestra
    }
    while true do
        local ped=GetPlayerPed(-1)
                --SetPedCanRagdoll(ped, true);
                --SetPedToRagdoll(ped);
        if IsPedInAnyVehicle(ped, false) then
          if IsPedInAnyPlane(ped) then
            local veh=GetVehiclePedIsUsing(ped)
            local model=GetEntityModel(veh)
            local maxspeed=planes_maxspeed[model]
            if maxspeed==nil then
                maxspeed=4.0*GetVehicleModelMaxSpeed(model)
            end
            -- BeginTextCommandPrint("STRING");
            -- AddTextComponentString("mspeed="..maxspeed)
            -- EndTextCommandPrint(200, true);
            SetEntityMaxSpeed(veh,maxspeed)
            SetVehicleEnginePowerMultiplier(veh,5000.0)
            if IsControlPressed(0,87) then --71 ?
                local force=planes_buff[model]
                if force then
                    if model~=970385471 or GetVehicleHoverModePercentage(veh)<.1 then
                        ApplyForceToEntityCenterOfMass(veh, 1, .0, force, .0, false, true, true, false)
                        --SET_OBJECT_PHYSICS_PARAMS(Object object, float weight, float p2,  float p3, float p4, float p5, float gravity, float p7,  float p8, float p9, float p10, float buoyancy)
                    end
                end
            end
            Wait(10)
          elseif IsPedInAnyBoat(ped) then
          
            Wait(1000)
          elseif IsPedInAnyHeli(ped) then
          
            Wait(1000)
          elseif IsPedInAnySub(ped) then
          
            Wait(1000)
          else
            local veh = GetVehiclePedIsUsing(ped)
            local model = GetEntityModel(veh)
            if tank_buff[model] then
                local engine=GetVehicleEngineHealth(veh)
                local body=GetVehicleBodyHealth(veh)
                if engine<body then SetVehicleEngineHealth(veh,body) end
                Wait(0)
            else
                local veh_health = GetVehicleEngineHealth(veh)
                if (veh_health>450.0) then
                    SetVehicleEngineHealth(veh, 450.0)
                end
                --SetVehicleWheelsCanBreak(veh, true);
                if engine_nerf[model] then
                    SetVehicleEngineTorqueMultiplier(veh,0.75);
                    Wait(0)
                else
                    SetVehicleEnginePowerMultiplier(veh,20.0);
                    Wait(1000)
                end
                --SetVehicleEngineTorqueMultiplier(veh,1.5);
                --SetVehicleHudSpecialAbilityBarActive(veh, true);
                --SetVehicleSteeringScale(veh, 100.0);
            end
          end
        else --not in vehicle
          Wait(1000)
        end
    end
end)