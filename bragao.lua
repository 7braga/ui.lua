-- ═══════════════════════════════════════════════════════════
-- BRAGAO HUB - UI CUSTOM CON TABS (v2.1 - FIXED)
-- ═══════════════════════════════════════════════════════════

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UIS              = game:GetService("UserInputService")
local ReplicatedStorage= game:GetService("ReplicatedStorage")
local TweenService     = game:GetService("TweenService")
local Stats            = game:GetService("Stats")
local CollectionService= game:GetService("CollectionService")
local VirtualUser      = game:GetService("VirtualUser")
local lp               = Players.LocalPlayer

print("[Bragao Hub] Iniciando...")

-- ═══════════════════════════════════════════════════════════
-- CONFIG / STATE
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
pcall(function()
    local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
    if remotes then
        CommE = remotes:WaitForChild("CommE", 5)
        CommF = remotes:WaitForChild("CommF_", 5)
    end
end)

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
        if myTeam.Name == "Pirates" and targetTeam.Name == "Marines" then return true end
        if myTeam.Name == "Marines" and targetTeam.Name == "Pirates" then return true end
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
    print("[Silent Aim] Instalado")

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
        if ok and hookMeta and hookmetamethod and getnamecallmethod and setreadonly then
            setreadonly(hookMeta, false)
            local OldHook
            OldHook = hookmetamethod(game, "__namecall", function(self, V1, V2, ...)
                local Method = getnamecallmethod():lower()
                if tostring(self) == "RemoteEvent" and Method == "fireserver" then
                    if typeof(V1) == "Vector3" then
                        if Config.SilentAimPlayers and State.PlayersPosition then
                            return OldHook(self, State.PlayersPosition, V2, ...)
                        elseif Config.SilentAimNPCs and State.NPCPosition then
                            return OldHook(self, State.NPCPosition, V2, ...)
                        end
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
    print("[Auto Ken] Iniciado")
    task.spawn(function()
        while Config.AutoKen do
            task.wait(0.1)
            pcall(function()
                local char = lp.Character
                if not char then return end
                if CollectionService:HasTag(char, "Ken") then
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
    billboard.Name = targetPlayer.Name
    billboard.Adornee = head
    billboard.Size = UDim2.fromOffset(220, 50)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Parent = espFolder

    local levelLabel = Instance.new("TextLabel")
    levelLabel.Name = "LevelLabel"
    levelLabel.Size = UDim2.new(1, 0, 0.5, 0)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Text = "Lv. ???"
    levelLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
    levelLabel.TextStrokeTransparency = 0.2
    levelLabel.Font = Enum.Font.SourceSansBold
    levelLabel.TextSize = 14
    levelLabel.Parent = billboard

    local mainLabel = Instance.new("TextLabel")
    mainLabel.Name = "MainLabel"
    mainLabel.Size = UDim2.new(1, 0, 0.5, 0)
    mainLabel.Position = UDim2.new(0, 0, 0.5, 0)
    mainLabel.BackgroundTransparency = 1
    mainLabel.Text = "[0] " .. targetPlayer.DisplayName .. " (0m)"
    mainLabel.TextColor3 = getESPColor(targetPlayer)
    mainLabel.TextStrokeTransparency = 0.2
    mainLabel.Font = Enum.Font.SourceSansBold
    mainLabel.TextSize = 16
    mainLabel.Parent = billboard

    ESPs[targetPlayer] = billboard
end

RunService.Heartbeat:Connect(function()
    if not Config.ESP then
        for _, gui in pairs(ESPs) do
            if gui then gui.Enabled = false end
        end
        return
    end
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= lp then
            if not ESPs[targetPlayer] then createESP(targetPlayer) end
            local gui = ESPs[targetPlayer]
            if gui then
                local char = targetPlayer.Character
                local head = char and char:FindFirstChild("Head")
                local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                local hum  = char and char:FindFirstChildOfClass("Humanoid")
                local myHRP= lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if char and head and hrp and hum and myHRP then
                    gui.Adornee = head
                    gui.Enabled = true
                    local dist = (myHRP.Position - hrp.Position).Magnitude
                    local nameLabel = gui:FindFirstChild("MainLabel")
                    local levelLabel= gui:FindFirstChild("LevelLabel")
                    if levelLabel then
                        local dataFolder = targetPlayer:FindFirstChild("Data")
                        local levelValue = dataFolder and dataFolder:FindFirstChild("Level")
                        levelLabel.Text = levelValue and ("Lv. " .. levelValue.Value) or "Lv. ???"
                    end
                    if nameLabel then
                        nameLabel.Text = "[" .. math.floor(hum.Health) .. "] " .. targetPlayer.DisplayName .. " (" .. math.floor(dist) .. "m)"
                        nameLabel.TextColor3 = getESPColor(targetPlayer)
                    end
                else
                    gui.Enabled = false
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- INFINITE JUMP
-- ═══════════════════════════════════════════════════════════
local function setupInfiniteJump()
    if Config.InfiniteJump and not State.infJumpConn then
        print("[Infinite Jump] ON")
        State.infJumpConn = UIS.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                local hum = getHum()
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    elseif not Config.InfiniteJump and State.infJumpConn then
        print("[Infinite Jump] OFF")
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
        print("[Anti-AFK] ON")
        task.spawn(function()
            while Config.AntiAFK do
                task.wait(60)
                pcall(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton1(Vector2.new(0, 0))
                end)
            end
            State.antiAFKRunning = false
        end)
    end
end

-- ═══════════════════════════════════════════════════════════
-- UI v2.1
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

local FONT      = Enum.Font.SourceSans
local FONT_SEMI = Enum.Font.SourceSansBold

local function tw(i, p, t)
    TweenService:Create(i, TweenInfo.new(t or 0.15), p):Play()
end

local function new(class, props, parent)
    local i = Instance.new(class)
    for k, v in pairs(props or {}) do i[k] = v end
    if parent then i.Parent = parent end
    return i
end

local function corner(p, r)
    return new("UICorner", { CornerRadius = UDim.new(0, r or 6) }, p)
end

local function stroke(p, c, th)
    return new("UIStroke", {
        Color = c or T.BORDER,
        Thickness = th or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, p)
end

-- Screen
local screenGui = new("ScreenGui", {
    Name = "BragaoHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
}, lp:WaitForChild("PlayerGui"))

-- Main Frame (pequeña 500x380)
local mainFrame = new("Frame", {
    Name = "MainFrame",
    Size = UDim2.fromOffset(500, 380),
    Position = UDim2.new(0.5, -250, 0.5, -190),
    BackgroundColor3 = T.BG,
    BorderSizePixel = 0,
    Active = true,
    ClipsDescendants = true,
}, screenGui)
corner(mainFrame, 10)
stroke(mainFrame, T.BORDER_HL, 1)

-- TitleBar
local titleBar = new("Frame", {
    Name = "TitleBar",
    Size = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = T.TITLEBAR,
    BorderSizePixel = 0,
}, mainFrame)
corner(titleBar, 10)
new("Frame", {
    BackgroundColor3 = T.TITLEBAR,
    Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14),
    BorderSizePixel = 0,
}, titleBar)
new("Frame", {
    BackgroundColor3 = T.BORDER,
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, -1),
    BorderSizePixel = 0,
}, titleBar)

-- Título
new("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 46, 0, 0),
    Size = UDim2.new(0, 300, 1, 0),
    Font = FONT_SEMI,
    Text = "◆  BRAGAO HUB",
    TextColor3 = Color3.fromRGB(255, 200, 0),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
}, titleBar)

-- Botón cerrar
local closeBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT,
    Position = UDim2.new(1, -36, 0, 8),
    Size = UDim2.fromOffset(26, 20),
    Font = FONT_SEMI, Text = "✕",
    TextColor3 = T.TEXT, TextSize = 12,
    AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(closeBtn, 4)
stroke(closeBtn, T.BORDER, 1)

-- Botón minimizar
local minBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT,
    Position = UDim2.new(1, -68, 0, 8),
    Size = UDim2.fromOffset(26, 20),
    Font = FONT_SEMI, Text = "—",
    TextColor3 = T.TEXT, TextSize = 13,
    AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(minBtn, 4)
stroke(minBtn, T.BORDER, 1)

-- Botón sidebar
local menuBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT,
    Position = UDim2.new(0, 10, 0, 8),
    Size = UDim2.fromOffset(26, 20),
    Font = FONT_SEMI, Text = "≡",
    TextColor3 = T.TEXT, TextSize = 13,
    AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(menuBtn, 4)
stroke(menuBtn, T.BORDER, 1)

menuBtn.MouseEnter:Connect(function()  tw(menuBtn,  { BackgroundColor3 = T.MIN_HOV })   end)
menuBtn.MouseLeave:Connect(function()  tw(menuBtn,  { BackgroundColor3 = T.ELEMENT })   end)
minBtn.MouseEnter:Connect(function()   tw(minBtn,   { BackgroundColor3 = T.MIN_HOV })   end)
minBtn.MouseLeave:Connect(function()   tw(minBtn,   { BackgroundColor3 = T.ELEMENT })   end)
closeBtn.MouseEnter:Connect(function() tw(closeBtn, { BackgroundColor3 = T.CLOSE_HOV }) end)
closeBtn.MouseLeave:Connect(function() tw(closeBtn, { BackgroundColor3 = T.ELEMENT })   end)

-- Body
local body = new("Frame", {
    Name = "Body",
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 36),
    Size = UDim2.new(1, 0, 1, -36),
}, mainFrame)

-- Sidebar
local sideW = 140
local sidebar = new("Frame", {
    Name = "Sidebar",
    BackgroundColor3 = T.PANEL,
    Size = UDim2.new(0, sideW, 1, 0),
    BorderSizePixel = 0,
}, body)
new("Frame", {
    BackgroundColor3 = T.BORDER,
    Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(1, -1, 0, 0),
    BorderSizePixel = 0,
}, sidebar)

local tabList = new("ScrollingFrame", {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = T.BORDER,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, sidebar)
new("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, tabList)

-- Content
local content = new("Frame", {
    Name = "Content",
    BackgroundTransparency = 1,
    Position = UDim2.new(0, sideW, 0, 0),
    Size = UDim2.new(1, -sideW, 1, 0),
}, body)

-- Drag
local dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = mainFrame.Position
        local c
        c = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragStart = nil
                c:Disconnect()
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

-- Toggle sidebar
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

-- Minimize
local minimized = false
local savedSize = mainFrame.Size
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        savedSize = mainFrame.Size
        body.Visible = false
        tw(mainFrame, { Size = UDim2.fromOffset(260, 36) }, 0.2)
    else
        body.Visible = true
        tw(mainFrame, { Size = savedSize }, 0.2)
    end
end)

-- Close
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

    tab.Content = new("ScrollingFrame", {
        Name = title,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = T.BORDER,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    }, content)
    new("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, tab.Content)

    tab.Button = new("TextButton", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, 32),
        Font = FONT,
        Text = "  " .. title,
        TextColor3 = T.TEXT,
        TextSize = 12,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, tabList)
    corner(tab.Button, 5)
    local s = stroke(tab.Button, T.BORDER, 1)

    tab.Button.MouseEnter:Connect(function()
        if activeTab ~= tab then
            tw(tab.Button, { BackgroundColor3 = T.ELEMENT_HOV })
        end
    end)
    tab.Button.MouseLeave:Connect(function()
        if activeTab ~= tab then
            tw(tab.Button, { BackgroundColor3 = T.ELEMENT })
        end
    end)

    tab.Button.MouseButton1Click:Connect(function()
        if activeTab then
            activeTab.Content.Visible = false
            tw(activeTab.Button, { BackgroundColor3 = T.ELEMENT })
            local oldS = activeTab.Button:FindFirstChildOfClass("UIStroke")
            if oldS then oldS.Color = T.BORDER end
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

-- Section
local function section(tab, title)
    local sec = new("Frame", {
        BackgroundColor3 = T.PANEL,
        Size = UDim2.new(1, 0, 0, 26),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(sec, 6)
    stroke(sec, T.BORDER_HL, 1)
    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = FONT_SEMI,
        Text = title,
        TextColor3 = T.TEXT,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, sec)
    return sec
end

-- Toggle
local function toggle(tab, cfg)
    cfg = cfg or {}
    local hasDesc = cfg.Desc and cfg.Desc ~= ""
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, hasDesc and 48 or 38),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6)
    stroke(c, T.BORDER, 1)

    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, hasDesc and 6 or 0),
        Size = UDim2.new(1, -100, 0, hasDesc and 15 or 38),
        Font = FONT_SEMI,
        Text = cfg.Title or "Toggle",
        TextColor3 = T.TEXT,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    if hasDesc then
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 22),
            Size = UDim2.new(1, -100, 0, 13),
            Font = FONT,
            Text = cfg.Desc,
            TextColor3 = T.TEXT_DIM,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end

    local switch = new("Frame", {
        BackgroundColor3 = cfg.Value and T.ON or T.OFF,
        Position = UDim2.new(1, -58, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(44, 22),
        BorderSizePixel = 0,
    }, c)
    corner(switch, 11)
    stroke(switch, T.BORDER, 1)

    local knob = new("Frame", {
        BackgroundColor3 = T.TEXT,
        Position = cfg.Value and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2),
        Size = UDim2.fromOffset(18, 18),
        BorderSizePixel = 0,
    }, switch)
    corner(knob, 9)

    local btn = new("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        AutoButtonColor = false,
    }, c)

    local state = cfg.Value or false
    btn.MouseButton1Click:Connect(function()
        state = not state
        tw(switch, { BackgroundColor3 = state and T.ON or T.OFF }, 0.2)
        tw(knob, { Position = state and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2) }, 0.2)
        if cfg.Callback then cfg.Callback(state) end
    end)
    return btn
end

-- Input
local function input(tab, cfg)
    cfg = cfg or {}
    local hasDesc = cfg.Desc and cfg.Desc ~= ""
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, hasDesc and 72 or 58),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6)
    stroke(c, T.BORDER, 1)

    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 6),
        Size = UDim2.new(1, -100, 0, 15),
        Font = FONT_SEMI,
        Text = cfg.Title or "Input",
        TextColor3 = T.TEXT,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    if hasDesc then
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 22),
            Size = UDim2.new(1, -100, 0, 13),
            Font = FONT,
            Text = cfg.Desc,
            TextColor3 = T.TEXT_DIM,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end

    local boxY = hasDesc and 42 or 28
    local box = new("Frame", {
        BackgroundColor3 = T.BG,
        Position = UDim2.new(0, 12, 0, boxY),
        Size = UDim2.new(1, -24, 0, 24),
        BorderSizePixel = 0,
    }, c)
    corner(box, 5)
    stroke(box, T.BORDER, 1)

    local tb = new("TextBox", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 0),
        Size = UDim2.new(1, -16, 1, 0),
        Font = FONT,
        Text = tostring(cfg.Value or ""),
        PlaceholderText = cfg.Placeholder or "escribe aqui...",
        PlaceholderColor3 = T.TEXT_DIM,
        TextColor3 = T.TEXT,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
    }, box)

    tb.FocusLost:Connect(function()
        if cfg.Callback then cfg.Callback(tb.Text) end
    end)
    return tb
end

-- ═══════════════════════════════════════════════════════════
-- WATERMARK
-- ═══════════════════════════════════════════════════════════
local watermarkEnabled = false
local wmFrame = new("Frame", {
    Name = "Watermark",
    BackgroundColor3 = T.BG,
    BackgroundTransparency = 0.15,
    Size = UDim2.fromOffset(220, 24),
    Position = UDim2.new(1, -230, 0, 8),
    Visible = false,
    BorderSizePixel = 0,
}, screenGui)
corner(wmFrame, 5)
stroke(wmFrame, T.BORDER, 1)

local wmLabel = new("TextLabel", {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 5, 0, 0),
    Font = FONT_SEMI,
    Text = "◆  BRAGAO HUB  |  FPS: --  |  -- ms",
    TextColor3 = T.TEXT,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Center,
}, wmFrame)

local fpsCount, fpsTime, currentFPS = 0, 0, 60
RunService.RenderStepped:Connect(function(dt)
    fpsCount = fpsCount + 1
    fpsTime = fpsTime + dt
    if fpsTime >= 1 then
        currentFPS = fpsCount
        fpsCount = 0
        fpsTime = 0
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if watermarkEnabled then
            local ping = 0
            pcall(function()
                ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            wmLabel.Text = string.format("◆  BRAGAO HUB  |  FPS: %d  |  %d ms", currentFPS, ping)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- CREAR TABS Y OPCIONES
-- ═══════════════════════════════════════════════════════════
local tabCombat   = createTab("Combat")
local tabAim      = createTab("Aim")
local tabMovement = createTab("Movement")
local tabVisual   = createTab("Visual")
local tabUtils    = createTab("Utils")

-- ── COMBAT ──
section(tabCombat, "Silent Aim")
toggle(tabCombat, {
    Title = "Silent Aim Players",
    Desc = "Apunta a jugadores enemigos",
    Value = false,
    Callback = function(v)
        Config.SilentAimPlayers = v
        if v then installSilentAim() end
    end
})
toggle(tabCombat, {
    Title = "Silent Aim NPCs",
    Desc = "Apunta a NPCs enemigos",
    Value = false,
    Callback = function(v)
        Config.SilentAimNPCs = v
        if v then installSilentAim() end
    end
})
toggle(tabCombat, {
    Title = "Auto Ken",
    Desc = "Activa Ken automaticamente",
    Value = false,
    Callback = function(v)
        Config.AutoKen = v
        if v then startAutoKenLoop() end
    end
})

-- ── AIM ──
section(tabAim, "Prediction")
toggle(tabAim, {
    Title = "Prediction",
    Desc = "Predice la posicion del enemigo",
    Value = false,
    Callback = function(v)
        Config.Prediction = v
    end
})
input(tabAim, {
    Title = "Prediction Amount",
    Desc = "Multiplicador de prediccion (ej. 0.1)",
    Value = tostring(Config.PredictionAmount),
    Placeholder = "0.1",
    Callback = function(text)
        local num = tonumber(text)
        if num then Config.PredictionAmount = num end
    end
})
input(tabAim, {
    Title = "Max Range",
    Desc = "Rango maximo del aim (studs)",
    Value = tostring(State.maxRange),
    Placeholder = "500",
    Callback = function(text)
        local num = tonumber(text)
        if num then State.maxRange = num end
    end
})

-- ── MOVEMENT ──
section(tabMovement, "Salto")
toggle(tabMovement, {
    Title = "Infinite Jump",
    Desc = "Salto infinito con espacio",
    Value = false,
    Callback = function(v)
        Config.InfiniteJump = v
        setupInfiniteJump()
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
        end
    end
})

-- ── VISUAL ──
section(tabVisual, "ESP")
toggle(tabVisual, {
    Title = "ESP Players",
    Desc = "Muestra nombre, vida y distancia",
    Value = false,
    Callback = function(v)
        Config.ESP = v
    end
})

-- ── UTILS ──
section(tabUtils, "Utilidades")
toggle(tabUtils, {
    Title = "Anti-AFK",
    Desc = "Evita ser expulsado por inactividad",
    Value = false,
    Callback = function(v)
        Config.AntiAFK = v
        setupAntiAFK()
    end
})

section(tabUtils, "Interfaz")
toggle(tabUtils, {
    Title = "Watermark",
    Desc = "Muestra FPS y Ping en pantalla",
    Value = false,
    Callback = function(v)
        watermarkEnabled = v
        wmFrame.Visible = v
    end
})

-- ═══════════════════════════════════════════════════════════
-- FINAL
-- ═══════════════════════════════════════════════════════════
print("[Bragao Hub] UI cargada correctamente")
print("Tabs: Combat | Aim | Movement | Visual | Utils")
