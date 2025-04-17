Framework = {}

if GetResourceState('es_extended') == 'started' then
    Framework.Type = 'ESX'
    Framework.Core = exports['es_extended']:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    Framework.Type = 'QB'
    Framework.Core = exports['qb-core']:GetCoreObject()
end

Framework.GetPlayer = function(source)
    if Framework.Type == 'ESX' then
        return Framework.Core.GetPlayerFromId(source)
    elseif Framework.Type == 'QB' then
        return Framework.Core.Functions.GetPlayer(source)
    end
end

Framework.GetGroup = function(player)
    if Framework.Type == 'ESX' then
        return player.getGroup()
    elseif Framework.Type == 'QB' then
        return player.PlayerData.permission
    end
end
