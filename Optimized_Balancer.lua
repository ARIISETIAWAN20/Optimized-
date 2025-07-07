-- 🔧 Optimized CPU-GPU Balancer (Silent Version)
-- ✅ Tanpa UI | Cocok untuk Delta Mobile / Snapdragon

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- 🧠 Garbage Collector berkala
task.spawn(function()
    while true do
        collectgarbage("collect")
        task.wait(5)
    end
end)

-- 🛑 Matikan Partikel & Trail visual berat
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Enabled = false
    end
end

-- 🚀 Tween GPU Utility (bisa dipakai dari script lain)
_G.TweenTo = function(obj, goal, time)
    local tween = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Sine), goal)
    tween:Play()
end

-- 🖼️ UI Text Update Ringan (update per detik, bukan per frame)
_G.UpdateTextSafe = function(label, content)
    if typeof(label) == "Instance" and label:IsA("TextLabel") then
        task.spawn(function()
            while true do
                label.Text = content()
                task.wait(1)
            end
        end)
    end
end

-- ✅ Optimizer aktif secara pasif tanpa UI
