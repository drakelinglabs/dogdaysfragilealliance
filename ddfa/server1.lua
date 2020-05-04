
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local coordinatearray={
    [1]={x=-119.616,y=-1576.976,z=34.1848,sprite=351,name="Steal drugs",wanted=2,money=2500,singletake=100,enemies=3},
    [2]={x=-334.763,y=-1317.364,z=31.4004,sprite=351,name="Steal drugs",wanted=2,money=9000,singletake=100,enemies=5},
    [3]={x=271.251,y=-1737.183,z=35.2965,sprite=351,name="Steal diamonds",wanted=4,money=25000,singletake=100,enemies=1},
    [4]={x=-129.715,y=-1421.568,z=31.3002,sprite=351,name="Steal documents",wanted=3,money=15000,singletake=100,enemies=7}
};

local money_drops={};

local player_money={};

local current_heist=0;
--for i = 1, 10 do
--   MsgBox ("i равно "..i)
--end

AddEventHandler('playerConnecting', function(playerName, setKickReason)
    --RconLog({ msgType = 'customConnect', ip = GetPlayerEP(source), name = playerName })
    player_money[source]=0
end)

AddEventHandler('playerDropped', function()
    --RconLog({ msgType = 'playerDropped', netID = source, name = GetPlayerName(source) })
    player_money[source]=nil
end)

AddEventHandler('chatMessage', function(player, playerName, message)
    if message:sub(1, 6) == '/heist' then
        if money_drops[-1]==nil then
            current_heist=math.random(1,4)
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
            TriggerClientEvent(event.startheist, -1, -1, money_drops[-1])
            TriggerClientEvent(event.spawnpeds,player,money_drops[-1].x,money_drops[-1].y,money_drops[-1].z,4)
        else
            for key, val in pairs(money_drops) do
                TriggerClientEvent(event.startheist, player, key, val)
            end
        end
    elseif message:sub(1, 6) == '/money' then
        TriggerClientEvent("chatMessage", player, "Fragile Alliance:", {33,33,0}, player_money[player])
    end
end)

RegisterServerEvent("fragile-alliance:take_money")
AddEventHandler("fragile-alliance:take_money", function(id)
    if money_drops[id]~=nil then
        if player_money[source]~=nil then
            player_money[source]=player_money[source]+money_drops[id].singletake;
        else
            player_money[source]=money_drops[id].singletake;
        end
        money_drops[id].money=money_drops[id].money-money_drops[id].singletake;
        if money_drops[id].money<=0 then
            money_drops[id]=nil
        end
        TriggerClientEvent(event.money, source, player_money[source])
    end
    if money_drops[id]==nil then
        TriggerClientEvent(event.stopheist, -1, id);
    end
end)

function drop_money(player,pos,sprite,name)
  --TriggerClientEvent("chatMessage", -1, "Death", {128,128,0}, name)
  if (player_money[player]~=nil) and (player_money[player]>0) then
    TriggerClientEvent("chatMessage", -1, "Fragile Alliance:", {128,128,0}, "You dropped loot")
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
    money_drops[index].singletake=math.floor(money_drops[index].money/10)
    money_drops[index].wanted=0
    money_drops[index].r=.5
    --coordinatearray[current_heist].singletake;
    TriggerClientEvent(event.startheist, -1, index, money_drops[index]);
  else
    TriggerClientEvent("chatMessage", -1, "Fragile Alliance:", {128,128,0}, "Type /heist to start mission.")
    TriggerClientEvent("chatMessage", -1, "Fragile Alliance:", {128,128,0}, "Press Z to check your money.")
  end
end

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