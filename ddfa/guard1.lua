
local guard={
debug=false,remove_pickups=false,
health=200,health_timestamp=0,
max_health=200,max_health_altered=false,
model=nil,
armor=0,
legal_camera=-1,
x=0.0,y=0.0,z=0.0,
altpos={x=.0,y=.0,z=.0,vehmdl=0,frame=0},
frame_counter=0,
internal_wanted=0,wanted=0,wanted_set_timestamp=0,wanted_got_timestamp=0,wanted_flashed_last_time=false,
lost_cops_at_frame=0,
max_wanted=5,
is_driver=false,vehicle=0,veh_engine_health=1000.0,veh_body_health=1000.0,veh_explosion_timestamp=nil,veh_damaged_timestamp=nil,
invincible_1=false,invincibility_timestamp=0,
invincible_2=false,
last_check=0,
police_radar_blips=true,
player_blips=0,
ok_player_blips={},
blip_removal_frame={},
blipped_players={},
explosions=0,
decor_legal="spawn_by_script_normally",
decor_illegal="unknsource",
peds_with_armor={
    [-1920001264]=100,--swat
    [GetHashKey("s_m_y_swat_02")]=100,--custom swat
},
}




DecorRegister(guard.decor_legal,3)
DecorRegister(guard.decor_illegal,3)

guard.SetPoliceRadarBlips=SetPoliceRadarBlips
function SetPoliceRadarBlips(bool)
    guard.police_radar_blips=bool
    return guard.SetPoliceRadarBlips(bool)
end
guard.CreateVehicle=CreateVehicle
function CreateVehicle(model,x,y,z,h,bool1,bool2)
    local ret={guard.CreateVehicle(model,x,y,z,h,bool1,bool2)}
    DecorSetInt(ret[1],guard.decor_legal,GetPlayerServerId(PlayerId()))
    return table.unpack(ret)
end
guard.CreatePed=CreatePed
function CreatePed(pedtype,model,x,y,z,h,bool1,bool2)
    local ret={guard.CreatePed(pedtype,model,x,y,z,h,bool1,bool2)}
    DecorSetInt(ret[1],guard.decor_legal,GetPlayerServerId(PlayerId()))
    return table.unpack(ret)
end
guard.CreateObject=CreateObject
function CreateObject(model,x,y,z,bool1,bool2,bool3)
    local ret={guard.CreateObject(model,x,y,z,bool1,bool2,bool3)}
    DecorSetInt(ret[1],guard.decor_legal,GetPlayerServerId(PlayerId()))
    return table.unpack(ret)
end
guard.SetVehicleBodyHealth=SetVehicleBodyHealth
function SetVehicleBodyHealth(veh,health)
    if veh==guard.vehicle then
        guard.veh_body_health=health
    end
    return guard.SetVehicleBodyHealth(veh,health)
end
guard.SetVehicleEngineHealth=SetVehicleEngineHealth
function SetVehicleEngineHealth(veh,health)
    if veh==guard.vehicle then
        guard.veh_engine_health=health
    end
    return guard.SetVehicleEngineHealth(veh,health)
end
guard.SetVehicleFixed=SetVehicleFixed
function SetVehicleFixed(veh)
    if veh==guard.vehicle then
        guard.veh_body_health=1000.0
        guard.veh_engine_health=1000.0
    end
    return guard.SetVehicleFixed(veh)
end
guard.SetEntityHealth=SetEntityHealth
function SetEntityHealth(ped,health)
    if PlayerPedId()==ped then guard.health=health end
    local ret={guard.SetEntityHealth(ped,health)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." health="..health) end
    return table.unpack(ret)
end
guard.SetEntityMaxHealth=SetEntityMaxHealth
function SetEntityMaxHealth(ped,max_health)
    if PlayerPedId()==ped then
     guard.max_health=max_health
     guard.max_health_altered=true
    end
    local ret={guard.SetEntityMaxHealth(ped,max_health)}
    if guard.debug then print(GetGameTimer()..":ent="..ped.." max_health="..max_health) end
    return table.unpack(ret)
end
guard.SetPedMaxHealth=SetPedMaxHealth
function SetPedMaxHealth(ped,max_health)
    if PlayerPedId()==ped then
     guard.max_health=max_health
     guard.max_health_altered=true
    end
    local ret={guard.SetPedMaxHealth(ped,max_health)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." max_health="..max_health) end
    return table.unpack(ret)
end
guard.SetPedArmour=SetPedArmour
function SetPedArmour(ped,armor)
    if PlayerPedId()==ped then guard.armor=armor end
    local ret={guard.SetPedArmour(ped,armor)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." armor="..armor) end
    return table.unpack(ret)
end
guard.SetPedAmmo=SetPedAmmo
function SetPedAmmo(ped,weapon,ammo)
    if PlayerPedId()==ped and (guard.weapon==weapon or GetPedAmmoTypeFromWeapon(ped,guard.weapon)==GetPedAmmoTypeFromWeapon(ped,weapon)) then
        guard.ammo=ammo
    end
    local ret={guard.SetPedAmmo(ped,weapon,ammo)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." ammo="..ammo) end
    return table.unpack(ret)
end
guard.SetPedAmmoByType=SetPedAmmoByType
function SetPedAmmoByType(ped,ammotype,ammo)
    if PlayerPedId()==ped and GetPedAmmoTypeFromWeapon(ped,guard.weapon)==ammotype then
        guard.ammo=ammo
    end
    local ret={guard.SetPedAmmoByType(ped,ammotype,ammo)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." ammo="..ammo) end
    return table.unpack(ret)
end
guard.GiveWeaponToPed=GiveWeaponToPed
function GiveWeaponToPed(ped,weapon,ammo,hidden,equip)
    if PlayerPedId()==ped and guard.weapon==weapon then
        guard.ammo=guard.ammo+ammo
    end
    local ret={guard.GiveWeaponToPed(ped,weapon,ammo,hidden,equip)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." ammo="..ammo) end
    return table.unpack(ret)
end
guard.SetPlayerModel=SetPlayerModel
function SetPlayerModel(player,model)
    local myself=PlayerId()
    local ret={guard.SetPlayerModel(player,model)}
    if player==-1 or myself==player then
     local def_armor=guard.peds_with_armor[model]
     if def_armor~=nil then
      guard.armor=def_armor
     end
     guard.model=model
     local ped=GetPlayerPed(player)
     guard.max_health=GetPedMaxHealth(ped)
     guard.health=GetEntityHealth(ped)
     guard.max_health_altered=false
     DecorSetInt(ped,guard.decor_legal,GetPlayerServerId(myself))
    end
    if guard.debug then print(GetGameTimer()..":player="..player.." model="..model.." max_health="..guard.max_health) end
    return table.unpack(ret)
end
guard.SetEntityCoords=SetEntityCoords
function SetEntityCoords(ped,x,y,z)
    local myself=PlayerPedId()
    if myself==ped or ped==GetVehiclePedIsUsing(myself) then guard.x,guard.y,guard.z=x,y,z end
    local ret={guard.SetEntityCoords(ped,x,y,z)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." x="..x.." y="..y.." z="..z) end
    return table.unpack(ret)
end
guard.SetPedCoordsKeepVehicle=SetPedCoordsKeepVehicle
function SetPedCoordsKeepVehicle(ped,x,y,z)
    if PlayerPedId()==ped then guard.x,guard.y,guard.z=x,y,z end
    local ret={guard.SetPedCoordsKeepVehicle(ped,x,y,z)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." x="..x.." y="..y.." z="..z) end
    return table.unpack(ret)
end
guard.AddBlipForEntity=AddBlipForEntity
function AddBlipForEntity(ent)
    if IsEntityAPed(ent) and IsPedAPlayer(ent) then
        local player_index=NetworkGetPlayerIndexFromPed(ent)
        local blip=guard.AddBlipForEntity(ent)
        local old_blip=guard.blipped_players[player_index]
        if old_blip~=nil then
            guard.ok_player_blips[old_blip]=nil
        end
        guard.ok_player_blips[blip]=player_index
        guard.blipped_players[player_index]=blip
        return blip
    else
        return guard.AddBlipForEntity(ent)
    end
end
guard.RemoveBlip=RemoveBlip
function RemoveBlip(blip)
    local player_index=guard.ok_player_blips[blip]
    if player_index~=nil then
        local old_blip=guard.blipped_players[player_index]
        if old_blip~=blip then
            guard.ok_player_blips[old_blip]=nil
        end
        guard.blipped_players[player_index]=nil
        guard.ok_player_blips[blip]=nil
        guard.blip_removal_frame[player_index]=guard.frame_counter
    end
    return guard.RemoveBlip(blip)
end
guard.SetMaxWantedLevel=SetMaxWantedLevel --bool is always false
function SetMaxWantedLevel(maxwanted)
    guard.max_wanted=maxwanted
    if maxwanted<guard.wanted then
     guard.wanted=maxwanted
     if guard.wanted==0 then guard.lost_cops_at_frame=guard.frame_counter end
    end
    if maxwanted<guard.internal_wanted then
     guard.internal_wanted=maxwanted
    end
    local ret={guard.SetMaxWantedLevel(maxwanted)}
    if guard.debug then print(GetGameTimer()..":max_wanted="..maxwanted) end
    return table.unpack(ret)
end
guard.SetPlayerWantedLevel=SetPlayerWantedLevel --bool is always false
function SetPlayerWantedLevel(player,wanted,bool)
    if player==-1 or PlayerId()==player then
     local actual_wanted=wanted
     if actual_wanted>guard.max_wanted then
        actual_wanted=guard.max_wanted
     end
     if actual_wanted>guard.wanted then
      guard.internal_wanted=actual_wanted
      guard.wanted_set_timestamp=GetGameTimer()
     elseif actual_wanted<guard.wanted then
      guard.wanted=actual_wanted
      guard.wanted_set_timestamp=0
      guard.internal_wanted=0
      if guard.wanted==0 then guard.lost_cops_at_frame=guard.frame_counter end
     end
    end
    local ret={guard.SetPlayerWantedLevel(player,wanted,bool)}
    if guard.debug then print(GetGameTimer()..":player="..player.." wanted="..wanted) end
    return table.unpack(ret)
end
guard.SetPlayerWantedLevelNow=SetPlayerWantedLevelNow --bool is always false
function SetPlayerWantedLevelNow(player,bool)
    if player==-1 or PlayerId()==player and guard.wanted_set_timestamp~=0 then
     if guard.wanted==0 then
      guard.wanted_got_timestamp=GetGameTimer()
     end
     guard.wanted_set_timestamp=0
     guard.wanted=guard.internal_wanted
     guard.internal_wanted=0
     if guard.wanted==0 then guard.lost_cops_at_frame=guard.frame_counter end
    end
    local ret={guard.SetPlayerWantedLevelNow(player,bool)}
    if guard.debug then print(GetGameTimer()..":player="..player.." wanted now") end
    return table.unpack(ret)
end
guard.ClearPlayerWantedLevel=ClearPlayerWantedLevel
function ClearPlayerWantedLevel(player)
    if player==-1 or PlayerId()==player then
     if guard.wanted>0 then guard.lost_cops_at_frame=guard.frame_counter end
     guard.wanted=0
     guard.internal_wanted=0
     guard.wanted_set_timestamp=0
    end
    local ret={guard.ClearPlayerWantedLevel(player)}
    if guard.debug then print(GetGameTimer()..":player="..player.." no longer wanted") end
    return table.unpack(ret)
end

guard.SetEntityCoordsNoOffset=SetEntityCoordsNoOffset
function SetEntityCoordsNoOffset(ent,x,y,z,b1,b2,b3,b4)
    if PlayerPedId()==ent then guard.x,guard.y,guard.z=x,y,z end
    local ret={guard.SetEntityCoordsNoOffset(ent,x,y,z,b1,b2,b3,b4)}
    if guard.debug then print(GetGameTimer()..":entity="..ent.." x="..x.." y="..y.." z="..z) end
    return table.unpack(ret)
end
guard.SetEntityInvincible=SetEntityInvincible
function SetEntityInvincible(ent,toggle)
    if PlayerPedId()==ent then guard.invincible_1=toggle end
    local ret={guard.SetEntityInvincible(ent,toggle)}
    return table.unpack(ret)
end
guard.SetPlayerInvincible=SetPlayerInvincible
function SetPlayerInvincible(player,toggle)
    if PlayerId()==player then guard.invincible_2=toggle end
    local ret={guard.SetPlayerInvincible(player,toggle)}
    return table.unpack(ret)
end
guard.SetCamActive=SetCamActive
function SetCamActive(camera,toggle)
    guard.legal_camera=camera
    if guard.debug then print(GetGameTimer()..":SET camera="..camera) end
    local ret={guard.SetCamActive(camera,toggle)}
    return table.unpack(ret)
end
guard.NetworkResurrectLocalPlayer=NetworkResurrectLocalPlayer
function NetworkResurrectLocalPlayer(x,y,z,heading,protection,b2,b3)
    guard.x,guard.y,guard.z=x,y,z
    local ret={guard.NetworkResurrectLocalPlayer(x,y,z,heading,protection,b2,b3)}
    local ped=PlayerPedId()
    guard.health=GetEntityHealth(ped)
    guard.max_health=GetPedMaxHealth(ped)
    if guard.wanted>0 then guard.lost_cops_at_frame=guard.frame_counter end
    guard.wanted=0
    local timestamp=GetGameTimer()
    if protection then
        guard.invincibility_timestamp=timestamp
        guard.invincible_1=true
    end
    guard.health_timestamp=timestamp
    DecorSetInt(ped,guard.decor_legal,GetPlayerServerId(PlayerId()))
    if guard.debug then print(GetGameTimer()..":player resurrected x="..x.." y="..y.." z="..z) end
    return table.unpack(ret)
end
guard.TaskWarpPedIntoVehicle=TaskWarpPedIntoVehicle
function TaskWarpPedIntoVehicle(ped,veh,seat)
    if PlayerPedId()==ped then
        guard.altpos.x,guard.altpos.y,guard.altpos.z=table.unpack(GetEntityCoords(veh))
        guard.altpos.vehmdl=GetEntityModel(veh)
        guard.altpos.frame=guard.frame_counter
    end
    local ret={guard.TaskWarpPedIntoVehicle(ped,veh,seat)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." warped into vehicle="..veh.." seat="..seat) end
    return table.unpack(ret)
end
guard.SetPedIntoVehicle=SetPedIntoVehicle
function SetPedIntoVehicle(ped,veh,seat)
    if PlayerPedId()==ped then
        guard.x,guard.y,guard.z=table.unpack(GetEntityCoords(veh))
        guard.altpos.x,guard.altpos.y,guard.altpos.z=guard.x,guard.y,guard.z
        guard.altpos.vehmdl=GetEntityModel(veh)
        guard.altpos.frame=guard.frame_counter
    end
    local ret={guard.SetPedIntoVehicle(ped,veh,seat)}
    if guard.debug then print(GetGameTimer()..":ped="..ped.." set into vehicle="..veh.." seat="..seat) end
    return table.unpack(ret)
end

-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
local code_rgnv=39000000
local code_rgn=35105140
local code_xpl=35105000
local code_stp=30001000
local code_godv=30000989
local code_inv1=30000990
local code_inv2=30000991
local code_maxh=30000992
local code_mdl=30000993
local code_want=30000994
local code_maxw=30000995
local code_evwnt=30000996
local code_infcl=30000997
local code_infam=30000998
local code_cam=30000999
local code_armr=20000100
local code_blp=20000000
local code_obj=10000000
local code_ped=5000000
local code_xml=4500000
local code_xam=4000000
local code_veh=1000000
    local EXPLOSION={
        GRENADE=0,
        GRENADELAUNCHER=1,
        STICKYBOMB=2,
        MOLOTOV=3,
        ROCKET=4,
        TANKSHELL=5,
        HI_OCTANE=6,
        CAR=7,
        PLANE=8,
        PETROL_PUMP=9,
        BIKE=10,
        DIR_STEAM=11,
        DIR_FLAME=12,
        DIR_WATER_HYDRANT=13,
        DIR_GAS_CANISTER=14,
        BOAT=15,
        SHIP_DESTROY=16,
        TRUCK=17,
        BULLET=18,
        SMOKEGRENADELAUNCHER=19,
        SMOKEGRENADE=20,
        BZGAS=21,
        FLARE=22,
        GAS_CANISTER=23,
        EXTINGUISHER=24,
        PROGRAMMABLEAR=25,
        TRAIN=26,
        BARREL=27,
        PROPANE=28,
        BLIMP=29,
        DIR_FLAME_EXPLODE=30,
        TANKER=31,
        PLANE_ROCKET=32,
        VEHICLE_BULLET=33,
        GAS_TANK=34,
        --BIRD_CRAP=35,
        
        FIREWORK = 35,
        SNOWBALL = 36,
        PROXMINE = 37,
        VALKYRIE_CANNON = 38,
    }
    local vehicles_with_cannons={
    --[-1600252419]=true,--valkyrie
    [970385471]=true,--hydra
    [-1281684762]=true,--lazer
    [-82626025]=true,--savage
    --[562680400]=true,--apc
    --[782665360]=true,--rhino tank
    [-1881846085]=true,--anti air trailer
    }
    
    local cars_with_armor={--vehicle rewards
    [-1205689942]=100,--riot
    [GetHashKey("insurgent7")]=100,--custom insurgent
    }
    
    --local banned_peds={
    --[307287994]=true,--puma
    --}
    local banned_objects={
    [1952396163]=true,--windmill
    [-1268267712]=true,--fbi ufo
    [-320283514]=true,--damaged ufo
    [-733833763]=true,--cable cart
    [-528704006]=true,
    [234083239]=true,
    [959275690]=true,--small cage
    [-1968824367]=true,--stunts fat ramp/wall
    }
    local banned_vehicles={
    ----[410882957]=true,--armored kuruma
    --[562680400]=true,--APC
    [884483972]=true,--opressor
    [-1435527158]=true,--gauss tank
    [941494461]=true,--ruiner 2000
    [1483171323]=true,--deluxo
    [886810209]=true,--stromberg
    ----[433954513]=true,--nightshark
    [-1924433270]=true,--insurgent mk2
    [-1590337689]=true,--blazer aqua
    [1356124575]=true,--technical3
    ----[-326143852]=true,--duke'o'death
    [-1210451983]=true,--tampa3
    ----[-32236122]=true,--halftrack
    }

    local dispatched={}
    local max_dispatched={}
    for i=1,15 do
        dispatched[i]=0
        max_dispatched[i]=0
    end
    local vehicle_size={
    [368211810]=30, --andromaga
    [1058115860]=30, --jet
    }
    local veh_timestamp=0
    local det_infam=0
    local det_infcl=0
    local last_weapon_impact_coord={x=.0,y=.0,z=.0}
    local last_shot=0
    local last_attack_was_melee=false
    local explosive_ammo_detected=true --true to wait for first shot
    while true do
        Wait(0)
        guard.frame_counter=guard.frame_counter+1
        for i=1,15 do
            local dis=GetNumberOfDispatchedUnitsForPlayer(i)
            if max_dispatched[i]<dis then max_dispatched[i]=dis end
            if dispatched[i]~=dis then
                if guard.debug then print(GetGameTimer()..":DETECTED dispatched["..i.."]="..dis) end
            end
            dispatched[i]=dis
        end
        local player=PlayerId()
        local serverid=GetPlayerServerId(player)
        local ped=GetPlayerPed(player)
        local explosions=0
        local blips=0
        --local inveh=IsPedInAnyVehicle(ped,true)
        local inveh=IsPedInAnyVehicle(ped,false)
        local isdriver=false
        local veh=GetVehiclePedIsIn(ped,true)
        local vehmodel=0
        local veh_engine=1000.0
        local veh_body=1000.0
        local pos=GetEntityCoords(ped)
        local health=GetEntityHealth(ped)
        local max_health=GetPedMaxHealth(ped)
        local armor=GetPedArmour(ped)
        local model=GetEntityModel(ped)
        local wanted=GetPlayerWantedLevel(player)
        local max_wanted=GetMaxWantedLevel()
        local stars_about_to_drop=ArePlayerFlashingStarsAboutToDrop(player)
        local damaged_by_obj=HasEntityBeenDamagedByAnyObject(ped)
        local damaged_by_ped=HasEntityBeenDamagedByAnyPed(ped)
        local damaged_by_veh=HasEntityBeenDamagedByAnyVehicle(ped)
        local invincible_1=NetworkIsLocalPlayerInvincible()
        local invincible_2=GetPlayerInvincible(player)
        local weapon=GetSelectedPedWeapon(ped)
        if not IsWeaponValid(weapon) then weapon=nil end
        local shooting=IsPedShooting(ped)
        local reloading=IsPedReloading(ped)
        local camera=GetRenderingCam()
        local timestamp=GetGameTimer()
        local attached=false
        
        if inveh then
            vehmodel=GetEntityModel(veh)
            if GetPedInVehicleSeat(veh,-1)==ped then
                if NetworkHasControlOfEntity(veh) then isdriver=true end
                attached=IsEntityAttached(veh)
                SetEntityInvincible(veh,false)
                veh_engine=GetVehicleEngineHealth(veh)
                veh_body=GetVehicleBodyHealth(veh)
                if guard.vehicle~=veh then
                    guard.vehicle=veh
                    guard.veh_engine_health=veh_engine
                    guard.veh_body_health=veh_body
                    if guard.debug then print(timestamp..":DETECTED took control over vehicle") end
                    guard.veh_explosion_timestamp=nil
                else
                    local damaged=false
                    if guard.veh_engine_health~=veh_engine then
                        if guard.veh_engine_health<veh_engine then
                            TriggerServerEvent(event.debug,code_rgnv+veh_engine-guard.veh_engine_health)
                        else
                            guard.veh_damaged_timestamp=timestamp
                        end
                        guard.veh_engine_health=veh_engine
                    end
                    if guard.veh_body_health~=veh_body then
                        if guard.veh_body_health<veh_body then
                            TriggerServerEvent(event.debug,code_rgnv+veh_body-guard.veh_body_health)
                        else
                            guard.veh_damaged_timestamp=timestamp
                        end
                        guard.veh_body_health=veh_body
                    end
                    if veh_body>0.0 and veh_engine>0.0 and guard.veh_explosion_timestamp~=nil then
                        if guard.veh_damaged_timestamp==nil and timestamp-guard.veh_explosion_timestamp>2000
                        or guard.veh_damaged_timestamp~=nil and timestamp-guard.veh_explosion_timestamp>1000 and guard.veh_explosion_timestamp-guard.veh_damaged_timestamp>2000 then
                            guard.veh_damaged_timestamp=guard.veh_explosion_timestamp
                            TriggerServerEvent(event.debug,code_godv)
                        end
                    end
                    local x0,y0,z0,x1,y1,z1=pos.x-4,pos.y-4,pos.z-4,pos.x+4,pos.y+4,pos.z+4
                    if IsExplosionInArea(EXPLOSION.GRENADE,x0,y0,z0,x1,y1,z1)
                    or IsExplosionInArea(EXPLOSION.GRENADELAUNCHER,x0,y0,z0,x1,y1,z1)
                    or IsExplosionInArea(EXPLOSION.STICKYBOMB,x0,y0,z0,x1,y1,z1)
                    or IsExplosionInArea(EXPLOSION.ROCKET,x0,y0,z0,x1,y1,z1)
                    or IsExplosionInArea(EXPLOSION.TANKSHELL,x0,y0,z0,x1,y1,z1)
                    or IsExplosionInArea(EXPLOSION.VEHICLE_BULLET,x0,y0,z0,x1,y1,z1)
                    or IsExplosionInArea(EXPLOSION.PLANE_ROCKET,x0,y0,z0,x1,y1,z1)
                    or IsExplosionInArea(EXPLOSION.VALKYRIE_CANNON,x0,y0,z0,x1,y1,z1)
                    or IsExplosionInArea(EXPLOSION.PROXMINE,x0,y0,z0,x1,y1,z1)
                    then
                        guard.veh_explosion_timestamp=timestamp
                    end
                end
            end
        end
        if not isdriver then
            attached=IsEntityAttached(ped)
            if guard.vehicle~=0 and guard.debug then print(timestamp..":DETECTED lost control over vehicle") end
            guard.vehicle=0
            guard.veh_explosion_timestamp=nil
            guard.veh_damaged_timestamp=nil
        end
        --local damaged_by_ent=HasEntityBeenDamagedByAnyEntity(ped)
        if guard.damaged_by_obj~=damaged_by_obj then
            guard.damaged_by_obj=damaged_by_obj
            if guard.debug and damaged_by_obj then print(timestamp..":DETECTED damaged_by_obj") end
        end
        if guard.damaged_by_ped~=damaged_by_ped then
            guard.damaged_by_ped=damaged_by_ped
            if guard.debug and damaged_by_ped then print(timestamp..":DETECTED damaged_by_ped") end
        end
        if guard.damaged_by_veh~=damaged_by_veh then
            guard.damaged_by_veh=damaged_by_veh
            if guard.debug and damaged_by_veh then print(timestamp..":DETECTED damaged_by_veh") end
        end
        if guard.invincible_1~=invincible_1 then
            guard.invincible_1=invincible_1
            if guard.debug then
             if invincible_1 then
              if guard.debug then print(timestamp..":DETECTED invincibility type 1 ENABLED") end
              TriggerServerEvent(event.debug,code_inv1)
             else
              if guard.debug then print(timestamp..":DETECTED invincibility type 1 DISABLED") end
             end
            end
        end
        if invincible_1 and timestamp-guard.invincibility_timestamp>2000 then
            --print(timestamp..":DETECTED invincibility type 1 ENABLED")
            TriggerServerEvent(event.debug,code_inv1)
        end
        if guard.invincible_2~=invincible_2 then
            guard.invincible_2=invincible_2
            if guard.debug then
             if invincible_2 then
              if guard.debug then print(timestamp..":DETECTED invincibility type 2 ENABLED") end
              TriggerServerEvent(event.debug,code_inv2)
             else
              if guard.debug then print(timestamp..":DETECTED invincibility type 2 DISABLED") end
             end
            end
        end
        -- -- if guard.max_health_altered==false and guard.model_maxhealth[model]==nil then
            -- -- guard.max_health=GetPedMaxHealth(ped)
            -- -- guard.model_maxhealth[model]=guard.max_health
            -- -- guard.max_health_altered=false
            -- -- if guard.debug then print("model "..model.." maxhealth updated to "..guard.model_maxhealth[model]) end
        -- -- end
        if guard.model~=model then
            if guard.model~=nil then TriggerServerEvent(event.debug,code_mdl) end
            guard.model=model
            if guard.debug then print(timestamp..":DETECTED model changed to "..model) end
        end
        if guard.max_health~=max_health then
            if max_health>guard.max_health then TriggerServerEvent(event.debug,code_maxh) end
            guard.max_health=max_health
            if guard.debug then print(timestamp..":DETECTED max_health="..health) end
        end

        if guard.health~=health then
            if health>guard.health then
             if health>guard.max_health/2+50 or (health-guard.health)*120>(timestamp-guard.health_timestamp) then
              if vehmodel~=1171614426 then --ambulance
               TriggerServerEvent(event.debug,code_rgn+health-guard.health)
              end
             end
            end
            guard.health=health
            guard.health_timestamp=timestamp
            if guard.debug then print(timestamp..":DETECTED health="..health) end
        end
        
        if guard.z>-190.0 then
            local dx,dy,dz=guard.x-pos.x,guard.y-pos.y,guard.z-pos.z
            local delta=math.sqrt(dx*dx+dy*dy+dz*dz)
            local vel=(delta*1000.0)/(timestamp-guard.last_check)
            delta=math.floor(delta+.5)
            vel=math.floor(vel+.5)
            if vel>555 then
                local veh_size=nil
                if veh~=0 then veh_size=vehicle_size[vehmodel] end
                if veh_size~=nil and delta<veh_size and veh_timestamp+400<timestamp and (guard.inveh~=inveh) then
                    if guard.debug then print(timestamp..":DETECTED entered/exited "..GetDisplayNameFromVehicleModel(vehmodel).." step="..delta) end
                    veh_timestamp=timestamp
                elseif veh==0 or isdriver then
                    if not attached then
                        --dx,dy,dz=guard.altpos.x-pos.x,guard.altpos.y-pos.y,guard.altpos.z-pos.z
                        --local delta2=math.sqrt(dx*dx+dy*dy+dz*dz)
                        TriggerServerEvent(event.debug,code_stp+delta,vel,{from={guard.x,guard.y,guard.z},to={pos.x,pos.y,pos.z},alt={guard.altpos.x,guard.altpos.y,guard.altpos.z},vm=(guard.altpos.vehmdl),frames=(guard.frame_counter-guard.altpos.frame)})
                        if guard.debug then
                            print(timestamp..":DETECTED velocity="..vel.." step="..delta.." alt_step="..delta2.." alt_fr="..(guard.frame_counter-guard.altpos.frame).." alt_vehmodel="..guard.altpos.vehmdl)
                            SetTextColour(255, 0, 0, 255)
                        end
                    end
                end
            end
            if guard.debug then
                SetTextOutline()
                SetTextFont(4)
                SetTextScale(.3,.3)
                SetTextEntry("STRING")
                AddTextComponentString("velocity="..vel)
                EndTextCommandDisplayText(.5,.8)
            end
        end
        guard.x,guard.y,guard.z=pos.x,pos.y,pos.z
        if guard.inveh~=inveh then
            guard.inveh=inveh
            if guard.debug then print(timestamp..":DETECTED entered/exited") end
        end
        guard.is_driver=isdriver
        if guard.armor~=armor then
            if armor>guard.armor then
             if cars_with_armor[vehmodel]==nil then
              TriggerServerEvent(event.debug,code_armr+armor-guard.armor)
             end
            end
            guard.armor=armor
            if guard.debug then print(timestamp..":DETECTED armor="..armor) end
        end
        if guard.police_radar_blips and (guard.wanted>0 or wanted>0 or stars_about_to_drop or guard.wanted_flashed_last_time or (guard.frame_counter-guard.lost_cops_at_frame)<30) then
            for p=0,31 do
                if NetworkIsPlayerActive(p) then
                    local target=GetPlayerPed(p)
                    if player~=p and GetBlipFromEntity(target)~=0 then
                        if not guard.blipped_players[p] and (guard.blip_removal_frame[p]==nil or (guard.frame_counter-guard.blip_removal_frame[p])>30) then
                            if not IsPedCop(target) then
                                blips=blips+1
                            end
                        end
                    end
                    local pos=GetEntityCoords(target)
                    local x0,y0,z0,x1,y1,z1=pos.x-10.0,pos.y-10.0,pos.z-10.0,pos.x+10.0,pos.y+10.0,pos.z+10.0
                    for t=0,38 do
                        if IsExplosionInArea(t,x0,y0,z0,x1,y1,z1) then
                            explosions=explosions+1
                        end
                    end
                end
            end
        else
            for p=0,31 do
                if NetworkIsPlayerActive(p) then
                    local target=GetPlayerPed(p)
                    if player~=p and GetBlipFromEntity(target)~=0 then
                        if not guard.blipped_players[p] and (guard.blip_removal_frame[p]==nil or (guard.frame_counter-guard.blip_removal_frame[p])>30) then
                            blips=blips+1
                        end
                    end
                    local pos=GetEntityCoords(target)
                    local x0,y0,z0,x1,y1,z1=pos.x-10.0,pos.y-10.0,pos.z-10.0,pos.x+10.0,pos.y+10.0,pos.z+10.0
                    for t=0,38 do
                        if IsExplosionInArea(t,x0,y0,z0,x1,y1,z1) then
                            explosions=explosions+1
                        end
                    end
                end
            end
        end
        if guard.explosions~=explosions then
            guard.explosions=explosions
            if guard.debug then print(GetGameTimer()..":DETECTED explosions="..explosions) end
            TriggerServerEvent(event.debug,code_xpl+explosions)
        end
        if guard.player_blips~=blips then
            guard.player_blips=blips
            if guard.debug then
                print(GetGameTimer()..":DETECTED blips="..blips)
                print("lost cops "..(guard.frame_counter-guard.lost_cops_at_frame).." frames ago")
            end
            TriggerServerEvent(event.debug,code_blp+blips)
        end
        if guard.wanted~=wanted then
            if wanted>guard.wanted then
                guard.wanted_got_timestamp=timestamp
            elseif wanted<guard.wanted then --and timestamp-guard.wanted_timestamp<1000 then
                if timestamp-guard.wanted_got_timestamp<39000 and guard.wanted_flashed_last_time==false then
                    TriggerServerEvent(event.debug,code_want)
                end
                if wanted==0 then guard.lost_cops_at_frame=guard.frame_counter end
                if guard.debug then print("you were wanted for "..(timestamp-guard.wanted_got_timestamp).."ms") end
            end
            guard.wanted=wanted
            if guard.debug then print(timestamp..":DETECTED wanted="..wanted) end
        end
        if guard.max_wanted~=max_wanted then
            guard.max_wanted=max_wanted
            TriggerServerEvent(event.debug,code_maxw)
            if guard.debug then print(timestamp..":DETECTED max_wanted="..max_wanted) end
        end
        if guard.wanted_set_timestamp~=0 and timestamp-guard.wanted_set_timestamp>10000 then
            if wanted<guard.internal_wanted then
                TriggerServerEvent(event.debug,code_evwnt)
                if guard.debug then print(timestamp..":DETECTED evaded pending wanted level") end
            end
            guard.wanted_set_timestamp=0
            guard.internal_wanted=0
        end
        guard.wanted_flashed_last_time=stars_about_to_drop
        if weapon~=nil and weapon~=guard.weapon then
            guard.weapon=weapon
            guard.clip=GetAmmoInClip(ped,weapon)
            guard.ammo=GetAmmoInPedWeapon(ped,weapon)
            if guard.debug then print(timestamp..":DETECTED switched weapon to "..weapon) end
        end
        if shooting and weapon~=911657153 then --not for tazer
            local bool,clip=GetAmmoInClip(ped,weapon)
            local ammo=GetAmmoInPedWeapon(ped,weapon)
            if bool and clip==guard.clip and GetMaxAmmoInClip(ped,weapon,1)~=1 then
                det_infcl=det_infcl+1
                if det_infcl>50 then
                    det_infcl=det_infcl-50
                    TriggerServerEvent(event.debug,code_infcl)
                end
            end
            if bool and ammo==guard.ammo then
                det_infam=det_infam+1
                if det_infam>50 then
                    det_infam=det_infam-50
                    TriggerServerEvent(event.debug,code_infam)
                end
            end
            guard.clip=clip
            guard.ammo=ammo
            if guard.debug then print("ammo="..GetAmmoInPedWeapon(ped,weapon).." clip="..clip.." clip_size="..GetWeaponClipSize(weapon)) end
        end
        if (not inveh and weapon~=1834241177) --not a railgun
           or
           (inveh and vehicles_with_cannons[vehmodel]==nil)
        then
            local success,hitpos=GetPedLastWeaponImpactCoord(ped)
            if success then
                last_weapon_impact_coord.x,last_weapon_impact_coord.y,last_weapon_impact_coord.z=hitpos.x,hitpos.y,hitpos.z
                last_shot=timestamp
                explosive_ammo_detected=false
                last_attack_was_melee=IsPedInMeleeCombat(ped)
                --print("hit "..last_weapon_impact_coord.x.." "..last_weapon_impact_coord.y.." "..last_weapon_impact_coord.z)
            end
            if not explosive_ammo_detected and timestamp-last_shot<500 then
                local explosions=0
                local x0,y0,z0=last_weapon_impact_coord.x-.4,last_weapon_impact_coord.y-.4,last_weapon_impact_coord.z-.4
                local x1,y1,z1=last_weapon_impact_coord.x+.4,last_weapon_impact_coord.y+.4,last_weapon_impact_coord.z+.4
                for t=0,38 do
                    if IsExplosionInArea(t,x0,y0,z0,x1,y1,z1) then
                        explosions=explosions+1
                    end
                end
                if explosions>0 then
                    explosive_ammo_detected=true
                    if last_attack_was_melee then
                        TriggerServerEvent(event.debug,code_xml+explosions)
                    else
                        TriggerServerEvent(event.debug,code_xam+explosions)
                    end
                end
            end
        end
        if guard.camera~=camera then
            guard.camera=camera
            if camera~=-1 and camera~=guard.legal_camera then TriggerServerEvent(event.debug,code_cam) end
            if guard.debug then print(timestamp..":DETECTED camera="..camera) end
        end
        if banned_peds~=nil then
            local peds=0
            for ped in EnumeratePeds() do
                if not IsPedAPlayer(ped) then
                    if not DecorExistOn(ped,guard.decor_legal) and not DecorExistOn(ped,guard.decor_illegal) then
                        DecorSetInt(ped,guard.decor_illegal,serverid)
                        local model=GetEntityModel(ped)
                        if banned_peds[model] then
                            peds=peds+1
                        end
                    end
                end
            end
            if guard.peds~=peds then
                guard.peds=peds
                if guard.debug then print(GetGameTimer()..":DETECTED peds="..peds) end
                TriggerServerEvent(event.debug,code_ped+peds)
            end
        end
        if banned_objects~=nil then
            local objects=0
            for obj in EnumerateObjects() do
                if NetworkGetEntityIsNetworked(obj) and not DecorExistOn(obj,guard.decor_legal) and not DecorExistOn(obj,guard.decor_illegal) then
                    DecorSetInt(obj,guard.decor_illegal,serverid)
                    local model=GetEntityModel(obj)
                    if banned_objects[model] then
                        SetEntityAsMissionEntity(obj,true,true)
                        DeleteObject(obj)
                        objects=objects+1
                    end
                end
            end
            if guard.objects~=objects then
                guard.objects=objects
                if guard.debug then print(GetGameTimer()..":DETECTED objects="..objects) end
                TriggerServerEvent(event.debug,code_obj+objects)
            end
        end
        if banned_vehicles~=nil then
            local vehicles=0
            for veh in EnumerateVehicles() do
                if not DecorExistOn(veh,guard.decor_legal) and not DecorExistOn(veh,guard.decor_illegal) then
                    DecorSetInt(veh,guard.decor_illegal,serverid)
                    local model=GetEntityModel(veh)
                    if banned_vehicles[model] then
                        SetEntityAsMissionEntity(veh,true,true)
                        DeleteVehicle(veh)
                        vehicles=vehicles+1
                    end
                end
            end
            if guard.vehicles~=vehicles then
                guard.vehicles=vehicles
                if guard.debug then print(GetGameTimer()..":DETECTED vehicles="..vehicles) end
                TriggerServerEvent(event.debug,code_veh+vehicles)
            end
        end
        guard.last_check=timestamp
        
        if guard.debug then
            SetTextOutline()
            SetTextFont(4)
            SetTextScale(.3,.3)
            SetTextEntry("STRING")
            AddTextComponentString("wanted="..wanted)
            EndTextCommandDisplayText(.5,.82)
            SetTextOutline()
            SetTextFont(4)
            SetTextScale(.3,.3)
            SetTextEntry("STRING")
            AddTextComponentString("int_wanted="..guard.internal_wanted)
            EndTextCommandDisplayText(.5,.84)
            SetTextOutline()
            SetTextFont(4)
            SetTextScale(.3,.3)
            SetTextEntry("STRING")
            AddTextComponentString("max_wanted="..guard.max_wanted)
            EndTextCommandDisplayText(.5,.86)
            
            -- SetTextOutline()
            -- SetTextFont(4)
            -- SetTextScale(.3,.3)
            -- SetTextEntry("STRING")
            -- AddTextComponentString("tr0="..GetWantedLevelThreshold(0))
            -- EndTextCommandDisplayText(.6,.78)
            -- SetTextOutline()
            -- SetTextFont(4)
            -- SetTextScale(.3,.3)
            -- SetTextEntry("STRING")
            -- AddTextComponentString("tr1="..GetWantedLevelThreshold(1))
            -- EndTextCommandDisplayText(.6,.8)
            -- SetTextOutline()
            -- SetTextFont(4)
            -- SetTextScale(.3,.3)
            -- SetTextEntry("STRING")
            -- AddTextComponentString("tr2="..GetWantedLevelThreshold(2))
            -- EndTextCommandDisplayText(.6,.82)
            -- SetTextOutline()
            -- SetTextFont(4)
            -- SetTextScale(.3,.3)
            -- SetTextEntry("STRING")
            -- AddTextComponentString("tr3="..GetWantedLevelThreshold(3))
            -- EndTextCommandDisplayText(.6,.84)
            -- SetTextOutline()
            -- SetTextFont(4)
            -- SetTextScale(.3,.3)
            -- SetTextEntry("STRING")
            -- AddTextComponentString("tr4="..GetWantedLevelThreshold(4))
            -- EndTextCommandDisplayText(.6,.86)
            -- SetTextOutline()
            -- SetTextFont(4)
            -- SetTextScale(.3,.3)
            -- SetTextEntry("STRING")
            -- AddTextComponentString("tr5="..GetWantedLevelThreshold(5))
            -- EndTextCommandDisplayText(.6,.88)
            -- SetTextOutline()
            -- SetTextFont(4)
            -- SetTextScale(.3,.3)
            -- SetTextEntry("STRING")
            -- AddTextComponentString("tr6="..GetWantedLevelThreshold(6))
            -- EndTextCommandDisplayText(.6,.9)
        end
    end
end)

if guard.remove_pickups then
Citizen.CreateThread(function()
    -- local banned_pickups={ --pickup hashes
    -- [0x5C517D97]=true, --PICKUP_AMMO_HOMINGLAUNCHER
    -- [0xFFFFFFFFF25A01B9]=true, --PICKUP_AMMO_MINIGUN
    -- [0x1CD2CF66]=true, --PICKUP_HEALTH_SNACK
    -- [0xFFFFFFFF8F707C18]=true, --PICKUP_HEALTH_STANDARD
    -- [0xC01EB678]=true, --PICKUP_WEAPON_HOMINGLAUNCHER
    -- [0x2F36B434]=true, --PICKUP_WEAPON_MINIGUN
    -- [0x4316CC09]=true, --PICKUP_VEHICLE_ARMOUR_STANDARD
    -- [0x098D79EF]=true, --PICKUP_VEHICLE_HEALTH_STANDARD
    -- [0xFFFFFFFFFDEE8368]=true, --PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW
    -- }
    local banned_pickup_models={} --model hashes
    banned_pickup_models[GetHashKey("prop_ld_health_pack")]=true
    local banned_weapons={
        --[WEAPON.HOMINGLAUNCHER]=true,
        [WEAPON.MINIGUN]=true,
    }
    --banned_pickups[GetHashKey("prop_ld_health_pack")]=true
    -- prop_bodyarmour_02
-- prop_bodyarmour_03
-- prop_bodyarmour_04
-- prop_bodyarmour_05
-- prop_bodyarmour_06
--prop_ld_armour
    while true do
        Wait(0)
        local n=0
        local delet_this={}
        for pickup in EnumeratePickups() do
            local model=GetEntityModel(pickup)
            if model~=0 then
                local whash=GetWeaponHashFromPickup(pickup)
                if whash==0 then
                    --if banned_pickup_models[model] then
                    n=n+1
                    delet_this[n]=pickup
                    --end
                elseif banned_weapons[whash] then
                    n=n+1
                    delet_this[n]=pickup
                end
            end
        end
        for _,pickup in pairs(delet_this) do
            --guard.SetEntityCoords(pickup,10000.0,12000.0,-13000.0)
            SetEntityAsMissionEntity(pickup,false,false)
            RemovePickup(pickup)
            DeleteObject(pickup)
        end
        if guard.debug and n~=0 then
            print(GetGameTimer()..":pickups removed "..n)
        end
    end
end)
end


-- RegisterNetEvent('initiate_standard_procedure')
-- AddEventHandler('initiate_standard_procedure',function(error_code)
    -- if error_code~=nil and error_code==13374 then
        -- guard.debug=true
    -- end
-- end)