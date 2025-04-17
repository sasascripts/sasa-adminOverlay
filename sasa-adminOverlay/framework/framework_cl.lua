Framework = {}

CreateThread(function()
    if GetResourceState('es_extended') == 'started' then
        Framework.Type = 'ESX'
        Framework.Core = exports['es_extended']:getSharedObject()
    elseif GetResourceState('qb-core') == 'started' then
        Framework.Type = 'QB'
        Framework.Core = exports['qb-core']:GetCoreObject()
    end
    
    while Framework.Type == nil do
        Wait(100)
    end
end)

Framework.ShowNotification = function(message)
    if Framework.Type == 'ESX' then
        Framework.Core.ShowNotification(message)
    elseif Framework.Type == 'QB' then
        Framework.Core.Functions.Notify(message)
    end
end
