-- Player ---
local player = game.Players.LocalPlayer
game.Workspace[player.Name].HumanoidRootPart.Anchored = true

-- UI Elements ---
--local loadingScreen = player.PlayerGui.MainLoadingScreen.Background
local menuFrame = script.Parent
local mainFrame = player.PlayerGui:WaitForChild("TopbarStandard")
local playButton = menuFrame.playBtn
local settingsButton = menuFrame.settingsBtn

-- Remotes ---
onStart = game.ReplicatedStorage.Remotes.RemoteEvents.OnStart

-- Setup UI --
--loadingScreen.Visible = true
menuFrame.Visible = true
mainFrame.Enabled = false


-- Start Function ---
playButton.MouseButton1Click:Connect(function()
	game.Workspace[player.Name].HumanoidRootPart.Anchored = false
	
	--Disable main menu UI
	menuFrame.Visible = false
	-- Enable mainUI
	mainFrame.Enabled = true
	--player.PlayerGui["StartScreen"].RotateSystem:WaitForChild('Value').Value = true
	
	--Load player's sea on the server
	onStart:FireServer(player)
	task.wait(1)
end)
