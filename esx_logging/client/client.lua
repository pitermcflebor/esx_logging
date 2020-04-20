--====================--
--==	ESX OBJ		==--
--====================--

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--====================--
--==	LOGGINGS	==--
--====================--

if Config.logCommands then
	Citizen.CreateThread(function()
		AddEventHandler('logging:executeCommand', function(data) -- after line 111 of [chat/cl_chat.lua] added 'TriggerEvent('logging:executeCommand', {id=PlayerId(), msg=data.message})'
			ESX.TriggerServerCallback('logging:add', function(errorCode, errorText)
				if type(errorCode) == 'number' then				-- check if raised an error
					if Config.debug then
						print('ERROR:', errorCode, errorText)
					end
				end
			end, 'command', {data.msg, PlayerId()})
		end)
	end)
end

if Config.logMessages then
	Citizen.CreateThread(function()
		AddEventHandler('logging:newMessage', function(data) -- after line 114 of [chat/cl_chat.lua] added 'TriggerEvent('logging:newMessage', {id=PlayerId(), msg=data.message})'
			ESX.TriggerServerCallback('logging:add', function(errorCode, errorText)
				if type(errorCode) == 'number' then			-- check if raised an error
					if Config.debug then
						print('ERROR:', errorCode, errorText)
					end
				end
			end, 'message', {data.msg, PlayerId()})
		end)
	end)
end

if Config.logAddItem then
	Citizen.CreateThread(function()
		RegisterNetEvent('esx:addInventoryItem')
		AddEventHandler('esx:addInventoryItem', function(item, count)
			ESX.TriggerServerCallback('logging:add', function(errorCode, errorText)
				if type(errorCode) == 'number' then
					if Config.debug then
						print('ERROR:', errorCode, errorText)
					end
				end
			end, 'newitem', {item, count})
		end)
	end)
end

if Config.logRemoveItem then
	Citizen.CreateThread(function()
		RegisterNetEvent('esx:removeInventoryItem')
		AddEventHandler('esx:removeInventoryItem', function(item, count)
			ESX.TriggerServerCallback('logging:add', function(errorCode, errorText)
				if type(errorCode) == 'number' then
					if Config.debug then
						print('ERROR:', errorCode, errorText)
					end
				end
			end, 'removeitem', {item, count})
		end)
	end)
end