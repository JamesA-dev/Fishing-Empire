Icon = require(game.ReplicatedStorage.Icon)

-- Player --
player = game.Players.LocalPlayer
humanoid = player.Character.Humanoid

-- Objects ---
local camera = game.workspace.CurrentCamera
local mainCamera = workspace.StartingArea.mainMenuCamera
local loadingScreens = game.ReplicatedStorage.LoadingScreens

-- UI --
seaLoadingScreen = loadingScreens.SeaLoadingScreen
homeLoadingScreen = loadingScreens.HomeLoadingScreen
local seaUI = player.PlayerGui.seaUI

-- Remotes --
local remotes = game.ReplicatedStorage.Remotes.RemoteEvents
local onSea = remotes.OnSea
local onHome = remotes.OnHome

-- Modules --
Icon = require(game.ReplicatedStorage.Icon)

-- Variables --
atSea = false

local homeBtnFrame = player.PlayerGui.TopbarStandard.Holders.Right.homeButton
local seaBtnFrame = player.PlayerGui.TopbarStandard.Holders.Right.seaButton

homeBtnFrame.Visible = false

local seaBtn = seaBtnFrame.IconButton.Menu.IconSpot.ClickRegion
local homeBtn = homeBtnFrame.IconButton.Menu.IconSpot.ClickRegion

local settingsBtn = player.PlayerGui.TopbarStandard.Holders.Left.Settings.IconButton.Menu.IconSpot.ClickRegion

settingsBtn.MouseButton1Click:Connect(function()
	
end)

seaBtn.MouseButton1Click:Connect(function()
	-- Disable home UI
	seaBtnFrame.Visible = false
	
	-- Loading screen
	local newSeaLoading = seaLoadingScreen:Clone()
	newSeaLoading.Parent = player.PlayerGui
	seaLoadingScreen.Enabled = true

	--Declare new variables once the sea has been loaded
	local boat = game.Workspace.ActiveSeas:WaitForChild(player.Name)[player.boatStats.boat.Value].Boat
	local boatCam = boat:WaitForChild('Camera')

	-- Move player's camera
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CameraSubject = boatCam
	camera.CFrame = boatCam.CFrame
	
	-- Disable player movement
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	game.Workspace[player.Name].HumanoidRootPart.Anchored = true
	wait(0.5)
	game.Workspace[player.Name].HumanoidRootPart.Anchored = false
	wait(0.5)
	game.Workspace[player.Name].HumanoidRootPart.Anchored = true
	wait(0.1)
	
	onSea:FireServer(player) -- To MainServer script (For enabling Player "Fishing" Title)
end)

homeBtn.MouseButton1Click:Connect(function()
	-- Disable sea UI
	seaUI.screenFrame.mainUI.Visible = false
	homeBtnFrame.Visible = false
	
	-- Loading screen
	local newHomeLoading = homeLoadingScreen:Clone()
	newHomeLoading.Parent = player.PlayerGui
	homeLoadingScreen.Enabled = true
	
	-- Move player's camera
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = mainCamera.CFrame
	task.wait()
	camera.CameraSubject = humanoid
	camera.CameraType = "Custom"
	
	-- Enable player movement
	game.Workspace[player.Name].HumanoidRootPart.Anchored = false
	humanoid.WalkSpeed = 16
	humanoid.JumpPower = 7.2
	
	onHome:FireServer(player) -- To MainServer script (For disabling Player "Fishing" Title)
end)
