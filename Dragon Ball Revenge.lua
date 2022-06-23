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

local function PlaceTP(PlaceID)
    game:GetService("TeleportService"):Teleport(PlaceID, LocalPlayer)
end

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

--[[
    Remote Blocker

local BlockedRemotes = {""}

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
]]

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Urbanstorms/Asterisk-Hub/main/Lib.lua"))()
local Menu = Material.Load({
    Title = "Asterisk Hub | Dragon Ball Revenge",
    Style = 1,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark"
})
local Main = Menu.New({
    Title = "Normal Farms"
})

local B = Main.Toggle({
    Text = "Auto Melee",
    Callback = function(Value)
        AMelee = Value
        local maxIterations = 2
        local iterations = 0
        while AMelee do
            iterations = iterations + 1
            if iterations == maxIterations then
                game:GetService("ReplicatedStorage").Grigora.Host.Remotes.Combat:FireServer(0)
                task.wait()
                iterations = 0
            end
        end
    end,
    Enabled = false
})

local B = Main.Toggle({
    Text = "Auto Defense",
    Callback = function(Value)
        ADefense = Value
        local maxIterations = 2
        local iterations = 0
        while ADefense do
            iterations = iterations + 1
            if iterations == maxIterations then
                game:GetService("ReplicatedStorage").Grigora.Host.Remotes.Defense:FireServer(0)
                task.wait()
                iterations = 0
            end
        end
    end,
    Enabled = false
})

local B = Main.Toggle({
    Text = "Auto Energy",
    Callback = function(Value)
        AEnergy = Value
        local maxIterations = 2
        local iterations = 0
        while AEnergy do
            iterations = iterations + 1
            if iterations == maxIterations then
                game:GetService("ReplicatedStorage").Grigora.Host.Remotes.KiBlast:FireServer(0, 0, Vector3.new())
                task.wait()
                iterations = 0
            end
        end
    end,
    Enabled = false
})

local Misc = Menu.New({
    Title = "Misc"
})
local B = Misc.Toggle({
    Text = "Hide Overhead",
    Callback = function(Value)
        HideName = Value
        while HideName do
            task.wait()
            pcall(function()
                if game:GetService("Players").LocalPlayer.Character.Head.PlayerUI.Enabled == true then
                    game:GetService("Players").LocalPlayer.Character.Head.PlayerUI.Enabled = false
                end
            end)
        end
    end,
    Enabled = false
})

SelForm = nil
local D = Misc.Dropdown({
	Text = "Form Selector",
	Callback = function(Value)
        SelForm = Value
        local args = {
            [1] = {
                [1] = {
                    [1] = SelForm,
                    [2] = 0,
                    [3] = 0,
                    [4] = 0
                },
                [2] = "Modes"
            }
        }
        
        game:GetService("ReplicatedStorage")._BindableEvents.RequestSkill:InvokeServer(unpack(args))
        task.wait(0.5)
        local args = {
            [1] = {
                ["Humanoid"] = game:GetService("Players").LocalPlayer.Character.Humanoid,
                ["Head"] = game:GetService("Players").LocalPlayer.Character.Head,
                ["UpperTorso"] = game:GetService("Players").LocalPlayer.Character.UpperTorso,
                ["HumanoidRootPart"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
                ["Character"] = game:GetService("Players").LocalPlayer.Character
            },
            [2] = game:GetService("Players").LocalPlayer.Status.Mode,
            [3] = game:GetService("Players").LocalPlayer.Status.ModeActive,
            [4] = game:GetService("Players").LocalPlayer.Status,
            [5] = false
        }
        
        game:GetService("ReplicatedStorage")._BindableEvents.Transform:InvokeServer(unpack(args))
        
	end,
	Options = {
        "Kaioken",
        "FSSJ",
        "SSJ",
        "SSJ2",
        "SSJ3",
        "SSJ4",
        "SSJG",
        "SSJB",
        "SSJR",
        "SSJBE",
        "UI",
        "MUI",
        "SSJR3",
        "GALAXY",
        "ZENO",
        "ZAIKO",
        "YAMOSHI",
        "Chronos",
        "Universe",
        "UltraEgo",
        "SSJ20K",
        "DemonPower",
        "More to Come"
	},
	Menu = {
		Information = function(self)
			Menu.Banner({
				Text = "Form Selector"
			})
		end
	}
})


SelPlace = nil
local D = Misc.Dropdown({
	Text = "Map Teleport",
	Callback = function(Value)
        SelPlace = Value
        if SelPlace == "Earth" then
            PlaceTP(9701414321)
        elseif SelPlace == "Gravity Chamber" then
            PlaceTP(9414933683)
        elseif SelPlace == "Time Chamber" then
            PlaceTP(7197495572)
        elseif SelPlace == "Supreme Kai World" then
            PlaceTP(9483239118)
        elseif SelPlace == "Bill's Planet" then
            PlaceTP(7197496527)
        elseif SelPlace == "Zeno Palace" then
            PlaceTP(8020433414)
        elseif SelPlace == "GOD TIME CHAMBER" then
            PlaceTP(7198416252)
        end
	end,
	Options = {
		"Earth",
		"Gravity Chamber",
		"Time Chamber",
		"Supreme Kai World",
		"Bill's Planet",
        "Zeno Palace",
        "GOD TIME CHAMBER"
	},
	Menu = {
		Information = function(self)
			Menu.Banner({
				Text = "Place Selector"
			})
		end
	}
})

local DBStuff = Menu.New({
    Title = "Dragon Ball Abuse"
})
local B = DBStuff.Toggle({
    Text = "Combat + Defense Wish Abuse",
    Callback = function(Value)
        CDAbuse = Value
        local maxIterations = 1
        local iterations = 0
        while CDAbuse do
            iterations = iterations + 1
            if iterations == maxIterations then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Map.DBS.DB.DB1.Position + Vector3.new(0, 3, 0)) * CFrame.Angles(math.rad(0), 0, 0)
                noclip()
                fireproximityprompt(game:GetService("Workspace").Map.DBS.DB.DB1.ProximityPrompt)
                game:GetService("ReplicatedStorage").PublicModules.Eventos.Pidio:InvokeServer("Attack")
                task.wait()
                iterations = 0
            end
        end
    end,
    Enabled = false
})


local B = DBStuff.Toggle({
    Text = "Speed + Energy Wish Abuse",
    Callback = function(Value)
        SEAbuse = Value
        local maxIterations = 1
        local iterations = 0
        while SEAbuse do
            iterations = iterations + 1
            if iterations == maxIterations then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Map.DBS.DB.DB1.Position + Vector3.new(0, 3, 0)) * CFrame.Angles(math.rad(0), 0, 0)
                noclip()
                fireproximityprompt(game:GetService("Workspace").Map.DBS.DB.DB1.ProximityPrompt)
                game:GetService("ReplicatedStorage").PublicModules.Eventos.Pidio:InvokeServer("Ki")
                task.wait()
                iterations = 0
            end
        end
    end,
    Enabled = false
})


local B = DBStuff.Toggle({
    Text = "Zenni Wish Abuse",
    Callback = function(Value)
        ZAbuse = Value
        local maxIterations = 1
        local iterations = 0
        while ZAbuse do
            iterations = iterations + 1
            if iterations == maxIterations then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Map.DBS.DB.DB1.Position + Vector3.new(0, 3, 0)) * CFrame.Angles(math.rad(0), 0, 0)
                noclip()
                fireproximityprompt(game:GetService("Workspace").Map.DBS.DB.DB1.ProximityPrompt)
                game:GetService("ReplicatedStorage").PublicModules.Eventos.Pidio:InvokeServer("Zenni")
                task.wait()
                iterations = 0
            end
        end
    end,
    Enabled = false
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
