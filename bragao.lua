-- ═══════════════════════════════════════════════════════════
-- BRAGAO HUB - UI PROFESIONAL CON TABS
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

print("[Bragao Hub] ✅ Iniciando UI mejorada...")

-- ═══════════════════════════════════════════════════════════
-- CONFIGURACIÓN
-- ═══════════════════════════════════════════════════════════
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
    uiMinimized = false,
}

-- Remotes
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
    print("[Silent Aim] ✅ Instalado")

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
    print("[Auto Ken] ✅ Iniciado")
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
        print("[Infinite Jump] ✅ Activado")
        State.infJumpConn = UIS.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                local hum = getHum()
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    elseif not Config.InfiniteJump and State.infJumpConn then
        print("[Infinite Jump] ❌ Desactivado")
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
        print("[Anti-AFK] ✅ Activado")
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
-- CREAR UI CON TABS
-- ═══════════════════════════════════════════════════════════

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BragaoHubUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = lp:WaitForChild("PlayerGui")

-- MAIN FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 550)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- HEADER
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ BRAGAO HUB"
title.TextColor3 = Color3.fromRGB(255, 200, 0)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- MINIMIZE BTN
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 40, 0, 35)
minimizeBtn.Position = UDim2.new(1, -90, 0.5, -17)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Text = "−"
minimizeBtn.TextSize = 20
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeBtn

-- CLOSE BTN
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 40, 0, 35)
closeBtn.Position = UDim2.new(1, -45, 0.5, -17)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"
closeBtn.TextSize = 20
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- CLOSE BUTTON FUNCTION
closeBtn.MouseButton1Click:Connect(function()
    mainFrame:Destroy()
end)

-- MINIMIZE BUTTON FUNCTION
minimizeBtn.MouseButton1Click:Connect(function()
    State.uiMinimized = not State.uiMinimized
    if State.uiMinimized then
        mainFrame.Size = UDim2.new(0, 420, 0, 50)
        minimizeBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 420, 0, 550)
        minimizeBtn.Text = "−"
    end
end)

-- TABS FRAME
local tabsFrame = Instance.new("Frame")
tabsFrame.Name = "TabsFrame"
tabsFrame.Size = UDim2.new(1, 0, 0, 45)
tabsFrame.Position = UDim2.new(0, 0, 0, 50)
tabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
tabsFrame.BorderSizePixel = 0
tabsFrame.Parent = mainFrame

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Orientation = Enum.Orientation.Horizontal
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.Padding = UDim.new(0, 2)
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Parent = tabsFrame

-- CONTENT FRAME
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -95)
contentFrame.Position = UDim2.new(0, 0, 0, 95)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 3
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 8)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentFrame

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingLeft = UDim.new(0, 10)
contentPadding.PaddingRight = UDim.new(0, 10)
contentPadding.PaddingTop = UDim.new(0, 10)
contentPadding.PaddingBottom = UDim.new(0, 10)
contentPadding.Parent = contentFrame

print("[Bragao Hub] ✅ UI Base creada")

-- ═══════════════════════════════════════════════════════════
-- FUNCIONES UI
-- ═══════════════════════════════════════════════════════════

local currentTab = nil
local tabs = {}

local function createTab(tabName)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabName .. "Tab"
    tabBtn.Size = UDim2.new(0, 0, 1, 0)
    tabBtn.AutomaticSize = Enum.AutomaticSize.X
    tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    tabBtn.BorderSizePixel = 0
    tabBtn.Text = "  " .. tabName .. "  "
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.Parent = tabsFrame

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 5)
    tabCorner.Parent = tabBtn

    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.Visible = false
    tabContent.Parent = contentFrame

    local tabContentLayout = Instance.new("UIListLayout")
    tabContentLayout.Padding = UDim.new(0, 8)
    tabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabContentLayout.Parent = tabContent

    tabBtn.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.Visible = false
            local oldBtn = tabsFrame:FindFirstChild(currentTab.Name:gsub("Content", "Tab"))
            if oldBtn then oldBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55) end
        end
        tabContent.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
        currentTab = tabContent
    end)

    tabs[tabName] = {Button = tabBtn, Content = tabContent}
    return tabContent
end

local function createToggle(text, callback, parent)
    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(1, 0, 0, 40)
    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    toggle.BorderSizePixel = 0
    toggle.Parent = parent

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggle

    local button = Instance.new("TextButton")
    button.Name = "ToggleButton"
    button.Size = UDim2.new(0, 45, 0, 24)
    button.Position = UDim2.new(1, -50, 0.5, -12)
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    button.BorderSizePixel = 0
    button.Text = "OFF"
    button.TextSize = 10
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.Parent = toggle

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button

    local state = false
    button.MouseButton1Click:Connect(function()
        state = not state
        button.BackgroundColor3 = state and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(100, 100, 120)
        button.Text = state and "ON" or "OFF"
        callback(state)
    end)

    return toggle
end

local function createSlider(title, callback, parent, minVal, maxVal, defaultVal)
    local sliderContainer = Instance.new("Frame")
    sliderContainer.Size = UDim2.new(1, 0, 0, 60)
    sliderContainer.BackgroundTransparency = 1
    sliderContainer.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderContainer

    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 35)
    sliderFrame.Position = UDim2.new(0, 0, 0, 20)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = sliderContainer

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 6)
    sliderCorner.Parent = sliderFrame

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -10, 1, 0)
    input.Position = UDim2.new(0, 5, 0, 0)
    input.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Text = tostring(defaultVal)
    input.TextSize = 12
    input.Font = Enum.Font.Gotham
    input.BorderSizePixel = 0
    input.Parent = sliderFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 4)
    inputCorner.Parent = input

    input.FocusLost:Connect(function()
        local num = tonumber(input.Text)
        if num then
            num = math.max(minVal, math.min(maxVal, num))
            input.Text = tostring(num)
            callback(num)
        else
            input.Text = tostring(defaultVal)
        end
    end)

    return sliderContainer
end

print("[Bragao Hub] ✅ Funciones UI creadas")

-- ═══════════════════════════════════════════════════════════
-- CREAR TABS Y OPCIONES
-- ═══════════════════════════════════════════════════════════

-- TAB COMBAT
local combatTab = createTab("⚔️ Combat")
createToggle("Silent Aim Players", function(value)
    Config.SilentAimPlayers = value
    if value then installSilentAim() end
    print("[Config] Silent Aim Players: " .. tostring(value))
end, combatTab)

createToggle("Silent Aim NPCs", function(value)
    Config.SilentAimNPCs = value
    if value then installSilentAim() end
    print("[Config] Silent Aim NPCs: " .. tostring(value))
end, combatTab)

createToggle("Auto Ken", function(value)
    Config.AutoKen = value
    if value then startAutoKenLoop() end
    print("[Config] Auto Ken: " .. tostring(value))
end, combatTab)

-- TAB AIM
local aimTab = createTab("🎯 Aim")
createToggle("Prediction", function(value)
    Config.Prediction = value
    print("[Config] Prediction: " .. tostring(value))
end, aimTab)

-- TAB MOVEMENT
local movementTab = createTab("🏃 Movement")
createToggle("Infinite Jump", function(value)
    Config.InfiniteJump = value
    setupInfiniteJump()
    print("[Config] Infinite Jump: " .. tostring(value))
end, movementTab)

createSlider("Walk Speed", function(value)
    Config.WalkSpeed = value
    print("[Config] Walk Speed: " .. tostring(value))
end, movementTab, 16, 100, 16)

-- TAB VISUAL
local visualTab = createTab("👁️ Visual")
createToggle("ESP", function(value)
    Config.ESP = value
    print("[Config] ESP: " .. tostring(value))
end, visualTab)

-- TAB UTILS
local utilsTab = createTab("⚙️ Utils")
createToggle("Anti-AFK", function(value)
    Config.AntiAFK = value
    setupAntiAFK()
    print("[Config] Anti-AFK: " .. tostring(value))
end, utilsTab)

print("[Bragao Hub] ✅ Todos los tabs y opciones creados")

-- SELECCIONAR TAB POR DEFECTO
if tabs["⚔️ Combat"] then
    tabs["⚔️ Combat"].Button:Fire("MouseButton1Click")
end

-- MENSAJE FINAL
print("")
print("╔════════════════════════════════════════╗")
print("║  ✅ BRAGAO HUB UI MEJORADA CARGADO    ║")
print("╚════════════════════════════════════════╝")
print("")
print("📍 FEATURES:")
print("   ⚔️  Combat Options")
print("   🎯  Aim Settings")
print("   🏃  Movement Controls")
print("   👁️   ESP Visual")
print("   ⚙️   Utilities")
print("")
print("🎮 Interfaz con tabs, minimizar y cerrar!")
print("")
