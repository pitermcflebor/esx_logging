function split(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

local function getTypes()
	local tab = {}
	for index,_ in pairs(Config.types) do
		table.insert(tab, index)
	end
	return tab
end

local function isValidType(typ)
	local types = getTypes()
	for _,v in pairs(types) do
		if v == typ then
			return true
		end
	end
	return false
end

local function allParametersPassed(typ, value)
	-- ENSURE EXISTS
	if Config.description[typ] ~= nil then
		local needed = 0
		for w in (Config.description[typ]):gmatch "%%s" do
			needed = needed + 1
		end
		if needed <= #value then
			return true, needed, #value, true
		elseif needed > #value then
			return false, needed, #value, true
		end
	else
		return false, nil, nil, false			-- NOT EXISTS
	end
end

function loggingAdd(source, typ, value)
	-- MYSQL IS READY?
	if ready2work then
		-- GET INFO OF PLAYER
		local xPlayer = ESX.GetPlayerFromId(source)
		-- PROCESSING ERRORS
		if typ == nil then						-- TYPE IS PASSED?
			return 400, error[400]
		elseif type(typ) ~= 'string' then		-- TYPE IS STRING?
			return 404, (error[404]):format(type(typ), typ)
		end
		if value == nil then					-- VALUE IS PASSED?
			return 401, error[401]
		elseif type(value) ~= 'table' then		-- VALUE IS TABLE?
			if type(value) == 'string' then
				return true -- when you run a non existent command, it send it as string (idk what happens)
			end
			return 405, (error[405]):format(type(value), value)
		elseif type(value) == 'table' then		-- EXCLUDED COMMAND?
			local cmd = split(value[1])[1]
			if type(cmd) == 'string' then
				if Config.excludeCommand[cmd] ~= nil then
					return true
				end
			end
		end
		if Config.types[typ] == nil then		-- TYPE EXIST?
			return 402, (error[402]):format(getTypes()) 
		end
		local allPassed, needed, passed, descriptionExists = allParametersPassed(typ, value)
		if not allPassed and descriptionExists then -- PASSED CORRECTLY PARAMETERS FOR :FORMAT?
			return 403, (error[403]):format(needed, passed)
		elseif not allPassed and not descriptionExists then
			return 408, error[408]
		end
		-- NO ERRORS, THEN CONTINUE
		-- INSERT INTO DB ASYNCHRONOUSLY
		MySQL.Async.execute('INSERT INTO `logging` (`type`, `description`, `identifier`, `name`) VALUES(@type, @description, @identifier, @name)', 
		{
			['@type']=typ,
			['@description']=(Config.description[typ]):format(table.unpack(value)),
			['@identifier']=xPlayer.getIdentifier(),
			['@name']=xPlayer.getName()
		},
		function(rowsAffected)end)
		-- EVERYTHIN' IT'S OKAY
		return true
	else
		-- MYSQL NOT READY
		return 407, error[407]
	end
end

function checkConfig()
	-- SET TABLE
	local t = {}
	-- CHECK IF TYPES HAS DESCRIPTION
	for index, value in pairs(Config.types) do
		if Config.description[index] == nil then
			table.insert(t, index)
		end
	end
	if #t > 0 then
		return false, 409, (error[409]):format(table.concat(t, '&'))
	end
	-- CHECK IF DESCRIPTION HAS TYPE
	for index, value in pairs(Config.description) do
		if Config.types[index] == nil then
			table.insert(t, index)
		end
	end
	if #t > 0 then
		return true, 410, (error[410]:format(table.concat(t, '&')))
	end
	return true -- everythin' is OK
end

function checkVersion()
	local currentVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
	PerformHttpRequest("https://pitermcflebor.github.io/esx_logging/version.txt", function(code, text, headers)
		if code == 200 then
			if text == currentVersion then
				print('[^3ESX_LOGGING^7]: Up to date!')
			else
				print('[^1ESX_LOGGING^7]:', 411, (error[411]):format(currentVersion, text))
			end
		else
			print(412, (error[412]):format(code))
		end
	end)
end