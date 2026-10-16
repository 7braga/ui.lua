local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

-- WINDUI PRIMERO
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "braga Hub  |  Blox Fruits",
    Author = "by bragao",
    Folder = "67",
    Icon = "home",
    NewElements = true,
})

-- VARIABLES
local soruAimEnabled = false
local infSoruEnabled = false
local silentAimPlayersEnabled = false
local silentAimNPCsEnabled = false
local predictionEnabled = false
local predictionAmount = 0.1
local zSkillOrM1 = false
local zSkillsEnabled = false
local autoKenEnabled = false
local autoKenRunning = false
local espEnabled = false
local infJumpEnabled = false
local walkWaterEnabled = false
local camLockEnabled = false
local camLockPred = 0.1
local dashEnabled = false
local dashLength = 1
local bunnyHopEnabled = false
local bunnyHopHooked = false
local noDodgeCDEnabled = false
local busoEnabled = false
local v3Enabled = false
local v3LoopRunning = false
local infEnergyEnabled = false
local fastAttackEnabled = false
local walkSpeedValue = 16
local autoV4Enabled = false
local fruitCheckEnabled = false
local fruitTeleportEnabled = false
local targetInfoEnabled = false
local fpsBoostEnabled = false
local fpsPingEnabled = false
local antiAfkEnabled = false
local maxRange = 500

local infJumpConn = nil
local waterPart = nil
local walkWaterConn = nil
local camLockConn = nil
local dashConnection = nil
local infSoruConn = nil
local energyConnection = nil
local fastAttackConn = nil
local fruitLoop = nil
local teleportLoop = nil
local fpsConn = nil
local fpsBoostConn = nil
local NoDodgeCoroutine = nil
local uiConn = nil
local sizeConn = nil
local PlayersPosition = nil
local NPCPosition = nil
local currentTool = nil
local characterConnections = {}
local Booms = {"TAP"}
local Skills = {"X"}
local aimlockActive = false
local nearestZTarget = nil
local godhumanZActive = false
local aimRenderConn = nil
local aimTimeoutTask = nil
local silentInstalled = false
local walkSpeedConn = nil

-- Remotes con pcall
local CommE, CommF
pcall(function() CommE = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild("CommE", 5) end)
pcall(function() CommF = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild("CommF_", 5) end)

-- ============================================================
-- TEAM CHECK
-- ============================================================
local function isAllyWithMe(targetPlayer)
    local myGui = lp:FindFirstChild("PlayerGui")
    if not myGui then return false end
    local scrolling = myGui:FindFirstChild("Main")
        and myGui.Main:FindFirstChild("Allies")
        and myGui.Main.Allies:FindFirstChild("Container")
        and myGui.Main.Allies.Container:FindFirstChild("Allies")
        and myGui.Main.Allies.Container.Allies:FindFirstChild("ScrollingFrame")
    if scrolling then
        for _, frame in pairs(scrolling:GetDescendants()) do
            if frame:IsA("ImageButton") and frame.Name == targetPlayer.Name then return true end
        end
    end
    return false
end

local function isEnemy(targetPlayer)
    if not targetPlayer or targetPlayer == lp then return false end
    local myTeam = lp.Team
    local targetTeam = targetPlayer.Team
    if myTeam and targetTeam then
        if myTeam.Name == "Pirates" and targetTeam.Name == "Marines" then return true
        elseif myTeam.Name == "Marines" and targetTeam.Name == "Pirates" then return true end
        if myTeam.Name == "Pirates" and targetTeam.Name == "Pirates" then
            if isAllyWithMe(targetPlayer) then return false end
            return true
        end
        if myTeam.Name == "Marines" and targetTeam.Name == "Marines" then return false end
    end
    return true
end

-- ============================================================
-- BASE FUNCTIONS
-- ============================================================
local function getHRP()
    local char = lp.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHum()
    local char = lp.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function getPredictedPosition(hrp)
    if not hrp then return nil end
    local humanoid = hrp.Parent:FindFirstChildOfClass("Humanoid")
    if not humanoid then return hrp.Position end
    if not predictionEnabled or humanoid.WalkSpeed < 5 then return hrp.Position end
    return hrp.Position + (hrp.AssemblyLinearVelocity * predictionAmount)
end

local function getClosestPlayer()
    local hrp = getHRP()
    if not hrp then return nil end
    local closest, closestDist = nil, maxRange
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and isEnemy(p) and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local eHRP = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and hum.Health > 0 and eHRP then
                local dist = (eHRP.Position - hrp.Position).Magnitude
                if dist < closestDist then closestDist = dist; closest = p end
            end
        end
    end
    return closest
end

local function getClosestNPC()
    local hrp = getHRP()
    if not hrp then return nil end
    local closest, closestDist = nil, maxRange
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    for _, v in ipairs(enemies:GetChildren()) do
        local eHRP = v:FindFirstChild("HumanoidRootPart")
        local hum = v:FindFirstChildOfClass("Humanoid")
        if eHRP and hum and hum.Health > 0 then
            local dist = (eHRP.Position - hrp.Position).Magnitude
            if dist < closestDist then closestDist = dist; closest = v end
        end
    end
    return closest
end

local function GetNearestTarget(maxDist)
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = char.HumanoidRootPart
    local closest, closestDist = nil, maxDist or 100
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp and isEnemy(plr) and plr.Character then
            local otherHRP = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChild("Humanoid")
            if otherHRP and hum and hum.Health > 0 then
                local dist = (otherHRP.Position - hrp.Position).Magnitude
                if dist < closestDist then closestDist = dist; closest = plr.Character end
            end
        end
    end
    return closest
end

-- ============================================================
-- SORU AIM
-- ============================================================
local mouse = lp:GetMouse()
pcall(function()
    local mt = getrawmetatable(game)
    local oldIndex = mt.__index
    setreadonly(mt, false)
    mt.__index = newcclosure(function(self, key)
        if not soruAimEnabled then return oldIndex(self, key) end
        if (key == "Hit" or key == "Target") and self == mouse then
            local enemy = getClosestPlayer()
            if enemy and enemy.Character then
                local eHRP = enemy.Character:FindFirstChild("HumanoidRootPart")
                if eHRP then
                    if key == "Hit" then return CFrame.new(eHRP.Position)
                    elseif key == "Target" then return eHRP end
                end
            end
        end
        return oldIndex(self, key)
    end)
    setreadonly(mt, true)
end)

-- ============================================================
-- INF SORU
-- ============================================================
local function setupInfSoru(char)
    if infSoruEnabled then pcall(function() char:SetAttribute("FlashstepCooldown", 2) end) end
end
local function startInfSoru()
    if lp.Character then pcall(function() lp.Character:SetAttribute("FlashstepCooldown", 2) end) end
    if infSoruConn then infSoruConn:Disconnect() end
    infSoruConn = lp.CharacterAdded:Connect(setupInfSoru)
end
local function stopInfSoru()
    if infSoruConn then infSoruConn:Disconnect(); infSoruConn = nil end
    pcall(function() if lp.Character then lp.Character:SetAttribute("FlashstepCooldown", 0) end end)
end

-- ============================================================
-- SILENT AIM
-- ============================================================
local function installSilentAim()
    if silentInstalled then return end
    silentInstalled = true

    RunService.Heartbeat:Connect(function()
        if not silentAimPlayersEnabled and not silentAimNPCsEnabled then
            PlayersPosition = nil; NPCPosition = nil; return
        end
        if silentAimPlayersEnabled then
            local enemy = getClosestPlayer()
            if enemy and enemy.Character then
                local eHRP = enemy.Character:FindFirstChild("HumanoidRootPart")
                PlayersPosition = eHRP and getPredictedPosition(eHRP) or nil
            else PlayersPosition = nil end
        else PlayersPosition = nil end
        if silentAimNPCsEnabled then
            local npc = getClosestNPC()
            if npc then
                local eHRP = npc:FindFirstChild("HumanoidRootPart")
                NPCPosition = eHRP and getPredictedPosition(eHRP) or nil
            else NPCPosition = nil end
        else NPCPosition = nil end
    end)

    pcall(function()
        local ok, hookMeta = pcall(getrawmetatable, game)
        if ok and hookMeta then
            setreadonly(hookMeta, false)
            local OldHook
            OldHook = hookmetamethod(game, "__namecall", function(self, V1, V2, ...)
                local Method = (getnamecallmethod and getnamecallmethod():lower()) or ""
                if tostring(self) == "RemoteEvent" and Method == "fireserver" then
                    if typeof(V1) == "Vector3" then
                        if silentAimPlayersEnabled and PlayersPosition then return OldHook(self, PlayersPosition, V2, ...)
                        elseif silentAimNPCsEnabled and NPCPosition then return OldHook(self, NPCPosition, V2, ...) end
                    end
                    if type(V1) == "string" and table.find(Booms, V1) and zSkillOrM1 then
                        if silentAimPlayersEnabled and PlayersPosition then return OldHook(self, V1, PlayersPosition, nil, ...)
                        elseif silentAimNPCsEnabled and NPCPosition then return OldHook(self, V1, NPCPosition, nil, ...) end
                    end
                elseif Method == "invokeserver" then
                    if type(V1) == "string" and table.find(Skills, V1) then
                        if silentAimPlayersEnabled and PlayersPosition then return OldHook(self, V1, PlayersPosition, nil, ...)
                        elseif silentAimNPCsEnabled and NPCPosition then return OldHook(self, V1, NPCPosition, nil, ...) end
                    end
                end
                return OldHook(self, V1, V2, ...)
            end)
            setreadonly(hookMeta, true)
        end
    end)
end

-- ============================================================
-- Z SKILL AIMLOCK
-- ============================================================
local function stopAimlock()
    if not aimlockActive then return end
    aimlockActive = false; nearestZTarget = nil; godhumanZActive = false
    if aimRenderConn then pcall(function() aimRenderConn:Disconnect() end); aimRenderConn = nil end
    if aimTimeoutTask then pcall(function() task.cancel(aimTimeoutTask) end); aimTimeoutTask = nil end
end

local function startAimlock()
    if not zSkillsEnabled or aimlockActive then return end
    nearestZTarget = GetNearestTarget(1000)
    if not nearestZTarget then return end
    aimlockActive = true
    aimRenderConn = RunService.RenderStepped:Connect(function()
        if not zSkillsEnabled then stopAimlock() return end
        if aimlockActive and nearestZTarget and nearestZTarget:FindFirstChild("HumanoidRootPart") then
            local cam = workspace.CurrentCamera
            if cam then cam.CFrame = CFrame.lookAt(cam.CFrame.Position, nearestZTarget.HumanoidRootPart.Position) end
        else stopAimlock() end
    end)
    aimTimeoutTask = task.delay(1, function()
        if aimlockActive then stopAimlock() end
    end)
end

pcall(function()
    if not getgenv().ZSkillHooked then
        getgenv().ZSkillHooked = true
        local oldNC
        oldNC = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "InvokeServer" or method == "FireServer" then
                local a1 = args[1]
                if typeof(a1) == "string" and a1:upper() == "Z" then
                    if currentTool and currentTool.Name == "Godhuman" then godhumanZActive = true end
                end
            end
            return oldNC(self, ...)
        end)
    end
end)

UIS.TouchEnded:Connect(function(touch)
    if not zSkillsEnabled then return end
    local cam = workspace.CurrentCamera
    if not cam or not touch or not touch.Position then return end
    if touch.Position.X > cam.ViewportSize.X / 2 then
        if currentTool and currentTool.Name == "Godhuman" and godhumanZActive then
            if not aimlockActive then startAimlock() end
        end
    end
end)

-- ============================================================
-- AUTO KEN
-- ============================================================
local function startAutoKenLoop()
    if autoKenRunning then return end
    autoKenRunning = true
    task.spawn(function()
        while autoKenEnabled do
            task.wait(0.1)
            pcall(function()
                local char = lp.Character
                if not char then return end
                if game:GetService("CollectionService"):HasTag(char, "Ken") then
                    local playerGui = lp:FindFirstChild("PlayerGui")
                    if playerGui then
                        local kenButton = playerGui:FindFirstChild("MobileContextButtons")
                            and playerGui.MobileContextButtons.ContextButtonFrame:FindFirstChild("BoundActionKen")
                        if kenButton and kenButton:GetAttribute("Selected") ~= true then
                            kenButton:SetAttribute("Selected", true)
                        end
                    end
                    local observationManager = getrenv()._G.OM
                    if observationManager and not observationManager.active then
                        observationManager.radius = 0
                        observationManager:setActive(true)
                        if CommE then CommE:FireServer("Ken", true) end
                    end
                end
            end)
        end
        autoKenRunning = false
    end)
end

-- ============================================================
-- ESP
-- ============================================================
local ESPs = {}
local espFolder = game.CoreGui:FindFirstChild("GlobalESP")
if not espFolder then
    espFolder = Instance.new("Folder")
    espFolder.Name = "GlobalESP"
    espFolder.Parent = game.CoreGui
end

local function getESPColor(p)
    if p == lp then return Color3.fromRGB(0, 255, 0) end
    if isAllyWithMe(p) then return Color3.fromRGB(0, 255, 0) end
    if isEnemy(p) then return Color3.fromRGB(255, 80, 80) end
    return Color3.fromRGB(0, 255, 0)
end

local function createESP(targetPlayer)
    if ESPs[targetPlayer] then return end
    local char = targetPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = targetPlayer.Name; billboard.Adornee = head
    billboard.Size = UDim2.fromOffset(220, 50); billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 3, 0); billboard.Parent = espFolder
    local levelLabel = Instance.new("TextLabel")
    levelLabel.Name = "LevelLabel"; levelLabel.Size = UDim2.new(1, 0, 0.5, 0)
    levelLabel.BackgroundTransparency = 1; levelLabel.Text = "Lv. ???"
    levelLabel.TextColor3 = Color3.fromRGB(0, 170, 255); levelLabel.TextStrokeTransparency = 0.2
    levelLabel.Font = Enum.Font.SourceSansBold; levelLabel.TextSize = 14
    levelLabel.Parent = billboard
    local mainLabel = Instance.new("TextLabel")
    mainLabel.Name = "MainLabel"; mainLabel.Size = UDim2.new(1, 0, 0.5, 0)
    mainLabel.Position = UDim2.new(0, 0, 0.5, 0); mainLabel.BackgroundTransparency = 1
    mainLabel.Text = "[0] " .. targetPlayer.DisplayName .. " (0m)"
    mainLabel.TextColor3 = getESPColor(targetPlayer); mainLabel.TextStrokeTransparency = 0.2
    mainLabel.Font = Enum.Font.SourceSansBold; mainLabel.TextSize = 16
    mainLabel.Parent = billboard
    ESPs[targetPlayer] = billboard
end

RunService.Heartbeat:Connect(function()
    if not espEnabled then
        for _, gui in pairs(ESPs) do if gui then gui.Enabled = false end end
        return
    end
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= lp then
            if not ESPs[targetPlayer] then createESP(targetPlayer) end
            local gui = ESPs[targetPlayer]
            if gui then
                local char = targetPlayer.Character
                local head = char and char:FindFirstChild("Head")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local myHRP = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if char and head and hrp and hum and myHRP then
                    gui.Adornee = head; gui.Enabled = true
                    local dist = (myHRP.Position - hrp.Position).Magnitude
                    local nameLabel = gui:FindFirstChild("MainLabel")
                    local levelLabel = gui:FindFirstChild("LevelLabel")
                    if levelLabel then
                        local dataFolder = targetPlayer:FindFirstChild("Data")
                        local levelValue = dataFolder and dataFolder:FindFirstChild("Level")
                        levelLabel.Text = levelValue and ("Lv. " .. levelValue.Value) or "Lv. ???"
                    end
                    if nameLabel then
                        nameLabel.Text = "[" .. math.floor(hum.Health) .. "] " .. targetPlayer.DisplayName .. " (" .. math.floor(dist) .. "m)"
                        nameLabel.TextColor3 = getESPColor(targetPlayer)
                    end
                else gui.Enabled = false end
            end
        end
    end
end)

-- ============================================================
-- V3 AUTO
-- ============================================================
local v3Loop = nil
local function startV3Loop()
    if v3LoopRunning then return end
    v3LoopRunning = true
    v3Loop = task.spawn(function()
        while v3LoopRunning do
            if not lp or not lp.Parent then break end
            pcall(function() if CommE then CommE:FireServer("ActivateAbility") end end)
            task.wait(31)
        end
        v3Loop = nil
    end)
end
local function stopV3Loop() v3LoopRunning = false; v3Loop = nil end

-- ============================================================
-- BUNNY HOP
-- ============================================================
local function installBunnyHop()
    if bunnyHopHooked then return end
    bunnyHopHooked = true
    pcall(function()
        local old
        old = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if (method == "InvokeServer" or method == "FireServer") then
                local a1 = args[1]

