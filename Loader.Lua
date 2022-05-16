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
local function DiscordInviter(DiscordCode)

    pcall(function()
        -- Urban Hub Auto joiner
        local JSONEncode, JSONDecode, GenerateGUID = game.HttpService.JSONEncode, game.HttpService.JSONDecode,
            game.HttpService.GenerateGUID
        local Request = syn and syn.request or request
        Request({
            Url = "http://127.0.0.1:6463/rpc?v=1",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Origin"] = "https://discord.com"
            },
            Body = JSONEncode(game.HttpService, {
                cmd = "INVITE_BROWSER",
                args = {
                    code = DiscordCode
                },
                nonce = GenerateGUID(game.HttpService, false)
            })
        })
    end)
end

local shitsngiggles = loadstring(game:HttpGet('https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/*************.lua'))()

local function LoadScript(ScriptString)
    loadstring(game:HttpGet((ScriptString), true))()
end

if shitsngiggles[getgenv().UrbanKey] then
    if game.GameId == 3471372453 then -- Find The Anime
        LoadScript('https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/Find%20The%20Anime.Lua')
        DiscordInviter("NZpS6ugu8X")
    elseif game.GameId == 3108473052 then
        LoadScript('https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/Demon%20Soul%20Simulator.lua')
        DiscordInviter("NZpS6ugu8X")
    elseif game.GameId == 1800603069 then
        LoadScript('https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/12%2C003%20Badge%20Walk.lua')
        DiscordInviter("NZpS6ugu8X")
    elseif game.GameId == 2719512531 then
        LoadScript('https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/Reaper%202.lua')
        DiscordInviter("NZpS6ugu8X")
    elseif game.GameId == 2639872821 then
        LoadScript('https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/JoJo%3A%20Golden%20Records.lua')
        DiscordInviter("NZpS6ugu8X")
    elseif game.GameId == 0 then
        LoadScript('')
        DiscordInviter("NZpS6ugu8X")
    elseif game.GameId == 0 then
        LoadScript('')
        DiscordInviter("NZpS6ugu8X")
    elseif game.GameId == 0 then
        LoadScript('')
        DiscordInviter("NZpS6ugu8X")
    else
        game.Players.LocalPlayer:Kick("Invalid Game")
        DiscordInviter("NZpS6ugu8X")
    end
else
    LoadScript('https://raw.githubusercontent.com/Urbanstorms/UrbanHub/main/KickScript.lua')
end
