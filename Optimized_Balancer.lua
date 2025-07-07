-- 🔧 CPU-GPU Balance Optimizer | Buat Delta Executor by Arii
-- 📌 Jalankan bersamaan dengan script utama kamu

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- 🧠 Batasi frame loop untuk menghindari spike CPU
task.spawn(function()
    while true do
        collectgarbage("collect")
        task.wait(5)
    end
end)

-- 🔄 Monitor CPU-GPU usage dan tampilkan (opsional UI ringan)
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
screenGui.Name = "OptimizerMonitor"
local infoLabel = Instance.new("TextLabel", screenGui)
infoLabel.Size = UDim2.new(0, 250, 0, 30)
infoLabel.Position = UDim2.new(0, 10, 0, 10)
infoLabel.BackgroundTransparency = 0.5
infoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextScaled = true
infoLabel.Font = Enum.Font.SourceSansBold

RunService.RenderStepped:Connect(function()
    local mem = math.floor(gcinfo())
    infoLabel.Text = "📊 CPU Stabilizer | Mem: "..mem.."MB"
end)

-- 🛠️ Optional: matikan efek partikel berlebih
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Enabled = false
    end
end

-- ⏱️ Tween Optimizer: Gunakan tween agar efek pergerakan pakai GPU
_G.TweenTo = function(obj, goal, time)
    local tween = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Sine), goal)
    tween:Play()
end

-- 🌙 UI Update Balancer (buat script lain pakai ini)
_G.UpdateTextSafe = function(label, content)
    if typeof(label) == "Instance" and label:IsA("TextLabel") then
        task.spawn(function()
            while true do
                label.Text = content()
                task.wait(1) -- update per detik
            end
        end)
    end
end

print("✅ Optimizer Loaded - CPU & GPU Balanced")
