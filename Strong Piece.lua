--[[
 /$$   /$$           /$$                                 /$$   /$$           /$$      
| $$  | $$          | $$                                | $$  | $$          | $$      
| $$  | $$  /$$$$$$ | $$$$$$$   /$$$$$$  /$$$$$$$       | $$  | $$ /$$   /$$| $$$$$$$ 
| $$  | $$ /$$__  $$| $$__  $$ |____  $$| $$__  $$      | $$$$$$$$| $$  | $$| $$__  $$
| $$  | $$| $$  \__/| $$  \ $$  /$$$$$$$| $$  \ $$      | $$__  $$| $$  | $$| $$  \ $$
| $$  | $$| $$      | $$  | $$ /$$__  $$| $$  | $$      | $$  | $$| $$  | $$| $$  | $$
|  $$$$$$/| $$      | $$$$$$$/|  $$$$$$$| $$  | $$      | $$  | $$|  $$$$$$/| $$$$$$$/
\______/ |__/      |_______/  \_______/|__/  |__/      |__/  |__/ \______/ |_______/                                                                                 
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

-- Functions end

-- Tables
local tool_table = {};
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
    if v:IsA("Tool") then
        table.insert(tool_table, v.Name)
    end
end

local mob_table = {};
for i, v in pairs(game:GetService("Workspace").World.Monsters:GetDescendants()) do
    if not table.find(mob_table, v.Name) and string.match(v.Name, "Level") then
        table.sort(mob_table)
        table.insert(mob_table, v.name)
    end
end

local Quest = {};
for i, v in pairs(game:GetService("Workspace").World.NPCS.Quests:GetDescendants()) do
    if not table.find(Quest, v.Name) and string.match(v.Name, "Quest") then
        table.sort(Quest)
        table.insert(Quest, v.Name)
    end
end

local BlockedRemotes = {"Swim"}

local Events = {
    Fire = true,
    Invoke = true,
    FireServer = true,
    InvokeServer = true
}

local gameMeta = getrawmetatable(game)
local psuedoEnv = {
    ["__index"] = gameMeta.__index,
    ["__namecall"] = gameMeta.__namecall
}
setreadonly(gameMeta, false)
gameMeta.__index, gameMeta.__namecall = newcclosure(function(self, index, ...)
    if Events[index] then
        for i, v in pairs(BlockedRemotes) do
            if v == self.Name and not checkcaller() then
                return nil
            end
        end
    end
    return psuedoEnv.__index(self, index, ...)
end)
setreadonly(gameMeta, true)

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/Lib.lua"))()
local Menu = Material.Load({
    Title = "Urban Hub | Strong Piece",
    Style = 1,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark"
})
local Main = Menu.New({
    Title = "Main"
})
-- Tool Shit
SelectedWeapon = "Combat"

local D = Main.Dropdown({
    Text = "Selected Weapon",
    Callback = function(SelectedOption)
        SelectedWeapon = SelectedOption
    end,
    Options = tool_table,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Select the tool you'd like to use."
            })
        end
    }
})

local B = Main.Toggle({
    Text = "Auto-Equip",
    Callback = function(Value)
        AEquip = Value
        while AEquip do
            task.wait()
            pcall(function()
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == SelectedWeapon then
                        task.wait(0.5)
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
            end)
        end
    end,
    Enabled = false
})

local B = Main.Toggle({
    Text = "Auto hit",
    Callback = function(Value)
        Ahit = Value
        while Ahit do
            task.wait()
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
                end
            end)
        end
    end,
    Enabled = false
})

local D = Main.Dropdown({
    Text = "Mobs",
    Callback = function(Value)
        Mobz = Value
    end,
    Options = mob_table,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Select the mob you wish to farm."
            })
        end
    }
})

local D = Main.Dropdown({
    Text = "Quest",
    Callback = function(Value)
        SelectedQuest = Value
    end,
    Options = Quest,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Select the quest you wish to farm."
            })
        end
    }
})

SelectedQuest = "BanditQuest"
Mobz = "Bandit [Level 5]"

local A = Main.Toggle({
    Text = "Start farm",
    Callback = function(Value)
        Autofarm = Value
        while Autofarm do
            pcall(function()
                if game.Players.LocalPlayer.PlayerGui.QuestGui.Enabled == false then
                    for i, v in pairs(game:GetService("Workspace").World.NPCS.Quests:GetDescendants()) do
                        if v.Name == SelectedQuest then
                            repeat
                                noclip()
                                moveto(v.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(-90), 0, 0) +
                                           Vector3.new(0, 7, 0), TSpeed)
                                noclip()
                                fireproximityprompt(v.Proximity)
                                task.wait()
                            until game.Players.LocalPlayer.PlayerGui.QuestGui.Enabled == true or not Autofarm
                        end
                    end
                elseif game.Players.LocalPlayer.PlayerGui.QuestGui.Enabled == true then
                    task.wait(1)
                    for i, v in pairs(game:GetService("Workspace").World.Monsters:GetChildren()) do
                        if v.Name == Mobz then
                            repeat
                                noclip()
                                moveto(v.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(-90), 0, 0) +
                                           Vector3.new(0, Distance, 0), TSpeed)
                                noclip()
                                task.wait()
                            until game.Players.LocalPlayer.PlayerGui.QuestGui.Enabled == false or v.Humanoid.Health <= 0 or
                                not Autofarm
                        end
                    end
                end
            end);
        end
    end,
    Enabled = false
})

TSpeed = 500
local C = Main.Slider({
    Text = "Tween Speed",
    Callback = function(Value)
        TSpeed = (Value)
    end,
    Min = 100,
    Max = 1000,
    Def = 500
})

Distance = 7
local C = Main.Slider({
    Text = "Distance",
    Callback = function(Value)
        Distance = (Value)
    end,
    Min = 0,
    Max = 20,
    Def = 7
})

local Extra = Menu.New({
    Title = "Extras"
})

local A = Extra.Button({
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

KillHealth = 50
local A = Extra.Button({
    Text = "Faster-kill (Buggy as fuck, don't reccomend but your choice.)",
    Callback = function()
        local connections = {}
        function hot(mob)
            if not connections[mob] and not game.Players:FindFirstChild(mob.Parent.Name) then
                connections[mob] = mob:GetPropertyChangedSignal("Health"):Connect(function()
                    if (mob.Health / mob.MaxHealth * 100) < KillHealth then
                        for i = 1, 20 do
                            mob.Health = 0
                        end
                    end
                end)
            end
        end
        for i, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Humanoid") and v.Parent.Name ~= game.Players.LocalPlayer.Name then
                hot(v)
            end
        end
        workspace.DescendantAdded:Connect(function(v)
            if v:IsA("Humanoid") then
                hot(v)
            end
        end)
    end,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Instantly kills any enemy. (if you have network ownership over that mob, otherwise it will just break the autofarm so its best used in a private server.)"
            })
        end
    }
})
local C = Extra.Slider({
    Text = "Kill when health at this percentage. (Set before clicking button) ^^",
    Callback = function(Value)
        KillHealth = (Value)
    end,
    Min = 1,
    Max = 99,
    Def = 50
})

local B = Extra.Toggle({
    Text = "Fruit Sniper",
    Callback = function(t)
        fruitsniper = t
        while fruitsniper do
            wait()
            pcall(function()
                for i, v in pairs(game.Workspace:GetChildren()) do
                    if v:IsA("Tool") then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
            end)
        end
    end,
    Enabled = false
})

--[[Old Fruit Sniper
local B = Extra.Toggle({
    Text = "Fruit Sniper",
    Callback = function(t)
        Fruit_Sniper = t
        while Fruit_Sniper do task.wait()
            pcall(function()
                for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v:IsA("Tool") then
                            --moveto(v.Handle.CFrame * CFrame.Angles(math.rad(-90), 0, 0) + Vector3.new(0, 0, 0), TSpeed)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0) --0 is touch
                            task.wait()
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 1) -- 1 is untouch
                    end
                end
            end)
        end
    end,
    Enabled = false
})
]]

local A = Extra.Button({
    Text = "Open Inventory",
    Callback = function()
        pcall(function()
            fireclickdetector(game:GetService("Workspace").World.NPCS.Inventorys.Inventory.ClickDetector)
        end)
    end
})

---

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
