fx_version 'adamant'

game 'gta5'

description 'Ham-snowball'
lua54 'yes'
version '1.0' 


shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'ox_target',
    'es_extended',
    'ox_lib'
}
