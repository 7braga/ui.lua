-- ═══════════════════════════════════════════════════════════
-- BRAGAO HUB - SIN WINDUI - UI CUSTOM FUNCIONAL
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

print("[bragao Hub] ✅ Iniciando sin WindUI...")

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
    print("[Silent Aim] Instalado ✅")

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
    print("[Auto Ken] Iniciado ✅")
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
        print("[Infinite Jump] Activado ✅")
        State.infJumpConn = UIS.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                local hum = getHum()
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    elseif not Config.InfiniteJump and State.infJumpConn then
        print("[Infinite Jump] Desactivado ❌")
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
        print("[Anti-AFK] Activado ✅")
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
-- CREAR UI CUSTOM (SIN WINDUI)
-- ═══════════════════════════════════════════════════════════

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BragaoHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = lp:WaitForChild("PlayerGui")

print("[bragao Hub] ✅ ScreenGui creado")

-- MAIN FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 500)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

print("[bragao Hub] ✅ Frame principal creado")

-- HEADER
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ BRAGAO HUB"
title.TextColor3 = Color3.fromRGB(255, 200, 0)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"
closeBtn.TextSize = 20
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 5)
closeBtnCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    mainFrame:Destroy()
end)

print("[bragao Hub] ✅ Header y botón cerrar creados")

-- CONTENT FRAME (scrollable)
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 3
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 10)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentFrame

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingLeft = UDim.new(0, 10)
contentPadding.PaddingRight = UDim.new(0, 10)
contentPadding.PaddingTop = UDim.new(0, 10)
contentPadding.PaddingBottom = UDim.new(0, 10)
contentPadding.Parent = contentFrame

print("[bragao Hub] ✅ Content frame creado")

-- FUNCIONES PARA CREAR ELEMENTOS
local function createLabel(text, parent)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function createToggle(text, callback, parent)
    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(1, 0, 0, 30)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toggle.BorderSizePixel = 0
    toggle.Parent = parent

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 5)
    toggleCorner.Parent = toggle

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggle

    local button = Instance.new("TextButton")
    button.Name = "ToggleButton"
    button.Size = UDim2.new(0, 40, 0, 20)
    button.Position = UDim2.new(1, -45, 0.5, -10)
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    button.BorderSizePixel = 0
    button.Text = "OFF"
    button.TextSize = 10
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.Parent = toggle

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 3)
    buttonCorner.Parent = button

    local state = false
    button.MouseButton1Click:Connect(function()
        state = not state
        button.BackgroundColor3 = state and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(200, 80, 80)
        button.Text = state and "ON" or "OFF"
        callback(state)
    end)

    return toggle, button
end

print("[bragao Hub] ✅ Funciones de UI creadas")

-- ═══════════════════════════════════════════════════════════
-- AGREGAR ELEMENTOS A LA UI
-- ═══════════════════════════════════════════════════════════

createLabel("⚔️ COMBAT", contentFrame)

createToggle("Silent Aim Players", function(value)
    Config.SilentAimPlayers = value
    if value then installSilentAim() end
    print("[Config] Silent Aim Players: " .. tostring(value))
end, contentFrame)

createToggle("Silent Aim NPCs", function(value)
    Config.SilentAimNPCs = value
    if value then installSilentAim() end
    print("[Config] Silent Aim NPCs: " .. tostring(value))
end, contentFrame)

createToggle("Auto Ken", function(value)
    Config.AutoKen = value
    if value then startAutoKenLoop() end
    print("[Config] Auto Ken: " .. tostring(value))
end, contentFrame)

createLabel("🎯 AIM", contentFrame)

createToggle("Prediction", function(value)
    Config.Prediction = value
    print("[Config] Prediction: " .. tostring(value))
end, contentFrame)

createLabel("🏃 MOVEMENT", contentFrame)

createToggle("Infinite Jump", function(value)
    Config.InfiniteJump = value
    setupInfiniteJump()
    print("[Config] Infinite Jump: " .. tostring(value))
end, contentFrame)

createLabel("👁️ VISUAL", contentFrame)

createToggle("ESP", function(value)
    Config.ESP = value
    print("[Config] ESP: " .. tostring(value))
end, contentFrame)

createLabel("⚙️ UTILS", contentFrame)

createToggle("Anti-AFK", function(value)
    Config.AntiAFK = value
    setupAntiAFK()
    print("[Config] Anti-AFK: " .. tostring(value))
end, contentFrame)

createLabel("Walk Speed (Slider)", contentFrame)

-- Walk Speed Slider
local walkSpeedFrame = Instance.new("Frame")
walkSpeedFrame.Size = UDim2.new(1, 0, 0, 30)
walkSpeedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
walkSpeedFrame.BorderSizePixel = 0
walkSpeedFrame.Parent = contentFrame

local wsCorner = Instance.new("UICorner")
wsCorner.CornerRadius = UDim.new(0, 5)
wsCorner.Parent = walkSpeedFrame

local slider = Instance.new("TextBox")
slider.Size = UDim2.new(1, -10, 1, 0)
slider.Position = UDim2.new(0, 5, 0, 0)
slider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
slider.TextColor3 = Color3.fromRGB(255, 255, 255)
slider.Text = "16"
slider.TextSize = 12
slider.Font = Enum.Font.Gotham
slider.BorderSizePixel = 0
slider.Parent = walkSpeedFrame

slider.FocusLost:Connect(function()
    local num = tonumber(slider.Text)
    if num then
        if num < 16 then num = 16 end
        if num > 100 then num = 100 end
        Config.WalkSpeed = num
        slider.Text = tostring(num)
        print("[Config] Walk Speed: " .. tostring(num))
    else
        slider.Text = "16"
    end
end)

print("[bragao Hub] ✅ Todos los toggles y opciones creados")

-- MENSAJE FINAL
print("")
print("╔════════════════════════════════════════╗")
print("║  ✅ BRAGAO HUB CARGADO CORRECTAMENTE  ║")
print("╚════════════════════════════════════════╝")
print("")
print("📍 OPCIONES DISPONIBLES:")
print("   ⚔️  Silent Aim Players")
print("   ⚔️  Silent Aim NPCs")
print("   ⚔️  Auto Ken")
print("   🎯  Prediction")
print("   🏃  Infinite Jump")
print("   🏃  Walk Speed")
print("   👁️   ESP")
print("   ⚙️   Anti-AFK")
print("")
print("🎮 Haz click en los toggles para activar/desactivar")
print("")
