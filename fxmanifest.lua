fx_version 'cerulean'
game 'gta5'

author 'Sloppy Designs'
description 'Simple Paycheck System [FREE RELEASE]'
documentation 'https://docs.sloppydesigns.com/free/sd-paycheck'
version '1.0.0'

shared_scripts {
  -- '@es_extended/imports.lua', -- Uncomment for ESX
  'config.lua'
}

client_script 'client/main.lua'
server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}

lua54 'yes'