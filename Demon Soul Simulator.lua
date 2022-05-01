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
-- Custom tween func & noclip + antifall.
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

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/Lib.lua"))()
local Menu = Material.Load({
    Title = "Urban Hub | Demon Soul Simulator",
    Style = 1,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark"
})
local Main = Menu.New({
    Title = "Main"
})

---

local A = Main.Toggle({
    Text = "Auto Souls",
    Callback = function(t)
        AutoS = t
        while AutoS do
            task.wait()
            pcall(function()
                for i, v in pairs(workspace.Souls:GetDescendants()) do
                    if v:IsA("TouchTransmitter") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0) -- 0 is touch
                        task.wait()
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1) -- 1 is untouch
                    end
                end
            end)
        end
    end,
    Enabled = false
})

local B = Main.Toggle({
    Text = "Auto Punch + Skills",
    Callback = function(t)
        AutoP = t
        local Skills_table = {1, 2, 3}
        local maxIterations = 5
        local iterations = 0
        while AutoP do
            pcall(function()
                iterations = iterations + 1
                if iterations == maxIterations then
                    task.spawn(function()
                        game:GetService("ReplicatedStorage").RemoteEvents.GeneralAttack:FireServer()
                        for i, v in next, Skills_table do
                            task.wait()
                            game:GetService("ReplicatedStorage").RemoteEvents.SkillAttack:FireServer(v)
                        end
                    end)
                    task.wait()
                    iterations = 0
                end
            end)
        end
    end,
    Enabled = false
})

local B = Main.Toggle({
    Text = "Autofarm level",
    Callback = function(t)
        Autofarm = t
        game:GetService("Players").LocalPlayer.PlayerGui.MainUi.BossDamageFrame.Visible = true
        while Autofarm do
            task.wait()
            pcall(function()
                if SelLeve == 'Level ' .. M0b then
                    for i, v in pairs(game:GetService("Workspace").GhostPos['Leve' .. M0b]:GetDescendants()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                            repeat
                                wait()
                                moveto(v.HumanoidRootPart.CFrame + Vector3.new(0, 0, Distance), 600)
                            until v.Humanoid.Health <= 0 or Autofarm == false
                        end
                    end
                elseif SelLeve == "Boss" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(443, 39, 758)
                end
            end)
        end
    end,
    Enabled = false
})

local D = Main.Dropdown({
    Text = "Selected Level",
    Callback = function(t)
        SelLeve = t
        if SelLeve == "Level 1" then
            M0b = "1"
        elseif SelLeve == "Level 2" then
            M0b = "2"
        elseif SelLeve == "Level 3" then
            M0b = "3"
        elseif SelLeve == "Level 4" then
            M0b = "4"
        elseif SelLeve == "Level 5" then
            M0b = "5"
        elseif SelLeve == "Level 6" then
            M0b = "6"
        elseif SelLeve == "Level 7" then
            M0b = "7"
        elseif SelLeve == "Level 8" then
            M0b = "8"
        end
    end,
    Options = {"Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Level 6", "Level 7", "Level 8", "Boss"},
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Level Selector"
            })
        end
    }
})

local C = Main.Slider({
    Text = "Distance",
    Callback = function(t)
        Distance = t
    end,
    Min = 0,
    Max = 20,
    Def = 2
})

local Misc = Menu.New({
    Title = "Misc"
})

local A = Misc.Button({
    Text = "Redeem codes",
    Callback = function()
        local Codes_table = {"demonsoul", "demon", "Welcome", "liangzai20klikes", "adou6000likes", "thanks3000likes",
                             "1000likes"}
        for i, v in next, Codes_table do
            task.wait()
            game:GetService("ReplicatedStorage").RemoteEvents.Code:FireServer(v)
        end
    end,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Redeem's all working codes for you."
            })
        end
    }
})

local B = Misc.Toggle({
    Text = "Hide name",
    Callback = function(t)
        HideNamee = t
        while HideNamee do
            wait()
            pcall(function()
                if game.Players.LocalPlayer.Character.Head.PlayerHeadUI.Enabled == true then
                    game.Players.LocalPlayer.Character.Head.PlayerHeadUI.Enabled = false
                end
            end)
        end
    end,
    Enabled = false
})

local B = Misc.Toggle({
    Text = "Auto Draw",
    Callback = function(t)
        AutoD = t
        while AutoD do
            task.wait(2)
            pcall(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(89, 41, -448)
                local args = {
                    [1] = true
                }
                game:GetService("ReplicatedStorage").RemoteEvents.DrawRole:FireServer(unpack(args))
                task.wait(1)
                game:GetService("ReplicatedStorage").RemoteEvents.StopAutoDrawRole:FireServer()
            end)
        end
    end,
    Enabled = false
})

local B = Misc.Toggle({
    Text = "Auto Chest",
    Callback = function(t)
        AutoC = t
        while AutoC do
            task.wait(0.1)
            pcall(function()
                for i, v in pairs(game:GetService("Workspace").ChestPoints:GetDescendants()) do
                    if v:IsA("TouchTransmitter") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0) -- 0 is touch
                        task.wait()
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1) -- 1 is untouch
                    end
                end
            end)
        end
    end,
    Enabled = false
})

local B = Misc.Toggle({
    Text = "Auto Dispatch",
    Callback = function(t)
        DispatchFarm = t
        while DispatchFarm do
            task.wait(60)
            pcall(function()
                local DispatchNumbers = {20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1}
                for i, v in next, DispatchNumbers do
                    task.wait()
                    game:GetService("ReplicatedStorage").RemoteEvents.Dispatch:FireServer(v)
                    game:GetService("ReplicatedStorage").RemoteEvents.ReceiveDispatchReward:FireServer(v)
                end
            end)
        end
    end,
    Enabled = false,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Auto collects & send them out on missions"
            })
        end
    }
})

local Teleports = Menu.New({
    Title = "Teleports"
})

local A = Teleports.Button({
    Text = "Spawn",
    Callback = function()
        game:GetService("ReplicatedStorage").RemoteEvents.ToBossArea:FireServer(false)
    end,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Teleports you"
            })
        end
    }
})

local A = Teleports.Button({
    Text = "Boss Area",
    Callback = function()
        game:GetService("ReplicatedStorage").RemoteEvents.ToBossArea:FireServer(true)
    end,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Teleports you"
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
