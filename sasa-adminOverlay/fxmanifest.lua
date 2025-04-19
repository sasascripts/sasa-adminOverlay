fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'SASA SCRIPTS'
description 'Admin Overlay System'
version '1.0.1'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua'
}

client_scripts {
    'framework/framework_cl.lua',
    'client/client.lua'
}

server_scripts {
    'framework/framework_sv.lua',
    'server/server.lua',
    'server/versionChecker.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html'
}

dependencies {
    'ox_lib'
}
