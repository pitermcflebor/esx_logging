--====================--
--==	ESX OBJ		==--
--====================--
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--====================--
--==	ERROR CODE	==--
--====================--

error = {
	[400] = 'type param is nil',
	[401] = 'value param is nil',
	[402] = 'type invalid passed parameter (ex: %s)',
	[403] = 'description need %s parameter(s), you passed %s',
	[404] = 'type param is not a string, you passed a "%s" with value "%s"',
	[405] = 'value param is not a table (ex: {p1, p2, p3}), you passed a "%s" with value "%s"',
	[406] = 'there was an error processing MySQL execution. Maybe DB not connected?',
	[407] = 'there was an error processing MySQL execution. Maybe mysql script not started properly? Maybe config file is not properly filled?',
	[408] = 'description of that type does not exist',
	[409] = 'these type(s) does not have a description: "%s". Check config.lua',
	[410] = 'these description(s) does not have a type: "%s". We can continue with them.',
	[411] = 'mismatched version, you are running %sv and there is a %sv',
	[412] = 'can\'t check version, something went wrong (code: %s)'
}

--====================--
--==	MySQL LOAD	==--
--====================--

ready2work = false
if MySQL ~= nil then
	MySQL.ready(function()
		local checkPassed, errorCode, errorText = checkConfig()
		if not checkPassed then
			print(('[^1ESX_LOGGING^7]: %s %s'):format(errorCode, errorText))
		else
			Citizen.CreateThread(function() checkVersion() end) -- check version without stoping code
			if errorCode ~= nil and errorText ~= nil then
				print(('[^3ESX_LOGGING^7]: System badly ready. %s %s'):format(errorCode, errorText))
			else
				print('[^3ESX_LOGGING^7]: System ready.')
			end
			ready2work = true
		end
	end)
else
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5000) -- wait for print
			print('\n\n[^1ESX_LOGGING^7]: Is ^3MySQL^7 running? Maybe not imported?\n\n')
		end
	end)
end

--====================--
--==	FUNCTIONS	==--
--====================--

-- REGISTER FOR CLIENT
ESX.RegisterServerCallback('logging:add', function(source, cb, typ, value)
	local errorCode, errorText = loggingAdd(source, typ, value)
	if type(errorCode) == 'number' then
		print(('[^1ESX_LOGGING^7]: %s %s'):format(errorCode, errorText))
		cb(errorCode, errorText) 							-- send error to client-side
	else
		cb(true) 											-- everythin' it's okay
	end
end)

-- REGISTER COMMANDS ON CONSOLE (F8)
if Config.logCommands then
	Citizen.CreateThread(function()
		RegisterServerEvent('__cfx_internal:commandFallback')
		AddEventHandler('__cfx_internal:commandFallback', function(command)
			local errorCode, errorText = loggingAdd(source, 'f8command', command)
			if type(errorCode) == 'number' then
				print(('[^1ESX_LOGGING^7]: %s %s'):format(errorCode, errorText))
			end
		end)
	end)
end

-- REGISTER PLAYER CONNECTED   todo
--[[ if Config.logJoin then
	Citizen.CreateThread(function()
		AddEventHandler('onPlayerConnect')
	end)
end]]
