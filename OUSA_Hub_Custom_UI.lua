--[[ ==========================================================
     OUSA HUB - UI CUSTOM DESDE CERO
     PARTE 1: CORE (Window / Tabs / Sidebar / Minimize / Close)
     ========================================================== ]]

local UI = {}
UI.__index = UI

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

-- ================= TEMA =================
UI.Theme = {
    BG            = Color3.fromRGB(8, 8, 8),      -- fondo ventana
    PANEL         = Color3.fromRGB(14, 14, 14),   -- panel sidebar
    TITLEBAR      = Color3.fromRGB(12, 12, 12),
    ELEMENT       = Color3.fromRGB(20, 20, 20),   -- fondo módulo
    ELEMENT_HOVER = Color3.fromRGB(30, 30, 30),
    ELEMENT_ACTIVE= Color3.fromRGB(38, 38, 38),
    BORDER        = Color3.fromRGB(60, 60, 60),   -- borde gris
    BORDER_HL     = Color3.fromRGB(105, 105, 105),-- borde resaltado
    TEXT          = Color3.fromRGB(255, 255, 255),
    TEXT_DIM      = Color3.fromRGB(150, 150, 150),
    TOGGLE_ON     = Color3.fromRGB(255, 255, 255),
    TOGGLE_OFF    = Color3.fromRGB(45, 45, 45),
    CLOSE_HOVER   = Color3.fromRGB(175, 45, 45),
    MIN_HOVER     = Color3.fromRGB(55, 55, 55),
}
local T = UI.Theme

-- ================= HELPERS =================
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
local function tween(i, p, t)
    TweenService:Create(i, TweenInfo.new(t or 0.15), p):Play()
end

UI._new = new
UI._corner = corner
UI._stroke = stroke
UI._tween = tween

-- ================= SCREEN =================
local Screen = new("ScreenGui", {
    Name = "OUSA_Hub_UI",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
}, PG)
UI._screen = Screen

-- ================= NOTIFICACIONES =================
local NotifHolder = new("Frame", {
    Name = "Notifications",
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 300, 1, -40),
    Position = UDim2.new(1, -320, 0, 20),
}, Screen)
new("UIListLayout", {
    Padding = UDim.new(0, 8),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    SortOrder = Enum.SortOrder.LayoutOrder,
}, NotifHolder)

function UI:Notify(cfg)
    cfg = cfg or {}
    local card = new("Frame", {
        BackgroundColor3 = T.PANEL,
        Size = UDim2.new(1, 0, 0, 60),
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
    }, NotifHolder)
    corner(card, 6)
    stroke(card, T.BORDER, 1)

    new("Frame", {
        BackgroundColor3 = T.TEXT,
        Size = UDim2.new(0, 3, 1, 0),
        BorderSizePixel = 0,
    }, card)

    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 8),
        Size = UDim2.new(1, -20, 0, 18),
        Font = Enum.Font.GothamBold,
        Text = cfg.Title or "Notificación",
        TextColor3 = T.TEXT,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)

    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 28),
        Size = UDim2.new(1, -20, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham,
        Text = cfg.Content or "",
        TextColor3 = T.TEXT_DIM,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)

    card.BackgroundTransparency = 1
    tween(card, { BackgroundTransparency = 0 }, 0.15)
    task.delay(cfg.Duration or 3, function()
        if card.Parent then
            tween(card, { BackgroundTransparency = 1 }, 0.2)
            task.wait(0.2)
            card:Destroy()
        end
    end)
end

-- ================= TAB METHODS (se llenan en Parte 2) =================
UI.TabMethods = {}

-- ================= VENTANA =================
function UI:Window(cfg)
    cfg = cfg or {}
    local win = { Tabs = {}, ActiveTab = nil, SidebarOpen = true, Minimized = false }
    local W = cfg.Width or 820
    local H = cfg.Height or 560
    local sideW = cfg.SidebarWidth or 195

    -- MAIN
    local main = new("Frame", {
        Name = "Window",
        BackgroundColor3 = T.BG,
        Size = UDim2.fromOffset(W, H),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Active = true,
        ClipsDescendants = true,
    }, Screen)
    corner(main, 10)
    stroke(main, T.BORDER_HL, 1)
    win.Frame = main

    -- TITLE BAR
    local titleBar = new("Frame", {
        Name = "TitleBar",
        BackgroundColor3 = T.TITLEBAR,
        Size = UDim2.new(1, 0, 0, 38),
        BorderSizePixel = 0,
    }, main)
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

    -- ☰ Botón toggle sidebar
    local menuBtn = new("TextButton", {
        BackgroundColor3 = T.ELEMENT,
        Position = UDim2.new(0, 10, 0, 9),
        Size = UDim2.new(0, 28, 0, 20),
        Font = Enum.Font.GothamBold, Text = "☰",
        TextColor3 = T.TEXT, TextSize = 13,
        AutoButtonColor = false, BorderSizePixel = 0,
    }, titleBar)
    corner(menuBtn, 4)
    stroke(menuBtn, T.BORDER, 1)

    -- Título
    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 48, 0, 0),
        Size = UDim2.new(0, 300, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = cfg.Title or "Window",
        TextColor3 = T.TEXT, TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, titleBar)

    -- Autor
    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -240, 0, 0),
        Size = UDim2.new(0, 130, 1, 0),
        Font = Enum.Font.Gotham,
        Text = cfg.Author or "",
        TextColor3 = T.TEXT_DIM, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, titleBar)

    -- ✕ Cerrar
    local closeBtn = new("TextButton", {
        BackgroundColor3 = T.ELEMENT,
        Position = UDim2.new(1, -38, 0, 9),
        Size = UDim2.new(0, 28, 0, 20),
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
        Size = UDim2.new(0, 28, 0, 20),
        Font = Enum.Font.GothamBold, Text = "—",
        TextColor3 = T.TEXT, TextSize = 14,
        AutoButtonColor = false, BorderSizePixel = 0,
    }, titleBar)
    corner(minBtn, 4)
    stroke(minBtn, T.BORDER, 1)

    -- BODY
    local body = new("Frame", {
        Name = "Body",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 38),
        Size = UDim2.new(1, 0, 1, -38),
    }, main)

    -- SIDEBAR
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
        Name = "TabList",
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

    -- CONTENT
    local content = new("Frame", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, sideW, 0, 0),
        Size = UDim2.new(1, -sideW, 1, 0),
    }, body)

    -- DRAG
    local dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = main.Position
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
            main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)

    -- HOVERS
    menuBtn.MouseEnter:Connect(function()  tween(menuBtn,  { BackgroundColor3 = T.ELEMENT_HOVER }) end)
    menuBtn.MouseLeave:Connect(function()  tween(menuBtn,  { BackgroundColor3 = T.ELEMENT }) end)
    minBtn.MouseEnter:Connect(function()   tween(minBtn,   { BackgroundColor3 = T.MIN_HOVER }) end)
    minBtn.MouseLeave:Connect(function()   tween(minBtn,   { BackgroundColor3 = T.ELEMENT }) end)
    closeBtn.MouseEnter:Connect(function() tween(closeBtn, { BackgroundColor3 = T.CLOSE_HOVER }) end)
    closeBtn.MouseLeave:Connect(function() tween(closeBtn, { BackgroundColor3 = T.ELEMENT }) end)

    -- ☰ TOGGLE SIDEBAR
    menuBtn.MouseButton1Click:Connect(function()
        win.SidebarOpen = not win.SidebarOpen
        if win.SidebarOpen then
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
    local savedSize = main.Size
    minBtn.MouseButton1Click:Connect(function()
        win.Minimized = not win.Minimized
        if win.Minimized then
            savedSize = main.Size
            body.Visible = false
            tween(main, { Size = UDim2.fromOffset(320, 38) }, 0.2)
        else
            body.Visible = true
            tween(main, { Size = savedSize }, 0.2)
        end
    end)

    -- ✕ CLOSE
    closeBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        if win.OpenBtn then win.OpenBtn.Visible = true end
    end)

    -- ================= TAB =================
    function win:Tab(title)
        local tab = setmetatable({}, { __index = UI.TabMethods })
        tab.Title = title or "Tab"

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

        local tabBtn = new("TextButton", {
            BackgroundColor3 = T.ELEMENT,
            Size = UDim2.new(1, 0, 0, 34),
            Font = Enum.Font.Gotham,
            Text = "  " .. tab.Title,
            TextColor3 = T.TEXT,
            TextSize = 12,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, tabList)
        corner(tabBtn, 5)
        local tabStroke = stroke(tabBtn, T.BORDER, 1)
        tab.Button = tabBtn
        tab.Stroke = tabStroke

        tabBtn.MouseEnter:Connect(function()
            if win.ActiveTab ~= tab then
                tween(tabBtn, { BackgroundColor3 = T.ELEMENT_HOVER })
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if win.ActiveTab ~= tab then
                tween(tabBtn, { BackgroundColor3 = T.ELEMENT })
            end
        end)

        function tab:Select()
            if win.ActiveTab and win.ActiveTab ~= tab then
                win.ActiveTab.Content.Visible = false
                tween(win.ActiveTab.Button, { BackgroundColor3 = T.ELEMENT })
                win.ActiveTab.Stroke.Color = T.BORDER
            end
            win.ActiveTab = tab
            tab.Content.Visible = true
            tween(tabBtn, { BackgroundColor3 = T.ELEMENT_ACTIVE })
            tabStroke.Color = T.TEXT
        end

        tabBtn.MouseButton1Click:Connect(function() tab:Select() end)

        table.insert(win.Tabs, tab)
        if #win.Tabs == 1 then tab:Select() end
        return tab
    end

    -- ================= TECLA TOGGLE =================
    function win:ToggleKey(key)
        UIS.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == key then
                main.Visible = not main.Visible
                if win.OpenBtn then win.OpenBtn.Visible = not main.Visible end
            end
        end)
    end

    -- ================= BOTÓN ABRIR =================
    function win:OpenButton(cfg)
        cfg = cfg or {}
        local ob = new("TextButton", {
            Name = "OpenButton",
            BackgroundColor3 = T.BG,
            Size = UDim2.new(0, 155, 0, 36),
            Position = UDim2.new(0, 20, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = cfg.Title or "Abrir UI",
            TextColor3 = T.TEXT, TextSize = 12,
            AutoButtonColor = false, Visible = false,
        }, Screen)
        corner(ob, 6)
        stroke(ob, T.BORDER_HL, 1)

        ob.MouseButton1Click:Connect(function()
            main.Visible = true
            ob.Visible = false
        end)
        win.OpenBtn = ob

        local ds, sp
        ob.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
                ds = i.Position; sp = ob.Position
                local c
                c = i.Changed:Connect(function()
                    if i.UserInputState == Enum.UserInputState.End then
                        ds = nil; c:Disconnect()
                    end
                end)
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if ds and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
                local d = i.Position - ds
                ob.Position = UDim2.new(
                    sp.X.Scale, sp.X.Offset + d.X,
                    sp.Y.Scale, sp.Y.Offset + d.Y)
            end
        end)
        return ob
    end

    return win
end

-- Al final de la Parte 1, guardamos UI para la Parte 2
getgenv().OUSA_UI = UI
return UI
--[[ ==========================================================
     PARTE 2: COMPONENTES DE TAB
     Toggle / Slider / Input / Button / Section / Divider /
     Label / Keybind  — cada uno con borde gris
     ========================================================== ]]

local UI = getgenv().OUSA_UI
local T = UI.Theme
local new = UI._new
local corner = UI._corner
local stroke = UI._stroke
local tween = UI._tween
local UIS = game:GetService("UserInputService")
local TM = UI.TabMethods

-- ============ HELPERS INTERNOS ============
local function card(tab, height)
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT,
        Size = UDim2.new(1, 0, 0, height or 50),
        BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6)
    stroke(c, T.BORDER, 1)
    return c
end

local function addTitle(c, cfg)
    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 7),
        Size = UDim2.new(1, -100, 0, 16),
        Font = Enum.Font.GothamBold,
        Text = cfg.Title or "",
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
end

-- ============ SECTION (título grupo) ============
function TM:Section(title)
    local sec = new("Frame", {
        BackgroundColor3 = T.PANEL,
        Size = UDim2.new(1, 0, 0, 28),
        BorderSizePixel = 0,
    }, self.Content)
    corner(sec, 6)
    stroke(sec, T.BORDER_HL, 1)
    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = title or "Section",
        TextColor3 = T.TEXT, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, sec)
    return sec
end

-- ============ DIVIDER ============
function TM:Divider()
    return new("Frame", {
        BackgroundColor3 = T.BORDER,
        Size = UDim2.new(1, 0, 0, 1),
        BorderSizePixel = 0,
    }, self.Content)
end

-- ============ LABEL ============
function TM:Label(cfg)
    cfg = cfg or {}
    return new("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
        Font = Enum.Font.Gotham,
        Text = cfg.Title or (type(cfg) == "string" and cfg or ""),
        TextColor3 = T.TEXT_DIM, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, self.Content)
end

-- ============ BUTTON ============
function TM:Button(cfg)
    cfg = cfg or {}
    local c = card(self, 50)
    addTitle(c, cfg)

    local btn = new("TextButton", {
        BackgroundColor3 = T.TOGGLE_OFF,
        Position = UDim2.new(1, -90, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 80, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = cfg.ButtonText or "Ejecutar",
        TextColor3 = T.TEXT, TextSize = 11,
        AutoButtonColor = false, BorderSizePixel = 0,
    }, c)
    corner(btn, 5)
    stroke(btn, T.BORDER, 1)

    btn.MouseEnter:Connect(function() tween(btn, { BackgroundColor3 = T.ELEMENT_HOVER }) end)
    btn.MouseLeave:Connect(function() tween(btn, { BackgroundColor3 = T.TOGGLE_OFF }) end)
    btn.MouseButton1Click:Connect(function()
        if cfg.Callback then cfg.Callback() end
    end)
    return btn
end

-- ============ TOGGLE ============
function TM:Toggle(cfg)
    cfg = cfg or {}
    local c = card(self, cfg.Desc and cfg.Desc ~= "" and 52 or 42)
    addTitle(c, cfg)

    local switch = new("Frame", {
        BackgroundColor3 = cfg.Value and T.TOGGLE_ON or T.TOGGLE_OFF,
        Position = UDim2.new(1, -60, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 46, 0, 24),
        BorderSizePixel = 0,
    }, c)
    corner(switch, 12)
    stroke(switch, T.BORDER, 1)

    local knob = new("Frame", {
        BackgroundColor3 = T.TEXT,
        Position = cfg.Value and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2),
        Size = UDim2.new(0, 20, 0, 20),
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
        tween(switch, { BackgroundColor3 = state and T.TOGGLE_ON or T.TOGGLE_OFF }, 0.2)
        tween(knob, { Position = state and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2) }, 0.2)
        if cfg.Callback then cfg.Callback(state) end
    end)
    return {
        Set = function(_, v)
            state = v
            tween(switch, { BackgroundColor3 = state and T.TOGGLE_ON or T.TOGGLE_OFF }, 0.2)
            tween(knob, { Position = state and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2) }, 0.2)
        end
    }
end

-- ============ SLIDER ============
function TM:Slider(cfg)
    cfg = cfg or {}
    local c = card(self, 64)
    local min = cfg.Min or 0
    local max = cfg.Max or 100
    local step = cfg.Step or 1
    local val = cfg.Default or min

    new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 7),
        Size = UDim2.new(1, -100, 0, 16),
        Font = Enum.Font.GothamBold,
        Text = cfg.Title or "Slider",
        TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)

    local valLbl = new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -80, 0, 7),
        Size = UDim2.new(0, 68, 0, 16),
        Font = Enum.Font.GothamBold,
        Text = tostring(val),
        TextColor3 = T.TEXT, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, c)

    local barBg = new("Frame", {
        BackgroundColor3 = T.TOGGLE_OFF,
        Position = UDim2.new(0, 12, 0, 40),
        Size = UDim2.new(1, -24, 0, 8),
        BorderSizePixel = 0,
    }, c)
    corner(barBg, 4)
    stroke(barBg, T.BORDER, 1)

    local fill = new("Frame", {
        BackgroundColor3 = T.TEXT,
        Size = UDim2.new(0, 0, 1, 0),
        BorderSizePixel = 0,
    }, barBg)
    corner(fill, 4)

    local knob = new("Frame", {
        BackgroundColor3 = T.TEXT,
        Size = UDim2.new(0, 14, 0, 14),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        BorderSizePixel = 0,
    }, barBg)
    corner(knob, 7)
    stroke(knob, T.BORDER, 1)

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
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setFromX(i.Position.X)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then
            setFromX(i.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    return { Set = function(_, v) val = v; upd(v) end }
end

-- ============ INPUT (TextBox) ============
function TM:Input(cfg)
    cfg = cfg or {}
    local c = card(self, cfg.Desc and cfg.Desc ~= "" and 78 or 62)

    addTitle(c, cfg)

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

-- ============ KEYBIND ============
function TM:Keybind(cfg)
    cfg = cfg or {}
    local c = card(self, 42)
    addTitle(c, cfg)

    local cur = cfg.Value or "E"
    local btn = new("TextButton", {
        BackgroundColor3 = T.TOGGLE_OFF,
        Position = UDim2.new(1, -80, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 68, 0, 26),
        Font = Enum.Font.GothamBold,
        Text = tostring(cur),
        TextColor3 = T.TEXT, TextSize = 11,
        AutoButtonColor = false, BorderSizePixel = 0,
    }, c)
    corner(btn, 5)
    stroke(btn, T.BORDER, 1)

    local listening = false
    btn.MouseButton1Click:Connect(function()
        listening = true
        btn.Text = "..."
    end)

    UIS.InputBegan:Connect(function(input, gp)
        if not listening then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            cur = input.KeyCode.Name
            btn.Text = cur
            listening = false
            if cfg.Callback then cfg.Callback(cur) end
        end
    end)
    return btn
end
--[[ ==========================================================
     PARTE 3: INTEGRACIÓN CON EL SCRIPT OUSA HUB
     ========================================================== ]]

local UI = getgenv().OUSA_UI
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local cam = workspace.CurrentCamera
local DashRemote = ReplicatedStorage.Resources.Brother["#Friend"].Communicate

-- ================= WEBHOOK =================
local webhook = "https://discord.com/api/webhooks/1554482088869371908/BDQlRiXrzBgIdu2v4wedTNZprXGHPEt4l75kCCVqYxmuIjpmWcF1POPdoVoqG1Mq4qMo"
local executor = "Unknown"
pcall(function() if identifyexecutor then executor = identifyexecutor() end end)

local payload = HttpService:JSONEncode({
    username = "executor info",
    embeds = {{
        title = "Script Executed", color = 65280,
        fields = {
            { name = "Username", value = player.Name, inline = true },
            { name = "UserId", value = tostring(player.UserId), inline = true },
            { name = "Executor", value = executor, inline = true },
            { name = "PlaceId", value = tostring(game.PlaceId), inline = true }
        }
    }}
})
local req = (syn and syn.request) or request or http_request
if req then
    req({ Url = webhook, Method = "POST",
        Headers = { ["Content-Type"] = "application/json" }, Body = payload })
end

-- ================= VENTANA =================
local Window = UI:Window({
    Title = "OUSA Hub",
    Author = "by archi",
    Width = 820,
    Height = 560,
    SidebarWidth = 200,
})
Window:ToggleKey(Enum.KeyCode.K)
Window:OpenButton({ Title = "OUSA Hub by archi" })

UI:Notify({ Title = "OUSA Hub is Back", Content = "Launched OUSA hub 6.7", Duration = 4 })

-- ================= TABS (una por tech) =================
local main        = Window:Tab("Main")
local Techs       = Window:Tab("Techs/Macro")
local meowtech    = Window:Tab("meowtech/uppercut")
local k1ngtech    = Window:Tab("k1ng tech/uppercut")
local oreo        = Window:Tab("Oreo tech/uppercut")
local kitty       = Window:Tab("kitty tech/uppercut")
local kak         = Window:Tab("kakyo tech/uppercut")
local inner       = Window:Tab("inner dash/uppercut")
local instanttwis = Window:Tab("instant twisted/m4")
local lethal      = Window:Tab("lethal/lethalwhirlwind")
local tech        = Window:Tab("kyoto")
local plat        = Window:Tab("youtube/tiktok/discord")
local tp          = Window:Tab("teleport")
local esp         = Window:Tab("Esp")
local M1reset     = Window:Tab("m1 reset")
local reduce      = Window:Tab("reduce lag")

-- ================= VARIABLES DE ESTADO =================
local UPPERCUT = {
    ["rbxassetid://10503381238"] = true,
    ["rbxassetid://13379003796"] = true,
}
local REQUIRED_ANIM_FOR_ATTACH = 10479335397
local TARGET_ANIM_ID = 12296113986
local M4_ANIM_ID = 13294471966

local hrp, followConnection, attached
local MeowTechEnabled, lethalEnabled, KingTechEnabled, LethalDashEnabled
local attachCooldown, AutoKyotoEnabled, lunarextender
local AutoKyotoLegitEnabled, oreov2, oreorev, kyokiedash
local didUppercut, dripz, GlobalCooldown, GlobalCooldownTime = false, false, false, 5
local instanttwistedv2, instantlethal, deathcounter
local AutoKyototween, meowtechv2, boomy, kakyo
local innerdash, innerlethal, supatech, leeinstanttwisted, kyokie
local instanttwisted

-- Config
local meowstart, meowDuration = 0.3, 0.3
local kingstart, kingwait = 0.3, 0.2
local oreostart, oreowait, oreocam, oreojump, oreodur = 0.3, 0.5, 1, 54, 0.2
local kittystartjump, kittystart, kittywait, kittycam, kittydur = 0.1, 0.3, 0.1, 1, 0.2
local kakyostart, kakyojump, kakyocam = 0.3, 40, 4
local waitpress, leewait, turn, leewait2, turn2 = 0.2, 0.2, -90, 0.05, 115
local meowlethalstart, meowlethaldur = 1.7, 0.5
local normallethalstart, secondforflip = 1.7, 0.2
local instantlethalstart, instantlethalwait = 1.7, 0.5
local boomystart, boomyjump, boomywait, boomycam = 1.7, 65, 0.1, 3

-- ================= FUNCIONES BASE =================
local function getRoot(char)
    return char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("LowerTorso")
        or char:FindFirstChild("Torso")
end

local function getClosestEnemy(maxDist)
    if not hrp then return nil end
    local liveFolder = workspace:FindFirstChild("Live")
    if not liveFolder then return nil end
    local best, bestDist = nil, maxDist
    for _, model in ipairs(liveFolder:GetChildren()) do
        if model:IsA("Model") and model ~= player.Character then
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local root = getRoot(model)
                if root then
                    local dist = (root.Position - hrp.Position).Magnitude
                    if dist < bestDist then best = root; bestDist = dist end
                end
            end
        end
    end
    return best
end

local function fireQ()
    DashRemote:FireServer({ [1] = { Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = "KeyPress" } })
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end

local function autoPressQ()
    DashRemote:FireServer({ [1] = { Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = "KeyPress" } })
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end

local function forceJump(height)
    height = height or 50
    local ch = player.Character
    if not ch then return end
    local r = ch:FindFirstChild("HumanoidRootPart")
    if not r then return end
    r.Velocity = Vector3.new(r.Velocity.X, height, r.Velocity.Z)
end

local function flip()
    if cam then
        local cf = cam.CFrame
        local look = cf.LookVector
        cam.CFrame = CFrame.new(cf.Position, cf.Position + Vector3.new(-look.X, look.Y, -look.Z))
    end
end

local function detach()
    if followConnection then followConnection:Disconnect(); followConnection = nil end
    attached = false
end

local function attachTo(enemyHRP, duration, ignoreAnim)
    if attached then return end
    enemyHRP = getRoot(enemyHRP.Parent)
    if not hrp or not enemyHRP then return end
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    if not ignoreAnim then
        local playing = false
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            local id = tonumber(track.Animation.AnimationId:match("%d+"))
            if id == REQUIRED_ANIM_FOR_ATTACH then playing = true; break end
        end
        if not playing then return end
    end
    attached = true
    local start = tick()
    followConnection = RunService.Heartbeat:Connect(function()
        if not enemyHRP or not enemyHRP.Parent then detach(); return end
        hrp.CFrame = CFrame.new(enemyHRP.Position + Vector3.new(0,1,0)) * CFrame.Angles(math.rad(90),0,0)
        if tick() - start >= (duration or 0.3) then detach() end
    end)
end

local function attachUnderTarget(targetChar, duration)
    if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return end
    local ch = player.Character
    if not ch or not ch:FindFirstChild("HumanoidRootPart") then return end
    local endT = os.clock() + duration
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if os.clock() >= endT then conn:Disconnect(); return end
        if ch and ch:FindFirstChild("HumanoidRootPart") then
            ch.HumanoidRootPart.CFrame =
                CFrame.new(targetChar.HumanoidRootPart.Position + Vector3.new(0,3,0))
                * CFrame.Angles(math.rad(90),0,0)
        end
    end)
end

local function doTwisted2()
    local myChar = player.Character
    local myHRP = myChar and getRoot(myChar)
    if not myHRP then return end
    local nearest, shortest = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local t = getRoot(p.Character)
            if t then
                local d = (t.Position - myHRP.Position).Magnitude
                if d < shortest then shortest = d; nearest = t end
            end
        end
    end
    if not nearest then return end
    cam.CFrame = CFrame.new(cam.CFrame.Position, nearest.Position)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    local function rot(a)
        local cf = cam.CFrame
        local look = cf.LookVector
        local flat = Vector3.new(look.X, 0, look.Z)
        if flat.Magnitude == 0 then flat = Vector3.new(0,0,1) end
        flat = flat.Unit
        local r = CFrame.fromAxisAngle(Vector3.yAxis, math.rad(a))
        cam.CFrame = CFrame.new(cf.Position, cf.Position + (r * flat + Vector3.new(0, look.Y, 0)))
    end
    rot(-70); task.wait(0.5); rot(120)
end

-- Anti death
workspace.FallenPartsDestroyHeight = 0/0
workspace:GetPropertyChangedSignal("FallenPartsDestroyHeight"):Connect(function()
    workspace.FallenPartsDestroyHeight = 0/0
end)

local function AntiDeath(char)
    local hum = char:WaitForChild("Humanoid")
    local r = char:WaitForChild("HumanoidRootPart")
    local lastHealth
    RunService.RenderStepped:Connect(function() lastHealth = hum.Health end)
    hum:GetPropertyChangedSignal("Health"):Connect(function()
        if hum.Health <= 0 and r.Position.Y <= 0 then hum.Health = lastHealth end
    end)
end
if player.Character then AntiDeath(player.Character) end
player.CharacterAdded:Connect(AntiDeath)

-- Fling loop
local hiddenfling = false
local flingPower = 10000
task.spawn(function()
    local vel, movel = nil, 0.1
    while true do
        RunService.Heartbeat:Wait()
        if hiddenfling then
            local c = player.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if r then
                vel = r.Velocity
                r.Velocity = vel * flingPower + Vector3.new(0, flingPower, 0)
                RunService.RenderStepped:Wait()
                if c and r then r.Velocity = vel end
                RunService.Stepped:Wait()
                if c and r then
                    r.Velocity = vel + Vector3.new(0, movel, 0)
                    movel = movel * -1
                end
            end
        end
    end
end)

-- ================= SETUP CHARACTER (animaciones) =================
local onCooldown = false
local function setupCharacter(char)
    local humanoid = char:WaitForChild("Humanoid")
    hrp = getRoot(char)
    attached = false
    attachCooldown = false
    if followConnection then followConnection:Disconnect(); followConnection = nil end

    humanoid.Died:Connect(function()
        attached = false
        if followConnection then followConnection:Disconnect(); followConnection = nil end
        hrp = nil
    end)

    humanoid.AnimationPlayed:Connect(function(track)
        local anim = track.Animation
        if not anim then return end
        local animIdNumber = tonumber(anim.AnimationId:match("%d+"))

        if UPPERCUT[anim.AnimationId] then
            didUppercut = true
            task.delay(0.6, function() didUppercut = false end)
        end

        if animIdNumber == REQUIRED_ANIM_FOR_ATTACH then
            -- global cooldown
        end

        if animIdNumber == 10479335397 then
            onCooldown = true
            task.delay(5, function() onCooldown = false end)
        end

        -- MeowTech
        if MeowTechEnabled and UPPERCUT[anim.AnimationId] and not attachCooldown then
            local e = getClosestEnemy(10)
            if e then
                task.delay(meowstart, function() fireQ(); attachTo(e, meowDuration) end)
            end
        end
        -- MeowTech v2
        if meowtechv2 and UPPERCUT[anim.AnimationId] and not onCooldown then
            local e = getClosestEnemy(10)
            if e then task.delay(meowstart, function() autoPressQ(); attachUnderTarget(e.Parent, meowDuration) end) end
        end
        -- KingTech
        if KingTechEnabled and UPPERCUT[anim.AnimationId] and not onCooldown then
            local e = getClosestEnemy(10)
            if e then
                task.delay(kingstart, function()
                    autoPressQ(); forceJump()
                    task.delay(kingwait, flip)
                end)
            end
        end
        -- Kakyo
        if kakyo and UPPERCUT[anim.AnimationId] and not onCooldown then
            local e = getClosestEnemy(10)
            if e then task.delay(kakyostart, function() forceJump(kakyojump) end) end
        end
        -- Oreo
        if dripz and UPPERCUT[anim.AnimationId] and not onCooldown then
            local e = getClosestEnemy(10)
            if e then
                task.delay(oreostart, function() autoPressQ(); forceJump(oreojump) end)
            end
        end
        -- Kitty
        if oreov2 and UPPERCUT[anim.AnimationId] and not onCooldown then
            local e = getClosestEnemy(10)
            if e then
                task.delay(kittystartjump, function() forceJump(60) end)
                task.delay(kittystart, function() autoPressQ(); flip() end)
            end
        end

        -- Auto Kyoto
        if AutoKyotoEnabled and animIdNumber == 12273188754 then
            task.delay(1.6, function()
                local c = player.Character
                local r = c and c:FindFirstChild("HumanoidRootPart")
                if r then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Two, false, game)
                    local look = r.CFrame.LookVector
                    local h = Vector3.new(look.X, 0, look.Z)
                    if h.Magnitude > 0 then h = h.Unit end
                    r.CFrame = r.CFrame + h * 22
                end
            end)
        end
        if AutoKyototween and animIdNumber == 12273188754 then
            task.delay(1.6, function()
                local c = player.Character
                local r = c and c:FindFirstChild("HumanoidRootPart")
                if r then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Two, false, game)
                    local conn
                    conn = RunService.Heartbeat:Connect(function()
                        r.AssemblyLinearVelocity = r.CFrame.LookVector * 150
                    end)
                    task.delay(0.1, function() conn:Disconnect() end)
                end
            end)
        end

        -- Lethal
        if lethalEnabled and animIdNumber == TARGET_ANIM_ID then
            task.spawn(function()
                task.delay(meowlethalstart, function()
                    local e = getClosestEnemy(10)
                    if e then fireQ(); attachTo(e, 0.5, true) end
                end)
            end)
        end
        if LethalDashEnabled and animIdNumber == TARGET_ANIM_ID then
            task.spawn(function()
                task.delay(normallethalstart, function()
                    forceJump(); autoPressQ()
                    task.delay(secondforflip, flip)
                end)
            end)
        end
        -- Instant Lethal
        if instantlethal and animIdNumber == TARGET_ANIM_ID and not onCooldown then
            local e = getClosestEnemy(10)
            if e then
                task.delay(instantlethalstart, function()
                    autoPressQ(); forceJump(60)
                end)
            end
        end
        -- Boomy
        if boomy and animIdNumber == TARGET_ANIM_ID then
            local e = getClosestEnemy(10)
            if e then
                task.delay(boomystart, function()
                    autoPressQ(); flip(); forceJump(boomyjump)
                end)
            end
        end
        -- Instant twisted (m4)
        if instanttwisted and animIdNumber == M4_ANIM_ID and not onCooldown then
            local e = getClosestEnemy(12)
            if e then task.delay(0.25, doTwisted2) end
        end
        -- Lee instant twisted
        if leeinstanttwisted and animIdNumber == M4_ANIM_ID and not onCooldown then
            task.delay(waitpress, function()
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                task.wait(leewait)
                cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(turn), 0)
                task.wait(leewait2)
                cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(turn2), 0)
            end)
        end
        -- Inner lethal
        if innerlethal and animIdNumber == TARGET_ANIM_ID then
            task.spawn(function()
                task.delay(1.7, function()
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                end)
            end)
        end
    end)
end

player.CharacterAdded:Connect(setupCharacter)
if player.Character then setupCharacter(player.Character) end

-- ================= UI: MAIN TAB =================
local walkSpeedValue = 23
local WalkSpeedEnabled = false

main:Section("Personaje")
main:Toggle({
    Title = "Enable WalkSpeed",
    Desc = "también evita stun",
    Value = false,
    Callback = function(s)
        WalkSpeedEnabled = s
        local ch = player.Character
        if ch and ch:FindFirstChild("Humanoid") then
            ch.Humanoid.WalkSpeed = s and walkSpeedValue or 23
        end
    end
})
main:Slider({
    Title = "WalkSpeed",
    Min = 0, Max = 1000, Step = 1, Default = 23,
    Callback = function(v)
        walkSpeedValue = v
        if WalkSpeedEnabled then
            local ch = player.Character
            if ch and ch:FindFirstChild("Humanoid") then ch.Humanoid.WalkSpeed = v end
        end
    end
})

main:Section("Extras")
main:Toggle({ Title = "touch fling", Desc = "fling al tocar",
    Value = false, Callback = function(v) hiddenfling = v end })
main:Toggle({ Title = "No Dash Cooldown", Desc = "quita cooldown del dash",
    Value = false, Callback = function(s)
        workspace:SetAttribute("EffectAffects", 1)
        workspace:SetAttribute("NoDashCooldown", s)
    end })
main:Toggle({ Title = "anti death counter", Desc = "no morir en death counter",
    Value = false, Callback = function(v) deathcounter = v end })

-- ================= UI: TECHS / MACRO =================
Techs:Section("Toggles de Techs")
Techs:Toggle({ Title = "Enable inner dash (100%)", Value = false, Callback = function(s) innerdash = s end })
Techs:Toggle({ Title = "Enable MeowTech",        Value = false, Callback = function(s) MeowTechEnabled = s end })
Techs:Toggle({ Title = "Enable MeowTechv2",      Value = false, Callback = function(s) meowtechv2 = s end })
Techs:Toggle({ Title = "Enable K1ng tech",       Value = false, Callback = function(s) KingTechEnabled = s end })
Techs:Toggle({ Title = "Enable oreo tech",       Value = false, Callback = function(s) dripz = s end })
Techs:Toggle({ Title = "kitty dash",             Value = false, Callback = function(s) oreov2 = s end })
Techs:Toggle({ Title = "kakyo under flip(new)",  Value = false, Callback = function(s) kakyo = s end })
Techs:Toggle({ Title = "lee instant twisted",    Value = false, Callback = function(s) leeinstanttwisted = s end })
Techs:Toggle({ Title = "MeowTech + lethal",      Value = false, Callback = function(s) lethalEnabled = s end })
Techs:Toggle({ Title = "LethalDash Enabled",     Value = false, Callback = function(s) LethalDashEnabled = s end })
Techs:Toggle({ Title = "Instant lethal",         Value = false, Callback = function(s) instantlethal = s end })
Techs:Toggle({ Title = "booomy instant lethal",  Value = false, Callback = function(s) boomy = s end })
Techs:Toggle({ Title = "inner lethal(90% headglide)", Value = false, Callback = function(s) innerlethal = s end })

-- ================= UI: MEOWTECH =================
meowtech:Section("MeowTech Settings")
meowtech:Input({ Title = "Start Time", Desc = "cuando inicia la tech",
    Value = "0.3", Callback = function(i) meowstart = tonumber(i) or meowstart end })
meowtech:Input({ Title = "Duration", Desc = "cuánto dura la tech",
    Value = "0.3", Callback = function(i) meowDuration = tonumber(i) or meowDuration end })

-- ================= UI: K1NG =================
k1ngtech:Section("K1ng Tech Settings")
k1ngtech:Input({ Title = "Start Time", Desc = "cuándo inicia",
    Value = "0.3", Callback = function(i) kingstart = tonumber(i) or kingstart end })
k1ngtech:Input({ Title = "Flip Time", Desc = "cuándo hace flip",
    Value = "0.2", Callback = function(i) kingwait = tonumber(i) or kingwait end })

-- ================= UI: OREO =================
oreo:Section("Oreo Tech Settings")
oreo:Input({ Title = "Start Time",  Value = "0.3", Callback = function(i) oreostart = tonumber(i) or oreostart end })
oreo:Input({ Title = "Rotation time", Value = "0.5", Callback = function(i) oreowait = tonumber(i) or oreowait end })
oreo:Input({ Title = "Camera speed", Value = "1",   Callback = function(i) oreocam = tonumber(i) or oreocam end })
oreo:Input({ Title = "Oreo duration", Value = "0.2", Callback = function(i) oreodur = tonumber(i) or oreodur end })
oreo:Input({ Title = "Jump height",  Value = "54",  Callback = function(i) oreojump = tonumber(i) or oreojump end })

-- ================= UI: KITTY =================
kitty:Section("Kitty Tech Settings")
kitty:Input({ Title = "Kitty jump",   Value = "0.1", Callback = function(i) kittystartjump = tonumber(i) or kittystartjump end })
kitty:Input({ Title = "Start Time",   Value = "0.3", Callback = function(i) kittystart = tonumber(i) or kittystart end })
kitty:Input({ Title = "Rotate Time",  Value = "0.1", Callback = function(i) kittywait = tonumber(i) or kittywait end })
kitty:Input({ Title = "Camera speed", Value = "1",   Callback = function(i) kittycam = tonumber(i) or kittycam end })
kitty:Input({ Title = "Kitty duration", Value = "0.2", Callback = function(i) kittydur = tonumber(i) or kittydur end })

-- ================= UI: KAKYO =================
kak:Section("Kakyo Tech Settings")
kak:Input({ Title = "Start Time", Value = "0.3", Callback = function(i) kakyostart = tonumber(i) or kakyostart end })
kak:Input({ Title = "Kakyo jump height", Value = "40", Callback = function(i) kakyojump = tonumber(i) or kakyojump end })
kak:Input({ Title = "Camera speed", Value = "4", Callback = function(i) kakyocam = tonumber(i) or kakyocam end })

-- ================= UI: INSTANT TWISTED =================
instanttwis:Section("Instant Twisted Settings")
instanttwis:Input({ Title = "Press Q Time", Value = "0.2", Callback = function(i) waitpress = tonumber(i) or waitpress end })
instanttwis:Input({ Title = "Wait",        Value = "0.1", Callback = function(i) leewait = tonumber(i) or leewait end })
instanttwis:Input({ Title = "Rotate Degree 1", Value = "-90", Callback = function(i) turn = tonumber(i) or turn end })
instanttwis:Input({ Title = "Wait 2",      Value = "0.05", Callback = function(i) leewait2 = tonumber(i) or leewait2 end })
instanttwis:Input({ Title = "Rotate Degree 2", Value = "110", Callback = function(i) turn2 = tonumber(i) or turn2 end })

-- ================= UI: LETHAL =================
lethal:Section("MeowTech + Lethal")
lethal:Input({ Title = "Start Time (MeowTech+Lethal)", Value = "1.7",
    Callback = function(i) meowlethalstart = tonumber(i) or meowlethalstart end })
lethal:Divider()
lethal:Section("Lethal Dash")
lethal:Input({ Title = "Start Time (Lethal Dash)", Value = "1.7",
    Callback = function(i) normallethalstart = tonumber(i) or normallethalstart end })
lethal:Input({ Title = "Flip Time", Value = "0.2",
    Callback = function(i) secondforflip = tonumber(i) or secondforflip end })
lethal:Divider()
lethal:Section("Instant Lethal")
lethal:Input({ Title = "Start Time (Instant Lethal)", Value = "1.7",
    Callback = function(i) instantlethalstart = tonumber(i) or instantlethalstart end })
lethal:Input({ Title = "Rotate Time", Value = "0.5",
    Callback = function(i) instantlethalwait = tonumber(i) or instantlethalwait end })
lethal:Divider()
lethal:Section("Boomy Instant Lethal")
lethal:Input({ Title = "Start Time", Value = "1.7", Callback = function(i) boomystart = tonumber(i) or boomystart end })
lethal:Input({ Title = "Jump Height", Value = "60", Callback = function(i) boomyjump = tonumber(i) or boomyjump end })
lethal:Input({ Title = "Rotate Time", Value = "0.1", Callback = function(i) boomywait = tonumber(i) or boomywait end })
lethal:Input({ Title = "Camera speed", Value = "3", Callback = function(i) boomycam = tonumber(i) or boomycam end })

-- ================= UI: KYOTO =================
tech:Section("Auto Kyoto")
tech:Toggle({ Title = "Auto Kyoto", Value = false, Callback = function(s) AutoKyotoEnabled = s end })
tech:Toggle({ Title = "Auto Kyoto tween mode", Value = false, Callback = function(s) AutoKyototween = s end })

-- ================= UI: SOCIAL =================
plat:Section("Redes")
plat:Button({ Title = "Copy Discord Link", Desc = "copiar link",
    Callback = function()
        pcall(function() setclipboard("https://discord.gg/n7rjmS4sNp") end)
        UI:Notify({ Title = "Copiado!", Content = "Discord copiado", Duration = 3 })
    end })
plat:Button({ Title = "Copy YouTube Link", Desc = "copiar link",
    Callback = function()
        pcall(function() setclipboard("http://youtube.com/@kyokiee") end)
        UI:Notify({ Title = "Copiado!", Content = "YouTube copiado", Duration = 3 })
    end })
plat:Button({ Title = "Copy TikTok Link", Desc = "copiar link",
    Callback = function()
        pcall(function() setclipboard("http://tiktok.com/@kyokieut") end)
        UI:Notify({ Title = "Copiado!", Content = "TikTok copiado", Duration = 3 })
    end })

-- ================= UI: TELEPORT =================
tp:Section("Jugadores")
local function addTpBtn(p)
    tp:Button({
        Title = p.Name,
        Desc = "Teleport a " .. p.Name,
        Callback = function()
            local a = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local b = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if a and b then a.CFrame = b.CFrame + Vector3.new(0,0,3) end
        end
    })
end
for _, p in ipairs(Players:GetPlayers()) do if p ~= player then addTpBtn(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= player then addTpBtn(p) end end)

-- ================= UI: ESP =================
esp:Section("Counter ESP")
local highlights = {}
local espEnabled = false
local function addHL(ch)
    if highlights[ch] then return end
    local h = Instance.new("Highlight", ch)
    h.FillColor = Color3.fromRGB(255,0,0)
    h.OutlineColor = Color3.fromRGB(255,0,0)
    h.FillTransparency = 0.45
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlights[ch] = h
end
local function rmHL(ch)
    if highlights[ch] then highlights[ch]:Destroy(); highlights[ch] = nil end
end
local function watch(ch)
    local function hasC()
        for _, a in ipairs(ch:GetChildren()) do
            if a:IsA("Accessory") and a.Name == "Counter" then return true end
        end
    end
    if hasC() then addHL(ch) end
    ch.ChildAdded:Connect(function(c)
        if c:IsA("Accessory") and c.Name == "Counter" then addHL(ch) end
    end)
    ch.ChildRemoved:Connect(function(c)
        if c:IsA("Accessory") and c.Name == "Counter" then rmHL(ch) end
    end)
end
esp:Toggle({ Title = "Counter ESP", Desc = "resalta jugadores con death counter",
    Value = false, Callback = function(state)
        espEnabled = state
        if state then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then watch(p.Character) end
            end
        else
            for c in pairs(highlights) do rmHL(c) end
        end
    end
})

-- ================= UI: M1 RESET =================
M1reset:Section("M1 Reset")
local dashDuration, dashforce = 0.2, 150
M1reset:Toggle({ Title = "M1Reset", Desc = "activar dash reset",
    Value = false, Callback = function(s) _G.m1Enabled = s end })
M1reset:Input({ Title = "duration", Value = "0.2",
    Callback = function(i) dashDuration = tonumber(i) or dashDuration end })
M1reset:Input({ Title = "dash force", Value = "150",
    Callback = function(i) dashforce = tonumber(i) or dashforce end })
M1reset:Keybind({ Title = "Dash Key", Desc = "tecla para dash", Value = "E", Callback = function() end })

-- ================= UI: REDUCE LAG =================
reduce:Section("Optimización")
reduce:Button({ Title = "potato graphics", Desc = "sin texturas",
    Callback = function()
        for _, inst in ipairs(workspace:GetDescendants()) do
            if inst:IsA("Decal") or inst:IsA("Texture") or inst:IsA("SurfaceAppearance") then
                inst:Destroy()
            elseif inst:IsA("MeshPart") then
                inst.TextureID = ""
                inst.Material = Enum.Material.SmoothPlastic
            elseif inst:IsA("Part") or inst:IsA("UnionOperation") then
                inst.Material = Enum.Material.SmoothPlastic
            end
        end
        UI:Notify({ Title = "Gráficos", Content = "texturas eliminadas", Duration = 3 })
    end
})
reduce:Button({ Title = "reduce lag (max)", Desc = "limpia el mapa",
    Callback = function()
        local KEEP = { Floor = true, Roads = true, MainPart = true }
        local Map = workspace:FindFirstChild("Map")
        if Map then
            for _, obj in ipairs(Map:GetChildren()) do
                if not KEEP[obj.Name] then obj:Destroy() end
            end
        end
        UI:Notify({ Title = "Optimizado", Content = "lag reducido", Duration = 3 })
    end
})

UI:Notify({ Title = "OUSA Hub listo", Content = "Presiona K para abrir/cerrar", Duration = 5 })
