-- ═══════════════════════════════════════════════════════════
-- BRAGAO HUB v7.4 - Name ESP fix + Tracer estable
-- ═══════════════════════════════════════════════════════════
print("[1] Iniciando...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local CS = game:GetService("CollectionService")
local VU = game:GetService("VirtualUser")
local SS = game:GetService("SoundService")
local lp = Players.LocalPlayer
local cam = workspace.CurrentCamera
print("[2] Servicios OK")

local Config = {
    SilentAimPlayers = false, SilentAimNPCs = false,
    Prediction = false, PredictionAmount = 0.1,
    AutoKen = false,
    ESP = false,
    BoxESP = false,
    TracerESP = false,
    InfiniteJump = false,
    WalkSpeed = 16, AntiAFK = false,
}
local State = {
    silentInstalled = false, autoKenRunning = false,
    infJumpConn = nil, PlayersPosition = nil, NPCPosition = nil,
    maxRange = 500, antiAFKRunning = false,
}

local CommE, CommF
pcall(function()
    local rem = RS:WaitForChild("Remotes", 5)
    if rem then
        CommE = rem:WaitForChild("CommE", 5)
        CommF = rem:WaitForChild("CommF_", 5)
    end
end)
print("[3] Remotes OK")

local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://6895079853"
clickSound.Volume = 0.35
clickSound.PlaybackSpeed = 1.05
clickSound.Parent = SS

local function playClick()
    pcall(function()
        local c = clickSound:Clone()
        c.Parent = SS
        c:Play()
        task.delay(1, function() c:Destroy() end)
    end)
end
print("[4] Sonido OK")

local function getHRP()
    local c = lp.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end
local function getHum()
    local c = lp.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end
local function isEnemy(t)
    if not t or t == lp then return false end
    local a, b = lp.Team, t.Team
    if a and b then
        if a.Name == "Pirates" and b.Name == "Marines" then return true end
        if a.Name == "Marines" and b.Name == "Pirates" then return true end
    end
    return true
end
local function getPredictedPosition(hrp)
    if not hrp then return nil end
    local h = hrp.Parent:FindFirstChildOfClass("Humanoid")
    if not h then return hrp.Position end
    if not Config.Prediction or h.WalkSpeed < 5 then return hrp.Position end
    return hrp.Position + (hrp.AssemblyLinearVelocity * Config.PredictionAmount)
end
local function getClosestPlayer()
    local hrp = getHRP(); if not hrp then return nil end
    local best, bd = nil, State.maxRange
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and isEnemy(p) and p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            local e = p.Character:FindFirstChild("HumanoidRootPart")
            if h and h.Health > 0 and e then
                local d = (e.Position - hrp.Position).Magnitude
                if d < bd then bd = d; best = p end
            end
        end
    end
    return best
end
local function getClosestNPC()
    local hrp = getHRP(); if not hrp then return nil end
    local best, bd = nil, State.maxRange
    local en = workspace:FindFirstChild("Enemies")
    if not en then return nil end
    for _, v in ipairs(en:GetChildren()) do
        local e = v:FindFirstChild("HumanoidRootPart")
        local h = v:FindFirstChildOfClass("Humanoid")
        if e and h and h.Health > 0 then
            local d = (e.Position - hrp.Position).Magnitude
            if d < bd then bd = d; best = v end
        end
    end
    return best
end

local function installSilentAim()
    if State.silentInstalled then return end
    State.silentInstalled = true
    RunService.Heartbeat:Connect(function()
        if not Config.SilentAimPlayers and not Config.SilentAimNPCs then
            State.PlayersPosition = nil; State.NPCPosition = nil; return
        end
        if Config.SilentAimPlayers then
            local e = getClosestPlayer()
            local eH = e and e.Character and e.Character:FindFirstChild("HumanoidRootPart")
            State.PlayersPosition = eH and getPredictedPosition(eH) or nil
        else State.PlayersPosition = nil end
        if Config.SilentAimNPCs then
            local n = getClosestNPC()
            local eH = n and n:FindFirstChild("HumanoidRootPart")
            State.NPCPosition = eH and getPredictedPosition(eH) or nil
        else State.NPCPosition = nil end
    end)
    pcall(function()
        local ok, hm = pcall(getrawmetatable, game)
        if ok and hm and hookmetamethod and getnamecallmethod and setreadonly then
            setreadonly(hm, false)
            local Old
            Old = hookmetamethod(game, "__namecall", function(self, V1, V2, ...)
                local m = getnamecallmethod():lower()
                if tostring(self) == "RemoteEvent" and m == "fireserver" and typeof(V1) == "Vector3" then
                    if Config.SilentAimPlayers and State.PlayersPosition then
                        return Old(self, State.PlayersPosition, V2, ...)
                    elseif Config.SilentAimNPCs and State.NPCPosition then
                        return Old(self, State.NPCPosition, V2, ...)
                    end
                end
                return Old(self, V1, V2, ...)
            end)
            setreadonly(hm, true)
        end
    end)
end

local function startAutoKenLoop()
    if State.autoKenRunning then return end
    State.autoKenRunning = true
    task.spawn(function()
        while Config.AutoKen do
            task.wait(0.1)
            pcall(function()
                local c = lp.Character; if not c then return end
                if CS:HasTag(c, "Ken") and CommE then CommE:FireServer("Ken", true) end
            end)
        end
        State.autoKenRunning = false
    end)
end

-- ═══════════════════════════════════════════════════════════
-- ESP SYSTEM
-- ═══════════════════════════════════════════════════════════

local function getESPColor(p)
    if p == lp then return Color3.fromRGB(0, 255, 0) end
    if isEnemy(p) then return Color3.fromRGB(255, 80, 80) end
    return Color3.fromRGB(0, 255, 0)
end

local espScreen = Instance.new("ScreenGui")
espScreen.Name = "BragaoESP"
espScreen.ResetOnSpawn = false
espScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
espScreen.IgnoreGuiInset = true
espScreen.DisplayOrder = -1
espScreen.Parent = lp:WaitForChild("PlayerGui")

-- NAME ESP
local ESPs = {}
local espFolder = game.CoreGui:FindFirstChild("GlobalESP")
if not espFolder then
    espFolder = Instance.new("Folder")
    espFolder.Name = "GlobalESP"
    espFolder.Parent = game.CoreGui
end

local function createESP(tp)
    if ESPs[tp] and ESPs[tp].Parent then return end
    local c = tp.Character; if not c then return end
    local head = c:FindFirstChild("Head"); if not head then return end

    local b = Instance.new("BillboardGui")
    b.Name = tp.Name
    b.Adornee = head
    b.Size = UDim2.fromOffset(220, 50)
    b.AlwaysOnTop = true
    b.StudsOffset = Vector3.new(0, 3, 0)
    b.Parent = espFolder

    local l = Instance.new("TextLabel")
    l.Name = "LevelLabel"
    l.Size = UDim2.new(1, 0, 0.5, 0)
    l.BackgroundTransparency = 1
    l.Text = "Lv. ???"
    l.TextColor3 = Color3.fromRGB(0, 170, 255)
    l.TextStrokeTransparency = 0.2
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 14
    l.Parent = b

    local m = Instance.new("TextLabel")
    m.Name = "MainLabel"
    m.Size = UDim2.new(1, 0, 0.5, 0)
    m.Position = UDim2.new(0, 0, 0.5, 0)
    m.BackgroundTransparency = 1
    m.Text = "[0] " .. tp.DisplayName .. " (0m)"
    m.TextColor3 = getESPColor(tp)
    m.TextStrokeTransparency = 0.2
    m.Font = Enum.Font.SourceSansBold
    m.TextSize = 16
    m.Parent = b

    ESPs[tp] = b
end

local boxFrames = {}
local tracerFrames = {}

local function getOrCreateBox(p)
    if boxFrames[p] and boxFrames[p].frame.Parent then return boxFrames[p] end
    local f = Instance.new("Frame")
    f.Name = "Box_" .. p.Name
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.Visible = false
    f.ZIndex = 1
    f.Parent = espScreen
    local s = Instance.new("UIStroke")
    s.Color = getESPColor(p)
    s.Thickness = 1.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = f
    boxFrames[p] = { frame = f, stroke = s }
    return boxFrames[p]
end

local function getOrCreateTracer(p)
    if tracerFrames[p] and tracerFrames[p].frame.Parent then return tracerFrames[p] end
    local f = Instance.new("Frame")
    f.Name = "Tracer_" .. p.Name
    f.BackgroundColor3 = getESPColor(p)
    f.BorderSizePixel = 0
    f.AnchorPoint = Vector2.new(0, 0.5)
    f.Visible = false
    f.ZIndex = 2
    f.Parent = espScreen
    tracerFrames[p] = { frame = f }
    return tracerFrames[p]
end

-- Main render loop
RunService.RenderStepped:Connect(function()
    for _, tp in ipairs(Players:GetPlayers()) do
        if tp ~= lp then
            local char = tp.Character
            local head = char and char:FindFirstChild("Head")
            local hrp  = char and char:FindFirstChild("HumanoidRootPart")
            local hum  = char and char:FindFirstChildOfClass("Humanoid")

            local myChar = lp.Character
            local myHead = myChar and myChar:FindFirstChild("Head")
            local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")

            local alive = char and head and hrp and hum and hum.Health > 0

            -- ═══ NAME & HP ESP ═══
            if Config.ESP then
                if alive and myHRP then
                    pcall(function()
                        if not ESPs[tp] or not ESPs[tp].Parent then
                            createESP(tp)
                        end
                        local gui = ESPs[tp]
                        if gui and gui.Parent then
                            gui.Adornee = head
                            gui.Enabled = true
                            local d = (myHRP.Position - hrp.Position).Magnitude
                            local ml = gui:FindFirstChild("MainLabel")
                            local ll = gui:FindFirstChild("LevelLabel")
                            if ll then
                                local df = tp:FindFirstChild("Data")
                                local lv = df and df:FindFirstChild("Level")
                                ll.Text = lv and ("Lv. " .. lv.Value) or "Lv. ???"
                            end
                            if ml then
                                ml.Text = "[" .. math.floor(hum.Health) .. "] " .. tp.DisplayName .. " (" .. math.floor(d) .. "m)"
                                ml.TextColor3 = getESPColor(tp)
                            end
                        end
                    end)
                else
                    local gui = ESPs[tp]
                    if gui and gui.Parent then gui.Enabled = false end
                end
            else
                local gui = ESPs[tp]
                if gui and gui.Parent then gui.Enabled = false end
            end

            -- ═══ BOX ESP ═══
            if Config.BoxESP then
                local boxData = getOrCreateBox(tp)
                if alive then
                    local topPos = head.Position + Vector3.new(0, 0.5, 0)
                    local botPos = hrp.Position - Vector3.new(0, 3, 0)
                    local top = cam:WorldToViewportPoint(topPos)
                    local bot = cam:WorldToViewportPoint(botPos)
                    if top.Z > 0 and bot.Z > 0 then
                        local h = math.abs(top.Y - bot.Y)
                        local w = h * 0.55
                        boxData.frame.Visible = true
                        boxData.frame.Position = UDim2.fromOffset(
                            math.floor(top.X - w / 2 + 0.5),
                            math.floor(top.Y + 0.5)
                        )
                        boxData.frame.Size = UDim2.fromOffset(math.floor(w + 0.5), math.floor(h + 0.5))
                        boxData.stroke.Color = getESPColor(tp)
                    else
                        boxData.frame.Visible = false
                    end
                else
                    boxData.frame.Visible = false
                end
            else
                local bd = boxFrames[tp]
                if bd and bd.frame.Parent then bd.frame.Visible = false end
            end

            -- ═══ TRACER ESP ═══
            if Config.TracerESP then
                local trData = getOrCreateTracer(tp)
                if alive and myHead then
                    -- Ambos extremos en la cabeza (más natural y estable)
                    local origin3D = myHead.Position
                    local target3D = head.Position

                    local originP = cam:WorldToViewportPoint(origin3D)
                    local targetP = cam:WorldToViewportPoint(target3D)

                    -- Solo verificamos Z > 0 (frente a cámara)
                    -- Redondeamos a enteros para evitar jitter sub-pixel
                    if originP.Z > 0 and targetP.Z > 0 then
                        local ox = math.floor(originP.X + 0.5)
                        local oy = math.floor(originP.Y + 0.5)
                        local tx = math.floor(targetP.X + 0.5)
                        local ty = math.floor(targetP.Y + 0.5)

                        local dx = tx - ox
                        local dy = ty - oy
                        local length = math.sqrt(dx * dx + dy * dy)
                        local angle = math.deg(math.atan2(dy, dx))

                        if length >= 1 then
                            trData.frame.Visible = true
                            trData.frame.Position = UDim2.fromOffset(ox, oy)
                            trData.frame.Size = UDim2.fromOffset(math.floor(length + 0.5), 1)
                            trData.frame.Rotation = angle
                            trData.frame.BackgroundColor3 = getESPColor(tp)
                        else
                            trData.frame.Visible = false
                        end
                    else
                        trData.frame.Visible = false
                    end
                else
                    trData.frame.Visible = false
                end
            else
                local td = tracerFrames[tp]
                if td and td.frame.Parent then td.frame.Visible = false end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if ESPs[p] then ESPs[p]:Destroy(); ESPs[p] = nil end
    if boxFrames[p] then boxFrames[p].frame:Destroy(); boxFrames[p] = nil end
    if tracerFrames[p] then tracerFrames[p].frame:Destroy(); tracerFrames[p] = nil end
end)

local function setupInfiniteJump()
    if Config.InfiniteJump and not State.infJumpConn then
        State.infJumpConn = UIS.InputBegan:Connect(function(i, gp)
            if gp then return end
            if i.KeyCode == Enum.KeyCode.Space then
                local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    elseif not Config.InfiniteJump and State.infJumpConn then
        State.infJumpConn:Disconnect(); State.infJumpConn = nil
    end
end
RunService.Heartbeat:Connect(function()
    if Config.WalkSpeed > 16 then
        local h = getHum(); if h then h.WalkSpeed = Config.WalkSpeed end
    end
end)
local function setupAntiAFK()
    if Config.AntiAFK and not State.antiAFKRunning then
        State.antiAFKRunning = true
        task.spawn(function()
            while Config.AntiAFK do
                task.wait(60)
                pcall(function()
                    VU:CaptureController()
                    VU:ClickButton1(Vector2.new(0, 0))
                end)
            end
            State.antiAFKRunning = false
        end)
    end
end
print("[5] Gameplay funcs OK")

-- ═══════════════════════════════════════════════════════════
-- UI
-- ═══════════════════════════════════════════════════════════
local T = {
    BG = Color3.fromRGB(8,8,8), PANEL = Color3.fromRGB(14,14,14),
    TITLEBAR = Color3.fromRGB(12,12,12), ELEMENT = Color3.fromRGB(20,20,20),
    ELEMENT_HOV = Color3.fromRGB(30,30,30), ELEMENT_ACT = Color3.fromRGB(38,38,38),
    BORDER = Color3.fromRGB(55,55,55), BORDER_SOFT = Color3.fromRGB(40,40,40),
    TEXT = Color3.fromRGB(255,255,255), TEXT_DIM = Color3.fromRGB(150,150,150),
    ON = Color3.fromRGB(70,200,110), OFF = Color3.fromRGB(55,55,65),
    CLOSE_HOV = Color3.fromRGB(230,70,70), MIN_HOV = Color3.fromRGB(55,55,55),
}
T.ACCENT = Color3.fromRGB(255, 200, 0)
T.ACCENT_DIM = Color3.fromRGB(160, 125, 0)

local FONT = Enum.Font.SourceSans
local FONT_B = Enum.Font.SourceSansBold

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
local function stroke(p, c, th, tr)
    return new("UIStroke", {
        Color = c or T.BORDER, Thickness = th or 1, Transparency = tr or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, p)
end

local screenGui = new("ScreenGui", {
    Name = "BragaoHub", ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true,
}, lp:WaitForChild("PlayerGui"))
print("[6] ScreenGui OK")

local notifHolder = new("Frame", {
    Name = "Notifs", BackgroundTransparency = 1,
    Size = UDim2.fromOffset(210, 400),
    Position = UDim2.new(1, -226, 0, 60),
}, screenGui)
new("UIListLayout", {
    Padding = UDim.new(0, 5),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    SortOrder = Enum.SortOrder.LayoutOrder,
}, notifHolder)

local function notify(title, content, color)
    color = color or T.ACCENT
    local h = content and 38 or 26
    local card = new("Frame", {
        BackgroundColor3 = T.PANEL, BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, h), BorderSizePixel = 0,
    }, notifHolder)
    corner(card, 5); stroke(card, T.BORDER_SOFT, 1, 0.2)

    local bar = new("Frame", {
        BackgroundColor3 = color, Size = UDim2.new(0, 2, 1, 0), BorderSizePixel = 0,
    }, card)

    local tl = new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 9, 0, content and 4 or 0),
        Size = UDim2.new(1, -16, 0, content and 13 or 26),
        Font = FONT_B,
        Text = title, TextColor3 = T.TEXT, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)

    local cl
    if content then
        cl = new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 9, 0, 18),
            Size = UDim2.new(1, -16, 0, 15),
            Font = FONT,
            Text = content, TextColor3 = T.TEXT_DIM, TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }, card)
    end

    tw(card, { BackgroundTransparency = 0 }, 0.15)
    tw(tl, { TextTransparency = 0 }, 0.15)
    if cl then tw(cl, { TextTransparency = 0 }, 0.15) end
    tw(bar, { BackgroundTransparency = 0 }, 0.15)

    task.spawn(function()
        task.wait(1.8)
        if not card.Parent then return end
        tw(card, { BackgroundTransparency = 1 }, 0.22)
        tw(tl, { TextTransparency = 1 }, 0.22)
        if cl then tw(cl, { TextTransparency = 1 }, 0.22) end
        tw(bar, { BackgroundTransparency = 1 }, 0.22)
        task.wait(0.28)
        if card.Parent then card:Destroy() end
    end)
end
print("[7] Notify OK")

local mainFrame = new("Frame", {
    Name = "MainFrame", Size = UDim2.fromOffset(500, 380),
    Position = UDim2.new(0.5, -250, 0.5, -190),
    BackgroundColor3 = T.BG, BorderSizePixel = 0,
    Active = true, ClipsDescendants = true,
}, screenGui)
corner(mainFrame, 10)
stroke(mainFrame, T.BORDER_SOFT, 1, 0.2)

local titleBar = new("Frame", {
    Name = "TitleBar", Size = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = T.TITLEBAR, BorderSizePixel = 0,
}, mainFrame)
corner(titleBar, 10)
new("Frame", {
    BackgroundColor3 = T.TITLEBAR, Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14), BorderSizePixel = 0,
}, titleBar)
new("Frame", {
    BackgroundColor3 = T.BORDER_SOFT, Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, -1), BorderSizePixel = 0,
}, titleBar)

local winTitle = new("TextLabel", {
    BackgroundTransparency = 1, Position = UDim2.new(0, 46, 0, 0),
    Size = UDim2.new(0, 300, 1, 0), Font = FONT_B,
    Text = "BRAGAO HUB", TextColor3 = T.ACCENT, TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
}, titleBar)

local closeBtn = new("TextButton", {
    BackgroundTransparency = 1, Position = UDim2.new(1, -34, 0, 8),
    Size = UDim2.fromOffset(24, 20), Font = FONT_B, Text = "X",
    TextColor3 = T.TEXT_DIM, TextSize = 15,
    AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
closeBtn.MouseEnter:Connect(function() tw(closeBtn, { TextColor3 = T.CLOSE_HOV }) end)
closeBtn.MouseLeave:Connect(function() tw(closeBtn, { TextColor3 = T.TEXT_DIM }) end)

local minBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT, Position = UDim2.new(1, -66, 0, 8),
    Size = UDim2.fromOffset(26, 20), Font = FONT_B, Text = "—",
    TextColor3 = T.TEXT, TextSize = 13,
    AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(minBtn, 4); stroke(minBtn, T.BORDER_SOFT, 1, 0.2)

local menuBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT, Position = UDim2.new(0, 10, 0, 8),
    Size = UDim2.fromOffset(26, 20), Font = FONT_B, Text = "=",
    TextColor3 = T.TEXT, TextSize = 14,
    AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(menuBtn, 4); stroke(menuBtn, T.BORDER_SOFT, 1, 0.2)

menuBtn.MouseEnter:Connect(function() tw(menuBtn, { BackgroundColor3 = T.MIN_HOV }) end)
menuBtn.MouseLeave:Connect(function() tw(menuBtn, { BackgroundColor3 = T.ELEMENT }) end)
minBtn.MouseEnter:Connect(function() tw(minBtn, { BackgroundColor3 = T.MIN_HOV }) end)
minBtn.MouseLeave:Connect(function() tw(minBtn, { BackgroundColor3 = T.ELEMENT }) end)

local body = new("Frame", {
    Name = "Body", BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 36), Size = UDim2.new(1, 0, 1, -36),
}, mainFrame)

local sideW = 145
local sidebar = new("Frame", {
    Name = "Sidebar", BackgroundColor3 = T.PANEL,
    Size = UDim2.new(0, sideW, 1, 0), BorderSizePixel = 0,
}, body)
new("Frame", {
    BackgroundColor3 = T.BORDER_SOFT, Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(1, -1, 0, 0), BorderSizePixel = 0,
}, sidebar)

local tabList = new("ScrollingFrame", {
    BackgroundTransparency = 1, Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6), BorderSizePixel = 0,
    ScrollBarThickness = 3, ScrollBarImageColor3 = T.BORDER,
    CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, sidebar)
new("UIListLayout", {
    Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder,
}, tabList)

local content = new("Frame", {
    Name = "Content", BackgroundTransparency = 1,
    Position = UDim2.new(0, sideW, 0, 0), Size = UDim2.new(1, -sideW, 1, 0),
}, body)
print("[8] Frame principal OK")

local dS, sP
titleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dS = i.Position; sP = mainFrame.Position
        local c; c = i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then dS = nil; c:Disconnect() end
        end)
    end
end)
UIS.InputChanged:Connect(function(i)
    if dS and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dS
        mainFrame.Position = UDim2.new(sP.X.Scale, sP.X.Offset + d.X, sP.Y.Scale, sP.Y.Offset + d.Y)
    end
end)

local sidebarOpen = true
menuBtn.MouseButton1Click:Connect(function()
    playClick()
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

local minimized, savedSize = false, mainFrame.Size
minBtn.MouseButton1Click:Connect(function()
    playClick()
    minimized = not minimized
    if minimized then
        savedSize = mainFrame.Size; body.Visible = false
        tw(mainFrame, { Size = UDim2.fromOffset(260, 36) }, 0.2)
    else
        body.Visible = true
        tw(mainFrame, { Size = savedSize }, 0.2)
    end
end)

local floatBtn = new("TextButton", {
    Name = "FloatButton", BackgroundColor3 = T.BG,
    Size = UDim2.fromOffset(130, 34), Position = UDim2.new(0, 20, 0, 20),
    Font = FONT_B, Text = "BRAGAO HUB", TextColor3 = T.ACCENT,
    TextSize = 12, AutoButtonColor = false, BorderSizePixel = 0,
    Visible = false, ZIndex = 50,
}, screenGui)
corner(floatBtn, 8)
stroke(floatBtn, T.ACCENT, 1, 0.1)

floatBtn.MouseButton1Click:Connect(function()
    playClick()
    floatBtn.Visible = false
    mainFrame.Visible = true
    local gs = savedSize
    mainFrame.Size = UDim2.fromOffset(gs.X.Offset * 0.85, gs.Y.Offset * 0.85)
    mainFrame.BackgroundTransparency = 1
    tw(mainFrame, { Size = gs, BackgroundTransparency = 0 }, 0.22)
end)

closeBtn.MouseButton1Click:Connect(function()
    playClick()
    local gs = mainFrame.Size
    tw(mainFrame, {
        Size = UDim2.fromOffset(gs.X.Offset * 0.85, gs.Y.Offset * 0.85),
        BackgroundTransparency = 1,
    }, 0.18)
    task.delay(0.22, function()
        mainFrame.Visible = false
        mainFrame.BackgroundTransparency = 0
        mainFrame.Size = savedSize
        floatBtn.Visible = true
    end)
end)

local fD, fS
floatBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        fD = i.Position; fS = floatBtn.Position
        local c; c = i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then fD = nil; c:Disconnect() end
        end)
    end
end)
UIS.InputChanged:Connect(function(i)
    if fD and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - fD
        floatBtn.Position = UDim2.new(fS.X.Scale, fS.X.Offset + d.X, fS.Y.Scale, fS.Y.Offset + d.Y)
    end
end)
print("[9] Float button OK")

local accentRefreshers = {}
local function registerAccent(fn) table.insert(accentRefreshers, fn) end
local function setAccent(color)
    T.ACCENT = color
    T.ACCENT_DIM = Color3.new(color.R * 0.6, color.G * 0.6, color.B * 0.6)
    for _, fn in ipairs(accentRefreshers) do pcall(fn) end
end
registerAccent(function() winTitle.TextColor3 = T.ACCENT end)
registerAccent(function() floatBtn.TextColor3 = T.ACCENT end)

local tabs, activeTab = {}, nil
local function createTab(title)
    local tab = { Title = title, Content = nil, Button = nil }

    tab.Content = new("ScrollingFrame", {
        Name = title, BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, -20), Position = UDim2.new(0, 10, 0, 10),
        BorderSizePixel = 0, ScrollBarThickness = 4,
        ScrollBarImageColor3 = T.BORDER,
        CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    }, content)
    new("UIListLayout", {
        Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder,
    }, tab.Content)

    tab.Button = new("TextButton", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 32),
        Font = FONT, Text = "  " .. title,
        TextColor3 = T.TEXT_DIM, TextSize = 12,
        AutoButtonColor = false, BorderSizePixel = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, tabList)
    corner(tab.Button, 5)
    local s = stroke(tab.Button, T.BORDER_SOFT, 1, 0.15)

    tab.Button.MouseEnter:Connect(function()
        if activeTab ~= tab then
            tw(tab.Button, { BackgroundColor3 = T.ELEMENT_HOV, TextColor3 = T.TEXT })
        end
    end)
    tab.Button.MouseLeave:Connect(function()
        if activeTab ~= tab then
            tw(tab.Button, { BackgroundColor3 = T.ELEMENT, TextColor3 = T.TEXT_DIM })
        end
    end)

    tab.Button.MouseButton1Click:Connect(function()
        playClick()
        if activeTab then
            activeTab.Content.Visible = false
            tw(activeTab.Button, { BackgroundColor3 = T.ELEMENT, TextColor3 = T.TEXT_DIM })
            local oS = activeTab.Button:FindFirstChildOfClass("UIStroke")
            if oS then oS.Color = T.BORDER_SOFT; oS.Transparency = 0.15 end
        end
        activeTab = tab
        tab.Content.Visible = true

        tab.Content.BackgroundTransparency = 1
        tab.Content.Position = UDim2.new(0, 22, 0, 10)
        tw(tab.Content, { Position = UDim2.new(0, 10, 0, 10) }, 0.22)

        tw(tab.Button, { BackgroundColor3 = T.ELEMENT_ACT, TextColor3 = T.TEXT })
        s.Color = T.ACCENT; s.Transparency = 0
    end)

    registerAccent(function()
        if activeTab == tab then s.Color = T.ACCENT end
    end)

    table.insert(tabs, tab)
    if #tabs == 1 then
        tab.Content.Visible = true; activeTab = tab
        tab.Content.BackgroundTransparency = 1
        tab.Content.Position = UDim2.new(0, 22, 0, 10)
        tw(tab.Content, { Position = UDim2.new(0, 10, 0, 10) }, 0.22)
        tw(tab.Button, { BackgroundColor3 = T.ELEMENT_ACT, TextColor3 = T.TEXT })
        s.Color = T.ACCENT; s.Transparency = 0
    end
    return tab
end
print("[10] createTab OK")

local activeList = {}
local activeUI = nil
local function refreshActiveUI()
    if not activeUI then return end
    for _, c in ipairs(activeUI:GetChildren()) do
        if c:IsA("TextLabel") or c:IsA("Frame") then c:Destroy() end
    end
    local count = 0
    for name, state in pairs(activeList) do
        if state then
            count = count + 1
            local row = new("Frame", {
                BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 22),
                BorderSizePixel = 0,
            }, activeUI)
            corner(row, 4); stroke(row, T.BORDER_SOFT, 1, 0.2)
            new("Frame", {
                BackgroundColor3 = T.ON, Size = UDim2.fromOffset(6, 6),
                Position = UDim2.new(0, 10, 0.5, -3), BorderSizePixel = 0,
            }, row)
            new("TextLabel", {
                BackgroundTransparency = 1, Position = UDim2.new(0, 24, 0, 0),
                Size = UDim2.new(1, -30, 1, 0), Font = FONT,
                Text = name, TextColor3 = T.TEXT, TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, row)
        end
    end
    if count == 0 then
        new("TextLabel", {
            BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22),
            Font = FONT, Text = "  Ninguna activa",
            TextColor3 = T.TEXT_DIM, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, activeUI)
    end
end
print("[11] refreshActiveUI OK")

local function section(tab, title)
    local sec = new("Frame", {
        BackgroundColor3 = T.PANEL, Size = UDim2.new(1, 0, 0, 26),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(sec, 6); stroke(sec, T.BORDER_SOFT, 1, 0.3)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -20, 1, 0), Font = FONT_B,
        Text = title, TextColor3 = T.TEXT, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, sec)
end

local function toggle(tab, cfg)
    cfg = cfg or {}
    local hasDesc = cfg.Desc and cfg.Desc ~= ""
    local H = hasDesc and 48 or 38
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, H),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)

    local dot = new("Frame", {
        BackgroundColor3 = T.ON, Size = UDim2.fromOffset(6, 6),
        Position = UDim2.new(0, 10, hasDesc and 0 or 0.5, hasDesc and 12 or -3),
        BorderSizePixel = 0, BackgroundTransparency = cfg.Value and 0 or 1,
    }, c)
    corner(dot, 3)

    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 24, 0, hasDesc and 6 or 0),
        Size = UDim2.new(1, -100, 0, hasDesc and 15 or H),
        Font = FONT_B, Text = cfg.Title or "Toggle",
        TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    if hasDesc then
        new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 24, 0, 22),
            Size = UDim2.new(1, -100, 0, 13), Font = FONT,
            Text = cfg.Desc, TextColor3 = T.TEXT_DIM, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end

    local switch = new("Frame", {
        BackgroundColor3 = cfg.Value and T.ON or T.OFF,
        Position = UDim2.new(1, -48, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(36, 18), BorderSizePixel = 0,
    }, c)
    corner(switch, 9); stroke(switch, T.BORDER_SOFT, 1, 0.25)

    local knob = new("Frame", {
        BackgroundColor3 = T.TEXT,
        Position = cfg.Value and UDim2.new(1, -16, 0, 2) or UDim2.new(0, 2, 0, 2),
        Size = UDim2.fromOffset(14, 14), BorderSizePixel = 0,
    }, switch)
    corner(knob, 7)

    local btn = new("TextButton", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0),
        Text = "", AutoButtonColor = false,
    }, c)

    local state = cfg.Value or false
    btn.MouseButton1Click:Connect(function()
        state = not state
        playClick()
        tw(switch, { BackgroundColor3 = state and T.ON or T.OFF }, 0.2)
        tw(knob, { Position = state and UDim2.new(1, -16, 0, 2) or UDim2.new(0, 2, 0, 2) }, 0.2)
        tw(dot, { BackgroundTransparency = state and 0 or 1 }, 0.15)
        activeList[cfg.Title] = state
        refreshActiveUI()
        notify(state and "Activado" or "Desactivado", cfg.Title, state and T.ON or T.CLOSE_HOV)
        if cfg.Callback then cfg.Callback(state) end
    end)
end

local function input(tab, cfg)
    cfg = cfg or {}
    local hasDesc = cfg.Desc and cfg.Desc ~= ""
    local H = hasDesc and 72 or 58
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, H),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)

    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 6),
        Size = UDim2.new(1, -100, 0, 15), Font = FONT_B,
        Text = cfg.Title or "Input", TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    if hasDesc then
        new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 22),
            Size = UDim2.new(1, -100, 0, 13), Font = FONT,
            Text = cfg.Desc, TextColor3 = T.TEXT_DIM, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end

    local boxY = hasDesc and 42 or 28
    local box = new("Frame", {
        BackgroundColor3 = T.BG, Position = UDim2.new(0, 12, 0, boxY),
        Size = UDim2.new(1, -24, 0, 24), BorderSizePixel = 0,
    }, c)
    corner(box, 5); stroke(box, T.BORDER_SOFT, 1, 0.2)

    local tb = new("TextBox", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 8, 0, 0),
        Size = UDim2.new(1, -16, 1, 0), Font = FONT,
        Text = tostring(cfg.Value or ""),
        PlaceholderText = cfg.Placeholder or "escribe aqui...",
        PlaceholderColor3 = T.TEXT_DIM, TextColor3 = T.TEXT,
        TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
    }, box)

    tb.FocusLost:Connect(function()
        if cfg.Callback then cfg.Callback(tb.Text) end
    end)
end

local ACCENT_PRESETS = {
    { Name = "Amarillo", C = Color3.fromRGB(255, 200, 0) },
    { Name = "Rojo",     C = Color3.fromRGB(230, 70, 70) },
    { Name = "Verde",    C = Color3.fromRGB(70, 200, 110) },
    { Name = "Azul",     C = Color3.fromRGB(80, 160, 255) },
    { Name = "Morado",   C = Color3.fromRGB(170, 100, 255) },
    { Name = "Rosa",     C = Color3.fromRGB(255, 120, 180) },
    { Name = "Cyan",     C = Color3.fromRGB(80, 220, 220) },
    { Name = "Blanco",   C = Color3.fromRGB(240, 240, 240) },
}

local function colorPicker(tab, title)
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 92),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 6),
        Size = UDim2.new(1, -20, 0, 15), Font = FONT_B,
        Text = title, TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)
    local grid = new("Frame", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 28),
        Size = UDim2.new(1, -24, 0, 56), BorderSizePixel = 0,
    }, c)
    new("UIGridLayout", {
        CellSize = UDim2.fromOffset(32, 24),
        CellPadding = UDim2.fromOffset(8, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, grid)
    for _, preset in ipairs(ACCENT_PRESETS) do
        local b = new("TextButton", {
            BackgroundColor3 = preset.C, Size = UDim2.fromOffset(32, 24),
            Text = "", AutoButtonColor = false, BorderSizePixel = 0,
        }, grid)
        corner(b, 5); stroke(b, T.BORDER_SOFT, 1, 0.3)
        b.MouseButton1Click:Connect(function()
            playClick()
            setAccent(preset.C)
            notify("Tema cambiado", preset.Name, preset.C)
        end)
    end
end
print("[12] Componentes OK")

local watermarkEnabled = false
local wmFrame = new("Frame", {
    Name = "Watermark", BackgroundColor3 = T.BG, BackgroundTransparency = 0.15,
    Size = UDim2.fromOffset(230, 24), Position = UDim2.new(1, -240, 0, 8),
    Visible = false, BorderSizePixel = 0, Active = true,
}, screenGui)
corner(wmFrame, 5); stroke(wmFrame, T.BORDER_SOFT, 1, 0.2)
local wmLabel = new("TextLabel", {
    BackgroundTransparency = 1, Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 5, 0, 0), Font = FONT_B,
    Text = "BRAGAO HUB  |  FPS: --  |  -- ms",
    TextColor3 = T.TEXT, TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Center,
}, wmFrame)

local wD, wS
wmFrame.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        wD = i.Position; wS = wmFrame.Position
        local c; c = i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then wD = nil; c:Disconnect() end
        end)
    end
end)
UIS.InputChanged:Connect(function(i)
    if wD and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - wD
        wmFrame.Position = UDim2.new(wS.X.Scale, wS.X.Offset + d.X, wS.Y.Scale, wS.Y.Offset + d.Y)
    end
end)

local fpsCount, fpsTime, currentFPS = 0, 0, 60
RunService.RenderStepped:Connect(function(dt)
    fpsCount = fpsCount + 1
    fpsTime = fpsTime + dt
    if fpsTime >= 1 then
        currentFPS = fpsCount; fpsCount = 0; fpsTime = 0
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
            wmLabel.Text = string.format("BRAGAO HUB  |  FPS: %d  |  %d ms", currentFPS, ping)
        end
    end
end)
print("[13] Watermark OK")

local tabCombat   = createTab("Combat")
local tabAim      = createTab("Aim")
local tabMovement = createTab("Movement")
local tabVisual   = createTab("Visual")
local tabUtils    = createTab("Utils")
print("[14] Tabs creadas")

section(tabCombat, "Silent Aim")
toggle(tabCombat, { Title = "Silent Aim Players", Desc = "Apunta a jugadores enemigos", Value = false,
    Callback = function(v) Config.SilentAimPlayers = v; if v then installSilentAim() end end })
toggle(tabCombat, { Title = "Silent Aim NPCs", Desc = "Apunta a NPCs enemigos", Value = false,
    Callback = function(v) Config.SilentAimNPCs = v; if v then installSilentAim() end end })
toggle(tabCombat, { Title = "Auto Ken", Desc = "Activa Ken automaticamente", Value = false,
    Callback = function(v) Config.AutoKen = v; if v then startAutoKenLoop() end end })

section(tabAim, "Prediction")
toggle(tabAim, { Title = "Prediction", Desc = "Predice la posicion del enemigo", Value = false,
    Callback = function(v) Config.Prediction = v end })
input(tabAim, { Title = "Prediction Amount", Desc = "Multiplicador (ej. 0.1)",
    Value = tostring(Config.PredictionAmount), Placeholder = "0.1",
    Callback = function(t) local n = tonumber(t); if n then Config.PredictionAmount = n end end })
input(tabAim, { Title = "Max Range", Desc = "Rango maximo del aim (studs)",
    Value = tostring(State.maxRange), Placeholder = "500",
    Callback = function(t) local n = tonumber(t); if n then State.maxRange = n end end })

section(tabMovement, "Salto")
toggle(tabMovement, { Title = "Infinite Jump", Desc = "Salto infinito con espacio", Value = false,
    Callback = function(v) Config.InfiniteJump = v; setupInfiniteJump() end })
section(tabMovement, "Velocidad")
input(tabMovement, { Title = "Walk Speed", Desc = "Velocidad de caminar (16 - 100)",
    Value = tostring(Config.WalkSpeed), Placeholder = "16",
    Callback = function(t)
        local n = tonumber(t)
        if n then n = math.clamp(n, 16, 100); Config.WalkSpeed = n end
    end })

section(tabVisual, "ESP Name & HP")
toggle(tabVisual, { Title = "ESP Name & HP", Desc = "Nombre, vida y distancia arriba del jugador", Value = false,
    Callback = function(v) Config.ESP = v end })

section(tabVisual, "ESP Box")
toggle(tabVisual, { Title = "ESP Box", Desc = "Caja 2D alrededor del jugador", Value = false,
    Callback = function(v) Config.BoxESP = v end })

section(tabVisual, "ESP Tracer")
toggle(tabVisual, { Title = "ESP Tracer", Desc = "Linea desde tu personaje al enemigo", Value = false,
    Callback = function(v) Config.TracerESP = v end })

section(tabUtils, "Utilidades")
toggle(tabUtils, { Title = "Anti-AFK", Desc = "Evita ser expulsado por inactividad", Value = false,
    Callback = function(v) Config.AntiAFK = v; setupAntiAFK() end })
toggle(tabUtils, { Title = "Watermark", Desc = "Muestra FPS y Ping (arrastrable)", Value = false,
    Callback = function(v) watermarkEnabled = v; wmFrame.Visible = v end })

section(tabUtils, "Opciones activas")
activeUI = new("Frame", {
    BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y, BorderSizePixel = 0,
}, tabUtils.Content)
new("UIListLayout", {
    Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
}, activeUI)
refreshActiveUI()

section(tabUtils, "Apariencia")
colorPicker(tabUtils, "Color de acento")
print("[15] Opciones OK")

notify("Bragao Hub v7.4", "Name ESP + Tracer arreglados", T.ACCENT)
print("[16] LISTO")
