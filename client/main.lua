if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end

local PlayerData = {}
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('panicbutton:sendCoords')
AddEventHandler('panicbutton:sendCoords', function()

    local playerCoords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('panicButton:syncPosition', playerCoords)
end)

RegisterNetEvent('panicbutton:alarm')
AddEventHandler('panicbutton:alarm', function(playername, pos)

    if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name == Config.JobAlarm then

        -- Blip
        local blip = AddBlipForCoord(pos.x, pos.y, pos.z)
        SetBlipSprite(blip, Config.BlipSprite)
        SetBlipDisplay(blip, Config.BlipDisplay)
        SetBlipScale(blip, Config.BlipScale)
        SetBlipColour(blip, Config.BlipColour)
        SetBlipAsShortRange(blip, false)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(playername)
        EndTextCommandSetBlipName(blip)

        -- Nachricht
        ShowNotification('~b~' .. playername .. ' ~r~benötigt Hilfe! Blip wurde gesetzt.')

        Citizen.Wait(Config.BlipTime)
        RemoveBlip(blip)

    end
end)


function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end