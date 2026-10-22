local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local UIS          = game:GetService("UserInputService")
local Workspace    = game:GetService("Workspace")
local RS           = game:GetService("ReplicatedStorage")
local CoreGui      = game:GetService("CoreGui")
local HttpService  = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local lp     = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ── Remotes de Blox Fruits ────────────────────────────────────
local CommE, Awakening, registerHit, registerAttack
pcall(function()
    local Remotes = RS:WaitForChild("Remotes", 10)
    CommE     = Remotes:FindFirstChild("CommE")
    Awakening = Remotes:FindFirstChild("Awakening")
    local Net = RS:WaitForChild("Modules", 10):WaitForChild("Net", 10)
    registerHit    = Net:FindFirstChild("RE/RegisterHit")
    registerAttack = Net:FindFirstChild("RE/RegisterAttack")
end)

-- ================================================================
-- CONFIGURACIÓN GLOBAL
-- ================================================================
local Config = {
    -- Combat
    CamLock           = false,
    FastAttack        = false,
    InfiniteEnergy    = false,
    UnbreakableSkills = false,
    AntiStun          = false,
    -- Movement
    WalkOnWater  = false,
    SpeedEnabled = false,  SpeedValue = 16,
    DashEnabled  = false,  DashValue  = 300,
    FlyEnabled   = false,  FlySpeed   = 80,
    Noclip       = false,
    InfiniteJump = false,
    -- Race
    AutoRaceV3 = false,
    AutoRaceV4 = false,
    -- Silent Aim
    SilentPlayer  = false,
    SilentNPC     = false,
    AimMode       = "360",     -- "360" | "FOV"
    AimPriority   = "Nearest", -- "Nearest" | "LowestHP"
    FOVRadius     = 150,
    ShowFOV       = false,
    -- ESP
    ESPEnabled    = false,
    ESPRange      = 1000,
    ESPBox        = true,
    ESPHealthBar  = true,
    ESPName       = true,
    ESPDistance   = true,
    ESPChams      = false,
    -- Tracers
    PlayerTracers = false,
    NPCTracers    = false,
    -- UI
    AccentHex = "00AAFF",
}

-- ================================================================
-- GUARDAR / CARGAR CONFIG
-- ================================================================
local CFG_FILE = "CentuDox-V4.json"

local function SaveConfig()
    pcall(function()
        if not writefile then return end
        local data = {}
        for k, v in pairs(Config) do
            local t = type(v)
            if t == "boolean" or t == "number" or t == "string" then
                data[k] = v
            end
        end
        writefile(CFG_FILE, HttpService:JSONEncode(data))
    end)
end

local function LoadConfig()
    pcall(function()
        if not (isfile and readfile and isfile(CFG_FILE)) then return end
        local ok, data = pcall(HttpService.JSONDecode, HttpService, readfile(CFG_FILE))
        if not ok or type(data) ~= "table" then return end
        for k, v in pairs(data) do
            if Config[k] ~= nil and type(Config[k]) == type(v) then
                Config[k] = v
            end
        end
    end)
end
LoadConfig()

-- ================================================================
-- UTILIDADES
-- ================================================================
local function getChar()  return lp.Character end
local function getHRP()   local c = getChar(); return c and c:FindFirstChild("HumanoidRootPart") end
local function getHuman() local c = getChar(); return c and c:FindFirstChildOfClass("Humanoid") end

local function hexToColor(hex)
    hex = hex:gsub("#", "")
    return Color3.fromRGB(
        tonumber(hex:sub(1,2), 16) or 0,
        tonumber(hex:sub(3,4), 16) or 0,
        tonumber(hex:sub(5,6), 16) or 0
    )
end

local function getAccent() return hexToColor(Config.AccentHex) end

-- Proyecta la bounding box 3D de un modelo a coordenadas 2D de pantalla
local function getBoundingBox2D(model)
    local ok, cf, size = pcall(function() return model:GetBoundingBox() end)
    if not ok then return nil end
    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge
    local hit = false
    for _, sx in ipairs({-1, 1}) do
        for _, sy in ipairs({-1, 1}) do
            for _, sz in ipairs({-1, 1}) do
                local v, onScreen = Camera:WorldToViewportPoint(
                    (cf * CFrame.new(sx*size.X/2, sy*size.Y/2, sz*size.Z/2)).Position
                )
                if onScreen then
                    hit = true
                    if v.X < minX then minX = v.X end
                    if v.Y < minY then minY = v.Y end
                    if v.X > maxX then maxX = v.X end
                    if v.Y > maxY then maxY = v.Y end
                end
            end
        end
    end
    return hit and minX, minY, maxX, maxY
end

-- ================================================================
-- TARGETS
-- ================================================================
local function getPlayerTargets()
    local list = {}
    local myHRP = getHRP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp then
            local c = p.Character
            if c then
                local hrp = c:FindFirstChild("HumanoidRootPart")
                local hum = c:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    list[#list+1] = {
                        model  = c,
                        hrp    = hrp,
                        hum    = hum,
                        player = p,
                        dist   = myHRP and (hrp.Position - myHRP.Position).Magnitude or 0,
                    }
                end
            end
        end
    end
    return list
end

local function getNPCTargets(maxDist)
    local list   = {}
    local myHRP  = getHRP()
    if not myHRP then return list end
    maxDist = maxDist or 500
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Humanoid") and obj.Health > 0 then
            local model = obj.Parent
            if model and model ~= getChar() and not Players:GetPlayerFromCharacter(model) then
                local hrp  = model:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local d = (hrp.Position - myHRP.Position).Magnitude
                    if d <= maxDist then
                        list[#list+1] = { model = model, hrp = hrp, hum = obj, dist = d }
                    end
                end
            end
        end
    end
    return list
end

-- Selecciona el mejor target para Silent Aim / CamLock
local function getBestTarget(list)
    if #list == 0 then return nil end
    local center  = Camera.ViewportSize / 2
    local best, bestVal = nil, math.huge
    for _, t in ipairs(list) do
        local v, onScreen = Camera:WorldToViewportPoint(t.hrp.Position)
        if onScreen then
            local val
            if Config.AimMode == "FOV" then
                local d2D = (Vector2.new(v.X, v.Y) - center).Magnitude
                if d2D > Config.FOVRadius then continue end
                val = Config.AimPriority == "LowestHP" and t.hum.Health or d2D
            else
                val = Config.AimPriority == "LowestHP" and t.hum.Health or t.dist
            end
            if val < bestVal then bestVal = val; best = t end
        end
    end
    return best
end

-- ================================================================
-- DRAWING: FOV circle + ESP (Box, HealthBar, Chams, Tracers)
-- ================================================================
local fovCircle = Drawing.new("Circle")
fovCircle.Visible      = false
fovCircle.Thickness    = 1.5
fovCircle.NumSides     = 64
fovCircle.Filled       = false
fovCircle.Color        = Color3.new(1,1,1)
fovCircle.Transparency = 0.25

-- Tabla de objetos Drawing por modelo
local espPool    = {}   -- [model] = entry
local tracerPool = {}   -- [model] = Drawing.Line

local function makeESPEntry(model)
    local e = { box = {} }
    for i = 1, 4 do
        local l = Drawing.new("Line")
        l.Thickness = 1.5
        l.Color     = Color3.fromRGB(255, 80, 80)
        l.Visible   = false
        e.box[i]    = l
    end
    e.hpBg  = Drawing.new("Line"); e.hpBg.Thickness  = 3; e.hpBg.Color  = Color3.fromRGB(50,50,50);   e.hpBg.Visible  = false
    e.hpBar = Drawing.new("Line"); e.hpBar.Thickness = 3; e.hpBar.Color = Color3.fromRGB(0,220,80);    e.hpBar.Visible = false
    e.label = Drawing.new("Text"); e.label.Size = 13; e.label.Center = true; e.label.Outline = true
    e.label.Color = Color3.new(1,1,1); e.label.Visible = false

    -- Chams via Highlight
    e.highlight                     = Instance.new("Highlight")
    e.highlight.Adornee             = model
    e.highlight.FillColor           = Color3.fromRGB(255, 0, 0)
    e.highlight.FillTransparency    = 0.55
    e.highlight.OutlineColor        = Color3.fromRGB(255, 80, 80)
    e.highlight.OutlineTransparency = 0
    e.highlight.Enabled             = false
    e.highlight.Parent              = CoreGui
    return e
end

local function cleanESP(e)
    if not e then return end
    for _, l in ipairs(e.box) do pcall(l.Remove, l) end
    pcall(e.hpBg.Remove,  e.hpBg)
    pcall(e.hpBar.Remove, e.hpBar)
    pcall(e.label.Remove, e.label)
    pcall(e.highlight.Destroy, e.highlight)
end

local function setESPVisible(e, v)
    for _, l in ipairs(e.box) do l.Visible = v and Config.ESPBox        end
    e.hpBg.Visible   = v and Config.ESPHealthBar
    e.hpBar.Visible  = v and Config.ESPHealthBar
    e.label.Visible  = v and Config.ESPName
    e.highlight.Enabled = v and Config.ESPChams
end

local function drawBox(e, x0, y0, x1, y1)
    e.box[1].From = Vector2.new(x0,y0); e.box[1].To = Vector2.new(x1,y0)  -- top
    e.box[2].From = Vector2.new(x0,y1); e.box[2].To = Vector2.new(x1,y1)  -- bottom
    e.box[3].From = Vector2.new(x0,y0); e.box[3].To = Vector2.new(x0,y1)  -- left
    e.box[4].From = Vector2.new(x1,y0); e.box[4].To = Vector2.new(x1,y1)  -- right
end

local function drawHealthBar(e, x0, y0, y1, pct)
    local x = x0 - 5
    e.hpBg.From  = Vector2.new(x, y0);            e.hpBg.To  = Vector2.new(x, y1)
    local yFill  = y0 + (y1 - y0) * (1 - pct)
    e.hpBar.From = Vector2.new(x, yFill);         e.hpBar.To = Vector2.new(x, y1)
    e.hpBar.Color = Color3.fromRGB(
        math.floor(255 * (1 - pct)),
        math.floor(255 * pct), 0
    )
end

-- ================================================================
-- SISTEMAS: FLY
-- ================================================================
local flyConn

local function startFly()
    local hrp = getHRP()
    if not hrp then return end
    local bv      = Instance.new("BodyVelocity")
    bv.MaxForce   = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity   = Vector3.zero
    bv.Parent     = hrp

    flyConn = RunService.Heartbeat:Connect(function()
        if not Config.FlyEnabled then
            pcall(bv.Destroy, bv)
            flyConn:Disconnect(); flyConn = nil; return
        end
        local curHRP = getHRP()
        if not curHRP or curHRP ~= hrp then
            pcall(bv.Destroy, bv)
            flyConn:Disconnect(); flyConn = nil; return
        end
        local vel, spd = Vector3.zero, Config.FlySpeed
        if UIS:IsKeyDown(Enum.KeyCode.W) then vel += Camera.CFrame.LookVector  * spd end
        if UIS:IsKeyDown(Enum.KeyCode.S) then vel -= Camera.CFrame.LookVector  * spd end
        if UIS:IsKeyDown(Enum.KeyCode.A) then vel -= Camera.CFrame.RightVector * spd end
        if UIS:IsKeyDown(Enum.KeyCode.D) then vel += Camera.CFrame.RightVector * spd end
        if UIS:IsKeyDown(Enum.KeyCode.Space)       then vel += Vector3.new(0, spd, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then vel -= Vector3.new(0, spd, 0) end
        bv.Velocity = vel
    end)
end

local function stopFly()
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    local hrp = getHRP()
    if hrp then
        local bv = hrp:FindFirstChildOfClass("BodyVelocity")
        if bv then bv:Destroy() end
    end
end

-- ================================================================
-- SISTEMAS: NOCLIP
-- ================================================================
local noclipConn
local function startNoclip()
    noclipConn = RunService.Stepped:Connect(function()
        if not Config.Noclip then
            noclipConn:Disconnect(); noclipConn = nil; return
        end
        local c = getChar()
        if c then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end)
end

-- ================================================================
-- SISTEMAS: INFINITE JUMP
-- ================================================================
local infJumpConn
local function startInfiniteJump()
    infJumpConn = UIS.JumpRequest:Connect(function()
        if not Config.InfiniteJump then
            infJumpConn:Disconnect(); infJumpConn = nil; return
        end
        local h = getHuman()
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
end

-- ================================================================
-- SISTEMAS: ANTI STUN
-- ================================================================
local antiStunConn
local function startAntiStun()
    antiStunConn = RunService.Heartbeat:Connect(function()
        if not Config.AntiStun then
            antiStunConn:Disconnect(); antiStunConn = nil; return
        end
        local h, hrp = getHuman(), getHRP()
        if h and hrp and h.MoveDirection.Magnitude > 0 then
            local s = h:GetState()
            if s == Enum.HumanoidStateType.Seated or
               s == Enum.HumanoidStateType.StrafingNoPhysics then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -1.7)
            end
        end
    end)
end

-- ================================================================
-- SISTEMAS: CAM LOCK
-- ================================================================
local camConn
local function startCamLock()
    camConn = RunService.RenderStepped:Connect(function()
        if not Config.CamLock then
            camConn:Disconnect(); camConn = nil; return
        end
        local all = getPlayerTargets()
        if #all == 0 then return end
        table.sort(all, function(a,b) return a.dist < b.dist end)
        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, all[1].hrp.Position)
    end)
end

-- ================================================================
-- SISTEMAS: SORU NEAREST
-- ================================================================
local function soruNearest()
    local all = getPlayerTargets()
    if #all == 0 then return end
    table.sort(all, function(a,b) return a.dist < b.dist end)
    local hrp = getHRP()
    if hrp then
        hrp.CFrame = all[1].hrp.CFrame * CFrame.new(0, 0, 3.5)
    end
end

-- ================================================================
-- SISTEMAS: WALK ON WATER
-- ================================================================
local waterPlane
local function setWalkOnWater(enabled)
    if not waterPlane then
        waterPlane = Workspace:FindFirstChild("Water Base-Plane", true)
    end
    if waterPlane then
        waterPlane.Size = enabled
            and Vector3.new(99999, 1, 99999)
            or  Vector3.new(99999, 0.05, 99999)
    end
end

-- ================================================================
-- SISTEMAS: AUTO RACE V3 / V4
-- ================================================================
local raceConn = RunService.Heartbeat:Connect(function()
    if Config.AutoRaceV3 then
        pcall(function() CommE:FireServer("ActivateAbility") end)
    end
    if Config.AutoRaceV4 then
        pcall(function()
            local fill = lp.PlayerGui
                :FindFirstChild("Main")
                and lp.PlayerGui.Main:FindFirstChild("RaceEnergy")
                and lp.PlayerGui.Main.RaceEnergy:FindFirstChild("Fill")
            if fill and fill.AbsoluteSize.X >= fill.Parent.AbsoluteSize.X * 0.9 then
                Awakening:InvokeServer(true)
            end
        end)
    end
end)

-- ================================================================
-- SILENT AIM (hookmetamethod si está disponible)
-- ================================================================
if hookmetamethod then
    local oldNC
    oldNC = hookmetamethod(game, "__namecall", function(self, ...)
        if not checkcaller() then return oldNC(self, ...) end
        local method = getnamecallmethod()
        if method == "FireServer" and self == registerHit then
            if Config.SilentPlayer or Config.SilentNPC then
                local all = {}
                if Config.SilentPlayer then
                    for _, t in ipairs(getPlayerTargets()) do all[#all+1] = t end
                end
                if Config.SilentNPC then
                    for _, t in ipairs(getNPCTargets(500)) do all[#all+1] = t end
                end
                local best = getBestTarget(all)
                if best then
                    local args = {...}
                    args[1] = best.hrp
                    return oldNC(self, table.unpack(args))
                end
            end
        end
        return oldNC(self, ...)
    end)
end

-- ================================================================
-- LOOP PRINCIPAL (RenderStepped)
-- ================================================================
RunService.RenderStepped:Connect(function()
    local hum  = getHuman()
    local hrp  = getHRP()
    local c    = getChar()

    -- Infinite Energy
    if Config.InfiniteEnergy and hum then
        pcall(function() hum:SetAttribute("Energy", math.huge) end)
    end

    -- Unbreakable Skills
    if Config.UnbreakableSkills and hrp then
        pcall(function() hrp:SetAttribute("UnbreakableAll", true) end)
    end

    -- Fast Attack
    if Config.FastAttack then
        pcall(function() if registerAttack then registerAttack:FireServer() end end)
    end

    -- Speed
    if Config.SpeedEnabled and hum then
        hum.WalkSpeed = Config.SpeedValue
    end

    -- Dash
    if Config.DashEnabled and c then
        pcall(function() c:SetAttribute("DashLength", Config.DashValue) end)
    end

    -- FOV Circle
    fovCircle.Visible = Config.ShowFOV
    if Config.ShowFOV then
        fovCircle.Radius   = Config.FOVRadius
        fovCircle.Color    = getAccent()
        fovCircle.Position = Camera.ViewportSize / 2
    end

    -- ── ESP ──────────────────────────────────────────────────
    if Config.ESPEnabled then
        for _, t in ipairs(getPlayerTargets()) do
            local model = t.model
            if not espPool[model] then espPool[model] = makeESPEntry(model) end
            local e = espPool[model]

            if t.dist > Config.ESPRange then
                setESPVisible(e, false)
            else
                local x0,y0,x1,y1 = getBoundingBox2D(model)
                if x0 then
                    setESPVisible(e, true)
                    if Config.ESPBox        then drawBox(e, x0, y0, x1, y1) end
                    if Config.ESPHealthBar  then
                        local pct = math.clamp(t.hum.Health / math.max(t.hum.MaxHealth, 1), 0, 1)
                        drawHealthBar(e, x0, y0, y1, pct)
                    end
                    if Config.ESPName then
                        local lbl = t.player.Name
                        if Config.ESPDistance then lbl = lbl.." ["..math.floor(t.dist).."m]" end
                        e.label.Text     = lbl
                        e.label.Position = Vector2.new((x0+x1)/2, y0 - 16)
                        e.label.Visible  = true
                    end
                    e.highlight.Enabled = Config.ESPChams
                else
                    setESPVisible(e, false)
                end
            end
        end
    else
        for _, e in pairs(espPool) do setESPVisible(e, false) end
    end

    -- ── Tracers ───────────────────────────────────────────────
    local center = Camera.ViewportSize
    local origin = Vector2.new(center.X/2, center.Y)

    local function updateTracer(model, hrpTarget, enabled)
        if not tracerPool[model] then
            local l = Drawing.new("Line")
            l.Thickness    = 1
            l.Transparency = 0.2
            l.Color        = getAccent()
            l.Visible      = false
            tracerPool[model] = l
        end
        local l = tracerPool[model]
        if enabled then
            local v, onScreen = Camera:WorldToViewportPoint(hrpTarget.Position)
            l.Visible = onScreen
            if onScreen then
                l.From = origin
                l.To   = Vector2.new(v.X, v.Y)
                l.Color = getAccent()
            end
        else
            l.Visible = false
        end
    end

    if Config.PlayerTracers then
        for _, t in ipairs(getPlayerTargets()) do
            updateTracer(t.model, t.hrp, true)
        end
    else
        for model, l in pairs(tracerPool) do
            if Players:GetPlayerFromCharacter(model) then l.Visible = false end
        end
    end

    if Config.NPCTracers then
        for _, t in ipairs(getNPCTargets(1000)) do
            updateTracer(t.model, t.hrp, true)
        end
    end
end)

-- Limpiar ESP al salir jugadores
Players.PlayerRemoving:Connect(function(p)
    task.delay(1, function()
        local c = p.Character
        if c and espPool[c] then
            cleanESP(espPool[c])
            espPool[c] = nil
        end
    end)
end)

-- ================================================================
-- UI ─ Panel arrastrable con temas de color
-- ================================================================
if CoreGui:FindFirstChild("CentuDoxV4") then
    CoreGui:FindFirstChild("CentuDoxV4"):Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name           = "CentuDoxV4"
Gui.ResetOnSpawn   = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent         = CoreGui

-- Paletas de color disponibles
local PALETTES = {
    Blue   = "00AAFF",
    Green  = "00D46A",
    Purple = "A855F7",
    Red    = "EF4444",
    Orange = "F97316",
}

-- Colores base del panel
local COL = {
    bg      = Color3.fromRGB( 4,  8, 18),
    panel   = Color3.fromRGB( 8, 14, 28),
    section = Color3.fromRGB(12, 20, 38),
    text    = Color3.fromRGB(220,230,255),
    muted   = Color3.fromRGB( 80,100,140),
    on      = Color3.fromRGB(  0,220,100),
    off     = Color3.fromRGB(220, 60, 60),
}

-- Panel principal
local Main = Instance.new("Frame")
Main.Name              = "Main"
Main.Size              = UDim2.new(0, 245, 0, 430)
Main.Position          = UDim2.new(0, 18, 0, 18)
Main.BackgroundColor3  = COL.bg
Main.BorderSizePixel   = 0
Main.ClipsDescendants  = true
Main.Parent            = Gui

local mainCorner  = Instance.new("UICorner", Main); mainCorner.CornerRadius = UDim.new(0, 8)
local mainStroke  = Instance.new("UIStroke", Main)
mainStroke.Color  = getAccent(); mainStroke.Thickness = 1.5

-- Title bar (drag handle)
local TBar = Instance.new("Frame")
TBar.Name             = "TBar"
TBar.Size             = UDim2.new(1, 0, 0, 34)
TBar.BackgroundColor3 = COL.panel
TBar.BorderSizePixel  = 0
TBar.Parent           = Main
Instance.new("UICorner", TBar).CornerRadius = UDim.new(0, 8)

local TLabel = Instance.new("TextLabel")
TLabel.Size                = UDim2.new(1, -40, 1, 0)
TLabel.Position            = UDim2.new(0, 10, 0, 0)
TLabel.BackgroundTransparency = 1
TLabel.Text                = "👑  CentuDox V4"
TLabel.TextColor3          = COL.text
TLabel.Font                = Enum.Font.GothamBold
TLabel.TextSize            = 13
TLabel.TextXAlignment      = Enum.TextXAlignment.Left
TLabel.Parent              = TBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size             = UDim2.new(0, 24, 0, 24)
MinBtn.Position         = UDim2.new(1, -28, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
MinBtn.BorderSizePixel  = 0
MinBtn.Text             = "−"
MinBtn.TextColor3       = COL.text
MinBtn.Font             = Enum.Font.GothamBold
MinBtn.TextSize         = 16
MinBtn.Parent           = TBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 4)

-- ── Drag ──────────────────────────────────────────────────────
do
    local dragging, ds, sp = false, nil, nil
    local function inputStart(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; ds = inp.Position; sp = Main.Position
        end
    end
    local function inputEnd(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end
    TBar.InputBegan:Connect(inputStart)
    TBar.InputEnded:Connect(inputEnd)
    UIS.InputChanged:Connect(function(inp)
        if dragging and (
            inp.UserInputType == Enum.UserInputType.MouseMovement or
            inp.UserInputType == Enum.UserInputType.Touch
        ) then
            local d = inp.Position - ds
            Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X,
                                      sp.Y.Scale, sp.Y.Offset + d.Y)
        end
    end)
end

-- ── Minimize ──────────────────────────────────────────────────
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(Main, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 245, 0, minimized and 34 or 430)
    }):Play()
    MinBtn.Text = minimized and "+" or "−"
end)

-- ── Scroll container ──────────────────────────────────────────
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size                  = UDim2.new(1, 0, 1, -34)
Scroll.Position              = UDim2.new(0, 0, 0, 34)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel       = 0
Scroll.ScrollBarThickness    = 3
Scroll.ScrollBarImageColor3  = getAccent()
Scroll.CanvasSize            = UDim2.new(0, 0, 0, 0)
Scroll.AutomaticCanvasSize   = Enum.AutomaticSize.Y
Scroll.Parent                = Main

local List = Instance.new("UIListLayout", Scroll)
List.Padding   = UDim.new(0, 4)
List.SortOrder = Enum.SortOrder.LayoutOrder

local pad = Instance.new("UIPadding", Scroll)
pad.PaddingTop    = UDim.new(0, 6)
pad.PaddingBottom = UDim.new(0, 8)
pad.PaddingLeft   = UDim.new(0, 6)
pad.PaddingRight  = UDim.new(0, 6)

-- Referencia a todos los UIStroke para actualizarlos al cambiar color
local allStrokes = { mainStroke }

-- ── Helpers de UI ─────────────────────────────────────────────
local lo = 0
local function nextLO() lo = lo + 1; return lo end

local function makeSection(title)
    local f = Instance.new("Frame")
    f.Size               = UDim2.new(1, 0, 0, 22)
    f.BackgroundColor3   = COL.section
    f.BorderSizePixel    = 0
    f.LayoutOrder        = nextLO()
    f.Parent             = Scroll
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local s = Instance.new("UIStroke", f); s.Thickness = 0.8; s.Transparency = 0.4
    s.Color = getAccent(); allStrokes[#allStrokes+1] = s

    local lbl = Instance.new("TextLabel", f)
    lbl.Size                  = UDim2.new(1, 0, 1, 0)
    lbl.Position              = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text                  = "▸  "..title:upper()
    lbl.TextColor3            = getAccent()
    lbl.Font                  = Enum.Font.GothamBold
    lbl.TextSize              = 11
    lbl.TextXAlignment        = Enum.TextXAlignment.Left
    return lbl  -- devuelve el label para poder cambiar color al actualizar acento
end

local sectionLabels = {}

local function makeToggle(label, cfgKey, cb)
    local row = Instance.new("Frame", Scroll)
    row.Size              = UDim2.new(1, 0, 0, 28)
    row.BackgroundColor3  = COL.panel
    row.BorderSizePixel   = 0
    row.LayoutOrder       = nextLO()
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size                  = UDim2.new(1, -58, 1, 0)
    lbl.Position              = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text                  = label
    lbl.TextColor3            = COL.text
    lbl.Font                  = Enum.Font.Gotham
    lbl.TextSize              = 12
    lbl.TextXAlignment        = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", row)
    btn.Size             = UDim2.new(0, 48, 0, 20)
    btn.Position         = UDim2.new(1, -52, 0.5, -10)
    btn.BorderSizePixel  = 0
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    local function refresh()
        local v = Config[cfgKey]
        btn.Text             = v and "ON" or "OFF"
        btn.TextColor3       = v and COL.on or COL.off
        btn.BackgroundColor3 = v and Color3.fromRGB(0,50,20) or Color3.fromRGB(55,10,10)
    end
    refresh()

    btn.MouseButton1Click:Connect(function()
        Config[cfgKey] = not Config[cfgKey]
        refresh(); SaveConfig()
        if cb then cb(Config[cfgKey]) end
    end)
end

local function makeSlider(label, cfgKey, minV, maxV)
    local row = Instance.new("Frame", Scroll)
    row.Size             = UDim2.new(1, 0, 0, 46)
    row.BackgroundColor3 = COL.panel
    row.BorderSizePixel  = 0
    row.LayoutOrder      = nextLO()
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size                  = UDim2.new(0.65, 0, 0, 20)
    lbl.Position              = UDim2.new(0, 8, 0, 3)
    lbl.BackgroundTransparency = 1
    lbl.Text                  = label
    lbl.TextColor3            = COL.text
    lbl.Font                  = Enum.Font.Gotham
    lbl.TextSize              = 11
    lbl.TextXAlignment        = Enum.TextXAlignment.Left

    local vBox = Instance.new("TextBox", row)
    vBox.Size              = UDim2.new(0, 46, 0, 18)
    vBox.Position          = UDim2.new(1, -50, 0, 3)
    vBox.BackgroundColor3  = COL.section
    vBox.BorderSizePixel   = 0
    vBox.Text              = tostring(Config[cfgKey])
    vBox.TextColor3        = COL.text
    vBox.Font              = Enum.Font.Gotham
    vBox.TextSize          = 11
    vBox.TextXAlignment    = Enum.TextXAlignment.Center
    Instance.new("UICorner", vBox).CornerRadius = UDim.new(0, 3)

    local track = Instance.new("Frame", row)
    track.Size             = UDim2.new(1, -16, 0, 6)
    track.Position         = UDim2.new(0, 8, 0, 30)
    track.BackgroundColor3 = COL.section
    track.BorderSizePixel  = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", track)
    fill.BackgroundColor3 = getAccent()
    fill.BorderSizePixel  = 0
    fill.Size             = UDim2.new(
        math.clamp((Config[cfgKey]-minV)/(maxV-minV), 0, 1), 0, 1, 0
    )
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local function setVal(v)
        v = math.clamp(math.round(v), minV, maxV)
        Config[cfgKey] = v
        vBox.Text  = tostring(v)
        fill.Size  = UDim2.new(math.clamp((v-minV)/(maxV-minV),0,1),0,1,0)
        fill.BackgroundColor3 = getAccent()
        SaveConfig()
    end

    local dragging = false
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            setVal(minV + (maxV-minV)*math.clamp(
                (i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1
            ))
        end
    end)
    track.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            setVal(minV + (maxV-minV)*math.clamp(
                (i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1
            ))
        end
    end)
    vBox.FocusLost:Connect(function()
        local n = tonumber(vBox.Text)
        if n then setVal(n) end
    end)
end

local function makeButton(label, cb)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size             = UDim2.new(1, 0, 0, 28)
    btn.BackgroundColor3 = COL.panel
    btn.BorderSizePixel  = 0
    btn.Text             = label
    btn.TextColor3       = COL.text
    btn.Font             = Enum.Font.Gotham
    btn.TextSize         = 12
    btn.LayoutOrder      = nextLO()
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    local s = Instance.new("UIStroke", btn); s.Thickness = 0.8; s.Transparency = 0.55
    s.Color = getAccent(); allStrokes[#allStrokes+1] = s
    btn.MouseButton1Click:Connect(cb)
end

-- Fila de paletas de color
local function makeColorPicker()
    local row = Instance.new("Frame", Scroll)
    row.Size             = UDim2.new(1, 0, 0, 30)
    row.BackgroundColor3 = COL.panel
    row.BorderSizePixel  = 0
    row.LayoutOrder      = nextLO()
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size                  = UDim2.new(0, 55, 1, 0)
    lbl.Position              = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text                  = "Acento"
    lbl.TextColor3            = COL.muted
    lbl.Font                  = Enum.Font.Gotham
    lbl.TextSize              = 11
    lbl.TextXAlignment        = Enum.TextXAlignment.Left

    local x = 66
    for name, hex in pairs(PALETTES) do
        local dot = Instance.new("TextButton", row)
        dot.Size             = UDim2.new(0, 18, 0, 18)
        dot.Position         = UDim2.new(0, x, 0.5, -9)
        dot.BackgroundColor3 = hexToColor(hex)
        dot.BorderSizePixel  = 0
        dot.Text             = ""
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
        x = x + 26
        dot.MouseButton1Click:Connect(function()
            Config.AccentHex = hex
            local ac = getAccent()
            -- Actualiza todos los strokes y colores de acento
            for _, s in ipairs(allStrokes) do s.Color = ac end
            mainStroke.Color = ac
            Scroll.ScrollBarImageColor3 = ac
            SaveConfig()
        end)
    end
end

-- ================================================================
-- CONSTRUIR LA UI
-- ================================================================

sectionLabels[#sectionLabels+1] = makeSection("Combat")
makeToggle("CamLock",             "CamLock",           function(v) if v then startCamLock() end end)
makeToggle("Fast Attack",         "FastAttack",         nil)
makeToggle("Infinite Energy",     "InfiniteEnergy",     nil)
makeToggle("Unbreakable Skills",  "UnbreakableSkills",  nil)
makeToggle("Anti Stun",           "AntiStun",           function(v) if v then startAntiStun() end end)
makeButton("⚡  Soru Nearest",   soruNearest)

sectionLabels[#sectionLabels+1] = makeSection("Movement")
makeToggle("Fly",           "FlyEnabled",   function(v) if v then startFly() else stopFly() end end)
makeSlider("Fly Speed",     "FlySpeed",      20, 300)
makeToggle("Noclip",        "Noclip",        function(v) if v then startNoclip()        end end)
makeToggle("Infinite Jump", "InfiniteJump",  function(v) if v then startInfiniteJump()  end end)
makeToggle("Speed",         "SpeedEnabled",  nil)
makeSlider("Speed Value",   "SpeedValue",    4, 250)
makeToggle("Dash",          "DashEnabled",   nil)
makeSlider("Dash Value",    "DashValue",     50, 1000)
makeToggle("Walk on Water", "WalkOnWater",   function(v) setWalkOnWater(v) end)

sectionLabels[#sectionLabels+1] = makeSection("Auto Race")
makeToggle("Auto Race V3", "AutoRaceV3", nil)
makeToggle("Auto Race V4", "AutoRaceV4", nil)

sectionLabels[#sectionLabels+1] = makeSection("Silent Aim")
makeToggle("Silent → Players", "SilentPlayer", nil)
makeToggle("Silent → NPC",     "SilentNPC",    nil)
makeToggle("Show FOV Circle",  "ShowFOV",      nil)
makeSlider("FOV Radius",       "FOVRadius",    50, 400)

sectionLabels[#sectionLabels+1] = makeSection("ESP")
makeToggle("ESP",          "ESPEnabled",   nil)
makeToggle("Box ESP",      "ESPBox",       nil)
makeToggle("Health Bar",   "ESPHealthBar", nil)
makeToggle("Name + Dist",  "ESPName",      nil)
makeToggle("Chams",        "ESPChams",     nil)
makeSlider("ESP Range",    "ESPRange",     100, 2000)

sectionLabels[#sectionLabels+1] = makeSection("Tracers")
makeToggle("Player Tracers", "PlayerTracers", nil)
makeToggle("NPC Tracers",    "NPCTracers",    nil)

sectionLabels[#sectionLabels+1] = makeSection("Settings")
makeColorPicker()

-- ================================================================
-- RESTAURAR ESTADOS AL CARGAR
-- ================================================================
if Config.FlyEnabled   then startFly()          end
if Config.Noclip       then startNoclip()        end
if Config.InfiniteJump then startInfiniteJump()  end
if Config.AntiStun     then startAntiStun()      end
if Config.CamLock      then startCamLock()       end
if Config.WalkOnWater  then setWalkOnWater(true) end

print("[CentuDox V4] Cargado correctamente ✓")
