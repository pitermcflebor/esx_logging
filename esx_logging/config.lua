-- DEFINE CONFIG TABLE
Config = {}

Config.logCommands 		= true		-- logging commands? (chat and F8)
Config.logMessages 		= true		-- logging messages? (chat)
Config.logAddItem 		= true		-- logging inventory items received (esx_inventory)
Config.logRemoveItem 	= true		-- logging inventory items removed (esx_inventory)
Config.logJoin			= true		-- logging when players connect
Config.logLeft			= true		-- logging when players disconnect

Config.debug 			= false		-- print errors for client? RECOMENDED: false || true only for debugging

-- DEFINE TYPES OF LOGGINS
Config.types = {
	['command'] 	= 'Log a command (ex: /setjob [id] [job] [grade])',
	['f8command'] 	= 'Log a F8 console command (ex: /setjob [id] [job] [grade])',
	['message'] 	= 'Log a message (ex: Hello world)',
	['newitem'] 	= 'Log a new item added to inventory (ex: Added x[amount] of [item] to inventory)',
	['removeitem'] 	= 'Log when item is removed from inventory (ex: Removed x[amount] of [item] from inventory)'
}

-- DEFINE THE DESCRIPTION THAT WILL SHOWN WHEN LOGGIN
Config.description = {
	-- [type] = 'string formatted'
	['command'] 		= 'executed "%s"',
	['f8command'] 		= 'executed "%s" from console (F8)',
	['message'] 		= 'send "%s"',
	['newitem'] 		= 'added "%s" to inventory, now has x%s',
	['removeitem'] 		= 'removed "%s" from inventory, now has x%s'
}

-- DEFINE EXCLUDED COMMANDS
Config.excludeCommand = { -- commands to avoid of logging
	-- ['/command'] = any
	['/-handsup'] 	= true,
	['/+handsup'] 	= true,
	['/clear']		= true,
	['/zfacepalm']	= true,
	['/yradio']		= true,
	['/zradio']		= true,
	['/zhandsup']	= true,
	['/zcrossarms']	= true
}


