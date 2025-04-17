# SASA Admin Overlay

Advanced development and debugging overlay system for FiveM.

## Features

### Core Features
- Real-time player information display
- Advanced FPS monitoring with color indicators
- Vehicle diagnostics (engine & body health)
- Coordinate tools with quick copy functions
- Multi-framework support (ESX/QB-Core)
- Performance optimized with caching

### Display Information
- Player IDs and Names
- Coordinates and Heading
- Vehicle Model and Health
- FPS Counter with Status Colors
- Distance-based Information Display

### Developer Tools
- Quick Vector3/Vector4 Copy
- Heading Copy Function
- Performance Monitoring
- Entity Information
- Debug Instructions

## Dependencies
- ESX Legacy or QB-Core
- ox_lib (optional, for enhanced notifications)

## Installation
1. Place in `[custom]` folder
2. Add to server.cfg: `ensure sasa-adminOverlay`
3. Configure `config.lua` to your needs
4. Restart your server

## Configuration

### Admin Groups
```lua
Config.AdminGroups = {
    -- ESX Groups
    'admin',
    'superadmin',
    -- QB Groups
    'god',
    'admin'
}
```

### Performance Configuration
```lua
Config.Performance = {
    updateInterval = 100,      -- FPS update rate
    playerUpdateInterval = 500, -- Player info update rate
    maxDrawDistance = 100.0,   -- Maximum render distance
    smoothFPS = true          -- Enable FPS smoothing
}
```

### Display Customization
```lua
Config.TextStyles = {
    scale = 0.35,
    font = 4,
    color = Config.Colors.default
}

Config.Positions = {
    fps = Config.PresetPositions['top-left'],
    copyInstructions = {
        vec3 = {x = 0.005, y = 0.90},
        vec4 = {x = 0.005, y = 0.93},
        heading = {x = 0.005, y = 0.96}
    }
}
```

### Notification Systems
```lua
Config.Notifications = {
    type = 'native',    -- 'native', 'esx', 'qb', 'mythic', 'ox'
    position = 'top-right',
    duration = 3000
}
```

## Usage Guide

### Basic Controls
- Toggle Overlay: F5 (configurable)
- Copy Vec3: F3
- Copy Vec4: F4
- Copy Heading: F6

### Command Usage
```
/adminoverlay - Toggle overlay
/copyvec3 - Copy current vec3 coordinates
/copyvec4 - Copy current vec4 coordinates
/copyheading - Copy current heading
```

### Developer Notes
- All display elements can be toggled in config
- Performance settings can be adjusted for different server loads
- Position presets available for all UI elements- Color coding for performance indicators

## Performance Optimization
- Efficient player caching system
- Configurable update intervals
- Distance-based rendering
- Smooth FPS transitions
- Memory usage optimization
- Entity information caching

## Troubleshooting

### Common Issues
1. Overlay not showing
   - Check admin permissions
   - Verify framework detection
   - Check keybinding conflicts

2. Performance Issues
   - Adjust update intervals
   - Reduce max draw distance
   - Disable unused features

3. Framework Detection
   - Ensure correct framework is running
   - Check framework version compatibility

## Support
- Discord: COMING SOON
- GitHub Issues: [Repository Link]
- Documentation: [Wiki Link]

## Credits
Created by SASA SCRIPTS
Version: 1.0.0

## License
Apache License 2.0
