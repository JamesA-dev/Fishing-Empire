-- Data Store --
local DSS = game:GetService("DataStoreService")
local boatData = DSS:GetDataStore("BoatData")

-- Remotes --
remotes = game.ReplicatedStorage.Remotes.RemoteEvents
onStart = remotes.OnStart
onBoatUpgrade = remotes.OnBoatUpgrade
onSea = remotes.OnSea
onHome = remotes.OnHome

-- References --
boats = game.ReplicatedStorage.Boats
levels = game.ReplicatedStorage.Levels
unclaimedSeas = game.Workspace.UnclaimedSeas
fishingTitle = game.ReplicatedStorage.Titles.FishingTitle

onStart.OnServerEvent:Connect(function(player)
	local playerLevel = game.Players[player.Name].levelData.level.Value
	local boatLevel = game.Players[player.Name].boatStats.boat.Value
	
	
	-- Get a random UnclaimedSea and its position then destory it --
	local unclaimedSea = unclaimedSeas.UnclaimedSea
	local seaPosition = unclaimedSea.Centre.Position -- The Main Position For everything to be moved to
	local seaPivot = unclaimedSea.Centre:GetPivot()
	unclaimedSea:Destroy()

	print(playerLevel)
	-- Get, Clone and Move the Sea Level in regards to the players stored playerLevel
	local playersSea = levels[playerLevel]:Clone()
	playersSea.Parent = game.Workspace.ActiveSeas
	playersSea.Water:PivotTo(seaPivot)
	playersSea.Name = player.Name -- Set the name of level folder to the players name

	-- Get, Clone and Move the Boat in regards to the players stored boatLevel
	local playersBoat = boats[boatLevel]:Clone()
	playersBoat.Parent = playersSea
	if boatLevel == 0 or boatLevel == 1 then
		playersBoat.Boat:PivotTo(seaPivot + Vector3.new(0, 3, 0))
	elseif boatLevel == 2 or boatLevel == 3 then
		playersBoat.Boat:PivotTo(seaPivot + Vector3.new(0, 6.5, 0))
	elseif boatLevel == 4 then
		playersBoat.Boat:PivotTo(seaPivot + Vector3.new(0, 7, 0))
	elseif boatLevel == 5 then
		playersBoat.Boat:PivotTo(seaPivot + Vector3.new(0, 6, 0))
	elseif boatLevel == 6 then
		playersBoat.Boat:PivotTo(seaPivot + Vector3.new(0, 7.3, 0))
	elseif boatLevel == 7 then
		playersBoat.Boat:PivotTo(seaPivot + Vector3.new(0, 8, 0))
	elseif boatLevel == 8 then
		playersBoat.Boat:PivotTo(seaPivot + Vector3.new(0, 8.2, 0))
	elseif boatLevel == 9 then
		playersBoat.Boat:PivotTo(seaPivot + Vector3.new(0, 10.7, 0))
	elseif boatLevel == 10 then
		playersBoat.Boat:PivotTo(seaPivot + Vector3.new(0, 12, 0))
	end
	
	-- Add players character to rig
	local Players = game:GetService("Players")
	local Rig = playersBoat.Boat.Player
	local ID = player.UserId

	local function CreateOfflineCharacter(UserID, Dummy)
		local Appearance = Players:GetHumanoidDescriptionFromUserId(UserID)
		Dummy.Humanoid:ApplyDescription(Appearance)
	end

	CreateOfflineCharacter(ID, Rig)
	
	local playersFishingTitle = fishingTitle:Clone()
	playersFishingTitle.Parent = player.Character.Head
end)

onSea.OnServerEvent:Connect(function(player)
	local playerFishing = player.Character.Head.FishingTitle
	playerFishing.Enabled = true
end)

onHome.OnServerEvent:Connect(function(player)
	local playerFishing = player.Character.Head.FishingTitle
	playerFishing.Enabled = false
end)


onBoatUpgrade.OnServerEvent:Connect(function(player)
	local boatLevel = game.Players[player.Name].boatStats.boat.Value
	local playerLevel = game.Players[player.Name].levelData.level.Value
	
	-- Current Sea and Boat --
	local currentSea = game.Workspace.ActiveSeas[player.Name]
	local currentBoat = currentSea[boatLevel].Boat
	local currentPivot = currentBoat:GetPivot()

	-- Remove old boat --
	game.Workspace.ActiveSeas[player.Name][boatLevel]:Destroy()

	-- playerMoney -= amount

	boatLevel += 1
	player.boatStats.boat.Value += 1
	
	-- Get new boat --
	local playersBoat = boats[boatLevel]:Clone()
	playersBoat.Parent = currentSea

	-- Get, Clone and Move the Boat in regards to the players stored boatLevel
	if boatLevel == 0 or boatLevel == 1 then
		playersBoat.Boat:PivotTo(currentPivot)
	elseif boatLevel == 2 then
		playersBoat.Boat:PivotTo(currentPivot + Vector3.new(0, 3.5, 0))
	elseif boatLevel == 3 then
		playersBoat.Boat:PivotTo(currentPivot + Vector3.new(0, 0, 0))
	elseif boatLevel == 4 then
		playersBoat.Boat:PivotTo(currentPivot + Vector3.new(0, 0.5, 0))
	elseif boatLevel == 5 then
		playersBoat.Boat:PivotTo(currentPivot + Vector3.new(0, -1, 0))
	elseif boatLevel == 6 then
		playersBoat.Boat:PivotTo(currentPivot + Vector3.new(0, 1.3, 0))
	elseif boatLevel == 7 then
		playersBoat.Boat:PivotTo(currentPivot + Vector3.new(0, 1, 0))
	elseif boatLevel == 8 then
		playersBoat.Boat:PivotTo(currentPivot + Vector3.new(0, 0.2, 0))
	elseif boatLevel == 9 then
		playersBoat.Boat:PivotTo(currentPivot + Vector3.new(0, 1.8, 0))
	elseif boatLevel == 10 then
		playersBoat.Boat:PivotTo(currentPivot + Vector3.new(0, -2, 0))
	end

	-- Add players character to rig
	local Players = game:GetService("Players")
	local Rig = playersBoat.Boat.Player
	local ID = player.UserId

	local function CreateOfflineCharacter(UserID, Dummy)
		local Appearance = Players:GetHumanoidDescriptionFromUserId(UserID)
		Dummy.Humanoid:ApplyDescription(Appearance)
	end

	CreateOfflineCharacter(ID, Rig)
end)
