fx_version 'cerulean'
game 'gta5'

author 'fort4s'
description 'custom shop system'
version '1.1.0'
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
    'locales/en.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'es_extended',
    'ox_lib',
    'ox_target',
    'oxmysql'
}