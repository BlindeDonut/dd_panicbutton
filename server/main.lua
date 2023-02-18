if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end

ESX.RegisterUsableItem('panicbutton', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == Config.JobUsable then
        TriggerClientEvent('panicbutton:sendCoords', source)
    end
end)

RegisterServerEvent('panicButton:syncPosition')
AddEventHandler('panicButton:syncPosition', function(position)

    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('panicbutton:alarm', -1, xPlayer.getName(), position)
    
end)