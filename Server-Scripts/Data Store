local DSS = game:GetService("DataStoreService")
local playerData = DSS:GetDataStore("PlayerData")
local fishingData = DSS:GetDataStore("FishingData")
local boatData = DSS:GetDataStore("BoatData")
local levelData = DSS:GetDataStore("LevelData")



local function OnJoin(plr : Player)

	-- Leaderstats Info
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"

	local Cash = Instance.new("NumberValue", leaderstats)
	Cash.Name = "Cash"
	Cash.Value = 0
	
	local Gems = Instance.new("NumberValue", leaderstats)
	Gems.Name = "Gems"
	Gems.Value = 0

	leaderstats.Parent = plr

	-- Fishing Info
	local fishingInfo = Instance.new("Folder")
	fishingInfo.Name = "fishingInfo"

	local stars = Instance.new("IntValue", fishingInfo)
	stars.Name = "stars"
	stars.Value = 0

	local fishEXP = Instance.new("IntValue", fishingInfo)
	fishEXP.Name = "fishEXP"
	fishEXP.Value = 0
	
	fishingInfo.Parent = plr

	-- Boat Info
	local boatStats = Instance.new("Folder")
	boatStats.Name = "boatStats"
	
	local boat = Instance.new("IntValue", boatStats)
	boat.Name = "boat"
	boat.Value = 0
	
	boatStats.Parent = plr
	
	-- Boat Upgrades
	local boatUpgrades = Instance.new("Folder")
	boatUpgrades.Name = "boatUpgrades"

	local properRod = Instance.new("IntValue", boatUpgrades)
	properRod.Name = "properRod"
	properRod.Value = 0

	local breadCrumbs = Instance.new("IntValue", boatUpgrades)
	breadCrumbs.Name = "breadCrumbs"
	breadCrumbs.Value = 0
	
	local theRightPull = Instance.new("IntValue", boatUpgrades)
	theRightPull.Name = "theRightPull"
	theRightPull.Value = 0

	local betterHooks = Instance.new("IntValue", boatUpgrades)
	betterHooks.Name = "betterHooks"
	betterHooks.Value = 0
	
	local improvedJiggs = Instance.new("IntValue", boatUpgrades)
	improvedJiggs.Name = "improvedJiggs"
	improvedJiggs.Value = 0

	local fishValue = Instance.new("IntValue", boatUpgrades)
	fishValue.Name = "fishValue"
	fishValue.Value = 0

	boatUpgrades.Parent = plr.boatStats
	
	-- Level Info
	local levelsInfo = Instance.new("Folder")
	levelsInfo.Name = "levelData"

	local level = Instance.new("IntValue", levelsInfo)
	level.Name = "level"
	level.Value = 0

	levelsInfo.Parent = plr
	
-- Make the data variables
	local playeruserID = 'player_'.. plr.UserId
	
	local playerInfo = playerData:GetAsync(playeruserID)
	local boatInfo = boatData:GetAsync(playeruserID)
	local fishingInfo = fishingData:GetAsync(playeruserID)
	local levelInfo = levelData:GetAsync(playeruserID)
	
	-- Leaderstats --
	if playerInfo then
		Cash.Value = playerInfo['Cash']
		Gems.Value = playerInfo['Gems']
	else
		Cash.Value = 0
		Gems.Value = 0
	end	
	
	-- Fishing Info --
	if fishingInfo then
		stars.Value = fishingInfo['stars']
		fishEXP.Value = fishingInfo['fishEXP']
	else
		stars.Value = 0
		fishEXP.Value = 0
	end
	
	-- Boat Info --
	if boatInfo then
		--boat.Value = boatInfo['boat']
		boat.Value = 0
		
		properRod.Value = boatInfo['properRod']
		breadCrumbs.Value = boatInfo['breadCrumbs']
		
		theRightPull.Value = boatInfo['theRightPull']
		betterHooks.Value = boatInfo['betterHooks']
		
		improvedJiggs.Value = boatInfo['improvedJiggs']
		fishValue.Value = boatInfo['fishValue']
	else
		boat.Value = 0
		
		properRod.Value = 0
		breadCrumbs.Value = 0
		
		theRightPull.Value = 0
		betterHooks.Value = 0
		
		improvedJiggs.Value = 0
		fishValue.Value = 0
	end	
	
	-- Level Info --
	if levelInfo then
		level.Value = levelInfo['level']
	else
		level.Value = 0
	end
end

local function create_table(player, folder)
	local playerstats = {}
	for _, stat in pairs(folder:GetChildren()) do
		if stat.Name == 'boatUpgrades' then
			for _, moreStat in pairs(stat:GetChildren()) do
				playerstats[moreStat.Name] = moreStat.Value
			end
		else
			playerstats[stat.Name] = stat.Value
		end
	end
	return playerstats
end

local function onPlayerExit(player : Player)
	local leaderstats = player.leaderstats
	local boatInfo = player.boatStats
	local fishingInfo = player.fishingInfo
	local levelInfo = player.levelData
	local player_stats = create_table(player, leaderstats)
	local boat_stats = create_table(player, boatInfo)
	local fishing_stats = create_table(player, fishingInfo)
	local level_stats = create_table(player, levelInfo)
	
	local success, err = pcall(function()
		local playeruserID = 'player_'.. player.UserId
		
		playerData:SetAsync(playeruserID, player_stats)
		boatData:SetAsync(playeruserID, boat_stats)
		fishingData:SetAsync(playeruserID, fishing_stats)
		levelData:SetAsync(playeruserID, level_stats)

	end)
	print(player_stats)
	if not success then
		warn('Could not save data')
	else
		print("Saved "..player.Name.."'s data")
	end
end


local function OnServerShutdown()
	local Players = game.Players
	for i,plr in pairs(Players:GetPlayers()) do
		onPlayerExit(plr)
	end
end
game.Players.PlayerAdded:Connect(OnJoin)

game.Players.PlayerRemoving:Connect(onPlayerExit)

game:BindToClose(OnServerShutdown)
