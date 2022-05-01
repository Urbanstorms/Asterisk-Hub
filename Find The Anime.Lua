--[[
 /$$   /$$           /$$                                 /$$   /$$           /$$      
| $$  | $$          | $$                                | $$  | $$          | $$      
| $$  | $$  /$$$$$$ | $$$$$$$   /$$$$$$  /$$$$$$$       | $$  | $$ /$$   /$$| $$$$$$$ 
| $$  | $$ /$$__  $$| $$__  $$ |____  $$| $$__  $$      | $$$$$$$$| $$  | $$| $$__  $$
| $$  | $$| $$  \__/| $$  \ $$  /$$$$$$$| $$  \ $$      | $$__  $$| $$  | $$| $$  \ $$
| $$  | $$| $$      | $$  | $$ /$$__  $$| $$  | $$      | $$  | $$| $$  | $$| $$  | $$
|  $$$$$$/| $$      | $$$$$$$/|  $$$$$$$| $$  | $$      | $$  | $$|  $$$$$$/| $$$$$$$/
\______/ |__/      |_______/  \_______/|__/  |__/      |__/  |__/ \______/ |_______/                                                                                 
]]
--[[
 /$$   /$$           /$$                                 /$$   /$$           /$$      
| $$  | $$          | $$                                | $$  | $$          | $$      
| $$  | $$  /$$$$$$ | $$$$$$$   /$$$$$$  /$$$$$$$       | $$  | $$ /$$   /$$| $$$$$$$ 
| $$  | $$ /$$__  $$| $$__  $$ |____  $$| $$__  $$      | $$$$$$$$| $$  | $$| $$__  $$
| $$  | $$| $$  \__/| $$  \ $$  /$$$$$$$| $$  \ $$      | $$__  $$| $$  | $$| $$  \ $$
| $$  | $$| $$      | $$  | $$ /$$__  $$| $$  | $$      | $$  | $$| $$  | $$| $$  | $$
|  $$$$$$/| $$      | $$$$$$$/|  $$$$$$$| $$  | $$      | $$  | $$|  $$$$$$/| $$$$$$$/
\______/ |__/      |_______/  \_______/|__/  |__/       |__/  |__/ \______/ |_______/                                                                                 
]] -- Custom tween func & noclip + antifall.
local TweenService = game:GetService("TweenService")
local noclipE = true
local antifall = true

local function noclip()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide == true then
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end
    end
end

local function moveto(obj, speed)
    local info = TweenInfo.new(
        ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - obj.Position).Magnitude) / speed,
        Enum.EasingStyle.Linear)
    local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {
        CFrame = obj
    })

    if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
        antifall = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
        antifall.Velocity = Vector3.new(0, 0, 0)
        noclipE = game:GetService("RunService").Stepped:Connect(noclip)
        tween:Play()
    end

    tween.Completed:Connect(function()
        antifall:Destroy()
        noclipE:Disconnect()
    end)
end

-----Functions end

--Auto Render
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5, 197, 354)
task.wait(2)--
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-744, 79, -94)
task.wait(2)--
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-657, 67, -446)
task.wait(2)--
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-259, 94, -676)
task.wait(2)--
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(229, 164, -621)
task.wait(2)--
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(653, 64, -311)
task.wait(2)--
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 19, 70)

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/Lib.lua"))()
local Menu = Material.Load({
    Title = "Urban Hub | Find The Anime",
    Style = 1,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark"
})
local Main = Menu.New({
    Title = "Main"
})

---
Poggers = 282

local A = Main.Toggle({
    Text = "Auto Collect & Rebirth",
    Callback = function(t)
        AutoRebCol = t
        while AutoRebCol do
            task.wait(1)
            for i = 1, Poggers do
                task.wait()
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game.Workspace.Fighters[i], 0) -- 0 is touch
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game.Workspace.Fighters[i], 1) -- 1 is untouch
            end
            task.wait(0.5)
            local Numbs = {13, 12}
            for i, v in next, Numbs do
                task.wait()
                game:GetService("ReplicatedStorage").RemoteFunction.clientRequestServer:InvokeServer(v)
            end
        end
    end,
    Enabled = false
})

local A = Main.Button({
    Text = "Collect All",
    Callback = function()
        for i = 1, Poggers do
            task.wait()
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game.Workspace.Fighters[i], 0) -- 0 is touch
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game.Workspace.Fighters[i], 1) -- 1 is untouch
        end
    end,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Collect's all characters."
            })
        end
    }
})

local A = Main.Button({
    Text = "Rebirth",
    Callback = function()
        local Numbs = {13, 12}
        for i, v in next, Numbs do
            task.wait()
            game:GetService("ReplicatedStorage").RemoteFunction.clientRequestServer:InvokeServer(v)
        end
    end,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Resets your collected characters and adds 1 rebirth!"
            })
        end
    }
})

local Credits = Menu.New({
    Title = "Credits"
})

local A = Credits.Button({
    Text = "Urbanstorm#2189 | Scriper | Urban Hub Creator | Daddy",
    Callback = function()
        pcall(function()
            setclipboard("https://discord.gg/NZpS6ugu8X")
        end)
    end
})
local A = Credits.Button({
    Text = "My Discord: https://discord.gg/NZpS6ugu8X",
    Callback = function()
        pcall(function()
            setclipboard("https://discord.gg/NZpS6ugu8X")
        end)
    end
})
local A = Credits.Button({
    Text = "Click to here copy discord link.",
    Callback = function()
        pcall(function()
            setclipboard("https://discord.gg/NZpS6ugu8X")
        end)
    end
})


