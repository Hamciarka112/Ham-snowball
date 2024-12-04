fx_version 'adamant'

game 'gta5'

description 'Ham-snowball'
lua54 'yes'
version '1.1' -- [FIX] Padaryta kad gautum itema kaip gniukste , pridedas checkas kad tikrintu ar turi vietos savo inv , bsk optimizacija padaryta, pakeistas zonu atsiradimo placementas padaryta labiau random.


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

escrow_ignore {
    'config.lua'
}