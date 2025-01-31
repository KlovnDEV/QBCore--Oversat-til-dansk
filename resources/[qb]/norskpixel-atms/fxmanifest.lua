
fx_version 'cerulean'
game 'gta5'

description 'norskpixel-ATM'
version '1.0.0'

shared_script 'config/main.lua'
server_script 'server/main.lua'
client_script 'client/main.lua'

ui_page 'nui/index.html'

files {
  'nui/images/logo1.png',
  'nui/images/logo.png',
  'nui/images/visa.png',
  'nui/images/mastercard.png',
  'nui/scripting/jquery-ui.css',
  'nui/scripting/external/jquery/jquery.js',
  'nui/scripting/jquery-ui.js',
  'nui/style.css',
  'nui/index.html',
  'nui/norskpixel-atms.js'
}

lua54 'yes'