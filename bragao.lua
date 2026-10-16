-- ═══════════════════════════════════════════════════════════
-- BRAGAO HUB v9 - FOV Circle + Color Pickers individuales
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
local Mouse = lp:GetMouse()
print("[2] Servicios OK")

local Config = {
    SilentAimPlayers = false, SilentAimNPCs = false,
    Prediction = false, PredictionAmount = 0.1,
    AutoKen = false,
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

-- ═══════════════════════════════════════════════════════════
-- GAMEPLAY FUNCS
-- ═══════════════════════════════════════════════════════════
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
-- ESP + FOV (Drawing API)
-- ═══════════════════════════════════════════════════════════
local Drawing = Drawing or (getgenv and getgenv().Drawing)
local hasDrawing = pcall(function() return Drawing.new("Line") end)

if not hasDrawing then
    warn("[Bragao Hub] Tu executor NO soporta Drawing API")
end

local ESP = {
    NameEnabled = false, TracersEnabled = false, BoxEnabled = false,
    HealthEnabled = false, ChamsEnabled = false, SkeletonEnabled = false,
    LimitDistance = false, MaxDistance = 250,

    NameColor     = Color3.fromRGB(255, 255, 255),
    TracerColor   = Color3.fromRGB(0, 255, 140),
    BoxColor      = Color3.fromRGB(0, 255, 140),
    SkeletonColor = Color3.fromRGB(0, 255, 140),
    ChamsColor    = Color3.fromRGB(0, 255, 140),

    TextSize = 14,
    TracerThickness = 1.5,
}

-- FOV Circle
local FOV = {
    Enabled = false,
    Size = 160,
    Thickness = 1.6,
    Color = Color3.fromRGB(0, 255, 140),
}

local FOVCircle
if hasDrawing then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = FOV.Thickness
    FOVCircle.NumSides = 64
    FOVCircle.Filled = false
    FOVCircle.Transparency = 1
    FOVCircle.Visible = false
end

local ESPObjects = {}

local function CreateESP(player)
    if not hasDrawing then return end
    if player == lp then return end
    if ESPObjects[player] then return end

    local d = {
        Name = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
        Box = Drawing.new("Square"),
        HealthBg = Drawing.new("Square"),
        Health = Drawing.new("Square"),
        Highlight = nil,
        Skeleton = {}
    }

    d.Name.Size = ESP.TextSize
    d.Name.Center = true
    d.Name.Outline = true
    d.Name.Color = ESP.NameColor
    d.Name.Font = 2

    d.Distance.Size = ESP.TextSize - 1
    d.Distance.Center = true
    d.Distance.Outline = true
    d.Distance.Color = ESP.NameColor
    d.Distance.Font = 2

    d.Tracer.Thickness = ESP.TracerThickness
    d.Tracer.Color = ESP.TracerColor

    d.Box.Thickness = 1.5
    d.Box.Filled = false
    d.Box.Color = ESP.BoxColor

    d.HealthBg.Filled = true
    d.HealthBg.Color = Color3.fromRGB(30,30,30)
    d.Health.Filled = true

    for i = 1, 12 do
        local line = Drawing.new("Line")
        line.Thickness = 1.4
        line.Color = ESP.SkeletonColor
        d.Skeleton[i] = line
    end

    ESPObjects[player] = d
end

local function RemoveESP(player)
    if ESPObjects[player] then
        for _, v in pairs(ESPObjects[player]) do
            if type(v) == "table" then
                for _, line in pairs(v) do
                    pcall(function() line:Remove() end)
                end
            elseif type(v) == "userdata" or type(v) == "table" then
                pcall(function() v:Remove() end)
            elseif typeof(v) == "Instance" then
                pcall(function() v:Destroy() end)
            end
        end
        ESPObjects[player] = nil
    end
end

for _, plr in pairs(Players:GetPlayers()) do CreateESP(plr) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)

local function GetBonePos(char, name)
    local part = char:FindFirstChild(name)
    return part and part.Position
end

RunService.RenderStepped:Connect(function()
    if not hasDrawing then return end
    for player, d in pairs(ESPObjects) do
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
            d.Name.Visible = false; d.Distance.Visible = false
            d.Tracer.Visible = false; d.Box.Visible = false
            d.HealthBg.Visible = false; d.Health.Visible = false
            if d.Highlight then d.Highlight.Enabled = false end
            for _, line in pairs(d.Skeleton) do line.Visible = false end
            continue
        end

        local hrp = char.HumanoidRootPart
        local hum = char.Humanoid
        local dist3D = (hrp.Position - cam.CFrame.Position).Magnitude

        if ESP.LimitDistance and dist3D > ESP.MaxDistance then
            d.Name.Visible = false; d.Distance.Visible = false
            d.Tracer.Visible = false; d.Box.Visible = false
            d.HealthBg.Visible = false; d.Health.Visible = false
            if d.Highlight then d.Highlight.Enabled = false end
            for _, line in pairs(d.Skeleton) do line.Visible = false end
            continue
        end

        local pos, onScreen = cam:WorldToViewportPoint(hrp.Position)

        -- Chams
        if ESP.ChamsEnabled then
            if not d.Highlight or not d.Highlight.Parent then
                local hl = Instance.new("Highlight")
                hl.OutlineColor = Color3.new(1,1,1)
                hl.FillTransparency = 0.5
                hl.Parent = char
                d.Highlight = hl
            end
            d.Highlight.Enabled = true
            d.Highlight.FillColor = ESP.ChamsColor
        else
            if d.Highlight then d.Highlight.Enabled = false end
        end

        if onScreen then
            local top = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.5, 0))
            local bottom = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
            local sizeY = math.abs(top.Y - bottom.Y) / 2
            local boxSize = Vector2.new(sizeY * 1.5, sizeY * 2.2)
            local boxPos = Vector2.new(pos.X - boxSize.X/2, pos.Y - boxSize.Y/2)

            if ESP.NameEnabled then
                d.Name.Text = player.Name
                d.Name.Size = ESP.TextSize
                d.Name.Position = Vector2.new(pos.X, boxPos.Y - 18)
                d.Name.Color = ESP.NameColor
                d.Name.Visible = true

                d.Distance.Text = math.floor(dist3D) .. "m"
                d.Distance.Size = ESP.TextSize - 1
                d.Distance.Position = Vector2.new(pos.X, boxPos.Y + boxSize.Y + 4)
                d.Distance.Color = ESP.NameColor
                d.Distance.Visible = true
            else
                d.Name.Visible = false
                d.Distance.Visible = false
            end

            if ESP.TracersEnabled then
                d.Tracer.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                d.Tracer.To = Vector2.new(pos.X, pos.Y)
                d.Tracer.Thickness = ESP.TracerThickness
                d.Tracer.Color = ESP.TracerColor
                d.Tracer.Visible = true
            else
                d.Tracer.Visible = false
            end

            if ESP.BoxEnabled then
                d.Box.Size = boxSize
                d.Box.Position = boxPos
                d.Box.Color = ESP.BoxColor
                d.Box.Visible = true
            else
                d.Box.Visible = false
            end

            if ESP.HealthEnabled then
                local hp = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                d.HealthBg.Size = Vector2.new(3, boxSize.Y)
                d.HealthBg.Position = Vector2.new(boxPos.X - 7, boxPos.Y)
                d.HealthBg.Visible = true
                d.Health.Size = Vector2.new(3, boxSize.Y * hp)
                d.Health.Position = Vector2.new(boxPos.X - 7, boxPos.Y + boxSize.Y * (1-hp))
                d.Health.Color = Color3.fromRGB(255*(1-hp), 255*hp, 40)
                d.Health.Visible = true
            else
                d.HealthBg.Visible = false
                d.Health.Visible = false
            end

            if ESP.SkeletonEnabled then
                local function scr(p)
                    if not p then return nil end
                    local s, on = cam:WorldToViewportPoint(p)
                    return on and Vector2.new(s.X, s.Y) or nil
                end

                local head = GetBonePos(char, "Head")
                local torso = GetBonePos(char, "UpperTorso") or GetBonePos(char, "Torso")
                local larm = GetBonePos(char, "LeftUpperArm") or GetBonePos(char, "Left Arm")
                local rarm = GetBonePos(char, "RightUpperArm") or GetBonePos(char, "Right Arm")
                local lleg = GetBonePos(char, "LeftUpperLeg") or GetBonePos(char, "Left Leg")
                local rleg = GetBonePos(char, "RightUpperLeg") or GetBonePos(char, "Right Leg")
                local lhand = GetBonePos(char, "LeftHand") or larm
                local rhand = GetBonePos(char, "RightHand") or rarm
                local lfoot = GetBonePos(char, "LeftFoot") or lleg
                local rfoot = GetBonePos(char, "RightFoot") or rleg

                local connections = {
                    {head, torso}, {torso, larm}, {torso, rarm},
                    {larm, lhand}, {rarm, rhand},
                    {torso, lleg}, {torso, rleg},
                    {lleg, lfoot}, {rleg, rfoot}
                }

                for i, conn in ipairs(connections) do
                    local from = scr(conn[1])
                    local to = scr(conn[2])
                    if from and to and d.Skeleton[i] then
                        d.Skeleton[i].From = from
                        d.Skeleton[i].To = to
                        d.Skeleton[i].Color = ESP.SkeletonColor
                        d.Skeleton[i].Visible = true
                    elseif d.Skeleton[i] then
                        d.Skeleton[i].Visible = false
                    end
                end
            else
                for _, line in pairs(d.Skeleton) do line.Visible = false end
            end
        else
            d.Name.Visible = false; d.Distance.Visible = false
            d.Tracer.Visible = false; d.Box.Visible = false
            d.HealthBg.Visible = false; d.Health.Visible = false
            for _, line in pairs(d.Skeleton) do line.Visible = false end
        end
    end
end)

-- FOV Circle loop
RunService.RenderStepped:Connect(function()
    if not hasDrawing or not FOVCircle then return end
    FOVCircle.Position = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
    FOVCircle.Radius = FOV.Size
    FOVCircle.Thickness = FOV.Thickness
    FOVCircle.Color = FOV.Color
    FOVCircle.Visible = FOV.Enabled
end)

print("[5] ESP + FOV OK")

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
print("[6] Gameplay funcs OK")

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
print("[7] ScreenGui OK")

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
        Font = FONT_B, Text = title, TextColor3 = T.TEXT, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)

    local cl
    if content then
        cl = new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 9, 0, 18),
            Size = UDim2.new(1, -16, 0, 15), Font = FONT,
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
print("[8] Notify OK")

local mainFrame = new("Frame", {
    Name = "MainFrame", Size = UDim2.fromOffset(500, 400),
    Position = UDim2.new(0.5, -250, 0.5, -200),
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

-- ═══════════════════════════════════════════════════════════
-- COMPONENTES
-- ═══════════════════════════════════════════════════════════
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

local function slider(tab, cfg)
    cfg = cfg or {}
    local min = cfg.Min or 0
    local max = cfg.Max or 100
    local step = cfg.Step or 1
    local val = cfg.Default or min

    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 64),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)

    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 7),
        Size = UDim2.new(1, -100, 0, 15), Font = FONT_B,
        Text = cfg.Title or "Slider", TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    local valLbl = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(1, -80, 0, 7),
        Size = UDim2.new(0, 68, 0, 15), Font = FONT_B,
        Text = tostring(val), TextColor3 = T.ACCENT, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, c)

    local barBg = new("Frame", {
        BackgroundColor3 = T.OFF, Position = UDim2.new(0, 12, 0, 40),
        Size = UDim2.new(1, -24, 0, 8), BorderSizePixel = 0,
    }, c)
    corner(barBg, 4); stroke(barBg, T.BORDER_SOFT, 1, 0.25)

    local fill = new("Frame", {
        BackgroundColor3 = T.ACCENT, Size = UDim2.new(0, 0, 1, 0),
        BorderSizePixel = 0,
    }, barBg)
    corner(fill, 4)

    local knob = new("Frame", {
        BackgroundColor3 = T.TEXT, Size = UDim2.fromOffset(14, 14),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0), BorderSizePixel = 0,
    }, barBg)
    corner(knob, 7); stroke(knob, T.BORDER_SOFT, 1)

    local function upd(v)
        local pct = (v - min) / (max - min)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        knob.Position = UDim2.new(pct, 0, 0.5, 0)
        valLbl.Text = tostring(v)
    end
    upd(val)

    local dragging = false
    local function setFromX(x)
        local abs = barBg.AbsolutePosition.X
        local w = barBg.AbsoluteSize.X
        local pct = math.clamp((x - abs) / w, 0, 1)
        local raw = min + pct * (max - min)
        local snapped = math.floor(raw / step + 0.5) * step
        snapped = math.clamp(snapped, min, max)
        val = snapped
        upd(val)
        if cfg.Callback then cfg.Callback(val) end
    end

    barBg.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setFromX(i.Position.X)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            setFromX(i.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    registerAccent(function()
        fill.BackgroundColor3 = T.ACCENT
        valLbl.TextColor3 = T.ACCENT
    end)
end

-- ═══════════════════════════════════════════════════════════
-- COLOR PICKER AVANZADO (RGB sliders)
-- ═══════════════════════════════════════════════════════════
local function colorPickerRGB(tab, title, defaultColor, callback)
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 160),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)

    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 10),
        Size = UDim2.new(1, -70, 0, 15), Font = FONT_B,
        Text = title, TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    -- Preview + Hex
    local preview = new("Frame", {
        BackgroundColor3 = defaultColor,
        Position = UDim2.new(1, -56, 0, 8),
        Size = UDim2.fromOffset(42, 42),
        BorderSizePixel = 0,
    }, c)
    corner(preview, 5); stroke(preview, T.BORDER_SOFT, 1, 0.4)

    local hexLbl = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(1, -60, 0, 52),
        Size = UDim2.fromOffset(50, 12), Font = FONT,
        Text = "#------", TextColor3 = T.TEXT_DIM, TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Center,
    }, c)

    local curR = math.floor(defaultColor.R * 255 + 0.5)
    local curG = math.floor(defaultColor.G * 255 + 0.5)
    local curB = math.floor(defaultColor.B * 255 + 0.5)

    local function apply()
        local col = Color3.fromRGB(curR, curG, curB)
        preview.BackgroundColor3 = col
        hexLbl.Text = string.format("#%02X%02X%02X", curR, curG, curB)
        if callback then callback(col) end
    end

    local function buildSlider(y, label, initialVal, tint, onChange)
        new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, y),
            Size = UDim2.new(0, 20, 0, 16), Font = FONT_B,
            Text = label, TextColor3 = tint, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)

        local valLbl = new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(1, -54, 0, y),
            Size = UDim2.new(0, 40, 0, 16), Font = FONT_B,
            Text = tostring(initialVal), TextColor3 = T.TEXT, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Right,
        }, c)

        local barBg = new("Frame", {
            BackgroundColor3 = T.OFF, Position = UDim2.new(0, 36, 0, y + 4),
            Size = UDim2.new(1, -102, 0, 8), BorderSizePixel = 0,
        }, c)
        corner(barBg, 4); stroke(barBg, T.BORDER_SOFT, 1, 0.25)

        local pct0 = initialVal / 255
        local fill = new("Frame", {
            BackgroundColor3 = tint, Size = UDim2.new(pct0, 0, 1, 0),
            BorderSizePixel = 0,
        }, barBg)
        corner(fill, 4)

        local knob = new("Frame", {
            BackgroundColor3 = T.TEXT, Size = UDim2.fromOffset(12, 12),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(pct0, 0, 0.5, 0), BorderSizePixel = 0,
        }, barBg)
        corner(knob, 6); stroke(knob, T.BORDER_SOFT, 1)

        local dragging = false
        local function setFromX(x)
            local abs = barBg.AbsolutePosition.X
            local w = barBg.AbsoluteSize.X
            local pct = math.clamp((x - abs) / w, 0, 1)
            local v = math.floor(pct * 255 + 0.5)
            fill.Size = UDim2.new(pct, 0, 1, 0)
            knob.Position = UDim2.new(pct, 0, 0.5, 0)
            valLbl.Text = tostring(v)
            onChange(v)
            apply()
        end

        barBg.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                setFromX(i.Position.X)
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                setFromX(i.Position.X)
            end
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    buildSlider(66, "R", curR, Color3.fromRGB(255, 90, 90), function(v) curR = v end)
    buildSlider(94, "G", curG, Color3.fromRGB(90, 255, 120), function(v) curG = v end)
    buildSlider(122, "B", curB, Color3.fromRGB(90, 150, 255), function(v) curB = v end)

    apply()
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

-- WATERMARK
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

-- COMBAT
section(tabCombat, "Silent Aim")
toggle(tabCombat, { Title = "Silent Aim Players", Desc = "Apunta a jugadores enemigos", Value = false,
    Callback = function(v) Config.SilentAimPlayers = v; if v then installSilentAim() end end })
toggle(tabCombat, { Title = "Silent Aim NPCs", Desc = "Apunta a NPCs enemigos", Value = false,
    Callback = function(v) Config.SilentAimNPCs = v; if v then installSilentAim() end end })
toggle(tabCombat, { Title = "Auto Ken", Desc = "Activa Ken automaticamente", Value = false,
    Callback = function(v) Config.AutoKen = v; if v then startAutoKenLoop() end end })

-- AIM
section(tabAim, "Prediction")
toggle(tabAim, { Title = "Prediction", Desc = "Predice la posicion del enemigo", Value = false,
    Callback = function(v) Config.Prediction = v end })
input(tabAim, { Title = "Prediction Amount", Desc = "Multiplicador (ej. 0.1)",
    Value = tostring(Config.PredictionAmount), Placeholder = "0.1",
    Callback = function(t) local n = tonumber(t); if n then Config.PredictionAmount = n end end })
input(tabAim, { Title = "Max Range", Desc = "Rango maximo del aim (studs)",
    Value = tostring(State.maxRange), Placeholder = "500",
    Callback = function(t) local n = tonumber(t); if n then State.maxRange = n end end })

-- MOVEMENT
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

-- ═══════════════════════════════════════════════════════════
-- VISUAL TAB
-- ═══════════════════════════════════════════════════════════
section(tabVisual, "ESP Toggles")
toggle(tabVisual, { Title = "ESP Name + Distance", Desc = "Nombre y distancia arriba del jugador", Value = false,
    Callback = function(v) ESP.NameEnabled = v end })
toggle(tabVisual, { Title = "ESP Tracers", Desc = "Lineas desde abajo al enemigo", Value = false,
    Callback = function(v) ESP.TracersEnabled = v end })
toggle(tabVisual, { Title = "Box ESP", Desc = "Caja 2D alrededor del jugador", Value = false,
    Callback = function(v) ESP.BoxEnabled = v end })
toggle(tabVisual, { Title = "Health Bar ESP", Desc = "Barra de vida al lado del jugador", Value = false,
    Callback = function(v) ESP.HealthEnabled = v end })
toggle(tabVisual, { Title = "Chams / Highlight", Desc = "Resalta al jugador con highlight", Value = false,
    Callback = function(v) ESP.ChamsEnabled = v end })
toggle(tabVisual, { Title = "Skeleton ESP", Desc = "Dibuja el esqueleto del jugador", Value = false,
    Callback = function(v) ESP.SkeletonEnabled = v end })

section(tabVisual, "Ajustes")
slider(tabVisual, { Title = "Text Size", Min = 10, Max = 22, Step = 1, Default = 14,
    Callback = function(v) ESP.TextSize = v end })
slider(tabVisual, { Title = "Tracer Thickness", Min = 0.5, Max = 4, Step = 0.1, Default = 1.5,
    Callback = function(v) ESP.TracerThickness = v end })

section(tabVisual, "Limite de distancia")
toggle(tabVisual, { Title = "Limitar distancia ESP", Desc = "Oculta ESPs lejanos", Value = false,
    Callback = function(v) ESP.LimitDistance = v end })
slider(tabVisual, { Title = "Max Distance", Min = 50, Max = 500, Step = 10, Default = 250,
    Callback = function(v) ESP.MaxDistance = v end })

-- ═══ NUEVO: COLORES ESP INDIVIDUALES ═══
section(tabVisual, "Colores ESP")
colorPickerRGB(tabVisual, "Name Color", ESP.NameColor, function(c) ESP.NameColor = c end)
colorPickerRGB(tabVisual, "Tracer Color", ESP.TracerColor, function(c) ESP.TracerColor = c end)
colorPickerRGB(tabVisual, "Box Color", ESP.BoxColor, function(c) ESP.BoxColor = c end)
colorPickerRGB(tabVisual, "Skeleton Color", ESP.SkeletonColor, function(c) ESP.SkeletonColor = c end)
colorPickerRGB(tabVisual, "Chams Color", ESP.ChamsColor, function(c) ESP.ChamsColor = c end)

-- ═══ NUEVO: FOV CIRCLE ═══
section(tabVisual, "FOV Circle")
toggle(tabVisual, { Title = "Mostrar FOV Circle", Desc = "Circulo central para referencia del aim", Value = false,
    Callback = function(v) FOV.Enabled = v end })
slider(tabVisual, { Title = "FOV Size", Min = 40, Max = 400, Step = 1, Default = 160,
    Callback = function(v) FOV.Size = v end })
slider(tabVisual, { Title = "FOV Thickness", Min = 0.5, Max = 4, Step = 0.1, Default = 1.6,
    Callback = function(v) FOV.Thickness = v end })
colorPickerRGB(tabVisual, "FOV Color", FOV.Color, function(c) FOV.Color = c end)

section(tabVisual, "Tema UI")
colorPicker(tabVisual, "Color de acento")

-- UTILS
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

print("[15] Opciones OK")

notify("Bragao Hub v9", "FOV Circle + Color Pickers RGB", T.ACCENT)
print("[16] LISTO")
