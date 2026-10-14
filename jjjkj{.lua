--[[ ================================================
     OUSA HUB CUSTOM UI - PARTE 1: CORE FRAMEWORK
     Fondo negro | Texto blanco | Bordes grises
     ================================================ ]]

local NewUI = {}
NewUI.__index = NewUI

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

-- ============ THEME ============
NewUI.Theme = {
    Bg          = Color3.fromRGB(8, 8, 8),
    PanelBg     = Color3.fromRGB(12, 12, 12),
    ElementBg   = Color3.fromRGB(18, 18, 18),
    Border      = Color3.fromRGB(70, 70, 70),
    BorderLight = Color3.fromRGB(110, 110, 110),
    Text        = Color3.fromRGB(255, 255, 255),
    TextDim     = Color3.fromRGB(170, 170, 170),
    Hover       = Color3.fromRGB(28, 28, 28),
    Active      = Color3.fromRGB(40, 40, 40),
    ToggleOn    = Color3.fromRGB(255, 255, 255),
    ToggleOff   = Color3.fromRGB(45, 45, 45),
    Btn         = Color3.fromRGB(30, 30, 30),
    BtnHover    = Color3.fromRGB(50, 50, 50),
}

-- ============ HELPERS ============
local function mk(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do inst[k] = v end
    if parent then inst.Parent = parent end
    return inst
end

local function addStroke(parent, color, thickness, transparency)
    return mk("UIStroke", {
        Color = color or NewUI.Theme.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, parent)
end

local function addCorner(parent, radius)
    return mk("UICorner", { CornerRadius = UDim.new(0, radius or 6) }, parent)
end

-- ============ ROOT SCREEN GUI ============
local screenGui = mk("ScreenGui", {
    Name = "OUSA_Hub_UI",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
}, PG)

-- ============ NOTIFICATIONS ============
local notifyHolder = mk("Frame", {
    Name = "Notifs",
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 320, 1, 0),
    Position = UDim2.new(1, -340, 0, 20),
}, screenGui)
mk("UIListLayout", {
    Padding = UDim.new(0, 8),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    SortOrder = Enum.SortOrder.LayoutOrder,
}, notifyHolder)

function NewUI:Notify(opts)
    opts = opts or {}
    local card = mk("Frame", {
        BackgroundColor3 = NewUI.Theme.ElementBg,
        Size = UDim2.new(1, 0, 0, 60),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, notifyHolder)
    addCorner(card, 6)
    addStroke(card, NewUI.Theme.Border, 1)
    mk("Frame", { BackgroundColor3 = NewUI.Theme.Text, Size = UDim2.new(0, 3, 1, 0), BorderSizePixel = 0 }, card)
    mk("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0, 8),
        Size = UDim2.new(1, -20, 0, 18), Font = Enum.Font.GothamBold,
        Text = opts.Title or "Notification", TextColor3 = NewUI.Theme.Text,
        TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
    }, card)
    mk("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0, 28),
        Size = UDim2.new(1, -20, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham, Text = opts.Content or "",
        TextColor3 = NewUI.Theme.TextDim, TextSize = 12, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)
    card.BackgroundTransparency = 1
    TweenService:Create(card, TweenInfo.new(0.15), { BackgroundTransparency = 0 }):Play()
    task.delay(opts.Duration or 3, function()
        if card.Parent then
            TweenService:Create(card, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
            task.wait(0.2); card:Destroy()
        end
    end)
end

-- ============ POPUP ============
local popupHolder = mk("Frame", {
    Name = "Popups", BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0), Visible = false,
}, screenGui)

function NewUI:Popup(opts)
    opts = opts or {}
    popupHolder.Visible = true
    local overlay = mk("Frame", {
        BackgroundColor3 = Color3.new(0,0,0), BackgroundTransparency = 0.5,
        Size = UDim2.new(1, 0, 1, 0),
    }, popupHolder)

    local popup = mk("Frame", {
        BackgroundColor3 = NewUI.Theme.PanelBg,
        Size = UDim2.new(0, 340, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5),
    }, overlay)
    addCorner(popup, 8); addStroke(popup, NewUI.Theme.Border, 1)

    local pad = mk("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, -30, 1, -30),
        Position = UDim2.new(0, 15, 0, 15), AutomaticSize = Enum.AutomaticSize.Y,
    }, popup)
    mk("UIListLayout", { Padding = UDim.new(0, 10) }, pad)

    mk("TextLabel", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22),
        Font = Enum.Font.GothamBold, Text = opts.Title or "Popup",
        TextColor3 = NewUI.Theme.Text, TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, pad)

    mk("TextLabel", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y, Font = Enum.Font.Gotham,
        Text = opts.Content or "", TextColor3 = NewUI.Theme.TextDim,
        TextSize = 13, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, pad)

    local btnRow = mk("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 32),
    }, pad)
    mk("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 8),
    }, btnRow)

    for _, b in ipairs(opts.Buttons or {}) do
        local btn = mk("TextButton", {
            BackgroundColor3 = NewUI.Theme.Btn,
            Size = UDim2.new(0, 110, 1, 0), Font = Enum.Font.Gotham,
            Text = b.Title or "OK", TextColor3 = NewUI.Theme.Text,
            TextSize = 13, AutoButtonColor = false,
        }, btnRow)
        addCorner(btn, 4); addStroke(btn, NewUI.Theme.Border, 1)
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = NewUI.Theme.BtnHover }):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = NewUI.Theme.Btn }):Play()
        end)
        btn.MouseButton1Click:Connect(function()
            if b.Callback then b.Callback() end
            overlay:Destroy()
            if #popupHolder:GetChildren() == 0 then popupHolder.Visible = false end
        end)
    end
end

-- ============ CREATE WINDOW ============
function NewUI:CreateWindow(cfg)
    cfg = cfg or {}
    local win = {}
    win.Tabs = {}
    win.ActiveTab = nil
    win.Minimized = false
    win.SidebarOpen = true

    -- MAIN FRAME
    local main = mk("Frame", {
        Name = "Main",
        BackgroundColor3 = NewUI.Theme.Bg,
        Size = cfg.Size or UDim2.fromOffset(720, 480),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Active = true, ClipsDescendants = true,
    }, screenGui)
    addCorner(main, 10)
    addStroke(main, NewUI.Theme.Border, 1)

    -- TITLE BAR
    local titleBar = mk("Frame", {
        Name = "TitleBar", BackgroundColor3 = NewUI.Theme.PanelBg,
        Size = UDim2.new(1, 0, 0, 36), BorderSizePixel = 0,
    }, main)
    addCorner(titleBar, 10)
    mk("Frame", { -- square bottom corners of titlebar
        BackgroundColor3 = NewUI.Theme.PanelBg,
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 1, -12), BorderSizePixel = 0,
    }, titleBar)
    mk("Frame", { -- bottom border line
        BackgroundColor3 = NewUI.Theme.Border,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1), BorderSizePixel = 0,
    }, titleBar)

    mk("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(0, 300, 1, 0), Font = Enum.Font.GothamBold,
        Text = cfg.Title or "New UI", TextColor3 = NewUI.Theme.Text,
        TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left,
    }, titleBar)

    mk("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(1, -250, 0, 0),
        Size = UDim2.new(0, 150, 1, 0), Font = Enum.Font.Gotham,
        Text = cfg.Author or "by you", TextColor3 = NewUI.Theme.TextDim,
        TextSize = 12, TextXAlignment = Enum.TextXAlignment.Right,
    }, titleBar)

    -- Minimize button
    local minBtn = mk("TextButton", {
        BackgroundColor3 = NewUI.Theme.Btn,
        Position = UDim2.new(1, -80, 0, 8), Size = UDim2.new(0, 26, 0, 20),
        Font = Enum.Font.GothamBold, Text = "—", TextColor3 = NewUI.Theme.Text,
        TextSize = 14, AutoButtonColor = false,
    }, titleBar)
    addCorner(minBtn, 4); addStroke(minBtn, NewUI.Theme.Border, 1)

    -- Close button
    local closeBtn = mk("TextButton", {
        BackgroundColor3 = NewUI.Theme.Btn,
        Position = UDim2.new(1, -48, 0, 8), Size = UDim2.new(0, 26, 0, 20),
        Font = Enum.Font.GothamBold, Text = "✕", TextColor3 = NewUI.Theme.Text,
        TextSize = 14, AutoButtonColor = false,
    }, titleBar)
    addCorner(closeBtn, 4); addStroke(closeBtn, NewUI.Theme.Border, 1)

    -- Sidebar toggle (hamburger) button
    local menuBtn = mk("TextButton", {
        BackgroundColor3 = NewUI.Theme.Btn,
        Position = UDim2.new(0, 8, 0, 8), Size = UDim2.new(0, 26, 0, 20),
        Font = Enum.Font.GothamBold, Text = "☰", TextColor3 = NewUI.Theme.Text,
        TextSize = 14, AutoButtonColor = false,
    }, titleBar)
    addCorner(menuBtn, 4); addStroke(menuBtn, NewUI.Theme.Border, 1)

    -- For button hover
    for _, b in ipairs({minBtn, closeBtn, menuBtn}) do
        b.MouseEnter:Connect(function()
            TweenService:Create(b, TweenInfo.new(0.15), { BackgroundColor3 = NewUI.Theme.BtnHover }):Play()
        end)
        b.MouseLeave:Connect(function()
            TweenService:Create(b, TweenInfo.new(0.15), { BackgroundColor3 = NewUI.Theme.Btn }):Play()
        end)
    end

    -- CONTENT AREA
    local sidebarW = cfg.SideBarWidth or 180
    local body = mk("Frame", {
        Name = "Body", BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 36),
        Size = UDim2.new(1, 0, 1, -36),
    }, main)

    -- SIDEBAR
    local sidebar = mk("Frame", {
        Name = "Sidebar", BackgroundColor3 = NewUI.Theme.PanelBg,
        Size = UDim2.new(0, sidebarW, 1, 0), BorderSizePixel = 0,
    }, body)
    mk("Frame", { -- right border line
        BackgroundColor3 = NewUI.Theme.Border,
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0), BorderSizePixel = 0,
    }, sidebar)

    local tabList = mk("ScrollingFrame", {
        Name = "TabList", BackgroundTransparency = 1,
        Size = UDim2.new(1, -12, 1, -12),
        Position = UDim2.new(0, 6, 0, 6),
        BorderSizePixel = 0, ScrollBarThickness = 3,
        ScrollBarImageColor3 = NewUI.Theme.Border,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, sidebar)
    mk("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, tabList)

    -- CONTENT
    local content = mk("ScrollingFrame", {
        Name = "Content", BackgroundTransparency = 1,
        Position = UDim2.new(0, sidebarW, 0, 0),
        Size = UDim2.new(1, -sidebarW, 1, 0),
        BorderSizePixel = 0, ScrollBarThickness = 4,
        ScrollBarImageColor3 = NewUI.Theme.Border,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, body)
    local contentPad = mk("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, content)
    mk("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, contentPad)

    -- DRAG
    local dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragStart = nil end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragStart and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- SIDEBAR TOGGLE
    menuBtn.MouseButton1Click:Connect(function()
        win.SidebarOpen = not win.SidebarOpen
        if win.SidebarOpen then
            sidebar.Visible = true
            content.Position = UDim2.new(0, sidebarW, 0, 0)
            content.Size = UDim2.new(1, -sidebarW, 1, 0)
        else
            sidebar.Visible = false
            content.Position = UDim2.new(0, 0, 0, 0)
            content.Size = UDim2.new(1, 0, 1, 0)
        end
    end)

    -- MINIMIZE
    local minimized = false
    local savedSize = main.Size
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        win.Minimized = minimized
        if minimized then
            savedSize = main.Size
            sidebar.Visible = false
            body.Visible = false
            TweenService:Create(main, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 260, 0, 36)
            }):Play()
        else
            body.Visible = true
            sidebar.Visible = win.SidebarOpen
            TweenService:Create(main, TweenInfo.new(0.2), { Size = savedSize }):Play()
        end
    end)

    -- CLOSE
    closeBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        if win.OpenButton then win.OpenButton.Visible = true end
    end)

    -- ============ TAB API ============
    function win:Tab(cfg)
        cfg = cfg or {}
        local tab = {}
        tab.Container = mk("ScrollingFrame", {
            Name = cfg.Title or "Tab",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -10, 1, -10),
            Position = UDim2.new(0, 10, 0, 10),
            BorderSizePixel = 0, ScrollBarThickness = 3,
            ScrollBarImageColor3 = NewUI.Theme.Border,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
        }, content)
        mk("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, tab.Container)

        local tabBtn = mk("TextButton", {
            BackgroundColor3 = NewUI.Theme.ElementBg,
            Size = UDim2.new(1, 0, 0, 32),
            Font = Enum.Font.Gotham, Text = "  " .. (cfg.Title or "Tab"),
            TextColor3 = NewUI.Theme.Text, TextSize = 13,
            AutoButtonColor = false,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, tabList)
        addCorner(tabBtn, 4); addStroke(tabBtn, NewUI.Theme.Border, 1)

        tabBtn.MouseEnter:Connect(function()
            if win.ActiveTab ~= tab then
                TweenService:Create(tabBtn, TweenInfo.new(0.15), { BackgroundColor3 = NewUI.Theme.Hover }):Play()
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if win.ActiveTab ~= tab then
                TweenService:Create(tabBtn, TweenInfo.new(0.15), { BackgroundColor3 = NewUI.Theme.ElementBg }):Play()
            end
        end)

        function tab:Select()
            if win.ActiveTab then
                win.ActiveTab.Container.Visible = false
                local prevBtn = win.ActiveTab.Button
                TweenService:Create(prevBtn, TweenInfo.new(0.15), {
                    BackgroundColor3 = NewUI.Theme.ElementBg,
                    TextColor3 = NewUI.Theme.Text,
                }):Play()
                addStroke(prevBtn, NewUI.Theme.Border, 1)
            end
            win.ActiveTab = tab
            tab.Container.Visible = true
            TweenService:Create(tabBtn, TweenInfo.new(0.15), {
                BackgroundColor3 = NewUI.Theme.Active,
                TextColor3 = NewUI.Theme.Text,
            }):Play()
        end

        tab.Button = tabBtn
        tabBtn.MouseButton1Click:Connect(function() tab:Select() end)

        table.insert(win.Tabs, tab)
        if #win.Tabs == 1 then tab:Select() end
        return tab
    end

    -- ============ SetToggleKey ============
    function win:SetToggleKey(key)
        UIS.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == key then
                main.Visible = not main.Visible
                if win.OpenButton then win.OpenButton.Visible = not main.Visible end
            end
        end)
    end

    -- ============ EditOpenButton ============
    function win:EditOpenButton(cfg)
        cfg = cfg or {}
        local ob = mk("TextButton", {
            Name = "OpenButton",
            BackgroundColor3 = NewUI.Theme.Bg,
            Size = UDim2.new(0, 140, 0, 34),
            Position = UDim2.new(0, 20, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = cfg.Title or "Open UI",
            TextColor3 = NewUI.Theme.Text, TextSize = 13,
            AutoButtonColor = false, Visible = false,
        }, screenGui)
        addCorner(ob, 6); addStroke(ob, NewUI.Theme.BorderLight, 2)
        ob.MouseButton1Click:Connect(function()
            main.Visible = true
            ob.Visible = false
        end)
        win.OpenButton = ob

        -- drag
        local dS, sP
        ob.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
                dS = i.Position; sP = ob.Position
                i.Changed:Connect(function()
                    if i.UserInputState == Enum.UserInputState.End then dS = nil end
                end)
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if dS and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
                local d = i.Position - dS
                ob.Position = UDim2.new(sP.X.Scale, sP.X.Offset + d.X,
                                        sP.Y.Scale, sP.Y.Offset + d.Y)
            end
        end)
        return ob
    end

    win.MainFrame = main
    win.Content = content
    return win
end

-- Expose global
getgenv().WindUI = NewUI
return NewUI
--[[ ================================================
     OUSA HUB CUSTOM UI - PARTE 2: COMPONENTES
     Añade métodos a Tab: Toggle, Slider, Input,
     Button, Divider, Keybind, Section, Label
     ================================================ ]]

-- Este bloque se pega DESPUÉS de la Parte 1.
-- Extiende la clase Tab con componentes.

local NewUI = getgenv().WindUI
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- ============ HELPERS INTERNOS ============
local function mk(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do inst[k] = v end
    if parent then inst.Parent = parent end
    return inst
end

local function addStroke(parent, color, thickness)
    return mk("UIStroke", {
        Color = color or NewUI.Theme.Border,
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, parent)
end

local function addCorner(parent, r)
    return mk("UICorner", { CornerRadius = UDim.new(0, r or 6) }, parent)
end

-- Obtener el objeto Tab (ya fue creado en la Parte 1 como win:Tab)
-- Vamos a parchear la clase Tab interceptando win:Tab

local originalCreateWindow = NewUI.CreateWindow

function NewUI:CreateWindow(cfg)
    local win = originalCreateWindow(self, cfg)

    local originalTab = win.Tab

    function win:Tab(tabCfg)
        local tab = originalTab(self, tabCfg)

        -- ============ HELPER: crear card base ============
        local function baseCard(height)
            local card = mk("Frame", {
                BackgroundColor3 = NewUI.Theme.ElementBg,
                Size = UDim2.new(1, 0, 0, height or 48),
                BorderSizePixel = 0,
            }, tab.Container)
            addCorner(card, 6)
            addStroke(card, NewUI.Theme.Border, 1)
            return card
        end

        -- ============ SECTION / DIVIDER ============
        function tab:Section(title)
            local sec = mk("Frame", {
                BackgroundColor3 = NewUI.Theme.PanelBg,
                Size = UDim2.new(1, 0, 0, 28),
                BorderSizePixel = 0,
            }, tab.Container)
            addCorner(sec, 6)
            addStroke(sec, NewUI.Theme.BorderLight, 1)
            mk("TextLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -16, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                Font = Enum.Font.GothamBold,
                Text = title or "Section",
                TextColor3 = NewUI.Theme.Text,
                TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
            }, sec)
        end

        function tab:Divider()
            local d = mk("Frame", {
                BackgroundColor3 = NewUI.Theme.Border,
                Size = UDim2.new(1, 0, 0, 1),
                BorderSizePixel = 0,
            }, tab.Container)
        end

        -- ============ LABEL ============
        function tab:Label(cfg)
            cfg = cfg or {}
            local lbl = mk("TextLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 20),
                Font = Enum.Font.Gotham,
                Text = cfg.Title or "",
                TextColor3 = NewUI.Theme.TextDim,
                TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
            }, tab.Container)
            return lbl
        end

        -- ============ BUTTON ============
        function tab:Button(cfg)
            cfg = cfg or {}
            local card = baseCard(48)
            mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 6),
                Size = UDim2.new(1, -90, 0, 16),
                Font = Enum.Font.GothamBold,
                Text = cfg.Title or "Button",
                TextColor3 = NewUI.Theme.Text, TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, card)
            mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 24),
                Size = UDim2.new(1, -90, 0, 14),
                Font = Enum.Font.Gotham,
                Text = cfg.Desc or "",
                TextColor3 = NewUI.Theme.TextDim, TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, card)

            local btn = mk("TextButton", {
                BackgroundColor3 = NewUI.Theme.Btn,
                Position = UDim2.new(1, -86, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 76, 0, 28),
                Font = Enum.Font.GothamBold, Text = "Run",
                TextColor3 = NewUI.Theme.Text, TextSize = 12,
                AutoButtonColor = false,
            }, card)
            addCorner(btn, 4); addStroke(btn, NewUI.Theme.Border, 1)

            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = NewUI.Theme.BtnHover }):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = NewUI.Theme.Btn }):Play()
            end)
            btn.MouseButton1Click:Connect(function()
                if cfg.Callback then cfg.Callback() end
            end)
            return btn
        end

        -- ============ TOGGLE ============
        function tab:Toggle(cfg)
            cfg = cfg or {}
            local card = baseCard(48)

            mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 6),
                Size = UDim2.new(1, -90, 0, 16),
                Font = Enum.Font.GothamBold,
                Text = cfg.Title or "Toggle",
                TextColor3 = NewUI.Theme.Text, TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, card)
            mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 24),
                Size = UDim2.new(1, -90, 0, 14),
                Font = Enum.Font.Gotham,
                Text = cfg.Desc or "",
                TextColor3 = NewUI.Theme.TextDim, TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, card)

            local switchBg = mk("Frame", {
                BackgroundColor3 = cfg.Value and NewUI.Theme.ToggleOn or NewUI.Theme.ToggleOff,
                Position = UDim2.new(1, -58, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 46, 0, 24),
            }, card)
            addCorner(switchBg, 12)
            addStroke(switchBg, NewUI.Theme.Border, 1)

            local knob = mk("Frame", {
                BackgroundColor3 = NewUI.Theme.Text,
                Position = cfg.Value and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2),
                Size = UDim2.new(0, 20, 0, 20),
            }, switchBg)
            addCorner(knob, 10)

            local btn = mk("TextButton", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "", AutoButtonColor = false,
            }, card)

            local state = cfg.Value or false
            btn.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(switchBg, TweenInfo.new(0.2), {
                    BackgroundColor3 = state and NewUI.Theme.ToggleOn or NewUI.Theme.ToggleOff
                }):Play()
                TweenService:Create(knob, TweenInfo.new(0.2), {
                    Position = state and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)
                }):Play()
                if cfg.Callback then cfg.Callback(state) end
            end)

            return {
                Set = function(_, v)
                    state = v
                    TweenService:Create(switchBg, TweenInfo.new(0.2), {
                        BackgroundColor3 = state and NewUI.Theme.ToggleOn or NewUI.Theme.ToggleOff
                    }):Play()
                    TweenService:Create(knob, TweenInfo.new(0.2), {
                        Position = state and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)
                    }):Play()
                end
            }
        end

        -- ============ SLIDER ============
        function tab:Slider(cfg)
            cfg = cfg or {}
            local card = baseCard(60)
            local range = cfg.Value or { Min = 0, Max = 100, Default = 50 }
            local step = cfg.Step or 1
            local value = range.Default or range.Min

            mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 6),
                Size = UDim2.new(1, -90, 0, 16),
                Font = Enum.Font.GothamBold,
                Text = cfg.Title or "Slider",
                TextColor3 = NewUI.Theme.Text, TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, card)

            local valLbl = mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(1, -80, 0, 6),
                Size = UDim2.new(0, 70, 0, 16),
                Font = Enum.Font.GothamBold,
                Text = tostring(value),
                TextColor3 = NewUI.Theme.Text, TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, card)

            local barBg = mk("Frame", {
                BackgroundColor3 = NewUI.Theme.ToggleOff,
                Position = UDim2.new(0, 12, 0, 38),
                Size = UDim2.new(1, -24, 0, 8),
            }, card)
            addCorner(barBg, 4); addStroke(barBg, NewUI.Theme.Border, 1)

            local fill = mk("Frame", {
                BackgroundColor3 = NewUI.Theme.Text,
                Size = UDim2.new(0, 0, 1, 0),
            }, barBg)
            addCorner(fill, 4)

            local knob = mk("Frame", {
                BackgroundColor3 = NewUI.Theme.Text,
                Size = UDim2.new(0, 14, 0, 14),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0, 0, 0.5, 0),
            }, barBg)
            addCorner(knob, 7); addStroke(knob, NewUI.Theme.Border, 1)

            local function updateUI(v)
                local pct = (v - range.Min) / (range.Max - range.Min)
                fill.Size = UDim2.new(pct, 0, 1, 0)
                knob.Position = UDim2.new(pct, 0, 0.5, 0)
                valLbl.Text = tostring(v)
            end
            updateUI(value)

            local dragging = false
            local function setFromX(x)
                local abs = barBg.AbsolutePosition.X
                local w = barBg.AbsoluteSize.X
                local pct = math.clamp((x - abs) / w, 0, 1)
                local raw = range.Min + pct * (range.Max - range.Min)
                local snapped = math.floor(raw / step + 0.5) * step
                snapped = math.clamp(snapped, range.Min, range.Max)
                value = snapped
                updateUI(value)
                if cfg.Callback then cfg.Callback(value) end
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

            return { Set = function(_, v) value = v; updateUI(v) end }
        end

        -- ============ INPUT ============
        function tab:Input(cfg)
            cfg = cfg or {}
            local card = baseCard(56)

            mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 6),
                Size = UDim2.new(1, -90, 0, 16),
                Font = Enum.Font.GothamBold,
                Text = cfg.Title or "Input",
                TextColor3 = NewUI.Theme.Text, TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, card)
            mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 22),
                Size = UDim2.new(1, -90, 0, 14),
                Font = Enum.Font.Gotham,
                Text = cfg.Desc or "",
                TextColor3 = NewUI.Theme.TextDim, TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, card)

            local box = mk("Frame", {
                BackgroundColor3 = NewUI.Theme.Bg,
                Position = UDim2.new(0, 12, 0, 40),
                Size = UDim2.new(1, -24, 0, 28),
            }, card)
            addCorner(box, 4); addStroke(box, NewUI.Theme.Border, 1)

            local tb = mk("TextBox", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -12, 1, 0),
                Position = UDim2.new(0, 6, 0, 0),
                Font = Enum.Font.Gotham, Text = tostring(cfg.Value or ""),
                PlaceholderText = cfg.Placeholder or "Enter...",
                PlaceholderColor3 = NewUI.Theme.TextDim,
                TextColor3 = NewUI.Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
            }, box)

            tb.FocusLost:Connect(function()
                if cfg.Callback then cfg.Callback(tb.Text) end
            end)
            return tb
        end

        -- ============ KEYBIND ============
        function tab:Keybind(cfg)
            cfg = cfg or {}
            local card = baseCard(48)
            mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 6),
                Size = UDim2.new(1, -90, 0, 16),
                Font = Enum.Font.GothamBold,
                Text = cfg.Title or "Keybind",
                TextColor3 = NewUI.Theme.Text, TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, card)
            mk("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 24),
                Size = UDim2.new(1, -90, 0, 14),
                Font = Enum.Font.Gotham,
                Text = cfg.Desc or "",
                TextColor3 = NewUI.Theme.TextDim, TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, card)

            local curKey = cfg.Value or "E"
            local btn = mk("TextButton", {
                BackgroundColor3 = NewUI.Theme.Btn,
                Position = UDim2.new(1, -86, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 76, 0, 28),
                Font = Enum.Font.GothamBold, Text = curKey,
                TextColor3 = NewUI.Theme.Text, TextSize = 12,
                AutoButtonColor = false,
            }, card)
            addCorner(btn, 4); addStroke(btn, NewUI.Theme.Border, 1)

            local listening = false
            btn.MouseButton1Click:Connect(function()
                listening = true
                btn.Text = "..."
            end)

            local conn
            conn = UIS.InputBegan:Connect(function(input, gp)
                if not listening then return end
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    curKey = input.KeyCode.Name
                    btn.Text = curKey
                    listening = false
                    if cfg.Callback then cfg.Callback(curKey) end
                end
            end)
            return btn
        end

        return tab
    end

    return win
end

return NewUI
--[[ ================================================
     OUSA HUB - PARTE 3: INTEGRACIÓN COMPLETA
     Pega las Partes 1 y 2 arriba, y luego esto.
     ================================================ ]]

-- Cargar UI custom (asumiendo Partes 1 y 2 ya ejecutadas -> getgenv().WindUI listo)
local WindUI = getgenv().WindUI

-- Servicios
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local cam = workspace.CurrentCamera

-- ============ WEBHOOK (opcional, mantenido igual) ============
local webhook = "https://discord.com/api/webhooks/1554482088869371908/BDQlRiXrzBgIdu2v4wedTNZprXGHPEt4l75kCCVqYxmuIjpmWcF1POPdoVoqG1Mq4qMo"
local executor = "Unknown"
pcall(function() if identifyexecutor then executor = identifyexecutor() end end)

local data = {
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
}
local json = HttpService:JSONEncode(data)
local req = (syn and syn.request) or request or http_request
if req then
    req({ Url = webhook, Method = "POST",
        Headers = { ["Content-Type"] = "application/json" }, Body = json })
end

-- ============ NOTIFICACIÓN INICIAL ============
WindUI:Notify({
    Title = "OUSA Hub is Back",
    Content = "Launched OUSA hub 6.7",
    Duration = 4
})

-- ============ POPUP DISCORD ============
WindUI:Popup({
    Title = "Discord",
    Content = "Join our Discord server!",
    Buttons = {
        { Title = "Cancel", Callback = function() end },
        { Title = "Copy Discord", Callback = function()
            if setclipboard then
                setclipboard("https://discord.gg/dCnvGNYANP")
                WindUI:Notify({ Title = "Copied!", Content = "Discord invite copied.", Duration = 3 })
            end
        end }
    }
})

-- ============ VENTANA PRINCIPAL ============
local Window = WindUI:CreateWindow({
    Title = "OUSA Hub",
    Author = "by archi",
    Size = UDim2.fromOffset(820, 560),
    SideBarWidth = 200,
})

Window:SetToggleKey(Enum.KeyCode.K)

Window:EditOpenButton({
    Title = "OUSA Hub by archi",
    Enabled = true,
    Draggable = true,
})

-- ============ CREAR TABS (uno por tech) ============
local main          = Window:Tab({ Title = "Main" })
local Techs         = Window:Tab({ Title = "Techs/Macro" })
local meowtech      = Window:Tab({ Title = "meowtech/uppercut" })
local k1ngtech      = Window:Tab({ Title = "k1ng tech/uppercut" })
local oreo          = Window:Tab({ Title = "Oreo tech/uppercut" })
local kitty         = Window:Tab({ Title = "kitty tech/uppercut" })
local kak           = Window:Tab({ Title = "kakyo tech/uppercut" })
local inner         = Window:Tab({ Title = "inner dash/uppercut" })
local instanttwis   = Window:Tab({ Title = "instant twisted/m4" })
local lethal        = Window:Tab({ Title = "lethal/lethalwhirlwind" })
local tech          = Window:Tab({ Title = "kyoto" })
local plat          = Window:Tab({ Title = "youtube/tiktok/discord" })
local tp            = Window:Tab({ Title = "teleport" })
local esp           = Window:Tab({ Title = "Esp" })
local M1reset       = Window:Tab({ Title = "m1 reset" })
local reduce        = Window:Tab({ Title = "reduce lag" })

main:Select()

-- ============ VARIABLES DE ESTADO (igual que tu script original) ============
local DashRemote = ReplicatedStorage.Resources.Brother["#Friend"].Communicate

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
local innerdash, innerlethal, kyokie, supatech
local leeinstanttwisted, instanttwisted

-- Config
local meowstart, meowDuration = 0.3, 0.3
local kingstart, kingwait = 0.3, 0.2
local oreostart, oreowait, oreocam, oreojump = 0.3, 0.5, 1, 54
local kittystartjump, kittystart, kittywait, kittycam, kittydur = 0.1, 0.3, 0.1, 1, 0.2
local kakyostart, kakyojump, kakyocam = 0.3, 40, 4
local waitpress, leewait, turn, leewait2, turn2 = 0.2, 0.2, -90, 0.05, 115
local meowlethalstart, meowlethaldur = 1.7, 0.5
local normallethalstart, secondforflip = 1.7, 0.2
local instantlethalstart, instantlethalwait = 1.7, 0.5
local boomystart, boomyjump, boomywait, boomycam = 1.7, 65, 0.1, 3

-- (Aquí van TODAS tus funciones del script original:
--  getRoot, getClosestEnemy, fireQ, attachTo, forceJump, flip, doTwisted,
--  autoPressQ, setupCharacter, AntiDeath, flingLoop, etc.
--  Pega tu código de funciones tal cual. Omitido por espacio pero sin cambios.)

-- ============ ====================================================
-- ============ TODOS LOS COMPONENTES DE UI (por tab) =============
-- ============ ====================================================

-- ---------- MAIN ----------
local walkSpeedValue = 23
local WalkSpeedEnabled = false
local hiddenfling = false

main:Section("Character")
main:Toggle({
    Title = "Enable WalkSpeed",
    Desc = "also make u no stun",
    Value = false,
    Callback = function(state)
        WalkSpeedEnabled = state
        local ch = player.Character
        if ch and ch:FindFirstChild("Humanoid") then
            ch.Humanoid.WalkSpeed = state and walkSpeedValue or 23
        end
    end
})
main:Slider({
    Title = "WalkSpeed",
    Desc = "change ur walkspeed",
    Step = 1,
    Value = { Min = 0, Max = 1000, Default = 23 },
    Callback = function(v)
        walkSpeedValue = v
        if WalkSpeedEnabled then
            local ch = player.Character
            if ch and ch:FindFirstChild("Humanoid") then
                ch.Humanoid.WalkSpeed = v
            end
        end
    end
})

main:Section("Extras")
main:Toggle({ Title = "touch fling", Desc = "fling other player when touch",
    Value = false, Callback = function(v) hiddenfling = v end })
main:Toggle({ Title = "No Dash Cooldown (new)", Desc = "Toggle to remove dash cooldown",
    Value = false, Callback = function(state)
        workspace:SetAttribute("EffectAffects", 1)
        workspace:SetAttribute("NoDashCooldown", state)
    end })
main:Toggle({ Title = "anti death counter", Desc = "make u not die in deathcounter",
    Value = false, Callback = function(v) deathcounter = v end })

-- ---------- TECHS / MACRO ----------
Techs:Section("Toggles activos")
Techs:Toggle({ Title = "Enable inner dash (100%)", Value = false,
    Callback = function(s) innerdash = s end })
Techs:Toggle({ Title = "Enable MeowTech", Value = false,
    Callback = function(s) MeowTechEnabled = s end })
Techs:Toggle({ Title = "Enable MeowTechv2", Value = false,
    Callback = function(s) meowtechv2 = s end })
Techs:Toggle({ Title = "Enable K1ng tech", Value = false,
    Callback = function(s) KingTechEnabled = s end })
Techs:Toggle({ Title = "Enable oreo tech", Value = false,
    Callback = function(s) dripz = s end })
Techs:Toggle({ Title = "kitty dash", Value = false,
    Callback = function(s) oreov2 = s end })
Techs:Toggle({ Title = "kakyo under flip(new)", Value = false,
    Callback = function(s) kakyo = s end })
Techs:Toggle({ Title = "lee instant twisted", Value = false,
    Callback = function(s) leeinstanttwisted = s end })
Techs:Toggle({ Title = "Enable MeowTech + lethal", Value = false,
    Callback = function(s) lethalEnabled = s end })
Techs:Toggle({ Title = "LethalDash Enabled", Value = false,
    Callback = function(s) LethalDashEnabled = s end })
Techs:Toggle({ Title = "Instant lethal", Value = false,
    Callback = function(s) instantlethal = s end })
Techs:Toggle({ Title = "booomy instant lethal", Value = false,
    Callback = function(s) boomy = s end })
Techs:Toggle({ Title = "inner lethal(90% headglide)", Value = false,
    Callback = function(s) innerlethal = s end })

-- ---------- MEOWTECH ----------
meowtech:Section("MeowTech Settings")
meowtech:Input({ Title = "Start Time", Desc = "on how long the tech start",
    Value = "0.3", Placeholder = "number", Callback = function(i) meowstart = tonumber(i) or meowstart end })
meowtech:Input({ Title = "Duration", Desc = "on how long the tech end",
    Value = "0.3", Placeholder = "number", Callback = function(i) meowDuration = tonumber(i) or meowDuration end })

-- ---------- K1NG TECH ----------
k1ngtech:Section("K1ng Tech Settings")
k1ngtech:Input({ Title = "Start Time", Desc = "when tech starts",
    Value = "0.3", Placeholder = "number", Callback = function(i) kingstart = tonumber(i) or kingstart end })
k1ngtech:Input({ Title = "Flip Time", Desc = "when flip triggers",
    Value = "0.2", Placeholder = "number", Callback = function(i) kingwait = tonumber(i) or kingwait end })

-- ---------- OREO ----------
oreo:Section("Oreo Tech Settings")
oreo:Input({ Title = "Start Time", Desc = "when tech starts",
    Value = "0.3", Callback = function(i) oreostart = tonumber(i) or oreostart end })
oreo:Input({ Title = "Rotation time", Desc = "wait before camera rotates",
    Value = "0.5", Callback = function(i) oreowait = tonumber(i) or oreowait end })
oreo:Input({ Title = "Camera speed", Desc = "speed of camera rotate",
    Value = "1", Callback = function(i) oreocam = tonumber(i) or oreocam end })
oreo:Input({ Title = "Oreo duration", Desc = "how long rotation stop",
    Value = "0.2", Callback = function(i) oreodur = tonumber(i) end })
oreo:Input({ Title = "Jump height", Desc = "jump power",
    Value = "54", Callback = function(i) oreojump = tonumber(i) or oreojump end })

-- ---------- KITTY ----------
kitty:Section("Kitty Tech Settings")
kitty:Input({ Title = "Kitty jump", Desc = "start to jump when do tech",
    Value = "0.1", Callback = function(i) kittystartjump = tonumber(i) or kittystartjump end })
kitty:Input({ Title = "Start Time", Desc = "start to jump",
    Value = "0.3", Callback = function(i) kittystart = tonumber(i) or kittystart end })
kitty:Input({ Title = "Rotate Time", Desc = "wait for camera rotate",
    Value = "0.1", Callback = function(i) kittywait = tonumber(i) or kittywait end })
kitty:Input({ Title = "Camera speed", Desc = "how fast camera rotates",
    Value = "1", Callback = function(i) kittycam = tonumber(i) or kittycam end })
kitty:Input({ Title = "Kitty duration", Desc = "camera rotation stop time",
    Value = "0.2", Callback = function(i) kittydur = tonumber(i) or kittydur end })

-- ---------- KAKYO ----------
kak:Section("Kakyo Tech Settings")
kak:Input({ Title = "Start Time", Desc = "when tech starts",
    Value = "0.3", Callback = function(i) kakyostart = tonumber(i) or kakyostart end })
kak:Input({ Title = "Kakyo jump height", Desc = "how high",
    Value = "40", Callback = function(i) kakyojump = tonumber(i) or kakyojump end })
kak:Input({ Title = "Camera speed", Desc = "speed of camera",
    Value = "4", Callback = function(i) kakyocam = tonumber(i) or kakyocam end })

-- ---------- INSTANT TWISTED ----------
instanttwis:Section("Instant Twisted Settings")
instanttwis:Input({ Title = "Press Q Time", Desc = "delay to press Q",
    Value = "0.2", Callback = function(i) waitpress = tonumber(i) or waitpress end })
instanttwis:Input({ Title = "Wait", Desc = "wait",
    Value = "0.1", Callback = function(i) leewait = tonumber(i) or leewait end })
instanttwis:Input({ Title = "Rotate Degree", Desc = "rotate ur camera",
    Value = "-90", Callback = function(i) turn = tonumber(i) or turn end })
instanttwis:Input({ Title = "Wait2", Desc = "wait2",
    Value = "0.05", Callback = function(i) leewait2 = tonumber(i) or leewait2 end })
instanttwis:Input({ Title = "Rotate Degree 2", Desc = "rotate ur camera",
    Value = "110", Callback = function(i) turn2 = tonumber(i) or turn2 end })

-- ---------- LETHAL ----------
lethal:Section("MeowTech + Lethal")
lethal:Input({ Title = "Start Time (MeowTech+Lethal)", Desc = "number",
    Value = "1.7", Callback = function(i) meowlethalstart = tonumber(i) or meowlethalstart end })
lethal:Divider()
lethal:Section("Lethal Dash")
lethal:Input({ Title = "Start Time (Lethal Dash)", Desc = "number",
    Value = "1.7", Callback = function(i) meowlethalstart = tonumber(i) or meowlethalstart end })
lethal:Input({ Title = "Flip Time", Desc = "number",
    Value = "0.2", Callback = function(i) secondforflip = tonumber(i) or secondforflip end })
lethal:Divider()
lethal:Section("Instant Lethal")
lethal:Input({ Title = "Start Time (Instant Lethal)", Desc = "number",
    Value = "1.7", Callback = function(i) instantlethalstart = tonumber(i) or instantlethalstart end })
lethal:Input({ Title = "Rotate Time", Desc = "number",
    Value = "0.5", Callback = function(i) instantlethalwait = tonumber(i) or instantlethalwait end })
lethal:Divider()
lethal:Section("Boomy Instant Lethal")
lethal:Input({ Title = "Start Time (Boomy)", Desc = "number",
    Value = "1.7", Callback = function(i) boomystart = tonumber(i) or boomystart end })
lethal:Input({ Title = "Jump Height", Desc = "number",
    Value = "60", Callback = function(i) boomyjump = tonumber(i) or boomyjump end })
lethal:Input({ Title = "Rotate Time", Desc = "number",
    Value = "0.1", Callback = function(i) boomywait = tonumber(i) or boomywait end })
lethal:Input({ Title = "Camera speed", Desc = "number",
    Value = "3", Callback = function(i) boomycam = tonumber(i) or boomycam end })

-- ---------- KYOTO ----------
tech:Section("Auto Kyoto")
tech:Toggle({ Title = "Auto Kyoto", Value = false,
    Callback = function(s) AutoKyotoEnabled = s end })
tech:Toggle({ Title = "Auto Kyoto tween mode", Value = false,
    Callback = function(s) AutoKyototween = s end })

-- ---------- PLATAFORMAS (links) ----------
plat:Section("Social Links")
plat:Button({ Title = "Copy Discord Link", Desc = "Click to copy",
    Callback = function()
        pcall(function() setclipboard("https://discord.gg/n7rjmS4sNp") end)
        WindUI:Notify({ Title = "Copied!", Content = "Discord link copied", Duration = 3 })
    end })
plat:Button({ Title = "Copy youtube Link", Desc = "Click to copy",
    Callback = function()
        pcall(function() setclipboard("http://youtube.com/@kyokiee") end)
        WindUI:Notify({ Title = "Copied!", Content = "YouTube link copied", Duration = 3 })
    end })
plat:Button({ Title = "Copy tiktok Link", Desc = "Click to copy",
    Callback = function()
        pcall(function() setclipboard("http://tiktok.com/@kyokieut") end)
        WindUI:Notify({ Title = "Copied!", Content = "TikTok link copied", Duration = 3 })
    end })

-- ---------- TELEPORT ----------
tp:Section("Teleport a jugador")
for _, p in ipairs(Players:GetPlayers()) do
    if p ~= player then
        tp:Button({
            Title = p.Name,
            Desc = "Teleport to " .. p.Name,
            Callback = function()
                if player.Character and p.Character then
                    local a = player.Character:FindFirstChild("HumanoidRootPart")
                    local b = p.Character:FindFirstChild("HumanoidRootPart")
                    if a and b then a.CFrame = b.CFrame + Vector3.new(0,0,3) end
                end
            end
        })
    end
end
Players.PlayerAdded:Connect(function(p)
    tp:Button({
        Title = p.Name, Desc = "Teleport to " .. p.Name,
        Callback = function()
            local a = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local b = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if a and b then a.CFrame = b.CFrame + Vector3.new(0,0,3) end
        end
    })
end)

-- ---------- ESP ----------
esp:Section("Counter ESP")
local espEnabled = false
local highlights = {}
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
    local function hasCounter()
        for _, acc in ipairs(ch:GetChildren()) do
            if acc:IsA("Accessory") and acc.Name == "Counter" then return true end
        end
    end
    if hasCounter() then addHL(ch) end
    ch.ChildAdded:Connect(function(c)
        if c:IsA("Accessory") and c.Name == "Counter" then addHL(ch) end
    end)
    ch.ChildRemoved:Connect(function(c)
        if c:IsA("Accessory") and c.Name == "Counter" then rmHL(ch) end
    end)
end
esp:Toggle({ Title = "Counter ESP", Desc = "Highlights players with death counter",
    Value = false, Callback = function(state)
        espEnabled = state
        if state then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then watch(p.Character) end
            end
        else
            for c, _ in pairs(highlights) do rmHL(c) end
        end
    end })
Players.PlayerAdded:Connect(function(p)
    if p ~= player then
        p.CharacterAdded:Connect(function(ch)
            if espEnabled then watch(ch) end
        end)
    end
end)

-- ---------- M1 RESET ----------
M1reset:Section("M1 Reset")
local dashDuration, dashforce = 0.2, 150
M1reset:Toggle({ Title = "M1Reset", Desc = "Toggle dash GUI",
    Value = false, Callback = function(s) m1resetGuiEnabled = s end })
M1reset:Input({ Title = "duration", Desc = "how long to dash",
    Value = "0.2", Callback = function(i) dashDuration = tonumber(i) or dashDuration end })
M1reset:Input({ Title = "dash force", Desc = "speed",
    Value = "150", Callback = function(i) dashforce = tonumber(i) or dashforce end })
M1reset:Keybind({ Title = "Dash Key", Desc = "Key to trigger dash",
    Value = "E", Callback = function(k) end })

-- (Tu lógica de triggerDash, GUI del gatito, etc. va aquí tal cual del original)

-- ---------- REDUCE LAG ----------
reduce:Section("Optimización")
reduce:Button({ Title = "potato graphics", Desc = "no texture", Callback = function()
    for _, inst in ipairs(workspace:GetDescendants()) do
        if inst:IsA("Decal") or inst:IsA("Texture") or inst:IsA("SurfaceAppearance") then
            inst:Destroy()
        elseif inst:IsA("MeshPart") then
            inst.TextureID = ""; inst.Material = Enum.Material.SmoothPlastic
        elseif inst:IsA("Part") or inst:IsA("UnionOperation") then
            inst.Material = Enum.Material.SmoothPlastic
        end
    end
end })
reduce:Button({ Title = "reduce lag(max)", Desc = "", Callback = function()
    -- Pega aquí tu lógica del cleaner
    WindUI:Notify({ Title = "Optimized", Content = "Lag reduced", Duration = 3 })
end })

-- ============ IMPORTANTE ============
-- Recuerda pegar TODAS tus funciones de gameplay
-- (getRoot, getClosestEnemy, fireQ, attachTo, forceJump, flip, doTwisted2,
--  autoPressQ, setupCharacter, AntiDeath, flingLoop, triggerDash, etc.)
-- ANTES de los componentes de UI. El resto del script es idéntico, solo
-- WindUI ahora es tu nueva librería con la misma API.
