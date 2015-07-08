
PLUGIN = nil


function Initialize(Plugin)
	-- Load the Info.lua file
	dofile(cPluginManager:GetPluginsPath() .. "/AutoReplant/Info.lua")

	PLUGIN = Plugin

	PLUGIN:SetName(g_PluginInfo.Name)
	PLUGIN:SetVersion(g_PluginInfo.Version)

	-- Hooks
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_RIGHT_CLICK, OnPlayerRightClick)

	LOG("Initialized " .. PLUGIN:GetName() .. " v." .. PLUGIN:GetVersion())
	LOG(PLUGIN:GetName() .. ": This plugin is currently in beta and may have a few bugs.")
	return true
end

function OnDisable()
	LOG("Disabled " .. PLUGIN:GetName() .. "!")
end

function OnPlayerRightClick(Player, X,Y,Z)
	World = Player:GetWorld()

	Valid, Type, Meta = World:GetBlockInfo(X,Y,Z)

	if ((Type == E_BLOCK_CROPS or Type == E_BLOCK_CARROTS or Type == E_BLOCK_POTATOES) and Meta == 0x7) then
		Pickups = cItems()
		if (Type == E_BLOCK_CROPS) then
			amount = math.random(0,1)
			if (amount ~= 0) then
				Pickups:Add(cItem(E_ITEM_SEEDS, amount))
			end
			Pickups:Add(cItem(E_ITEM_WHEAT, 1))
		elseif (Type == E_BLOCK_CARROTS) then
			amount = math.random(0,2)
			if (amount ~= 0) then
				Pickups:Add(cItem(E_ITEM_CARROT, amount))
			end
		else
			amount = math.random(0,2)
			if (amount ~= 0) then
				Pickups:Add(cItem(E_ITEM_POTATO, amount))
			end
		end

		if (Pickups:Size() > 0) then
			World:SpawnItemPickups(Pickups, X,Y,Z, 5)
		end
		World:FastSetBlock(X,Y,Z, Type, 0)
	end
end

