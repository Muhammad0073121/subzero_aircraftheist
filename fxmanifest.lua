fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'subzero'
description 'Robbery Script with ox_lib and ox_inventory'

shared_script 'config.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_lib/init.lua',
    'server/main.lua'
}

client_scripts {
    '@ox_lib/init.lua',
    'client/main.lua'
}

dependencies {
    'qb-core',
    'ox_lib',
    'ox_inventory',
    'ox_target'
}
