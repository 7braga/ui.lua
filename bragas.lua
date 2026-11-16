
_G.shouldRuncli = true
_G.mvsdMainDebugging = false -- REMEMBER SET FALSE
if getgenv().executedScript and not _G.mvsdMainDebugging then
    print("you have already executed this, rejoin the server to re-execute")
    return
end
getgenv().executedScript = true
-- MvsdSupport1 removido (repo eliminado)
if not _G.mvsdMainDebugging then
    local Results = { Passed = 0, Failed = 0, Tests = {} }
    local function RunCheck(Index, Name, Func)
        local Success = pcall(Func)
        if Success then
            Results.Passed = Results.Passed + 1
            table.insert(Results.Tests, "[PASS ->]" .. Index .. ". " .. Name .. " check")
        else
            Results.Failed = Results.Failed + 1
            table.insert(Results.Tests, "[-> FAIL]" .. Index .. ". " .. Name .. " check")
        end
    end
    local InstanceCreator = Instance and Instance.new or nil;
    local NewCFrame = CFrame and CFrame.new or nil;
    local SanityCheckFinish = false
    task.spawn(function()
        RunCheck(1, "instance new", function()
            if typeof(InstanceCreator) ~= "function" then
                error()
            end
            local part = InstanceCreator("Part")
            if not part or not part:IsA("BasePart") then
                error()
            end
            part:Destroy()
        end)
        RunCheck(2, "cframe new", function()
            local cf = NewCFrame(1, 2, 3)
            if typeof(cf) ~= "CFrame" then
                error()
            end
            if cf.X ~= 1 or cf.Y ~= 2 or cf.Z ~= 3 then
                error()
            end
        end)
        RunCheck(3, "get service", function()
            local ok, players = pcall(game.GetService, game, "Players")
            if not ok or players ~= game.Players then
                error()
            end
        end)
        RunCheck(4, "vector3 new", function()
            local v = Vector3.new(4, 5, 6)
            if typeof(v) ~= "Vector3" then
                error()
            end
            if v.X ~= 4 or v.Y ~= 5 or v.Z ~= 6 then
                error()
            end
        end)
        RunCheck(5, "task functions", function()
            local SpawnFunc = task.spawn or spawn
            local WaitFunc = task.wait or wait
            if typeof(SpawnFunc) ~= "function" then
                error()
            end
            local ran = false
            SpawnFunc(function()
                ran = true
            end)
            WaitFunc(0.1)
            if not ran then
                error()
            end
        end)
        RunCheck(6, "tween service creation", function()
            local TweenService = game:GetService("TweenService")
            local part = Instance.new("Part")
            local tweenInfo = TweenInfo.new(0.1)
            local tween = TweenService:Create(part, tweenInfo, { Transparency = 1 })
            if not tween or typeof(tween.Play) ~= "function" then
                error()
            end
            part:Destroy()
        end)
        RunCheck(7, "instance cloning", function()
            local part = Instance.new("Part")
            part.Name = "Original"
            local clone = part:Clone()
            if not clone or clone.Name ~= "Original" then
                error()
            end
            part:Destroy()
            clone:Destroy()
        end)
        RunCheck(8, "findfirstchild and waitforchild", function()
            local folder = Instance.new("Folder")
            folder.Name = "FolderTest"
            local child = Instance.new("Part")
            child.Name = "ChildPart"
            child.Parent = folder
            if folder:FindFirstChild("ChildPart") ~= child then
                error()
            end
            local found = folder:WaitForChild("ChildPart", 1)
            if found ~= child then
                error()
            end
            folder:Destroy()
        end)
        RunCheck(9, "runservice event functions", function()
            local RunService = game:GetService("RunService")
            for _, evName in ipairs({ "Heartbeat", "RenderStepped", "Stepped" }) do
                local ev = RunService[evName]
                if ev and typeof(ev.Connect) ~= "function" then
                    error()
                end
            end
        end)
        RunCheck(10, "workspace raycast", function()
            local WorkspaceService = game:GetService("Workspace")
            local origin = Vector3.new(0, 10, 0)
            local direction = Vector3.new(0, -20, 0)
            local result = WorkspaceService:Raycast(origin, direction)
            if typeof(WorkspaceService.Raycast) ~= "function" then
                error()
            end
        end)
        RunCheck(11, "tween transparency changes", function()
            local TweenService = game:GetService("TweenService")
            local part = Instance.new("Part")
            part.Parent = workspace
            local tweenInfo = TweenInfo.new(0.1)
            local tween = TweenService:Create(part, tweenInfo, { Transparency = 0.5 })
            tween:Play()
            task.wait(0.15)
            if math.abs(part.Transparency - 0.5) > 0.01 then
                error()
            end
            part:Destroy()
        end)
        RunCheck(12, "vector3 addition and magnitude", function()
            local a = Vector3.new(1, 2, 3)
            local b = Vector3.new(4, 5, 6)
            local c = a + b
            if c.X ~= 5 or c.Y ~= 7 or c.Z ~= 9 then
                error("Vector3 addition failed")
            end
            if math.abs(c.Magnitude - math.sqrt(5 ^ 2 + 7 ^ 2 + 9 ^ 2)) > 0.01 then
                error()
            end
        end)
        RunCheck(13, "remote event firing", function()
            local event = Instance.new("RemoteEvent")
            local fired = false
            event.OnServerEvent:Connect(function() fired = true end)
            task.spawn(function() event:FireServer() end)
            task.wait(0.1)
            if not fired then
                error()
            end
            event:Destroy()
        end)
        RunCheck(14, "cframe new and positioning", function()
            local cf1 = CFrame.new(1, 2, 3)
            local cf2 = CFrame.new(0, 1, 0)
            local cf3 = cf1 * cf2
            local expected = Vector3.new(1, 3, 3)
            local pos = cf3.Position
            if pos.X ~= expected.X or pos.Y ~= expected.Y or pos.Z ~= expected.Z then
                error()
            end
        end)
        RunCheck(15, "workspace raycast", function()
            local part = Instance.new("Part")
            part.Anchored = true
            part.Size = Vector3.new(4, 1, 4)
            part.Position = Vector3.new(0, 5, 0)
            part.Parent = workspace
            local origin = Vector3.new(0, 10, 0)
            local direction = Vector3.new(0, -10, 0)
            local result = workspace:Raycast(origin, direction)
            if not result or result.Instance ~= part then
                part:Destroy()
                error()
            end
            part:Destroy()
        end)
        RunCheck(16, "humanoid health manipulation", function()
            local model = Instance.new("Model")
            local humanoid = Instance.new("Humanoid")
            humanoid.Health = 100
            humanoid.Parent = model
            model.Parent = workspace

            humanoid:TakeDamage(25)
            task.wait(0.05)
            if humanoid.Health ~= 75 then
                model:Destroy()
                error()
            end
            model:Destroy()
        end)
        RunCheck(17, "seat and weldconstraint", function()
            local seat = Instance.new("Seat")
            seat.Anchored = false
            seat.Position = Vector3.new(0, 5, 0)
            seat.Parent = workspace
            local part = Instance.new("Part")
            part.Anchored = false
            part.Position = Vector3.new(0, 6, 0)
            part.Parent = workspace
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = seat
            weld.Part1 = part
            weld.Parent = seat
            if weld.Part0 ~= seat or weld.Part1 ~= part then
                seat:Destroy()
                part:Destroy()
                error()
            end
            seat:Destroy()
            part:Destroy()
        end)
        RunCheck(18, "userinputservice key detection", function()
            local UIS = game:GetService("UserInputService")
            if typeof(UIS.IsKeyDown) ~= "function" then
                error()
            end
        end)
        RunCheck(19, "tween events and their completion", function()
            local TweenService = game:GetService("TweenService")
            local part = Instance.new("Part")
            part.Parent = workspace
            local tween = TweenService:Create(part, TweenInfo.new(0.1), { Transparency = 0.5 })
            local finished = false
            tween.Completed:Connect(function() finished = true end)
            tween:Play()
            task.wait(0.15)
            if not finished then
                part:Destroy()
                error()
            end
            part:Destroy()
        end)
        RunCheck(20, "player character existence", function()
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            if not player then
                error()
            end
            if player.Character and not player.Character:IsA("Model") then
                error()
            end
        end)
        RunCheck(21, "body velocity movement", function()
            local part = Instance.new("Part")
            part.Anchored = false
            part.Position = Vector3.new(0, 5, 0)
            part.Parent = workspace
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0, 10, 0)
            bv.Parent = part
            task.wait(0.1)
            if part.Position.Y <= 5 then
                bv:Destroy()
                part:Destroy()
                error()
            end
            bv:Destroy()
            part:Destroy()
        end)
        RunCheck(22, "cframe rotation", function()
            local cf = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(90), 0)
            local pos = (cf * Vector3.new(1, 0, 0))
            if math.abs(pos.X) > 0.01 then
                error()
            end
        end)
        RunCheck(23, "touch event firing", function()
            local part1 = Instance.new("Part")
            part1.Anchored = false
            part1.Position = Vector3.new(0, 5, 0)
            part1.Parent = workspace
            local part2 = Instance.new("Part")
            part2.Anchored = false
            part2.Position = Vector3.new(0, 6, 0)
            part2.Parent = workspace
            local touched = false
            part1.Touched:Connect(function(hit)
                if hit == part2 then touched = true end
            end)
            part2.Position = Vector3.new(0, 5, 0)
            task.wait(0.1)
            part1:Destroy()
            part2:Destroy()
            if not touched then
                error()
            end
        end)
        RunCheck(24, "string manipulation", function()
            local s = string.format("%s %d", "hello", 42)
            if s ~= "hello 42" then error() end
            if string.len("test") ~= 4 then error() end
            if string.upper("abc") ~= "ABC" then error() end
        end)
        RunCheck(25, "table operations", function()
            local t = { 1, 2, 3 }
            table.insert(t, 4)
            if #t ~= 4 or t[4] ~= 4 then error() end
            table.remove(t, 1)
            if #t ~= 3 or t[1] ~= 2 then error() end
        end)
        RunCheck(26, "math library functions", function()
            if math.floor(3.9) ~= 3 then error() end
            if math.ceil(3.1) ~= 4 then error() end
            if math.max(1, 5, 3) ~= 5 then error() end
            if math.min(1, 5, 3) ~= 1 then error() end
            if math.abs(-7) ~= 7 then error() end
        end)
        RunCheck(27, "color3 creation", function()
            local c = Color3.new(1, 0, 0)
            if typeof(c) ~= "Color3" then error() end
            if c.R ~= 1 or c.G ~= 0 or c.B ~= 0 then error() end
            local c2 = Color3.fromRGB(255, 128, 0)
            if typeof(c2) ~= "Color3" then error() end
        end)
        RunCheck(28, "udim2 creation", function()
            local u = UDim2.new(0.5, 10, 0.5, 20)
            if typeof(u) ~= "UDim2" then error() end
            if u.X.Scale ~= 0.5 or u.X.Offset ~= 10 then error() end
            if u.Y.Scale ~= 0.5 or u.Y.Offset ~= 20 then error() end
        end)
        RunCheck(29, "instance attribute setting and getting", function()
            local part = Instance.new("Part")
            part:SetAttribute("TestAttr", 42)
            if part:GetAttribute("TestAttr") ~= 42 then
                part:Destroy()
                error()
            end
            part:Destroy()
        end)
        RunCheck(30, "bindable event firing", function()
            local event = Instance.new("BindableEvent")
            local received = false
            event.Event:Connect(function() received = true end)
            event:Fire()
            task.wait(0.05)
            if not received then
                event:Destroy()
                error()
            end
            event:Destroy()
        end)
        RunCheck(31, "bindable function invoke", function()
            local bf = Instance.new("BindableFunction")
            bf.OnInvoke = function(val) return val * 2 end
            local result = bf:Invoke(5)
            if result ~= 10 then
                bf:Destroy()
                error()
            end
            bf:Destroy()
        end)
        RunCheck(32, "part property changes", function()
            local part = Instance.new("Part")
            part.Size = Vector3.new(2, 3, 4)
            part.BrickColor = BrickColor.new("Bright red")
            part.Anchored = true
            if part.Size ~= Vector3.new(2, 3, 4) then
                part:Destroy()
                error()
            end
            if not part.Anchored then
                part:Destroy()
                error()
            end
            part:Destroy()
        end)
        RunCheck(33, "coroutine creation and resuming", function()
            local result = nil
            local co = coroutine.create(function()
                result = 99
            end)
            coroutine.resume(co)
            if result ~= 99 then error() end
        end)
        RunCheck(34, "pcall error catching", function()
            local ok, err = pcall(function()
                error("intentional error")
            end)
            if ok then error() end
            if not err then error() end
        end)
        RunCheck(35, "instance getchildren", function()
            local folder = Instance.new("Folder")
            local a = Instance.new("Part")
            a.Parent = folder
            local b = Instance.new("Part")
            b.Parent = folder
            local children = folder:GetChildren()
            if #children ~= 2 then
                folder:Destroy()
                error()
            end
            folder:Destroy()
        end)
        RunCheck(36, "instance getdescendants", function()
            local folder = Instance.new("Folder")
            local sub = Instance.new("Folder")
            sub.Parent = folder
            local part = Instance.new("Part")
            part.Parent = sub
            local desc = folder:GetDescendants()
            if #desc ~= 2 then
                folder:Destroy()
                error()
            end
            folder:Destroy()
        end)
        RunCheck(37, "number to string and string to number", function()
            local n = 3.14
            local s = tostring(n)
            if typeof(s) ~= "string" then error() end
            local back = tonumber(s)
            if math.abs(back - n) > 0.001 then error() end
        end)
        RunCheck(38, "cframe lookAt", function()
            local from = Vector3.new(0, 0, 0)
            local to = Vector3.new(0, 0, -10)
            local cf = CFrame.lookAt(from, to)
            if typeof(cf) ~= "CFrame" then error() end
            local lookVec = cf.LookVector
            if math.abs(lookVec.Z - (-1)) > 0.01 then error() end
        end)
        RunCheck(39, "gui object creation", function()
            local screenGui = Instance.new("ScreenGui")
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0.5, 0, 0.5, 0)
            frame.Parent = screenGui
            if not frame or frame.Size ~= UDim2.new(0.5, 0, 0.5, 0) then
                screenGui:Destroy()
                error()
            end
            screenGui:Destroy()
        end)
        RunCheck(40, "sound instance creation", function()
            local sound = Instance.new("Sound")
            sound.Volume = 0.5
            if typeof(sound) ~= "Instance" then
                sound:Destroy()
                error()
            end
            if sound.Volume ~= 0.5 then
                sound:Destroy()
                error()
            end
            sound:Destroy()
        end)
        RunCheck(41, "vector3 dot and cross product", function()
            local a = Vector3.new(1, 0, 0)
            local b = Vector3.new(0, 1, 0)
            local dot = a:Dot(b)
            if dot ~= 0 then error() end
            local cross = a:Cross(b)
            if math.abs(cross.Z - 1) > 0.01 then error() end
        end)
        RunCheck(42, "instance changed event", function()
            local part = Instance.new("Part")
            local changed = false
            part.Changed:Connect(function(prop)
                if prop == "Name" then changed = true end
            end)
            part.Name = "NewName"
            task.wait(0.05)
            if not changed then
                part:Destroy()
                error()
            end
            part:Destroy()
        end)
        RunCheck(43, "random number generation", function()
            local rng = Random.new()
            local n = rng:NextNumber(0, 1)
            if n < 0 or n > 1 then error() end
            local i = rng:NextInteger(1, 10)
            if i < 1 or i > 10 then error() end
        end)
        RunCheck(44, "string find and match", function()
            local s = "hello world"
            local start, finish = string.find(s, "world")
            if start ~= 7 or finish ~= 11 then error() end
            local match = string.match(s, "%a+")
            if match ~= "hello" then error() end
        end)
        RunCheck(45, "cframe inverse", function()
            local cf = CFrame.new(5, 10, 15)
            local inv = cf:Inverse()
            local result = cf * inv
            if math.abs(result.X) > 0.01 or math.abs(result.Y) > 0.01 or math.abs(result.Z) > 0.01 then
                error()
            end
        end)
        RunCheck(46, "part anchored physics", function()
            local part = Instance.new("Part")
            part.Anchored = true
            part.Position = Vector3.new(0, 50, 0)
            part.Parent = workspace
            task.wait(0.2)
            if math.abs(part.Position.Y - 50) > 0.1 then
                part:Destroy()
                error()
            end
            part:Destroy()
        end)
        RunCheck(47, "folder and value instances", function()
            local folder = Instance.new("Folder")
            local intVal = Instance.new("IntValue")
            intVal.Value = 99
            intVal.Parent = folder
            local strVal = Instance.new("StringValue")
            strVal.Value = "test"
            strVal.Parent = folder
            if intVal.Value ~= 99 or strVal.Value ~= "test" then
                folder:Destroy()
                error()
            end
            folder:Destroy()
        end)
        RunCheck(48, "ipairs and pairs iteration", function()
            local arr = { 10, 20, 30 }
            local sum = 0
            for _, v in ipairs(arr) do
                sum = sum + v
            end
            if sum ~= 60 then error() end
            local dict = { a = 1, b = 2, c = 3 }
            local count = 0
            for _ in pairs(dict) do
                count = count + 1
            end
            if count ~= 3 then error() end
        end)
        RunCheck(49, "task delay execution", function()
            local ran = false
            task.delay(0.05, function()
                ran = true
            end)
            task.wait(0.15)
            if not ran then error() end
        end)
        RunCheck(50, "instance findfirstchildofclass", function()
            local model = Instance.new("Model")
            local part = Instance.new("Part")
            part.Parent = model
            local humanoid = Instance.new("Humanoid")
            humanoid.Parent = model
            if model:FindFirstChildOfClass("Humanoid") ~= humanoid then
                model:Destroy()
                error()
            end
            if model:FindFirstChildOfClass("Part") ~= part then
                model:Destroy()
                error()
            end
            model:Destroy()
        end)
        SanityCheckFinish = true
    end)
    repeat task.wait(0.1) until SanityCheckFinish == true

    local TotalTests = (Results.Passed + Results.Failed); local Percentage = 0
    if TotalTests > 0 then Percentage = math.floor((Results.Passed / TotalTests) * 100) end; local failedCount = 0
    for _, line in ipairs(Results.Tests) do
        if string.find(line, "FAIL") then
            print(line)
            failedCount = failedCount + 1
        end
    end
    if Results.Failed > 5 then
        print("[VEXALSCRIPTS] sanity check failed with a total result of (" ..
            Results.Passed .. "/" .. TotalTests .. ") (" .. Percentage .. "%) (0 sUNC functions were used)")
        error("[VEXALSCRIPTS] failed too many tests (5), this script shall not run!")
        return
    end
    print("[VEXALSCRIPTS] sanity check succeeded with a total result of (" ..
        Results.Passed .. "/" .. TotalTests .. ") (" .. Percentage .. "%) (0 sUNC functions were used)")

    -- hash + loader removidos (repo eliminado)
end

local wind = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local window = wind:CreateWindow({
    Title = "Murder vs Sheriff Duels (NEW)",
    Icon = "rbxassetid://139687752061139",
    Author = "by Vexal Scripts",
    Folder = "VexalScripts_MVSDNEW",
    Size = UDim2.fromOffset(650, 430),
    MinSize = Vector2.new(450, 250),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Sky",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
        end,
    },
})
window:EditOpenButton({
    Title = "Vexal",
    Icon = "rbxassetid://139687752061139",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("0A1128"),
        Color3.fromHex("4B0082")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})
window:Tag({
    Title = "NEW UPDATE",
    Icon = "shield-check",
    Color = Color3.fromHex("#30aaff"),
    Radius = 5,
})
local Welcome = window:Tab({
    Title = "Welcome",
    Icon = "shield-user",
    Locked = false,
})
Welcome:Paragraph({
    Title = "Welcome to Vexal Scripts",
    Desc =
    "We hope you find this script useful, if you find any issues please report them below to my discord by making a ticket, thank you for using us!",
    Color = Color3.fromHex("#1756B8"),
    Thumbnail = "rbxassetid://139687752061139",
    ThumbnailSize = 150,
    Buttons = {
        {
            Icon = "square-arrow-out-up-right",
            Title = "Copy Our Discord",
            Callback = function()
            end,
        }
    }
})
local lockedParagraph = Welcome:Paragraph({
    Title = "Unsupported Executor",
    Desc =
    "You are currently using an unsupported executor (Solara/Xeno). Certain features have been restricted by our automated system to ensure stability. To unlock full functionality and access all available tools, please switch to a recommended executor (Velocity/Madium)!",
    Color = "Red",
    Locked = false
})
Welcome:Paragraph({
    Title = "Changelogs and Patches",
    Desc = "You may view our latest changelogs and patches right in our discord server!",
    Color = "Green",
    Locked = false
})
Welcome:Select()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Collection = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Camera = Workspace.CurrentCamera
local Player = Players.LocalPlayer

getgenv().match = false
local canShoot = true
local matchEnemies = {}

task.spawn(function()
    while true do
        if Player then
            if Player:GetAttribute("Match") then
                getgenv().match = true
            else
                getgenv().match = false
            end
        end
        task.wait(0.1)
    end
end)
task.spawn(function()
    while task.wait(0.1) do
        local currentMatch = Player:GetAttribute("Match")
        local tempTable = {}
        if currentMatch then
            for _, v in ipairs(Players:GetPlayers()) do
                if v ~= Player and v:GetAttribute("Match") == currentMatch then
                    local char = v.Character
                    if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                        table.insert(tempTable, v)
                    end
                end
            end
        end
        matchEnemies = tempTable
    end
end)
task.spawn(function()
    local lastGunTracked = nil
    local soundConnection = nil
    while task.wait(0.1) do
        local character = Player.Character
        local gun = nil
        local locations = { Player:FindFirstChild("Backpack") }
        if character then table.insert(locations, character) end
        for _, container in ipairs(locations) do
            if container then
                for _, tool in ipairs(container:GetChildren()) do
                    if tool:IsA("Tool") and tool:FindFirstChild("Fire") and tool:FindFirstChild("Reload") then
                        gun = tool
                        break
                    end
                end
            end
            if gun then break end
        end
        if gun then
            if gun ~= lastGunTracked then
                lastGunTracked = gun
                if soundConnection then soundConnection:Disconnect() end
                local fireSound = gun:FindFirstChild("Fire")
                if fireSound and fireSound:IsA("Sound") then
                    soundConnection = fireSound.Played:Connect(function()
                        lastFiredTime = tick()
                    end)
                end
            end
        else
            lastGunTracked = nil
            if soundConnection then
                soundConnection:Disconnect()
                soundConnection = nil
            end
        end
    end
end)

local function getGun()
    local character = Player.Character
    local locations = { Player:FindFirstChild("Backpack") }
    if character then table.insert(locations, character) end
    for _, container in ipairs(locations) do
        if container then
            for _, tool in ipairs(container:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("Fire") and tool:FindFirstChild("Reload") then
                    return tool
                end
            end
        end
    end
    return nil
end
local function equipGun()
    local character = Player.Character
    local backpack = Player:FindFirstChildOfClass("Backpack")
    if not character or not backpack then
        return false
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        return false
    end
    if getgenv().match then
        local gun = getGun()
        if gun then
            humanoid:EquipTool(gun)
            return true
        end
    end
    return false
end
local function equipKnife()
    local character = Player.Character
    local backpack = Player:FindFirstChildOfClass("Backpack")
    if not character or not backpack then
        return false
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        return false
    end
    if getgenv().match then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool:GetAttribute("EquipAnimation") == "Knife_Equip" then
                humanoid:EquipTool(tool)
                return true
            end
        end
    end
    return false
end
local BulletRendererColor = Color3.fromRGB(255, 255, 255)
local function BulletRenderer(origin, targetPos)
    local function CreatePseudoPart(cf)
        local p = Instance.new("Part")
        p.Size = Vector3.new(0.1, 0.1, 0.1)
        p.Transparency = 1
        p.CanCollide = false
        p.CanQuery = false
        p.CanTouch = false
        p.Anchored = true
        p.CFrame = cf
        p.Parent = workspace
        return p
    end
    local startPart = CreatePseudoPart(CFrame.lookAt(origin, targetPos) * CFrame.new(0, 0, -1))
    local endPart = CreatePseudoPart(CFrame.new(targetPos))
    local beam = Instance.new("Beam")
    beam.Texture = ""
    beam.TextureLength = 1
    beam.TextureMode = Enum.TextureMode.Stretch
    beam.TextureSpeed = 0
    beam.Color = ColorSequence.new(BulletRendererColor)
    beam.LightEmission = 1
    beam.LightInfluence = 0
    beam.Brightness = 5
    beam.Width0 = 0
    beam.Width1 = 0
    local att0 = Instance.new("Attachment", startPart)
    local att1 = Instance.new("Attachment", endPart)
    beam.Attachment0 = att0
    beam.Attachment1 = att1
    beam.Parent = startPart
    local fadeIn = TweenService:Create(beam, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        Width0 = 0.3,
        Width1 = 0.6
    })
    local fadeOut = TweenService:Create(beam, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Width0 = 0,
        Width1 = 0
    })
    fadeIn:Play()
    fadeIn.Completed:Connect(function()
        fadeOut:Play()
    end)
    Debris:AddItem(startPart, 0.3)
    Debris:AddItem(endPart, 0.3)
end
local function CharacterRayOrigin(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    return (hrp.CFrame * CFrame.new(0, 0, hrp.Size.Z / 2)).Position
end
local function ShootGun(target)
    local myChar = Player.Character
    if not myChar then return end
    local origin = CharacterRayOrigin(myChar)
    if not origin then return end
    local hitPart = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
    local tool = getGun()
    if not tool then return end
    if hitPart then
        canShoot = false
        local targetPos = hitPart.Position
        local muzzle = tool:FindFirstChild("Muzzle", true)
        local startPos = muzzle and muzzle.WorldPosition or origin
        BulletRenderer(startPos, targetPos)
        ReplicatedStorage.Remotes.ShootGun:FireServer(origin, targetPos, hitPart, targetPos)
        local sound = tool and tool:FindFirstChild("Fire")
        if sound and sound:IsA("Sound") then
            sound:Play()
        end
        task.delay(2.5, function()
            canShoot = true
        end)
    end
end
local lastNotify = 0
local function NotSupportedFeature()
    local currentTime = tick()
    if currentTime - lastNotify >= 5 then
        lastNotify = currentTime

        wind:Notify({
            Title = "Uh Oh! Executor not supported!",
            Content =
            "Sorry! Your executor isn't supported to run this feature, we have made sure of that by running simple checks once you loaded this script!",
            Duration = 3,
            Icon = "rbxassetid://139687752061139",
        })

        wind:Notify({
            Title = "Notice!",
            Content = "If your on PC/Laptop, try using Velocity (its free!), on Android/Ios please try using Delta!",
            Duration = 3,
            Icon = "rbxassetid://139687752061139",
        })
    end
end
local function FeatureActivated(boolean)
    if boolean then
        wind:Notify({
            Title = "Activated Feature!!",
            Content =
            "Enjoying Vexal Scripts? Join our discord server located in the Welcome tab for even better stuff!",
            Duration = 3,
            Icon = "rbxassetid://139687752061139",
        })
    else
        wind:Notify({
            Title = "Disabled Feature!!",
            Content =
            "Enjoying Vexal Scripts? Join our discord server located in the Welcome tab for even better stuff!",
            Duration = 3,
            Icon = "rbxassetid://139687752061139",
        })
    end
end

local Main = window:Tab({
    Title = "Main",
    Icon = "house",
    Locked = false,
})
local ConfigurationSection = Main:Section({
    Title = "Configuration",
    Opened = true,
})
local autounanchor = false
ConfigurationSection:Toggle({
    Title = "Auto UnAnchor Character",
    Desc = "Lets you bypass the 5 second wait before the match starts",
    Icon = "check",
    Default = false,
    Flag = "AutoAunacnchorToggle",
    Callback = function(Value)
        autounanchor = Value
        local function monitorCharacter(character)
            local rootPart = character:WaitForChild("HumanoidRootPart", 5)
            local humanoid = character:WaitForChild("Humanoid", 5)
            if not rootPart or not humanoid then return end
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not character.Parent or humanoid.Health <= 0 then
                    connection:Disconnect()
                    return
                end
                if rootPart.Anchored and autounanchor then
                    rootPart.Anchored = false
                end
            end)
        end
        if Player.Character then
            task.spawn(monitorCharacter, Player.Character)
        end
        Player.CharacterAdded:Connect(monitorCharacter)
    end
})
ConfigurationSection:Colorpicker({
    Title = "Bullet Tracer Color",
    Desc = "Changes the color of your bullet tracer",
    Flag = "BulletTracerColorPicker",
    Default = BulletRendererColor,
    Locked = false,
    Callback = function(color)
        BulletRendererColor = color
    end
})
Main:Space()

getgenv().autoshoot_enabled = false
getgenv().max_distance = 300
getgenv().autoshoot_cooldown = 2
local autoshoot_thread = nil
Main:Toggle({
    Title = "Enable Autoshoot",
    Desc = "This will automatically shoot enemies for you blatantly.",
    Icon = "check",
    Default = false,
    Flag = "EnableAutoShootToggle",
    Callback = function(Value)
        getgenv().autoshoot_enabled = Value
        FeatureActivated(Value)
        if autoshoot_thread then
            task.cancel(autoshoot_thread)
            autoshoot_thread = nil
        end
        if getgenv().autoshoot_enabled then
            local function has_clear_los(fromPos, toPos, myCharacter, targetCharacter)
                local params = RaycastParams.new()
                params.FilterDescendantsInstances = { myCharacter, targetCharacter }
                params.FilterType = Enum.RaycastFilterType.Exclude
                local result = workspace:Raycast(fromPos, (toPos - fromPos), params)
                if result then
                    if not result.Instance:IsDescendantOf(targetCharacter) then
                        return false
                    end
                end
                return true
            end
            autoshoot_thread = task.spawn(function()
                while getgenv().autoshoot_enabled do
                    local myChar = Player.Character
                    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local myHum = myChar and myChar:FindFirstChild("Humanoid")
                    if getgenv().match and myRoot and myHum and myHum.Health > 0 then
                        local closestTarget = nil
                        local closestDistance = getgenv().max_distance or 1000
                        for _, enemy in ipairs(matchEnemies) do
                            local char = enemy.Character
                            local hrp = char and char:FindFirstChild("HumanoidRootPart")
                            local hum = char and char:FindFirstChild("Humanoid")
                            if enemy ~= Player and hum and hum.Health > 0 and hrp then
                                local dist = (hrp.Position - myRoot.Position).Magnitude
                                if dist < closestDistance then
                                    local onDifferentTeam = (not enemy.Team or enemy.Team ~= Player.Team)
                                    local isVisibleInFov = (Camera.CFrame.LookVector:Dot((hrp.Position - Camera.CFrame.Position).Unit) >= 0.9)
                                    if onDifferentTeam and isVisibleInFov then
                                        closestDistance = dist
                                        closestTarget = enemy
                                    end
                                end
                            end
                        end
                        if closestTarget and canShoot then
                            local targetChar = closestTarget.Character
                            local targetHrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                            if targetHrp and has_clear_los(myRoot.Position, targetHrp.Position, myChar, targetChar) then
                                ShootGun(closestTarget)
                            end
                        end
                    end
                    task.wait(0.03)
                end
            end)
        end
    end
})
Main:Slider({
    Title = "Autoshoot Max Distance",
    Step = 1,
    Flag = "AutoshootMaxDistanceSlider",
    Value = {
        Min = 0,
        Max = 1000,
        Default = 300,
    },
    Callback = function(value)
        getgenv().max_distance = value
    end
})
Main:Slider({
    Title = "Cooldown",
    Step = 0.5,
    Flag = "AutoshootCooldownSlider",
    Value = {
        Min = 0.5,
        Max = 10,
        Default = 2,
    },
    Callback = function(value)
        getgenv().autoshoot_cooldown = value
    end
})
Main:Space()

getgenv().auto_throw_enabled = false
getgenv().max_distance = 300
getgenv().throw_cooldown = 2
local autoThrowThread = nil
local lastThrowTime = 0
local function throwKnife(targetChar)
    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if not tool or not tool:FindFirstChild("RightHandle") then return end
    local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHrp then return end
    local origin = CharacterRayOrigin(game.Players.LocalPlayer.Character)
    local direction = (targetHrp.Position - origin).Unit
    ReplicatedStorage.Remotes.ThrowStart:FireServer(origin, direction)
    require(ReplicatedStorage.Modules.KnifeProjectileController)({
        Speed = tool:GetAttribute("ThrowSpeed"),
        KnifeProjectile = tool.RightHandle:Clone(),
        Direction = direction,
        Origin = origin
    }, function(raycastResult)
        ReplicatedStorage.Remotes.ThrowHit:FireServer(raycastResult and raycastResult.Instance,
            raycastResult and raycastResult.Position)
    end)
    lastThrowTime = tick()
end
local uteuirhguh = Main:Toggle({
    Title = "Enable auto throw knife",
    Desc = "Automatically throws your knife at enemies",
    Default = false,
    Callback = function(Value)
        getgenv().auto_throw_enabled = Value
        if autoThrowThread then
            task.cancel(autoThrowThread)
            autoThrowThread = nil
        end
        if Value then
            autoThrowThread = task.spawn(function()
                while getgenv().auto_throw_enabled do
                    if (tick() - lastThrowTime) >= getgenv().throw_cooldown then
                        local myChar = game.Players.LocalPlayer.Character
                        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

                        if myRoot then
                            local closestTarget = nil
                            local shortestDist = getgenv().max_distance
                            for _, player in matchEnemies do
                                if player ~= game.Players.LocalPlayer and player.Character and player.Team ~= Player.Team then
                                    local enemyHrp = player.Character:FindFirstChild("HumanoidRootPart")
                                    local enemyHum = player.Character:FindFirstChild("Humanoid")

                                    if enemyHrp and enemyHum and enemyHum.Health > 0 then
                                        local dist = (enemyHrp.Position - myRoot.Position).Magnitude
                                        local params = RaycastParams.new()
                                        params.FilterDescendantsInstances = { myChar, player.Character }
                                        params.FilterType = Enum.RaycastFilterType.Exclude
                                        local result = workspace:Raycast(myRoot.Position,
                                            (enemyHrp.Position - myRoot.Position), params)

                                        if dist < shortestDist and not result then
                                            shortestDist = dist
                                            closestTarget = player.Character
                                        end
                                    end
                                end
                            end

                            if closestTarget then
                                throwKnife(closestTarget)
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})
Main:Slider({
    Title = "Max Throw Distance",
    Value = { Min = 0, Max = 1000, Default = 300 },
    Callback = function(v) getgenv().max_distance = v end
})
Main:Slider({
    Title = "Cooldown",
    Value = { Min = 0.5, Max = 10, Default = 2 },
    Callback = function(v) getgenv().throw_cooldown = v end
})
Main:Space()

getgenv().triggerbot_enabled = false
getgenv().triggerbot_firing = false
getgenv().triggerbot_cooldown = 1
local function triggerbot_valid_enemy(enemy)
    if not enemy or enemy == Player then return false end
    local character = enemy.Character
    if not character or character.Parent ~= Workspace then return false end
    if enemy.Team and enemy.Team == Player.Team then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local my_hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not (humanoid and hrp and my_hrp) then return false end
    if humanoid.Health <= 0 then return false end
    if Collection:HasTag(character, "Invulnerable") or Collection:HasTag(character, "SpeedTrail") then return false end
    return true
end
local function triggerbot_shoot(target)
    local my_char = Player.Character
    local my_root = my_char and my_char:FindFirstChild("HumanoidRootPart")
    local target_hrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not (my_root and target_hrp) then
        getgenv().triggerbot_firing = false
        return
    end
    local hit_part = target.Character:FindFirstChild("LowerTorso")
        or target.Character:FindFirstChild("UpperTorso")
        or target.Character:FindFirstChild("Head")
    if hit_part then
        ShootGun(target)
    else
        getgenv().triggerbot_firing = false
    end
end
RunService.Heartbeat:Connect(function()
    if not getgenv().triggerbot_enabled then return end
    if not getgenv().match then return end
    if getgenv().triggerbot_firing then return end
    local character = Player.Character
    if not character then return end
    if not getgenv().match then return end
    local mousePos = UserInputService:GetMouseLocation()
    local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.FilterDescendantsInstances = { character }
    rayParams.IgnoreWater = true
    local result = Workspace:Raycast(ray.Origin, ray.Direction * 2000, rayParams)
    if not result then return end
    local hitCharacter = result.Instance:FindFirstAncestorOfClass("Model")
    if not hitCharacter then return end
    local hitPlayer = Players:GetPlayerFromCharacter(hitCharacter)
    if not hitPlayer then return end
    if triggerbot_valid_enemy(hitPlayer) then
        getgenv().triggerbot_firing = true
        triggerbot_shoot(hitPlayer)
        task.delay(getgenv().triggerbot_cooldown, function()
            getgenv().triggerbot_firing = false
        end)
    end
end)
Main:Toggle({
    Title = "Trigger Bot",
    Desc = "Automatically shoots when your mouse hovers over an enemy",
    Icon = "check",
    Default = false,
    Flag = "TriggerBotToggle",
    Callback = function(Value)
        getgenv().triggerbot_enabled = Value
        if getgenv().triggerbot_enabled then
            FeatureActivated(true)
        else
            FeatureActivated(false)
        end
    end
})
Main:Slider({
    Title = "Trigger Bot Cooldown",
    Step = 0.1,
    Flag = "TriggerBotCooldownSlider",
    Value = {
        Min = 0,
        Max = 3,
        Default = 1,
    },
    Callback = function(value)
        getgenv().triggerbot_cooldown = value
    end
})
Main:Space()

getgenv().hitbox_expander = false
getgenv().hitbox_size = 13
getgenv().hitbox_color = Color3.fromRGB(255, 0, 0)
Main:Toggle({
    Title = "Enable Hitbox Expander",
    Desc = "Adds hitbox to all enemies",
    Icon = "check",
    Default = false,
    Flag = "HitboxEnableToggle",
    Callback = function(Value)
        getgenv().hitbox_expander = Value
        if getgenv().hitbox_expander then
            FeatureActivated(true)
        else
            FeatureActivated(false)
        end
        if not getgenv().hitbox_expander then
            for _, player in matchEnemies do
                if player ~= Player then
                    local character = player.Character
                    local hrp = character and character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.CanCollide = false
                        local hit_box = hrp:FindFirstChild("hit_box")
                        if hit_box then
                            hit_box:Destroy()
                        end
                    end
                end
            end
            return
        end
        task.spawn(function()
            while getgenv().hitbox_expander and task.wait(0.1) do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= Player and player.Character then
                        local character = player.Character
                        local hrp = character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local enemy = player.Team ~= Player.Team
                            if enemy then
                                hrp.Size = Vector3.new(getgenv().hitbox_size, getgenv().hitbox_size,
                                    getgenv().hitbox_size)
                                hrp.CanCollide = true
                                local hit_box = hrp:FindFirstChild("hit_box")
                                if not hit_box then
                                    local box_handle = Instance.new("BoxHandleAdornment")
                                    box_handle.Name = "hit_box"
                                    box_handle.Adornee = hrp
                                    box_handle.AlwaysOnTop = true
                                    box_handle.ZIndex = 10
                                    box_handle.Size = hrp.Size
                                    box_handle.Color3 = getgenv().hitbox_color
                                    box_handle.Transparency = 0.8
                                    box_handle.Parent = hrp
                                else
                                    hit_box.Size = hrp.Size
                                end
                            else
                                hrp.Size = Vector3.new(2, 2, 1)
                                hrp.CanCollide = false
                                local hit_box = hrp:FindFirstChild("hit_box")
                                if hit_box then
                                    hit_box:Destroy()
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
})
Main:Slider({
    Title = "Hitbox Size",
    Step = 1,
    Flag = "HitboxSizeSlider",
    Value = {
        Min = 5,
        Max = 100,
        Default = 13,
    },
    Callback = function(size)
        getgenv().hitbox_size = size
    end
})
Main:Colorpicker({
    Title = "Hitbox Color",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0,
    Locked = false,
    Flag = "HitboxColorPicker",
    Callback = function(color)
        getgenv().hitbox_color = color
    end
})

Main:Space()
getgenv().original_cooldowns = {}
Main:Toggle({
    Title = "Remove Gun Cooldown",
    Desc = "You may need to re-equip your weapon for changes to apply",
    Icon = "check",
    Default = false,
    Flag = "RemoveGunCooldownToggle",
    Callback = function(Value)
        getgenv().remove_gun_cooldown = Value
        if getgenv().remove_gun_cooldown then
            FeatureActivated(true)
        else
            FeatureActivated(false)
        end
        if Value then
            getgenv().original_cooldowns = {}
            task.spawn(function()
                while getgenv().remove_gun_cooldown do
                    task.wait(0.1)
                    local tools = {}
                    for _, container in ipairs({ Player:FindFirstChild("Backpack"), Player.Character }) do
                        if container then
                            for _, tool in ipairs(container:GetChildren()) do
                                if tool:IsA("Tool") and tool:FindFirstChild("Fire") then
                                    table.insert(tools, tool)
                                end
                            end
                        end
                    end
                    for _, tool in ipairs(tools) do
                        if getgenv().original_cooldowns[tool] == nil then
                            getgenv().original_cooldowns[tool] = tool:GetAttribute("Cooldown")
                        end
                        if tool:GetAttribute("Cooldown") ~= 0 then
                            tool:SetAttribute("Cooldown", 0)
                        end
                    end
                end
            end)
        else
            for tool, cooldown in pairs(getgenv().original_cooldowns) do
                if tool and tool.Parent then
                    tool:SetAttribute("Cooldown", cooldown)
                end
            end
            getgenv().original_cooldowns = {}
        end
    end,
})

local Esp = window:Tab({
    Title = "Esp Highlights",
    Icon = "eye",
    Locked = false,
})
getgenv().esp_team_color = Color3.fromRGB(0, 255, 0)
getgenv().esp_enemy_color = Color3.fromRGB(255, 0, 0)
getgenv().esp_charms_highlighter = false
local charms_esp = CoreGui:FindFirstChild("Highlights") or Instance.new("Folder")
charms_esp.Name = "CharmsESP"
charms_esp.Parent = CoreGui
Esp:Toggle({
    Title = "Enable Charms Highlighter",
    Desc = "Highlights players full body",
    Icon = "check",
    Default = false,
    Flag = "EspCharmsToggle",
    Callback = function(Value)
        getgenv().esp_charms_highlighter = Value
        if not getgenv().esp_charms_highlighter then
            FeatureActivated(false)
            for _, esp_players in ipairs(charms_esp:GetChildren()) do
                esp_players:Destroy()
            end
            return
        else
            FeatureActivated(true)
        end
        task.spawn(function()
            while getgenv().esp_charms_highlighter do
                task.wait(0.1)
                for _, v in matchEnemies do
                    if not getgenv().esp_charms_highlighter then break end
                    if v ~= Player then
                        local character = v.Character
                        if character then
                            local highlight = charms_esp:FindFirstChild(v.Name)
                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.Name = v.Name
                                highlight.FillTransparency = 0.6
                                highlight.OutlineTransparency = 0.4
                                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                highlight.Parent = charms_esp
                            end
                            local teamColor = (v.Team == Player.Team)
                                and getgenv().esp_team_color
                                or getgenv().esp_enemy_color
                            highlight.FillColor = teamColor
                            highlight.OutlineColor = teamColor
                            highlight.Adornee = character
                        end
                    end
                end
            end
        end)
    end
})
getgenv().esp_skeleton = false
local skeleton_folder = CoreGui:FindFirstChild("Skeletons") or Instance.new("Folder")
skeleton_folder.Name = "Skeletons"
skeleton_folder.Parent = CoreGui
Esp:Toggle({
    Title = "Enable Skeletal Highlighter",
    Desc = "Highlights players skeleton",
    Icon = "check",
    Default = false,
    Flag = "EspSkeletonToggle",
    Callback = function(Value)
        getgenv().esp_skeleton = Value
        local function cleanup()
            for _, child in ipairs(skeleton_folder:GetChildren()) do
                child:Destroy()
            end
        end
        if not Value then
            cleanup()
            FeatureActivated(false)
            return
        else
            FeatureActivated(true)
        end
        task.spawn(function()
            local function createLine()
                local line = Instance.new("LineHandleAdornment")
                line.Thickness = 2
                line.ZIndex = 10
                line.AlwaysOnTop = true
                return line
            end
            local bones = {
                { "Head",       "UpperTorso" }, { "UpperTorso", "LowerTorso" },
                { "UpperTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
                { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" }, { "RightLowerArm", "RightHand" },
                { "LowerTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
                { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" }, { "RightLowerLeg", "RightFoot" }
            }
            while getgenv().esp_skeleton do
                task.wait(0.1)
                for _, v in matchEnemies do
                    local char = v.Character
                    local holder = skeleton_folder:FindFirstChild(v.Name)
                    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                        if not holder then
                            holder = Instance.new("Folder")
                            holder.Name = v.Name
                            holder.Parent = skeleton_folder
                        end
                        local color = (v.Team == Player.Team) and getgenv().esp_team_color or getgenv().esp_enemy_color
                        for i, bonePair in ipairs(bones) do
                            local p1, p2 = char:FindFirstChild(bonePair[1]), char:FindFirstChild(bonePair[2])
                            if p1 and p2 then
                                local line = holder:FindFirstChild(tostring(i)) or createLine()
                                line.Name = tostring(i)
                                line.Color3 = color
                                line.Adornee = p1
                                line.CFrame = CFrame.new(Vector3.zero, p1.CFrame:PointToObjectSpace(p2.Position))
                                line.Length = (p1.Position - p2.Position).Magnitude
                                line.Parent = holder
                            end
                        end
                    elseif holder then
                        holder:Destroy()
                    end
                end
                for _, child in ipairs(skeleton_folder:GetChildren()) do
                    if not Players:FindFirstChild(child.Name) then
                        child:Destroy()
                    end
                end
            end
            cleanup()
        end)
    end
})
getgenv().esp_tracers = false
local tracers_folder = CoreGui:FindFirstChild("Tracers") or Instance.new("Folder")
tracers_folder.Name = "Tracers"
tracers_folder.Parent = CoreGui
local RunService = game:GetService("RunService")
local tracerConnection = nil

Esp:Toggle({
    Title = "Enable Tracers Highlighter",
    Desc = "Draws lines from your character to others smoothly.",
    Icon = "check",
    Default = false,
    Flag = "EspTracersToggle",
    Callback = function(Value)
        getgenv().esp_tracers = Value
        
        local function cleanup()
            for _, child in ipairs(tracers_folder:GetChildren()) do
                child:Destroy()
            end
        end
        
        if tracerConnection then
            tracerConnection:Disconnect()
            tracerConnection = nil
        end
        
        if not Value then
            cleanup()
            if FeatureActivated then FeatureActivated(false) end
            return
        else
            if FeatureActivated then FeatureActivated(true) end
        end
        
        tracerConnection = RunService.RenderStepped:Connect(function()
            if not getgenv().esp_tracers then
                if tracerConnection then tracerConnection:Disconnect() tracerConnection = nil end
                cleanup()
                return
            end
            
            local myChar = Player.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            
            if myRoot then
                for _, v in ipairs(matchEnemies) do
                    if v ~= Player and v.Parent then
                        local char = v.Character
                        local tracer = tracers_folder:FindFirstChild(v.Name)
                        
                        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                            if not tracer then
                                tracer = Instance.new("LineHandleAdornment")
                                tracer.Name = v.Name
                                tracer.Thickness = 1.5
                                tracer.ZIndex = 10
                                tracer.AlwaysOnTop = true
                                tracer.Parent = tracers_folder
                            end
                            
                            local targetRoot = char.HumanoidRootPart
                            local color = (v.Team == Player.Team) and getgenv().esp_team_color or getgenv().esp_enemy_color
                            
                            tracer.Color3 = color
                            tracer.Adornee = workspace.Terrain 
                            tracer.CFrame = CFrame.lookAt(myRoot.Position, targetRoot.Position)
                            tracer.Length = (myRoot.Position - targetRoot.Position).Magnitude
                        elseif tracer then
                            tracer:Destroy()
                        end
                    end
                end
            else
                cleanup()
            end
            
            for _, child in ipairs(tracers_folder:GetChildren()) do
                if not Players:FindFirstChild(child.Name) then
                    child:Destroy()
                end
            end
        end)
    end
})
Esp:Colorpicker({
    Title = "Team Color Highlight",
    Desc = "Esp color for teammates",
    Default = Color3.fromRGB(0, 255, 0),
    Transparency = 0,
    Locked = false,
    Flag = "EspTeamColorPicker",
    Callback = function(color)
        getgenv().esp_team_color = color
    end
})
Esp:Colorpicker({
    Title = "Enemy Color Highlight",
    Desc = "Esp color for enemies",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0,
    Locked = false,
    Flag = "EspEnemyColorPicker",
    Callback = function(color)
        getgenv().esp_enemy_color = color
    end
})

local Killing = window:Tab({
    Title = "Kill All",
    Icon = "skull",
    Locked = false,
})
getgenv().autoKillGun = false
Killing:Button({
    Title = "[GUN] Kill all players once",
    Desc = "Kills all players in your server once",
    Locked = false,
    Callback = function()
        if getgenv().match then
            local players = game:GetService("Players")
            local player = players.LocalPlayer
            local myMatch = player:GetAttribute("Match")
            if myMatch then
                equipGun()
                wind:Notify({
                    Title = "Killing all players!",
                    Content =
                    "Enjoying Vexal Scripts? Join our discord server located in the Welcome tab for even better stuff!",
                    Duration = 3,
                    Icon = "rbxassetid://139687752061139",
                })
                for _, plr in matchEnemies do
                    if plr.Team ~= player.Team and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local target = plr.Character.HumanoidRootPart
                        local origin = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if origin then
                            local ShootGun = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ShootGun")
                            ShootGun:FireServer(origin.Position, target.Position, target, target.Position)
                        end
                    end
                    task.wait(0.1)
                end
            end
        end
    end
})
Killing:Toggle({
    Title = "[GUN] Auto kill all players",
    Desc = "Kills everyone constantly in your server with gun",
    Value = false,
    Callback = function(state)
        getgenv().autoKillGun = state
        if state then
            FeatureActivated(true)
        else
            FeatureActivated(false)
        end
    end
})
task.spawn(function()
    local players = game:GetService("Players")
    local player = players.LocalPlayer
    while true do
        if getgenv().autoKillGun then
            local myMatch = player:GetAttribute("Match")
            if myMatch then
                equipGun()
                for _, plr in matchEnemies do
                    if plr.Team ~= player.Team and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local target = plr.Character.HumanoidRootPart
                        local origin = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if origin then
                            local ShootGun = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ShootGun")
                            ShootGun:FireServer(origin.Position, target.Position, target, target.Position)
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)
getgenv().autoKillKnife = false
Killing:Button({
    Title = "[KNIFE] Kill all players once",
    Desc = "Kills all players in your server once",
    Locked = false,
    Callback = function()
        if getgenv().match then
            local players = game:GetService("Players")
            local player = players.LocalPlayer
            local myMatch = player:GetAttribute("Match")
            if myMatch then
                equipKnife()
                wind:Notify({
                    Title = "Killing all players!",
                    Content =
                    "Enjoying Vexal Scripts? Join our discord server located in the Welcome tab for even better stuff!",
                    Duration = 3,
                    Icon = "rbxassetid://139687752061139",
                })
                for _, target in ipairs(Players:GetPlayers()) do
                    if target ~= player and target.Character then
                        local humanoid = target.Character:FindFirstChild("Humanoid")
                        local rootPart = target.Character:FindFirstChild("HumanoidRootPart")
                        if humanoid and humanoid.Health > 0 and rootPart then
                            local knifeRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ThrowHit")
                            knifeRemote:FireServer(rootPart, rootPart.Position)
                        end
                    end
                    task.wait(0.1)
                end
            end
        end
    end
})
Killing:Toggle({
    Title = "[KNIFE] Auto kill all players",
    Desc = "Kills everyone constantly in your server with knife",
    Value = false,
    Callback = function(state)
        getgenv().autoKillKnife = state
        if state then
            FeatureActivated(true)
        else
            FeatureActivated(false)
        end
    end
})
task.spawn(function()
    local players = game:GetService("Players")
    local player = players.LocalPlayer
    while true do
        if getgenv().autoKillKnife then
            local myMatch = player:GetAttribute("Match")
            if myMatch then
                equipKnife()
                for _, target in matchEnemies do
                    if target ~= player and target.Character then
                        local humanoid = target.Character:FindFirstChild("Humanoid")
                        local rootPart = target.Character:FindFirstChild("HumanoidRootPart")
                        if humanoid and humanoid.Health > 0 and rootPart then
                            local knifeRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ThrowHit")
                            knifeRemote:FireServer(rootPart, rootPart.Position)
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

local Ability = window:Tab({
    Title = "Abilitys",
    Icon = "zap",
    Locked = false,
})
getgenv().autoShroud = false
getgenv().lowExecutorsShroud = false
getgenv().shroudRate = 1
local ConfigSuccess, Config = pcall(function()
    return require(game:GetService("ReplicatedStorage").Ability.AbilityConfig)
end)
local ActivateShroud = ReplicatedStorage.Ability:WaitForChild("ActivateShroud")
local isLocked = (not ConfigSuccess)
local originals = {
    SprintCooldown = not isLocked and Config.SprintCooldown or 15,
    DashCooldown = not isLocked and Config.DashCooldown or 6,
    ShroudCooldown = not isLocked and Config.ShroudCooldown or 7,
    SoulReapCombatDelay = not isLocked and Config.SoulReapCombatDelay or 0.35
}
if isLocked then
    uteuirhguh:Lock()
end
local function blind(targetPlayer)
    local character = Players.LocalPlayer.Character
    if targetPlayer and targetPlayer.Character and character then
        local targetPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local root = character:FindFirstChild("HumanoidRootPart")

        if targetPart and root then
            local origin
            local direction

            if getgenv().lowExecutorsShroud then
                origin = root.Position
                direction = (targetPart.Position - origin).Unit
                ActivateShroud:FireServer(origin, direction)
            else
                local s1, CharacterRayOrigin = pcall(function()
                    return require(ReplicatedStorage.Modules
                        .CharacterRayOrigin)
                end)
                local s2, ShroudProjectileController = pcall(function()
                    return require(ReplicatedStorage.Ability
                        .ShroudProjectileController)
                end)
                if s1 and s2 then
                    origin = CharacterRayOrigin(character)
                    direction = (targetPart.Position - origin).Unit
                    ActivateShroud:FireServer(origin, direction)
                    ShroudProjectileController(origin, direction)
                else
                    getgenv().lowExecutorsShroud = true
                    origin = root.Position
                    direction = (targetPart.Position - origin).Unit
                    ActivateShroud:FireServer(origin, direction)
                end
            end
        end
    end
end

Ability:Toggle({
    Title = "Auto Shroud All",
    Desc = "Automatically blinds all enemies in match",
    Value = false,
    Callback = function(state)
        getgenv().autoShroud = state
    end
})
Ability:Toggle({
    Title = "Low Executor Mode",
    Desc = "Supports all executors, may not notice shroud box/sound but blinds enemy and saves FPS",
    Value = false,
    Callback = function(state)
        getgenv().lowExecutorsShroud = state
    end
})
Ability:Slider({
    Title = "Amount of Shrouds per Enemy",
    Desc = "Adjust firing rate per enemy, a high number increases fps for entire game",
    Step = 0.1,
    Value = {
        Min = 1,
        Max = 10000,
        Default = 1,
    },
    Callback = function(value)
        getgenv().shroudRate = value
    end
})
task.spawn(function()
    while true do
        if getgenv().autoShroud then
            local matchId = Players.LocalPlayer:GetAttribute("Match")
            for _, p in matchEnemies do
                blind(p)
            end
            task.wait(1 / getgenv().shroudRate)
        else
            task.wait(0.5)
        end
    end
end)

Ability:Space()
task.spawn(function()
    if not isLocked then
        lockedParagraph:Destroy()
    end
end)
Ability:Toggle({
    Title = "Remove Sprint Cooldown",
    Locked = isLocked,
    Value = false,
    Callback = function(state)
        if state then
            FeatureActivated(true)
        else
            FeatureActivated(false)
        end
        if not isLocked then
            Config.SprintCooldown = state and 0 or originals.SprintCooldown
        else
            NotSupportedFeature()
        end
    end
})
Ability:Toggle({
    Title = "Remove Dash Cooldown",
    Locked = isLocked,
    Value = false,
    Callback = function(state)
        if state then
            FeatureActivated(true)
        else
            FeatureActivated(false)
        end
        if not isLocked then
            Config.DashCooldown = state and 0 or originals.DashCooldown
        else
            NotSupportedFeature()
        end
    end
})
Ability:Toggle({
    Title = "Remove Shroud Cooldown",
    Locked = isLocked,
    Value = false,
    Callback = function(state)
        if state then
            FeatureActivated(true)
        else
            FeatureActivated(false)
        end
        if not isLocked then
            Config.ShroudCooldown = state and 0 or originals.ShroudCooldown
        else
            NotSupportedFeature()
        end
    end
})
Ability:Toggle({
    Title = "Remove Soul Reap Combat Delay",
    Locked = isLocked,
    Value = false,
    Callback = function(state)
        if state then
            FeatureActivated(true)
        else
            FeatureActivated(false)
        end
        if not isLocked then
            Config.SoulReapCombatDelay = state and 0 or originals.SoulReapCombatDelay
        else
            NotSupportedFeature()
        end
    end
})

Ability:Space()
Ability:Slider({
    Title = "Sprint Time",
    Step = 0.5,
    Locked = isLocked,
    Value = {
        Min = 0.5,
        Max = 10,
        Default = not isLocked and Config.SprintTime or 0,
    },
    Callback = function(value)
        if not isLocked then
            Config.SprintTime = value
        else
            NotSupportedFeature()
        end
    end
})
Ability:Slider({
    Title = "Sprint Boost",
    Step = 0.1,
    Locked = isLocked,
    Value = {
        Min = 0,
        Max = 5,
        Default = not isLocked and Config.SprintBoost or 0,
    },
    Callback = function(value)
        if not isLocked then
            Config.SprintBoost = value
        else
            NotSupportedFeature()
        end
    end
})
Ability:Slider({
    Title = "Soul Reap Time",
    Step = 0.5,
    Locked = isLocked,
    Value = {
        Min = 0.5,
        Max = 10,
        Default = not isLocked and Config.SoulReapTime,
    },
    Callback = function(value)
        if not isLocked then
            Config.SoulReapTime = value
        else
            NotSupportedFeature()
        end
    end
})
Ability:Slider({
    Title = "Soul Reap Speed Boost",
    Step = 0.1,
    Locked = isLocked,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = not isLocked and Config.SoulReapSpeedBoost or 0,
    },
    Callback = function(value)
        if not isLocked then
            Config.SoulReapSpeedBoost = value
        else
            NotSupportedFeature()
        end
    end
})
Ability:Slider({
    Title = "Propeller Jump Boost",
    Step = 0.1,
    Locked = isLocked,
    Value = {
        Min = 0.1,
        Max = 5,
        Default = not isLocked and Config.PropellerJumpBoost or 0,
    },
    Callback = function(value)
        if not isLocked then
            Config.PropellerJumpBoost = value
        else
            NotSupportedFeature()
        end
    end
})
Ability:Slider({
    Title = "Shroud Time",
    Step = 0.5,
    Locked = isLocked,
    Value = {
        Min = 0.5,
        Max = 10,
        Default = not isLocked and Config.ShroudTime or 0,
    },
    Callback = function(value)
        if not isLocked then
            Config.ShroudTime = value
        else
            NotSupportedFeature()
        end
    end
})
Ability:Slider({
    Title = "Shroud Projectile Speed",
    Step = 2.5,
    Locked = isLocked,
    Value = {
        Min = 2.5,
        Max = 100,
        Default = not isLocked and Config.ShroudProjectileSpeed or 0,
    },
    Callback = function(value)
        if not isLocked then
            Config.ShroudProjectileSpeed = value
        else
            NotSupportedFeature()
        end
    end
})
Ability:Slider({
    Title = "Shroud Projectile Range",
    Step = 5,
    Locked = isLocked,
    Value = {
        Min = 5,
        Max = 1000,
        Default = not isLocked and Config.ShroudProjectileRange or 0,
    },
    Callback = function(value)
        if not isLocked then
            Config.ShroudProjectileRange = value
        else
            NotSupportedFeature()
        end
    end
})

local Teleport = window:Tab({
    Title = "Teleport",
    Icon = "map-pin",
    Locked = false,
})

local lobby = workspace:WaitForChild("Lobby")
local groups = { DuelRing_1v1 = 1, DuelRing_2v2 = 2, DuelRing_3v3 = 3, DuelRing_4v4 = 4 }
local autoWalkToDuelPad = false
local currentPadModel = nil
local lastJumpTime = 0
local function walkTo(model)
    local character = Player.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoid and rootPart and model and model.PrimaryPart then
        local targetPosition = model.PrimaryPart.Position
        local distance = (rootPart.Position - targetPosition).Magnitude
        if distance <= 6 then
            getgenv().noclip = false
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
            return
        end
        humanoid.WalkSpeed = 35
        humanoid:MoveTo(targetPosition)
        if os.clock() - lastJumpTime >= 2 then
            humanoid.Jump = true
            lastJumpTime = os.clock()
        end
        getgenv().noclip = true
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end
Teleport:Toggle({
    Title = "Enable auto walk to duel pads",
    Desc = "Automatically walks to an available duel pad accurately",
    Default = false,
    Flag = "AutoWalkDuelPadToggle",
    Callback = function(value)
        autoWalkToDuelPad = value
    end
})
Teleport:Space()
task.spawn(function()
    while true do
        if executionID ~= _G.executionID then break end
        if not Player:GetAttribute("Match") then
            if autoWalkToDuelPad then
                local character = Player.Character
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                if currentPadModel and rootPart then
                    local currentMaxCount = 1
                    for groupName, maxCount in pairs(groups) do
                        if lobby:FindFirstChild("DuelRingsGroup") and lobby.DuelRingsGroup:FindFirstChild(groupName) then
                            if lobby.DuelRingsGroup[groupName]:FindFirstChild(currentPadModel.Name) then
                                currentMaxCount = maxCount
                                break
                            end
                        end
                    end
                    if currentMaxCount == 1 then
                        local opponentFound = false
                        for _, otherPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                            if otherPlayer ~= Player and otherPlayer.Character then
                                local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if otherRoot then
                                    local dist = (rootPart.Position - otherRoot.Position).Magnitude
                                    if dist <= 8 then
                                        opponentFound = true
                                        break
                                    end
                                end
                            end
                        end
                        if not opponentFound then
                            currentPadModel = nil
                        end
                    end
                end
                if currentPadModel and rootPart then
                    local stillValid = false
                    for _, groupFolder in ipairs(lobby:GetChildren()) do
                        if groupFolder.Name == "DuelRingsGroup" then
                            for groupName, maxCount in pairs(groups) do
                                local ringFolder = groupFolder:FindFirstChild(groupName)
                                if ringFolder and ringFolder:FindFirstChild(currentPadModel.Name) then
                                    local totalPlayersInGroup = 0
                                    local maxPlayersForGroup = maxCount * 2
                                    local targetedPadStillNeedsPlayer = false
                                    for _, model in ipairs(ringFolder:GetChildren()) do
                                        if model:IsA("Model") and model.Name == "DuelPad" then
                                            local count = model:GetAttribute("CharacterCount") or 0
                                            totalPlayersInGroup = totalPlayersInGroup + count
                                            if model == currentPadModel and count < maxCount then
                                                targetedPadStillNeedsPlayer = true
                                            end
                                        end
                                    end
                                    if (totalPlayersInGroup == maxPlayersForGroup - 1 and targetedPadStillNeedsPlayer) or (totalPlayersInGroup == maxPlayersForGroup) then
                                        stillValid = true
                                    end
                                    break
                                end
                            end
                        end
                        if stillValid then break end
                    end
                    if not stillValid then currentPadModel = nil end
                end
                if not currentPadModel then
                    local foundNewPad = false
                    for _, groupFolder in ipairs(lobby:GetChildren()) do
                        if groupFolder.Name == "DuelRingsGroup" then
                            for groupName, maxCount in pairs(groups) do
                                local ringFolder = groupFolder:FindFirstChild(groupName)
                                if ringFolder then
                                    local pads = {}
                                    local totalPlayersInGroup = 0
                                    local maxPlayersForGroup = maxCount * 2
                                    for _, model in ipairs(ringFolder:GetChildren()) do
                                        if model:IsA("Model") and model.Name == "DuelPad" then
                                            local count = model:GetAttribute("CharacterCount") or 0
                                            totalPlayersInGroup = totalPlayersInGroup + count
                                            table.insert(pads, { model = model, count = count })
                                        end
                                    end
                                    if totalPlayersInGroup == maxPlayersForGroup - 1 then
                                        for _, pad in ipairs(pads) do
                                            if pad.count < maxCount then
                                                local opponentReady = true
                                                if maxCount == 1 then
                                                    opponentReady = false
                                                    for _, otherPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                                                        if otherPlayer ~= Player and otherPlayer.Character then
                                                            local otherRoot = otherPlayer.Character:FindFirstChild(
                                                                "HumanoidRootPart")
                                                            if otherRoot and pad.model.PrimaryPart then
                                                                local dist = (otherRoot.Position - pad.model.PrimaryPart.Position)
                                                                    .Magnitude
                                                                if dist <= 8 then
                                                                    opponentReady = true
                                                                    break
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                                if opponentReady then
                                                    walkTo(pad.model)
                                                    if rootPart and pad.model.PrimaryPart then
                                                        local distance = (rootPart.Position - pad.model.PrimaryPart.Position)
                                                            .Magnitude
                                                        if distance <= 6 then currentPadModel = pad.model end
                                                    end
                                                    foundNewPad = true
                                                    task.wait(0.5)
                                                    break
                                                end
                                            end
                                        end
                                    end
                                end
                                if foundNewPad then break end
                            end
                        end
                        if foundNewPad then break end
                    end
                end
            else
                currentPadModel = nil
            end
        else
            currentPadModel = nil
        end
        task.wait(0.2)
    end
end)
if lobby and lobby:FindFirstChild("DuelRingsGroup") then
    for groupName, _ in pairs(groups) do
        local ringFolder = lobby.DuelRingsGroup:FindFirstChild(groupName)
        if ringFolder then
            local padIndex = 1
            for _, model in ipairs(ringFolder:GetChildren()) do
                if model:IsA("Model") and model.Name == "DuelPad" then
                    local sideName = (padIndex % 2 == 1) and "Right" or "Left"
                    local cleanTitle = "Walk to " .. groupName .. " " .. sideName

                    Teleport:Button({
                        Title = cleanTitle,
                        Locked = false,
                        Callback = function()
                            wind:Notify({
                                Title = "Walking to position!",
                                Content =
                                "Enjoying Vexal Scripts? Join our discord server located in the Welcome tab for even better stuff!",
                                Duration = 3,
                                Icon = "rbxassetid://139687752061139",
                            })

                            walkTo(model)
                        end
                    })
                    padIndex = padIndex + 1
                end
            end
        end
    end
end
local fov = window:Tab({
    Title = "FOV Shooting",
    Icon = "crosshair",
    Locked = false,
})
local fov_autoshoot_enabled = false
local fov_manualShoot_enabled = false
local fov_circle_enabled = false
local fov_radius = 100
local fov_shoot_cooldown = 1
local fov_last_shot = 0
local fov_circle = nil
local fov_gunController = nil
local fov_autoshoot_toggle = nil
local fov_manual_toggle = nil
local function createFovCircle()
    if fov_circle then
        fov_circle:Remove()
    end
    fov_circle = Drawing.new("Circle")
    fov_circle.Thickness = 2
    fov_circle.NumSides = 64
    fov_circle.Radius = fov_radius
    fov_circle.Color = Color3.fromRGB(255, 255, 255)
    fov_circle.Transparency = 1
    fov_circle.Visible = false
    fov_circle.Filled = false
end
createFovCircle()
local function update_fov_circle()
    if fov_circle and (fov_circle_enabled or fov_autoshoot_enabled or fov_manualShoot_enabled) then
        local mouse_pos = UserInputService:GetMouseLocation()
        fov_circle.Position = Vector2.new(mouse_pos.X, mouse_pos.Y)
        fov_circle.Radius = fov_radius
        fov_circle.Visible = true
    elseif fov_circle then
        fov_circle.Visible = false
    end
end
local function is_in_fov(target_position)
    local screen_pos, on_screen = Camera:WorldToViewportPoint(target_position)
    if not on_screen then
        return false
    end
    local mouse_pos = UserInputService:GetMouseLocation()
    local distance = math.sqrt((screen_pos.X - mouse_pos.X) ^ 2 + (screen_pos.Y - mouse_pos.Y) ^ 2)
    return distance <= fov_radius
end
local function has_clear_los(from_pos, to_pos, target_character)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = { Player.Character, target_character }
    params.FilterType = Enum.RaycastFilterType.Exclude
    local result = Workspace:Raycast(from_pos, (to_pos - from_pos), params)
    if result then
        if not result.Instance:IsDescendantOf(target_character) then
            return false
        end
    end
    return true
end
local function valid_enemy(enemy)
    if not enemy or enemy == Player then
        return false
    end
    local character = enemy.Character
    if not character or character.Parent ~= Workspace then
        return false
    end
    if enemy.Team and enemy.Team == Player.Team then
        return false
    end
    local humanoid = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local my_hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not (humanoid and hrp and my_hrp) then
        return false
    end
    if humanoid.Health <= 0 then
        return false
    end
    if Collection:HasTag(character, "Invulnerable") or Collection:HasTag(character, "SpeedTrail") then
        return false
    end
    return true
end
local function shoot_enemy(target)
    local my_char = Player.Character
    local my_root = my_char and my_char:FindFirstChild("HumanoidRootPart")
    local target_hrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not (my_root and target_hrp) then
        return false
    end
    if not has_clear_los(my_root.Position, target_hrp.Position, target.Character) then
        return false
    end
    if not is_in_fov(target_hrp.Position) then
        return false
    end
    local current_time = tick()
    if current_time - fov_last_shot < fov_shoot_cooldown then
        return false
    end

    local hit_part = target.Character:FindFirstChild("LowerTorso") or
        target.Character:FindFirstChild("UpperTorso") or
        target.Character:FindFirstChild("Head")

    if hit_part then
        ShootGun(target)
        fov_last_shot = current_time
        return true
    end
    return false
end
RunService.Heartbeat:Connect(function()
    update_fov_circle()
    if not fov_autoshoot_enabled then
        return
    end
    local my_char = Player.Character
    if not my_char then
        return
    end
    for _, enemy in pairs(Players:GetPlayers()) do
        if valid_enemy(enemy) then
            if shoot_enemy(enemy) then
                break
            end
        end
    end
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if fov_manualShoot_enabled and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local current_time = tick()
        if current_time - fov_last_shot < fov_shoot_cooldown then
            return
        end
        local my_char = Player.Character
        if not my_char then
            return
        end
        for _, enemy in pairs(Players:GetPlayers()) do
            if valid_enemy(enemy) then
                if shoot_enemy(enemy) then
                    break
                end
            end
        end
    end
end)
local function start_gun_controller_loop()
    if fov_gunController then
        task.cancel(fov_gunController)
    end
    fov_gunController = task.spawn(function()
        while fov_manualShoot_enabled do
            task.wait()
            local gun_controller = Workspace:FindFirstChild(Player.Name)
            if gun_controller then
                local controller = gun_controller:FindFirstChild("GunController")
                if controller then
                    controller.Parent = nil
                end
            end
        end
    end)
end
local function stop_gun_controller_loop()
    if fov_gunController then
        task.cancel(fov_gunController)
        fov_gunController = nil
    end
end
fov:Toggle({
    Title = "Enable FOV Circle",
    Desc = "Show FOV circle around your mouse",
    Default = false,
    Flag = "EnableFovCircle",
    Callback = function(value)
        fov_circle_enabled = value
    end
})
fov_autoshoot_toggle = fov:Toggle({
    Title = "Autoshoot FOV",
    Desc = "Automatically shoots enemies in your FOV circle",
    Default = false,
    Flag = "EnableAutoshootFov",
    Callback = function(value)
        fov_autoshoot_enabled = value
        if value then
            if fov_manual_toggle then
                fov_manual_toggle:Lock()
            end
        else
            if fov_manual_toggle then
                fov_manual_toggle:Unlock()
            end
        end
    end
})
fov_manual_toggle = fov:Toggle({
    Title = "FOV Manual Shoot",
    Desc = "Click to shoot enemies in FOV circle",
    Default = false,
    Flag = "EnableManualShootToggle",
    Callback = function(value)
        fov_manualShoot_enabled = value

        if value then
            if fov_autoshoot_toggle then
                fov_autoshoot_toggle:Lock()
            end
            start_gun_controller_loop()
        else
            if fov_autoshoot_toggle then
                fov_autoshoot_toggle:Unlock()
            end
            stop_gun_controller_loop()
        end
    end
})
fov:Slider({
    Title = "FOV Circle Size",
    Step = 5,
    Flag = "FovCircleSizeSlider",
    Value = {
        Min = 35,
        Max = 300,
        Default = 100,
    },
    Callback = function(value)
        fov_radius = value
    end
})
fov:Slider({
    Title = "FOV Autoshoot Cooldown",
    Step = 0.1,
    Flag = "FovAutoshootCooldownSlider",
    Value = {
        Min = 0,
        Max = 5,
        Default = 2,
    },
    Callback = function(value)
        fov_shoot_cooldown = value
    end
})

local Misc = window:Tab({
    Title = "Misc",
    Icon = "folder",
    Locked = false,
})
getgenv().original_speed = 16
getgenv().speed_enabled = false
getgenv().current_speed = 16
getgenv().remove_gun_cooldown = false
Misc:Toggle({
    Title = "Auto Spin",
    Desc = "Auto spins for you when not in match",
    Default = false,
    Callback = function(state)
        getgenv().autoSpin = state
        task.spawn(function()
            while getgenv().autoSpin do
                if not Player:GetAttribute("Match") then
                    local SpinnerService = require(game:GetService("ReplicatedStorage").Dailies.SpinnerService)
                    SpinnerService.Spin()
                end
                task.wait(0.1)
            end
        end)
    end,
})
Misc:Toggle({
    Title = "Noclip",
    Desc = "Allows you to walk through walls",
    Default = false,
    Callback = function(state)
        getgenv().noclip = state
        if state then
            FeatureActivated(true)
            local noclipLoop
            noclipLoop = game:GetService("RunService").Stepped:Connect(function()
                if not getgenv().noclip then
                    noclipLoop:Disconnect()
                    return
                end
                local char = Player.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            FeatureActivated(false)
        end
    end,
})
Misc:Toggle({
    Title = "Enable Speed Changer",
    Desc = "Changes your walk speed",
    Icon = "check",
    Default = false,
    Flag = "SpeedChangerToggle",
    Callback = function(Value)
        getgenv().speed_enabled = Value
        if Value then
            task.spawn(function()
                while getgenv().speed_enabled do
                    local character = Player.Character
                    local humanoid = character and character:FindFirstChild("Humanoid")
                    if humanoid and humanoid.WalkSpeed ~= getgenv().current_speed then
                        humanoid.WalkSpeed = getgenv().current_speed
                    end
                    task.wait(0.1)
                end
            end)
        else
            local character = Player.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = getgenv().original_speed
            end
        end
    end
})
Misc:Slider({
    Title = "Walk Speed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 200,
        Default = 16,
    },
    Flag = "SpeedChangerSlider",
    Callback = function(speed)
        getgenv().current_speed = speed
        if getgenv().speed_enabled then
            local character = Player.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
        end
    end
})
Player.CharacterAdded:Connect(function(character)
    task.wait(0.2)
    if getgenv().speed_enabled then
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = getgenv().current_speed
    end
end)
wind:AddTheme({
    Name = "VexalScripts_Theme1",
    Accent = wind:Gradient(
        { ["0"] = { Color = Color3.fromHex("#8644ff"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#6325d9"), Transparency = 0 } },
        { Rotation = 90 }),
    Background = wind:Gradient(
        { ["0"] = { Color = Color3.fromHex("#120f1a"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#0c0a12"), Transparency = 0 } },
        { Rotation = 90 }),
    Outline = wind:Gradient(
        { ["0"] = { Color = Color3.fromHex("#2d2838"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#1f1a26"), Transparency = 0 } },
        { Rotation = 0 }),
    Text = wind:Gradient(
        { ["0"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#f3effa"), Transparency = 0 } },
        { Rotation = 90 }),
    Placeholder = wind:Gradient(
        { ["0"] = { Color = Color3.fromHex("#6e677a"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#565061"), Transparency = 0 } },
        { Rotation = 0 }),
    Button = wind:Gradient(
        { ["0"] = { Color = Color3.fromHex("#1e1929"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#171320"), Transparency = 0 } },
        { Rotation = 90 }),
    Icon = wind:Gradient(
        { ["0"] = { Color = Color3.fromHex("#e6dbff"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#bca8ff"), Transparency = 0 } },
        { Rotation = 45 })
})
wind:SetTheme("VexalScripts_Theme1")

local Settings = window:Tab({
    Title = "Settings",
    Icon = "settings",
    Locked = false,
})
local themeNames = {}
for name in pairs(wind.Themes) do
    table.insert(themeNames, name)
end
table.sort(themeNames)
Settings:Dropdown({
    Title = "Themes",
    Desc = "Select a theme",
    Flag = "SelectedTheme",
    Values = themeNames,
    Value = "VexalScripts_Theme1",
    Callback = function(option)
        wind:SetTheme(option)
    end
})
Settings:Keybind({
    Title = "Keybind",
    Desc = "Keybind to open ui",
    Value = "LeftControl",
    Flag = "KeybindOpenWindow",
    Callback = function(v)
        window:SetToggleKey(Enum.KeyCode[v])
    end
})
Settings:Space()
local ConfigManager = window.ConfigManager
local CurrentConfigName = "default"
local ConfigNameInput = Settings:Input({
    Title = "Config Name",
    Value = CurrentConfigName,
    Callback = function(value)
        CurrentConfigName = value
    end
})
local ConfigDropdown = Settings:Dropdown({
    Title = "All Configs",
    Values = ConfigManager:AllConfigs(),
    Callback = function(value)
        CurrentConfigName = value
        ConfigNameInput:Set(value)
    end
})
Settings:Button({
    Title = "Save Config",
    Callback = function()
        local config = ConfigManager:CreateConfig(CurrentConfigName)
        if config:Save() then
            ConfigDropdown:Refresh(ConfigManager:AllConfigs())
        end
    end
})
Settings:Button({
    Title = "Load Config",
    Callback = function()
        local config = ConfigManager:CreateConfig(CurrentConfigName)
        if config:Load() then
        end
    end
})
Settings:Button({
    Title = "Delete Config",
    Callback = function()
        local config = ConfigManager:CreateConfig(CurrentConfigName)
        config:Delete()
        ConfigDropdown:Refresh(ConfigManager:AllConfigs())
    end
})
wind:Notify({
    Title = "Welcome to Vexal Scripts MVSD",
    Duration = 15,
    Icon = "rbxassetid://139687752061139",
})
