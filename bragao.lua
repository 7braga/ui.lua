-- ═══════════════════════════════════════════════════════════
-- BRAGAO HUB - UI CUSTOM CON TABS
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

print("[bragao Hub] ✅ Iniciando...")

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
-- ═══════════════════════════════════════════════════════════
--                NUEVA UI CON TABS
-- ═══════════════════════════════════════════════════════════
-- ═══════════════════════════════════════════════════════════

local T = {
    BG          = Color3.fromRGB(8, 8, 8),
    PANEL       = Color3.fromRGB(14, 14, 14),
    TITLEBAR    = Color3.fromRGB(12, 12, 12),
    ELEMENT     = Color3.fromRGB(20, 20, 20),
    ELEMENT_HOV = Color3.fromRGB(30, 30, 30),
    ELEMENT_ACT = Color3.fromRGB(38, 38, 38),
    BORDER      = Color3.fromRGB(60, 60, 60),
    BORDER_HL   = Color3.fromRGB(105, 105, 105),
    TEXT        = Color3.fromRGB(255, 255, 255),
    TEXT_DIM    = Color3.fromRGB(150, 150, 150),
    ON          = Color3.fromRGB(70, 200, 110),
    OFF         = Color3.fromRGB(60, 60, 70),
    CLOSE_HOV   = Color3.fromRGB(175, 45, 45),
    MIN_HOV     = Color3.fromRGB(55, 55, 55),
}
local TweenService = game:GetService("TweenService")
local function tw(i, p, t) TweenService:Create(i, TweenInfo.new(t or 0.15), p):Play() end

local function new(class, props, parent)
    local i = Instance.new(class)
    for k, v in pairs(props or {}) do i[k] = v end
    if parent then i.Parent = parent end
    return i
end
local function corner(p, r) return new("UICorner", { CornerRadius = UDim.new(0, r or 6) }, p) end
local function stroke(p, c, th)
    return new("UIStroke", { Color = c or T.BORDER, Thickness = th or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, p)
end

-- SCREEN
local screenGui = new("ScreenGui", {
    Name = "BragaoHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
}, lp:WaitForChild("PlayerGui"))

-- MAIN
local mainFrame = new("Frame", {
    Name = "MainFrame",
    Size = UDim2.fromOffset(560, 420),
    Position = UDim2.new(0.5, -280, 0.5, -210),
    BackgroundColor3 = T.BG,
    BorderSizePixel = 0, Active = true, ClipsDescendants = true,
}, screenGui)
corner(mainFrame, 10)
stroke(mainFrame, T.BORDER_HL, 1)

-- TITLEBAR
local titleBar = new("Frame", {
    Name = "TitleBar",
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = T.TITLEBAR,
    BorderSizePixel = 0,
}, mainFrame)
corner(titleBar, 10)
new("Frame", { BackgroundColor3 = T.TITLEBAR, Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14), BorderSizePixel = 0 }, titleBar)
new("Frame", { BackgroundColor3 = T.BORDER, Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, -1), BorderSizePixel = 0 }, titleBar)

-- Titulo
new("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 14, 0, 0),
    Size = UDim2.new(0, 300, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "⚡ BRAGAO HUB",
    TextColor3 = Color3.fromRGB(255, 200, 0),
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
}, titleBar)

-- ✕ Cerrar
local closeBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT,
    Position = UDim2.new(1, -38, 0, 9),
    Size = UDim2.fromOffset(28, 20),
    Font = Enum.Font.GothamBold, Text = "✕",
    TextColor3 = T.TEXT, TextSize = 12,
    AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(closeBtn, 4)
stroke(closeBtn, T.BORDER, 1)

-- — Minimizar
local minBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT,
    Position = UDim2.new(1, -72, 0, 9),
    Size = UDim2.fromOffset(28, 20),
    Font = Enum.Font.GothamBold, Text = "—",
    TextColor3 = T.TEXT, TextSize = 14,
    AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(minBtn, 4)
stroke(minBtn, T.BORDER, 1)

-- ☰ toggle sidebar
local menuBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT,
    Position = UDim2.new(0, 10, 0, 9),
    Size = UDim2.fromOffset(28, 20),
    Font = Enum.Font.GothamBold, Text = "☰",
    TextColor3 = T.TEXT, TextSize = 12,
    AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(menuBtn, 4)
stroke(menuBtn, T.BORDER, 1)

-- Reubicar título
titleBar:FindFirstChildOfClass("TextLabel").Position = UDim2.new(0, 46, 0, 0)

-- Hovers
menuBtn.MouseEnter:Connect(function()  tw(menuBtn,  { BackgroundColor3 = T.MIN_HOV })   end)
menuBtn.MouseLeave:Connect(function()  tw(menuBtn,  { BackgroundColor3 = T.ELEMENT })   end)
minBtn.MouseEnter:Connect(function()   tw(minBtn,   { BackgroundColor3 = T.MIN_HOV })   end)
minBtn.MouseLeave:Connect(function()   tw(minBtn,   { BackgroundColor3 = T.ELEMENT })   end)
closeBtn.MouseEnter:Connect(function() tw(closeBtn, { BackgroundColor3 = T.CLOSE_HOV }) end)
closeBtn.MouseLeave:Connect(function() tw(closeBtn, { BackgroundColor3 = T.ELEMENT })   end)

-- BODY
local body = new("Frame", {
    Name = "Body", BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 38),
    Size = UDim2.new(1, 0, 1, -38),
}, mainFrame)

-- SIDEBAR
local sideW = 150
local sidebar = new("Frame", {
    Name = "Sidebar",
    BackgroundColor3 = T.PANEL,
    Size = UDim2.new(0, sideW, 1, 0),
    BorderSizePixel = 0,
}, body)
new("Frame", { BackgroundColor3 = T.BORDER, Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(1, -1, 0, 0), BorderSizePixel = 0 }, sidebar)

local tabList = new("ScrollingFrame", {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BorderSizePixel = 0, ScrollBarThickness = 3,
    ScrollBarImageColor3 = T.BORDER,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, sidebar)
new("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, tabList)

-- CONTENT
local content = new("Frame", {
    Name = "Content", BackgroundTransparency = 1,
    Position = UDim2.new(0, sideW, 0, 0),
    Size = UDim2.new(1, -sideW, 1, 0),
}, body)

-- DRAG
local dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position; startPos = mainFrame.Position
        local c
        c = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragStart = nil; c:Disconnect()
            end
        end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragStart and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + d.X,
            startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

-- ☰ TOGGLE SIDEBAR
local sidebarOpen = true
menuBtn.MouseButton1Click:Connect(function()
    sidebarOpen = not sidebarOpen
    if sidebarOpen then
        sidebar.Visible = true
        content.Position = UDim2.new(0, sideW, 0, 0)
        content.Size = UDim2.new(1, -sideW, 1, 0)
    else
        sidebar.Visible = false
        content.Position = UDim2.new(0, 0, 0, 0)
        content.Size = UDim2.new(1, 0, 1, 0)
    end
end)

-- — MINIMIZE
local minimized = false
local savedSize = mainFrame.Size
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        savedSize = mainFrame.Size
        body.Visible = false
        tw(mainFrame, { Size = UDim2.fromOffset(280, 38) }, 0.2)
    else
        body.Visible = true
        tw(mainFrame, { Size = savedSize }, 0.2)
    end
end)

-- ✕ CLOSE
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ═══════════════════════════════════════════════════════════
-- SISTEMA DE TABS
-- ═══════════════════════════════════════════════════════════
local tabs = {}
local activeTab = nil

local function createTab(title)
    local tab = { Title = title, Content = nil, Button = nil }

    -- Contenido
    tab.Content = new("ScrollingFrame", {
        Name = title,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BorderSizePixel = 0, ScrollBarThickness = 4,
        ScrollBarImageColor3 = T.BORDER,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    }, content)
    new("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, tab.Content)

    -- Botón sidebar
    tab.Button = new("TextButton", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, 34),
        Font = Enum.Font.Gotham,
        Text = "  " .. title,
        TextColor3 = T.TEXT, TextSize = 12,
        AutoButtonColor = false, BorderSizePixel = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, tabList)
    corner(tab.Button, 5)
    local s = stroke(tab.Button, T.BORDER, 1)

    tab.Button.MouseEnter:Connect(function()
        if activeTab ~= tab then tw(tab.Button, { BackgroundColor3 = T.ELEMENT_HOV }) end
    end)
    tab.Button.MouseLeave:Connect(function()
        if activeTab ~= tab then tw(tab.Button, { BackgroundColor3 = T.ELEMENT }) end
    end)

    tab.Button.MouseButton1Click:Connect(function()
        if activeTab then
            activeTab.Content.Visible = false
            tw(activeTab.Button, { BackgroundColor3 = T.ELEMENT })
            activeTab.Button:FindFirstChildOfClass("UIStroke").Color = T.BORDER
        end
        activeTab = tab
        tab.Content.Visible = true
        tw(tab.Button, { BackgroundColor3 = T.ELEMENT_ACT })
        s.Color = T.TEXT
    end)

    table.insert(tabs, tab)
    if #tabs == 1 then
        tab.Content.Visible = true
        activeTab = tab
        tw(tab.Button, { BackgroundColor3 = T.ELEMENT_ACT })
        s.Color = T.TEXT
    end
    return tab
end

-- ═══════════════════════════════════════════════════════════
-- COMPONENTES DE TAB
-- ═══════════════════════════════════════════════════════════
local function section(tab, title)
    local sec = new("Frame", {
        BackgroundColor3 = T.PANEL,
        Size = UDim2.new(1, 0, 0, 28),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(sec, 6)
    stroke(sec, T.BORDER_HL, 1)
    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = Enum.Font.GothamBold, Text = title,
        TextColor3 = T.TEXT, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, sec)
    return sec
end

local function toggle(tab, cfg)
    cfg = cfg or {}
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, cfg.Desc and 52 or 42),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6)
    stroke(c, T.BORDER, 1)

    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, cfg.Desc and 7 or 0),
        Size = UDim2.new(1, -100, 0, cfg.Desc and 16 or 42),
        Font = Enum.Font.GothamBold,
        Text = cfg.Title or "Toggle",
        TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    if cfg.Desc and cfg.Desc ~= "" then
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 24),
            Size = UDim2.new(1, -100, 0, 14),
            Font = Enum.Font.Gotham,
            Text = cfg.Desc,
            TextColor3 = T.TEXT_DIM, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end

    local switch = new("Frame", {
        BackgroundColor3 = cfg.Value and T.ON or T.OFF,
        Position = UDim2.new(1, -60, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(46, 24),
        BorderSizePixel = 0,
    }, c)
    corner(switch, 12)
    stroke(switch, T.BORDER, 1)

    local knob = new("Frame", {
        BackgroundColor3 = T.TEXT,
        Position = cfg.Value and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2),
        Size = UDim2.fromOffset(20, 20),
        BorderSizePixel = 0,
    }, switch)
    corner(knob, 10)

    local btn = new("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "", AutoButtonColor = false,
    }, c)

    local state = cfg.Value or false
    btn.MouseButton1Click:Connect(function()
        state = not state
        tw(switch, { BackgroundColor3 = state and T.ON or T.OFF }, 0.2)
        tw(knob, { Position = state and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2) }, 0.2)
        if cfg.Callback then cfg.Callback(state) end
    end)
    return btn
end

local function input(tab, cfg)
    cfg = cfg or {}
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, cfg.Desc and 78 or 62),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6)
    stroke(c, T.BORDER, 1)

    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 7),
        Size = UDim2.new(1, -100, 0, 16),
        Font = Enum.Font.GothamBold,
        Text = cfg.Title or "Input",
        TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    if cfg.Desc and cfg.Desc ~= "" then
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 24),
            Size = UDim2.new(1, -100, 0, 14),
            Font = Enum.Font.Gotham,
            Text = cfg.Desc,
            TextColor3 = T.TEXT_DIM, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end

    local boxY = (cfg.Desc and cfg.Desc ~= "") and 44 or 30
    local box = new("Frame", {
        BackgroundColor3 = T.BG,
        Position = UDim2.new(0, 12, 0, boxY),
        Size = UDim2.new(1, -24, 0, 26),
        BorderSizePixel = 0,
    }, c)
    corner(box, 5)
    stroke(box, T.BORDER, 1)

    local tb = new("TextBox", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 0),
        Size = UDim2.new(1, -16, 1, 0),
        Font = Enum.Font.Gotham,
        Text = tostring(cfg.Value or ""),
        PlaceholderText = cfg.Placeholder or "escribe aquí...",
        PlaceholderColor3 = T.TEXT_DIM,
        TextColor3 = T.TEXT, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
    }, box)

    tb.FocusLost:Connect(function()
        if cfg.Callback then cfg.Callback(tb.Text) end
    end)
    return tb
end

-- ═══════════════════════════════════════════════════════════
-- CREAR TABS Y OPCIONES
-- ═══════════════════════════════════════════════════════════

local tabCombat    = createTab("⚔️ Combat")
local tabAim       = createTab("🎯 Aim")
local tabMovement  = createTab("🏃 Movement")
local tabVisual    = createTab("👁️ Visual")
local tabUtils     = createTab("⚙️ Utils")

-- ─────── COMBAT ───────
section(tabCombat, "Silent Aim")
toggle(tabCombat, {
    Title = "Silent Aim Players",
    Desc = "Apunta a jugadores enemigos",
    Value = false,
    Callback = function(v)
        Config.SilentAimPlayers = v
        if v then installSilentAim() end
        print("[Config] Silent Aim Players: " .. tostring(v))
    end
})
toggle(tabCombat, {
    Title = "Silent Aim NPCs",
    Desc = "Apunta a NPCs enemigos",
    Value = false,
    Callback = function(v)
        Config.SilentAimNPCs = v
        if v then installSilentAim() end
        print("[Config] Silent Aim NPCs: " .. tostring(v))
    end
})
toggle(tabCombat, {
    Title = "Auto Ken",
    Desc = "Activa Ken automáticamente",
    Value = false,
    Callback = function(v)
        Config.AutoKen = v
        if v then startAutoKenLoop() end
        print("[Config] Auto Ken: " .. tostring(v))
    end
})

-- ─────── AIM ───────
section(tabAim, "Prediction")
toggle(tabAim, {
    Title = "Prediction",
    Desc = "Predice la posición del enemigo",
    Value = false,
    Callback = function(v)
        Config.Prediction = v
        print("[Config] Prediction: " .. tostring(v))
    end
})
input(tabAim, {
    Title = "Prediction Amount",
    Desc = "Multiplicador de predicción (ej. 0.1)",
    Value = tostring(Config.PredictionAmount),
    Placeholder = "0.1",
    Callback = function(text)
        local num = tonumber(text)
        if num then
            Config.PredictionAmount = num
            print("[Config] Prediction Amount: " .. tostring(num))
        end
    end
})
input(tabAim, {
    Title = "Max Range",
    Desc = "Rango máximo del aim (studs)",
    Value = tostring(State.maxRange),
    Placeholder = "500",
    Callback = function(text)
        local num = tonumber(text)
        if num then
            State.maxRange = num
            print("[Config] Max Range: " .. tostring(num))
        end
    end
})

-- ─────── MOVEMENT ───────
section(tabMovement, "Salto")
toggle(tabMovement, {
    Title = "Infinite Jump",
    Desc = "Salto infinito con espacio",
    Value = false,
    Callback = function(v)
        Config.InfiniteJump = v
        setupInfiniteJump()
        print("[Config] Infinite Jump: " .. tostring(v))
    end
})

section(tabMovement, "Velocidad")
input(tabMovement, {
    Title = "Walk Speed",
    Desc = "Velocidad de caminar (16 - 100)",
    Value = tostring(Config.WalkSpeed),
    Placeholder = "16",
    Callback = function(text)
        local num = tonumber(text)
        if num then
            if num < 16 then num = 16 end
            if num > 100 then num = 100 end
            Config.WalkSpeed = num
            print("[Config] Walk Speed: " .. tostring(num))
        end
    end
})

-- ─────── VISUAL ───────
section(tabVisual, "ESP")
toggle(tabVisual, {
    Title = "ESP Players",
    Desc = "Muestra info de jugadores (nombre, vida, distancia)",
    Value = false,
    Callback = function(v)
        Config.ESP = v
        print("[Config] ESP: " .. tostring(v))
    end
})

-- ─────── UTILS ───────
section(tabUtils, "Utilidades")
toggle(tabUtils, {
    Title = "Anti-AFK",
    Desc = "Evita ser expulsado por inactividad",
    Value = false,
    Callback = function(v)
        Config.AntiAFK = v
        setupAntiAFK()
        print("[Config] Anti-AFK: " .. tostring(v))
    end
})

-- ═══════════════════════════════════════════════════════════
-- FINAL
-- ═══════════════════════════════════════════════════════════
print("")
print("╔════════════════════════════════════════╗")
print("║  ✅ BRAGAO HUB CARGADO CORRECTAMENTE  ║")
print("╚════════════════════════════════════════╝")
print("")
print("📍 TABS DISPONIBLES:")
print("   ⚔️  Combat   → Silent Aim Players / NPCs / Auto Ken")
print("   🎯  Aim      → Prediction / Amount / Max Range")
print("   🏃  Movement → Infinite Jump / Walk Speed")
print("   👁️  Visual   → ESP")
print("   ⚙️  Utils    → Anti-AFK")
print("")
