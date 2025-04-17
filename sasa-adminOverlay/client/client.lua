local isOverlayActive = false
local fps = 0

local ESX = exports["es_extended"]:getSharedObject()
local QBCore = nil

if GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
end

local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- Better clipboard function
local function CopyToClipboard(text)
    SendNUIMessage({
        type = "copy",
        text = text
    })
end

-- Better FPS Counter
local smoothFPS = 0
local fpsUpdateInterval = 100 -- ms

Citizen.CreateThread(function()
    local lastTime = GetGameTimer()
    local frameCount = 0
    
    while true do
        Citizen.Wait(0)
        frameCount = frameCount + 1
        local currentTime = GetGameTimer()
        local timeDiff = currentTime - lastTime

        if timeDiff >= fpsUpdateInterval then
            local currentFPS = (frameCount * 1000) / timeDiff
            smoothFPS = smoothFPS * 0.95 + currentFPS * 0.05 -- Smooth transition
            frameCount = 0
            lastTime = currentTime
        end
    end
end)

local function GetFPSColor(fps)
    if fps >= 60 then
        return Config.Colors.success
    elseif fps >= 30 then
        return Config.Colors.warning
    else
        return Config.Colors.error
    end
end

local function DrawColoredText(text, pos, color)
    SetTextScale(Config.TextStyles.scale, Config.TextStyles.scale)
    SetTextFont(Config.TextStyles.font)
    SetTextProportional(1)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(pos.x, pos.y)
end

-- Cached variables for performance
local playerCache = {}
local lastUpdate = 0

local function ShowNotification(message, type)
    type = type or 'info'
    if Config.Notifications.type == 'native' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(message)
        DrawNotification(false, false)
    elseif Config.Notifications.type == 'esx' and ESX then
        ESX.ShowNotification(message)
    elseif Config.Notifications.type == 'qb' and QBCore then
        QBCore.Functions.Notify(message, type)
    elseif Config.Notifications.type == 'mythic' then
        exports['mythic_notify']:DoHudText(type, message)
    elseif Config.Notifications.type == 'ox' then
        lib.notify({
            title = 'Admin Overlay',
            description = message,
            type = type
        })
    end
end

-- Optimized player info update
local function UpdatePlayerCache()
    local players = GetActivePlayers()
    local newCache = {}
    local myPos = GetEntityCoords(PlayerPedId())
    
    for _, player in ipairs(players) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            local pos = GetEntityCoords(ped)
            local distance = #(myPos - pos)
            
            if distance < Config.Performance.maxDrawDistance then
                newCache[player] = {
                    ped = ped,
                    pos = pos,
                    id = GetPlayerServerId(player),
                    name = GetPlayerName(player),
                    heading = GetEntityHeading(ped),
                    vehicle = IsPedInAnyVehicle(ped, false) and GetVehiclePedIsIn(ped, false) or nil
                }
            end
        end
    end
    
    playerCache = newCache
end

-- Main render thread with optimization
Citizen.CreateThread(function()
    while true do
        if isOverlayActive then
            local currentTime = GetGameTimer()
            
            -- Update player cache at interval
            if currentTime - lastUpdate > Config.Performance.playerUpdateInterval then
                UpdatePlayerCache()
                lastUpdate = currentTime
            end
            
            -- Draw FPS
            if Config.ShowElements.fps then
                local currentFPS = math.floor(smoothFPS)
                local fpsColor = GetFPSColor(currentFPS)
                DrawColoredText(("FPS: %d"):format(currentFPS), Config.Positions.fps, fpsColor)
            end
            
            -- Draw copy instructions (fixed positioning)
            DrawColoredText("~w~[~y~F3~w~] Copy Vec3", Config.Positions.copyInstructions.vec3, Config.Colors.default)
            DrawColoredText("~w~[~y~F4~w~] Copy Vec4", Config.Positions.copyInstructions.vec4, Config.Colors.default)
            DrawColoredText("~w~[~y~F6~w~] Copy Heading", Config.Positions.copyInstructions.heading, Config.Colors.default)
            
            -- Draw player info from cache
            for _, data in pairs(playerCache) do
                local infoText = ("~w~ID: ~y~%s~w~~n~Name: ~y~%s~w~~n~Pos: ~y~%.2f, %.2f, %.2f~w~~n~Heading: ~y~%.2f"):format(
                    data.id, data.name, data.pos.x, data.pos.y, data.pos.z, data.heading)
                
                DrawText3D(data.pos.x, data.pos.y, data.pos.z + Config.Positions.playerInfo.nameOffset, infoText)
                
                if data.vehicle then
                    local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(data.vehicle))
                    local engineHealth = math.floor((GetVehicleEngineHealth(data.vehicle) / 1000) * 100)
                    local bodyHealth = math.floor((GetVehicleBodyHealth(data.vehicle) / 1000) * 100)
                    
                    local vehicleInfo = ("~w~Vehicle: ~y~%s~w~~n~Engine: ~%s~%d%%~w~~n~Body: ~%s~%d%%"):format(
                        vehicleModel,
                        engineHealth > 50 and "g" or "r", engineHealth,
                        bodyHealth > 50 and "g" or "r", bodyHealth
                    )
                    
                    DrawText3D(data.pos.x, data.pos.y, data.pos.z + Config.Positions.playerInfo.vehicleOffset, vehicleInfo)
                end
            end
            
            Citizen.Wait(0)
        else
            Citizen.Wait(500)
        end
    end
end)

-- Command handlers for copying
RegisterCommand('copyvec3', function()
    if isOverlayActive then
        local coords = GetEntityCoords(PlayerPedId())
        local text = ("vector3(%.2f, %.2f, %.2f)"):format(coords.x, coords.y, coords.z)
        CopyToClipboard(text)
        ShowNotification('Vec3 coordinates copied!', 'success')
    end
end)

RegisterCommand('copyvec4', function()
    if isOverlayActive then
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local text = ("vector4(%.2f, %.2f, %.2f, %.2f)"):format(coords.x, coords.y, coords.z, heading)
        CopyToClipboard(text)
        ShowNotification('Vec4 coordinates copied!', 'success')
    end
end)

RegisterCommand('copyheading', function()
    if isOverlayActive then
        local heading = GetEntityHeading(PlayerPedId())
        local text = ("%.2f"):format(heading)
        CopyToClipboard(text)
        ShowNotification('Heading copied!', 'success')
    end
end)

-- Command handler
RegisterCommand(Config.Command, function()
    if ESX then
        ESX.TriggerServerCallback('sasa-adminOverlay:checkAdmin', function(isAdmin)
            HandleAdminCheck(isAdmin)
        end)
    elseif QBCore then
        QBCore.Functions.TriggerCallback('sasa-adminOverlay:checkAdmin', function(isAdmin)
            HandleAdminCheck(isAdmin)
        end)
    end
end)

function HandleAdminCheck(isAdmin)
    if isAdmin then
        isOverlayActive = not isOverlayActive
        ShowNotification(isOverlayActive and 'Overlay Enabled' or 'Overlay Disabled', 'info')
    end
end

RegisterKeyMapping(Config.Command, 'Toggle Admin Overlay', 'keyboard', Config.DefaultKey)

-- Event handler
RegisterNetEvent('sasa-adminOverlay:toggle')
AddEventHandler('sasa-adminOverlay:toggle', function()
    if ESX then
        ESX.TriggerServerCallback('sasa-adminOverlay:checkAdmin', function(isAdmin)
            HandleAdminCheck(isAdmin)
        end)
    elseif QBCore then
        QBCore.Functions.TriggerCallback('sasa-adminOverlay:checkAdmin', function(isAdmin)
            HandleAdminCheck(isAdmin)
        end)
    end
end)
