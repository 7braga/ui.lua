-- ==================================================================
-- FONDO DE IMAGEN: pega aquí el ID de TU imagen (debe ser un asset de tipo
-- IMAGEN subido a Roblox, no un Decal). Solo los números, ej: "80687556099311"
-- ==================================================================
BRAGAO_BG_ID = "139086303945721"

-- bragao Hub | WindUI
repeat task.wait() until game:IsLoaded()

local ok, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)
if not ok or not WindUI then
    warn("WindUI failed:", WindUI)
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local UserInputService = UIS
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RS = ReplicatedStorage
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local MaterialService = game:GetService("MaterialService")
local SoundService = game:GetService("SoundService")

local lp = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local CommE = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("CommE")
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")

local registerAttack = Net:FindFirstChild("RE/RegisterAttack")
local registerHit
pcall(function()
    registerHit = require(ReplicatedStorage.Modules.Net):RemoteEvent("RegisterHit", true)
end)
if not registerHit then
    registerHit = Net:FindFirstChild("RE/RegisterHit")
end
local ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")
local Validator2 = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Validator2")

local Config = {
    FastAttack = false, FAPlayers = true, FAMobs = true, FARange = 1000,
    BringMobs = false, BringRange = 3000,
    FruitM1 = false, VoidFruitM1 = false,
    FruitM1Players = true, FruitM1Mobs = true, VoidAllM1 = false,

    SafeGun = false, SafeMobs = true, SafePlayers = true, SafeSea = true, SafeRange = 500,
    SuperGun = false, SuperMobs = true, SuperPlayers = true, SuperSea = true, SuperRange = 500,
    Disappear = false,

    AutoV3 = false, AutoV4 = false, AutoPvP = false,
    InfiniteZoom = false, AntiAFK = true,
    Notifications = true,
    Fly = false, FlySpeed = 250, FlyVertical = 180, FlySmooth = true,
    WalkOnWater = false, AntiLava = false,
    SpeedEnabled = false, SpeedMode = "CFrame", SpeedValue = 50,

    Tracker = false,
    TrackerFly = false, TrackerFlySpeed = 275, TrackerOrbitRadius = 50,
    TrackerNoTpRange = 300, TrackerPositionMode = "orbit",
    AutoFlee = false, AutoFleeHP = 30,
    TweenNearest = false, TweenToPlayer = false, TweenSpeed = 350,
    TweenOX = 0, TweenOY = 1.5, TweenOZ = 3.5,
    InstaTP = false, Spectate = false, SelectedTrackPlayer = "Nearest",
    PredictionStrength = 0.1,

    M1Extender = false, M1Range = 50,
    GunClickSL = false,
    SilentPlayer = false, SilentNPC = false,
    AimMode = "360", AimPriority = "Nearest",
    ShowFOV = false, FOVMode = "V1", FOVRadius = 150, AimMaxRange = 2000,
    Tracer = false, TracerColor = "Red",
    ESP = false, ESPRange = 1000,
    Tracers = false, TracerTracerColor = "White",
    ESPName = true, ESPHealth = true, ESPHealthBar = true, ESPDistance = true, ESPBox = true,
    ESPTool = false, ESPChams = false, ESPTextSize = 13,
    SATracer = true, SATracerAll = true,
    SoruAutoAim = false, SoruAimMode = "360", SoruFOVType = "V1",
    SoruPriority = "Nearest", SoruFOVRadius = 150, SoruRange = 300, SoruShowFOV = false,
    ZBoostEnabled = false, ZBoostPower = 450, ZBoostDuration = 0.55,
    NoGfxMode = "Off",
    FlagJobId = "",
    FlagRegion = "Singapore",
    BypassTpNpc = false, BypassTpRange = 500, BypassTpMode = "Nearest", BypassTpAbove = true, BypassTpHeight = 12,
    LowGraphics = false, DisableShadows = false, NoFog = false,

    SkyEnabled = false, SkyType = "black storm",
    AmbientEnabled = false, AmbientType = "Rain",
    MinecraftTex = false,
    -- 4EVR: fondo + colores de la UI (se guardan)
    UI_Theme = 1, UI_Ver = 0, UI_CustomUrl = "", UI_BgOn = true, UI_BgVisible = 70, UI_CardAlpha = 30,
    UI_ColBg = "#161619", UI_ColText = "#ffffff", UI_ColMuted = "#a1a1aa", UI_ColAccent = "#ffffff",
    UI_ColCard = "#18181b", UI_ColButton = "#3f3f46", UI_ColIcon = "#d4d4d8", UI_ColBorder = "#ffffff",
    -- Blacklist persistence
    BL_Melee_Z = false, BL_Melee_X = false, BL_Melee_C = false, BL_Melee_V = false, BL_Melee_F = false,
    BL_Sword_Z = false, BL_Sword_X = false, BL_Sword_C = false, BL_Sword_V = false, BL_Sword_F = false,
    BL_Fruit_Z = false, BL_Fruit_X = false, BL_Fruit_C = false, BL_Fruit_V = false, BL_Fruit_F = false, BL_Fruit_TAP = false,
    BL_Gun_Z = false, BL_Gun_X = false, BL_Gun_C = false, BL_Gun_V = false, BL_Gun_F = false,
}


-- ==================== UI: definiciones de botones flotantes (estilo Onyx) ====================
-- "toggle" = Title exacto del toggle de la UI que enciende/apaga el botón.
local BragaoUI = {
    floatDefs = {
        { id = "Noclip",  toggle = "Noclip",             label = "NOCLIP",        icon = "ghost",     color = "#94A3B8", default = true  },
        { id = "Fly",     toggle = "Fly",                label = "FLY",           icon = "plane",     color = "#38BDF8", default = true  },
        { id = "Silent",  toggle = "Silent Aim Players", label = "SILENT\nAIM",   icon = "target",    color = "#2DD4BF", default = true  },
        { id = "ESP",     toggle = "ESP",                label = "ESP",           icon = "expand",    color = "#FACC15", default = true  },
        { id = "FastAtk", toggle = "Fast Attack",        label = "FAST\nATTACK",  icon = "sword",     color = "#EF4444", default = true  },
        { id = "InfJump", toggle = "Infinite Jump",      label = "INF\nJUMP",     icon = "climb",     color = "#A855F7", default = true  },
        { id = "Soru",    toggle = "Soru Auto Aim",      label = "SORU\nAIM",     icon = "crosshair", color = "#257AF7", default = false },
    },
    states = {},     -- [Title del toggle] = true/false (estado actual)
    elements = {},   -- [Title] = { elementos WindUI }
    callbacks = {},  -- [Title] = { callbacks envueltos }
}
for _, d in ipairs(BragaoUI.floatDefs) do
    Config["BtnOn_" .. d.id] = d.default
    Config["BtnX_" .. d.id] = -1   -- -1 = posición por defecto
    Config["BtnY_" .. d.id] = -1
end
Config.BtnScale = UserInputService.TouchEnabled and 70 or 100
Config.BtnLocked = false
Config.UISounds = true

local CONFIG_FILE = "bragaoHub_Config.json"

local function Notify(title, content, duration)
    if not Config.Notifications then return end
    pcall(function()
        WindUI:Notify({ Title = title or "bragao Hub", Content = content or "", Duration = duration or 2 })
    end)
end

local function SaveConfig()
    if not writefile then
        return false
    end
    local ok = pcall(function()
        local data = {}
        for k, v in pairs(Config) do
            local t = type(v)
            if t == "boolean" or t == "number" or t == "string" then
                data[k] = v
            end
        end
        local encoded = HttpService:JSONEncode(data)
        writefile(CONFIG_FILE, encoded)
        pcall(function()
            if makefolder and not isfolder("BragaoHub") then makefolder("BragaoHub") end
            writefile("BragaoHub/Config.json", encoded)
        end)
    end)
    return ok == true
end

local function LoadConfig()
    pcall(function()
        if not (isfile and readfile) then return end
        local raw = nil
        if isfile(CONFIG_FILE) then
            raw = readfile(CONFIG_FILE)
        elseif isfile("BragaoHub/Config.json") then
            raw = readfile("BragaoHub/Config.json")
        end
        if not raw or raw == "" then return end
        local data = HttpService:JSONDecode(raw)
        if type(data) ~= "table" then return end
        for k, v in pairs(data) do
            if Config[k] ~= nil and type(Config[k]) == type(v) then
                Config[k] = v
            end
        end
    end)
end

LoadConfig()
if Config.UI_Ver ~= 4 then Config.UI_Ver = 4; Config.UI_Theme = 1 end
task.spawn(function()
    while true do
        task.wait(5)
        SaveConfig()
    end
end)
pcall(function() game:BindToClose(function() SaveConfig() end) end)
local function save()
    task.defer(SaveConfig)
end

local character = lp.Character or lp.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
lp.CharacterAdded:Connect(function(c)
    character = c
    humanoidRootPart = c:WaitForChild("HumanoidRootPart")
end)
local savedZoom = lp.CameraMaxZoomDistance

local function isAlive(model)
    if not model or not model.Parent then return false end
    local hum = model:FindFirstChildOfClass("Humanoid")
    local root = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
    return hum and hum.Health > 0 and root ~= nil
end

local function getFruit()
    local char, bp = lp.Character, lp:FindFirstChild("Backpack")
    for _, container in ipairs({ char, bp }) do
        if container then
            for _, t in ipairs(container:GetChildren()) do
                if t:IsA("Tool") and (t.ToolTip == "Blox Fruit" or t:GetAttribute("WeaponType") == "Demon Fruit" or t.Name:find("-")) then
                    return t
                end
            end
        end
    end
end

-- ==================== Z BOOST ====================
local boostGui = nil
local function destroyBoostGui()
    if boostGui then boostGui:Destroy() boostGui = nil end
end
local function doBoost()
    if not Config.ZBoostEnabled then return end
    local char = lp.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dir = Camera.CFrame.LookVector
    local att = Instance.new("Attachment")
    att.Parent = hrp
    local lv = Instance.new("LinearVelocity")
    lv.MaxForce = 99999999
    lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    lv.VectorVelocity = dir * Config.ZBoostPower
    lv.Attachment0 = att
    lv.Parent = hrp
    task.delay(Config.ZBoostDuration, function()
        if lv and lv.Parent then lv:Destroy() end
        if att and att.Parent then att:Destroy() end
    end)
end
local function createBoostGui()
    destroyBoostGui()
    local gui = Instance.new("ScreenGui")
    gui.Name = "BragaoZBoost"
    gui.ResetOnSpawn = false
    gui.Parent = lp:WaitForChild("PlayerGui")
    boostGui = gui
    local f = Instance.new("Frame", gui)
    f.Size = UDim2.new(0, 90, 0, 42)
    f.Position = UDim2.new(0.37, 0, 0.26, 0)
    f.BackgroundColor3 = Color3.fromRGB(75, 30, 135)
    f.Active = true
    f.Draggable = true
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
    local zBtn = Instance.new("TextButton", f)
    zBtn.Size = UDim2.new(0, 40, 0, 30)
    zBtn.Position = UDim2.new(0, 12, 0, 6)
    zBtn.BackgroundColor3 = Color3.fromRGB(210, 140, 255)
    zBtn.Text = "Z"
    zBtn.TextSize = 18
    zBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", zBtn).CornerRadius = UDim.new(0, 8)
    zBtn.MouseButton1Click:Connect(function()
        doBoost()
        zBtn.Text = "!"
        zBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 80)
        task.wait(0.35)
        zBtn.Text = "Z"
        zBtn.BackgroundColor3 = Color3.fromRGB(210, 140, 255)
    end)
end
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Z and Config.ZBoostEnabled then doBoost() end
end)

-- ==================== FAST ATTACK ====================
task.spawn(function()
    while true do
        task.wait(0.08)
        if not Config.FastAttack then continue end
        pcall(function()
            local char = lp.Character
            if not char then return end
            local myHRP = char:FindFirstChild("HumanoidRootPart")
            if not myHRP then return end
            local Mod = RS:FindFirstChild("Modules")
            local Net2 = Mod and Mod:FindFirstChild("Net")
            local RA2 = Net2 and Net2:FindFirstChild("RE/RegisterAttack")
            local RH2 = Net2 and Net2:FindFirstChild("RE/RegisterHit")
            if not RA2 or not RH2 then return end
            local myPos = myHRP.Position
            local all = {}
            if Config.FAPlayers then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= lp and p.Character then
                        local pH = p.Character:FindFirstChildOfClass("Humanoid")
                        local pR = p.Character:FindFirstChild("HumanoidRootPart")
                        local pHd = p.Character:FindFirstChild("Head")
                        if pH and pR and pHd and pH.Health > 0 and (pR.Position - myPos).Magnitude <= Config.FARange then
                            all[#all + 1] = { p.Character, pHd }
                        end
                    end
                end
            end
            if Config.FAMobs then
                local en = workspace:FindFirstChild("Enemies")
                if en then
                    for _, n in pairs(en:GetChildren()) do
                        local nH = n:FindFirstChildOfClass("Humanoid")
                        local nR = n:FindFirstChild("HumanoidRootPart")
                        local nHd = n:FindFirstChild("Head")
                        if nH and nR and nHd and nH.Health > 0 and (nR.Position - myPos).Magnitude <= Config.FARange then
                            all[#all + 1] = { n, nHd }
                        end
                    end
                end
            end
            if #all > 0 then
                RA2:FireServer(0)
                for _, t in pairs(all) do
                    pcall(function() RH2:FireServer(t[2], all) end)
                end
            end
        end)
    end
end)

-- ==================== FRUIT M1 ====================
local FruitM1 = { maxVec = Vector3.new(9e30, 9e30, 9e30), on = false, conn = nil, clickConn = nil, fbCombo = 1 }
function FruitM1.GetFruit() return getFruit() end
function FruitM1.IsTrex(tool) return tool and tool.Name == "T-Rex-T-Rex" end
function FruitM1.IsDragon(tool) return tool and tool.Name == "Dragon-Dragon" end
function FruitM1.IsBlade(tool) return tool and tool.Name == "Blade-Blade" end
function FruitM1.IsPain(tool) return tool and tool.Name == "Pain-Pain" end
function FruitM1.IsControl(tool) return tool and tool.Name == "Control-Control" end
function FruitM1.IsGas(tool) return tool and tool.Name == "Gas-Gas" end
function FruitM1.MaxCombo(tool)
    if FruitM1.IsTrex(tool) then return 4 end
    if FruitM1.IsBlade(tool) then return 2 end
    if FruitM1.IsPain(tool) then return 4 end
    if FruitM1.IsControl(tool) then return 4 end
    if FruitM1.IsGas(tool) then return 5 end
    if FruitM1.IsDragon(tool) then
        local char = lp.Character
        return (char and char:FindFirstChild("DragonHybrid")) and 5 or 3
    end
    return 5
end
function FruitM1.TapInterval(combo, maxCombo)
    if Config.VoidFruitM1 and combo and maxCombo and combo >= maxCombo then return 1 end
    local char = lp.Character
    local cd = char and (char:GetAttribute("FruitTAPCooldown") or 0) or 0
    return 0.2 - cd
end
function FruitM1.SetNormal(enabled)
    FruitM1.on = enabled
    if FruitM1.conn then pcall(task.cancel, FruitM1.conn) FruitM1.conn = nil end
    if FruitM1.clickConn then pcall(task.cancel, FruitM1.clickConn) FruitM1.clickConn = nil end
    if not enabled then return end

    -- Fast attack de fruits SIN equipar + prediction (LeftClickRemote)
    FruitM1.conn = task.spawn(function()
        local PingService = game:GetService("Stats")
        while FruitM1.on do
            local ok, err = pcall(function()
                local fruit = FruitM1.GetFruit() -- busca en Backpack y Character
                local char = lp.Character
                local myHRP = char and char:FindFirstChild("HumanoidRootPart")
                if not fruit or not myHRP then return end

                local remote = fruit:FindFirstChild("LeftClickRemote")
                if not remote then return end

                local stun = char:FindFirstChild("Stun")
                local busy = char:FindFirstChild("Busy")
                if (stun and stun.Value and stun.Value > 0) or (busy and busy.Value) then return end

                local range = 600
                local bestHRP, bestDist, bestVel

                -- Players
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= lp and player.Character then
                        local thrp = player.Character:FindFirstChild("HumanoidRootPart")
                        local hum = player.Character:FindFirstChildOfClass("Humanoid")
                        if thrp and hum and hum.Health > 0 then
                            local d = (thrp.Position - myHRP.Position).Magnitude
                            if d < range and (not bestDist or d < bestDist) then
                                bestHRP, bestDist = thrp, d
                                bestVel = thrp.AssemblyLinearVelocity
                            end
                        end
                    end
                end
                -- NPCs / Mobs
                local enemies = Workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, npc in ipairs(enemies:GetChildren()) do
                        if npc:IsA("Model") then
                            local thrp = npc:FindFirstChild("HumanoidRootPart")
                            local hum = npc:FindFirstChildOfClass("Humanoid")
                            if thrp and hum and hum.Health > 0 then
                                local d = (thrp.Position - myHRP.Position).Magnitude
                                if d < range and (not bestDist or d < bestDist) then
                                    bestHRP, bestDist = thrp, d
                                    bestVel = thrp.AssemblyLinearVelocity
                                end
                            end
                        end
                    end
                end

                if not bestHRP then return end

                -- Prediction: velocity + ping
                local ping = 0.05
                pcall(function()
                    ping = PingService.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
                end)
                local predTime = math.clamp(ping * 1.35 + 0.04, 0.04, 0.28)
                local predPos = bestHRP.Position + (bestVel or Vector3.zero) * predTime
                local dir = (predPos - myHRP.Position) * Vector3.new(1, 0, 1)
                if dir.Magnitude < 0.1 then
                    dir = myHRP.CFrame.LookVector
                else
                    dir = dir.Unit
                end

                local maxCombo = FruitM1.MaxCombo(fruit)
                if maxCombo < 1 then maxCombo = 1 end
                local combo = FruitM1.fbCombo or 1
                local isSpecial = FruitM1.IsTrex(fruit) or FruitM1.IsDragon(fruit)
                    or FruitM1.IsBlade(fruit) or FruitM1.IsGas(fruit)
                    or FruitM1.IsPain(fruit) or FruitM1.IsControl(fruit)

                if isSpecial then
                    remote:FireServer(dir, combo)
                else
                    remote:FireServer(dir, combo, true)
                end
                FruitM1.fbCombo = (combo < maxCombo) and (combo + 1) or 1
            end)
            task.wait(0.05) -- spam rapido para que peguen todos los clicks
        end
    end)
end

-- ==================== GUN AURA ====================
local function GetBestPart(model)
    return model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model.PrimaryPart
end

local ShootFunction, getupval, setupval, getupvals
pcall(function()
    getupval = debug.getupvalue or getupvalue
    setupval = debug.setupvalue or setupvalue
    getupvals = debug.getupvalues or getupvalues
end)
local V_Idx = { v26 = 12, v22 = 13, v25 = 14, v21 = 15, v23 = 16, v24 = 17, v27 = 18 }
local function InitDragonGun()
    local ok2, result = pcall(require, ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("CombatController"))
    if ok2 and type(result) == "table" and result.Attack and getupval then
        ShootFunction = getupval(result.Attack, 9)
    end
end
local function GetNextValidator()
    if not getupval then return 0, 0 end
    if not ShootFunction then InitDragonGun() end
    if not ShootFunction then return 0, 0 end
    local upvals = getupvals and getupvals(ShootFunction)
    if not upvals then return 0, 0 end
    if upvals[V_Idx.v21] ~= 727595 then
        for i, v in pairs(upvals) do
            if v == 727595 then
                local o = i - 15
                V_Idx.v21 = i; V_Idx.v22 = 13 + o; V_Idx.v23 = 16 + o; V_Idx.v24 = 17 + o
                V_Idx.v26 = 12 + o; V_Idx.v25 = 14 + o; V_Idx.v27 = 18 + o
                break
            end
        end
    end
    local v1 = getupval(ShootFunction, V_Idx.v21)
    local v2 = getupval(ShootFunction, V_Idx.v22)
    local v3 = getupval(ShootFunction, V_Idx.v23)
    local v4 = getupval(ShootFunction, V_Idx.v24)
    local v5 = getupval(ShootFunction, V_Idx.v25)
    local v6 = getupval(ShootFunction, V_Idx.v26)
    local v7 = getupval(ShootFunction, V_Idx.v27)
    if not (v1 and v2 and v3 and v4 and v5 and v6 and v7) then return 0, 0 end
    local v9 = ((v5 * v2 + v6 * v1) % v3 * v3 + v6 * v2) % v4
    v5 = math.floor(v9 / v3); v6 = v9 - v5 * v3; v7 = v7 + 1
    setupval(ShootFunction, V_Idx.v25, v5)
    setupval(ShootFunction, V_Idx.v26, v6)
    setupval(ShootFunction, V_Idx.v27, v7)
    return math.floor(v9 / v4 * 16777215), v7
end

local function GetClosestGunTarget(range, doPlayers, doMobs, doSea)
    local root = humanoidRootPart
    if not root then return nil end
    local closest, dist, myPos = nil, math.huge, root.Position
    if doMobs then
        local ef = Workspace:FindFirstChild("Enemies")
        if ef then
            for _, enemy in pairs(ef:GetChildren()) do
                local h = enemy:FindFirstChildOfClass("Humanoid")
                local r = GetBestPart(enemy)
                if h and h.Health > 0 and r then
                    local d = (r.Position - myPos).Magnitude
                    if d < dist and d <= range then dist = d; closest = r end
                end
            end
        end
    end
    if doPlayers then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= lp and player.Character then
                local h = player.Character:FindFirstChildOfClass("Humanoid")
                local r = GetBestPart(player.Character)
                if h and h.Health > 0 and r then
                    local d = (r.Position - myPos).Magnitude
                    if d < dist and d <= range then dist = d; closest = r end
                end
            end
        end
    end
    if doSea then
        for _, folderName in ipairs({ "SeaEvent", "SeaEvents", "Boats", "Ships" }) do
            local folder = Workspace:FindFirstChild(folderName)
            if folder then
                for _, obj in pairs(folder:GetDescendants()) do
                    if obj:IsA("Model") then
                        local h = obj:FindFirstChildOfClass("Humanoid")
                        local r = GetBestPart(obj)
                        if h and h.Health > 0 and r then
                            local d = (r.Position - myPos).Magnitude
                            if d < dist and d <= range then dist = d; closest = r end
                        end
                    end
                end
            end
        end
    end
    return closest
end

local _cachedToolSafe, _cachedTargetSafe, _timerSafe = nil, nil, 0
local _cachedToolSuper, _cachedTargetSuper, _timerSuper = nil, nil, 0

task.spawn(function()
    while true do
        if not Config.SafeGun then task.wait(0.05) continue end
        pcall(function()
            local char = lp.Character
            if not char then return end
            if not _cachedToolSafe or not _cachedToolSafe.Parent or _cachedToolSafe.ToolTip ~= "Gun" then
                _cachedToolSafe = char:FindFirstChildOfClass("Tool")
                if not _cachedToolSafe or _cachedToolSafe.ToolTip ~= "Gun" then _cachedToolSafe = nil return end
            end
            _timerSafe = _timerSafe + 1
            if _timerSafe >= 3 or not _cachedTargetSafe or not _cachedTargetSafe.Parent then
                _cachedTargetSafe = GetClosestGunTarget(Config.SafeRange, Config.SafePlayers, Config.SafeMobs, Config.SafeSea)
                _timerSafe = 0
            end
            if not _cachedTargetSafe then return end
            local valCode, valCount = GetNextValidator()
            if valCode ~= 0 and Validator2 then pcall(function() Validator2:FireServer(valCode, valCount) end) end
            _cachedToolSafe:SetAttribute("LocalOverheat", 0)
            _cachedToolSafe:SetAttribute("IsReloading_Client", false)
            _cachedToolSafe:SetAttribute("LocalShotsLeft", 100)
            if ShootGunEvent then ShootGunEvent:FireServer(_cachedTargetSafe.Position, { _cachedTargetSafe }) end
        end)
        task.wait(0.03)
    end
end)

task.spawn(function()
    while true do
        if not Config.SuperGun then task.wait(0.05) continue end
        pcall(function()
            local char = lp.Character
            if not char then return end
            if not _cachedToolSuper or not _cachedToolSuper.Parent or _cachedToolSuper.ToolTip ~= "Gun" then
                _cachedToolSuper = char:FindFirstChildOfClass("Tool")
                if not _cachedToolSuper or _cachedToolSuper.ToolTip ~= "Gun" then _cachedToolSuper = nil return end
            end
            _timerSuper = _timerSuper + 1
            if _timerSuper >= 3 or not _cachedTargetSuper or not _cachedTargetSuper.Parent then
                _cachedTargetSuper = GetClosestGunTarget(Config.SuperRange, Config.SuperPlayers, Config.SuperMobs, Config.SuperSea)
                _timerSuper = 0
            end
            if not _cachedTargetSuper then return end
            local valCode, valCount = GetNextValidator()
            if valCode ~= 0 and Validator2 then pcall(function() Validator2:FireServer(valCode, valCount) end) end
            _cachedToolSuper:SetAttribute("LocalOverheat", 0)
            _cachedToolSuper:SetAttribute("IsReloading_Client", false)
            _cachedToolSuper:SetAttribute("LocalShotsLeft", 100)
            if ShootGunEvent then ShootGunEvent:FireServer(_cachedTargetSuper.Position, { _cachedTargetSuper }) end
        end)
        task.wait(0.03)
    end
end)

-- ==================== DISAPPEAR ====================
local disappearConn = nil
local function setDisappear(on)
    Config.Disappear = on
    if disappearConn then task.cancel(disappearConn) disappearConn = nil end
    if not on then return end
    disappearConn = task.spawn(function()
        while Config.Disappear do
            task.wait(0.1)
            pcall(function()
                if sethiddenproperty then sethiddenproperty(lp, "SimulationRadius", math.huge) end
                local enemies = Workspace:FindFirstChild("Enemies")
                if not enemies then return end
                for _, mob in ipairs(enemies:GetChildren()) do
                    local root = mob:FindFirstChild("HumanoidRootPart")
                    if root then
                        pcall(function() root.CFrame = CFrame.new(0, -500, 0) end)
                    end
                end
            end)
        end
    end)
end
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.P then
        setDisappear(not Config.Disappear)
    end
end)

-- ==================== BRING MOBS ====================
RunService.Heartbeat:Connect(function()
    if not Config.BringMobs then return end
    pcall(function()
        local hrp = humanoidRootPart
        if not hrp then return end
        if sethiddenproperty then pcall(function() sethiddenproperty(lp, "SimulationRadius", math.huge) end) end
        local targetPos = hrp.Position
        local enemies = Workspace:FindFirstChild("Enemies")
        if not enemies then return end
        for _, enemy in ipairs(enemies:GetChildren()) do
            if enemy:IsA("Model") then
                local eHum = enemy:FindFirstChildOfClass("Humanoid")
                local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                if eHum and eRoot and eHum.Health > 0 then
                    if (eRoot.Position - targetPos).Magnitude <= Config.BringRange then
                        eRoot.CFrame = CFrame.new(targetPos.X, targetPos.Y - 18, targetPos.Z)
                        eRoot.CanCollide = false
                        eHum.WalkSpeed = 0
                        eHum.JumpPower = 0
                    end
                end
            end
        end
    end)
end)

-- ==================== TRACKER FLY ====================
local trackerConn = nil
local function StartTrackerFly()
    if trackerConn then return end
    trackerConn = RunService.Heartbeat:Connect(function()
        if not Config.TrackerFly then return end
        local hrp = humanoidRootPart
        if not hrp then return end
        local closest, dist = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp and p.Character then
                local r = p.Character:FindFirstChild("HumanoidRootPart")
                local h = p.Character:FindFirstChildOfClass("Humanoid")
                if r and h and h.Health > 0 then
                    local d = (r.Position - hrp.Position).Magnitude
                    if d < dist then dist = d; closest = r end
                end
            end
        end
        if closest and dist > 8 then
            local dir = (closest.Position - hrp.Position)
            if dir.Magnitude > 0 then
                local step = math.min(Config.TrackerFlySpeed * 0.03, dir.Magnitude - Config.TrackerOrbitRadius)
                if step > 0 then
                    hrp.CFrame = hrp.CFrame + dir.Unit * step
                end
            end
        end
    end)
end
local function StopTrackerFly()
    if trackerConn then trackerConn:Disconnect(); trackerConn = nil end
end

-- ==================== CESTIAN-STYLE TWEEN / INSTA / SPECTATE ====================
local TweenService = game:GetService("TweenService")
local activeTrackTween = nil
local function getTrackTargetHRP()
    local name = Config.SelectedTrackPlayer or "Nearest"
    if name ~= "Nearest" then
        local p = Players:FindFirstChild(name)
        if p and p.Character then
            return p.Character:FindFirstChild("HumanoidRootPart"), p
        end
        return nil, nil
    end
    local my = humanoidRootPart
    if not my then return nil, nil end
    local best, bd, bp = nil, math.huge, nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if r and h and h.Health > 0 then
                local d = (r.Position - my.Position).Magnitude
                if d < bd then bd = d; best = r; bp = p end
            end
        end
    end
    return best, bp
end
RunService.Heartbeat:Connect(function()
    if not (Config.TweenNearest or Config.TweenToPlayer or Config.InstaTP) then return end
    pcall(function()
        local hrp = humanoidRootPart
        if not hrp then return end
        local targetHRP = getTrackTargetHRP()
        if not targetHRP then return end
        local ox, oy, oz = Config.TweenOX or 0, Config.TweenOY or 1.5, Config.TweenOZ or 3.5
        local pred = targetHRP.Position + (targetHRP.AssemblyLinearVelocity * (Config.PredictionStrength or 0.1))
        local dest = CFrame.new(pred) * CFrame.new(ox, oy, oz)
        if Config.InstaTP then
            hrp.CFrame = dest
            hrp.AssemblyLinearVelocity = Vector3.zero
        elseif Config.TweenNearest or Config.TweenToPlayer then
            local dist = (dest.Position - hrp.Position).Magnitude
            local speed = Config.TweenSpeed or 350
            if activeTrackTween then activeTrackTween:Cancel() end
            activeTrackTween = TweenService:Create(hrp, TweenInfo.new(math.max(dist / speed, 0.05), Enum.EasingStyle.Linear), { CFrame = dest })
            activeTrackTween:Play()
        end
    end)
end)
RunService.RenderStepped:Connect(function()
    if not Config.Spectate then return end
    pcall(function()
        local _, plr = getTrackTargetHRP()
        if plr and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum then Workspace.CurrentCamera.CameraSubject = hum end
        end
    end)
end)

-- ==================== AUTO FLEE ====================
local fleeConnection = nil
local fleeTeleported = false
local FLEE_Y, FLEE_Z = 530, 300
local function GetFleeDestination()
    local pid = game.PlaceId
    if pid == 4442272183 or pid == 79091703265657 then
        return Vector3.new(923, 126, 32852)
    elseif pid == 7449423635 or pid == 100117331123089 then
        return Vector3.new(-5027.03, 316.43, -3206.07)
    end
    return nil
end
local function RestoreFleeState()
    pcall(function()
        local char = lp.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end
        if hum then
            hum.PlatformStand = false
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end
local function StartAutoFlee()
    if fleeConnection then return end
    fleeConnection = task.spawn(function()
        while Config.AutoFlee do
            task.wait()
            pcall(function()
                if not Config.AutoFlee then return end
                local char = lp.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hum or not hrp or hum.Health <= 0 then return end
                local hpPercent = (hum.Health / hum.MaxHealth) * 100
                if hpPercent <= Config.AutoFleeHP then
                    if not fleeTeleported then
                        fleeTeleported = true
                        local dest = GetFleeDestination()
                        if dest then
                            pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", dest) end)
                        end
                    end
                    local deltaTime = task.wait()
                    local newPosition = hrp.Position + Vector3.new(0, FLEE_Y * deltaTime, FLEE_Z * deltaTime)
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                    hum:ChangeState(Enum.HumanoidStateType.Physics)
                    hrp.CFrame = CFrame.new(newPosition) * (hrp.CFrame - hrp.Position)
                elseif fleeTeleported then
                    fleeTeleported = false
                    RestoreFleeState()
                end
            end)
        end
        fleeConnection = nil
        fleeTeleported = false
        RestoreFleeState()
    end)
end
local function StopAutoFlee()
    Config.AutoFlee = false
    fleeConnection = nil
    fleeTeleported = false
    RestoreFleeState()
end

-- ==================== AUTO BUFFS ====================
task.spawn(function()
    while true do
        task.wait(1)
        if Config.AutoV3 and CommE then pcall(function() CommE:FireServer("ActivateAbility") end) end
    end
end)
task.spawn(function()
    while true do
        task.wait(0.5)
        if Config.AutoV4 then
            pcall(function()
                local aw = (lp.Character and lp.Character:FindFirstChild("Awakening"))
                    or (lp.Backpack and lp.Backpack:FindFirstChild("Awakening"))
                if aw then
                    local rf = aw:FindFirstChildWhichIsA("RemoteFunction")
                    if rf then rf:InvokeServer(true) end
                end
            end)
        end
    end
end)
task.spawn(function()
    while true do
        task.wait(30)
        if Config.AutoPvP then pcall(function() CommF:InvokeServer("EnablePvp") end) end
    end
end)

-- ==================== STATS GUI ====================
local statsScreen, statsLabel, statsConn, statsFrame
local statsFpsCount, statsFpsLast, statsFpsValue = 0, tick(), 60
pcall(function()
    statsScreen = Instance.new("ScreenGui")
    statsScreen.Name = "BragaoStatsGui"
    statsScreen.ResetOnSpawn = false
    statsScreen.Enabled = false
    statsScreen.Parent = lp:WaitForChild("PlayerGui")
    statsFrame = Instance.new("Frame", statsScreen)
    statsFrame.Size = UDim2.new(0, 200, 0, 28)
    statsFrame.Position = UDim2.new(0.5, -100, 0, 8)
    statsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    statsFrame.BackgroundTransparency = 0.3
    statsFrame.Active = true
    statsFrame.Draggable = true
    Instance.new("UICorner", statsFrame).CornerRadius = UDim.new(0, 8)
    statsLabel = Instance.new("TextLabel", statsFrame)
    statsLabel.Size = UDim2.new(1, 0, 1, 0)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Font = Enum.Font.GothamBold
    statsLabel.TextSize = 13
    statsLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    statsLabel.Text = "FPS: -- | Ping: --"
end)
local function setStatsGui(on)
    Config.StatsGui = on
    if statsScreen then statsScreen.Enabled = on end
    if statsConn then statsConn:Disconnect() statsConn = nil end
    if not on then return end
    statsConn = RunService.Heartbeat:Connect(function()
        statsFpsCount = statsFpsCount + 1
        local now = tick()
        if now - statsFpsLast >= 1 then
            statsFpsValue = statsFpsCount / (now - statsFpsLast)
            statsFpsCount = 0
            statsFpsLast = now
        end
        local ping = math.floor(lp:GetNetworkPing() * 1000)
        local fps = math.floor(statsFpsValue)
        if statsLabel then
            if fps < 30 then statsLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            elseif fps < 50 then statsLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            else statsLabel.TextColor3 = Color3.fromRGB(0, 255, 100) end
            statsLabel.Text = string.format("FPS: %d | Ping: %dms", fps, ping)
        end
    end)
end

-- ==================== REMOVE GHOST SHIP ====================
task.spawn(function()
    while true do
        task.wait(2)
        if not Config.RemoveGhostShip then continue end
        pcall(function()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                local n = obj.Name:lower()
                if n:find("ghost") and n:find("ship") then
                    pcall(function() obj:Destroy() end)
                end
            end
        end)
    end
end)

-- ==================== FLY ====================
local flyBV, flyBG, flyConn
local holdUp, holdDown = false, false
local noclipParts = {}
local function setNoclip(on)
    local char = lp.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            if on then
                if noclipParts[part] == nil then noclipParts[part] = part.CanCollide end
                part.CanCollide = false
            else
                if noclipParts[part] ~= nil then part.CanCollide = noclipParts[part] end
            end
        end
    end
    if not on then noclipParts = {} end
end
local function destroyFlyMovers()
    pcall(function() if flyBV then flyBV:Destroy() end end)
    pcall(function() if flyBG then flyBG:Destroy() end end)
    flyBV, flyBG = nil, nil
end
local function cleanupFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    destroyFlyMovers()
    setNoclip(false)
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then pcall(function() hum.PlatformStand = false end) end
end
local function ensureFlyMovers(hrp)
    if not hrp then return end
    if not flyBV or not flyBV.Parent then
        flyBV = Instance.new("BodyVelocity")
        flyBV.Name = "BragaoFlyBV"
        flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        flyBV.Velocity = Vector3.zero
        flyBV.Parent = hrp
    end
    if not flyBG or not flyBG.Parent then
        flyBG = Instance.new("BodyGyro")
        flyBG.Name = "BragaoFlyBG"
        flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyBG.P = 3e4
        flyBG.Parent = hrp
    end
end
local function startFly()
    cleanupFly()
    local hrp = humanoidRootPart
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    Config.Fly = true
    hum.PlatformStand = true
    setNoclip(true)
    ensureFlyMovers(hrp)
    flyConn = RunService.Heartbeat:Connect(function(dt)
        if not Config.Fly then return end
        hrp = humanoidRootPart
        hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        ensureFlyMovers(hrp)
        hum.PlatformStand = true
        setNoclip(true)
        local camCF = Camera.CFrame
        local look, right = camCF.LookVector, camCF.RightVector
        local md = hum.MoveDirection
        local move = Vector3.zero
        if md.Magnitude > 0.08 then
            local flatLook = Vector3.new(look.X, 0, look.Z)
            local flatRight = Vector3.new(right.X, 0, right.Z)
            if flatLook.Magnitude > 0.01 then flatLook = flatLook.Unit end
            if flatRight.Magnitude > 0.01 then flatRight = flatRight.Unit end
            local flatMd = Vector3.new(md.X, 0, md.Z)
            local fwd, str = 0, 0
            if flatMd.Magnitude > 0.01 then
                flatMd = flatMd.Unit
                fwd = flatMd:Dot(flatLook)
                str = flatMd:Dot(flatRight)
            end
            move = look * fwd + right * str
            if move.Magnitude > 0.01 then move = move.Unit * math.clamp(md.Magnitude, 0, 1) end
        end
        if holdUp then move = move + Vector3.new(0, 1, 0) end
        if holdDown then move = move - Vector3.new(0, 1, 0) end
        local targetVel = Vector3.zero
        if move.Magnitude > 0.05 then
            move = move.Unit
            targetVel = Vector3.new(move.X * Config.FlySpeed, move.Y * Config.FlyVertical, move.Z * Config.FlySpeed)
        end
        if Config.FlySmooth then
            flyBV.Velocity = flyBV.Velocity:Lerp(targetVel, math.clamp(dt * 12, 0.1, 0.5))
        else
            flyBV.Velocity = targetVel
        end
        flyBG.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + look)
    end)
end
local function stopFly()
    Config.Fly = false
    cleanupFly()
end
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Space then holdUp = true
    elseif input.KeyCode == Enum.KeyCode.LeftShift then holdDown = true end
end)
UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then holdUp = false
    elseif input.KeyCode == Enum.KeyCode.LeftShift then holdDown = false end
end)
lp.CharacterAdded:Connect(function()
    destroyFlyMovers()
    noclipParts = {}
    task.wait(0.6)
    if Config.Fly then startFly() end
end)

pcall(function()
    lp.Idled:Connect(function()
        if not Config.AntiAFK then return end
        local vu = game:GetService("VirtualUser")
        if vu then vu:CaptureController(); vu:ClickButton2(Vector2.zero) end
    end)
end)

local waterPart
task.spawn(function()
    while true do
        task.wait(0.15)
        if Config.WalkOnWater then
            local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if not waterPart or not waterPart.Parent then
                waterPart = Instance.new("Part")
                waterPart.Size = Vector3.new(200, 1, 200)
                waterPart.Transparency = 1
                waterPart.Anchored = true
                waterPart.CanCollide = false
                waterPart.Name = "BragaoWaterPlatform"
                waterPart.Parent = Workspace
            end
            if hrp and hrp.Position.Y >= 9.5 then
                waterPart.Position = Vector3.new(hrp.Position.X, 9.2, hrp.Position.Z)
                waterPart.CanCollide = true
            else
                waterPart.CanCollide = false
            end
        elseif waterPart then
            waterPart.CanCollide = false
        end
    end
end)

local antiLavaConn
local function startAntiLava()
    if antiLavaConn then antiLavaConn:Disconnect() end
    local t = 0
    antiLavaConn = RunService.Stepped:Connect(function(_, dt)
        t = t + dt
        if t < 0.2 then return end
        t = 0
        local char = lp.Character
        if not (char and Config.AntiLava) then return end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart")
                and part.Name ~= "HumanoidRootPart"
                and part.Name ~= "Head"
                and part.Name ~= "Torso"
                and part.Name ~= "UpperTorso"
                and part.Name ~= "LowerTorso" then
                pcall(function() part.CanTouch = false end)
            end
        end
    end)
end
local function stopAntiLava()
    if antiLavaConn then antiLavaConn:Disconnect() antiLavaConn = nil end
end

RunService.Heartbeat:Connect(function()
    if not Config.SpeedEnabled then return end
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    local md = hum.MoveDirection
    if Config.SpeedMode == "WalkSpeed" then
        hum.WalkSpeed = Config.SpeedValue
    elseif Config.SpeedMode == "CFrame" and md.Magnitude > 0 then
        hrp.CFrame = hrp.CFrame + md * (Config.SpeedValue / 100)
    elseif Config.SpeedMode == "Velocity" and md.Magnitude > 0 then
        hrp.AssemblyLinearVelocity = Vector3.new(md.X * Config.SpeedValue, hrp.AssemblyLinearVelocity.Y, md.Z * Config.SpeedValue)
    end
end)

-- ==================== SKY ====================
local skies = {
    ["black storm"] = {
        SkyboxLf = "rbxassetid://15502507918", SkyboxUp = "rbxassetid://15502511911",
        SkyboxRt = "rbxassetid://15502509398", SkyboxFt = "rbxassetid://15502510289",
        SkyboxDn = "rbxassetid://15502508460", SkyboxBk = "rbxassetid://15502511288",
    },
    ["blue space"] = {
        SkyboxLf = "rbxassetid://15536114370", SkyboxUp = "rbxassetid://15536117282",
        SkyboxRt = "rbxassetid://15536118762", SkyboxFt = "rbxassetid://15536116141",
        SkyboxDn = "rbxassetid://15536112543", SkyboxBk = "rbxassetid://15536110634",
    },
    ["realistic"] = {
        SkyboxUp = "rbxassetid://653719321", SkyboxDn = "rbxassetid://653718790",
        SkyboxLf = "rbxassetid://653719190", SkyboxFt = "rbxassetid://653719067",
        SkyboxRt = "rbxassetid://653718931", SkyboxBk = "rbxassetid://653719502",
    },
    ["stormy"] = {
        SkyboxUp = "http://www.roblox.com/asset/?id=18703232671", SkyboxBk = "http://www.roblox.com/asset/?id=18703245834",
        SkyboxLf = "http://www.roblox.com/asset/?id=18703237556", SkyboxDn = "http://www.roblox.com/asset/?id=18703243349",
        SkyboxFt = "http://www.roblox.com/asset/?id=18703240532", SkyboxRt = "http://www.roblox.com/asset/?id=18703235430",
    },
    ["pink"] = {
        SkyboxUp = "rbxassetid://12216108877", SkyboxLf = "rbxassetid://12216110170",
        SkyboxRt = "rbxassetid://12216110471", SkyboxFt = "rbxassetid://12216109489",
        SkyboxBk = "rbxassetid://12216109205", SkyboxDn = "rbxassetid://12216109875",
    },
    ["c00lkidd"] = {
        SkyboxBk = "rbxassetid://6444884337", SkyboxDn = "rbxassetid://6444884780",
        SkyboxFt = "rbxassetid://6444884337", SkyboxLf = "rbxassetid://6444884337",
        SkyboxRt = "rbxassetid://6444884337", SkyboxUp = "rbxassetid://6412503613",
    },
}
local skyInst = nil
local function applySky()
    if skyInst then skyInst:Destroy() skyInst = nil end
    if not Config.SkyEnabled then return end
    local d = skies[Config.SkyType]
    if not d then return end
    local s = Instance.new("Sky")
    for k, v in pairs(d) do s[k] = v end
    s.Parent = Lighting
    skyInst = s
end

local ambientPresets = {
    Rain = { Ambient = Color3.fromRGB(90, 100, 120), Outdoor = Color3.fromRGB(70, 80, 100), Brightness = 1 },
    Night = { Ambient = Color3.fromRGB(40, 40, 60), Outdoor = Color3.fromRGB(30, 30, 50), Brightness = 0.5 },
    Day = { Ambient = Color3.fromRGB(140, 140, 140), Outdoor = Color3.fromRGB(128, 128, 128), Brightness = 2 },
    Foggy = { Ambient = Color3.fromRGB(100, 100, 110), Outdoor = Color3.fromRGB(90, 90, 100), Brightness = 1.2 },
}
local function applyAmbient()
    if not Config.AmbientEnabled then
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        return
    end
    local p = ambientPresets[Config.AmbientType] or ambientPresets.Rain
    Lighting.Ambient = p.Ambient
    Lighting.OutdoorAmbient = p.Outdoor
    Lighting.Brightness = p.Brightness
end

local function applyMinecraft(on)
    Config.MinecraftTex = on
    if on then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.Brightness = 2.5
            Lighting.Ambient = Color3.fromRGB(140, 140, 140)
            Lighting.OutdoorAmbient = Color3.fromRGB(140, 140, 140)
        end)
    else
        pcall(function()
            Lighting.GlobalShadows = true
            Lighting.Brightness = 2
        end)
    end
end

-- ==================== SILENT AIM (Nameless full module port) ====================
-- Same logic as NamelessWare SilentAimModule: prediction, blacklist, mouse override,
-- FireServer args[1] only, TAP skip, Soru C, Godhuman/Sword Z override, faceTarget

local mouse = lp:GetMouse()
local Camera = Workspace.CurrentCamera

local SilentAimModule = (function()
    local module = {}
    local player = lp
    local UIS = UserInputService
    local camera = Workspace.CurrentCamera
    local CoreGui = game:GetService("CoreGui")

    local SilentAimPlayersEnabled = false
    local SilentAimNPCsEnabled = false
    local PredictionEnabled = true
    local PredictionAmount = 0.12
    local ZSkillorM1 = true
    local ShowFOVCircle = false
    local FOVRadius = 150
    local FOVMode = "V1"
    local AimMode = "360"
    local TargetPriority = "Nearest"
    local maxRange = 2000

    local SoruAutoAimEnabled = false
    local SoruAutoAimRange = 300
    local SoruTargetingMode = "360"
    local SoruFOVType = "V1"
    local SoruFOVRadius = 150
    local SoruTargetPriority = "Nearest"
    local SoruShowFOVCircle = false
    local SoruCurrentTarget = nil
    local SoruPredictedPosition = nil

    local TracerEnabled = false
    local TracerColor = "Red"
    local tracerModel, tracerAttachment0, tracerAttachment1, tracerBeam = nil, nil, nil, nil

    local renderConnection, heartbeatConnection = nil, nil
    local currentTool, currentToolCategory = nil, "Melee"
    local PlayersPosition, NPCPosition = nil, nil
    local CurrentTargetPlayer = nil
    local fovCache, fovCacheTime = {}, 0
    local Selectedplayer = nil
    local characterConnections = {}
    local Skills = {"X"}
    local BlacklistedKeys = {
        Melee = { Z = false, X = false, C = false, V = false, F = false },
        Sword = { Z = false, X = false, C = false, V = false, F = false },
        Fruit = { Z = false, X = false, C = false, V = false, F = false, TAP = false },
        Gun   = { Z = false, X = false, C = false, V = false, F = false },
    }
    local currentSkillKey = nil
    local SKILL_KEYS = {"Z", "X", "C", "V", "F", "TAP"}
    local lastSkillTime = 0
    local OverrideGodhumanSanguineEnabled = true

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Bragao_FOV"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    pcall(function()
        if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
    end)
    ScreenGui.Parent = (gethui and gethui()) or CoreGui or player:WaitForChild("PlayerGui")

    local FOVFrame = Instance.new("Frame")
    FOVFrame.Name = "FOVCircle"
    FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    FOVFrame.BackgroundTransparency = 1
    FOVFrame.Visible = false
    FOVFrame.Parent = ScreenGui
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(160, 70, 255)
    UIStroke.Thickness = 2
    UIStroke.Parent = FOVFrame
    Instance.new("UICorner", FOVFrame).CornerRadius = UDim.new(1, 0)

    local SoruFOVFrame = Instance.new("Frame")
    SoruFOVFrame.Name = "SoruFOVCircle"
    SoruFOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    SoruFOVFrame.BackgroundTransparency = 1
    SoruFOVFrame.Visible = false
    SoruFOVFrame.Parent = ScreenGui
    local SoruUIStroke = Instance.new("UIStroke")
    SoruUIStroke.Color = Color3.fromRGB(0, 255, 100)
    SoruUIStroke.Thickness = 2
    SoruUIStroke.Parent = SoruFOVFrame
    Instance.new("UICorner", SoruFOVFrame).CornerRadius = UDim.new(1, 0)

    local function getToolCategory(tool)
        if not tool then return "Melee" end
        local name = string.lower(tool.Name)
        local tip = tool.ToolTip or ""
        if tip == "Gun" or name:find("guitar") or name:find("rifle") or name:find("gun") or name:find("bow") or name:find("kabucha") then
            return "Gun"
        end
        local meleeNames = {"claw", "godhuman", "superhuman", "talon", "step", "karate", "breath", "kung fu", "combat", "fist", "sanguine", "electric"}
        for _, m in ipairs(meleeNames) do
            if name:find(m) then return "Melee" end
        end
        if tip == "Blox Fruit" or name:find("fruit") or name:find("-") then return "Fruit" end
        if tip == "Sword" then return "Sword" end
        return "Sword"
    end

    local function isOverrideTool(tool)
        if not tool then return false end
        local name = string.lower(tool.Name)
        if name == "godhuman" or name:find("sanguine") or name:find("yama") then return true end
        if currentToolCategory == "Sword" then return true end
        if currentToolCategory == "Melee" and (name:find("godhuman") or name:find("sanguine")) then return true end
        return false
    end

    local function isKeyCurrentlyBlacklisted(key)
        if not key then return false end
        local cat = currentToolCategory or "Melee"
        if BlacklistedKeys[cat] and BlacklistedKeys[cat][key] ~= nil then
            return BlacklistedKeys[cat][key] == true
        end
        return false
    end

    local function getHRP(model)
        return model and model:FindFirstChild("HumanoidRootPart")
    end

    local function faceTarget(targetPos)
        if not targetPos then return end
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local currentPos = hrp.Position
        local lookVector = (Vector3.new(targetPos.X, currentPos.Y, targetPos.Z) - currentPos)
        if lookVector.Magnitude < 0.001 then return end
        lookVector = lookVector.Unit
        hrp.CFrame = CFrame.lookAt(currentPos, currentPos + lookVector, Vector3.new(0, 1, 0))
    end

    local function setCurrentSkillKey(key)
        currentSkillKey = key
        lastSkillTime = os.clock()
        if SilentAimPlayersEnabled or SilentAimNPCsEnabled then
            local targetPos = PlayersPosition or NPCPosition
            if targetPos then
                task.spawn(function() faceTarget(targetPos) end)
            end
        end
        task.spawn(function()
            local myTime = lastSkillTime
            task.wait(1.5)
            if lastSkillTime == myTime and currentSkillKey == key then
                currentSkillKey = nil
            end
        end)
    end

    local lastDirection = nil
    local function predicted(hrp)
        if not hrp then return nil end
        local hum = hrp.Parent and hrp.Parent:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return hrp.Position end
        if not PredictionEnabled then return hrp.Position end
        local vel = hrp.AssemblyLinearVelocity or hrp.Velocity or Vector3.zero
        local speed = vel.Magnitude
        if speed < 5 then
            lastDirection = nil
            return hrp.Position
        end
        local currentDirection = vel.Unit
        if lastDirection then
            if lastDirection:Dot(currentDirection) < 0.7 then
                lastDirection = nil
                return hrp.Position
            end
        end
        lastDirection = currentDirection
        local ping = 0
        pcall(function() ping = player:GetNetworkPing() end)
        ping = math.clamp(ping, 0, 0.35)
        local factor = PredictionAmount + ping
        if speed > 100 then factor = math.min(factor, 0.15) end
        return hrp.Position + vel * factor
    end

    local function isAllyWithMe(targetplayer)
        local myGui = player:FindFirstChild("PlayerGui")
        if not myGui then return false end
        local scrolling = myGui:FindFirstChild("Main")
            and myGui.Main:FindFirstChild("Allies")
            and myGui.Main.Allies:FindFirstChild("Container")
            and myGui.Main.Allies.Container:FindFirstChild("Allies")
            and myGui.Main.Allies.Container.Allies:FindFirstChild("ScrollingFrame")
        if scrolling then
            for _, frame in pairs(scrolling:GetDescendants()) do
                if frame:IsA("ImageButton") and frame.Name == targetplayer.Name then
                    return true
                end
            end
        end
        return false
    end

    local function isTargetProtected(targetPlayer)
        if not targetPlayer then return false end
        local char = targetPlayer.Character
        if not char then return false end
        if char:GetAttribute("SafeZone") == true or char:GetAttribute("PvpDisabled") == true
            or char:GetAttribute("CombatProtected") == true or char:GetAttribute("PVP") == false then
            return true
        end
        if char:FindFirstChildWhichIsA("ForceField") then return true end
        return false
    end

    local function isEnemy(targetplayer)
        if not targetplayer or targetplayer == player then return false end
        if isTargetProtected(targetplayer) then return false end
        local myTeam, targetTeam = player.Team, targetplayer.Team
        if myTeam and targetTeam then
            if myTeam.Name == "Pirates" and targetTeam.Name == "Marines" then return true end
            if myTeam.Name == "Marines" and targetTeam.Name == "Pirates" then return true end
            if myTeam.Name == "Pirates" and targetTeam.Name == "Pirates" then
                return not isAllyWithMe(targetplayer)
            end
            if myTeam.Name == "Marines" and targetTeam.Name == "Marines" then return false end
        end
        return true
    end

    local function getFOVCenter(mode)
        if mode == "V2" then return UIS:GetMouseLocation() end
        camera = Workspace.CurrentCamera
        return camera.ViewportSize / 2
    end

    local function isTargetValid(hrp, lpHRP, aimMode, fovRadius, fovType)
        if not hrp or not lpHRP then return false end
        if aimMode == "180" then
            local dir = (hrp.Position - lpHRP.Position).Unit
            if lpHRP.CFrame.LookVector:Dot(dir) < 0 then return false end
        elseif aimMode == "FOV" then
            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
            if not onScreen then return false end
            local center = getFOVCenter(fovType)
            if (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude > fovRadius then
                return false
            end
        end
        return true
    end

    local function getClosestplayer(lpHRP)
        if not lpHRP then return nil end
        if TargetPriority == "Lock Player" then
            if Selectedplayer and Selectedplayer.Character and Selectedplayer.Character.Parent then
                if isTargetProtected(Selectedplayer) then return nil end
                local hum = Selectedplayer.Character:FindFirstChildWhichIsA("Humanoid")
                local hrp = getHRP(Selectedplayer.Character)
                if hum and hum.Health > 0 and hrp then
                    if isTargetValid(hrp, lpHRP, AimMode, FOVRadius, FOVMode)
                        and (hrp.Position - lpHRP.Position).Magnitude <= maxRange then
                        return Selectedplayer
                    end
                end
            end
            return nil
        end
        local valid = {}
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= player and isEnemy(pl) and pl.Character and pl.Character.Parent then
                local hum = pl.Character:FindFirstChildWhichIsA("Humanoid")
                local hrp = getHRP(pl.Character)
                if hum and hum.Health > 0 and hrp and isTargetValid(hrp, lpHRP, AimMode, FOVRadius, FOVMode) then
                    local dist = (hrp.Position - lpHRP.Position).Magnitude
                    if dist <= maxRange then
                        table.insert(valid, { Player = pl, Humanoid = hum, HRP = hrp, Distance = dist })
                    end
                end
            end
        end
        if #valid == 0 then return nil end
        if AimMode == "360" or AimMode == "180" then
            if TargetPriority == "Nearest" then
                table.sort(valid, function(a, b) return a.Distance < b.Distance end)
            elseif TargetPriority == "Low HP" or TargetPriority == "LowestHP" then
                table.sort(valid, function(a, b) return a.Humanoid.Health < b.Humanoid.Health end)
            elseif TargetPriority == "HighestHP" then
                table.sort(valid, function(a, b) return a.Humanoid.Health > b.Humanoid.Health end)
            elseif TargetPriority == "Looking At Me" then
                table.sort(valid, function(a, b)
                    local dirA = (lpHRP.Position - a.HRP.Position).Unit
                    local dirB = (lpHRP.Position - b.HRP.Position).Unit
                    return a.HRP.CFrame.LookVector:Dot(dirA) > b.HRP.CFrame.LookVector:Dot(dirB)
                end)
            else
                table.sort(valid, function(a, b) return a.Distance < b.Distance end)
            end
        else
            local center = getFOVCenter(FOVMode)
            table.sort(valid, function(a, b)
                local pA = camera:WorldToViewportPoint(a.HRP.Position)
                local pB = camera:WorldToViewportPoint(b.HRP.Position)
                return (Vector2.new(pA.X, pA.Y) - center).Magnitude < (Vector2.new(pB.X, pB.Y) - center).Magnitude
            end)
        end
        return valid[1].Player
    end

    local function getClosestNPC(lpHRP)
        if not lpHRP then return nil end
        local enemiesFolder = Workspace:FindFirstChild("Enemies")
        if not enemiesFolder then return nil end
        local closest, closestDist = nil, math.huge
        for _, npc in ipairs(enemiesFolder:GetChildren()) do
            if npc:IsA("Model") then
                local hum = npc:FindFirstChildWhichIsA("Humanoid")
                local hrp = getHRP(npc)
                if hum and hum.Health > 0 and hrp and isTargetValid(hrp, lpHRP, AimMode, FOVRadius, FOVMode) then
                    local dist = (hrp.Position - lpHRP.Position).Magnitude
                    if dist <= maxRange and dist < closestDist then
                        closestDist = dist
                        closest = npc
                    end
                end
            end
        end
        return closest
    end

    local function getSoruTarget(lpHRP)
        if not lpHRP then return nil end
        local valid = {}
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= player and pl.Character and pl.Character.Parent and isEnemy(pl) then
                local hum = pl.Character:FindFirstChildWhichIsA("Humanoid")
                local hrp = getHRP(pl.Character)
                if hum and hum.Health > 0 and hrp then
                    if isTargetValid(hrp, lpHRP, SoruTargetingMode, SoruFOVRadius, SoruFOVType) then
                        local dist = (hrp.Position - lpHRP.Position).Magnitude
                        if dist <= SoruAutoAimRange then
                            table.insert(valid, { HRP = hrp, Humanoid = hum, Distance = dist })
                        end
                    end
                end
            end
        end
        if #valid == 0 then return nil end
        if SoruTargetingMode == "360" or SoruTargetingMode == "180" then
            if SoruTargetPriority == "Nearest" then
                table.sort(valid, function(a, b) return a.Distance < b.Distance end)
            elseif SoruTargetPriority == "Low HP" then
                table.sort(valid, function(a, b) return a.Humanoid.Health < b.Humanoid.Health end)
            elseif SoruTargetPriority == "Looking At Me" then
                table.sort(valid, function(a, b)
                    local dirA = (lpHRP.Position - a.HRP.Position).Unit
                    local dirB = (lpHRP.Position - b.HRP.Position).Unit
                    return a.HRP.CFrame.LookVector:Dot(dirA) > b.HRP.CFrame.LookVector:Dot(dirB)
                end)
            end
        else
            local center = getFOVCenter(SoruFOVType)
            table.sort(valid, function(a, b)
                local pA = camera:WorldToViewportPoint(a.HRP.Position)
                local pB = camera:WorldToViewportPoint(b.HRP.Position)
                return (Vector2.new(pA.X, pA.Y) - center).Magnitude < (Vector2.new(pB.X, pB.Y) - center).Magnitude
            end)
        end
        return valid[1].HRP
    end

    task.spawn(function()
        while true do
            task.wait(0.15)
            if SoruAutoAimEnabled then
                local myHRP = getHRP(player.Character)
                local targetHRP = myHRP and getSoruTarget(myHRP)
                if targetHRP then
                    SoruPredictedPosition = predicted(targetHRP) or targetHRP.Position
                    SoruCurrentTarget = targetHRP
                else
                    SoruCurrentTarget = nil
                    SoruPredictedPosition = nil
                end
            else
                SoruCurrentTarget = nil
                SoruPredictedPosition = nil
            end
        end
    end)

    local function updateTracerColor()
        if not tracerBeam then return end
        local colorMap = {
            Red = Color3.fromRGB(255, 0, 0), Green = Color3.fromRGB(0, 255, 0),
            Blue = Color3.fromRGB(0, 0, 255), Yellow = Color3.fromRGB(255, 255, 0),
            White = Color3.fromRGB(255, 255, 255),
        }
        tracerBeam.Color = ColorSequence.new(colorMap[TracerColor] or colorMap.Red)
    end
    local function createTracer()
        if tracerModel then return end
        tracerModel = Instance.new("Model")
        tracerModel.Name = "BragaoSilentAimTracer"
        tracerModel.Parent = Workspace
        tracerAttachment0 = Instance.new("Attachment", tracerModel)
        tracerAttachment1 = Instance.new("Attachment", tracerModel)
        tracerBeam = Instance.new("Beam", tracerModel)
        tracerBeam.Attachment0 = tracerAttachment0
        tracerBeam.Attachment1 = tracerAttachment1
        tracerBeam.Width0 = 0.1
        tracerBeam.Width1 = 0.1
        tracerBeam.FaceCamera = true
        updateTracerColor()
    end
    local function destroyTracer()
        if tracerModel then tracerModel:Destroy() end
        tracerModel, tracerAttachment0, tracerAttachment1, tracerBeam = nil, nil, nil, nil
    end

    -- Mouse module override (Godhuman / Sanguine / Sword Z)
    pcall(function()
        local MouseModuleInstance = RS:FindFirstChild("Mouse")
        if not MouseModuleInstance then return end
        local MouseModule = nil
        pcall(function() MouseModule = require(MouseModuleInstance) end)
        if not MouseModule or type(MouseModule) ~= "table" then return end
        local realStore = { Hit = rawget(MouseModule, "Hit"), Target = rawget(MouseModule, "Target") }
        local mmt = getrawmetatable(MouseModule)
        if mmt then setreadonly(mmt, false) else mmt = {}; setmetatable(MouseModule, mmt) end
        rawset(MouseModule, "Hit", nil)
        rawset(MouseModule, "Target", nil)
        mmt.__index = function(self, key)
            if key == "Hit" then
                if OverrideGodhumanSanguineEnabled
                    and (SilentAimPlayersEnabled or SilentAimNPCsEnabled)
                    and (PlayersPosition or NPCPosition)
                    and isOverrideTool(currentTool)
                    and currentSkillKey == "Z"
                    and not isKeyCurrentlyBlacklisted(currentSkillKey) then
                    local pos = PlayersPosition or NPCPosition
                    if pos then return CFrame.new(pos) end
                end
                return realStore.Hit
            elseif key == "Target" then
                if OverrideGodhumanSanguineEnabled
                    and (SilentAimPlayersEnabled or SilentAimNPCsEnabled)
                    and (PlayersPosition or NPCPosition)
                    and isOverrideTool(currentTool)
                    and currentSkillKey == "Z"
                    and not isKeyCurrentlyBlacklisted(currentSkillKey) then
                    return nil
                end
                return realStore.Target
            end
            return rawget(self, key)
        end
        mmt.__newindex = function(self, key, value)
            if key == "Hit" or key == "Target" then
                realStore[key] = value
            else
                rawset(self, key, value)
            end
        end
        setreadonly(mmt, true)
    end)

    UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        local keyMap = {
            [Enum.KeyCode.Z] = "Z", [Enum.KeyCode.X] = "X", [Enum.KeyCode.C] = "C",
            [Enum.KeyCode.V] = "V", [Enum.KeyCode.F] = "F",
        }
        local key = keyMap[input.KeyCode]
        if key then setCurrentSkillKey(key) end
    end)

    task.spawn(function()
        local pg = player:WaitForChild("PlayerGui", 20)
        if not pg then return end
        local main = pg:FindFirstChild("Main") or pg:WaitForChild("Main", 15)
        if not main then return end
        local skills = main:FindFirstChild("Skills") or main:WaitForChild("Skills", 10)
        if not skills then return end
        local function hookBtn(btn)
            if not btn:IsA("GuiButton") then return end
            if btn:GetAttribute("MHHooked") then return end
            if table.find(SKILL_KEYS, btn.Name) then
                btn:SetAttribute("MHHooked", true)
                btn.Activated:Connect(function() setCurrentSkillKey(btn.Name) end)
            end
        end
        for _, d in ipairs(skills:GetDescendants()) do hookBtn(d) end
        skills.DescendantAdded:Connect(hookBtn)
    end)

    local function getSkillKeyFromArgs(args)
        for _, arg in ipairs(args) do
            if type(arg) == "string" and table.find(SKILL_KEYS, arg) then
                return arg
            end
        end
        return nil
    end

    local function startRenderLoop()
        if not renderConnection then
            renderConnection = RunService.RenderStepped:Connect(function()
                camera = Workspace.CurrentCamera
                if ShowFOVCircle then
                    local center = getFOVCenter(FOVMode)
                    FOVFrame.Position = UDim2.fromOffset(center.X, center.Y)
                    FOVFrame.Size = UDim2.fromOffset(FOVRadius * 2, FOVRadius * 2)
                    FOVFrame.Visible = true
                else
                    FOVFrame.Visible = false
                end
                if SoruShowFOVCircle then
                    local center = getFOVCenter(SoruFOVType)
                    SoruFOVFrame.Position = UDim2.fromOffset(center.X, center.Y)
                    SoruFOVFrame.Size = UDim2.fromOffset(SoruFOVRadius * 2, SoruFOVRadius * 2)
                    SoruFOVFrame.Visible = true
                else
                    SoruFOVFrame.Visible = false
                end
                pcall(function()
                    CurrentTargetPlayer = nil
                    local lpChar = player.Character
                    if not lpChar then return end
                    local lpHRP = lpChar:FindFirstChild("HumanoidRootPart")
                    if not lpHRP then return end
                    if not SilentAimPlayersEnabled and not SilentAimNPCsEnabled then
                        if TracerEnabled and tracerBeam then tracerBeam.Enabled = false end
                        PlayersPosition = nil
                        NPCPosition = nil
                        return
                    end
                    if SilentAimPlayersEnabled then
                        local targetplayer = getClosestplayer(lpHRP)
                        if targetplayer and targetplayer.Character then
                            CurrentTargetPlayer = targetplayer
                            PlayersPosition = predicted(getHRP(targetplayer.Character))
                        else
                            PlayersPosition = nil
                        end
                    else
                        PlayersPosition = nil
                    end
                    if SilentAimNPCsEnabled then
                        local npc = getClosestNPC(lpHRP)
                        if npc then
                            NPCPosition = predicted(getHRP(npc))
                        else
                            NPCPosition = nil
                        end
                    else
                        NPCPosition = nil
                    end
                    if TracerEnabled and tracerBeam and tracerAttachment0 and tracerAttachment1 then
                        local targetPos = PlayersPosition or NPCPosition
                        if lpHRP and targetPos then
                            tracerAttachment0.WorldPosition = lpHRP.Position
                            tracerAttachment1.WorldPosition = targetPos
                            tracerBeam.Enabled = true
                        else
                            tracerBeam.Enabled = false
                        end
                    end
                end)
            end)
        end
        if not heartbeatConnection then
            heartbeatConnection = RunService.Heartbeat:Connect(function()
                if not ZSkillorM1 or (not SilentAimPlayersEnabled and not SilentAimNPCsEnabled) then return end
                if currentSkillKey and isKeyCurrentlyBlacklisted(currentSkillKey) then return end
                if currentTool then
                    local n = string.lower(currentTool.Name)
                    if n:find("portal") or n:find("lightning") then return end
                end
                if not OverrideGodhumanSanguineEnabled then return end
                if not isOverrideTool(currentTool) then return end
                if currentSkillKey ~= "Z" then return end
                local targetPos = PlayersPosition or NPCPosition
                if targetPos then
                    local targetCFrame = CFrame.new(targetPos)
                    pcall(function()
                        mouse.Hit = targetCFrame
                    end)
                end
            end)
        end
    end

    local function stopRenderLoop()
        if renderConnection then renderConnection:Disconnect(); renderConnection = nil end
        if heartbeatConnection then heartbeatConnection:Disconnect(); heartbeatConnection = nil end
        FOVFrame.Visible = false
        SoruFOVFrame.Visible = false
        destroyTracer()
        PlayersPosition = nil
        NPCPosition = nil
        CurrentTargetPlayer = nil
    end

    -- MAIN namecall / index hooks (Nameless exact behavior)
    pcall(function()
        local mt = getrawmetatable(game)
        if not mt then return end
        local oldNamecall = mt.__namecall
        local oldIndex = mt.__index
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local Method = getnamecallmethod()
            local args = {...}
            if args[1] == "TAP" then
                return oldNamecall(self, ...)
            end
            local skillKey = getSkillKeyFromArgs(args)
            if skillKey then
                if SilentAimPlayersEnabled or SilentAimNPCsEnabled then
                    local targetPos = PlayersPosition or NPCPosition
                    if targetPos then
                        task.spawn(function() faceTarget(targetPos) end)
                    end
                end
                setCurrentSkillKey(skillKey)
            end
            -- Soru: only skill C
            if SoruAutoAimEnabled and SoruPredictedPosition and skillKey == "C" then
                for i, arg in ipairs(args) do
                    if typeof(arg) == "Vector3" then
                        args[i] = SoruPredictedPosition
                    end
                end
            end
            local skip = false
            if skillKey and isKeyCurrentlyBlacklisted(skillKey) then
                skip = true
            elseif not skillKey and currentSkillKey and isKeyCurrentlyBlacklisted(currentSkillKey) then
                skip = true
            end
            if not skip then
                if Method == "FireServer" then
                    if typeof(args[1]) == "Vector3" then
                        if SilentAimPlayersEnabled and PlayersPosition then
                            args[1] = PlayersPosition
                        elseif SilentAimNPCsEnabled and NPCPosition then
                            args[1] = NPCPosition
                        end
                    end
                elseif Method == "InvokeServer" and currentTool and currentTool.Name == "Buddy Sword" then
                    if type(args[1]) == "string" and table.find(Skills, args[1]) then
                        if SilentAimPlayersEnabled and PlayersPosition then
                            args[2] = PlayersPosition
                        elseif SilentAimNPCsEnabled and NPCPosition then
                            args[2] = NPCPosition
                        end
                    end
                end
            end
            return oldNamecall(self, unpack(args))
        end)
        mt.__index = newcclosure(function(t, k)
            if SoruAutoAimEnabled and t == mouse and SoruPredictedPosition then
                if k == "Hit" then return CFrame.new(SoruPredictedPosition) end
                if k == "Target" then return SoruCurrentTarget end
            end
            return oldIndex(t, k)
        end)
        setreadonly(mt, true)
    end)

    local function clearConnections()
        for _, c in ipairs(characterConnections) do
            pcall(function() c:Disconnect() end)
        end
        characterConnections = {}
    end

    local function onCharacterAdded(char)
        clearConnections()
        currentTool = nil
        currentToolCategory = "Melee"
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Tool") then
                currentTool = child
                currentToolCategory = getToolCategory(child)
            end
        end
        table.insert(characterConnections, char.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                currentTool = child
                currentToolCategory = getToolCategory(child)
                currentSkillKey = nil
            end
        end))
        table.insert(characterConnections, char.ChildRemoved:Connect(function(child)
            if child == currentTool then
                currentTool = nil
                currentToolCategory = "Melee"
            end
        end))
    end
    player.CharacterAdded:Connect(onCharacterAdded)
    if player.Character then onCharacterAdded(player.Character) end

    function module:SetPlayerSilentAim(state)
        SilentAimPlayersEnabled = state
        if state then startRenderLoop()
        elseif not SilentAimNPCsEnabled then stopRenderLoop() end
    end
    function module:SetNPCSilentAim(state)
        SilentAimNPCsEnabled = state
        if state then startRenderLoop()
        elseif not SilentAimPlayersEnabled then stopRenderLoop() end
    end
    function module:SetBlacklistKey(cat, key, state)
        if BlacklistedKeys[cat] and BlacklistedKeys[cat][key] ~= nil then
            BlacklistedKeys[cat][key] = state
        end
    end
    function module:IsKeyBlacklisted(cat, key)
        return BlacklistedKeys[cat] and BlacklistedKeys[cat][key] or false
    end
    function module:SetAimMode(mode) AimMode = mode end
    function module:SetTargetPriority(prio) TargetPriority = prio end
    function module:SetShowFOVCircle(state) ShowFOVCircle = state end
    function module:SetFOVRadius(num) FOVRadius = num end
    function module:SetFOVMode(mode) FOVMode = mode end
    function module:SetDistanceLimit(num) if type(num) == "number" then maxRange = num end end
    function module:SetSelectedPlayer(playerName)
        if not playerName or playerName == "" or playerName == "None" or playerName == "Nearest" then
            Selectedplayer = nil
            return
        end
        Selectedplayer = Players:FindFirstChild(playerName)
    end
    function module:SetSoruAutoAim(state)
        SoruAutoAimEnabled = state
        if not state then
            SoruCurrentTarget = nil
            SoruPredictedPosition = nil
        end
    end
    function module:SetSoruRange(r) SoruAutoAimRange = r end
    function module:SetSoruAimMode(mode) SoruTargetingMode = mode end
    function module:SetSoruFOVType(mode) SoruFOVType = mode end
    function module:SetSoruFOVRadius(r) SoruFOVRadius = r end
    function module:SetSoruPriority(p) SoruTargetPriority = p end
    function module:SetSoruShowFOVCircle(state) SoruShowFOVCircle = state end
    function module:SetTracerEnabled(state)
        TracerEnabled = state
        if state then createTracer() else destroyTracer() end
    end
    function module:SetTracerColor(color) TracerColor = color; updateTracerColor() end
    function module:GetTargetPos() return PlayersPosition or NPCPosition end
    function module:GetTargetPlayer() return CurrentTargetPlayer end
    function module:IsPlayerSilentAimEnabled() return SilentAimPlayersEnabled end
    -- Enemigos (los mismos que el silent aim consideraría) cuya posición en pantalla cae dentro del círculo del FOV.
    -- Se recalcula como máximo cada 0.1 s para no repetir el chequeo de aliados en cada frame.
    function module:GetFOVEnemies()
        if not SilentAimPlayersEnabled then return {} end
        local now = os.clock()
        if now - fovCacheTime < 0.1 then return fovCache end
        fovCacheTime = now
        local result = {}
        local lpChar = player.Character
        local lpHRP = lpChar and lpChar:FindFirstChild("HumanoidRootPart")
        if lpHRP then
            camera = Workspace.CurrentCamera
            local center = getFOVCenter(FOVMode)
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= player and pl.Character and pl.Character.Parent and isEnemy(pl) then
                    local hum = pl.Character:FindFirstChildWhichIsA("Humanoid")
                    local hrp = getHRP(pl.Character)
                    if hum and hum.Health > 0 and hrp and (hrp.Position - lpHRP.Position).Magnitude <= maxRange then
                        local sp, onScreen = camera:WorldToViewportPoint(hrp.Position)
                        if onScreen and (Vector2.new(sp.X, sp.Y) - center).Magnitude <= FOVRadius then
                            table.insert(result, pl)
                        end
                    end
                end
            end
        end
        fovCache = result
        return result
    end
    function module:GetBlacklist() return BlacklistedKeys end
    return module
end)()

-- Sync from Config
SilentAimModule:SetPlayerSilentAim(Config.SilentPlayer == true)
SilentAimModule:SetNPCSilentAim(Config.SilentNPC == true)
SilentAimModule:SetAimMode(Config.AimMode or "360")
SilentAimModule:SetTargetPriority(Config.AimPriority or "Nearest")
SilentAimModule:SetShowFOVCircle(Config.ShowFOV == true)
SilentAimModule:SetFOVMode(Config.FOVMode or "V1")
SilentAimModule:SetFOVRadius(Config.FOVRadius or 150)
SilentAimModule:SetDistanceLimit(Config.AimMaxRange or 2000)
SilentAimModule:SetSoruAutoAim(Config.SoruAutoAim == true)
SilentAimModule:SetSoruAimMode(Config.SoruAimMode or "360")
SilentAimModule:SetSoruFOVType(Config.SoruFOVType or "V1")
SilentAimModule:SetSoruFOVRadius(Config.SoruFOVRadius or Config.FOVRadius or 150)
SilentAimModule:SetSoruRange(Config.SoruRange or 300)
SilentAimModule:SetSoruPriority(Config.SoruPriority or "Nearest")
SilentAimModule:SetSoruShowFOVCircle(Config.SoruShowFOV == true)

-- Load blacklist from Config
for _, cat in ipairs({"Melee", "Sword", "Fruit", "Gun"}) do
    for _, key in ipairs({"Z", "X", "C", "V", "F", "TAP"}) do
        local ck = "BL_" .. cat .. "_" .. key
        if Config[ck] == true then
            SilentAimModule:SetBlacklistKey(cat, key, true)
        end
    end
end

-- M1 Extender (Nameless style: on click only)
local M1ExtenderMod = (function()
    local M = {}
    local active = false
    local maxRange = 50
    local function getTarget()
        local myChar = lp.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local target, shortestDist = nil, maxRange
        for _, folder in pairs({ Workspace:FindFirstChild("Enemies"), Workspace:FindFirstChild("Characters") }) do
            if folder then
                for _, v in pairs(folder:GetChildren()) do
                    local eRoot = v:FindFirstChild("HumanoidRootPart")
                    local eHum = v:FindFirstChildOfClass("Humanoid")
                    if v ~= myChar and eRoot and eHum and eHum.Health > 0 then
                        local dist = (eRoot.Position - myRoot.Position).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            target = v
                        end
                    end
                end
            end
        end
        return target
    end
    UIS.InputBegan:Connect(function(input, processed)
        if processed or not active then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            local target = getTarget()
            local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
            if target and tool then
                local head = target:FindFirstChild("Head") or target:FindFirstChild("HumanoidRootPart")
                if head then
                    pcall(function()
                        local RA = registerAttack or (Net and Net:FindFirstChild("RE/RegisterAttack"))
                        local RH = registerHit or (Net and Net:FindFirstChild("RE/RegisterHit"))
                        if RA then RA:FireServer() end
                        if RH then
                            local hitData = {}
                            for _, part in pairs(target:GetChildren()) do
                                if part:IsA("BasePart") then
                                    table.insert(hitData, { target, part })
                                end
                            end
                            RH:FireServer(head, hitData)
                        end
                    end)
                end
            end
        end
    end)
    function M:Toggle(v) active = v end
    function M:SetRange(v) maxRange = v end
    return M
end)()
M1ExtenderMod:Toggle(Config.M1Extender == true)
M1ExtenderMod:SetRange(Config.M1Range or 50)

-- Gun Click SL (Nameless)
local GunClickSLMod = (function()
    local enabled = false
    local aimPos = nil
    local hookInstalled = false
    local function getClosestTarget()
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local closest, dist = nil, math.huge
        local myPos = root.Position
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= lp and player.Character then
                local targetPart = player.Character:FindFirstChild("HumanoidRootPart")
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                if targetPart and hum and hum.Health > 0 then
                    local d = (targetPart.Position - myPos).Magnitude
                    if d < dist then
                        dist = d
                        closest = targetPart
                    end
                end
            end
        end
        return closest
    end
    local function installHook()
        if hookInstalled then return end
        hookInstalled = true
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            if enabled and aimPos and method == "FireServer" then
                local remoteName = tostring(self.Name or self)
                if remoteName:find("ShootGun") then
                    if typeof(args[1]) == "Vector3" then
                        args[1] = aimPos.Position
                    end
                    if typeof(args[2]) == "table" then
                        args[2] = { aimPos }
                    end
                    return oldNamecall(self, unpack(args))
                end
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end
    local M = {}
    function M:SetEnabled(state)
        if state == enabled then return end
        enabled = state
        if state then
            aimPos = nil
            installHook()
            task.spawn(function()
                while enabled do
                    aimPos = getClosestTarget()
                    task.wait(0.05)
                end
            end)
        else
            aimPos = nil
        end
    end
    return M
end)()
if Config.GunClickSL then GunClickSLMod:SetEnabled(true) end

-- Compat shims for UI that referenced old SilentAim / Soru / M1Ext tables
local SilentAim = {
    Player = Config.SilentPlayer,
    NPC = Config.SilentNPC,
    AimMode = Config.AimMode or "360",
    Priority = Config.AimPriority or "Nearest",
    ShowFOV = Config.ShowFOV,
    FOVMode = Config.FOVMode or "V1",
    FOVRadius = Config.FOVRadius or 150,
    MaxRange = Config.AimMaxRange or 2000,
}
local Soru = {
    Enabled = Config.SoruAutoAim,
    AimMode = Config.SoruAimMode or "360",
    FOVType = Config.SoruFOVType or "V1",
    Priority = Config.SoruPriority or "Nearest",
    FOVRadius = Config.SoruFOVRadius or 150,
    Range = Config.SoruRange or 300,
    ShowFOV = Config.SoruShowFOV,
}
local M1Ext = { on = Config.M1Extender, range = Config.M1Range or 50 }
local function updateFOVCircle() end
local function updateSoruFOV() end



-- ==================== BYPASS TP NPC (Cestian-style) ====================
local BypassTpConn = nil
local function StartBypassTpNpc()
    if BypassTpConn then return end
    BypassTpConn = task.spawn(function()
        while Config.BypassTpNpc do
            task.wait(0.15)
            pcall(function()
                local char = lp.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local enemies = Workspace:FindFirstChild("Enemies")
                if not enemies then return end
                local range = Config.BypassTpRange or 500
                local mode = Config.BypassTpMode or "Nearest"
                local list = {}
                for _, npc in ipairs(enemies:GetChildren()) do
                    if npc:IsA("Model") then
                        local eRoot = npc:FindFirstChild("HumanoidRootPart")
                        local eHum = npc:FindFirstChildOfClass("Humanoid")
                        if eRoot and eHum and eHum.Health > 0 then
                            local d = (eRoot.Position - hrp.Position).Magnitude
                            if d <= range then
                                table.insert(list, { root = eRoot, dist = d, model = npc })
                            end
                        end
                    end
                end
                if #list == 0 then return end
                table.sort(list, function(a, b) return a.dist < b.dist end)
                if mode == "Nearest" then
                    local t = list[1].root
                    local yOff = Config.BypassTpAbove and (Config.BypassTpHeight or 12) or 3
                    hrp.CFrame = CFrame.new(t.Position + Vector3.new(0, yOff, 0))
                elseif mode == "All in Range" then
                    for _, item in ipairs(list) do
                        pcall(function()
                            item.root.CFrame = hrp.CFrame * CFrame.new(0, -5, -3)
                            item.root.CanCollide = false
                            item.root.AssemblyLinearVelocity = Vector3.zero
                        end)
                    end
                elseif mode == "Bring to Me" then
                    for _, item in ipairs(list) do
                        pcall(function()
                            item.root.CFrame = CFrame.new(hrp.Position + Vector3.new(0, -8, 0))
                            item.root.CanCollide = false
                        end)
                    end
                end
            end)
        end
        BypassTpConn = nil
    end)
end
local function StopBypassTpNpc()
    Config.BypassTpNpc = false
    BypassTpConn = nil
end


-- ==================== POTATO GRAPHICS (Nameless No GFX + Cestian Flags) ====================
local noGfxMode = "Off"
local noGfxConnections = {}
local noGfxModifiedObjects = {}
local hotbarIconsOriginals = {}

local function restoreNoGfx()
    for obj, data in pairs(noGfxModifiedObjects) do
        pcall(function()
            if data.Texture ~= nil then obj.Texture = data.Texture end
            if data.Enabled ~= nil then obj.Enabled = data.Enabled end
        end)
    end
    noGfxModifiedObjects = {}
    for iconLabel, oldImage in pairs(hotbarIconsOriginals) do
        pcall(function() iconLabel.Image = oldImage or "" end)
    end
    hotbarIconsOriginals = {}
    if noGfxConnections.DescendantAdded then
        noGfxConnections.DescendantAdded:Disconnect()
        noGfxConnections.DescendantAdded = nil
    end
    if noGfxConnections.HotbarChildAdded then
        noGfxConnections.HotbarChildAdded:Disconnect()
        noGfxConnections.HotbarChildAdded = nil
    end
end

local function processObject(inst)
    local className = inst.ClassName
    if className == "Beam" or className == "Trail" then
        if not noGfxModifiedObjects[inst] then
            noGfxModifiedObjects[inst] = { Texture = inst.Texture }
            inst.Texture = "rbxassetid://84308155859778"
        end
    elseif className == "ParticleEmitter" then
        if not noGfxModifiedObjects[inst] then
            noGfxModifiedObjects[inst] = { Texture = inst.Texture, Enabled = inst.Enabled }
            inst.Texture = ""
            inst.Enabled = false
        end
    end
end

local function startNoGfxV1()
    restoreNoGfx()
    task.spawn(function()
        local descendants = Workspace:GetDescendants()
        for i = 1, #descendants do
            local inst = descendants[i]
            if not inst:IsA("Terrain") and not inst:IsA("Camera") then
                processObject(inst)
            end
            if i % 100 == 0 then RunService.Heartbeat:Wait() end
        end
    end)
    noGfxConnections.DescendantAdded = Workspace.DescendantAdded:Connect(processObject)
end

local function startNoGfxV2()
    restoreNoGfx()
    task.spawn(function()
        local descendants = Workspace:GetDescendants()
        for i = 1, #descendants do
            local inst = descendants[i]
            if not inst:IsA("Terrain") and not inst:IsA("Camera") then
                processObject(inst)
            end
            if i % 100 == 0 then RunService.Heartbeat:Wait() end
        end
    end)
    noGfxConnections.DescendantAdded = Workspace.DescendantAdded:Connect(processObject)
    task.spawn(function()
        local PlayerGui = lp:WaitForChild("PlayerGui", 10)
        if not PlayerGui then return end
        local Backpack = PlayerGui:FindFirstChild("Backpack") or PlayerGui:WaitForChild("Backpack", 5)
        if not Backpack then return end
        local Hotbar = Backpack:FindFirstChild("Hotbar")
        local HotbarContainer = Hotbar and (Hotbar:FindFirstChild("Container") or Hotbar)
        if not HotbarContainer then return end
        local function updateHotbarIconSilent()
            for _, slot in ipairs(HotbarContainer:GetChildren()) do
                local iconLabel = slot:FindFirstChild("Icon") or slot:FindFirstChild("Image") or slot:FindFirstChildOfClass("ImageLabel")
                if iconLabel and iconLabel:IsA("ImageLabel") then
                    if not hotbarIconsOriginals[iconLabel] then
                        hotbarIconsOriginals[iconLabel] = iconLabel.Image
                    end
                    iconLabel.Image = "rbxassetid://84308155859778"
                    iconLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end
        updateHotbarIconSilent()
        noGfxConnections.HotbarChildAdded = HotbarContainer.ChildAdded:Connect(function()
            task.defer(updateHotbarIconSilent)
        end)
    end)
end

local function setNoGfxMode(mode)
    if mode == noGfxMode then return end
    noGfxMode = mode
    Config.NoGfxMode = mode
    restoreNoGfx()
    if mode == "V1" then startNoGfxV1()
    elseif mode == "V2" then startNoGfxV2()
    end
end

local function hopToJobId(jobId)
    jobId = tostring(jobId or ""):gsub("%s+", "")
    if jobId == "" then return false end
    local ok = pcall(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, lp)
    end)
    return ok
end



-- ==================== MOVEMENT (Nameless-style) ====================
local MovementState = {
    Noclip = false,
    InfiniteJump = false,
    SuperJump = false,
    SuperJumpPower = 100,
    BunnyHop = false,
    NoFallDamage = false,
    DashDistance = false,
    DashLength = 50,
    HipHeight = false,
    HipHeightValue = 2,
}

local noclipConn, jumpConn, bhopConn, fallConn, dashConn, hipConn

local function setNoclipParts(enabled)
    local char = lp.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not enabled
        end
    end
end

local function StartNoclip()
    if noclipConn then return end
    MovementState.Noclip = true
    noclipConn = RunService.Stepped:Connect(function()
        if not MovementState.Noclip then return end
        setNoclipParts(true)
    end)
end
local function StopNoclip()
    MovementState.Noclip = false
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    setNoclipParts(false)
end

local function StartInfiniteJump()
    if jumpConn then return end
    MovementState.InfiniteJump = true
    jumpConn = UIS.JumpRequest:Connect(function()
        if not MovementState.InfiniteJump then return end
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end
local function StopInfiniteJump()
    MovementState.InfiniteJump = false
    if jumpConn then jumpConn:Disconnect() jumpConn = nil end
end

local function StartSuperJump()
    if not MovementState.SuperJump then return end
    -- apply on jump
end

-- Super jump via state change
do
    local sjConn
    local function ensureSJ()
        if sjConn then return end
        sjConn = RunService.Heartbeat:Connect(function()
            if not MovementState.SuperJump then return end
            local char = lp.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp then return end
            if hum.Jump and hum:GetState() == Enum.HumanoidStateType.Jumping then
                local v = hrp.AssemblyLinearVelocity
                if v.Y > 0 and v.Y < MovementState.SuperJumpPower then
                    hrp.AssemblyLinearVelocity = Vector3.new(v.X, MovementState.SuperJumpPower, v.Z)
                end
            end
        end)
    end
    ensureSJ()
end

local function StartBunnyHop()
    if bhopConn then return end
    MovementState.BunnyHop = true
    bhopConn = RunService.Heartbeat:Connect(function()
        if not MovementState.BunnyHop then return end
        local char = lp.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end
        if hum.FloorMaterial ~= Enum.Material.Air then
            hum.Jump = true
            local md = hum.MoveDirection
            if md.Magnitude > 0.1 then
                local speed = math.max(hum.WalkSpeed, Config.SpeedValue or 50)
                hrp.AssemblyLinearVelocity = Vector3.new(md.X * speed * 1.2, hrp.AssemblyLinearVelocity.Y, md.Z * speed * 1.2)
            end
        end
    end)
end
local function StopBunnyHop()
    MovementState.BunnyHop = false
    if bhopConn then bhopConn:Disconnect() bhopConn = nil end
end

local function StartNoFall()
    if fallConn then return end
    MovementState.NoFallDamage = true
    fallConn = RunService.Heartbeat:Connect(function()
        if not MovementState.NoFallDamage then return end
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            if hum:GetState() == Enum.HumanoidStateType.Freefall then
                -- prevent death by fall
            end
        end
        local char = lp.Character
        if char then
            local fd = char:FindFirstChild("FallDamage") or char:FindFirstChild("Falling")
            -- Blox Fruits uses attribute sometimes
            pcall(function() char:SetAttribute("FallDamage", 0) end)
        end
    end)
end
local function StopNoFall()
    MovementState.NoFallDamage = false
    if fallConn then fallConn:Disconnect() fallConn = nil end
end

local function StartDashDistance()
    if dashConn then return end
    MovementState.DashDistance = true
    dashConn = RunService.Heartbeat:Connect(function()
        if not MovementState.DashDistance then return end
        local char = lp.Character
        if not char then return end
        -- Blox Fruits dash attributes
        pcall(function()
            char:SetAttribute("DashLength", MovementState.DashLength)
            char:SetAttribute("DashDistance", MovementState.DashLength)
            char:SetAttribute("SoruLength", MovementState.DashLength)
        end)
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function()
                hum:SetAttribute("DashLength", MovementState.DashLength)
            end)
        end
    end)
end
local function StopDashDistance()
    MovementState.DashDistance = false
    if dashConn then dashConn:Disconnect() dashConn = nil end
end

local function StartHipHeight()
    if hipConn then return end
    MovementState.HipHeight = true
    hipConn = RunService.Heartbeat:Connect(function()
        if not MovementState.HipHeight then return end
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.HipHeight = MovementState.HipHeightValue
        end
    end)
end
local function StopHipHeight()
    MovementState.HipHeight = false
    if hipConn then hipConn:Disconnect() hipConn = nil end
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.HipHeight = 2 end
end

-- ==================== FAST FLAGS (Cestian-style) ====================
-- Sets como Supremacy Fps tab: FF1 / FF2 / FF3
local FastFlagSets = {
    [1] = { -- Performance / FPS
        {"DFIntTaskSchedulerTargetFps", "9999"},
        {"FFlagTaskSchedulerLimitTargetFpsTo2402", "False"},
        {"FFlagDebugGraphicsPreferVulkan", "True"},
        {"FFlagDebugGraphicsDisableDirect3D11", "True"},
        {"DFIntTextureQualityOverride", "1"},
        {"DFIntTextureCompositorActiveJobs", "1"},
        {"FFlagDisablePostFx", "True"},
        {"FIntRenderShadowIntensity", "0"},
        {"DFIntDebugFRMQualityLevelOverride", "1"},
        {"FFlagCommitToGraphicsQualityLevels", "True"},
        {"FFlagDebugSkyGray", "True"},
        {"FFlagDisableNewLightAttenuation", "True"},
    },
    [2] = { -- Network / Latency
        {"DFIntConnectionMTUSize", "1492"},
        {"DFIntHttpCurlConnectionCacheSize", "134217728"},
        {"DFIntMaxFrameBufferSize", "4"},
        {"DFIntMaxInterpolationPathLength", "1"},
        {"DFIntTimestepArbiterThresholdInTicks", "1"},
        {"FFlagSimDefaultPrimalSolver", "True"},
        {"DFIntS2PhysicsSenderRate", "15"},
        {"DFIntPhysicsSenderMaxBandwidthBps", "1000000"},
    },
    [3] = { -- Extra potato
        {"FFlagHandleAltEnterFullscreenManually", "False"},
        {"FFlagFixPlayerCollisionWhenSwimming", "False"},
        {"DFIntAnimationLodFacsDistanceMin", "0"},
        {"DFIntAnimationLodFacsDistanceMax", "0"},
        {"DFIntAnimationLodFacsMinVisSize", "0"},
        {"FFlagEnableInGameMenuChromeABTest3", "False"},
        {"FFlagEnableInGameMenuChromeABTest4", "False"},
        {"FFlagEnableInGameMenuModernization", "False"},
        {"FFlagUserShowGuiHideToggles", "True"},
    },
}

local function InjectFastFlags(setId)
    setId = setId or 1
    local list = FastFlagSets[setId] or FastFlagSets[1]
    local injected, failed = 0, 0
    local function trySet(name, value)
        local ok = false
        if typeof(setfflag) == "function" then
            ok = pcall(setfflag, name, tostring(value))
        end
        if not ok and typeof(setflag) == "function" then
            ok = pcall(setflag, name, tostring(value))
        end
        -- algunos executors: game:DefineFastFlag / SetFastFlag
        if not ok then
            ok = pcall(function()
                if getgenv and getgenv().setfflag then
                    getgenv().setfflag(name, tostring(value))
                end
            end)
        end
        return ok
    end
    for _, pair in ipairs(list) do
        if trySet(pair[1], pair[2]) then
            injected = injected + 1
        else
            failed = failed + 1
        end
    end
    pcall(function()
        if setfpscap then setfpscap(999) end
    end)
    return injected, failed
end


-- ==================== ESP SYSTEM ====================
local TracerBeams = {}

local function IsEnemy(player)
    if player == lp then return false end
    local myTeam = lp.Team
    local targetTeam = player.Team
    if not myTeam or not targetTeam then return true end
    if myTeam.Name == "Pirates" and targetTeam.Name == "Pirates" then return false end
    if myTeam.Name == "Marines" and targetTeam.Name == "Marines" then return false end
    return true
end

local function GetESPColor(player)
    if IsEnemy(player) then
        return Color3.fromRGB(255, 0, 0)
    else
        return Color3.fromRGB(0, 255, 0)
    end
end

local function CreateTracer(player)
    if not player or not player.Character then return end
    if TracerBeams[player] then return end
    local myChar = lp.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    local character = player.Character
    local targetHRP = character:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = myHRP
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = targetHRP
    local beam = Instance.new("Beam")
    beam.Attachment0 = attachment0
    beam.Attachment1 = attachment1
    beam.Color = ColorSequence.new(GetESPColor(player))
    beam.Transparency = NumberSequence.new(0.5)
    beam.Width0 = 2
    beam.Width1 = 2
    beam.Parent = workspace
    TracerBeams[player] = {
        Beam = beam,
        Attachment0 = attachment0,
        Attachment1 = attachment1
    }
end

local function UpdateTracers()
    if not Config.Tracers then
        for player, obj in pairs(TracerBeams) do
            if obj then
                pcall(function()
                    obj.Beam:Destroy()
                    obj.Attachment0:Destroy()
                    obj.Attachment1:Destroy()
                end)
            end
        end
        TracerBeams = {}
        return
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= lp then
            local char = player.Character
            if char then
                if not TracerBeams[player] then
                    CreateTracer(player)
                end
            end
        end
    end
end


-- ═══════════════════════════════════════════════════════════
-- ESP 2D (nombre, HP, barra de vida, distancia, caja, arma, chams)
-- + SILENT AIM FOV TRACER (línea roja a los enemigos dentro del FOV)
-- Todo se dibuja en una ScreenGui propia, siempre visible a través de paredes.
-- ═══════════════════════════════════════════════════════════
do
    -- Si el script se ejecuta dos veces, limpiar lo anterior
    pcall(function()
        if getgenv and getgenv().__BragaoESPConn then
            getgenv().__BragaoESPConn:Disconnect()
            getgenv().__BragaoESPConn = nil
        end
    end)
    pcall(function()
        local host = (gethui and gethui()) or CoreGui
        local old = host:FindFirstChild("Bragao_ESP")
        if old then old:Destroy() end
    end)

    local ESPGui = Instance.new("ScreenGui")
    ESPGui.Name = "Bragao_ESP"
    ESPGui.ResetOnSpawn = false
    ESPGui.IgnoreGuiInset = true
    ESPGui.DisplayOrder = 5
    ESPGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function()
        if syn and syn.protect_gui then syn.protect_gui(ESPGui) end
    end)
    ESPGui.Parent = (gethui and gethui()) or CoreGui

    local RED = Color3.fromRGB(255, 0, 0)
    local espData = {}   -- [Player] = { Box, Stroke, BarBG, BarFill, Name, Info, Chams }
    local saLines = {}   -- [Player] = Frame (línea roja del silent aim)

    -- ---------- helpers ----------
    local function newText(size, bold)
        local t = Instance.new("TextLabel")
        t.BackgroundTransparency = 1
        t.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
        t.TextSize = size
        t.TextStrokeTransparency = 0.35
        t.TextColor3 = Color3.new(1, 1, 1)
        t.Size = UDim2.fromOffset(220, size + 2)
        t.AnchorPoint = Vector2.new(0.5, 0)
        t.Visible = false
        t.Parent = ESPGui
        return t
    end

    local function createESP(pl)
        local o = {}
        o.Box = Instance.new("Frame")
        o.Box.BackgroundTransparency = 1
        o.Box.BorderSizePixel = 0
        o.Box.Visible = false
        o.Box.Parent = ESPGui
        o.Stroke = Instance.new("UIStroke")
        o.Stroke.Thickness = 1.5
        o.Stroke.Parent = o.Box

        o.BarBG = Instance.new("Frame")
        o.BarBG.BackgroundColor3 = Color3.new(0, 0, 0)
        o.BarBG.BackgroundTransparency = 0.3
        o.BarBG.BorderSizePixel = 0
        o.BarBG.Visible = false
        o.BarBG.Parent = ESPGui
        o.BarFill = Instance.new("Frame")
        o.BarFill.BorderSizePixel = 0
        o.BarFill.AnchorPoint = Vector2.new(0, 1)
        o.BarFill.Position = UDim2.new(0, 0, 1, 0)
        o.BarFill.Size = UDim2.new(1, 0, 1, 0)
        o.BarFill.Parent = o.BarBG

        o.Name = newText(13, true)
        o.Info = newText(12, false)
        espData[pl] = o
        return o
    end

    local function hideESP(o)
        o.Box.Visible = false
        o.BarBG.Visible = false
        o.Name.Visible = false
        o.Info.Visible = false
    end

    local function setChams(o, char, on, color)
        if on and char then
            if not o.Chams then
                local h = Instance.new("Highlight")
                h.FillTransparency = 0.6
                h.OutlineTransparency = 0
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                h.Parent = ESPGui
                o.Chams = h
            end
            o.Chams.Adornee = char
            o.Chams.FillColor = color
            o.Chams.OutlineColor = color
            o.Chams.Enabled = true
        elseif o.Chams then
            o.Chams.Enabled = false
        end
    end

    local function destroyESP(pl)
        local o = espData[pl]
        if o then
            for _, k in ipairs({ "Box", "BarBG", "Name", "Info", "Chams" }) do
                if o[k] then pcall(function() o[k]:Destroy() end) end
            end
            espData[pl] = nil
        end
        local f = saLines[pl]
        if f then
            pcall(function() f:Destroy() end)
            saLines[pl] = nil
        end
    end

    -- ---------- ESP 2D ----------
    local function updateESP(cam, myHRP)
        local on = Config.ESP == true
        local range = Config.ESPRange or 1000
        local textSize = Config.ESPTextSize or 13

        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= lp then
                local o = espData[pl]
                local char = pl.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local alive = on and hum ~= nil and hrp ~= nil and hum.Health > 0

                local dist = 0
                if alive and myHRP then
                    dist = (hrp.Position - myHRP.Position).Magnitude
                    if dist > range then alive = false end
                end

                if not alive then
                    if o then
                        hideESP(o)
                        setChams(o, nil, false)
                    end
                else
                    o = o or createESP(pl)
                    local color = GetESPColor(pl)
                    setChams(o, char, Config.ESPChams == true, color)

                    local topV = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
                    local botV = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.2, 0))
                    if topV.Z <= 0 or botV.Z <= 0 then
                        hideESP(o)
                    else
                        local h = math.max(botV.Y - topV.Y, 6)
                        local w = h * 0.6
                        local cx = topV.X
                        local x, y = cx - w / 2, topV.Y

                        -- caja
                        o.Box.Visible = Config.ESPBox == true
                        o.Box.Position = UDim2.fromOffset(x, y)
                        o.Box.Size = UDim2.fromOffset(w, h)
                        o.Stroke.Color = color

                        -- barra de vida
                        local maxHp = math.max(hum.MaxHealth, 1)
                        local ratio = math.clamp(hum.Health / maxHp, 0, 1)
                        o.BarBG.Visible = Config.ESPHealthBar == true
                        o.BarBG.Position = UDim2.fromOffset(x - 6, y)
                        o.BarBG.Size = UDim2.fromOffset(3, h)
                        o.BarFill.Size = UDim2.new(1, 0, ratio, 0)
                        o.BarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(0, 255, 0), ratio)

                        -- nombre
                        o.Name.TextSize = textSize
                        o.Name.TextColor3 = color
                        o.Name.Text = pl.Name
                        o.Name.Position = UDim2.fromOffset(cx, y - textSize - 4)
                        o.Name.Visible = Config.ESPName == true

                        -- línea de info: HP | distancia | arma
                        local parts = {}
                        if Config.ESPHealth then
                            parts[#parts + 1] = "HP " .. math.floor(hum.Health) .. "/" .. math.floor(maxHp)
                        end
                        if Config.ESPDistance then
                            parts[#parts + 1] = math.floor(dist) .. "m"
                        end
                        if Config.ESPTool then
                            local tool = char:FindFirstChildOfClass("Tool")
                            if tool then parts[#parts + 1] = tool.Name end
                        end
                        if #parts > 0 then
                            o.Info.TextSize = textSize - 1
                            o.Info.Text = table.concat(parts, " | ")
                            o.Info.Position = UDim2.fromOffset(cx, y + h + 2)
                            o.Info.Visible = true
                        else
                            o.Info.Visible = false
                        end
                    end
                end
            end
        end
    end

    -- ---------- Silent Aim FOV Tracer ----------
    local saLabel = newText(14, true)
    saLabel.Text = "[ SILENT AIM ]"
    saLabel.TextColor3 = RED
    saLabel.ZIndex = 4

    local function newLine()
        local f = Instance.new("Frame")
        f.BorderSizePixel = 0
        f.AnchorPoint = Vector2.new(0.5, 0.5)
        f.BackgroundColor3 = RED
        f.Visible = false
        f.Parent = ESPGui
        return f
    end

    local function drawLine(f, a, b, thickness)
        local d = b - a
        local len = d.Magnitude
        if len < 1 then
            f.Visible = false
            return
        end
        f.Size = UDim2.fromOffset(len, thickness)
        f.Position = UDim2.fromOffset((a.X + b.X) / 2, (a.Y + b.Y) / 2)
        f.Rotation = math.deg(math.atan2(d.Y, d.X))
        f.Visible = true
    end

    -- Punto en pantalla; si está detrás de la cámara lo manda al borde para que la línea siga apuntando bien
    local function screenPoint(cam, pos, vs)
        local v = cam:WorldToViewportPoint(pos)
        local p = Vector2.new(v.X, v.Y)
        if v.Z <= 0 then
            local c = vs / 2
            local dir = c - p
            if dir.Magnitude < 1 then dir = Vector2.new(0, 1) end
            p = c + dir.Unit * vs.Magnitude
            p = Vector2.new(math.clamp(p.X, 0, vs.X), math.clamp(p.Y, 0, vs.Y))
        end
        return p, v.Z > 0
    end

    local function updateSATracers(cam, myHRP)
        local want = {} -- [Player] = true si es el objetivo real del silent aim, false si solo está en el FOV
        if Config.SATracer and myHRP and SilentAimModule:IsPlayerSilentAimEnabled() then
            if Config.SATracerAll then
                for _, pl in ipairs(SilentAimModule:GetFOVEnemies()) do
                    want[pl] = false
                end
            end
            local target = SilentAimModule:GetTargetPlayer()
            if target then want[target] = true end
        end

        local vs = cam.ViewportSize
        local startP, startOk = screenPoint(cam, myHRP and myHRP.Position or Vector3.zero, vs)
        if not myHRP or not startOk then
            startP = Vector2.new(vs.X / 2, vs.Y)
        end

        local drawn = {}
        local labelPos = nil
        for pl, isTarget in pairs(want) do
            local char = pl.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local f = saLines[pl]
                if not f then
                    f = newLine()
                    saLines[pl] = f
                end
                local p, inFront = screenPoint(cam, hrp.Position, vs)
                drawLine(f, startP, p, isTarget and 3 or 1.5)
                f.BackgroundTransparency = isTarget and 0 or 0.45
                f.ZIndex = isTarget and 3 or 2
                drawn[pl] = true
                if isTarget and inFront then labelPos = p end
            end
        end

        for pl, f in pairs(saLines) do
            if not drawn[pl] then f.Visible = false end
        end

        if labelPos then
            saLabel.Position = UDim2.fromOffset(labelPos.X, labelPos.Y - 56)
            saLabel.Visible = true
        else
            saLabel.Visible = false
        end
    end

    Players.PlayerRemoving:Connect(destroyESP)

    local conn = RunService.RenderStepped:Connect(function()
        pcall(function()
            local cam = Workspace.CurrentCamera
            if not cam then return end
            local myChar = lp.Character
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            updateESP(cam, myHRP)
            updateSATracers(cam, myHRP)
        end)
    end)
    pcall(function()
        if getgenv then getgenv().__BragaoESPConn = conn end
    end)
end

Players.PlayerRemoving:Connect(function(player)
    if TracerBeams[player] then
        pcall(function()
            TracerBeams[player].Beam:Destroy()
            TracerBeams[player].Attachment0:Destroy()
            TracerBeams[player].Attachment1:Destroy()
        end)
        TracerBeams[player] = nil
    end
end)

RunService.Heartbeat:Connect(function()
    UpdateTracers()
end)

-- ==================== UI ====================
-- Tema tipo Onyx: grafito casi negro, textos blancos, acentos grises
do
    -- Imágenes de fondo (4EVR)
    BragaoUI.themeImages = {
        { name = "Bragao Hub", key = "main", id = tostring(BRAGAO_BG_ID or "80687556099311"):match("%d+") or "139086303945721", cascade = true },
        { name = "Tema 1", key = "t1", id = "117499714135455" },
        { name = "Tema 2", key = "t2", id = "139086303945721" },
        { name = "Personalizado", key = "custom" },
        { name = "GitHub (wia)", key = "wia", url = "https://raw.githubusercontent.com/7braga/png./main/wia.png" },
    }
    -- Valor inicial para crear la ventana (siempre un rbxassetid válido); la imagen real se resuelve después
    function BragaoUI.bgString()
        local d = BragaoUI.themeImages[Config.UI_Theme]
        if not d or not d.id then d = BragaoUI.themeImages[1] end
        return "rbxassetid://" .. d.id
    end
    function BragaoUI.bgTransparency()
        local vis = Config.UI_BgOn and math.clamp(tonumber(Config.UI_BgVisible) or 55, 0, 100) / 100 or 0
        return 1 - vis
    end

    -- Colores guardados -> tema
    local function toHex(c)
        return string.format("#%02x%02x%02x", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
    end
    local function fromHex(h, fb)
        local okc, c = pcall(Color3.fromHex, h)
        if okc and typeof(c) == "Color3" then return c end
        return fb
    end
    BragaoUI.toHex = toHex
    BragaoUI.uiDefaults = {
        UI_ColBg = "#161619", UI_ColCard = "#18181b", UI_ColText = "#ffffff", UI_ColMuted = "#a1a1aa",
        UI_ColAccent = "#ffffff", UI_ColButton = "#3f3f46", UI_ColIcon = "#d4d4d8", UI_ColBorder = "#ffffff",
    }
    function BragaoUI.col(key)
        return fromHex(Config[key], fromHex(BragaoUI.uiDefaults[key] or "#ffffff", Color3.new(1, 1, 1)))
    end
    function BragaoUI.buildTheme()
        local bg, accent, text = BragaoUI.col("UI_ColBg"), BragaoUI.col("UI_ColAccent"), BragaoUI.col("UI_ColText")
        local black, white = Color3.new(0, 0, 0), Color3.new(1, 1, 1)
        return {
            Name = "Bragao",
            Background = WindUI:Gradient({
                ["0"] = { Color = bg, Transparency = 0.12 },
                ["100"] = { Color = bg, Transparency = 0.12 },
            }, { Rotation = 90 }),
            Accent = WindUI:Gradient({
                ["0"] = { Color = bg:Lerp(black, 0.3), Transparency = 0 },
                ["100"] = { Color = bg:Lerp(white, 0.1), Transparency = 0 },
            }, { Rotation = 90 }),
            Dialog = bg:Lerp(black, 0.1),
            Outline = BragaoUI.col("UI_ColBorder"),
            Text = text,
            Placeholder = BragaoUI.col("UI_ColMuted"),
            Button = BragaoUI.col("UI_ColButton"),
            Icon = BragaoUI.col("UI_ColIcon"),
            Toggle = accent,
            Slider = accent,
            Checkbox = accent,
            SliderIcon = Color3.fromHex("#71717a"),
            Primary = text,
            PanelBackground = Color3.fromHex("#ffffff"),
            PanelBackgroundTransparency = 0.94,
            LabelBackground = Color3.fromHex("#000000"),
            LabelBackgroundTransparency = 0.8,
            ElementBackground = BragaoUI.col("UI_ColCard"),
            ElementBackgroundTransparency = math.clamp((tonumber(Config.UI_CardAlpha) or 30) / 100, 0, 0.95),
        }
    end
    local ok = pcall(function() WindUI:AddTheme(BragaoUI.buildTheme()) end)
    BragaoUI.themeName = ok and "Bragao" or "Dark"

    -- Aplica los colores en vivo (con debounce para no saturar al arrastrar el picker)
    function BragaoUI.applyTheme()
        if BragaoUI.themeName ~= "Bragao" then return end
        pcall(function()
            local t = WindUI:GetThemes().Bragao
            for k, v in pairs(BragaoUI.buildTheme()) do t[k] = v end
            WindUI:SetTheme("Bragao")
        end)
    end
    local pendingApply = false
    function BragaoUI.queueApply()
        if pendingApply then return end
        pendingApply = true
        task.delay(0.15, function()
            pendingApply = false
            BragaoUI.applyTheme()
            save()
        end)
    end
    local vs = (Workspace.CurrentCamera and Workspace.CurrentCamera.ViewportSize) or Vector2.new(1920, 1080)
    BragaoUI.windowSize = UDim2.fromOffset(math.max(560, math.min(850, vs.X - 24)), math.max(350, math.min(560, vs.Y - 24)))
end

local Window = WindUI:CreateWindow({
    Title = "Bragao Hub",
    Icon = "star",
    Theme = BragaoUI.themeName,
    Size = BragaoUI.windowSize,
    MaxSize = Vector2.new(850, 560),
    Resizable = true,
    Transparent = true,
    Background = BragaoUI.bgString(),
    BackgroundImageTransparency = BragaoUI.bgTransparency(),
    Acrylic = false,
    ShadowTransparency = 0.3,
    Radius = 18,
    SideBarWidth = 185,
    HideSearchBar = false,
    Topbar = { Height = 56, ButtonsType = "Default" },
    User = { Enabled = false, Anonymous = false },
})

pcall(function()
    Window:EditOpenButton({
        Title = "Bragao",
        Icon = "star",
        CornerRadius = UDim.new(0, 16),
        StrokeThickness = 2,
        Color = ColorSequence.new(Color3.fromHex("#2a2a32"), Color3.fromHex("#c9c9d4")),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    })
end)

-- ==================== FONDO (imagen) ====================
BragaoUI.bgCurrent = BragaoUI.bgString()
BragaoUI.imgCache = {}

local function normAsset(str)
    str = tostring(str or "")
    local n = str:match("rbxassetid://(%d+)") or str:match("[?&][iI][dD]=(%d+)")
    return n and ("rbxassetid://" .. n) or str
end

-- Devuelve un valor usable en ImageLabel.Image para el tema indicado:
-- 1) URL propia (GitHub raw...): se descarga y se usa getcustomasset
-- 2) ID de Roblox: si es un Decal se convierte a su imagen real (Decal.Texture)
function BragaoUI.resolveImage(entry)
    -- Método directo (igual que el script de referencia): Image asset -> rbxassetid://ID, sin conversiones
    if entry.direct then return "rbxassetid://" .. entry.id end
    local url = (entry.key == "custom") and Config.UI_CustomUrl or entry.url
    local cacheKey = entry.key .. "|" .. tostring(url or entry.id)
    if BragaoUI.imgCache[cacheKey] then return BragaoUI.imgCache[cacheKey] end
    local result
    if url and url ~= "" then
        pcall(function()
            if not (writefile and getcustomasset) then return end
            if makefolder and isfolder and not isfolder("BragaoHub") then makefolder("BragaoHub") end
            local path = "BragaoHub/bg_" .. entry.key .. ".img"
            local okDl, body = pcall(function() return game:HttpGet(url) end)
            if okDl and type(body) == "string" and #body > 100 then writefile(path, body) end
            if isfile and isfile(path) then result = getcustomasset(path) end
        end)
    end
    if not result and entry.id then
        pcall(function()
            local objs = game:GetObjects("rbxassetid://" .. entry.id)
            local o = objs and objs[1]
            if o then
                if (o:IsA("Decal") or o:IsA("Texture")) and o.Texture ~= "" then
                    result = normAsset(o.Texture)
                elseif o:IsA("ImageLabel") or o:IsA("ImageButton") then
                    result = normAsset(o.Image)
                end
                pcall(function() o:Destroy() end)
            end
        end)
        if not result then result = "rbxassetid://" .. entry.id end
    end
    if result then BragaoUI.imgCache[cacheKey] = result end
    return result
end

-- Candidatos para un ID: imagen real del Decal, ID directo y ID-1 (los Decals suelen ser la imagen +1)
function BragaoUI.candidates(entry)
    local list, seen = {}, {}
    local function add(v) if v and not seen[v] then seen[v] = true table.insert(list, v) end end
    add(BragaoUI.resolveImage(entry))
    add("rbxassetid://" .. entry.id)
    local n = tonumber(entry.id)
    if n then add(string.format("rbxassetid://%.0f", n - 1)) end
    return list
end

function BragaoUI.findBg()
    if BragaoUI.bgLabel and BragaoUI.bgLabel.Parent then return BragaoUI.bgLabel end
    local found
    pcall(function()
        for _, d in ipairs(Window.UIElements.Main:GetDescendants()) do
            if d:IsA("ImageLabel") and d.Image == BragaoUI.bgCurrent then found = d break end
        end
    end)
    BragaoUI.bgLabel = found
    return found
end

function BragaoUI.applyBackground(silent)
    local tr = BragaoUI.bgTransparency()
    local entry = BragaoUI.themeImages[Config.UI_Theme] or BragaoUI.themeImages[1]
    pcall(function() Window.BackgroundImageTransparency = tr end) -- para que al reabrir mantenga el valor
    local lbl = BragaoUI.findBg()
    if lbl then lbl.ImageTransparency = tr end
    if not Config.UI_BgOn then return end
    task.spawn(function()
        local img = BragaoUI.resolveImage(entry)
        if not img then
            if not silent then Notify("Bragao Hub", "No se pudo cargar la imagen (revisa la URL o si tu executor tiene getcustomasset)", 4) end
            return
        end
        local l = BragaoUI.findBg()
        if l and entry.cascade then
            local okImg
            for _, c in ipairs(BragaoUI.candidates(entry)) do
                l.Image = c
                l.ImageTransparency = BragaoUI.bgTransparency()
                local t0 = os.clock()
                repeat task.wait(0.1) until l.IsLoaded or os.clock() - t0 > 3
                if l.IsLoaded then okImg = c break end
            end
            if okImg then img = okImg
            elseif not silent then Notify("Bragao Hub", "El ID no cargó como imagen. Sube tu imagen como Image (no Decal) y usa ese ID", 5) end
            BragaoUI.bgLabel = l
        elseif l then
            l.Image = img
            l.ImageTransparency = BragaoUI.bgTransparency()
            BragaoUI.bgLabel = l
        else
            pcall(function() Window:SetBackgroundImage(img) end)
            pcall(function() Window:SetBackgroundImageTransparency(BragaoUI.bgTransparency()) end)
        end
        BragaoUI.bgCurrent = img
    end)
end
task.delay(1, function() BragaoUI.applyBackground(true) end)

-- ==================== SONIDOS DE LA UI (click / toggle) ====================
BragaoUI.sfxIds = { click = 139800881181209, toggle = 136108770017536, error = 131039887376992 }
BragaoUI.sfxVol = { click = 0.65, toggle = 0.6, error = 0.55 }
BragaoUI.sfxReady = false
BragaoUI.sfx = {}

function BragaoUI.playSfx(name)
    if not BragaoUI.sfxReady or not Config.UISounds then return end
    local id = BragaoUI.sfxIds[name]
    if not id then return end
    pcall(function()
        local folder = SoundService:FindFirstChild("BragaoSFX")
        if not folder then
            folder = Instance.new("Folder")
            folder.Name = "BragaoSFX"
            folder.Parent = SoundService
        end
        local s = BragaoUI.sfx[name]
        if not s or not s.Parent then
            s = Instance.new("Sound")
            s.Name = name
            s.SoundId = string.format("rbxassetid://%.0f", id)
            s.Volume = BragaoUI.sfxVol[name] or 0.5
            s.Parent = folder
            BragaoUI.sfx[name] = s
        end
        s.TimePosition = 0
        s:Play()
    end)
end
-- evita que suene todo al cargar la UI
task.delay(2, function() BragaoUI.sfxReady = true end)

-- Envolver Window:Tab para: grupos plegables (Tab:Sec), sonido en toggles/botones y registro de toggles (botones flotantes)
-- Uso: Tab:Sec({ Title = "...", Desc = "...", Icon = "...", Opened = true }) -> todo lo que se cree después va dentro de ese grupo.
do
    local origTab = Window.Tab
    local ELEMENTS = { "Toggle", "Button", "Slider", "Dropdown", "Paragraph", "Input", "Keybind", "Colorpicker", "Divider", "Space", "Image", "Code" }
    Window.Tab = function(self, cfg)
        local tab = origTab(self, cfg)
        if type(tab) ~= "table" then return tab end

        local origSection = tab.Section
        local base, cur = {}, nil
        for _, name in ipairs(ELEMENTS) do
            if type(tab[name]) == "function" then base[name] = tab[name] end
        end

        function tab.Sec(selfT, scfg)
            scfg = scfg or {}
            if scfg.Opened == nil then scfg.Opened = true end
            if scfg.Box == nil then scfg.Box = true end
            if scfg.BoxBorder == nil then scfg.BoxBorder = true end
            cur = nil
            if type(origSection) ~= "function" then return nil end
            local ok, sec = pcall(origSection, tab, scfg)
            if (not ok or type(sec) ~= "table") and scfg.Icon then
                scfg.Icon = nil
                ok, sec = pcall(origSection, tab, scfg)
            end
            if ok and type(sec) == "table" then cur = sec end
            return cur
        end
        function tab.EndSec() cur = nil end

        for name, fn in pairs(base) do
            tab[name] = function(selfT, ecfg)
                local title
                if type(ecfg) == "table" then
                    if name == "Toggle" then
                        title = ecfg.Title
                        local cb = ecfg.Callback
                        BragaoUI.states[title] = ecfg.Value == true
                        local wrapped = function(v, ...)
                            BragaoUI.states[title] = (v == true)
                            BragaoUI.playSfx("toggle")
                            if BragaoUI.refresh then BragaoUI.refresh(title) end
                            if cb then return cb(v, ...) end
                        end
                        ecfg.Callback = wrapped
                        BragaoUI.callbacks[title] = BragaoUI.callbacks[title] or {}
                        table.insert(BragaoUI.callbacks[title], wrapped)
                    elseif name == "Button" then
                        local cb = ecfg.Callback
                        ecfg.Callback = function(...)
                            BragaoUI.playSfx("click")
                            if cb then return cb(...) end
                        end
                    end
                end
                local el
                if cur and type(cur[name]) == "function" then
                    el = cur[name](cur, ecfg)
                else
                    el = fn(tab, ecfg)
                end
                if name == "Toggle" and title then
                    BragaoUI.elements[title] = BragaoUI.elements[title] or {}
                    table.insert(BragaoUI.elements[title], el)
                end
                return el
            end
        end
        return tab
    end
end

local Main = Window:Tab({ Title = "Main", Icon = "home" })
Main:Sec({ Title = "Fast Attack", Icon = "zap", Desc = "Ataque rápido a jugadores y NPCs" })
Main:Toggle({ Title = "Fast Attack", Value = Config.FastAttack, Callback = function(v) Config.FastAttack = v; save() end })
Main:Toggle({ Title = "Attack Players", Value = Config.FAPlayers, Callback = function(v) Config.FAPlayers = v; save() end })
Main:Toggle({ Title = "Attack NPCs", Value = Config.FAMobs, Callback = function(v) Config.FAMobs = v; save() end })
Main:Slider({ Title = "FA Range", Step = 50, Value = { Min = 50, Max = 5000, Default = Config.FARange }, Callback = function(v) Config.FARange = v; save() end })
Main:Sec({ Title = "Bring Mobs", Icon = "magnet", Desc = "Traer mobs hacia ti" })
Main:Toggle({ Title = "Bring Mobs", Value = Config.BringMobs, Callback = function(v) Config.BringMobs = v; save() end })
Main:Slider({ Title = "Bring Range", Step = 50, Value = { Min = 50, Max = 5000, Default = Config.BringRange }, Callback = function(v) Config.BringRange = v; save() end })

local GunAura = Window:Tab({ Title = "Gun Aura", Icon = "crosshair" })
GunAura:Sec({ Title = "Gun Aura Safe", Icon = "shield", Desc = "Versión segura" })
GunAura:Toggle({ Title = "Gun Aura Safe", Value = Config.SafeGun, Callback = function(v)
    Config.SafeGun = v
    _cachedToolSafe = nil
    _cachedTargetSafe = nil
    save()
end })
GunAura:Toggle({ Title = "Safe Mobs", Value = Config.SafeMobs, Callback = function(v) Config.SafeMobs = v; save() end })
GunAura:Toggle({ Title = "Safe Players", Value = Config.SafePlayers, Callback = function(v) Config.SafePlayers = v; save() end })
GunAura:Toggle({ Title = "Safe Sea Events", Value = Config.SafeSea, Callback = function(v) Config.SafeSea = v; save() end })
GunAura:Slider({ Title = "Safe Gun Range", Step = 50, Value = { Min = 50, Max = 30000, Default = Config.SafeRange }, Callback = function(v) Config.SafeRange = v; save() end })
GunAura:Sec({ Title = "Super Gun Aura", Icon = "flame", Desc = "Versión agresiva" })
GunAura:Toggle({ Title = "Super Gun Aura", Value = Config.SuperGun, Callback = function(v)
    Config.SuperGun = v
    _cachedToolSuper = nil
    _cachedTargetSuper = nil
    save()
end })
GunAura:Toggle({ Title = "Super Mobs", Value = Config.SuperMobs, Callback = function(v) Config.SuperMobs = v; save() end })
GunAura:Toggle({ Title = "Super Players", Value = Config.SuperPlayers, Callback = function(v) Config.SuperPlayers = v; save() end })
GunAura:Toggle({ Title = "Super Sea Events", Value = Config.SuperSea, Callback = function(v) Config.SuperSea = v; save() end })
GunAura:Slider({ Title = "Super Gun Range", Step = 50, Value = { Min = 50, Max = 30000, Default = Config.SuperRange }, Callback = function(v) Config.SuperRange = v; save() end })
GunAura:Sec({ Title = "Extras", Icon = "eye", Desc = "Ocultar elementos del mapa" })
GunAura:Toggle({ Title = "Disappear Everything", Value = Config.Disappear, Callback = function(v)
    setDisappear(v)
    save()
end })
GunAura:Paragraph({ Title = "Disappear Keybind", Desc = "Tecla P para activar/desactivar" })


local Dungeons = Window:Tab({ Title = "Dungeons", Icon = "swords" })
Dungeons:Sec({ Title = "Fruit Fast Attack", Icon = "flame", Desc = "Fast attack de fruta SIN equipar" })
Dungeons:Toggle({ Title = "Fruit Fast Attack (sin equipar)", Value = Config.FruitM1, Callback = function(v)
    Config.FruitM1 = v
    if FruitM1 and FruitM1.SetNormal then
        FruitM1.SetNormal(v)
    end
    save()
end })
Dungeons:Sec({ Title = "Bypass TP NPC", Icon = "map-pin", Desc = "Teletransporte a NPCs ignorando límites" })
Dungeons:Toggle({ Title = "Bypass TP NPC", Value = Config.BypassTpNpc or false, Callback = function(v)
    Config.BypassTpNpc = v
    if v then
        StartBypassTpNpc()
    else
        StopBypassTpNpc()
    end
    save()
end })
Dungeons:Slider({
    Title = "NPC TP Range",
    Step = 25,
    Value = { Min = 50, Max = 5000, Default = Config.BypassTpRange or 500 },
    Callback = function(v)
        Config.BypassTpRange = v
        save()
    end,
})
Dungeons:Dropdown({
    Title = "TP Mode",
    Values = {"Nearest", "All in Range", "Bring to Me"},
    Value = Config.BypassTpMode or "Nearest",
    Callback = function(v)
        Config.BypassTpMode = v
        save()
    end,
})
Dungeons:Toggle({
    Title = "TP Above NPC",
    Value = Config.BypassTpAbove ~= false,
    Callback = function(v)
        Config.BypassTpAbove = v
        save()
    end,
})
Dungeons:Slider({
    Title = "Height Above NPC",
    Step = 1,
    Value = { Min = 3, Max = 50, Default = Config.BypassTpHeight or 12 },
    Callback = function(v)
        Config.BypassTpHeight = v
        save()
    end,
})

local Trackers = Window:Tab({ Title = "Trackers", Icon = "users" })
local trackPlayerNames = {"Nearest"}
for _, p in ipairs(Players:GetPlayers()) do
    if p ~= lp then table.insert(trackPlayerNames, p.Name) end
end
Trackers:Sec({ Title = "Objetivo", Icon = "users", Desc = "A quién seguir" })
Trackers:Dropdown({
    Title = "Target Player",
    Values = trackPlayerNames,
    Value = Config.SelectedTrackPlayer or "Nearest",
    Callback = function(v)
        Config.SelectedTrackPlayer = v
        save()
    end,
})
Trackers:Sec({ Title = "Tween / Teleport", Icon = "move", Desc = "Cómo llegar al objetivo" })
Trackers:Toggle({
    Title = "Tween Nearest",
    Value = Config.TweenNearest,
    Callback = function(v)
        Config.TweenNearest = v
        if v then Config.TweenToPlayer = false end
        save()
    end,
})
Trackers:Toggle({
    Title = "Tween To Player",
    Value = Config.TweenToPlayer,
    Callback = function(v)
        Config.TweenToPlayer = v
        if v then Config.TweenNearest = false end
        save()
    end,
})
Trackers:Toggle({
    Title = "Insta TP",
    Value = Config.InstaTP,
    Callback = function(v) Config.InstaTP = v; save() end,
})
Trackers:Slider({
    Title = "Tween Speed",
    Step = 10,
    Value = { Min = 50, Max = 800, Default = Config.TweenSpeed or 350 },
    Callback = function(v) Config.TweenSpeed = v; save() end,
})
Trackers:Sec({ Title = "Offset de posición", Icon = "sliders-horizontal", Desc = "Ajuste fino X / Y / Z" })
Trackers:Slider({
    Title = "Offset X",
    Step = 0.5,
    Value = { Min = -20, Max = 20, Default = Config.TweenOX or 0 },
    Callback = function(v) Config.TweenOX = v; save() end,
})
Trackers:Slider({
    Title = "Offset Y",
    Step = 0.5,
    Value = { Min = -20, Max = 50, Default = Config.TweenOY or 1.5 },
    Callback = function(v) Config.TweenOY = v; save() end,
})
Trackers:Slider({
    Title = "Offset Z",
    Step = 0.5,
    Value = { Min = -20, Max = 20, Default = Config.TweenOZ or 3.5 },
    Callback = function(v) Config.TweenOZ = v; save() end,
})
Trackers:Sec({ Title = "Órbita / Fly", Icon = "orbit", Desc = "Girar o volar alrededor del objetivo" })
Trackers:Toggle({
    Title = "Tracker Orbit / Fly",
    Value = Config.TrackerFly,
    Callback = function(v)
        Config.TrackerFly = v
        if v then StartTrackerFly() else StopTrackerFly() end
        save()
    end,
})
Trackers:Slider({
    Title = "Tracker Speed",
    Step = 5,
    Value = { Min = 50, Max = 500, Default = Config.TrackerFlySpeed },
    Callback = function(v) Config.TrackerFlySpeed = v; save() end,
})
Trackers:Slider({
    Title = "Orbit Radius",
    Step = 1,
    Value = { Min = 5, Max = 150, Default = Config.TrackerOrbitRadius },
    Callback = function(v) Config.TrackerOrbitRadius = v; save() end,
})
Trackers:Sec({ Title = "Auto Flee y Spectate", Icon = "heart-pulse", Desc = "Huir con poca vida y espectar" })
Trackers:Toggle({
    Title = "Auto Flee",
    Value = Config.AutoFlee,
    Callback = function(v)
        Config.AutoFlee = v
        if v then StartAutoFlee() else StopAutoFlee() end
        save()
    end,
})
Trackers:Slider({
    Title = "Auto Flee HP %",
    Step = 1,
    Value = { Min = 5, Max = 80, Default = Config.AutoFleeHP },
    Callback = function(v) Config.AutoFleeHP = v; save() end,
})
Trackers:Toggle({
    Title = "Spectate Target",
    Value = Config.Spectate,
    Callback = function(v)
        Config.Spectate = v
        if not v then
            pcall(function()
                local cam = Workspace.CurrentCamera
                local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
                if hum then cam.CameraSubject = hum end
            end)
        end
        save()
    end,
})

local Aim = Window:Tab({ Title = "Aim", Icon = "target" })
Aim:Sec({ Title = "Silent Aim", Icon = "crosshair", Desc = "Jugadores, NPCs y prioridad" })
Aim:Toggle({ Title = "Silent Aim Players", Value = Config.SilentPlayer, Callback = function(v)
    Config.SilentPlayer = v
    SilentAimModule:SetPlayerSilentAim(v)
    save()
end })
Aim:Toggle({ Title = "Silent Aim NPCs", Value = Config.SilentNPC, Callback = function(v)
    Config.SilentNPC = v
    SilentAimModule:SetNPCSilentAim(v)
    save()
end })
Aim:Dropdown({
    Title = "Aim Mode",
    Values = {"360", "180", "FOV"},
    Value = Config.AimMode or "360",
    Callback = function(v)
        Config.AimMode = v
        SilentAimModule:SetAimMode(v)
        save()
    end,
})
Aim:Dropdown({
    Title = "Priority",
    Values = {"Nearest", "Low HP", "HighestHP", "Looking At Me", "Lock Player"},
    Value = Config.AimPriority or "Nearest",
    Callback = function(v)
        Config.AimPriority = v
        SilentAimModule:SetTargetPriority(v)
        save()
    end,
})
Aim:Sec({ Title = "FOV y alcance", Icon = "scan", Desc = "Círculo, radio y rango máximo" })
Aim:Dropdown({
    Title = "FOV Mode",
    Values = {"V1", "V2"},
    Value = Config.FOVMode or "V1",
    Callback = function(v)
        Config.FOVMode = v
        SilentAimModule:SetFOVMode(v)
        save()
    end,
})
Aim:Toggle({ Title = "Show FOV Circle", Value = Config.ShowFOV, Callback = function(v)
    Config.ShowFOV = v
    SilentAimModule:SetShowFOVCircle(v)
    save()
end })
Aim:Slider({
    Title = "FOV Radius",
    Step = 5,
    Value = { Min = 10, Max = 2000, Default = Config.FOVRadius or 150 },
    Callback = function(v)
        Config.FOVRadius = v
        SilentAimModule:SetFOVRadius(v)
        -- AIM TP (Soru) same size
        Config.SoruFOVRadius = v
        SilentAimModule:SetSoruFOVRadius(v)
        save()
    end,
})
Aim:Slider({
    Title = "Max Range",
    Step = 50,
    Value = { Min = 50, Max = 10000, Default = Config.AimMaxRange or 2000 },
    Callback = function(v)
        Config.AimMaxRange = v
        SilentAimModule:SetDistanceLimit(v)
        save()
    end,
})
Aim:Toggle({ Title = "Tracer", Value = Config.Tracer, Callback = function(v)
    Config.Tracer = v
    SilentAimModule:SetTracerEnabled(v)
    save()
end })
Aim:Sec({ Title = "M1 Extender", Icon = "swords", Desc = "Más rango en el M1" })
Aim:Toggle({ Title = "M1 Extender (solo rango)", Value = Config.M1Extender, Callback = function(v)
    Config.M1Extender = v
    M1ExtenderMod:Toggle(v)
    save()
end })
Aim:Slider({
    Title = "M1 Range",
    Step = 5,
    Value = { Min = 10, Max = 300, Default = Config.M1Range or 50 },
    Callback = function(v)
        Config.M1Range = v
        M1ExtenderMod:SetRange(v)
        save()
    end,
})
Aim:Sec({ Title = "Extras", Icon = "rocket", Desc = "Gun Click y Z Boost" })
Aim:Toggle({ Title = "Gun Click SL", Value = Config.GunClickSL, Callback = function(v)
    Config.GunClickSL = v
    GunClickSLMod:SetEnabled(v)
    save()
end })
Aim:Toggle({ Title = "Z Boost", Value = Config.ZBoostEnabled, Callback = function(v)
    Config.ZBoostEnabled = v
    if v then createBoostGui() else destroyBoostGui() end
    save()
end })
Aim:Slider({
    Title = "Z Boost Power",
    Step = 10,
    Value = { Min = 100, Max = 2000, Default = Config.ZBoostPower or 450 },
    Callback = function(v) Config.ZBoostPower = v; save() end,
})
Aim:Sec({ Title = "Soru Auto Aim", Icon = "target", Desc = "Auto aim para Soru" })
Aim:Toggle({ Title = "Soru Auto Aim", Value = Config.SoruAutoAim, Callback = function(v)
    Config.SoruAutoAim = v
    SilentAimModule:SetSoruAutoAim(v)
    save()
end })
Aim:Dropdown({
    Title = "Soru Aim Mode",
    Values = {"360", "180", "FOV"},
    Value = Config.SoruAimMode or "360",
    Callback = function(v)
        Config.SoruAimMode = v
        SilentAimModule:SetSoruAimMode(v)
        save()
    end,
})
Aim:Dropdown({
    Title = "Soru FOV Type",
    Values = {"V1", "V2"},
    Value = Config.SoruFOVType or "V1",
    Callback = function(v)
        Config.SoruFOVType = v
        SilentAimModule:SetSoruFOVType(v)
        save()
    end,
})
Aim:Dropdown({
    Title = "Soru Priority",
    Values = {"Nearest", "Low HP", "Looking At Me"},
    Value = Config.SoruPriority or "Nearest",
    Callback = function(v)
        Config.SoruPriority = v
        SilentAimModule:SetSoruPriority(v)
        save()
    end,
})
Aim:Slider({
    Title = "Soru FOV Radius",
    Step = 5,
    Value = { Min = 10, Max = 2000, Default = Config.SoruFOVRadius or 150 },
    Callback = function(v)
        Config.SoruFOVRadius = v
        SilentAimModule:SetSoruFOVRadius(v)
        save()
    end,
})
Aim:Slider({
    Title = "Soru Max Range",
    Step = 10,
    Value = { Min = 50, Max = 1000, Default = Config.SoruRange or 300 },
    Callback = function(v)
        Config.SoruRange = v
        SilentAimModule:SetSoruRange(v)
        save()
    end,
})
Aim:Toggle({ Title = "Show Soru FOV", Value = Config.SoruShowFOV, Callback = function(v)
    Config.SoruShowFOV = v
    SilentAimModule:SetSoruShowFOVCircle(v)
    save()
end })

local BL = Window:Tab({ Title = "Blacklist", Icon = "ban" })
BL:Paragraph({ Title = "Blacklist del Silent Aim", Desc = "Abre la ⚙ de cada categoría y marca las habilidades que quieres excluir." })
local blItems, blRefresh = {}, {}
local function blCategory(cat, label, keys)
    local sec = BL:Sec({ Title = label, Desc = "Ninguna en blacklist", Icon = "settings", Opened = false })
    local function refresh()
        local on = {}
        for _, key in ipairs(keys) do
            if Config["BL_" .. cat .. "_" .. key] == true then table.insert(on, key) end
        end
        local txt = (#on > 0) and ("Blacklist: " .. table.concat(on, "  ·  ")) or "Ninguna en blacklist"
        if sec then pcall(function() sec:SetDesc(txt) end) end
    end
    table.insert(blRefresh, refresh)
    for _, key in ipairs(keys) do
        local ck = "BL_" .. cat .. "_" .. key
        local el = BL:Toggle({
            Title = (key == "TAP") and "TAP (click normal)" or ("Habilidad " .. key),
            Desc = "Añadir a la blacklist",
            Value = Config[ck] == true,
            Callback = function(v)
                Config[ck] = v
                SilentAimModule:SetBlacklistKey(cat, key, v)
                refresh()
                save()
            end,
        })
        table.insert(blItems, { el = el, ck = ck, cat = cat, key = key })
    end
    refresh()
end
blCategory("Fruit", "Fruit", { "Z", "X", "C", "V", "F", "TAP" })
blCategory("Sword", "Sword", { "Z", "X" })
blCategory("Melee", "Melee", { "Z", "X", "C" })
blCategory("Gun", "Gun", { "Z", "X" })
BL:EndSec()
BL:Button({ Title = "Limpiar blacklist", Desc = "Desmarca todas las habilidades", Callback = function()
    for _, it in ipairs(blItems) do
        if Config[it.ck] then
            Config[it.ck] = false
            pcall(function() SilentAimModule:SetBlacklistKey(it.cat, it.key, false) end)
            pcall(function() it.el:Set(false) end)
        end
    end
    for _, r in ipairs(blRefresh) do r() end
    save()
    Notify("Bragao Hub", "Blacklist limpiada", 2)
end })

local Misc = Window:Tab({ Title = "Misc", Icon = "settings" })
Misc:Sec({ Title = "General", Icon = "settings", Desc = "Avisos y anti AFK" })
Misc:Toggle({ Title = "Notifications", Value = Config.Notifications, Callback = function(v)
    Config.Notifications = v
    save()
end })
Misc:Toggle({ Title = "Anti AFK", Value = Config.AntiAFK, Callback = function(v) Config.AntiAFK = v; save() end })
Misc:Sec({ Title = "Automático", Icon = "zap", Desc = "V3, V4 y PvP" })
Misc:Toggle({ Title = "Auto V3", Value = Config.AutoV3, Callback = function(v) Config.AutoV3 = v; save() end })
Misc:Toggle({ Title = "Auto V4", Value = Config.AutoV4, Callback = function(v) Config.AutoV4 = v; save() end })
Misc:Toggle({ Title = "Auto PvP", Value = Config.AutoPvP, Callback = function(v) Config.AutoPvP = v; save() end })
Misc:Sec({ Title = "Utilidades", Icon = "wrench", Desc = "Cámara, mundo y protección" })
Misc:Toggle({ Title = "Infinite Zoom", Value = Config.InfiniteZoom, Callback = function(v)
    Config.InfiniteZoom = v
    lp.CameraMaxZoomDistance = v and math.huge or savedZoom
    save()
end })
Misc:Toggle({ Title = "Stats Gui", Value = Config.StatsGui, Callback = function(v)
    setStatsGui(v)
    save()
end })
Misc:Toggle({ Title = "Remove Ghost Ship", Value = Config.RemoveGhostShip, Callback = function(v)
    Config.RemoveGhostShip = v
    save()
end })
Misc:Toggle({ Title = "Walk on Water", Value = Config.WalkOnWater, Callback = function(v) Config.WalkOnWater = v; save() end })
Misc:Toggle({ Title = "Anti Lava", Value = Config.AntiLava, Callback = function(v)
    Config.AntiLava = v
    if v then startAntiLava() else stopAntiLava() end
    save()
end })
Misc:Sec({ Title = "Velocidad", Icon = "gauge", Desc = "Modo y valor de velocidad" })
Misc:Toggle({ Title = "Speed Hack", Value = Config.SpeedEnabled, Callback = function(v)
    Config.SpeedEnabled = v
    if not v then
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
    save()
end })
Misc:Dropdown({
    Title = "Speed Mode",
    Values = {"WalkSpeed","CFrame","Velocity"},
    Value = Config.SpeedMode,
    Callback = function(v) Config.SpeedMode = v; save() end,
})
Misc:Slider({ Title = "Speed Value", Step = 1, Value = { Min = 16, Max = 500, Default = Config.SpeedValue }, Callback = function(v) Config.SpeedValue = v; save() end })

Misc:Sec({ Title = "Acciones", Icon = "play", Desc = "Compras y utilidades rápidas" })
Misc:Button({ Title = "Buy Cyborg Race", Callback = function()
    pcall(function() CommF:InvokeServer("CyborgTrainer", "Buy") end)
    Notify("Bragao Hub", "Buy Cyborg Race enviado", 2)
end })
Misc:Button({ Title = "Buy Ghoul Race", Callback = function()
    pcall(function()
        CommF:InvokeServer("Ectoplasm", "BuyCheck", 4)
        CommF:InvokeServer("Ectoplasm", "Buy", 4)
    end)
    Notify("Bragao Hub", "Buy Ghoul Race enviado", 2)
end })
Misc:Button({ Title = "Reset Stats", Callback = function()
    pcall(function()
        CommF:InvokeServer("BlackbeardReward", "Refund", "2")
    end)
    pcall(function()
        CommF:InvokeServer("ResetStats")
    end)
    Notify("Bragao Hub", "Reset Stats enviado", 2)
end })
Misc:Button({ Title = "Reroll Race", Callback = function()
    pcall(function()
        CommF:InvokeServer("BlackbeardReward", "Reroll", "2")
    end)
    Notify("Bragao Hub", "Reroll Race enviado", 2)
end })
Misc:Button({ Title = "Save Config Now", Callback = function()
    local ok = SaveConfig()
    if ok then
        Notify("Bragao Hub", "Config guardada OK", 2)
    else
        Notify("Bragao Hub", "No se pudo guardar (sin writefile?)", 3)
    end
end })

-- ==================== POTATO GRAPHICS ====================

-- ==================== MOVEMENT TAB ====================
local Movement = Window:Tab({ Title = "Movement", Icon = "person-standing" })
Movement:Sec({ Title = "Fly", Icon = "plane", Desc = "Volar y su velocidad" })
Movement:Toggle({
    Title = "Fly",
    Value = Config.Fly,
    Callback = function(v)
        Config.Fly = v
        if v then startFly() else stopFly() end
        save()
    end,
})
Movement:Slider({
    Title = "Fly Speed",
    Step = 10,
    Value = { Min = 50, Max = 500, Default = Config.FlySpeed or 250 },
    Callback = function(v) Config.FlySpeed = v; save() end,
})
Movement:Sec({ Title = "Velocidad", Icon = "gauge", Desc = "Speed hack y modo" })
Movement:Toggle({
    Title = "Speed Hack",
    Value = Config.SpeedEnabled,
    Callback = function(v)
        Config.SpeedEnabled = v
        if not v then
            local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
        save()
    end,
})
Movement:Dropdown({
    Title = "Speed Mode",
    Values = {"WalkSpeed", "CFrame", "Velocity"},
    Value = Config.SpeedMode or "CFrame",
    Callback = function(v) Config.SpeedMode = v; save() end,
})
Movement:Slider({
    Title = "Speed Value",
    Step = 1,
    Value = { Min = 16, Max = 500, Default = Config.SpeedValue or 50 },
    Callback = function(v) Config.SpeedValue = v; save() end,
})

Movement:Sec({ Title = "Noclip y saltos", Icon = "footprints", Desc = "Atravesar y saltar" })
Movement:Toggle({
    Title = "Noclip",
    Value = false,
    Callback = function(v)
        if v then StartNoclip() else StopNoclip() end
        save()
    end,
})
Movement:Toggle({
    Title = "Infinite Jump",
    Value = false,
    Callback = function(v)
        if v then StartInfiniteJump() else StopInfiniteJump() end
        save()
    end,
})
Movement:Toggle({
    Title = "Super Jump",
    Value = false,
    Callback = function(v)
        MovementState.SuperJump = v
        save()
    end,
})
Movement:Slider({
    Title = "Super Jump Power",
    Step = 5,
    Value = { Min = 50, Max = 300, Default = 100 },
    Callback = function(v)
        MovementState.SuperJumpPower = v
        save()
    end,
})
Movement:Toggle({
    Title = "Bunny Hop",
    Value = false,
    Callback = function(v)
        if v then StartBunnyHop() else StopBunnyHop() end
        save()
    end,
})
Movement:Sec({ Title = "Extras", Icon = "activity", Desc = "Caída, dash y altura" })
Movement:Toggle({
    Title = "No Fall Damage",
    Value = false,
    Callback = function(v)
        if v then StartNoFall() else StopNoFall() end
        save()
    end,
})
Movement:Toggle({
    Title = "Dash Distance",
    Value = false,
    Callback = function(v)
        if v then StartDashDistance() else StopDashDistance() end
        save()
    end,
})
Movement:Slider({
    Title = "Dash Length",
    Step = 5,
    Value = { Min = 10, Max = 200, Default = 50 },
    Callback = function(v)
        MovementState.DashLength = v
        save()
    end,
})
Movement:Toggle({
    Title = "Custom Hip Height",
    Value = false,
    Callback = function(v)
        if v then StartHipHeight() else StopHipHeight() end
        save()
    end,
})
Movement:Slider({
    Title = "Hip Height Value",
    Step = 0.5,
    Value = { Min = 0, Max = 20, Default = 2 },
    Callback = function(v)
        MovementState.HipHeightValue = v
        save()
    end,
})


local Potato = Window:Tab({ Title = "Potato Graphics", Icon = "monitor" })
Potato:Sec({ Title = "No GFX", Icon = "monitor", Desc = "V1 = partículas/beams | V2 = + iconos" })
Potato:Dropdown({
    Title = "No GFX Mode",
    Values = {"Off", "V1", "V2"},
    Value = Config.NoGfxMode or "Off",
    Callback = function(v)
        setNoGfxMode(v)
        save()
    end,
})
Potato:Sec({ Title = "Gráficos bajos", Icon = "cpu", Desc = "Bajar la calidad del juego" })
Potato:Toggle({
    Title = "Low Graphics",
    Value = Config.LowGraphics or false,
    Callback = function(v)
        Config.LowGraphics = v
        pcall(function()
            if v then
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
            else
                settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
            end
        end)
        save()
    end,
})
Potato:Toggle({
    Title = "Disable Shadows",
    Value = Config.DisableShadows or false,
    Callback = function(v)
        Config.DisableShadows = v
        pcall(function()
            Lighting.GlobalShadows = not v
        end)
        save()
    end,
})
Potato:Toggle({
    Title = "No Fog",
    Value = Config.NoFog or false,
    Callback = function(v)
        Config.NoFog = v
        pcall(function()
            if v then
                Lighting.FogEnd = 9e9
                Lighting.FogStart = 9e9
            else
                Lighting.FogEnd = 100000
            end
        end)
        save()
    end,
})
Potato:Sec({ Title = "Fast Flags", Icon = "rocket", Desc = "FFlags del executor (FPS / red / física)" })
Potato:Button({
    Title = "Inject Fast Flags 1",
    Callback = function()
        local n, f = InjectFastFlags(1)
        Notify("Bragao Hub", "FF1: " .. tostring(n) .. " ok | " .. tostring(f) .. " fail", 3)
    end,
})
Potato:Button({
    Title = "Inject Fast Flags 2",
    Callback = function()
        local n, f = InjectFastFlags(2)
        Notify("Bragao Hub", "FF2: " .. tostring(n) .. " ok | " .. tostring(f) .. " fail", 3)
    end,
})
Potato:Button({
    Title = "Inject Fast Flags 3",
    Callback = function()
        local n, f = InjectFastFlags(3)
        Notify("Bragao Hub", "FF3: " .. tostring(n) .. " ok | " .. tostring(f) .. " fail", 3)
    end,
})
Potato:Button({
    Title = "Inject All Fast Flags",
    Callback = function()
        local n1, f1 = InjectFastFlags(1)
        local n2, f2 = InjectFastFlags(2)
        local n3, f3 = InjectFastFlags(3)
        Notify("Bragao Hub", "Total: " .. tostring(n1+n2+n3) .. " flags inyectadas", 3)
    end,
})

-- ==================== VISUAL TAB ====================
local Visual = Window:Tab({ Title = "Visual", Icon = "eye" })

Visual:Sec({ Title = "ESP", Icon = "eye", Desc = "Ver jugadores a través de paredes" })
Visual:Toggle({
    Title = "ESP",
    Value = Config.ESP,
    Callback = function(v)
        Config.ESP = v
        save()
    end
})

Visual:Slider({
    Title = "ESP Range",
    Step = 50,
    Value = { Min = 100, Max = 5000, Default = Config.ESPRange },
    Callback = function(v)
        Config.ESPRange = v
        save()
    end
})

Visual:Sec({ Title = "ESP — información", Icon = "layers", Desc = "Qué mostrar de cada jugador" })
for _, opt in ipairs({
    { "ESPName", "ESP Name" },
    { "ESPHealth", "ESP HP (texto)" },
    { "ESPHealthBar", "ESP Barra de vida" },
    { "ESPDistance", "ESP Distancia" },
    { "ESPBox", "ESP Box" },
    { "ESPTool", "ESP Arma equipada" },
    { "ESPChams", "ESP Chams (silueta)" },
}) do
    Visual:Toggle({
        Title = opt[2],
        Value = Config[opt[1]],
        Callback = function(v)
            Config[opt[1]] = v
            save()
        end
    })
end

Visual:Slider({
    Title = "ESP Tamaño de texto",
    Step = 1,
    Value = { Min = 10, Max = 20, Default = Config.ESPTextSize },
    Callback = function(v)
        Config.ESPTextSize = v
        save()
    end
})

Visual:Sec({ Title = "Silent Aim Tracer", Icon = "crosshair", Desc = "Línea al objetivo (requiere Silent Aim Players)" })
Visual:Toggle({
    Title = "Silent Aim Tracer",
    Value = Config.SATracer,
    Callback = function(v)
        Config.SATracer = v
        save()
    end
})
Visual:Toggle({
    Title = "Marcar a todos los del FOV",
    Value = Config.SATracerAll,
    Callback = function(v)
        Config.SATracerAll = v
        save()
    end
})

Visual:Sec({ Title = "Tracers", Icon = "move", Desc = "Líneas hasta los jugadores" })
Visual:Toggle({ 
    Title = "Tracers", 
    Value = Config.Tracers, 
    Callback = function(v) 
        Config.Tracers = v
        save() 
    end 
})

-- ==================== BOTONES FLOTANTES (estilo Onyx) ====================
-- Cada botón enciende/apaga un toggle real de la UI y se mantiene sincronizado con él.
do
    local ICONS = {
        crosshair = "rbxassetid://134242818164054",
        sword = "rbxassetid://124448418211665",
        target = "rbxassetid://87563802520297",
        climb = "rbxassetid://100467452364672",
        plane = "rbxassetid://126985561580989",
        expand = "rbxassetid://137492887754537",
        ghost = "rbxassetid://113822048130017",
    }
    local IS_MOBILE = UserInputService.TouchEnabled
    local TILE = IS_MOBILE and 72 or 84
    local GAP = 10

    local F = { gui = nil, parts = {}, locked = Config.BtnLocked == true }
    BragaoUI.float = F

    local function tween(obj, props, t)
        pcall(function()
            TweenService:Create(obj, TweenInfo.new(t or 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
        end)
    end

    local function lighten(c, a)
        return Color3.new(c.R + (1 - c.R) * a, c.G + (1 - c.G) * a, c.B + (1 - c.B) * a)
    end

    local function scaleValue()
        return math.clamp((Config.BtnScale or 100) / 100, 0.4, 2)
    end

    -- Enciende/apaga el toggle real (y su elemento en la UI) desde un botón flotante
    function BragaoUI.setToggle(title, value)
        local list = BragaoUI.elements[title]
        if list then
            for _, el in ipairs(list) do
                pcall(function() el:Set(value) end)
            end
        end
        -- Si Set no disparó el callback, lo llamamos nosotros
        if BragaoUI.states[title] ~= value then
            for _, cb in ipairs(BragaoUI.callbacks[title] or {}) do
                pcall(cb, value)
            end
        end
    end

    local function setActive(part, active)
        part.active = active
        tween(part.stroke, { Transparency = active and 0 or 0.15 }, 0.18)
        tween(part.plate, { BackgroundTransparency = active and 0.35 or 0.82 }, 0.18)
        tween(part.plateStroke, { Transparency = active and 0.15 or 0.55 }, 0.18)
        tween(part.icon, { ImageColor3 = lighten(part.accent, active and 0.8 or 0.55) }, 0.18)
        tween(part.label, { TextColor3 = active and Color3.fromRGB(240, 240, 246) or Color3.fromRGB(146, 146, 158) }, 0.18)
    end

    function BragaoUI.refresh(title)
        for _, def in ipairs(BragaoUI.floatDefs) do
            if def.toggle == title and F.parts[def.id] then
                setActive(F.parts[def.id], BragaoUI.states[title] == true)
            end
        end
    end

    -- Posiciones por defecto: una fila centrada arriba, solo con los botones activos
    function F.relayout()
        local list = {}
        for _, def in ipairs(BragaoUI.floatDefs) do
            if F.parts[def.id] then table.insert(list, def) end
        end
        local sc = scaleValue()
        for i, def in ipairs(list) do
            local part = F.parts[def.id]
            part.scale.Scale = sc
            if (Config["BtnX_" .. def.id] or -1) < 0 then
                part.btn.Position = UDim2.new(0.5, (i - (#list + 1) / 2) * (TILE + GAP) * sc, 0.25, 0)
            else
                part.btn.Position = UDim2.fromScale(Config["BtnX_" .. def.id], Config["BtnY_" .. def.id])
            end
        end
    end

    function F.destroy(id)
        local part = F.parts[id]
        if not part then return end
        for _, c in ipairs(part.conns) do pcall(function() c:Disconnect() end) end
        pcall(function() part.btn:Destroy() end)
        F.parts[id] = nil
    end

    function F.create(def)
        if F.parts[def.id] or not F.gui then return end
        if not BragaoUI.callbacks[def.toggle] then return end -- ese toggle no existe en esta versión
        local accent = Color3.fromHex(def.color)

        local btn = Instance.new("TextButton")
        btn.Name = def.id .. "Btn"
        btn.Size = UDim2.fromOffset(TILE, TILE)
        btn.AnchorPoint = Vector2.new(0.5, 0.5)
        btn.Text = ""
        btn.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
        btn.BackgroundTransparency = 0.18
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.ZIndex = 2
        btn.Parent = F.gui
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 16)
        local uiScale = Instance.new("UIScale")
        uiScale.Scale = scaleValue()
        uiScale.Parent = btn
        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1.5
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Color = accent
        stroke.Transparency = 0.15
        stroke.Parent = btn

        local plate = Instance.new("Frame")
        plate.Name = "Plate"
        plate.Size = UDim2.fromOffset(34, 34)
        plate.Position = UDim2.new(0.5, 0, 0, math.floor(TILE * 0.36))
        plate.AnchorPoint = Vector2.new(0.5, 0.5)
        plate.BackgroundColor3 = accent
        plate.BackgroundTransparency = 0.82
        plate.BorderSizePixel = 0
        plate.ZIndex = 3
        plate.Parent = btn
        Instance.new("UICorner", plate).CornerRadius = UDim.new(0, 11)
        local plateStroke = Instance.new("UIStroke")
        plateStroke.Thickness = 1
        plateStroke.Color = accent
        plateStroke.Transparency = 0.55
        plateStroke.Parent = plate

        local icon = Instance.new("ImageLabel")
        icon.Name = "Icon"
        icon.Size = UDim2.fromOffset(23, 23)
        icon.Position = UDim2.new(0.5, 0, 0.5, 0)
        icon.AnchorPoint = Vector2.new(0.5, 0.5)
        icon.BackgroundTransparency = 1
        icon.Image = ICONS[def.icon] or ""
        icon.ImageColor3 = lighten(accent, 0.55)
        icon.ZIndex = 5
        icon.Parent = plate

        local lines = select(2, def.label:gsub("\n", "")) + 1
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(1, -10, 0, 24)
        label.Position = UDim2.new(0.5, 0, 1, -7)
        label.AnchorPoint = Vector2.new(0.5, 1)
        label.BackgroundTransparency = 1
        label.Text = def.label
        label.TextSize = (lines >= 2) and (IS_MOBILE and 8 or 9) or (IS_MOBILE and 9 or 10)
        label.Font = Enum.Font.GothamBold
        label.TextColor3 = Color3.fromRGB(146, 146, 158)
        label.TextWrapped = true
        label.LineHeight = lines >= 2 and 1 or 1.1
        label.ZIndex = 6
        label.Parent = btn

        local part = {
            btn = btn, stroke = stroke, plate = plate, plateStroke = plateStroke,
            icon = icon, label = label, accent = accent, scale = uiScale,
            active = false, conns = {}, def = def,
        }
        F.parts[def.id] = part
        local function on(signal, fn) table.insert(part.conns, signal:Connect(fn)) end

        -- hover
        on(btn.MouseEnter, function()
            tween(btn, { BackgroundTransparency = 0.06 })
            tween(plate, { BackgroundTransparency = part.active and 0.3 or 0.7 })
        end)
        on(btn.MouseLeave, function()
            tween(btn, { BackgroundTransparency = 0.18 })
            tween(plate, { BackgroundTransparency = part.active and 0.35 or 0.82 })
        end)

        -- click vs arrastre
        local pressed, dragged, activeInput, startScalePos, startInputPos = false, false, nil, nil, nil
        local lastClick = 0
        local function doClick()
            if dragged then return end
            local now = os.clock()
            if now - lastClick < 0.2 then return end
            lastClick = now
            BragaoUI.playSfx("click")
            local sc = scaleValue()
            tween(uiScale, { Scale = sc * 0.93 }, 0.06)
            task.delay(0.08, function()
                if uiScale.Parent then tween(uiScale, { Scale = sc }, 0.16) end
            end)
            task.spawn(function()
                BragaoUI.setToggle(def.toggle, not (BragaoUI.states[def.toggle] == true))
            end)
        end
        on(btn.MouseButton1Click, doClick)
        on(btn.TouchTap, doClick)

        on(btn.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                pressed, dragged, activeInput = true, false, input
                local vs = F.gui.AbsoluteSize
                local center = btn.AbsolutePosition + btn.AbsoluteSize / 2
                startScalePos = Vector2.new(center.X / vs.X, center.Y / vs.Y)
                startInputPos = input.Position
            end
        end)
        on(UserInputService.InputChanged, function(input)
            if not pressed or F.locked or not btn.Parent then return end
            if input.UserInputType ~= Enum.UserInputType.MouseMovement and input ~= activeInput then return end
            local d = input.Position - startInputPos
            if not dragged then
                if math.abs(d.X) + math.abs(d.Y) < 6 then return end
                dragged = true
            end
            local vs = F.gui.AbsoluteSize
            btn.Position = UDim2.fromScale(
                math.clamp(startScalePos.X + d.X / vs.X, 0.02, 0.98),
                math.clamp(startScalePos.Y + d.Y / vs.Y, 0.02, 0.98)
            )
        end)
        on(UserInputService.InputEnded, function(input)
            if not pressed or input ~= activeInput then return end
            pressed, activeInput = false, nil
            if dragged then
                Config["BtnX_" .. def.id] = btn.Position.X.Scale
                Config["BtnY_" .. def.id] = btn.Position.Y.Scale
                save()
            end
            task.delay(0.05, function() dragged = false end)
        end)

        setActive(part, BragaoUI.states[def.toggle] == true)
        F.relayout()
    end

    function F.build()
        pcall(function()
            local host = (gethui and gethui()) or CoreGui
            local old = host:FindFirstChild("Bragao_Buttons")
            if old then old:Destroy() end
        end)
        local gui = Instance.new("ScreenGui")
        gui.Name = "Bragao_Buttons"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 10
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        pcall(function()
            if syn and syn.protect_gui then syn.protect_gui(gui) end
        end)
        gui.Parent = (gethui and gethui()) or CoreGui
        F.gui = gui
        for _, def in ipairs(BragaoUI.floatDefs) do
            if Config["BtnOn_" .. def.id] then F.create(def) end
        end
        F.relayout()
    end

    function F.resetPositions()
        for _, def in ipairs(BragaoUI.floatDefs) do
            Config["BtnX_" .. def.id] = -1
            Config["BtnY_" .. def.id] = -1
        end
        F.relayout()
        save()
    end

    -- ---------- Pestaña "Botones" ----------
    local BtnTab = Window:Tab({ Title = "Botones", Icon = "layout-grid" })
        BtnTab:Sec({ Title = "Botones flotantes", Icon = "layout-grid", Desc = "Toca para encender/apagar. Arrástralo para moverlo." })
    for _, def in ipairs(BragaoUI.floatDefs) do
        BtnTab:Toggle({
            Title = def.label:gsub("\n", " ") .. " Button",
            Value = Config["BtnOn_" .. def.id],
            Callback = function(v)
                Config["BtnOn_" .. def.id] = v
                if v then F.create(def) else F.destroy(def.id) end
                F.relayout()
                save()
            end,
        })
    end
    BtnTab:Sec({ Title = "Ajustes", Icon = "settings", Desc = "Posición, tamaño y sonidos" })
    BtnTab:Toggle({
        Title = "Bloquear posición de botones",
        Value = Config.BtnLocked,
        Callback = function(v)
            Config.BtnLocked = v
            F.locked = v
            save()
        end,
    })
    BtnTab:Slider({
        Title = "Tamaño de botones (%)",
        Step = 5,
        Value = { Min = 40, Max = 150, Default = Config.BtnScale },
        Callback = function(v)
            Config.BtnScale = v
            F.relayout()
            save()
        end,
    })
    BtnTab:Toggle({
        Title = "Sonidos de la UI",
        Value = Config.UISounds,
        Callback = function(v)
            Config.UISounds = v
            save()
        end,
    })
    BtnTab:Button({
        Title = "Restablecer posiciones",
        Callback = function() F.resetPositions() end,
    })

    F.build()
end

-- ==================== 4EVR (fondos, colores y guardado) ====================
do
    local EV = Window:Tab({ Title = "4EVR", Icon = "sparkles" })
    local function activeName()
        local d = BragaoUI.themeImages[Config.UI_Theme] or BragaoUI.themeImages[1]
        return Config.UI_BgOn and d.name or "Sin imagen"
    end

    -- ---------- Fondos ----------
    local secBg = EV:Sec({ Title = "Fondos", Desc = "Activo: " .. activeName(), Icon = "image", Opened = true })
    local bgToggle
    local function useTheme(i)
        Config.UI_Theme = i
        Config.UI_BgOn = true
        if bgToggle then pcall(function() bgToggle:Set(true) end) end
        BragaoUI.applyBackground()
        pcall(function() secBg:SetDesc("Activo: " .. activeName()) end)
        save()
    end
    for idx, t in ipairs(BragaoUI.themeImages) do
        if t.id or (t.url and t.key ~= "custom") then
            local prev = t.id and (BragaoUI.resolveImage(t) or ("rbxassetid://" .. t.id)) or t.url
            pcall(function() EV:Image({ Image = prev, AspectRatio = "16:9" }) end)
            EV:Button({
                Title = "Usar " .. t.name,
                Desc = "Poner este fondo en la ventana",
                Callback = function() useTheme(idx) end,
            })
        end
    end
    bgToggle = EV:Toggle({
        Title = "Mostrar imagen de fondo",
        Value = Config.UI_BgOn,
        Callback = function(v)
            Config.UI_BgOn = v
            BragaoUI.applyBackground()
            pcall(function() secBg:SetDesc("Activo: " .. activeName()) end)
            save()
        end,
    })
    EV:Slider({
        Title = "Visibilidad de la imagen (%)",
        Step = 5,
        Value = { Min = 0, Max = 100, Default = Config.UI_BgVisible },
        Callback = function(v)
            Config.UI_BgVisible = v
            BragaoUI.applyBackground()
            save()
        end,
    })

    -- ---------- Imagen propia ----------
    EV:Sec({ Title = "Imagen propia", Desc = "Sube tu imagen a GitHub y pega el link RAW", Icon = "link", Opened = false })
    EV:Input({
        Title = "URL de la imagen",
        Desc = "Ej: https://raw.githubusercontent.com/USUARIO/REPO/main/fondo.png",
        Value = Config.UI_CustomUrl or "",
        Placeholder = "https://raw.githubusercontent.com/...",
        Callback = function(text)
            Config.UI_CustomUrl = tostring(text or "")
            BragaoUI.imgCache = {}
            save()
        end,
    })
    EV:Button({
        Title = "Usar mi imagen",
        Desc = "Descarga la imagen y la pone de fondo",
        Callback = function()
            if (Config.UI_CustomUrl or "") == "" then
                Notify("Bragao Hub", "Pega primero la URL", 2)
                return
            end
            BragaoUI.imgCache = {}
            useTheme(4)
        end,
    })

    -- ---------- Colores ----------
    EV:Sec({ Title = "Colores de la UI", Desc = "Se aplican al instante y se guardan solos", Icon = "palette", Opened = true })
    local pickers = {}
    local function addPicker(key, title, desc)
        pickers[key] = EV:Colorpicker({
            Title = title,
            Desc = desc,
            Default = BragaoUI.col(key),
            Callback = function(c)
                Config[key] = BragaoUI.toHex(c)
                BragaoUI.queueApply()
            end,
        })
    end
    addPicker("UI_ColText", "Letras", "Color del texto principal")
    addPicker("UI_ColMuted", "Letras secundarias", "Descripciones y placeholders")
    addPicker("UI_ColBg", "Fondo de la ventana", "Color base detrás de todo")
    addPicker("UI_ColCard", "Tarjetas", "Fondo de cada opción")
    addPicker("UI_ColAccent", "Acento", "Toggles, sliders y checks")
    addPicker("UI_ColButton", "Botones", "Fondo de los botones")
    addPicker("UI_ColIcon", "Iconos", "Color de los iconos")
    addPicker("UI_ColBorder", "Bordes", "Contornos de la UI")
    local cardSlider = EV:Slider({
        Title = "Transparencia de tarjetas (%)",
        Step = 5,
        Value = { Min = 0, Max = 95, Default = Config.UI_CardAlpha },
        Callback = function(v)
            Config.UI_CardAlpha = v
            BragaoUI.queueApply()
        end,
    })

    -- ---------- Paletas rápidas ----------
    EV:Sec({ Title = "Paletas rápidas", Desc = "Cambia todos los colores de una vez", Icon = "sparkles", Opened = false })
    local PALETTES = {
        { "Onyx (original)", { UI_ColBg = "#161619", UI_ColCard = "#18181b", UI_ColText = "#ffffff", UI_ColMuted = "#a1a1aa", UI_ColAccent = "#ffffff", UI_ColButton = "#3f3f46", UI_ColIcon = "#d4d4d8", UI_ColBorder = "#ffffff" }, 30 },
        { "Sangre", { UI_ColBg = "#1a0a0c", UI_ColCard = "#2a1215", UI_ColText = "#fff1f2", UI_ColMuted = "#fda4af", UI_ColAccent = "#ef4444", UI_ColButton = "#7f1d1d", UI_ColIcon = "#fecaca", UI_ColBorder = "#ef4444" }, 30 },
        { "Océano", { UI_ColBg = "#071a26", UI_ColCard = "#0f2b3d", UI_ColText = "#e0f2fe", UI_ColMuted = "#7dd3fc", UI_ColAccent = "#38bdf8", UI_ColButton = "#0c4a6e", UI_ColIcon = "#bae6fd", UI_ColBorder = "#38bdf8" }, 30 },
        { "Violeta", { UI_ColBg = "#150b26", UI_ColCard = "#241540", UI_ColText = "#f5f3ff", UI_ColMuted = "#c4b5fd", UI_ColAccent = "#a855f7", UI_ColButton = "#5b21b6", UI_ColIcon = "#ddd6fe", UI_ColBorder = "#a855f7" }, 30 },
        { "Esmeralda", { UI_ColBg = "#06180f", UI_ColCard = "#0e2a1c", UI_ColText = "#ecfdf5", UI_ColMuted = "#86efac", UI_ColAccent = "#22c55e", UI_ColButton = "#166534", UI_ColIcon = "#bbf7d0", UI_ColBorder = "#22c55e" }, 30 },
    }
    local function applyPalette(p)
        for k, hex in pairs(p[2]) do
            Config[k] = hex
            if pickers[k] then pcall(function() pickers[k]:Set(BragaoUI.col(k)) end) end
        end
        Config.UI_CardAlpha = p[3]
        pcall(function() cardSlider:Set(p[3]) end)
        BragaoUI.applyTheme()
        save()
        Notify("Bragao Hub", "Paleta: " .. p[1], 2)
    end
    for _, p in ipairs(PALETTES) do
        EV:Button({ Title = p[1], Callback = function() applyPalette(p) end })
    end

    EV:EndSec()
    EV:Button({ Title = "Restablecer colores", Desc = "Vuelve a la paleta Onyx", Callback = function() applyPalette(PALETTES[1]) end })
end

task.defer(function()
    if Config.Fly then startFly() end
    if Config.AntiLava then startAntiLava() end
    if Config.InfiniteZoom then lp.CameraMaxZoomDistance = math.huge end
    if Config.ZBoostEnabled then createBoostGui() end
    if Config.StatsGui then setStatsGui(true) end
    if Config.FruitM1 then FruitM1.SetNormal(true) end
    if Config.TrackerFly then StartTrackerFly() end
    if Config.AutoFlee then StartAutoFlee() end
    if Config.GunClickSL then GunClickSLMod:SetEnabled(true) end
    if Config.NoGfxMode and Config.NoGfxMode ~= "Off" then setNoGfxMode(Config.NoGfxMode) end
    if Config.LowGraphics then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)
    end
    if Config.BypassTpNpc then StartBypassTpNpc() end
end)

Notify("Bragao Hub", "Cargado correctamente", 3)
print("Bragao Hub")
