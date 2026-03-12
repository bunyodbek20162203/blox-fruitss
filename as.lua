-- Kill Aura script (Blox Fruits)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- sozlamalar
local DAMAGE = 12302494239482340
local RANGE = 50 -- radius ichidagi dushmanlar

-- Kill Aura toggle
local killAuraOn = false

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.K then -- K tugmasi bilan yoqish/o‘chirish
        killAuraOn = not killAuraOn
        print("Kill Aura:", killAuraOn and "ON" or "OFF")
    end
end)

-- dushmanlarga zararni qo‘llash
RunService.RenderStepped:Connect(function()
    if not killAuraOn then return end

    for _, npc in pairs(workspace.Enemies:GetChildren()) do
        if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") then
            local distance = (npc.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance <= RANGE then
                npc.Humanoid:TakeDamage(DAMAGE)
            end
        end
    end
end)