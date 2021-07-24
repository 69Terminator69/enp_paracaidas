author 'TermiDEV'

client_scripts {
    'client/*.lua',
    'config.lua'
}

shared_scripts {
    'config.lua',
}

server_scripts{
	'@mysql-async/lib/MySQL.lua',
    'server/*.lua',
    'config.lua'
}