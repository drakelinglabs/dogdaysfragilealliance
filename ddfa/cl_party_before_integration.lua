local party={}

party.colorname={
red=1,
green=2,
blue=3,
white=4,
yellow=5,
orange=47,
purple=50,
pink=48,
grey=39,
}
party.blipcolors={
[1]={255,59,59}, --red
[2]={121,206,121}, --green
[3]={101,185,231}, --blue
[4]={241,241,241}, --white
[5]={240,203,88}, --yellow
[47]={255,154,24}, --orange
[50]={138,109,227}, --purple
[48]={247,69,165}, --pink
[39]={159,159,159}, --grey
[72]={0,0,0}, --black
[85]={0,0,0}, --black
}
party.myparty
party.mycolor=4
party.showself=false
party.showselfface=true
party.showmarkers=true
party.showmymarker=true
party.showtraitorface=false
party.headshots={}
party.peds={}
party.markers={}
party.traitor

local function GetSeatPedIsUsing(ped)
    local veh=GetVehiclePedIsIn(ped)
    local maxseat=GetVehicleMaxNumberOfPassengers(veh)-1
    for i=-1,maxseat do
        if GetPedInVehicleSeat(veh,i)==ped then
            return i
        end
    end
    return 0
end

party.mask=0xFFFFF
party.no_change_flag=0x100000
party.only_cops_flag=0x80000
party.no_cops_flag=0x40000
party.true_mask=(party.mask|party.no_change_flag)
party.shuffle=function(p)
    return p~(math.random(0,0x7FF)*0x200000)
end
party.SetPlayerParty=function(ped,p)
    DecorSetInt(ped,"partynumber",shuffle(p))
end
party.GetPlayerParty=function(ped)
    return (DecorGetInt(ped,"partynumber")&party.true_mask)
end
party.SetTraitorParty=function(ped,p)
    DecorSetInt(ped,"partytraitor",shuffle(p))
end
party.GetTraitorParty=function(ped)
    return (DecorGetInt(ped,"partytraitor")&party.true_mask)
end
party.IsPedOkForThisParty(ped,p)
    if (p&(party.no_cops_flag|party.only_cops_flag))~=0 then
        if GetEntityHealth(ped)<100 then
            return false
        end
        if (p&party.no_cops_flag)~=0 and IsPedCop(ped) then
            return false
        end
        if (p&party.only_cops_flag)~=0 and not IsPedCop(ped) then
            return false
        end
    end
    return true
end

Citizen.CreateThread(function()
    --DecorRegister("partynumber",3) --moved to another file
    --DecorRegister("partycolor",3)
    --DecorRegister("party_x",3)
    --DecorRegister("party_y",3)
    --DecorRegister("party_z",3)
    DecorRegister("partytraitor",3)
    local oldped=PlayerPedId()
    while true do
        Wait(0)
        local face_x=.950
        local face_y=.925
        local myid=PlayerId()
        local myped=PlayerPedId()
        if oldped~=myped then
            oldped=myped
            if party.myparty~=nil then SetPlayerParty(myped,party.myparty) end
            DecorSetInt(myped,"partycolor",party.mycolor)
        elseif GetEntityHealth(myped)>0 and DecorExistOn(myped,"partynumber") then
            party.myparty=GetPlayerParty(myped)
        end
        if party.myparty~=nil and party.showmymarker then
            local my_waypoint=GetFirstBlipInfoId(8)
            if my_waypoint==0 then
                DecorRemove(myped,"party_x")
                DecorRemove(myped,"party_y")
                DecorRemove(myped,"party_z")
            else
                local coords=GetBlipCoords(my_waypoint)
                DecorSetInt(myped,"party_x",math.floor(coords.x+.5))
                DecorSetInt(myped,"party_y",math.floor(coords.y+.5))
                DecorSetInt(myped,"party_z",math.floor(coords.z+.5))
            end
        else
            DecorRemove(myped,"party_x")
            DecorRemove(myped,"party_y")
            DecorRemove(myped,"party_z")
        end
        if party.myparty~=nil and (party.myparty&party.no_change_flag)~=0 then
            for playerid=0,31 do
                local playerped=GetPlayerPed(playerid)
                local blipcolor=4
                local blip=GetBlipFromEntity(playerped)
                local headshot=party.headshots[playerid]
                local marker=party.markers[playerid]
                if DecorExistOn(playerped,"partytraitor") and GetTraitorParty(playerped)==party.myparty then
                    if party.peds[playerid]==nil then
                        party.peds[playerid]=playerped
                    elseif party.peds[playerid]~=playerped then
                        party.peds[playerid]=playerped
                        if headshot~=nil then
                            UnregisterPedheadshot(headshot)
                            party.headshots[playerid]=nil
                        end
                    end
                    blipcolor=1 --(((GetGameTimer()&512)~=0) and 1 or 40)
                    if headshot==nil then
                        headshot=RegisterPedheadshot(playerped)
                        party.headshots[playerid]=headshot
                    end
                    if blip==0 then
                        blip=AddBlipForEntity(playerped)
                    end
                    SetBlipSprite(blip,119)
                    SetBlipScale(blip,1.0)
                    SetBlipColour(blip,blipcolor)
                    if party.showmarkers and DecorExistOn(playerped,"party_x") and DecorExistOn(playerped,"party_y") and DecorExistOn(playerped,"party_z") then
                        if marker==nil then
                            local x=DecorGetInt(playerped,"party_x")+.001
                            local y=DecorGetInt(playerped,"party_y")+.001
                            local z=DecorGetInt(playerped,"party_z")+.001
                            marker=AddBlipForCoord(x,y,z)
                            SetBlipSprite(marker, 162)
                            SetBlipDisplay(marker, 2)
                            SetBlipScale(marker, 1.0)
                            party.markers[playerid]=marker
                        end
                        SetBlipColour(marker,blipcolor)
                    elseif marker~=nil then
                        RemoveBlip(marker)
                        party.markers[playerid]=nil
                    end
                    
                    local playerhp=GetEntityHealth(playerped)-100
                    local playermaxhp=GetEntityMaxHealth(playerped)-100
                    local playerarmor=GetPedArmour(playerped)
                    local wanted=GetPlayerWantedLevel(playerid)
                    if party.showtraitorface and (party.showselfface or playerid~=myid) and IsPedheadshotReady(headshot) and IsPedheadshotValid(headshot) then
                        DrawRect(face_x,face_y,0.044,0.066,0,0,0,255) --frame
                        local headshot_string=GetPedheadshotTxdString(headshot)
                        if playerhp>0 then
                            DrawSprite(headshot_string,headshot_string,face_x,face_y,0.04,0.06,0.0,255,255,255,255)
                            if (playerhp-1)*2>playermaxhp then
                                DrawRect(face_x,face_y-0.022,playerhp*0.0003,0.004,0,200,0,255)
                                SetTextColour(0,200,0,255)
                            else
                                DrawRect(face_x,face_y-0.022,playerhp*0.0003,0.004,200,0,0,255)
                                SetTextColour(200,0,0,255)
                            end
                            SetTextCentre(true)
                            SetTextOutline()
                            SetTextFont(4)
                            SetTextScale(.35, .35)
                            SetTextEntry("STRING")
                            AddTextComponentString(playerhp)
                            EndTextCommandDisplayText(face_x,face_y+0.023)
                            DrawRect(face_x,face_y-0.020,playerarmor*0.0003,0.004,0,150,255,255)
                        else
                            DrawSprite(headshot_string,headshot_string,face_x,face_y,0.04,0.06,0.0,255,0,0,255)
                        end
                        local dict="crosstheline"--"mpinventory"
                        local cross="timer_largecross_32"--"survival"
                        if not HasStreamedTextureDictLoaded(dict) then
                           RequestStreamedTextureDict(dict,false)
                        else
                           DrawSprite(dict,cross,face_x,face_y,0.04,0.06,0.0,255,0,0,255)
                        end
                        if wanted>0 then
                          local dict="commonmenu"
                          if not HasStreamedTextureDictLoaded(dict) then
                           RequestStreamedTextureDict(dict,false)
                          else
                           local star="shop_new_star"
                           local y=face_y+0.023
                           DrawSprite(dict,star,face_x-0.016,y,0.016,0.024,0.0,255,255,255,255)
                           if wanted>1 then
                            DrawSprite(dict,star,face_x-0.008,y,0.016,0.024,0.0,255,255,255,255)
                            if wanted>2 then
                             DrawSprite(dict,star,face_x,y,0.016,0.024,0.0,255,255,255,255)
                             if wanted>3 then
                              DrawSprite(dict,star,face_x+0.008,y,0.016,0.024,0.0,255,255,255,255)
                              if wanted>4 then
                               DrawSprite(dict,star,face_x+0.016,y,0.016,0.024,0.0,255,255,255,255)
                              end
                             end
                            end
                           end
                          end
                        end
                        if face_x>.801 then
                            face_x=face_x-.05
                        else
                            face_x=.950
                            face_y=face_y-.075
                        end
                    end
                elseif DecorExistOn(playerped,"partynumber") and GetPlayerParty(playerped)==party.myparty then
                    if party.peds[playerid]==nil then
                        party.peds[playerid]=playerped
                    elseif party.peds[playerid]~=playerped then
                        party.peds[playerid]=playerped
                        if headshot~=nil then
                            UnregisterPedheadshot(headshot)
                            party.headshots[playerid]=nil
                        end
                    end
                    if DecorExistOn(playerped,"partycolor") then
                        blipcolor=DecorGetInt(playerped,"partycolor")
                    end
                    if headshot==nil then
                        headshot=RegisterPedheadshot(playerped)
                        party.headshots[playerid]=headshot
                    end
                    if blip==0 then
                        blip=AddBlipForEntity(playerped)
                        SetBlipScale(blip,0.6)
                    end
                    SetBlipColour(blip,blipcolor)
                    if party.showmarkers and DecorExistOn(playerped,"party_x") and DecorExistOn(playerped,"party_y") and DecorExistOn(playerped,"party_z") then
                        if marker==nil then
                            local x=DecorGetInt(playerped,"party_x")+.001
                            local y=DecorGetInt(playerped,"party_y")+.001
                            local z=DecorGetInt(playerped,"party_z")+.001
                            marker=AddBlipForCoord(x,y,z)
                            SetBlipSprite(marker, 162)
                            SetBlipDisplay(marker, 2)
                            SetBlipScale(marker, 1.0)
                            party.markers[playerid]=marker
                        end
                        SetBlipColour(marker,blipcolor)
                    elseif marker~=nil then
                        RemoveBlip(marker)
                        party.markers[playerid]=nil
                    end
                    
                    local playerhp=GetEntityHealth(playerped)-100
                    local playermaxhp=GetEntityMaxHealth(playerped)-100
                    local playerarmor=GetPedArmour(playerped)
                    local wanted=GetPlayerWantedLevel(playerid)
                    local rgb=party.blipcolors[blipcolor]
                    if playerhp<0 and playerped~=myped and party.traitor==nil then
                        local killer=GetPedKiller(playerped)
                        print("killer="..killer)
                        if killer~=0 then
                            if killer==myped or killer==GetVehiclePedIsUsing(myped) then
                                party.traitor=party.myparty
                                SetTraitorParty(myped,party.traitor)
                                DecorRemove(myped,"partynumber")
                                party.myparty=nil
                            end
                        end
                    end
                    -- if (party.showself or playerid~=myid) then
                        -- local pos = GetEntityCoords(playerped)
                        -- local not_on_screen,x,y=N_0xf9904d11f1acbec3(pos.x,pos.y,pos.z+0.35)
                        -- if not not_on_screen then
                            -- if IsPedSittingInAnyVehicle(playerped) then
                                -- y=y+GetSeatPedIsUsing(playerped)*0.025
                            -- end
                            -- SetTextCentre(true)
                            -- SetTextOutline()
                            -- SetTextFont(4)
                            -- SetTextScale(.3, .3)
                            -- if playerhp>0 then
                                -- SetTextColour(rgb[1],rgb[2],rgb[3],255)
                            -- else
                                -- SetTextColour(255,0,0,255)
                            -- end
                            -- SetTextEntry("STRING")
                            --if wanted==0 then
                            -- AddTextComponentString(playerhp.."HP")
                            --else
                            -- AddTextComponentString(playerhp.."HP "..wanted.."STARS")
                            --end
                            -- EndTextCommandDisplayText(x,y)
                            -- if playerhp>0 then
                                -- if playerarmor~=0 then
                                    -- DrawRect(x+(playerarmor-100)*0.000125,y+0.025,playerarmor*0.00025,0.003,0,150,255,150)
                                    -- y=y+0.03
                                -- else
                                    -- y=y+0.025
                                -- end
                                -- DrawRect(x,y,0.025,0.005,0,0,0,255)
                                -- if (playerhp-1)*2>playermaxhp then
                                    -- DrawRect(x+(playerhp-100)*0.000125,y,playerhp*0.00025,0.003,100,255,100,150)
                                -- else
                                    -- DrawRect(x+(playerhp-100)*0.000125,y,playerhp*0.00025,0.003,255,0,0,150)
                                -- end
                            -- end
                        -- end
                    -- end
                    if (party.showselfface or playerid~=myid) and IsPedheadshotReady(headshot) and IsPedheadshotValid(headshot) then
                        if rgb~=nil then DrawRect(face_x,face_y,0.044,0.066,rgb[1],rgb[2],rgb[3],255) end --frame
                        local headshot_string=GetPedheadshotTxdString(headshot)
                        if playerhp>0 then
                            DrawSprite(headshot_string,headshot_string,face_x,face_y,0.04,0.06,0.0,255,255,255,255)
                            if (playerhp-1)*2>playermaxhp then
                                DrawRect(face_x,face_y-0.022,playerhp*0.0003,0.004,0,200,0,255)
                                SetTextColour(0,200,0,255)
                            else
                                DrawRect(face_x,face_y-0.022,playerhp*0.0003,0.004,200,0,0,255)
                                SetTextColour(200,0,0,255)
                            end
                            SetTextCentre(true)
                            SetTextOutline()
                            SetTextFont(4)
                            SetTextScale(.35, .35)
                            SetTextEntry("STRING")
                            AddTextComponentString(playerhp)
                            EndTextCommandDisplayText(face_x,face_y+0.023)
                            DrawRect(face_x,face_y-0.020,playerarmor*0.0003,0.004,0,150,255,255)
                        else
                            DrawSprite(headshot_string,headshot_string,face_x,face_y,0.04,0.06,0.0,255,0,0,255)
                        end
                        if wanted>0 then
                          local dict="commonmenu"
                          if not HasStreamedTextureDictLoaded(dict) then
                           RequestStreamedTextureDict(dict,false)
                          else
                           local star="shop_new_star"
                           local y=face_y+0.023
                           DrawSprite(dict,star,face_x-0.016,y,0.016,0.024,0.0,255,255,255,255)
                           if wanted>1 then
                            DrawSprite(dict,star,face_x-0.008,y,0.016,0.024,0.0,255,255,255,255)
                            if wanted>2 then
                             DrawSprite(dict,star,face_x,y,0.016,0.024,0.0,255,255,255,255)
                             if wanted>3 then
                              DrawSprite(dict,star,face_x+0.008,y,0.016,0.024,0.0,255,255,255,255)
                              if wanted>4 then
                               DrawSprite(dict,star,face_x+0.016,y,0.016,0.024,0.0,255,255,255,255)
                              end
                             end
                            end
                           end
                          end
                        end
                        if face_x>.801 then
                            face_x=face_x-.05
                        else
                            face_x=.950
                            face_y=face_y-.075
                        end
                    end
                else
                    if headshot~=nil then
                        UnregisterPedheadshot(headshot)
                        party.headshots[playerid]=nil
                    end
                    if blip~=0 then
                        RemoveBlip(blip)
                    end
                    if marker~=nil then
                        RemoveBlip(marker)
                        party.markers[playerid]=nil
                    end
                end
            end
        else
            for playerid=0,31 do
                local playerped=GetPlayerPed(playerid)
                local blipcolor=4
                local blip=GetBlipFromEntity(playerped)
                local headshot=party.headshots[playerid]
                local marker=party.markers[playerid]
                if DecorExistOn(playerped,"partynumber") and GetPlayerParty(playerped)==party.myparty then
                    if party.peds[playerid]==nil then
                        party.peds[playerid]=playerped
                    elseif party.peds[playerid]~=playerped then
                        party.peds[playerid]=playerped
                        if headshot~=nil then
                            UnregisterPedheadshot(headshot)
                            party.headshots[playerid]=nil
                        end
                    end
                    if DecorExistOn(playerped,"partycolor") then
                        blipcolor=DecorGetInt(playerped,"partycolor")
                    end
                    if headshot==nil then
                        headshot=RegisterPedheadshot(playerped)
                        party.headshots[playerid]=headshot
                    end
                    if blip==0 then
                        blip=AddBlipForEntity(playerped)
                        SetBlipScale(blip,0.75)
                    end
                    SetBlipColour(blip,blipcolor)
                    if party.showmarkers and DecorExistOn(playerped,"party_x") and DecorExistOn(playerped,"party_y") and DecorExistOn(playerped,"party_z") then
                        if marker==nil then
                            local x=DecorGetInt(playerped,"party_x")+.001
                            local y=DecorGetInt(playerped,"party_y")+.001
                            local z=DecorGetInt(playerped,"party_z")+.001
                            marker=AddBlipForCoord(x,y,z)
                            SetBlipSprite(marker, 162)
                            SetBlipDisplay(marker, 2)
                            SetBlipScale(marker, 1.0)
                            party.markers[playerid]=marker
                        end
                        SetBlipColour(marker,blipcolor)
                    elseif marker~=nil then
                        RemoveBlip(marker)
                        party.markers[playerid]=nil
                    end
                    
                    local playerhp=GetEntityHealth(playerped)-100
                    local playermaxhp=GetEntityMaxHealth(playerped)-100
                    local playerarmor=GetPedArmour(playerped)
                    local wanted=GetPlayerWantedLevel(playerid)
                    local rgb=party.blipcolors[blipcolor]
                    if (party.showself or playerid~=myid) then
                        local pos = GetEntityCoords(playerped)
                        local not_on_screen,x,y=N_0xf9904d11f1acbec3(pos.x,pos.y,pos.z+0.35)
                        if not not_on_screen then
                            if IsPedSittingInAnyVehicle(playerped) then
                                y=y+GetSeatPedIsUsing(playerped)*0.025
                                --print("inveh",IsPedInAnyVehicle(playerped),GetSeatPedIsUsing(playerped))
                            end
                            SetTextCentre(true)
                            SetTextOutline()
                            SetTextFont(4)
                            SetTextScale(.3, .3)
                            if playerhp>0 then
                                SetTextColour(rgb[1],rgb[2],rgb[3],255)
                            else
                                SetTextColour(255,0,0,255)
                            end
                            SetTextEntry("STRING")
                            AddTextComponentString(GetPlayerName(playerid))
                            EndTextCommandDisplayText(x,y)
                            if playerhp>0 then
                                if playerarmor~=0 then
                                    DrawRect(x+(playerarmor-100)*0.000125,y+0.025,playerarmor*0.00025,0.003,0,150,255,150)
                                    y=y+0.03
                                else
                                    y=y+0.025
                                end
                                DrawRect(x,y,0.025,0.005,0,0,0,255)
                                if (playerhp-1)*2>playermaxhp then
                                    DrawRect(x+(playerhp-100)*0.000125,y,playerhp*0.00025,0.003,100,255,100,150)
                                else
                                    DrawRect(x+(playerhp-100)*0.000125,y,playerhp*0.00025,0.003,255,0,0,150)
                                end
                            end
                        end
                    end
                    --DrawRect(0.925,0.925,0.1,0.08,0,0,0,200)--frame
                    --local headshot=RegisterPedheadshot(playerped) 
                    if (party.showselfface or playerid~=myid) and IsPedheadshotReady(headshot) and IsPedheadshotValid(headshot) then
                        if rgb~=nil then DrawRect(face_x,face_y,0.044,0.066,rgb[1],rgb[2],rgb[3],255) end --frame
                        local headshot_string=GetPedheadshotTxdString(headshot)
                        if playerhp>0 then
                            DrawSprite(headshot_string,headshot_string,face_x,face_y,0.04,0.06,0.0,255,255,255,255)
                            if (playerhp-1)*2>playermaxhp then
                                DrawRect(face_x,face_y-0.022,playerhp*0.0003,0.004,0,200,0,255)
                                SetTextColour(0,200,0,255)
                            else
                                DrawRect(face_x,face_y-0.022,playerhp*0.0003,0.004,200,0,0,255)
                                SetTextColour(200,0,0,255)
                            end
                            SetTextCentre(true)
                            SetTextOutline()
                            SetTextFont(4)
                            SetTextScale(.35, .35)
                            SetTextEntry("STRING")
                            AddTextComponentString(playerhp)
                            EndTextCommandDisplayText(face_x,face_y+0.023)
                            DrawRect(face_x,face_y-0.020,playerarmor*0.0003,0.004,0,150,255,255)
                        else
                            DrawSprite(headshot_string,headshot_string,face_x,face_y,0.04,0.06,0.0,255,0,0,255)
                        end
                        if wanted>0 then
    --local dict="commonmenutu" "amb@world_human_stand_mobile@male@text@exit"
    --local texturename="team_deathmatch" "exit_to_call"
                          local dict="commonmenu"
                          if not HasStreamedTextureDictLoaded(dict) then
                           RequestStreamedTextureDict(dict,false)
                          else
                           local star="shop_new_star"
                           local y=face_y+0.023
                           DrawSprite(dict,star,face_x-0.016,y,0.016,0.024,0.0,255,255,255,255)
                           if wanted>1 then
                            DrawSprite(dict,star,face_x-0.008,y,0.016,0.024,0.0,255,255,255,255)
                            if wanted>2 then
                             DrawSprite(dict,star,face_x,y,0.016,0.024,0.0,255,255,255,255)
                             if wanted>3 then
                              DrawSprite(dict,star,face_x+0.008,y,0.016,0.024,0.0,255,255,255,255)
                              if wanted>4 then
                               DrawSprite(dict,star,face_x+0.016,y,0.016,0.024,0.0,255,255,255,255)
                              end
                             end
                            end
                           end
                          end
                        end
                        if face_x>.801 then
                            face_x=face_x-.05
                        else
                            face_x=.950
                            face_y=face_y-.075
                        end
                        
                        -- DrawSprite(GetPedheadshotTxdString(headshot),GetPedheadshotTxdString(headshot),0.900,0.925,0.04,0.06,0.0,255,255,255,255)
                        -- DrawSprite(GetPedheadshotTxdString(headshot),GetPedheadshotTxdString(headshot),0.850,0.925,0.04,0.06,0.0,255,255,255,255)
                        -- DrawSprite(GetPedheadshotTxdString(headshot),GetPedheadshotTxdString(headshot),0.800,0.925,0.04,0.06,0.0,255,255,255,255)
                        
                        -- DrawSprite(GetPedheadshotTxdString(headshot),GetPedheadshotTxdString(headshot),0.950,0.850,0.04,0.06,0.0,255,255,255,255)
                        -- DrawSprite(GetPedheadshotTxdString(headshot),GetPedheadshotTxdString(headshot),0.900,0.850,0.04,0.06,0.0,255,255,255,255)
                        -- DrawSprite(GetPedheadshotTxdString(headshot),GetPedheadshotTxdString(headshot),0.850,0.850,0.04,0.06,0.0,255,255,255,255)
                        -- DrawSprite(GetPedheadshotTxdString(headshot),GetPedheadshotTxdString(headshot),0.800,0.850,0.04,0.06,0.0,255,255,255,255)
                        --DrawRect(0.900,0.925,0.04,0.06,0,0,0,255)--face
                    end
                else
                    if headshot~=nil then
                        UnregisterPedheadshot(headshot)
                        party.headshots[playerid]=nil
                    end
                    if blip~=0 then
                        RemoveBlip(blip)
                    end
                    if marker~=nil then
                        RemoveBlip(marker)
                        party.markers[playerid]=nil
                    end
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    for i=0,32 do
        UnregisterPedheadshot(i)
    end
    while true do
        Wait(360000)
        for k,v in pairs(party.headshots) do
            UnregisterPedheadshot(v)
        end
        party.headshots={}
    end
end)

party.cmd_partycolor=function(source,args,raw)
    if args[1]~=nil then
        if party.colorname[args[1]]~=nil then
            party.mycolor=party.colorname[args[1]]
            DecorSetInt(GetPlayerPed(-1),"partycolor",party.mycolor)
        elseif party.blipcolors[tonumber(args[1])]~=nil then
            party.mycolor=tonumber(args[1])
            DecorSetInt(GetPlayerPed(-1),"partycolor",party.mycolor)
        end
    end
end

local special_forces={
federals=(911|party.no_change_flag|party.only_cops_flag),
scpfoundation=(682|party.no_change_flag),
meninblack=(682|party.no_change_flag),
altahotel=(1|party.no_change_flag|party.no_cops_flag),
hostel=(2|party.no_change_flag|party.no_cops_flag),
}

local function GetPartyNumberFromText(text)
    local ret=special_forces[text]
    if ret~=nil then
        return ret
    else
        ret=tonumber(text)
        if ret~=nil then
            ret=(ret&party.mask)
        end
        return ret
    end
end

party.cmd_join_party=function(source,args,raw)
    local p=GetPartyNumberFromText(args[1])
    --if party==nil then print("nil") end
    if p==nil and args[2]~=nil then
        p=GetPartyNumberFromText(args[2])
    end
    if p~=nil and (party.myparty==nil or (party.myparty&party.no_change_flag)==0) then
        --party=party&party.mask --moved to GetPartyNumberFromText
        local ped = PlayerPedId()
        if ((p&party.no_change_flag)==0) or IsPedOkForThisParty(ped,p) and party.traitor==nil then
            party.myparty=p
            --TriggerEvent("chat:addMessage",{template="{0} {1}",args={"^3Your Party Number:",raw}})
            SetPlayerParty(ped,party.myparty)
            DecorSetInt(ped,"partycolor",party.mycolor)
        end
    end
end

local function text_to_bool(old,text)
    if text==nil then
        return not old
    elseif text=="y" or text=="1" then
        return true
    elseif text=="n" or text=="0" then
        return false
    end
    return old
end
party.cmd_partyshowself=function(source,args,raw)
    party.showself=text_to_bool(party.showself,args[1])
end
party.cmd_partyshowselfface=function(source,args,raw)
    party.showselfface=text_to_bool(party.showselfface,args[1])
end
party.cmd_partyshowmarkers=function(source,args,raw)
    party.showmarkers=text_to_bool(party.showmarkers,args[1])
end
party.cmd_partyshowmymarker=function(source,args,raw)
    party.showmymarker=text_to_bool(party.showmymarker,args[1])
end

RegisterCommand("partyc",party.cmd_partycolor,false)
RegisterCommand("partycolor",party.cmd_partycolor,false)
RegisterCommand("partyss",party.cmd_partyshowself,false)
RegisterCommand("partyshowself",party.cmd_partyshowself,false)
RegisterCommand("partyshowselfface",party.cmd_partyshowselfface,false)
RegisterCommand("partyshowface",party.cmd_partyshowselfface,false)
RegisterCommand("partyshowmarkers",party.cmd_partyshowmarkers,false)
RegisterCommand("partyshowmymarker",party.cmd_partyshowmymarker,false)
RegisterCommand("partysf",party.cmd_partyshowselfface,false)
RegisterCommand("partysm",party.cmd_partyshowmarkers,false)
RegisterCommand("partysmm",party.cmd_partyshowmymarker,false)
RegisterCommand("join",party.cmd_join_party,false)
RegisterCommand("create",party.cmd_join_party,false)
RegisterCommand("party",party.cmd_join_party,false)

RegisterCommand("leave",function(source,args,raw)
    if (party.myparty&party.no_change_flag)==0 then
        party.myparty=nil
        DecorRemove(PlayerPedId(),"partynumber")
    end
end,false)

Citizen.CreateThread(function()
    while true do
        if party.traitor~=nil then
            SetTraitorParty(PlayerPedId(),party.traitor)
        end
        Wait(0)
        if party.myparty~=nil then
            local ped=PlayerPedId()
            if (party.myparty&party.no_change_flag)~=0 then
                if GetEntityHealth(ped)<100 then
                    party.myparty=nil
                    --Wait(0)
                    --while ped==PlayerPedId() and GetEntityHealth(ped)<100 do
                    --    Wait(0)
                    --end
                elseif not IsPedOkForThisParty(ped,party.myparty) then
                    party.myparty=nil
                    DecorRemove(ped,"partynumber")
                    Wait(500)
                else
                    SetPlayerParty(ped,party.myparty)
                    Wait(3000)
                end
            else
                SetPlayerParty(ped,party.myparty)
                Wait(5000)
            end
        else
            Wait(1000)
        end
    end
end)