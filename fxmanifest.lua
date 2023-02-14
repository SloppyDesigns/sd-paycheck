fx_version 'cerulean'
game 'gta5'

author 'Sloppy Designs'
description 'Simple Paycheck System [FREE RELEASE]'
documentation 'https://docs.sloppydesigns.com/free/sd-paycheck'
version '1.0.0'

shared_script 'config.lua'
client_script 'client/main.lua'
server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}

dependencies {
  'qb-target',
}

lua54 'yes'