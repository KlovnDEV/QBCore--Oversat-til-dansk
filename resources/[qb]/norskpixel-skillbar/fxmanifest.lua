
fx_version 'cerulean'
game 'gta5'

description 'norskpixel-Skillbar'
version '1.0.0'

ui_page "html/index.html"
client_script 'client/main.lua'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/VerdanaBold.ttf'
}

exports {
    'GetSkillbarObject'
}

dependencies {
  'norskpixel-core'
}

lua54 'yes'