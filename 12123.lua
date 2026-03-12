local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local DAMAGE = 100000000
local RANGE = 200

local killAura = false
local flying = false

-- 🐉 DRAGON FIRE BREATH
function fireBreath()

    for i = 1,20 do

        local fire = Instance.new("Part")
        fire.Size = Vector3.new(6,6,12)
        fire.Material = Enum.Material.Neon
        fire.BrickColor = BrickColor.new("Bright orange")
        fire.CanCollide = false
        fire.CFrame = root.CFrame * CFrame.new(0,0,-8)
        fire.Parent = workspace

        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.Velocity = root.CFrame.LookVector * 200
        bodyVel.MaxForce = Vector3.new(999999,999999,999999)
        bodyVel.Parent = fire

        fire.Touched:Connect(function(hit)
            local hum = hit.Parent:FindFirstChild("Humanoid")
            if hum and hit.Parent ~= char then
                hum:TakeDamage(DAMAGE)
            end
        end)

        game.Debris:AddItem(fire,2)

        task.wait(0.05)

    end

end

-- ⚔ KILL AURA
RunService.RenderStepped:Connect(function()

    if not killAura then return end

    for _,enemy in pairs(workspace:GetDescendants()) do
        if enemy:IsA("Humanoid") and enemy.Parent ~= char then

            local hrp = enemy.Parent:FindFirstChild("HumanoidRootPart")

            if hrp then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist <= RANGE then
                    enemy:TakeDamage(DAMAGE)
                end
            end

        end
    end

end)

-- 💨 DRAGON FLY
function toggleFly()

    flying = not flying

    if flying then

        humanoid:ChangeState(Enum.HumanoidStateType.Physics)

        local bv = Instance.new("BodyVelocity")
        bv.Name = "DragonFly"
        bv.Velocity = Vector3.new(0,150,0)
        bv.MaxForce = Vector3.new(999999,999999,999999)
        bv.Parent = root

    else

        if root:FindFirstChild("DragonFly") then
            root.DragonFly:Destroy()
        end

    end

end

-- 🎮 TUGMALAR
UIS.InputBegan:Connect(function(input)

    if input.KeyCode == Enum.KeyCode.F then
        fireBreath()
    end

    if input.KeyCode == Enum.KeyCode.K then
        killAura = not killAura
        print("Kill Aura:", killAura)
    end

    if input.KeyCode == Enum.KeyCode.G then
        toggleFly()
    end

end)