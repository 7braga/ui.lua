--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                       V E L O R A                            ║
    ║           Premium Modular Interface Framework                ║
    ║                       v1.0.0                                 ║
    ╚══════════════════════════════════════════════════════════════╝
    Estructura modular · Temas · Botones flotantes · Persistencia
--]]

--================================================================
-- 1. SERVICIOS Y SETUP
--================================================================
local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local UserInputService   = game:GetService("UserInputService")
local RunService         = game:GetService("RunService")
local HttpService        = game:GetService("HttpService")
local SoundService       = game:GetService("SoundService")
local Lighting           = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- Limpieza de instancias previas
if _G.VELORA then
    pcall(function()
        if _G.VELORA.Root then _G.VELORA.Root:Destroy() end
        if _G.VELORA.SoundsFolder then _G.VELORA.SoundsFolder:Destroy() end
    end)
end

local VELORA = {}
_G.VELORA = VELORA

--================================================================
-- 2. CONFIG / DEFAULTS / TEMAS
--================================================================
VELORA.Config = {
    Name    = "VELORA",
    Version = "1.0.0",
    Palette = {
        GrayLight   = Color3.fromHex("D9DADD"),
        White       = Color3.fromHex("FFFFFF"),
        SurfaceGray = Color3.fromHex("F0F1F3"),
        TextDark    = Color3.fromHex("202126"),
        Accent      = Color3.fromHex("A78BFA"),
        Violet      = Color3.fromHex("A78BFA"),
        IceBlue     = Color3.fromHex("7FB3D5"),
    },
    Animation = { Fast = 0.15, Normal = 0.28, Slow = 0.45 },
    Categories = { "Combat Lab", "Visuals", "Movement Lab", "Utility", "Interface" },
}

VELORA.Themes = {
    Pearl    = { bg="D9DADD", white="FFFFFF", surface="F0F1F3", text="202126", accent="A78BFA" },
    Frost    = { bg="E8EEF7", white="FFFFFF", surface="DDE6F2", text="1F2A3A", accent="7FB3D5" },
    Graphite = { bg="2B2D31", white="36393F", surface="40444B", text="E6E8EB", accent="9BA4B5" },
    Lavender = { bg="EDE7F6", white="FFFFFF", surface="E1D5F0", text="2A1F3D", accent="B39DDB" },
    Midnight = { bg="141824", white="1E2333", surface="272D42", text="DDE3F0", accent="82AAFF" },
}

VELORA.Defaults = {
    Theme        = "Pearl",
    Accent       = "A78BFA",
    Font         = "Gotham",
    FontSize     = 14,
    CornerRadius = 12,
    Shadow       = 0.35,
    Transparency = 0,
    AnimSpeed    = 0.28,
    ReduceMotion = false,
    Background   = { ImageId = "", Opacity = 0.35, Blur = 8, Scale = "Cover" },
    Sounds       = { Enabled = true, Volume = 0.5 },
    Modules      = {},
    Floating     = {},
    Window       = { Size = UDim2.new(0, 780, 0, 540), Position = UDim2.new(0.5, -390, 0.5, -270) },
    LastTab      = "HOME",
    Profiles     = {},
}

VELORA.State = HttpService:JSONDecode(HttpService:JSONEncode(VELORA.Defaults))

--================================================================
-- 3. UTILIDADES
--================================================================
local U = {}

function U.Create(class, props)
    local inst = Instance.new(class)
    local parent = nil
    for k, v in pairs(props or {}) do
        if k == "Parent" then parent = v
        else pcall(function() inst[k] = v end) end
    end
    if parent then inst.Parent = parent end
    return inst
end

function U.Tween(obj, dur, props, style, dir)
    local info = TweenInfo.new(dur or 0.25, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

function U.Round(parent, radius)
    return U.Create("UICorner", { CornerRadius = UDim.new(0, radius or 12), Parent = parent })
end

function U.Stroke(parent, color, thickness)
    return U.Create("UIStroke", {
        Color = color or Color3.fromHex("D9DADD"),
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

function U.Padding(parent, all)
    return U.Create("UIPadding", {
        PaddingTop    = UDim.new(0, all),
        PaddingBottom = UDim.new(0, all),
        PaddingLeft   = UDim.new(0, all),
        PaddingRight  = UDim.new(0, all),
        Parent = parent,
    })
end

function U.Gradient(parent)
    return U.Create("UIGradient", {
        Color = ColorSequence.new(Color3.fromRGB(255,255,255), Color3.fromRGB(230,232,236)),
        Rotation = 90,
        Parent = parent,
    })
end

-- Arrastrar (ratón + táctil)
function U.MakeDraggable(frame, handle, onEnd)
    handle = handle or frame
    local dragging, dragStart, startPos = false, nil, nil

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = input.Position
            startPos  = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if onEnd then onEnd(frame.Position) end
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
end

-- Notificaciones flotantes
local notifLayer
function U.Notify(text, kind)
    if not notifLayer then
        notifLayer = U.Create("Frame", {
            Name = "NotifLayer",
            Size = UDim2.new(0, 320, 1, 0),
            Position = UDim2.new(1, -340, 0, 0),
            BackgroundTransparency = 1,
            Parent = VELORA.Root,
        })
        U.Create("UIListLayout", {
            Padding = UDim.new(0, 8),
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = notifLayer,
        })
    end
    local color = kind == "error" and Color3.fromHex("E57373")
        or kind == "success" and Color3.fromHex("81C784")
        or Color3.fromHex("90A4AE")

    local n = U.Create("Frame", {
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Color3.fromHex("FFFFFF"),
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Parent = notifLayer,
    })
    U.Round(n, 10)
    U.Stroke(n, color, 1.5)
    U.Padding(n, 10)
    U.Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromHex("202126"),
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = n,
    })
    U.Tween(n, 0.2, { BackgroundTransparency = 0 })
    task.delay(3, function()
        U.Tween(n, 0.3, { BackgroundTransparency = 1 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        task.wait(0.32)
        n:Destroy()
    end)
end

--================================================================
-- 4. SETTINGS REPOSITORY
--================================================================
local SettingsRepository = {}
local DIR   = "VELORA"
local FILE  = "VELORA/settings.json"
local hasIO = (typeof(writefile) == "function")
          and (typeof(readfile) == "function")
          and (typeof(isfolder) == "function")

function SettingsRepository.save(data)
    local ok, encoded = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    if not ok then return false, encoded end

    if hasIO then
        pcall(function()
            if not isfolder(DIR) then makefolder(DIR) end
            writefile(FILE, encoded)
        end)
    end
    VELORA.State = data
    return true
end

function SettingsRepository.load()
    if hasIO then
        local ok, raw = pcall(function()
            if isfile(FILE) then return readfile(FILE) end
            return nil
        end)
        if ok and raw then
            local ok2, data = pcall(function() return HttpService:JSONDecode(raw) end)
            if ok2 and type(data) == "table" then return data end
        end
    end
    return VELORA.State
end

function SettingsRepository.mergeDefaults(t)
    for k, v in pairs(VELORA.Defaults) do
        if t[k] == nil then t[k] = v end
    end
    return t
end

function SettingsRepository.export()
    return HttpService:JSONEncode(VELORA.State)
end

function SettingsRepository.import(json)
    local ok, data = pcall(function() return HttpService:JSONDecode(json) end)
    if not ok or type(data) ~= "table" then
        return false, "JSON inválido"
    end
    VELORA.State = SettingsRepository.mergeDefaults(data)
    return true
end

--================================================================
-- 5. SOUND MANAGER
--================================================================
local SoundManager = {}
VELORA.SoundManager = SoundManager

SoundManager.Enabled = true
SoundManager.Volume  = 0.5

local soundsFolder = U.Create("Folder", { Name = "VELORA_Sounds", Parent = SoundService })
VELORA.SoundsFolder = soundsFolder

local SFX = {
    click     = "rbxassetid://6895079853",
    enable    = "rbxassetid://6895079853",
    disable   = "rbxassetid://6895079853",
    tab       = "rbxassetid://6895079853",
    minimize  = "rbxassetid://6895079853",
    restore   = "rbxassetid://6895079853",
    theme     = "rbxassetid://6895079853",
    error     = "rbxassetid://6895079853",
    confirm   = "rbxassetid://6895079853",
}
local soundCache = {}

local function getSound(key)
    if not SFX[key] then return nil end
    if not soundCache[key] then
        soundCache[key] = U.Create("Sound", {
            Name = "SFX_" .. key,
            SoundId = SFX[key],
            Volume = SoundManager.Volume,
            Parent = soundsFolder,
        })
    end
    return soundCache[key]
end

function SoundManager.play(key)
    if not SoundManager.Enabled then return end
    local s = getSound(key)
    if not s then return end
    if s.IsPlaying then s:Stop() end
    s.Volume = SoundManager.Volume
    pcall(function() s:Play() end)
end

function SoundManager.preview(key) SoundManager.play(key) end
function SoundManager.setVolume(v)
    SoundManager.Volume = math.clamp(v, 0, 1)
    for _, s in pairs(soundCache) do s.Volume = SoundManager.Volume end
end
function SoundManager.setEnabled(b) SoundManager.Enabled = b end

--================================================================
-- 6. THEME ENGINE
--================================================================
local ThemeEngine = {}
VELORA.ThemeEngine = ThemeEngine

ThemeEngine.Current = nil

function ThemeEngine.applyFromState()
    local st = VELORA.State
    local preset = VELORA.Themes[st.Theme] or VELORA.Themes.Pearl
    local colors = {
        bg      = Color3.fromHex(preset.bg),
        white   = Color3.fromHex(preset.white),
        surface = Color3.fromHex(preset.surface),
        text    = Color3.fromHex(preset.text),
        accent  = Color3.fromHex(st.Accent ~= "" and st.Accent or preset.accent),
    }
    ThemeEngine.Current = colors
    ThemeEngine.emit("Changed", colors)
end

function ThemeEngine.setTheme(name)
    if not VELORA.Themes[name] then return end
    VELORA.State.Theme = name
    ThemeEngine.applyFromState()
    SoundManager.play("theme")
end

function ThemeEngine.setAccent(hex)
    local ok = pcall(function() return Color3.fromHex(hex) end)
    if not ok then return end
    VELORA.State.Accent = hex
    ThemeEngine.applyFromState()
end

-- Event emitter minimalista
local listeners = {}
function ThemeEngine.on(evt, fn)
    listeners[evt] = listeners[evt] or {}
    table.insert(listeners[evt], fn)
end
function ThemeEngine.emit(evt, ...)
    if listeners[evt] then
        for _, fn in ipairs(listeners[evt]) do pcall(fn, ...) end
    end
end

--================================================================
-- 7. MODULE REGISTRY
--================================================================
local ModuleRegistry = {}
VELORA.ModuleRegistry = ModuleRegistry

ModuleRegistry.Modules = {}     -- id -> definition
ModuleRegistry.Enabled = {}     -- id -> bool
ModuleRegistry.Hooks   = {}     -- id -> {onEnable, onDisable}

function ModuleRegistry.register(def)
    -- def = {id, name, desc, category, floatingIcon}
    ModuleRegistry.Modules[def.id] = def
    ModuleRegistry.Enabled[def.id] = VELORA.State.Modules[def.id] == true
end

function ModuleRegistry.isEnabled(id) return ModuleRegistry.Enabled[id] == true end

function ModuleRegistry.setEnabled(id, on)
    if ModuleRegistry.Enabled[id] == on then return end
    ModuleRegistry.Enabled[id] = on
    VELORA.State.Modules[id] = on

    local hook = ModuleRegistry.Hooks[id]
    if hook then
        pcall(function()
            if on and hook.onEnable then hook.onEnable()
            elseif not on and hook.onDisable then hook.onDisable() end
        end)
    end

    SoundManager.play(on and "enable" or "disable")
    ModuleRegistry.emit("Toggled", id, on)
end

local modListeners = {}
function ModuleRegistry.on(evt, fn)
    modListeners[evt] = modListeners[evt] or {}
    table.insert(modListeners[evt], fn)
end
function ModuleRegistry.emit(evt, ...)
    if modListeners[evt] then
        for _, fn in ipairs(modListeners[evt]) do pcall(fn, ...) end
    end
end

--== MÓDULOS DE PRUEBA (independientes, con hooks reales) ==

-- Combat Lab
ModuleRegistry.register({id="aim_assist", name="Aim Assist",  desc="Asistencia de apuntado para pruebas.", category="Combat Lab",     floatingIcon="rbxassetid://6031075931"})
ModuleRegistry.register({id="hitbox",     name="Hitbox Expand", desc="Expande hitbox de prueba.",        category="Combat Lab",     floatingIcon="rbxassetid://6031075931"})

ModuleRegistry.Hooks.aim_assist = {
    onEnable  = function() U.Notify("Aim Assist ON (demo)", "success") end,
    onDisable = function() U.Notify("Aim Assist OFF") end,
}
ModuleRegistry.Hooks.hitbox = {
    onEnable  = function() U.Notify("Hitbox ON (demo)", "success") end,
    onDisable = function() U.Notify("Hitbox OFF") end,
}

-- Visuals
ModuleRegistry.register({id="fullbright", name="Fullbright",   desc="Ilumina toda la escena.",       category="Visuals", floatingIcon="rbxassetid://6031075931"})
ModuleRegistry.register({id="esp_names",  name="ESP Names",    desc="Nombres sobre jugadores.",       category="Visuals", floatingIcon="rbxassetid://6031075931"})

ModuleRegistry.Hooks.fullbright = {
    onEnable = function()
        VELORA._fullbrightCache = {
            Brightness = Lighting.Brightness,
            Ambient    = Lighting.Ambient,
            OutdoorAmbient = Lighting.OutdoorAmbient,
        }
        Lighting.Brightness = 2
        Lighting.Ambient    = Color3.fromRGB(180,180,180)
        Lighting.OutdoorAmbient = Color3.fromRGB(180,180,180)
    end,
    onDisable = function()
        local c = VELORA._fullbrightCache
        if c then
            Lighting.Brightness = c.Brightness
            Lighting.Ambient    = c.Ambient
            Lighting.OutdoorAmbient = c.OutdoorAmbient
        end
    end,
}

ModuleRegistry.Hooks.esp_names = {
    onEnable = function()
        VELORA._espConns = VELORA._espConns or {}
        local function attach(char)
            local head = char:WaitForChild("Head", 5)
            if not head or head:FindFirstChild("VELORA_ESP") then return end
            local bb = Instance.new("BillboardGui")
            bb.Name = "VELORA_ESP"
            bb.Adornee = head
            bb.AlwaysOnTop = true
            bb.Size = UDim2.new(0, 200, 0, 50)
            bb.StudsOffset = Vector3.new(0, 2.5, 0)
            bb.Parent = head
            U.Create("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = char.Name,
                TextColor3 = Color3.fromHex("A78BFA"),
                TextStrokeTransparency = 0.6,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                Parent = bb,
            })
        end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then attach(plr.Character) end
            table.insert(VELORA._espConns, plr.CharacterAdded:Connect(attach))
        end
        table.insert(VELORA._espConns, Players.PlayerAdded:Connect(function(plr)
            table.insert(VELORA._espConns, plr.CharacterAdded:Connect(attach))
        end))
    end,
    onDisable = function()
        if VELORA._espConns then
            for _, c in ipairs(VELORA._espConns) do pcall(function() c:Disconnect() end) end
            VELORA._espConns = nil
        end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local h = plr.Character:FindFirstChild("Head")
                if h and h:FindFirstChild("VELORA_ESP") then h.VELORA_ESP:Destroy() end
            end
        end
    end,
}

-- Movement Lab
ModuleRegistry.register({id="speed", name="Walk Speed", desc="Ajusta velocidad de caminar.", category="Movement Lab", floatingIcon="rbxassetid://6031075931"})
ModuleRegistry.register({id="jump",  name="Jump Power", desc="Ajusta salto.",                category="Movement Lab", floatingIcon="rbxassetid://6031075931"})

ModuleRegistry.Hooks.speed = {
    onEnable = function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            VELORA._origSpeed = hum.WalkSpeed
            hum.WalkSpeed = 32
        end
    end,
    onDisable = function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = VELORA._origSpeed or 16 end
    end,
}

ModuleRegistry.Hooks.jump = {
    onEnable = function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            VELORA._origJump = hum.JumpPower
            hum.JumpPower = 80
        end
    end,
    onDisable = function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = VELORA._origJump or 50 end
    end,
}

-- Utility
ModuleRegistry.register({id="diag", name="Diagnostics", desc="Monitor FPS / ping.", category="Utility", floatingIcon="rbxassetid://6031075931"})
ModuleRegistry.Hooks.diag = {
    onEnable = function()
        VELORA._diagConn = RunService.RenderStepped:Connect(function()
            -- Solo mantiene un contador; la UI lo lee
        end)
    end,
    onDisable = function()
        if VELORA._diagConn then VELORA._diagConn:Disconnect(); VELORA._diagConn = nil end
    end,
}

-- Interface
ModuleRegistry.register({id="reduce_motion", name="Reduce Motion", desc="Desactiva animaciones.", category="Interface", floatingIcon="rbxassetid://6031075931"})
ModuleRegistry.Hooks.reduce_motion = {
    onEnable = function() VELORA.State.ReduceMotion = true end,
    onDisable = function() VELORA.State.ReduceMotion = false end,
}

--================================================================
-- 8. FLOATING BUTTONS MANAGER
--================================================================
local FBM = {}
VELORA.FloatingButtonsManager = FBM
FBM.Buttons = {}

local function getFloatState(id)
    VELORA.State.Floating[id] = VELORA.State.Floating[id] or {
        Pos = {x = 0.85, y = 0.15},
        Size = 52,
        Shape = "Circle",
        Opacity = 0.85,
        Icon = nil,
    }
    return VELORA.State.Floating[id]
end

function FBM.create(id)
    if FBM.Buttons[id] then return end
    local mod = ModuleRegistry.Modules[id]
    if not mod then return end
    local st = getFloatState(id)

    local btn = U.Create("TextButton", {
        Name = "FLOAT_" .. id,
        Size = UDim2.new(0, st.Size, 0, st.Size),
        Position = UDim2.new(st.Pos.x, 0, st.Pos.y, 0),
        BackgroundColor3 = Color3.fromHex("FFFFFF"),
        BackgroundTransparency = 1 - st.Opacity,
        Text = "",
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Parent = VELORA.Root,
    })
    btn.ZIndex = 20
    local corner = U.Round(btn, st.Shape == "Circle" and st.Size or 12)
    U.Stroke(btn, Color3.fromHex("A78BFA"), 2)

    local icon = U.Create("ImageLabel", {
        Size = UDim2.new(0.6, 0, 0.6, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = st.Icon or mod.floatingIcon or "",
        ImageColor3 = Color3.fromHex("202126"),
        Parent = btn,
    })

    local function refresh()
        local on = ModuleRegistry.isEnabled(id)
        U.Tween(btn, 0.15, {
            BackgroundColor3 = on and Color3.fromHex("A78BFA") or Color3.fromHex("FFFFFF"),
        })
        icon.ImageColor3 = on and Color3.fromHex("FFFFFF") or Color3.fromHex("202126")
    end
    refresh()
    ModuleRegistry.on("Toggled", function(mid) if mid == id then refresh() end end)

    -- Interacción
    btn.MouseButton1Click:Connect(function()
        ModuleRegistry.setEnabled(id, not ModuleRegistry.isEnabled(id))
    end)

    -- Arrastrar (ratón + táctil)
    local dragging, dragStart, startPos = false, nil, nil
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = input.Position
            startPos  = btn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    local abs = btn.AbsolutePosition
                    local vp  = workspace.CurrentCamera.ViewportSize
                    st.Pos.x = math.clamp(abs.X / vp.X, 0, 1 - 60/vp.X)
                    st.Pos.y = math.clamp(abs.Y / vp.Y, 0, 1 - 60/vp.Y)
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - dragStart
            btn.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)

    -- Evitar solapamiento básico (desplaza si choca)
    task.defer(function()
        for _, other in pairs(FBM.Buttons) do
            if other ~= btn then
                local a, b = btn.AbsolutePosition, other.AbsolutePosition
                if math.abs(a.X - b.X) < 40 and math.abs(a.Y - b.Y) < 40 then
                    btn.Position = UDim2.new(btn.Position.X.Scale, btn.Position.X.Offset + 60, btn.Position.Y.Scale, btn.Position.Y.Offset)
                end
            end
        end
    end)

    FBM.Buttons[id] = btn
end

function FBM.remove(id)
    if FBM.Buttons[id] then
        FBM.Buttons[id]:Destroy()
        FBM.Buttons[id] = nil
    end
end

function FBM.setShape(id, shape)
    local st = getFloatState(id)
    st.Shape = shape
    local btn = FBM.Buttons[id]
    if btn then
        local corner = btn:FindFirstChildOfClass("UICorner")
        if corner then corner.CornerRadius = UDim.new(0, shape == "Circle" and st.Size or 12) end
    end
end

function FBM.setSize(id, size)
    local st = getFloatState(id)
    st.Size = size
    local btn = FBM.Buttons[id]
    if btn then
        btn.Size = UDim2.new(0, size, 0, size)
        FBM.setShape(id, st.Shape)
    end
end

function FBM.setOpacity(id, op)
    local st = getFloatState(id)
    st.Opacity = op
    local btn = FBM.Buttons[id]
    if btn then btn.BackgroundTransparency = 1 - op end
end

function FBM.setIcon(id, icon)
    local st = getFloatState(id)
    st.Icon = icon
    local btn = FBM.Buttons[id]
    if btn then
        local img = btn:FindFirstChildOfClass("ImageLabel")
        if img then img.Image = icon end
    end
end

--================================================================
-- 9. UIBUILDER — VENTANA + PESTAÑAS
--================================================================
VELORA.Root = U.Create("ScreenGui", {
    Name = "VELORA",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = PlayerGui,
})
U.Create("UIScale", { Parent = VELORA.Root })

-- Fondo personalizado
local bgLayer = U.Create("Frame", {
    Name = "BackgroundLayer",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.fromHex("D9DADD"),
    BorderSizePixel = 0,
    BackgroundTransparency = 0,
    Parent = VELORA.Root,
})
VELORA.BackgroundImage = U.Create("ImageLabel", {
    Name = "CustomBG",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    ImageTransparency = 1,
    ScaleType = Enum.ScaleType.Crop,
    Parent = VELORA.Root,
})
local blur = U.Create("BlurEffect", { Size = 0, Parent = Lighting })

-- Ventana principal
local Window = U.Create("Frame", {
    Name = "MainWindow",
    Size = VELORA.State.Window.Size,
    Position = VELORA.State.Window.Position,
    BackgroundColor3 = Color3.fromHex("FFFFFF"),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent = VELORA.Root,
})
VELORA.Window = Window
U.Round(Window, 16)
U.Stroke(Window, Color3.fromHex("D9DADD"), 1)

-- Barra superior
local TitleBar = U.Create("Frame", {
    Name = "TitleBar",
    Size = UDim2.new(1, 0, 0, 52),
    BackgroundColor3 = Color3.fromHex("F0F1F3"),
    BorderSizePixel = 0,
    Parent = Window,
})
U.Round(TitleBar, 16)
U.Create("Frame", { -- tapar esquinas inferiores
    Size = UDim2.new(1, 0, 0, 20),
    Position = UDim2.new(0, 0, 1, -20),
    BackgroundColor3 = Color3.fromHex("F0F1F3"),
    BorderSizePixel = 0,
    Parent = TitleBar,
})
local dot = U.Create("Frame", {
    Size = UDim2.new(0, 8, 0, 8),
    Position = UDim2.new(0, 18, 0.5, -4),
    BackgroundColor3 = Color3.fromHex("A78BFA"),
    BorderSizePixel = 0,
    Parent = TitleBar,
})
U.Round(dot, 4)

U.Create("TextLabel", {
    Size = UDim2.new(0, 200, 1, 0),
    Position = UDim2.new(0, 34, 0, 0),
    BackgroundTransparency = 1,
    Text = "VELORA",
    Font = Enum.Font.Fondamento,     -- estilo cursivo elegante
    TextSize = 24,
    TextColor3 = Color3.fromHex("202126"),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = TitleBar,
})

-- Botones de ventana
local function windowBtn(text, xOffset, cb)
    local b = U.Create("TextButton", {
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(1, xOffset, 0.5, -16),
        BackgroundColor3 = Color3.fromHex("FFFFFF"),
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Color3.fromHex("202126"),
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = TitleBar,
    })
    U.Round(b, 8)
    b.MouseEnter:Connect(function() U.Tween(b, 0.12, { BackgroundColor3 = Color3.fromHex("E8EAEE") }) end)
    b.MouseLeave:Connect(function() U.Tween(b, 0.12, { BackgroundColor3 = Color3.fromHex("FFFFFF") }) end)
    b.MouseButton1Click:Connect(function() SoundManager.play("click"); cb() end)
    return b
end

local MinimizeBtn = windowBtn("—", -110, function()
    SoundManager.play("minimize")
    U.Tween(Window, 0.25, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0) })
    VELORA.Minimized = true
    task.delay(0.3, function()
        Window.Visible = false
        VELORA.restoreIcon()
    end)
end)

local RestoreBtn = windowBtn("▢", -74, function()
    SoundManager.play("restore")
    VELORA.State.Window.Size = UDim2.new(0, 780, 0, 540)
    Window.Size = VELORA.State.Window.Size
end)

local CloseBtn = windowBtn("✕", -36, function()
    SoundManager.play("click")
    VELORA.shutdown()
end)

-- Arrastrable
U.MakeDraggable(Window, TitleBar, function(pos)
    VELORA.State.Window.Position = pos
end)

-- Pestañas
local TabsBar = U.Create("Frame", {
    Name = "TabsBar",
    Size = UDim2.new(1, -32, 0, 40),
    Position = UDim2.new(0, 16, 0, 60),
    BackgroundTransparency = 1,
    Parent = Window,
})
U.Create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = TabsBar,
})

local Content = U.Create("Frame", {
    Name = "Content",
    Size = UDim2.new(1, -32, 1, -112),
    Position = UDim2.new(0, 16, 0, 108),
    BackgroundTransparency = 1,
    Parent = Window,
})

local Pages, TabButtons = {}, {}
local currentTab = nil

local function switchTab(name)
    if currentTab == name then return end
    SoundManager.play("tab")
    for n, frame in pairs(Pages) do
        if n == name then
            frame.Visible = true
            if not VELORA.State.ReduceMotion then
                frame.GroupTransparency = 1
                U.Tween(frame, 0.22, { GroupTransparency = 0 })
            end
        else
            frame.Visible = false
        end
    end
    for n, btn in pairs(TabButtons) do
        local active = (n == name)
        U.Tween(btn, 0.15, {
            BackgroundColor3 = active and Color3.fromHex("A78BFA") or Color3.fromHex("F0F1F3"),
            TextColor3 = active and Color3.fromHex("FFFFFF") or Color3.fromHex("202126"),
        })
    end
    currentTab = name
    VELORA.State.LastTab = name
end

local function addTab(name)
    local b = U.Create("TextButton", {
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromHex("F0F1F3"),
        Text = name,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = Color3.fromHex("202126"),
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = TabsBar,
    })
    U.Round(b, 10)
    U.Padding(b, 10)
    b.MouseButton1Click:Connect(function() switchTab(name) end)
    TabButtons[name] = b

    local page = U.Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromHex("D9DADD"),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = Content,
    })
    U.Create("UIListLayout", {
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = page,
    })
    Pages[name] = page
    return page
end

--== HOME ==
local Home = addTab("HOME")

local function card(parent, height)
    local c = U.Create("Frame", {
        Size = UDim2.new(1, -8, 0, height),
        BackgroundColor3 = Color3.fromHex("F0F1F3"),
        BorderSizePixel = 0,
        Parent = parent,
    })
    U.Round(c, 12)
    U.Padding(c, 12)
    return c
end

do
    local profile = card(Home, 90)
    local av = U.Create("ImageLabel", {
        Size = UDim2.new(0, 56, 0, 56),
        Position = UDim2.new(0, 8, 0.5, -28),
        BackgroundColor3 = Color3.fromHex("D9DADD"),
        Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150",
        Parent = profile,
    })
    U.Round(av, 28)
    U.Create("TextLabel", {
        Size = UDim2.new(1, -80, 0, 24),
        Position = UDim2.new(0, 76, 0, 12),
        BackgroundTransparency = 1,
        Text = LocalPlayer.DisplayName .. "  (@" .. LocalPlayer.Name .. ")",
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = profile,
    })
    local activeCount = 0
    for _, v in pairs(ModuleRegistry.Enabled) do if v then activeCount += 1 end end
    U.Create("TextLabel", {
        Size = UDim2.new(1, -80, 0, 20),
        Position = UDim2.new(0, 76, 0, 40),
        BackgroundTransparency = 1,
        Text = ("Sesión activa · %d módulos ON · v%s"):format(activeCount, VELORA.Config.Version),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Color3.fromHex("5A5F66"),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = profile,
    })
end

-- Quick actions
do
    local qa = card(Home, 60)
    U.Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Parent = qa,
    })
    local function qaBtn(txt, cb)
        local b = U.Create("TextButton", {
            Size = UDim2.new(0, 140, 0, 32),
            BackgroundColor3 = Color3.fromHex("FFFFFF"),
            Text = txt,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextColor3 = Color3.fromHex("202126"),
            AutoButtonColor = false,
            Parent = qa,
        })
        U.Round(b, 8)
        U.Stroke(b, Color3.fromHex("D9DADD"), 1)
        b.MouseButton1Click:Connect(function() SoundManager.play("click"); cb() end)
    end
    qaBtn("Ir a BUTTONS", function() switchTab("BUTTONS") end)
    qaBtn("Ir a CUSTOMIZE", function() switchTab("CUSTOMIZE") end)
    qaBtn("Ir a UTILITY", function() switchTab("UTILITY") end)
end

-- Performance
do
    local perf = card(Home, 60)
    local fpsLbl = U.Create("TextLabel", {
        Size = UDim2.new(0.5, -8, 1, 0),
        BackgroundTransparency = 1,
        Text = "FPS: --",
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = perf,
    })
    local pingLbl = U.Create("TextLabel", {
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = "Ping: --",
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = perf,
    })
    local frames = 0
    RunService.RenderStepped:Connect(function()
        frames += 1
    end)
    task.spawn(function()
        while VELORA.Root.Parent do
            fpsLbl.Text = ("FPS: %d"):format(frames)
            frames = 0
            local stats = game:GetService("Stats")
            local ok, ping = pcall(function()
                return stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            end)
            pingLbl.Text = ("Ping: %s ms"):format(ok and math.floor(ping) or "--")
            task.wait(1)
        end
    end)
end

-- Logs recientes
local RecentLog = {}
local function logAction(txt)
    table.insert(RecentLog, 1, {t = os.date("%H:%M:%S"), txt = txt})
    if #RecentLog > 20 then table.remove(RecentLog) end
    ModuleRegistry.emit("LogAdded")
end
VELORA.log = logAction

do
    local logs = card(Home, 200)
    U.Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 24),
        BackgroundTransparency = 1,
        Text = "Últimas acciones",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = logs,
    })
    local list = U.Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -32),
        Position = UDim2.new(0, 0, 0, 28),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = logs,
    })
    U.Create("UIListLayout", { Padding = UDim.new(0, 4), Parent = list })
    ModuleRegistry.on("LogAdded", function()
        list:ClearAllChildren()
        U.Create("UIListLayout", { Padding = UDim.new(0, 4), Parent = list })
        for _, e in ipairs(RecentLog) do
            U.Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 18),
                BackgroundTransparency = 1,
                Text = ("[%s] %s"):format(e.t, e.txt),
                Font = Enum.Font.Code,
                TextSize = 12,
                TextColor3 = Color3.fromHex("5A5F66"),
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = list,
            })
        end
    end)
end

--== BUTTONS ==
local Buttons = addTab("BUTTONS")

local function buildModuleCard(page, id)
    local mod = ModuleRegistry.Modules[id]
    local c = U.Create("Frame", {
        Size = UDim2.new(1, -8, 0, 84),
        BackgroundColor3 = Color3.fromHex("F0F1F3"),
        BorderSizePixel = 0,
        Parent = page,
    })
    U.Round(c, 12)
    U.Padding(c, 12)

    U.Create("TextLabel", {
        Size = UDim2.new(1, -130, 0, 22),
        BackgroundTransparency = 1,
        Text = mod.name,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = c,
    })
    U.Create("TextLabel", {
        Size = UDim2.new(1, -130, 0, 18),
        Position = UDim2.new(0, 0, 0, 24),
        BackgroundTransparency = 1,
        Text = mod.desc,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Color3.fromHex("5A5F66"),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = c,
    })

    -- Botón floating
    local fb = U.Create("TextButton", {
        Size = UDim2.new(0, 34, 0, 34),
        Position = UDim2.new(1, -118, 0, 0),
        BackgroundColor3 = Color3.fromHex("FFFFFF"),
        Text = "◉",
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = Color3.fromHex("202126"),
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = c,
    })
    U.Round(fb, 8)
    U.Stroke(fb, Color3.fromHex("D9DADD"), 1)
    fb.MouseButton1Click:Connect(function()
        SoundManager.play("click")
        if FBM.Buttons[id] then
            FBM.remove(id)
            U.Notify("Botón flotante eliminado", "success")
        else
            FBM.create(id)
            U.Notify("Botón flotante creado", "success")
        end
    end)

    -- Toggle ON/OFF
    local toggle = U.Create("TextButton", {
        Size = UDim2.new(0, 76, 0, 34),
        Position = UDim2.new(1, -76, 0, 0),
        BackgroundColor3 = Color3.fromHex("FFFFFF"),
        Text = "OFF",
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = Color3.fromHex("202126"),
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = c,
    })
    U.Round(toggle, 17)
    U.Stroke(toggle, Color3.fromHex("D9DADD"), 1)

    local function refresh()
        local on = ModuleRegistry.isEnabled(id)
        toggle.Text = on and "ON" or "OFF"
        U.Tween(toggle, 0.15, {
            BackgroundColor3 = on and Color3.fromHex("A78BFA") or Color3.fromHex("FFFFFF"),
            TextColor3 = on and Color3.fromHex("FFFFFF") or Color3.fromHex("202126"),
        })
    end
    refresh()
    ModuleRegistry.on("Toggled", function(mid) if mid == id then refresh() end end)

    toggle.MouseButton1Click:Connect(function()
        ModuleRegistry.setEnabled(id, not ModuleRegistry.isEnabled(id))
        logAction(("%s → %s"):format(mod.name, ModuleRegistry.isEnabled(id) and "ON" or "OFF"))
    end)
end

for _, cat in ipairs(VELORA.Config.Categories) do
    local header = U.Create("TextLabel", {
        Size = UDim2.new(1, -8, 0, 26),
        BackgroundTransparency = 1,
        Text = cat,
        Font = Enum.Font.GothamBlack,
        TextSize = 13,
        TextColor3 = Color3.fromHex("5A5F66"),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Buttons,
    })
    for id, mod in pairs(ModuleRegistry.Modules) do
        if mod.category == cat then
            buildModuleCard(Buttons, id)
        end
    end
end

--== UTILITY ==
local Utility = addTab("UTILITY")

local function utilBtn(parent, label, cb)
    local b = U.Create("TextButton", {
        Size = UDim2.new(1, -8, 0, 40),
        BackgroundColor3 = Color3.fromHex("F0F1F3"),
        Text = label,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = parent,
    })
    U.Round(b, 10)
    U.Padding(b, 12)
    b.MouseButton1Click:Connect(function() SoundManager.play("click"); cb() end)
    return b
end

utilBtn(Utility, "📄  Ver registros", function()
    local txt = {}
    for _, e in ipairs(RecentLog) do table.insert(txt, ("[%s] %s"):format(e.t, e.txt)) end
    U.Notify("Registros: " .. #RecentLog .. " entradas", "success")
end)
utilBtn(Utility, "🧹  Limpiar registros", function()
    RecentLog = {}
    ModuleRegistry.emit("LogAdded")
    U.Notify("Registros limpiados", "success")
end)
utilBtn(Utility, "♻️  Restablecer configuración", function()
    VELORA.State = HttpService:JSONDecode(HttpService:JSONEncode(VELORA.Defaults))
    ThemeEngine.applyFromState()
    U.Notify("Configuración restablecida", "success")
end)
utilBtn(Utility, "💾  Guardar perfil", function()
    VELORA.State.Profiles["custom"] = {
        Theme = VELORA.State.Theme,
        Accent = VELORA.State.Accent,
    }
    SettingsRepository.save(VELORA.State)
    U.Notify("Perfil guardado", "success")
end)
utilBtn(Utility, "📂  Cargar perfil", function()
    local p = VELORA.State.Profiles["custom"]
    if p then
        VELORA.State.Theme  = p.Theme or VELORA.State.Theme
        VELORA.State.Accent = p.Accent or VELORA.State.Accent
        ThemeEngine.applyFromState()
        U.Notify("Perfil cargado", "success")
    else
        U.Notify("No hay perfil guardado", "error")
    end
end)
utilBtn(Utility, "⬆️  Exportar ajustes", function()
    local json = SettingsRepository.export()
    if setclipboard then
        pcall(function() setclipboard(json) end)
    end
    U.Notify("Ajustes exportados al portapapeles", "success")
end)
utilBtn(Utility, "⬇️  Importar ajustes", function()
    local json = getclipboard and getclipboard() or nil
    if not json then
        U.Notify("Portapapeles no disponible", "error"); return
    end
    local ok, err = SettingsRepository.import(json)
    if ok then
        ThemeEngine.applyFromState()
        U.Notify("Ajustes importados", "success")
    else
        U.Notify("Error: " .. tostring(err), "error")
    end
end)
utilBtn(Utility, "🖥️  Restablecer interfaz", function()
    VELORA.State.Window.Size     = VELORA.Defaults.Window.Size
    VELORA.State.Window.Position = VELORA.Defaults.Window.Position
    Window.Size     = VELORA.State.Window.Size
    Window.Position = VELORA.State.Window.Position
    U.Notify("Interfaz restablecida", "success")
end)

--== CUSTOMIZE ==
local Customize = addTab("CUSTOMIZE")

-- Temas
do
    local c = U.Create("Frame", {
        Size = UDim2.new(1, -8, 0, 76),
        BackgroundColor3 = Color3.fromHex("F0F1F3"),
        BorderSizePixel = 0,
        Parent = Customize,
    })
    U.Round(c, 12); U.Padding(c, 10)
    U.Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = "Tema",
        Font = Enum.Font.GothamBold, TextSize = 13,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = c,
    })
    local row = U.Create("Frame", {
        Size = UDim2.new(1, 0, 0, 34), Position = UDim2.new(0, 0, 0, 24),
        BackgroundTransparency = 1, Parent = c,
    })
    U.Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        Parent = row,
    })
    for name in pairs(VELORA.Themes) do
        local b = U.Create("TextButton", {
            Size = UDim2.new(0, 86, 1, 0),
            BackgroundColor3 = Color3.fromHex("FFFFFF"),
            Text = name,
            Font = Enum.Font.GothamBold, TextSize = 11,
            TextColor3 = Color3.fromHex("202126"),
            AutoButtonColor = false, BorderSizePixel = 0,
            Parent = row,
        })
        U.Round(b, 8); U.Stroke(b, Color3.fromHex("D9DADD"), 1)
        b.MouseButton1Click:Connect(function()
            ThemeEngine.setTheme(name)
            logAction("Tema: " .. name)
        end)
    end
end

-- Acento
do
    local c = U.Create("Frame", {
        Size = UDim2.new(1, -8, 0, 56),
        BackgroundColor3 = Color3.fromHex("F0F1F3"),
        BorderSizePixel = 0,
        Parent = Customize,
    })
    U.Round(c, 12); U.Padding(c, 10)
    U.Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = "Color de acento (hex)",
        Font = Enum.Font.GothamBold, TextSize = 13,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = c,
    })
    local input = U.Create("TextBox", {
        Size = UDim2.new(0, 120, 0, 26),
        Position = UDim2.new(0, 0, 0, 24),
        BackgroundColor3 = Color3.fromHex("FFFFFF"),
        Text = VELORA.State.Accent,
        Font = Enum.Font.Code, TextSize = 12,
        TextColor3 = Color3.fromHex("202126"),
        ClearTextOnFocus = false, BorderSizePixel = 0,
        Parent = c,
    })
    U.Round(input, 6); U.Stroke(input, Color3.fromHex("D9DADD"), 1)
    local apply = U.Create("TextButton", {
        Size = UDim2.new(0, 70, 0, 26),
        Position = UDim2.new(0, 130, 0, 24),
        BackgroundColor3 = Color3.fromHex("A78BFA"),
        Text = "Apply",
        Font = Enum.Font.GothamBold, TextSize = 12,
        TextColor3 = Color3.fromHex("FFFFFF"),
        AutoButtonColor = false, BorderSizePixel = 0, Parent = c,
    })
    U.Round(apply, 6)
    apply.MouseButton1Click:Connect(function()
        ThemeEngine.setAccent(input.Text)
        SoundManager.play("theme")
        U.Notify("Acento aplicado", "success")
    end)
end

-- Fondo personalizado
do
    local c = U.Create("Frame", {
        Size = UDim2.new(1, -8, 0, 200),
        BackgroundColor3 = Color3.fromHex("F0F1F3"),
        BorderSizePixel = 0, Parent = Customize,
    })
    U.Round(c, 12); U.Padding(c, 10)
    U.Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = "Fondo personalizado (Roblox Image ID)",
        Font = Enum.Font.GothamBold, TextSize = 13,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = c,
    })
    local input = U.Create("TextBox", {
        Size = UDim2.new(1, -180, 0, 28),
        Position = UDim2.new(0, 0, 0, 26),
        BackgroundColor3 = Color3.fromHex("FFFFFF"),
        PlaceholderText = "ej. 139086303945721",
        Text = VELORA.State.Background.ImageId,
        Font = Enum.Font.Code, TextSize = 12,
        TextColor3 = Color3.fromHex("202126"),
        ClearTextOnFocus = false, BorderSizePixel = 0, Parent = c,
    })
    U.Round(input, 6); U.Stroke(input, Color3.fromHex("D9DADD"), 1)

    local apply = U.Create("TextButton", {
        Size = UDim2.new(0, 80, 0, 28),
        Position = UDim2.new(1, -170, 0, 26),
        BackgroundColor3 = Color3.fromHex("A78BFA"),
        Text = "Apply",
        Font = Enum.Font.GothamBold, TextSize = 12,
        TextColor3 = Color3.fromHex("FFFFFF"),
        AutoButtonColor = false, BorderSizePixel = 0, Parent = c,
    })
    U.Round(apply, 6)

    local remove = U.Create("TextButton", {
        Size = UDim2.new(0, 80, 0, 28),
        Position = UDim2.new(1, -84, 0, 26),
        BackgroundColor3 = Color3.fromHex("FFFFFF"),
        Text = "Remove",
        Font = Enum.Font.GothamBold, TextSize = 12,
        TextColor3 = Color3.fromHex("202126"),
        AutoButtonColor = false, BorderSizePixel = 0, Parent = c,
    })
    U.Round(remove, 6); U.Stroke(remove, Color3.fromHex("D9DADD"), 1)

    local function setBg(id)
        if id == "" then
            VELORA.BackgroundImage.Image = ""
            U.Tween(VELORA.BackgroundImage, 0.3, { ImageTransparency = 1 })
            VELORA.State.Background.ImageId = ""
            return
        end
        local url = "rbxassetid://" .. tostring(id)
        VELORA.BackgroundImage.Image = url
        U.Tween(VELORA.BackgroundImage, 0.3, { ImageTransparency = 1 - VELORA.State.Background.Opacity })
        VELORA.State.Background.ImageId = tostring(id)
    end

    apply.MouseButton1Click:Connect(function()
        if input.Text == "" then
            U.Notify("Introduce un ID válido", "error"); SoundManager.play("error"); return
        end
        local n = tonumber(input.Text)
        if not n then U.Notify("ID no numérico", "error"); SoundManager.play("error"); return end
        setBg(input.Text)
        SoundManager.play("confirm")
        U.Notify("Fondo aplicado", "success")
    end)
    remove.MouseButton1Click:Connect(function()
        input.Text = ""
        setBg("")
        U.Notify("Fondo restaurado al predeterminado", "success")
    end)

    -- Opacidad del fondo
    local opLbl = U.Create("TextLabel", {
        Size = UDim2.new(0, 160, 0, 18),
        Position = UDim2.new(0, 0, 0, 64),
        BackgroundTransparency = 1,
        Text = "Opacidad del fondo: 35%",
        Font = Enum.Font.Gotham, TextSize = 12,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = c,
    })
    local opSlider = U.Create("Frame", {
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 84),
        BackgroundColor3 = Color3.fromHex("D9DADD"),
        BorderSizePixel = 0, Parent = c,
    })
    U.Round(opSlider, 10)
    local opFill = U.Create("Frame", {
        Size = UDim2.new(VELORA.State.Background.Opacity, 0, 1, 0),
        BackgroundColor3 = Color3.fromHex("A78BFA"),
        BorderSizePixel = 0, Parent = opSlider,
    })
    U.Round(opFill, 10)
    opSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            local function set()
                local mx = UserInputService:GetMouseLocation().X
                local abs = opSlider.AbsolutePosition.X
                local w   = opSlider.AbsoluteSize.X
                local v   = math.clamp((mx - abs) / w, 0, 1)
                opFill.Size = UDim2.new(v, 0, 1, 0)
                VELORA.State.Background.Opacity = v
                opLbl.Text = ("Opacidad del fondo: %d%%"):format(math.floor(v * 100))
                if VELORA.BackgroundImage.Image ~= "" then
                    VELORA.BackgroundImage.ImageTransparency = 1 - v
                end
            end
            set()
            local conn
            conn = UserInputService.InputChanged:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseMovement
                or i.UserInputType == Enum.UserInputType.Touch then
                    set()
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1
                or i.UserInputType == Enum.UserInputType.Touch then
                    if conn then conn:Disconnect() end
                end
            end)
        end
    end)
end

-- Sonidos
do
    local c = U.Create("Frame", {
        Size = UDim2.new(1, -8, 0, 120),
        BackgroundColor3 = Color3.fromHex("F0F1F3"),
        BorderSizePixel = 0, Parent = Customize,
    })
    U.Round(c, 12); U.Padding(c, 10)
    U.Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = "Sonidos de interfaz",
        Font = Enum.Font.GothamBold, TextSize = 13,
        TextColor3 = Color3.fromHex("202126"),
        TextXAlignment = Enum.TextXAlignment.Left, Parent = c,
    })
    local muteBtn = U.Create("TextButton", {
        Size = UDim2.new(0, 90, 0, 26),
        Position = UDim2.new(0, 0, 0, 24),
        BackgroundColor3 = VELORA.State.Sounds.Enabled and Color3.fromHex("A78BFA") or Color3.fromHex("FFFFFF"),
        Text = VELORA.State.Sounds.Enabled and "ON" or "OFF",
        Font = Enum.Font.GothamBold, TextSize = 12,
        TextColor3 = VELORA.State.Sounds.Enabled and Color3.fromHex("FFFFFF") or Color3.fromHex("202126"),
        AutoButtonColor = false, BorderSizePixel = 0, Parent = c,
    })
    U.Round(muteBtn, 8)
    muteBtn.MouseButton1Click:Connect(function()
        local on = not SoundManager.Enabled
        SoundManager.setEnabled(on)
        VELORA.State.Sounds.Enabled = on
        muteBtn.Text = on and "ON" or "OFF"
        muteBtn.BackgroundColor3 = on and Color3.fromHex("A78BFA") or Color3.fromHex("FFFFFF")
        muteBtn.TextColor3 = on and Color3.fromHex("FFFFFF") or Color3.fromHex("202126")
    end)
    for _, key in ipairs({"click", "enable", "disable", "tab", "theme", "error", "confirm"}) do
        local b = U.Create("TextButton", {
            Size = UDim2.new(0, 88, 0, 26),
            Position = UDim2.new(0, 100 + (#key * 0), 0, 60 + 0),
            BackgroundColor3 = Color3.fromHex("FFFFFF"),
            Text = "▶ " .. key,
            Font = Enum.Font.Gotham, TextSize = 11,
            TextColor3 = Color3.fromHex("202126"),
            AutoButtonColor = false, BorderSizePixel = 0, Parent = c,
        })
        U.Round(b, 6); U.Stroke(b, Color3.fromHex("D9DADD"), 1)
        b.MouseButton1Click:Connect(function() SoundManager.preview(key) end)
    end
end

--================================================================
-- 10. RESTORE ICON + SHUTDOWN + INIT
--================================================================
function VELORA.restoreIcon()
    if VELORA.RestoreIcon then return end
    local ri = U.Create("TextButton", {
        Name = "RestoreIcon",
        Size = UDim2.new(0, 56, 0, 56),
        Position = UDim2.new(0.05, 0, 0.85, 0),
        BackgroundColor3 = Color3.fromHex("A78BFA"),
        Text = "V",
        Font = Enum.Font.Fondamento, TextSize = 22,
        TextColor3 = Color3.fromHex("FFFFFF"),
        AutoButtonColor = false, BorderSizePixel = 0,
        Parent = VELORA.Root,
    })
    U.Round(ri, 28)
    U.Stroke(ri, Color3.fromHex("FFFFFF"), 2)
    ri.MouseButton1Click:Connect(function()
        SoundManager.play("restore")
        ri:Destroy()
        VELORA.RestoreIcon = nil
        Window.Visible = true
        Window.Size = VELORA.State.Window.Size
    end)
    VELORA.RestoreIcon = ri
end

function VELORA.shutdown()
    -- Detener módulos activos
    for id, on in pairs(ModuleRegistry.Enabled) do
        if on then ModuleRegistry.setEnabled(id, false) end
    end
    -- Limpiar conexiones
    if VELORA._espConns then
        for _, c in ipairs(VELORA._espConns) do pcall(function() c:Disconnect() end) end
        VELORA._espConns = nil
    end
    if VELORA._diagConn then VELORA._diagConn:Disconnect() end
    if VELORA._fullbrightCache then
        local c = VELORA._fullbrightCache
        Lighting.Brightness = c.Brightness
        Lighting.Ambient    = c.Ambient
        Lighting.OutdoorAmbient = c.OutdoorAmbient
    end
    -- Guardar preferencias finales
    pcall(function() SettingsRepository.save(VELORA.State) end)
    -- Destruir
    if VELORA.Root then VELORA.Root:Destroy() end
    if blur then blur:Destroy() end
    if VELORA.SoundsFolder then VELORA.SoundsFolder:Destroy() end
    _G.VELORA = nil
    U.Notify("VELORA cerrado correctamente", "success")
end

--== INIT ==
do
    -- Cargar config
    local loaded = SettingsRepository.load()
    if loaded then VELORA.State = SettingsRepository.mergeDefaults(loaded) end
    ThemeEngine.applyFromState()
    SoundManager.Enabled = VELORA.State.Sounds.Enabled
    SoundManager.setVolume(VELORA.State.Sounds.Volume)

    -- Aplicar fondo guardado
    if VELORA.State.Background.ImageId ~= "" then
        VELORA.BackgroundImage.Image = "rbxassetid://" .. VELORA.State.Background.ImageId
        VELORA.BackgroundImage.ImageTransparency = 1 - VELORA.State.Background.Opacity
    end

    -- Restaurar tamaño/posición
    Window.Size     = VELORA.State.Window.Size
    Window.Position = VELORA.State.Window.Position

    -- Pestaña inicial
    switchTab(VELORA.State.LastTab or "HOME")

    -- Crear botones flotantes guardados
    for id, _ in pairs(VELORA.State.Floating) do
        if ModuleRegistry.Modules[id] then FBM.create(id) end
    end

    -- Guardado automático periódico
    task.spawn(function()
        while VELORA.Root and VELORA.Root.Parent do
            task.wait(30)
            pcall(function() SettingsRepository.save(VELORA.State) end)
        end
    end)

    logAction("VELORA iniciado v" .. VELORA.Config.Version)
    U.Notify("VELORA listo · v" .. VELORA.Config.Version, "success")
end
