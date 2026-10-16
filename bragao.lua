-- ═══════════════════════════════════════════════════════════
--                NUEVA UI CON TABS (v2 · Minimalista)
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

-- ─── Fuente minimalista ───
local FONT      = Enum.Font.SourceSans
local FONT_SEMI = Enum.Font.SourceSansSemibold
local FONT_BOLD = Enum.Font.SourceSansBold

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

-- MAIN (más pequeña: 500x380)
local mainFrame = new("Frame", {
    Name = "MainFrame",
    Size = UDim2.fromOffset(500, 380),
    Position = UDim2.new(0.5, -250, 0.5, -190),
    BackgroundColor3 = T.BG,
    BorderSizePixel = 0, Active = true, ClipsDescendants = true,
}, screenGui)
corner(mainFrame, 10)
stroke(mainFrame, T.BORDER_HL, 1)

-- TITLEBAR
local titleBar = new("Frame", {
    Name = "TitleBar",
    Size = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = T.TITLEBAR,
    BorderSizePixel = 0,
}, mainFrame)
corner(titleBar, 10)
new("Frame", { BackgroundColor3 = T.TITLEBAR, Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14), BorderSizePixel = 0 }, titleBar)
new("Frame", { BackgroundColor3 = T.BORDER, Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, -1), BorderSizePixel = 0 }, titleBar)

-- Título con símbolo ◆
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

-- ✕ Cerrar
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

-- — Minimizar
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

-- ☰ toggle sidebar
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
    Position = UDim2.new(0, 0, 0, 36),
    Size = UDim2.new(1, 0, 1, -36),
}, mainFrame)

-- SIDEBAR
local sideW = 140
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
        tw(mainFrame, { Size = UDim2.fromOffset(260, 36) }, 0.2)
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

    tab.Button = new("TextButton", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, 32),
        Font = FONT,
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
        Size = UDim2.new(1, 0, 0, 26),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(sec, 6)
    stroke(sec, T.BORDER_HL, 1)
    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = FONT_SEMI, Text = title,
        TextColor3 = T.TEXT, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, sec)
    return sec
end

local function toggle(tab, cfg)
    cfg = cfg or {}
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, cfg.Desc and 48 or 38),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6)
    stroke(c, T.BORDER, 1)

    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, cfg.Desc and 6 or 0),
        Size = UDim2.new(1, -100, 0, cfg.Desc and 15 or 38),
        Font = FONT_SEMI,
        Text = cfg.Title or "Toggle",
        TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    if cfg.Desc and cfg.Desc ~= "" then
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 22),
            Size = UDim2.new(1, -100, 0, 13),
            Font = FONT,
            Text = cfg.Desc,
            TextColor3 = T.TEXT_DIM, TextSize = 10,
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
        Text = "", AutoButtonColor = false,
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

local function input(tab, cfg)
    cfg = cfg or {}
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, cfg.Desc and 72 or 58),
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
        TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    if cfg.Desc and cfg.Desc ~= "" then
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 22),
            Size = UDim2.new(1, -100, 0, 13),
            Font = FONT,
            Text = cfg.Desc,
            TextColor3 = T.TEXT_DIM, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end

    local boxY = (cfg.Desc and cfg.Desc ~= "") and 42 or 28
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
        PlaceholderText = cfg.Placeholder or "escribe aquí...",
        PlaceholderColor3 = T.TEXT_DIM,
        TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
    }, box)

    tb.FocusLost:Connect(function()
        if cfg.Callback then cfg.Callback(tb.Text) end
    end)
    return tb
end

-- ═══════════════════════════════════════════════════════════
-- WATERMARK (FPS + Ping)
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
    Text = "◆  BRAGAO HUB  ·  FPS: --  ·  -- ms",
    TextColor3 = T.TEXT,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Center,
}, wmFrame)

-- Contador de FPS
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

-- Actualizar watermark cada 0.5s
task.spawn(function()
    while true do
        task.wait(0.5)
        if watermarkEnabled then
            local ping = 0
            pcall(function()
                ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            wmLabel.Text = string.format("◆  BRAGAO HUB  ·  FPS: %d  ·  %d ms", currentFPS, ping)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- CREAR TABS Y OPCIONES (símbolos en vez de emojis)
-- ═══════════════════════════════════════════════════════════

local tabCombat    = createTab("⌖  Combat")
local tabAim       = createTab("◎  Aim")
local tabMovement  = createTab("➤  Movement")
local tabVisual    = createTab("◉  Visual")
local tabUtils     = createTab("⚙  Utils")

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
    Desc = "Muestra nombre, vida y distancia",
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

section(tabUtils, "Interfaz")
toggle(tabUtils, {
    Title = "Watermark",
    Desc = "Muestra FPS y Ping en pantalla",
    Value = false,
    Callback = function(v)
        watermarkEnabled = v
        wmFrame.Visible = v
        print("[Config] Watermark: " .. tostring(v))
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
print("   TABS: Combat · Aim · Movement · Visual · Utils")
print("")
