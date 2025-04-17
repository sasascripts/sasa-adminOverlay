# SASA Admin Overlay

Advanced admin overlay system for FiveM with support for ESX and QB-Core frameworks.

## Features
- Real-time player information display
- FPS counter with color indicators
- Coordinate copying tools
- Vehicle information
- Multiple notification systems
- Framework agnostic (ESX/QB-Core)
- Performance optimized

## Dependencies
- ESX Legacy or QB-Core
- ox_lib (optional, for enhanced notifications)

## Installation
1. Place in resources folder
2. Add to server.cfg: `ensure sasa-adminOverlay`
3. Configure config.lua to your needs

## Configuration

### Admin Groups
```lua
Config.AdminGroups = {
    'admin',
    'superadmin'
}
```

### Toggle Methods
```lua
Config.ToggleMethods = {
    command = true,     -- Enable command toggle
    event = true,       -- Enable event toggle
    keybind = true     -- Enable keybind toggle
}
```

### Display Elements
```lua
Config.ShowElements = {
    playerIds = true,
    playerNames = true,
    vehicleInfo = true,
    coordinates = true,
    heading = true,
    fps = true
}
```

### Hotkeys
```lua
Config.Hotkeys = {
    copyVec3 = 'F3',    -- Copy vec3 coordinates
    copyVec4 = 'F4',    -- Copy vec4 coordinates
    copyHeading = 'F6'  -- Copy heading
}
```

### Notification Systems
```lua
Config.Notifications = {
    type = 'native', -- 'native', 'esx', 'qb', 'mythic', 'ox'
    position = 'top-right',
    duration = 3000
}
```

### Performance Settings
```lua
Config.Performance = {
    updateInterval = 100,
    playerUpdateInterval = 500,
    maxDrawDistance = 100.0,
    smoothFPS = true
}
```

### Preset Positions
```lua
Config.PresetPositions = {
    ['top-left'] = {x = 0.005, y = 0.005},
    ['top-right'] = {x = 0.985, y = 0.005},
    // ...more presets
}
```

## Usage
- Toggle: F5 (configurable)
- Copy Vec3: F3
- Copy Vec4: F4
- Copy Heading: F6

## Performance
The script is optimized with:
- Player caching system
- Configurable update intervals
- Distance-based rendering
- Smooth FPS counter
- Efficient memory usage

## Support
Discord: COMING SOON

## License
Apache License 2.0
