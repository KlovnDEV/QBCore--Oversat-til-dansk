
fx_version 'cerulean'
game 'gta5'

description 'norskpixel-LapRaces'
version '1.0.0'

ui_page 'html/index.html'

shared_script 'config.lua'

client_script 'client/main.lua'
server_script'server/main.lua'

files {
    'html/*.html',
    'html/*.css',
    'html/*.js',
    'html/fonts/*.otf',
    'html/img/*'
}

exports {
    'IsInRace',
    'IsInEditor'
}

lua54 'yes'