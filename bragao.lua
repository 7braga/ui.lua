-- ═══════════════════════════════════════════════════════════
-- BRAGAO HUB - UI SIMPLE Y FUNCIONAL
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

print("[Bragao Hub] ✅ Iniciando UI...")

-- CONFIGURACIÓN
local Config = {
    SilentAimPlayers = false,
    SilentAimNPCs = false,
    Prediction = false,
    PredictionAmount = 0.1,
    AutoKen = false,
    ESP = false,
    InfiniteJump = false,
    WalkSpeed = 16,
    AntiAFK = false,
}

local State = {
    silentInstalled = false,
    autoKenRunning = false,
    infJumpConn = nil,
    PlayersPosition = nil,
    NPCPosition = nil,
    maxRange = 500,
    antiAFKRunning = false,
}

local CommE, CommF
pcall(function() CommE = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild("CommE", 5) end)
pcall(function() CommF = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild("CommF_", 5) end)

-- ═══════════════════════════════════════════════════════════
-- FUNCIONES BASE
-- ═══════════════════════════════════════════════════════════

local function getHRP()
    local char = lp.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHum()
    local char = lp.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function isEnemy(targetPlayer)
    if not targetPlayer or targetPlayer == lp then return false end
    local myTeam = lp.Team
    local targetTeam = targetPlayer.Team
    if myTeam and targetTeam then
        if myTeam.Name == "Pirates" and targetTeam.Name == "Marines" then return true
        elseif myTeam.Name == "Marines" and targetTeam.Name == "Pirates" then return true end
    end
    return true
end

local function getPredictedPosition(hrp)
    if not hrp then return nil end
    local humanoid = hrp.Parent:FindFirstChildOfClass("Humanoid")
    if not humanoid then return hrp.Position end
    if not Config.Prediction or humanoid.WalkSpeed < 5 then return hrp.Position end
    return hrp.Position + (hrp.AssemblyLinearVelocity * Config.PredictionAmount)
end

local function getClosestPlayer()
    local hrp = getHRP()
    if not hrp then return nil end
    local closest, closestDist = nil, State.maxRange
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
    local closest, closestDist = nil, State.maxRange
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

-- ═══════════════════════════════════════════════════════════
-- SILENT AIM
-- ═══════════════════════════════════════════════════════════

local function installSilentAim()
    if State.silentInstalled then return end
    State.silentInstalled = true

    RunService.Heartbeat:Connect(function()
        if not Config.SilentAimPlayers and not Config.SilentAimNPCs then
            State.PlayersPosition = nil; State.NPCPosition = nil; return
        end
        if Config.SilentAimPlayers then
            local enemy = getClosestPlayer()
            if enemy and enemy.Character then
                local eHRP = enemy.Character:FindFirstChild("HumanoidRootPart")
                State.PlayersPosition = eHRP and getPredictedPosition(eHRP) or nil
            else State.PlayersPosition = nil end
        else State.PlayersPosition = nil end
        if Config.SilentAimNPCs then
            local npc = getClosestNPC()
            if npc then
                local eHRP = npc:FindFirstChild("HumanoidRootPart")
                State.NPCPosition = eHRP and getPredictedPosition(eHRP) or nil
            else State.NPCPosition = nil end
        else State.NPCPosition = nil end
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
                        if Config.SilentAimPlayers and State.PlayersPosition then return OldHook(self, State.PlayersPosition, V2, ...)
                        elseif Config.SilentAimNPCs and State.NPCPosition then return OldHook(self, State.NPCPosition, V2, ...) end
                    end
                end
                return OldHook(self, V1, V2, ...)
            end)
            setreadonly(hookMeta, true)
        end
    end)
end

-- ═══════════════════════════════════════════════════════════
-- AUTO KEN
-- ═══════════════════════════════════════════════════════════

local function startAutoKenLoop()
    if State.autoKenRunning then return end
    State.autoKenRunning = true
    task.spawn(function()
        while Config.AutoKen do
            task.wait(0.1)
            pcall(function()
                local char = lp.Character
                if not char then return end
                if game:GetService("CollectionService"):HasTag(char, "Ken") then
                    if CommE then CommE:FireServer("Ken", true) end
                end
            end)
        end
        State.autoKenRunning = false
    end)
end

-- ═══════════════════════════════════════════════════════════
-- ESP
-- ═══════════════════════════════════════════════════════════

local ESPs = {}
local espFolder = game.CoreGui:FindFirstChild("GlobalESP")
if not espFolder then
    espFolder = Instance.new("Folder")
    espFolder.Name = "GlobalESP"
    espFolder.Parent = game.CoreGui
end

local function getESPColor(p)
    if p == lp then return Color3.fromRGB(0, 255, 0) end
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
    if not Config.ESP then
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

-- ═══════════════════════════════════════════════════════════
-- INFINITE JUMP
-- ═══════════════════════════════════════════════════════════

local function setupInfiniteJump()
    if Config.InfiniteJump and not State.infJumpConn then
        State.infJumpConn = UIS.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                local hum = getHum()
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    elseif not Config.InfiniteJump and State.infJumpConn then
        State.infJumpConn:Disconnect()
        State.infJumpConn = nil
    end
end

-- ═══════════════════════════════════════════════════════════
-- WALK SPEED
-- ═══════════════════════════════════════════════════════════

RunService.Heartbeat:Connect(function()
    if Config.WalkSpeed > 16 then
        local hum = getHum()
        if hum then hum.WalkSpeed = Config.WalkSpeed end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- ANTI AFK
-- ═══════════════════════════════════════════════════════════

local function setupAntiAFK()
    if Config.AntiAFK and not State.antiAFKRunning then
        State.antiAFKRunning = true
        task.spawn(function()
            while Config.AntiAFK do
                task.wait(60)
                pcall(function()
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0))
                end)
            end
            State.antiAFKRunning = false
        end)
    end
end

-- ═══════════════════════════════════════════════════════════
-- CREAR UI SIMPLE
-- ═══════════════════════════════════════════════════════════

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BragaoHubUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = lp:WaitForChild("PlayerGui")

-- MAIN FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 550, 0, 700)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -350)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(80, 150, 220)
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- HEADER
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
header.BorderSizePixel = 0
header.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ BRAGAO HUB"
title.TextColor3 = Color3.fromRGB(255, 200, 0)
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- MINIMIZE BTN
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 50, 0, 40)
minimizeBtn.Position = UDim2.new(1, -110, 0.5, -20)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Text = "−"
minimizeBtn.TextSize = 28
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeBtn

-- CLOSE BTN
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 50, 0, 40)
closeBtn.Position = UDim2.new(1, -55, 0.5, -20)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"
closeBtn.TextSize = 28
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- CLOSE FUNCTION
closeBtn.MouseButton1Click:Connect(function()
    mainFrame:Destroy()
end)

-- MINIMIZE FUNCTION
local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Size = UDim2.new(0, 550, 0, 55)
        minimizeBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 550, 0, 700)
        minimizeBtn.Text = "−"
    end
end)

-- ═══════════════════════════════════════════════════════════
-- CREAR TABS - MANUAL Y SIMPLE
-- ═══════════════════════════════════════════════════════════

local function createToggleSimple(text, configKey, parent, yPos, callback)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0.9, 0, 0, 50)
    bg.Position = UDim2.new(0.05, 0, 0, yPos)
    bg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    bg.BorderSizePixel = 0
    bg.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = bg

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 14
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = bg

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 55, 0, 32)
    btn.Position = UDim2.new(1, -65, 0.5, -16)
    btn.BackgroundColor3 = Color3.fromRGB(100, 100, 130)
    btn.BorderSizePixel = 0
    btn.Text = "OFF"
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.Parent = bg

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(100, 100, 130)
        btn.Text = Config[configKey] and "ON" or "OFF"
        callback(Config[configKey])
    end)
end

-- CREAR TABS
local tabs = {}

local function createTab(tabName, tabNumber)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabName
    tabBtn.Size = UDim2.new(0.19, 0, 0, 45)
    tabBtn.Position = UDim2.new((tabNumber - 1) * 0.2, 0, 0, 55)
    tabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    tabBtn.BorderSizePixel = 0
    tabBtn.Text = tabName
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.Parent = mainFrame

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabBtn

    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, -100)
    tabContent.Position = UDim2.new(0, 0, 0, 100)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.Visible = false
    tabContent.Parent = mainFrame

    tabBtn.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do
            tab.Content.Visible = false
            tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            tab.Button.TextColor3 = Color3.fromRGB(180, 180, 200)
        end
        tabContent.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(80, 150, 220)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    tabs[tabName] = {Button = tabBtn, Content = tabContent}
    return tabContent
end

-- CREAR TABS
local combatTab = createTab("COMBAT", 1)
local aimTab = createTab("AIM", 2)
local movementTab = createTab("MOVEM.", 3)
local visualTab = createTab("VISUAL", 4)
local utilsTab = createTab("UTILS", 5)

-- ═══════════════════════════════════════════════════════════
-- AGREGAR OPCIONES A CADA TAB
-- ═══════════════════════════════════════════════════════════

-- COMBAT TAB
createToggleSimple("Silent Aim Players", "SilentAimPlayers", combatTab, 10, function(val)
    if val then installSilentAim() end
end)

createToggleSimple("Silent Aim NPCs", "SilentAimNPCs", combatTab, 65, function(val)
    if val then installSilentAim() end
end)

createToggleSimple("Auto Ken", "AutoKen", combatTab, 120, function(val)
    if val then startAutoKenLoop() end
end)

-- AIM TAB
createToggleSimple("Prediction", "Prediction", aimTab, 10, function(val) end)

-- MOVEMENT TAB
createToggleSimple("Infinite Jump", "InfiniteJump", movementTab, 10, function(val)
    setupInfiniteJump()
end)

-- WALK SPEED INPUT
local walkSpeedBg = Instance.new("Frame")
walkSpeedBg.Size = UDim2.new(0.9, 0, 0, 50)
walkSpeedBg.Position = UDim2.new(0.05, 0, 0, 65)
walkSpeedBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
walkSpeedBg.BorderSizePixel = 0
walkSpeedBg.Parent = movementTab

local walkCorner = Instance.new("UICorner")
walkCorner.CornerRadius = UDim.new(0, 8)
walkCorner.Parent = walkSpeedBg

local walkLabel = Instance.new("TextLabel")
walkLabel.Size = UDim2.new(0.5, 0, 1, 0)
walkLabel.BackgroundTransparency = 1
walkLabel.Text = "Walk Speed:"
walkLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
walkLabel.TextSize = 14
walkLabel.Font = Enum.Font.GothamSemibold
walkLabel.TextXAlignment = Enum.TextXAlignment.Left
walkLabel.Parent = walkSpeedBg

local walkInput = Instance.new("TextBox")
walkInput.Size = UDim2.new(0.4, -10, 0.6, 0)
walkInput.Position = UDim2.new(0.55, 0, 0.2, 0)
walkInput.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
walkInput.TextColor3 = Color3.fromRGB(255, 255, 255)
walkInput.Text = "16"
walkInput.TextSize = 12
walkInput.Font = Enum.Font.Gotham
walkInput.BorderSizePixel = 0
walkInput.Parent = walkSpeedBg

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 5)
inputCorner.Parent = walkInput

walkInput.FocusLost:Connect(function()
    local num = tonumber(walkInput.Text)
    if num then
        num = math.max(16, math.min(100, num))
        Config.WalkSpeed = num
        walkInput.Text = tostring(num)
    else
        walkInput.Text = "16"
    end
end)

-- VISUAL TAB
createToggleSimple("ESP", "ESP", visualTab, 10, function(val) end)

-- UTILS TAB
createToggleSimple("Anti-AFK", "AntiAFK", utilsTab, 10, function(val)
    setupAntiAFK()
end)

-- ═══════════════════════════════════════════════════════════
-- SELECCIONAR TAB POR DEFECTO
-- ═══════════════════════════════════════════════════════════

tabs["COMBAT"].Button:Fire("MouseButton1Click")

print("╔════════════════════════════════════════╗")
print("║  ✅ BRAGAO HUB - CARGADO CORRECTAMENTE║")
print("╚════════════════════════════════════════╝")
