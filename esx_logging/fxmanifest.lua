version "1.0.0"
--[[ 

#			     DISCLAIMER
#		 THIS IS A RESOURCE CREATED BY
#			  [ PiterMcFlebor ]
#	  YOU CAN DO WITH THIS ANYTHIN' YOU WANT
#	 I DON'T TAKE RESPONSABILITY OF BAD USAGE
#	     USE GITHUB TO ASK FOR ANY HELP
#

REQUIREMENTS:
	- es_extended
	- MySQL Async

INSTALLATION:
	- Add this folder to your ./resources folder
	- Add `start esx_logging` to your server.cfg file || IMPORTANT, PLACE IT AFTER `start es_extended` AND `start mysql-async`
	- Run your server


]]

fx_version 'bodacious'
games { 'gta5' }

client_scripts {
	'config.lua',
	'client/*.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/*.lua'
}