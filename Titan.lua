-- Titan AutoKill Script (Delta Safe)
-- Cria GUI com OrionLib, implementa proteção contra kick e um sistema de Auto Kill

-- Carrega a biblioteca OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Cria a janela principal da interface
local Window = OrionLib:MakeWindow({
    Name = "AutoKill | Delta Safe", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "OrionTest"
})

-- Cria a aba principal da GUI
local Tab = Window:MakeTab({
	Name = "Principal",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- Proteção contra Kick
hookfunction(game:GetService("Players").LocalPlayer.Kick, function() end)

-- Função de Auto Kill
Tab:AddToggle({
	Name = "Auto Kill (Delta)",
	Default = false,
	Callback = function(Value)
        getgenv().ak = Value
        while getgenv().ak and wait(0.2) do
            pcall(function()
                for i,v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1)
                    end
                end
            end)
        end
	end    
})
