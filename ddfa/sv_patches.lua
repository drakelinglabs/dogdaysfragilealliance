
local HookGetGameTimer=GetGameTimer
local time_zero=HookGetGameTimer()
--print("time:"..time_zero.." (no one asked)")
function GetSyncTimer()
    return HookGetGameTimer()-time_zero
end
RegisterServerEvent(event.server_timestamp)
AddEventHandler(event.server_timestamp,function()
    TriggerClientEvent(event.server_timestamp,source,GetSyncTimer())
    --print("time:"..GetGameTimer()-time_zero)
end)

-- local HookGetPlayerName=GetPlayerName
-- function GetPlayerName(src)
    -- local name="errname"
    -- local success,err_name=pcall(HookGetPlayerName,src)
    -- if success then
        -- name=err_name
        -- if name==nil then name="nil" end
    -- end
    -- return name
-- end