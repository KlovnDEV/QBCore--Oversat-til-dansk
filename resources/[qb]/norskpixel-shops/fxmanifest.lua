
fx_version 'cerulean'
game 'gta5'

description 'norskpixel-Shops'
version '1.0.0'

shared_script 'config.lua'

client_script 'client/main.lua'
server_script 'server/main.lua'

dependencies {
	'norskpixel-inventory'
}

lua54 'yes'