-- Dragon Power Script (Starter Example)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local transformed = false
local killAura = false
local flying = false
local DAMAGE = 12302494239482340

-- 🐉 Dragon Transform
function dragonTransform()
    if not transformed then
        humanoid.WalkSpeed = 60
        humanoid.JumpPower = 120

        local aura = Instance.new("ParticleEmitter")
        aura.Texture = "rbxassetid://243660364"
        aura.Rate = 100
        aura.Parent = root

        transformed = true
        print("Dragon Transform ON")
    else
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50

        for _,v in pairs(root:GetChildren()) do
            if v:IsA("ParticleEmitter") then
                v:Destroy()
            end
        end

        transformed = false
        print("Dragon Transform OFF")
    end
end

-- 🔥 Dragon Fire Attack
function dragonFire()
    local fire = Instance.new("Part")
    fire.Size = Vector3.new(2,2,10)
    fire.BrickColor = BrickColor.new("Bright orange")
    fire.Material = Enum.Material.Neon
    fire.CFrame = root.CFrame * CFrame.new(0,0,-5)
    fire.Anchored = false
    fire.Parent = workspace

    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.Velocity = root.CFrame.LookVector * 150
    bodyVel.MaxForce = Vector3.new(999999,999999,999999)
    bodyVel.Parent = fire

    game.Debris:AddItem(fire,3)
end

-- ⚔ Kill Aura
RunService.RenderStepped:Connect(function()
    if killAura then
        for _,enemy in pairs(workspace:GetChildren()) do
            if enemy:FindFirstChild("Humanoid") and enemy ~= char then
                enemy.Humanoid:TakeDamage(DAMAGE)
            end
        end
    end
end)

-- 💨 Dragon Fly
function toggleFly()
    flying = not flying

    if flying then
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)

        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.Name = "DragonFly"
        bodyVel.Velocity = Vector3.new(0,50,0)
        bodyVel.MaxForce = Vector3.new(999999,999999,999999)
        bodyVel.Parent = root
    else
        if root:FindFirstChild("DragonFly") then
            root.DragonFly:Destroy()
        end
    end
end

-- 🎮 Tugmalar
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.T then
        dragonTransform() -- transform
    elseif input.KeyCode == Enum.KeyCode.F then
        dragonFire() -- fire attack
    elseif input.KeyCode == Enum.KeyCode.K then
        killAura = not killAura -- kill aura toggle
        print("Kill Aura:", killAura)
    elseif input.KeyCode == Enum.KeyCode.G then
        toggleFly() -- fly
    end
end)