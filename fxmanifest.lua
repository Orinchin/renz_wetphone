fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Renz'
description 'Repair when the phone is wet'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts{
    'client/main.lua',
    'config.lua'
}

server_scripts {
    'server/main.lua',
    'config.lua'
}