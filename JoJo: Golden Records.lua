--[[
 /$$   /$$           /$$                                 /$$   /$$           /$$      
| $$  | $$          | $$                                | $$  | $$          | $$      
| $$  | $$  /$$$$$$ | $$$$$$$   /$$$$$$  /$$$$$$$       | $$  | $$ /$$   /$$| $$$$$$$ 
| $$  | $$ /$$__  $$| $$__  $$ |____  $$| $$__  $$      | $$$$$$$$| $$  | $$| $$__  $$
| $$  | $$| $$  \__/| $$  \ $$  /$$$$$$$| $$  \ $$      | $$__  $$| $$  | $$| $$  \ $$
| $$  | $$| $$      | $$  | $$ /$$__  $$| $$  | $$      | $$  | $$| $$  | $$| $$  | $$
|  $$$$$$/| $$      | $$$$$$$/|  $$$$$$$| $$  | $$      | $$  | $$|  $$$$$$/| $$$$$$$/
\______/ |__/      |_______/  \_______/|__/  |__/       |__/  |__/ \______/ |_______/                                                                                 
]] local function LoadScript(ScriptString)
    loadstring(game:HttpGet((ScriptString), true))()
end

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
    Title = "Urban Hub | JoJo: Golden Records",
    Style = 1,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark"
})

-- Main Tab
local Main = Menu.New({
    Title = "Main"
})
local shithead = game.Players.LocalPlayer.Character

local A = Main.Button({
    Text = "Noclip Camera",
    Callback = function()
        pcall(function()
            for useless, garbage in next, getgc() do
                if getfenv(garbage).script ==
                    game.Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper and
                    typeof(garbage) == "function" then
                    for number, value in next, getconstants(garbage) do
                        if tonumber(value) == 0.25 then
                            setconstant(garbage, number, 0)
                        elseif tonumber(value) == 0 then
                            setconstant(garbage, number, 0.25)
                        end
                    end
                end
            end
        end)
    end
})

local B = Main.Toggle({
    Text = "Meteor Farm",
    Callback = function(t)
        Meteor_Farm = t
        while Meteor_Farm do
            task.wait()
            pcall(function()
                for i, v in pairs(game:GetService("Workspace")["Meteor Landing Spots"]:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then
                        fireproximityprompt(v)
                        task.wait(0.5)
                        v.Parent.Parent:Destroy()
                    end
                end
                for i, v in pairs(game:GetService("Workspace")["Meteor Landing Spots"]:GetDescendants()) do
                    if v:IsA("MeshPart") then
                        repeat
                            noclip()
                            task.wait()
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("MouseClick")
                            shithead.HumanoidRootPart.CFrame = CFrame.new(v.Position + Vector3.new(0, Distancem, 0))
                        until v.ObjectHealth.Value <= 0 or not Meteor_Farm
                    end
                end
            end)
        end
    end,
    Enabled = false
})

Distancem = 1
local C = Main.Slider({
    Text = "Meteor Farm Distance",
    Callback = function(t)
        Distancem = t
    end,
    Min = -20,
    Max = 20,
    Def = 1
})

local B = Main.Toggle({
    Text = "Rokakaka Farm",
    Callback = function(t)
        Rokakaka_Farm = t
        while Rokakaka_Farm do
            task.wait()
            pcall(function()
                for i, v in pairs(game:GetService("Workspace")["Rokakaka Trees"]:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then
                        repeat
                            shithead.HumanoidRootPart.CFrame = v.Parent.CFrame + Vector3.new(0, Distancer, 0)
                            task.wait()
                            fireproximityprompt(v)
                            task.wait(0.5)
                            v.Parent.Parent:Destroy()
                        until v.Parent == nil or not Rokakaka_Farm
                    end
                end
            end)
        end
    end,
    Enabled = false
})
Distancer = 3
local C = Main.Slider({
    Text = "Rokakaka Farm Distance",
    Callback = function(t)
        Distancer = t
    end,
    Min = -20,
    Max = 20,
    Def = 3
})

local B = Main.Toggle({
    Text = "Chest Farm - WIP (TPs to chest and opens only)",
    Callback = function(t)
        ChestFarm = t
        while ChestFarm do
            task.wait()
            pcall(function()
                for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v:IsA("Model") and string.match(v.Name, "Chest") then
                        for i2, v2 in pairs(v:GetDescendants()) do
                            if v2:IsA("ProximityPrompt") then
                                repeat
                                    shithead.HumanoidRootPart.CFrame = v2.Parent.CFrame + Vector3.new(0, 2, 0)
                                    task.wait()
                                    fireproximityprompt(v2)
                                    task.wait()
                                until v2.Parent == nil or not ChestFarm
                                task.wait()
                                for i3, v3 in pairs(game:GetService("Workspace"):GetChildren()) do
                                    if v3:IsA("Model") then
                                        for i4, v4 in pairs(v3:GetDescendants()) do
                                            if v4:FindFirstChilld("ProximityPrompt") then
                                                repeat
                                                    shithead.HumanoidRootPart.CFrame = v4.Parent.CFrame +
                                                                                           Vector3.new(0, 0, 0)
                                                    task.wait()
                                                    fireproximityprompt(v4)
                                                    task.wait(0.5)
                                                    v4.Parent.Parent:Destroy()
                                                until v4.Parent == nil or not ChestFarm
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end,
    Enabled = false
})

local B = Main.Toggle({
    Text = "Gold Coin Farm - WIP (May not be working)",
    Callback = function(t)
        GoldCoin_Farm = t
        while Rokakaka_Farm do
            task.wait()
            pcall(function()
                for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v:IsA("MeshPart") and v.Name == "Gold Coin" then
                        repeat
                            shithead.HumanoidRootPart.CFrame = v.Parent.CFrame + Vector3.new(0, 0, 0)
                            task.wait()
                            firetouchinterest(v)
                            task.wait(0.5)
                            v.Parent.Parent:Destroy()
                        until v.Parent == nil or not GoldCoin_Farm
                    end
                end
            end)
        end
    end,
    Enabled = false
})

-- Credits Tab
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
