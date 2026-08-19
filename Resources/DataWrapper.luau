--PersistX (DataStore Wrapper)
--Scripted by @redmustard_6

---------------
---VARIABLES---
---------------
local dss = game:GetService("DataStoreService")
local https = game:GetService("HttpService")
local datawrapper = {}

---------------
---FUNCTIONS---
---------------

--Gets a datastore by name (THIS IS NOT A LOAD FUNCTION!)
function datawrapper.Get(name)
	return dss:GetDataStore(name)
end

--Loads data with a datastore and key input
function datawrapper.LoadGeneric(datastore, key, default)
	--Load the datastore safely using pcall
	local data
	local success, err = pcall(function()
		data = datastore:GetAsync(key)
	end)

	if success then
		if data then
			--Return the data if a data value already exists
			return data
		else
			--Return the default value if no data exists
			if not default then warn("No default value for key: "..tostring(key)..". ") end
			return default
		end
	else
		--Warn the potential error
		warn(err)
		return default
	end

end

--Loads data with a datastore and player input
function datawrapper.Load(datastore, player:Player, default)
	--Load the datastore safely using pcall
	local data
	local success, err = pcall(function()
		data = datastore:GetAsync(player.UserId)
	end)

	if success then
		if data then
			--Return the data if a data value already exists
			return data
		else
			--Return the default value if no data exists
			if not default then warn("No default value for "..player.Name..". ") end
			return default
		end
	else
		--Warn the potential error
		warn(err)
		player:Kick("Data saving has failed. Please join again.")
	end

end


--Saves data with a datastore, key and data input
function datawrapper.SaveGeneric(datastore, key, data)
	--Save the datastore safely using pcall
	local success, err = pcall(function()
		datastore:SetAsync(key, data)
	end)

	if success then
		--Return the data
		return success
	else
		--Warn potential error
		warn(err)
		return success
	end

end

--Saves data with a datastore, player and data input
function datawrapper.Save(datastore, player, data)
	--Save the datastore safely using pcall
	local success, err = pcall(function()
		datastore:SetAsync(player.UserId, data)
	end)

	if success then
		--Return the data
		return success
	else
		--Warn potential error
		warn(err)
		return success
	end

end

--Loads data with a datastore and player input
function datawrapper.LoadDecode(datastore, player, default)
	local rawData
	local success, err = pcall(function()
		rawData = datastore:GetAsync(player.UserId)
	end)

	if success then
		if rawData ~= nil then
			-- Only decode if rawData exists
			return https:JSONDecode(rawData)
		else
			if not default then warn("No default value for "..player.Name) end
			return default
		end
	else
		warn(err)
		player:Kick("Data saving has failed. Please join again.")
	end
end

--Saves data with a datastore, player and data input
function datawrapper.SaveEncode(datastore, player, data)
	--Save the datastore safely using pcall
	local success, err = pcall(function()
		datastore:SetAsync(player.UserId, https:JSONEncode(data))
	end)

	if success then
		--Return the data
		return success
	else
		--Warn potential error
		warn(err)
		return success
	end

end

return datawrapper
