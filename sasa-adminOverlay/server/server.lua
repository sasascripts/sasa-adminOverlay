local ESX = exports["es_extended"]:getSharedObject()
local QBCore = nil

if GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
end

local function IsPlayerAdmin(source)
    local player
    if ESX then
        player = ESX.GetPlayerFromId(source)
        if player then
            local group = player.getGroup()
            for _, adminGroup in ipairs(Config.AdminGroups) do
                if group == adminGroup then
                    return true
                end
            end
        end
    elseif QBCore then
        player = QBCore.Functions.GetPlayer(source)
        if player then
            local permission = player.PlayerData.permission
            for _, adminGroup in ipairs(Config.AdminGroups) do
                if permission == adminGroup then
                    return true
                end
            end
        end
    end
    return false
end

-- ESX Server Callback
if ESX then
    ESX.RegisterServerCallback('sasa-adminOverlay:checkAdmin', function(source, cb)
        cb(IsPlayerAdmin(source))
    end)
end

-- QB Server Callback
if QBCore then
    QBCore.Functions.CreateCallback('sasa-adminOverlay:checkAdmin', function(source, cb)
        cb(IsPlayerAdmin(source))
    end)
end
