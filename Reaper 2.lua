--[[
  /$$$$$$              /$$                         /$$           /$$             /$$   /$$           /$$      
 /$$__  $$            | $$                        |__/          | $$            | $$  | $$          | $$      
| $$  \ $$  /$$$$$$$ /$$$$$$    /$$$$$$   /$$$$$$  /$$  /$$$$$$$| $$   /$$      | $$  | $$ /$$   /$$| $$$$$$$ 
| $$$$$$$$ /$$_____/|_  $$_/   /$$__  $$ /$$__  $$| $$ /$$_____/| $$  /$$/      | $$$$$$$$| $$  | $$| $$__  $$
| $$__  $$|  $$$$$$   | $$    | $$$$$$$$| $$  \__/| $$|  $$$$$$ | $$$$$$/       | $$__  $$| $$  | $$| $$  \ $$
| $$  | $$ \____  $$  | $$ /$$| $$_____/| $$      | $$ \____  $$| $$_  $$       | $$  | $$| $$  | $$| $$  | $$
| $$  | $$ /$$$$$$$/  |  $$$$/|  $$$$$$$| $$      | $$ /$$$$$$$/| $$ \  $$      | $$  | $$|  $$$$$$/| $$$$$$$/
|__/  |__/|_______/    \___/   \_______/|__/      |__/|_______/ |__/  \__/      |__/  |__/ \______/ |_______/                                                                              
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

local Players = {};
for i,v in pairs(game.Players:GetChildren()) do
    table.insert(Players,v.Name)
end;

for i, v in next, getconnections(game.Players.LocalPlayer.Idled) do
    v:Disable();
end;

local plr = game:GetService("Players").LocalPlayer
local tweenService = game:GetService("TweenService")
getgenv().speed = 300
function toTarget(target)
    local speed = getgenv().speed
    local info = TweenInfo.new((target.Position - plr.Character.HumanoidRootPart.Position).Magnitude / speed, Enum.EasingStyle.Linear)
    local _, err = pcall(function()
        tweenService:Create(plr.Character.HumanoidRootPart, info, {CFrame = target}):Play()
    end)
    if err then error("Couldn't create/start tween: ", err) end
end
function newIndexHook()
    local mt = getrawmetatable(game)
    local oldIndex = mt.__newindex
    setreadonly(mt, false)
    mt.__newindex = newcclosure(function(self, i, v)
        if checkcaller() and self == plr.Character.HumanoidRootPart and i == 'CFrame' then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
            return toTarget(v) 
        end
        return oldIndex(self, i, v)
    end)

    setreadonly(mt, true)
end
newIndexHook()

game:GetService("RunService").Stepped:Connect(function()
if getgenv().Autofarm or getgenv().SP or getgenv().MenosFarm then
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide == true then
                 v.CanCollide = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end;
        end;
    end;
end);

local Mob = {};
getgenv().DIS = 6
for i,v in pairs(game:GetService("Workspace").Living:GetChildren()) do
if not table.find(Mob,v.Name) and not v:FindFirstChild("ClientHandler") and not v:FindFirstChild("xSIXxAnimationSaves") and not string.match(v.Name,"Masta") and v.Name ~= "Noob" then --//I'm so sorry you had to witness this i apolgize whoever sees this...
        table.sort(Mob) table.insert(Mob,v.name)
    end;
end;

local Quest = {};
for i,v in pairs(game:GetService("Workspace").NPCs:GetDescendants()) do
pcall(function()
if v.Name == ("Quest") and not v.Parent:FindFirstChild("xSIXxAnimationSaves") then
    if v.Value ~= "" and v.Value ~= "Test Quest" then
                table.sort(Quest) table.insert(Quest,v.Value)
            end;
        end;
    end);
end;

local NPC = {};
for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
if v:IsA("Model") and not v:FindFirstChild("xSIXxAnimationSaves") then
        table.sort(NPC) table.insert(NPC,v.Name)
    end;
end;

for i, v in next, getconnections(game.Players.LocalPlayer.Idled) do
    v:Disable();
end;

-----Functions end

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Urbanstorms/Asterisk-Hub/main/Loader.Lua"))()
local Menu = Material.Load({
    Title = "Asterisk Hub | Reaper 2",
    Style = 1,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark"
})
local Main = Menu.New({
    Title = "Main"
})

---
local B = Main.Toggle({
    Text = "Auto equip",
    Callback = function(Value)
        getgenv().Equip = Value
        while getgenv().Equip and wait(.3) do
            if game:GetService("Players").LocalPlayer.Status.Weapon.Value == nil then
                local a = {
                    [1] = {
                        ["inputType"] = Enum.UserInputType.Keyboard,
                        ["keyCode"] = Enum.KeyCode.E
                    }
                }
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(a))
            end
            if game:GetService("Players").Urbanstormy.Character.Saber == nil then
                local args = {
                    [1] = {
                        ["inputType"] = Enum.UserInputType.Keyboard,
                        ["keyCode"] = Enum.KeyCode.J
                    }
                }
                
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(args))                
            end
        end
    end,
    Enabled = false
})

local A = Main.Toggle({
    Text = "Autofarm",
    Callback = function(Value)
        getgenv().Autofarm = Value
        while getgenv().Autofarm and wait() do
            pcall(function()
                for i, v in pairs(game:GetService("Workspace").Living:GetChildren()) do
                    if game.Players.LocalPlayer.Character and v:FindFirstChild("HumanoidRootPart") and
                        v:FindFirstChild("Humanoid") then
                        if v.Name == getgenv().Mob and v.Humanoid.Health > 0 then
                            repeat
                                wait()
                                local args = {
                                    [1] = {
                                        ["inputType"] = Enum.UserInputType.MouseButton1,
                                        ["keyCode"] = Enum.KeyCode.Unknown
                                    }
                                }
                                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(args))
                                if not game:GetService("Workspace").Food:FindFirstChildWhichIsA("Part") or
                                    not game:GetService("Workspace").Food:FindFirstChildWhichIsA("MeshPart") and
                                    getgenv().AutoEat then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame - Vector3.new(0,getgenv().DIS, 0)
                                elseif not getgenv().Eat then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame - Vector3.new(0,getgenv().DIS, 0)
                                end
                            until v.Humanoid.Health <= 0 or not getgenv().Autofarm
                        end
                    end
                end
            end);
        end
    end,
    Enabled = false
})

local A = Main.Toggle({
    Text = "Auto quest",
    Callback = function(Value)
        getgenv().AutoQuest = Value
        while getgenv().AutoQuest and wait() do
            pcall(function()
                for i, v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if game:GetService("Players").LocalPlayer.PlayerGui.HUD:FindFirstChild("QuestsFrame2") then
                        if not game:GetService("Players").LocalPlayer.PlayerGui.HUD.QuestsFrame2:FindFirstChild(
                            getgenv().Quest) then
                            wait(2)
                            game:GetService("ReplicatedStorage").Remotes.TakeQuest:FireServer(getgenv().Quest)
                        end
                    end
                end
            end);
        end
    end,
    Enabled = false
})

local D = Main.Dropdown({
    Text = "Mobs",
    Callback = function(Value)
        getgenv().Mob = Value
    end,
    Options = Mob,
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
        getgenv().Quest = Value
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

local C = Main.Slider({
    Text = "Distance",
    Callback = function(Value)
        print(Value)
    end,
    Min = -20,
    Max = 20,
    Def = 6
})

local Misc = Menu.New({
    Title = "Misc"
})

local A = Misc.Toggle({
    Text = "Auto adjust mob",
    Callback = function(Value)
        if getgenv().Quest == "Op Killer" and Value then
            getgenv().OPK = true
            getgenv().AQ = false
        elseif getgenv().Quest == "Acquired Taste" and Value then
            getgenv().AQ = true
            getgenv().OPK = false
        end

        while getgenv().AQ and wait() do
            pcall(function()
                local wtf = game:GetService("Players").LocalPlayer.PlayerGui.HUD.QuestsFrame2["Acquired Taste"].Frame.Objective
                if string.match(wtf.Text, "Kill 1 Clawed") or string.match(wtf.Text, "Kill 2 Clawed") then
                    getgenv().Mob = "Clawed Hollow"
                elseif string.match(wtf.Text, "Kill 1 Winged") or string.match(wtf.Text, "Kill 2 Winged") and
                    string.match(wtf.Text, "Kill 0 Clawed") then
                    getgenv().Mob = "Winged Hollow"
                elseif string.match(wtf.Text, "Kill 1 Savage") and string.match(wtf.Text, "Kill 0 Clawed") and
                    string.match(wtf.Text, "Kill 0 Winged") then
                    getgenv().Mob = "Savage Hollow"
                end
            end);
        end

        while getgenv().OPK and wait() do
            pcall(function()
                local wtf2 = game:GetService("Players").LocalPlayer.PlayerGui.HUD.QuestsFrame2["Op Killer"].Frame
                                 .Objective
                if string.match(wtf2.Text, "Kill 1 Heavy") or string.match(wtf2.Text, "Kill 2 Heavy") then
                    getgenv().Mob = "Heavy Corrupted Kido Corps"
                elseif string.match(wtf2.Text, "Kill 1 Experienced") and string.match(wtf2.Text, "Kill 0 Heavy") then
                    getgenv().Mob = "Experienced Corrupted Shikai User"
                elseif string.match(wtf2.Text, "Kill 3 Corrupted") or string.match(wtf2.Text, "Kill 2 Corrupted") or
                    string.match(wtf2.Text, "Kill 1 Corrupted") and string.match(wtf2.Text, "Kill 0 Experienced") then
                    getgenv().Mob = "Corrupted Kido Corps"
                end
            end);
        end
    end,
    Enabled = false
})

local B = Misc.Toggle({
    Text = "Auto eat",
    Callback = function(Value)
        getgenv().Eat = Value
        while getgenv().Eat and wait() do
            pcall(function()
                for i, v in pairs(game:GetService("Workspace").Food:GetDescendants()) do
                    if v:FindFirstChild("ProximityPrompt") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame - Vector3.new(0, -5, 0)
                        fireproximityprompt(v.ProximityPrompt)
                    end
                end
            end);
        end
    end,
    Enabled = false
})

local B = Misc.Toggle({
    Text = "Instant teleport",
    Callback = function(Value)
        getgenv().InstaTP = Value
        if getgenv().InstaTP then
            getgenv().speed = 9e9
            game.Players.LocalPlayer.Name = "123imnotmomo"
        else
            getgenv().speed = 300
        end
    end,
    Enabled = false
})

local AutoSkill = Menu.New({
    Title = "Auto Skills"
})

local B = AutoSkill.Toggle({
    Text = "Skill 1",
    Callback = function(Value)
        getgenv().One = Value
        while getgenv().One and wait() do
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "One", false, game);
            wait(1)
            local a = {
                [1] = {
                    ["inputType"] = Enum.UserInputType.MouseButton1,
                    ["keyCode"] = Enum.KeyCode.Unknown
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(a))
        end
    end,
    Enabled = false
})

local B = AutoSkill.Toggle({
    Text = "Skill 2",
    Callback = function(Value)
        getgenv().Two = Value
        while getgenv().Two and wait() do
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Two", false, game);
            wait(1)
            local a = {
                [1] = {
                    ["inputType"] = Enum.UserInputType.MouseButton1,
                    ["keyCode"] = Enum.KeyCode.Unknown
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(a))
        end
    end,
    Enabled = false
})

local B = AutoSkill.Toggle({
    Text = "Skill 3",
    Callback = function(Value)
        getgenv().Three = Value
        while getgenv().Three and wait() do
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Three", false, game);
            wait(1)
            local a = {
                [1] = {
                    ["inputType"] = Enum.UserInputType.MouseButton1,
                    ["keyCode"] = Enum.KeyCode.Unknown
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(a))
        end
    end,
    Enabled = false
})

local B = AutoSkill.Toggle({
    Text = "Skill 4",
    Callback = function(Value)
        getgenv().Four = Value
        while getgenv().Four and wait() do
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Four", false, game);
            wait(1)
            local a = {
                [1] = {
                    ["inputType"] = Enum.UserInputType.MouseButton1,
                    ["keyCode"] = Enum.KeyCode.Unknown
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(a))
        end
    end,
    Enabled = false
})

local B = AutoSkill.Toggle({
    Text = "Skill 5",
    Callback = function(Value)
        getgenv().Five = Value
        while getgenv().Five and wait() do
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Five", false, game);
            wait(1)
            local a = {
                [1] = {
                    ["inputType"] = Enum.UserInputType.MouseButton1,
                    ["keyCode"] = Enum.KeyCode.Unknown
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(a))
        end
    end,
    Enabled = false
})

local OtherFarms = Menu.New({
    Title = "Other Farms"
})

local B = OtherFarms.Toggle({
    Text = "Menos farm",
    Callback = function(Value)
        getgenv().MenosFarm = Value
        while getgenv().MenosFarm and wait() do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (getgenv().MPos)
        end
    end,
    Enabled = false
})

local A = OtherFarms.Button({
    Text = "Set position",
    Callback = function()
        getgenv().MPos = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
    end,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Sets position"
            })
        end
    }
})

local D = OtherFarms.Dropdown({
    Text = "Stomp key",
    Callback = function(Value)
        getgenv().SKey = Value
    end,
    Options = SKey,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Select the key you stomp with."
            })
        end
    }
})

local B = OtherFarms.Toggle({
    Text = "Auto stomp",
    Callback = function(Value)
        getgenv().Stomp = Value
        while getgenv().Stomp and wait() do
            game:GetService("VirtualInputManager"):SendKeyEvent(true, getgenv().SKey, false, game);
            wait(1)
            local a = {
                [1] = {
                    ["inputType"] = Enum.UserInputType.MouseButton1,
                    ["keyCode"] = Enum.KeyCode.Unknown
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(a))
        end
    end,
    Enabled = false
})

local Teleports = Menu.New({
    Title = "Teleports"
})

local D = Teleports.Dropdown({
    Text = "NPC",
    Callback = function(Value)
        getgenv().NPCTP = Value
    end,
    Options = NPC,
    Menu = {
        Information = function(self)
            Menu.Banner({
                Text = "Select the NPC you wish to teleport to."
            })
        end
    }
})

local A = Teleports.Button({
    Text = "Teleport",
    Callback = function()
        pcall(function()
            for i, v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                if v.Name == getgenv().NPCTP then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                end
            end
        end);
    end
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
    Text = "10x#8397 | Original script creator | iusearchbtw.lol",
    Callback = function()
        pcall(function()
            setclipboard("iusearchbtw.lol")
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
