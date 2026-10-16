local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

print("[bragao Hub] Iniciando carga...")

-- WINDUI PRIMERO
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
print("[bragao Hub] WindUI cargado ✅")

local Window = WindUI:CreateWindow({
    Title = "braga Hub | Blox Fruits",
    Author = "by bragao",
    Folder = "BragaoHub",
    Icon = "home",
})

print("[bragao Hub] Ventana creada ✅")

-- VARIABLES
local Config = {
    SilentAimPlayers = false,
    SilentAimNPCs = false,
    Prediction = false,
    PredictionAmount = 0.1,
    ZSkills = false,
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
}

-- Remotes
local CommE, CommF
pcall(function() CommE = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild("CommE", 5) end)
pcall(function() CommF = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild("CommF_", 5) end)

-- ============================================================
-- FUNCIONES BASE
-- ============================================================
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

-- ============================================================
-- SILENT AIM
-- ============================================================
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

-- ============================================================
-- AUTO KEN
-- ============================================================
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

-- ============================================================
-- INFINITE JUMP
-- ============================================================
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

-- ============================================================
-- WALK SPEED
-- ============================================================
RunService.Heartbeat:Connect(function()
    if Config.WalkSpeed > 16 then
        local hum = getHum()
        if hum then hum.WalkSpeed = Config.WalkSpeed end
    end
end)

-- ============================================================
-- ANTI AFK
-- ============================================================
local antiAFKRunning = false
local function setupAntiAFK()
    if Config.AntiAFK and not antiAFKRunning then
        antiAFKRunning = true
        print("[Anti-AFK] Activado ✅")
        task.spawn(function()
            while Config.AntiAFK do
                task.wait(60)
                pcall(function()
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0))
                end)
            end
            antiAFKRunning = false
        end)
    end
end

-- ============================================================
-- CREAR UI - TABS Y OPCIONES
-- ============================================================

-- TAB 1: COMBAT
local CombatTab = Window:CreateTab("Combat", "⚔️")
print("[bragao Hub] Tab Combat creado ✅")

CombatTab:CreateToggle("Silent Aim Players", false, function(value)
    Config.SilentAimPlayers = value
    if value then installSilentAim() end
    print("[Config] Silent Aim Players: " .. tostring(value))
end)

CombatTab:CreateToggle("Silent Aim NPCs", false, function(value)
    Config.SilentAimNPCs = value
    if value then installSilentAim() end
    print("[Config] Silent Aim NPCs: " .. tostring(value))
end)

CombatTab:CreateToggle("Auto Ken", false, function(value)
    Config.AutoKen = value
    if value then startAutoKenLoop() end
    print("[Config] Auto Ken: " .. tostring(value))
end)

-- TAB 2: AIM
local AimTab = Window:CreateTab("Aim", "🎯")
print("[bragao Hub] Tab Aim creado ✅")

AimTab:CreateToggle("Prediction", false, function(value)
    Config.Prediction = value
    print("[Config] Prediction: " .. tostring(value))
end)

AimTab:CreateSlider("Prediction Amount", 0, 1, 0.1, function(value)
    Config.PredictionAmount = value
    print("[Config] Prediction Amount: " .. tostring(value))
end)

-- TAB 3: MOVEMENT
local MovementTab = Window:CreateTab("Movement", "🏃")
print("[bragao Hub] Tab Movement creado ✅")

MovementTab:CreateToggle("Infinite Jump", false, function(value)
    Config.InfiniteJump = value
    setupInfiniteJump()
    print("[Config] Infinite Jump: " .. tostring(value))
end)

MovementTab:CreateSlider("Walk Speed", 16, 100, 16, function(value)
    Config.WalkSpeed = value
    print("[Config] Walk Speed: " .. tostring(value))
end)

-- TAB 4: VISUAL
local VisualTab = Window:CreateTab("Visual", "👁️")
print("[bragao Hub] Tab Visual creado ✅")

VisualTab:CreateToggle("ESP", false, function(value)
    Config.ESP = value
    print("[Config] ESP: " .. tostring(value))
end)

-- TAB 5: UTILS
local UtilsTab = Window:CreateTab("Utils", "⚙️")
print("[bragao Hub] Tab Utils creado ✅")

UtilsTab:CreateToggle("Anti-AFK", false, function(value)
    Config.AntiAFK = value
    setupAntiAFK()
    print("[Config] Anti-AFK: " .. tostring(value))
end)

print("[bragao Hub] ════════════════════════════════════════")
print("[bragao Hub] ✅ SCRIPT CARGADO CORRECTAMENTE")
print("[bragao Hub] ════════════════════════════════════════")
print("[bragao Hub] Tabs disponibles:")
print("[bragao Hub]  ⚔️  Combat (Silent Aim, Auto Ken)")
print("[bragao Hub]  🎯  Aim (Prediction)")
print("[bragao Hub]  🏃  Movement (Jump, Speed)")
print("[bragao Hub]  👁️   Visual (ESP)")
print("[bragao Hub]  ⚙️   Utils (Anti-AFK)")
print("[bragao Hub] ════════════════════════════════════════")
