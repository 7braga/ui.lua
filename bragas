-- ═══════════════════════════════════════════════════════════════════════════════
-- BLOX FRUITS - ADVANCED PVP SYSTEM
-- Silent Aim | ESP | FOV Circle | Tracer | Mobile-Optimized UI
-- Nivel Avanzado - Programador Profesional
-- ═══════════════════════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LP:GetMouse()

-- ═══ ESTADOS Y CONFIGURACIÓN ═══
local State = {
    SilentAim = {
        Enabled = false,
        FOVRadius = 150,
        DetectionRange = 100,
        AutoAim = true,
        LineOfSight = true,
    },
    ESP = {
        Enabled = false,
        Box = true,
        Tracer = true,
        FOVCircle = true,
        Distance = true,
    },
    UI = {
        Open = true,
        MinimizeRequested = false,
    },
    CurrentTarget = nil,
}

-- ═══ COLORES (Tema Profesional) ═══
local Colors = {
    UI_BG = Color3.fromRGB(10, 10, 15),
    UI_ACCENT = Color3.fromRGB(0, 150, 255),
    UI_TEXT = Color3.fromRGB(255, 255, 255),
    UI_BORDER = Color3.fromRGB(50, 50, 60),
    ESP_PLAYER = Color3.fromRGB(255, 100, 100),
    ESP_TEAM = Color3.fromRGB(100, 255, 100),
    FOV_CIRCLE = Color3.fromRGB(0, 150, 255),
    TRACER = Color3.fromRGB(255, 200, 0),
}

-- ═══ SERVICIO DE DIBUJO (Drawing API) ═══
local Drawing = {
    Drawings = {},
}

local function createDrawing(type, props)
    local d = Drawing.new(type)
    for k, v in pairs(props or {}) do
        pcall(function() d[k] = v end)
    end
    table.insert(Drawing.Drawings, d)
    return d
end

-- Intentar usar Drawing library si existe
if not Drawing.new then
    Drawing.new = function(type)
        local obj = {}
        obj.Visible = true
        obj.Color = Color3.new(1, 1, 1)
        obj.Remove = function(self) end
        return obj
    end
end

-- ═══ FUNCIONES CORE ═══
local function GetCharacter(player)
    if not player or not player.Character then return nil end
    return player.Character
end

local function GetHumanoidRootPart(player)
    local char = GetCharacter(player)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid(player)
    local char = GetCharacter(player)
    if not char then return nil end
    return char:FindFirstChild("Humanoid")
end

local function IsPlayerAlive(player)
    local hum = GetHumanoid(player)
    if not hum or hum.Health <= 0 then return false end
    return true
end

local function IsSameTeam(player1, player2)
    if not player1.Team or not player2.Team then return false end
    return player1.Team == player2.Team
end

local function IsInLineOfSight(targetPos)
    if not State.SilentAim.LineOfSight then return true end
    
    local rayOrigin = Camera.CFrame.Position
    local rayDirection = (targetPos - rayOrigin).Unit * 1000
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LP.Character}
    
    local rayResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    
    if not rayResult then return true end
    
    local hitPlayer = Players:GetPlayerFromCharacter(rayResult.Instance:FindFirstAncestorOfClass("Model"))
    return hitPlayer ~= nil
end

local function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = State.SilentAim.DetectionRange
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LP then continue end
        if not IsPlayerAlive(player) then continue end
        if IsSameTeam(LP, player) then continue end
        
        local hrp = GetHumanoidRootPart(player)
        if not hrp then continue end
        
        local playerLPhrp = GetHumanoidRootPart(LP)
        if not playerLPhrp then continue end
        
        local distance = (hrp.Position - playerLPhrp.Position).Magnitude
        if distance > closestDistance then continue end
        
        -- Verificar si está dentro del FOV circle
        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if not onScreen then continue end
        
        local mousePos = UserInputService:GetMouseLocation()
        local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
        
        if screenDist > State.SilentAim.FOVRadius then continue end
        
        -- Verificar línea de vista
        if not IsInLineOfSight(hrp.Position) then continue end
        
        if distance < closestDistance then
            closestDistance = distance
            closestPlayer = player
        end
    end
    
    return closestPlayer
end

-- ═══ FUNCIONES ESP ═══
local function WorldToScreen(pos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen
end

local function DrawPlayerBox(player, color)
    if not State.ESP.Box then return end
    
    local hrp = GetHumanoidRootPart(player)
    if not hrp then return end
    
    local headPos, onScreen1 = WorldToScreen(hrp.Position + Vector3.new(0, 3, 0))
    local feetPos, onScreen2 = WorldToScreen(hrp.Position - Vector3.new(0, 3, 0))
    
    if not onScreen1 or not onScreen2 then return end
    
    local boxHeight = (headPos - feetPos).Magnitude
    local boxWidth = boxHeight * 0.4
    
    -- Top line
    createDrawing("Line", {
        From = headPos + Vector2.new(-boxWidth/2, 0),
        To = headPos + Vector2.new(boxWidth/2, 0),
        Color = color,
        Thickness = 1.5,
    })
    
    -- Bottom line
    createDrawing("Line", {
        From = feetPos + Vector2.new(-boxWidth/2, 0),
        To = feetPos + Vector2.new(boxWidth/2, 0),
        Color = color,
        Thickness = 1.5,
    })
    
    -- Left line
    createDrawing("Line", {
        From = headPos + Vector2.new(-boxWidth/2, 0),
        To = feetPos + Vector2.new(-boxWidth/2, 0),
        Color = color,
        Thickness = 1.5,
    })
    
    -- Right line
    createDrawing("Line", {
        From = headPos + Vector2.new(boxWidth/2, 0),
        To = feetPos + Vector2.new(boxWidth/2, 0),
        Color = color,
        Thickness = 1.5,
    })
end

local function DrawTracer(player, color)
    if not State.ESP.Tracer then return end
    
    local hrp = GetHumanoidRootPart(player)
    if not hrp then return end
    
    local targetPos, onScreen = WorldToScreen(hrp.Position)
    if not onScreen then return end
    
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    createDrawing("Line", {
        From = screenCenter,
        To = targetPos,
        Color = color,
        Thickness = 2,
    })
end

local function DrawDistance(player, color)
    if not State.ESP.Distance then return end
    
    local hrp = GetHumanoidRootPart(player)
    local playerhrp = GetHumanoidRootPart(LP)
    
    if not hrp or not playerhrp then return end
    
    local distance = (hrp.Position - playerhrp.Position).Magnitude
    local textPos, onScreen = WorldToScreen(hrp.Position)
    
    if not onScreen then return end
    
    createDrawing("Text", {
        Position = textPos,
        Text = math.floor(distance) .. "m",
        Color = color,
        Size = 13,
    })
end

local function DrawFOVCircle()
    if not State.ESP.FOVCircle or not State.SilentAim.Enabled then return end
    
    local mousePos = UserInputService:GetMouseLocation()
    local segments = 60
    local radius = State.SilentAim.FOVRadius
    
    for i = 1, segments do
        local angle1 = (i - 1) * (2 * math.pi / segments)
        local angle2 = i * (2 * math.pi / segments)
        
        local x1 = mousePos.X + math.cos(angle1) * radius
        local y1 = mousePos.Y + math.sin(angle1) * radius
        local x2 = mousePos.X + math.cos(angle2) * radius
        local y2 = mousePos.Y + math.sin(angle2) * radius
        
        createDrawing("Line", {
            From = Vector2.new(x1, y1),
            To = Vector2.new(x2, y2),
            Color = Colors.FOV_CIRCLE,
            Thickness = 1,
        })
    end
end

local function ClearDrawings()
    for _, d in pairs(Drawing.Drawings) do
        pcall(function() d:Remove() end)
    end
    Drawing.Drawings = {}
end

-- ═══ MAIN LOOP - SILENT AIM & ESP ═══
RunService.RenderStepped:Connect(function()
    ClearDrawings()
    
    if State.SilentAim.Enabled and State.SilentAim.AutoAim then
        State.CurrentTarget = GetClosestPlayer()
    end
    
    if State.ESP.Enabled then
        DrawFOVCircle()
        
        for _, player in pairs(Players:GetPlayers()) do
            if player == LP then continue end
            if not IsPlayerAlive(player) then continue end
            
            local color = IsSameTeam(LP, player) and Colors.ESP_TEAM or Colors.ESP_PLAYER
            
            DrawPlayerBox(player, color)
            DrawTracer(player, color == Colors.ESP_PLAYER and Colors.TRACER or Colors.ESP_TEAM)
            DrawDistance(player, color)
        end
    end
end)

-- ═══ APLICAR SILENT AIM AL CLICK ═══
Mouse.Button1Down:Connect(function()
    if not State.SilentAim.Enabled or not State.CurrentTarget then return end
    
    local targetHRP = GetHumanoidRootPart(State.CurrentTarget)
    if not targetHRP then return end
    
    -- Mover el mouse al target
    local screenPos, onScreen = Camera:WorldToViewportPoint(targetHRP.Position)
    if onScreen then
        Mouse.X = screenPos.X
        Mouse.Y = screenPos.Y
    end
end)

-- ═══ UI - CREACIÓN ═══
local function new(class, props)
    local obj = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            pcall(function() obj[k] = v end)
        end
    end
    return obj
end

local function corner(parent, radius)
    local c = new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
end

local function stroke(parent, color, thickness)
    local s = new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1.5
    s.Parent = parent
end

local ScreenGui = new("ScreenGui", {
    Name = "BloxFruitPVP",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = LP:WaitForChild("PlayerGui")
})

local MainFrame = new("Frame", {
    BackgroundColor3 = Colors.UI_BG,
    Size = UDim2.new(0, 280, 0, 520),
    Position = UDim2.new(1, -300, 0.5, -260),
    BorderSizePixel = 0,
    Parent = ScreenGui
})
corner(MainFrame, 12)
stroke(MainFrame, Colors.UI_ACCENT, 2)

-- HEADER
local Header = new("Frame", {
    BackgroundColor3 = Colors.UI_ACCENT,
    Size = UDim2.new(1, 0, 0, 45),
    BorderSizePixel = 0,
    Parent = MainFrame
})
corner(Header, 12)

new("TextLabel", {
    BackgroundTransparency = 1,
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    Text = "⚔️ BLOX FRUITS PVP",
    Size = UDim2.new(1, -80, 1, 0),
    Position = UDim2.new(0, 8, 0, 0),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header
})

-- Minimizar
local MinBtn = new("TextButton", {
    BackgroundColor3 = Colors.UI_ACCENT,
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    Text = "_",
    Size = UDim2.new(0, 35, 1, 0),
    Position = UDim2.new(1, -75, 0, 0),
    BorderSizePixel = 0,
    Parent = Header
})
corner(MinBtn)

-- Cerrar
local CloseBtn = new("TextButton", {
    BackgroundColor3 = Color3.fromRGB(220, 70, 70),
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    Text = "✕",
    Size = UDim2.new(0, 35, 1, 0),
    Position = UDim2.new(1, -35, 0, 0),
    BorderSizePixel = 0,
    Parent = Header
})
corner(CloseBtn)

-- TABS
local TabButtons = new("Frame", {
    BackgroundColor3 = Color3.fromRGB(20, 20, 25),
    Size = UDim2.new(1, 0, 0, 40),
    Position = UDim2.new(0, 0, 0, 45),
    BorderSizePixel = 0,
    Parent = MainFrame
})

new("UIListLayout", {
    Orientation = Enum.Orientation.Horizontal,
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 2),
    Parent = TabButtons
})

local ContentArea = new("Frame", {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, -85),
    Position = UDim2.new(0, 0, 0, 85),
    BorderSizePixel = 0,
    Parent = MainFrame
})

local CurrentTab = nil

local function CreateTab(name, displayName)
    local TabBtn = new("TextButton", {
        BackgroundColor3 = Color3.fromRGB(20, 20, 25),
        TextColor3 = Colors.UI_TEXT,
        TextSize = 9,
        Font = Enum.Font.GothamBold,
        Text = displayName,
        Size = UDim2.new(0, 90, 1, 0),
        BorderSizePixel = 0,
        Parent = TabButtons
    })
    
    local TabContent = new("ScrollingFrame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = false,
        ScrollBarThickness = 3,
        Parent = ContentArea
    })
    
    local Layout = new("UIListLayout")
    Layout.Padding = UDim.new(0, 5)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = TabContent
    
    new("UIPadding", {
        PaddingLeft = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 6),
        PaddingTop = UDim.new(0, 6),
        PaddingBottom = UDim.new(0, 6),
        Parent = TabContent
    })
    
    TabBtn.MouseButton1Click:Connect(function()
        if CurrentTab then CurrentTab.Visible = false end
        TabContent.Visible = true
        CurrentTab = TabContent
        
        for _, btn in pairs(TabButtons:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = (btn == TabBtn) and Colors.UI_ACCENT or Color3.fromRGB(20, 20, 25)
            end
        end
    end)
    
    local function AddToggle(text, stateTable, key)
        local Container = new("Frame", {
            BackgroundColor3 = Color3.fromRGB(25, 25, 32),
            Size = UDim2.new(1, 0, 0, 38),
            BorderSizePixel = 0,
            Parent = TabContent
        })
        corner(Container, 6)
        
        new("TextLabel", {
            BackgroundTransparency = 1,
            TextColor3 = Colors.UI_TEXT,
            TextSize = 10,
            Font = Enum.Font.Gotham,
            Text = text,
            Size = UDim2.new(1, -50, 1, 0),
            Position = UDim2.new(0, 6, 0, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = Container
        })
        
        local ToggleBg = new("Frame", {
            BackgroundColor3 = stateTable[key] and Color3.fromRGB(76, 200, 100) or Color3.fromRGB(50, 50, 60),
            Size = UDim2.new(0, 40, 0, 22),
            Position = UDim2.new(1, -46, 0.5, -11),
            BorderSizePixel = 0,
            Parent = Container
        })
        corner(ToggleBg, 11)
        
        ToggleBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                stateTable[key] = not stateTable[key]
                ToggleBg.BackgroundColor3 = stateTable[key] and Color3.fromRGB(76, 200, 100) or Color3.fromRGB(50, 50, 60)
            end
        end)
    end
    
    return { AddToggle = AddToggle }
end

-- CREAR TABS
local AimTab = CreateTab("aim", "⚙️ AIM")
AimTab.AddToggle("Enable", State.SilentAim, "Enabled")
AimTab.AddToggle("Auto Aim", State.SilentAim, "AutoAim")
AimTab.AddToggle("Line of Sight", State.SilentAim, "LineOfSight")

local ESPTab = CreateTab("esp", "👁️ ESP")
ESPTab.AddToggle("Enable", State.ESP, "Enabled")
ESPTab.AddToggle("Box", State.ESP, "Box")
ESPTab.AddToggle("Tracer", State.ESP, "Tracer")
ESPTab.AddToggle("FOV Circle", State.ESP, "FOVCircle")
ESPTab.AddToggle("Distance", State.ESP, "Distance")

-- MINIMIZE
local IsMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    if IsMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 280, 0, 45)}):Play()
        MinBtn.Text = "□"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 280, 0, 520)}):Play()
        MinBtn.Text = "_"
    end
end)

-- CLOSE
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = MainFrame.Position + UDim2.new(0, 350, 0, 0)}):Play()
    task.wait(0.4)
    ScreenGui:Destroy()
end)

-- DRAGGABLE
local Dragging = false
local DragOffset = Vector2.new()

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragOffset = UserInputService:GetMouseLocation() - MainFrame.AbsolutePosition
    end
end)

Header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        MainFrame.Position = UDim2.new(0, UserInputService:GetMouseLocation().X - DragOffset.X, 0, UserInputService:GetMouseLocation().Y - DragOffset.Y)
    end
end)

-- Show first tab
if TabButtons:FindFirstChild("TextButton") then
    TabButtons:FindFirstChild("TextButton"):MouseButton1Click:Emit()
end

print("✓ BLOX FRUITS PVP - Script Iniciado")
print("✓ Silent Aim + ESP Activo")
print("✓ Acceso a config en: _G.BloxFruitPVP")

_G.BloxFruitPVP = State
