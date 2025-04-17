Config = {}

Config.AdminGroups = {
    -- ESX Groups
    'admin',
    'superadmin',
    -- QB Groups
    'god',
    'admin'
}

Config.DefaultKey = 'F5' -- Key to toggle overlay
Config.Command = 'adminoverlay' -- Command to toggle overlay

Config.ToggleMethods = {
    command = true,     -- Enable command toggle
    event = true,       -- Enable event toggle
    keybind = true      -- Enable keybind toggle
}

Config.ShowElements = {
    playerIds = true,
    playerNames = true,
    vehicleInfo = true,
    coordinates = true,
    heading = true,
    fps = true          -- Show FPS counter
}

Config.Hotkeys = {
    copyVec3 = 'F3',    -- Copy vec3 coordinates
    copyVec4 = 'F4',    -- Copy vec4 coordinates (with heading)
    copyHeading = 'F6'  -- Copy only heading
}

Config.DisplayDistance = 100.0 -- Maximum distance to display information

Config.PresetPositions = {
    ['top-left'] = {x = 0.005, y = 0.005},
    ['top-right'] = {x = 0.985, y = 0.005},
    ['bottom-left'] = {x = 0.005, y = 0.96},
    ['bottom-right'] = {x = 0.985, y = 0.96},
    ['center-left'] = {x = 0.005, y = 0.5},
    ['center-right'] = {x = 0.985, y = 0.5},
    ['top-center'] = {x = 0.5, y = 0.005},
    ['bottom-center'] = {x = 0.5, y = 0.96}
}

Config.Positions = {
    fps = Config.PresetPositions['top-left'],
    copyInstructions = {
        vec3 = {x = 0.005, y = 0.90},
        vec4 = {x = 0.005, y = 0.93},
        heading = {x = 0.005, y = 0.96}
    },
    playerInfo = {
        nameOffset = 1.0,
        vehicleOffset = 1.5  -- Zvětšeno pro lepší čitelnost více informací
    }
}

Config.Colors = {
    default = {r = 255, g = 255, b = 255, a = 255},
    highlight = {r = 255, g = 255, b = 0, a = 255},
    warning = {r = 255, g = 150, b = 0, a = 255},
    error = {r = 255, g = 0, b = 0, a = 255},
    success = {r = 0, g = 255, b = 0, a = 255}
}

Config.TextStyles = {
    scale = 0.35,
    font = 4,
    color = Config.Colors.default
}

Config.Notifications = {
    type = 'native', -- 'native', 'esx', 'qb', 'mythic', 'ox'
    position = 'top-right',
    duration = 3000
}

Config.Performance = {
    updateInterval = 100, -- FPS update interval (ms)
    playerUpdateInterval = 500, -- How often to update player info (ms)
    maxDrawDistance = 100.0, -- Maximum distance to draw info
    smoothFPS = true -- Enable FPS smoothing
}
