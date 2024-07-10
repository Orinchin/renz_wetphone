fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Renz'
description 'A simple script to improve your phone features.'
version '1.0.1'

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
