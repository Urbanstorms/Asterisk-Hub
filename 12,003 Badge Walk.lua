rconsoleprint([[
  /$$$$$$              /$$                         /$$           /$$             /$$   /$$           /$$      
 /$$__  $$            | $$                        |__/          | $$            | $$  | $$          | $$      
| $$  \ $$  /$$$$$$$ /$$$$$$    /$$$$$$   /$$$$$$  /$$  /$$$$$$$| $$   /$$      | $$  | $$ /$$   /$$| $$$$$$$ 
| $$$$$$$$ /$$_____/|_  $$_/   /$$__  $$ /$$__  $$| $$ /$$_____/| $$  /$$/      | $$$$$$$$| $$  | $$| $$__  $$
| $$__  $$|  $$$$$$   | $$    | $$$$$$$$| $$  \__/| $$|  $$$$$$ | $$$$$$/       | $$__  $$| $$  | $$| $$  \ $$
| $$  | $$ \____  $$  | $$ /$$| $$_____/| $$      | $$ \____  $$| $$_  $$       | $$  | $$| $$  | $$| $$  | $$
| $$  | $$ /$$$$$$$/  |  $$$$/|  $$$$$$$| $$      | $$ /$$$$$$$/| $$ \  $$      | $$  | $$|  $$$$$$/| $$$$$$$/
|__/  |__/|_______/    \___/   \_______/|__/      |__/|_______/ |__/  \__/      |__/  |__/ \______/ |_______/                                                                              
]])
rconsoleprint(".\n")
task.wait(0.5)
rconsoleprint("..\n")
task.wait(0.5)
rconsoleprint("...\n")
task.wait(0.5)
rconsoleprint("....\n")
task.wait(0.5)
rconsoleprint(".....\n")
task.wait(0.5)
rconsoleprint("Starting!\n")
task.wait(0.5)
for i=1, 12003 do
    task.wait(0.01)
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game.Workspace[i].Platform, 0) --0 is touch
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game.Workspace[i].Platform, 1) -- 1 is untouch
    rconsoleprint(i)
    rconsoleprint(" - Success!\n")
end
rconsoleprint("Done!")
