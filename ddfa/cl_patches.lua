
local time_difference=0
local HookGetGameTimer=GetGameTimer
function GetSyncTimer()
    return HookGetGameTimer()+time_difference
end
RegisterNetEvent(event.server_timestamp)
AddEventHandler(event.server_timestamp,function(server_timestamp)
    time_difference=server_timestamp-HookGetGameTimer()
    print("time_difference="..time_difference)
end)
TriggerServerEvent(event.server_timestamp)
print("requesting time_difference...")
Citizen.CreateThread(function()
    Wait(10000)
    print("requesting time_difference again...")
    TriggerServerEvent(event.server_timestamp)
    Wait(10000)
    print("requesting time_difference again...")
    TriggerServerEvent(event.server_timestamp)
end)

function IsPedCop(ped)
    local pedType = GetPedType(ped)
    return (pedType==6) or (pedType==27)
end

local _i, _f, _v, _r, _ri, _rf, _rl, _s, _rv, _ro, _in, _ii, _fi =
	Citizen.PointerValueInt(), Citizen.PointerValueFloat(), Citizen.PointerValueVector(),
	Citizen.ReturnResultAnyway(), Citizen.ResultAsInteger(), Citizen.ResultAsFloat(), Citizen.ResultAsLong(), Citizen.ResultAsString(), Citizen.ResultAsVector(), Citizen.ResultAsObject(),
	Citizen.InvokeNative, Citizen.PointerValueIntInitialized, Citizen.PointerValueFloatInitialized

--local g = _G
--local rs = rawset
--local msgpack = msgpack
--local _tostring = tostring
--local function _ts(num)
--	if num == 0 or not num then -- workaround for users calling string parameters with '0', also nil being translated
--		return nil
--	end
--	return _tostring(num)
--end
local function _ch(hash)
	if type(hash) == 'string' then
		return GetHashKey(hash)
	end
	return hash
end
--local function _mfr(fn)
--	return Citizen.GetFunctionReference(fn)
--end
    
local HookNetworkGetNetworkIdFromEntity=NetworkGetNetworkIdFromEntity
function NetworkGetNetworkIdFromEntity(ent)
    if(not DoesEntityExist(ent))then return nil end 
    return HookNetworkGetNetworkIdFromEntity(ent)
end

-- local HookIsVehicleTyreBurst=IsVehicleTyreBurst
-- function IsVehicleTyreBurst(v,t,b)
    -- local ret=HookIsVehicleTyreBurst(v,t,b)
    -- if ret==nil or ret==false or ret==0 then return false end
    -- return true
-- end

function IsVehicleTyreBurst(vehicle, wheelID, completely)
	return _in(0xBA291848A0815CA9, vehicle, wheelID, completely, _r)
end

function IsVehicleDoorFullyOpen(v, door)
	return _in(0x3E933CFF7B111C22, v, door, _r)
end

-- local HookIsVehicleDoorFullyOpen=IsVehicleDoorFullyOpen
-- function IsVehicleDoorFullyOpen(v,d)
    -- local ret=HookIsVehicleDoorFullyOpen(v,d)
    -- if ret==nil or ret==false or ret==0 then return false end
    -- return true
-- end


local HookGetEntityModel=GetEntityModel
function GetEntityModel(ent)
    if DoesEntityExist(ent) then
        return HookGetEntityModel(ent)
    end
    return 0
end

function IsPedShooting(ped)
	return _in(0x34616828CD07F1A1, ped, _r)
end

function ScGetNickname()
	return _in(0x198D161F458ECC7F, _r, _s)
end

function IsPedReloading(ped)
    return _in(0x24B100C68C645951, ped, _r)
end

function GetVehicleMaxSpeed(vehicle)
	return _in(0x53AF99BAA671CA47, vehicle, _r, _rf)
end

function GetVehicleModelMaxSpeed(modelHash)
	return _in(0xF417C2502FFFED43, _ch(modelHash), _r, _rf)
end

function NetworkGetPlayerIndexFromPed(ped)
	return _in(0x6C0E2E0125610278, ped, _r, _ri)
end

function ExpandWorldLimits(x, y, z)
	return _in(0x5006D96C995A5827, x, y, z)
end

function NetworkIsCableConnected()
	return _in(0xEFFB25453D8600F9, _r)
end

function SetEntityMaxSpeed(entity, speed)
	return _in(0x0E46A3FCBDE2A1B1, entity, speed)
end

function GetVehicleHoverModePercentage(veh)
    return _in(0xDA62027C8BDB326E, veh, _r, _rf)
end

function GetLandingGearState(veh)
    return _in(0x9B0F3DCA3DB0F4CD, veh, _r, _ri)
end

function DeleteVehicle(vehicle)
	return _in(0xEA386986E786A54F, _ii(vehicle) --[[ may be optional ]])
end

function DeletePed(ped)
	return _in(0x9614299DCB53E54B, _ii(ped) --[[ may be optional ]])
end

--function SetNetworkIdSyncToPlayer(netId, player, toggle)
--	return _in(0xA8A024587329F36A, netId, player, toggle)
--end

-- function GetAmmoInClip(ped,weapon)
    -- return 1
-- end

-- function GetAmmoInPedWeapon(ped,weapon)
    -- return 1
-- end

-- function GetWeaponClipSize(weapon)
    -- return 2
-- end

-- function GetMaxAmmoInClip(ped,weapon,unk)
    -- return 2
-- end


DecorRegister("NoLongerNeeded",2)
Citizen.CreateThread(function()
    local function loop(ent,mypos,positions,delfunc)
        local vehpos=GetEntityCoords(ent)
        local dx,dy=vehpos.x-mypos.x,vehpos.y-mypos.y
        local dist_to_me=dx*dx+dy*dy
        if dist_to_me<90000 then return end --300m
        for i,playerpos in pairs(positions) do
            dx,dy=vehpos.x-playerpos.x,vehpos.y-playerpos.y
            local dist_to_player=dx*dx+dy*dy
            if dist_to_player<dist_to_me then
                return
            end
        end
        SetEntityAsMissionEntity(ent,true,true)
        delfunc(ent)
    end
    while false do
        Wait(500)
        local positions={}
        local myped=PlayerPedId()
        local mypos=GetEntityCoords(myped)
        for i=0,31 do
            if NetworkIsPlayerActive(i) then
                local ped=GetPlayerPed(i)
                if ped~=myped then
                    positions[i]=GetEntityCoords(ped)
                end
            end
        end
        for veh in EnumerateVehicles() do
            if not IsVehicleDriveable(veh) and GetVehicleEngineHealth(veh)<0
            or DecorExistOn(veh,"NoLongerNeeded") and GetPedInVehicleSeat(veh,-1)==0 then
                loop(veh,mypos,positions,DeleteVehicle)
            end
        end
        for ped in EnumeratePeds() do
            if DecorExistOn(ped,"NoLongerNeeded") then
                loop(ped,mypos,positions,DeletePed)
            end
        end
    end
end)

function SetEntityAsNoLongerNeeded(ent)
    --print("no longer needed")
    if DoesEntityExist(ent) then
        DecorSetBool(ent,"NoLongerNeeded",true)
        _in(0xB736A491E64A32CF,_ii(ent))
    end
end
function SetVehicleAsNoLongerNeeded(ent)
    --print("no longer needed")
    if DoesEntityExist(ent) and IsEntityAVehicle(ent) then
        DecorSetBool(ent,"NoLongerNeeded",true)
        _in(0x629BFA74418D6239,_ii(ent))
    end
end
function SetPedAsNoLongerNeeded(ent)
    --print("no longer needed")
    if DoesEntityExist(ent) and IsEntityAPed(ent) then
        DecorSetBool(ent,"NoLongerNeeded",true)
        _in(0x2595DD4236549CE3,_ii(ent))
    end
end

--SetObjectAsNoLongerNeeded=NoLongerNeeded

NetworkGetScriptStatus() --needed for ..AsNoLongerNeeded to work