-- player --
local player = game.Players.LocalPlayer

-- References --
boats = game.ReplicatedStorage.Boats
onBoatUpgrade = game.ReplicatedStorage.Remotes.RemoteEvents.OnBoatUpgrade
local camera = game.workspace.CurrentCamera

-- Variables --
local upgradesMenuActive = false

-- UI --
local upgradesMenu = script.Parent

local boatUpgradesButton = upgradesMenu.Parent.boatUpgradesButton

local topButtons = upgradesMenu.TopButtons
local closeButton = upgradesMenu.Close

local boatButton = topButtons.BoatButton
local crewButton = topButtons.CrewButton
local itemsButton = topButtons.ItemsButton

local boatBackground = upgradesMenu.boatBackground
local crewBackground = upgradesMenu.crewBackground
local itemsBackground = upgradesMenu.itemsBackground

local boatUpgradeButtons = boatBackground.ScrollingFrame

-- Data --
local boatLevel = player.boatStats.boat.Value

--[[ MAIN ]]--

boatButton.MouseButton1Click:Connect(function()
	boatButton.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	crewButton.Title.TextColor3 = Color3.fromRGB(88, 138, 72)
	itemsButton.Title.TextColor3 = Color3.fromRGB(155, 155, 54)
	
	boatBackground.Visible = true
	crewBackground.Visible = false
	itemsBackground.Visible = false
	
	boatButton.ZIndex = 3
	crewButton.ZIndex = 2
	itemsButton.ZIndex = 1
end)

crewButton.MouseButton1Click:Connect(function()
	crewButton.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	boatButton.Title.TextColor3 = Color3.fromRGB(175, 109, 58)
	itemsButton.Title.TextColor3 = Color3.fromRGB(155, 155, 54)

	boatBackground.Visible = false
	crewBackground.Visible = true
	itemsBackground.Visible = false

	crewButton.ZIndex = 3
	boatButton.ZIndex = 2
	itemsButton.ZIndex = 2
end)

itemsButton.MouseButton1Click:Connect(function()
	itemsButton.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	crewButton.Title.TextColor3 = Color3.fromRGB(88, 138, 72)
	boatButton.Title.TextColor3 = Color3.fromRGB(175, 109, 58)
	
	boatBackground.Visible = false
	crewBackground.Visible = false
	itemsBackground.Visible = true

	itemsButton.ZIndex = 3
	crewButton.ZIndex = 2
	boatButton.ZIndex = 1
end)

closeButton.MouseButton1Down:Connect(function()
	upgradesMenu.Visible = false
	upgradesMenuActive = false
end)

boatUpgradesButton.MouseButton1Click:Connect(function()
	--[[
		if upgradesMenuActive == false then
		upgradesMenu.Visible = true
		upgradesMenuActive = true
		boatButton.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		crewButton.Title.TextColor3 = Color3.fromRGB(88, 138, 72)
		itemsButton.Title.TextColor3 = Color3.fromRGB(155, 155, 54)

		boatBackground.Visible = true
		crewBackground.Visible = false
		itemsBackground.Visible = false

		boatButton.ZIndex = 3
		crewButton.ZIndex = 2
		itemsButton.ZIndex = 1
	else
		upgradesMenu.Visible = false
		upgradesMenuActive = false
	end
	]]--
	
	onBoatUpgrade:FireServer(player)
	
	
	local boat = game.Workspace.ActiveSeas:WaitForChild(player.Name)[player.boatStats.boat.Value].Boat
	print(game.Workspace.ActiveSeas:WaitForChild(player.Name)[player.boatStats.boat.Value])
	local boatCam = boat:WaitForChild('Camera')

	-- Move player's camera
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CameraSubject = boatCam
	camera.CFrame = boatCam.CFrame
end)

boatUpgradeButtons.boatUpgrade.upgradeBoatButton.MouseButton1Click:Connect(function()

end)
