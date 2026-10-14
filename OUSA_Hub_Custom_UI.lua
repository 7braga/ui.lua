-- OUSA HUB - CUSTOM UI VERSION
-- Black UI with White Text, Grey Borders
-- Modular Tech Tabs with Sliders and Controls

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local webhook = "https://discord.com/api/webhooks/1554482088869371908/BDQlRiXrzBgIdu2v4wedTNZprXGHPEt4l75kCCVqYxmuIjpmWcF1POPdoVoqG1Mq4qMo"

-- Send webhook notification
local executor = "Unknown"
pcall(function()
    if identifyexecutor then
        executor = identifyexecutor()
    end
end)

local data = {
    username = "OUSA Hub Execution",
    embeds = {{
        title = "OUSA Hub Loaded",
        color = 16776960,
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
    req({
        Url = webhook,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = json
    })
end

-- ========== UI CONSTANTS ==========
local UI_PADDING = 12
local HEADER_HEIGHT = 40
local TAB_HEIGHT = 35
local MODULE_PADDING = 10
local BORDER_SIZE = 2
local CORNER_RADIUS = 6

-- COLOR CONSTANTS
local COLOR_BG = Color3.fromRGB(15, 15, 15)      -- Very dark black
local COLOR_FG = Color3.fromRGB(240, 240, 240)  -- White text
local COLOR_BORDER = Color3.fromRGB(80, 80, 80) -- Grey border
local COLOR_HOVER = Color3.fromRGB(40, 40, 40)  -- Dark grey hover
local COLOR_ACTIVE = Color3.fromRGB(255, 200, 0) -- Gold/Yellow for active
local COLOR_PANEL = Color3.fromRGB(25, 25, 25)  -- Slightly lighter panel

-- ========== UTILITY FUNCTIONS ==========
local function getRoot(char)
    return char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("LowerTorso")
        or char:FindFirstChild("Torso")
end

local function createFrame(parent, name, props)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = parent

    if props then
        for key, value in pairs(props) do
            frame[key] = value
        end
    end

    -- Default styling
    frame.BackgroundColor3 = COLOR_BG
    frame.BorderColor3 = COLOR_BORDER
    frame.BorderSizePixel = BORDER_SIZE

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, CORNER_RADIUS)
    corner.Parent = frame

    return frame
end

local function createButton(parent, name, text, size, pos, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = parent
    button.Size = size
    button.Position = pos
    button.BackgroundColor3 = COLOR_PANEL
    button.BorderColor3 = COLOR_BORDER
    button.BorderSizePixel = BORDER_SIZE
    button.TextColor3 = COLOR_FG
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Text = text

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, CORNER_RADIUS)
    corner.Parent = button

    local mouseEnter = button.MouseEnter:Connect(function()
        button.BackgroundColor3 = COLOR_HOVER
    end)

    local mouseLeave = button.MouseLeave:Connect(function()
        button.BackgroundColor3 = COLOR_PANEL
    end)

    if callback then
        button.MouseButton1Click:Connect(callback)
    end

    return button
end

local function createTextLabel(parent, text, size, pos, textSize)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Size = size
    label.Position = pos
    label.BackgroundTransparency = 1
    label.TextColor3 = COLOR_FG
    label.TextSize = textSize or 14
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left

    return label
end

local function createSlider(parent, name, minVal, maxVal, defaultVal, callback)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Parent = parent
    container.Size = UDim2.new(1, -MODULE_PADDING * 2, 0, 50)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0

    -- Label
    local label = createTextLabel(container, name, UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 0), 12)

    -- Slider background
    local sliderBg = Instance.new("Frame")
    sliderBg.Parent = container
    sliderBg.Size = UDim2.new(1, 0, 0, 8)
    sliderBg.Position = UDim2.new(0, 0, 0, 25)
    sliderBg.BackgroundColor3 = COLOR_BORDER
    sliderBg.BorderSizePixel = 0

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 4)
    sliderCorner.Parent = sliderBg

    -- Slider handle
    local handle = Instance.new("Frame")
    handle.Name = "Handle"
    handle.Parent = sliderBg
    handle.Size = UDim2.new(0, 16, 0, 16)
    handle.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -8, 0.5, -8)
    handle.BackgroundColor3 = COLOR_ACTIVE
    handle.BorderSizePixel = 0

    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0, 8)
    handleCorner.Parent = handle

    -- Value label
    local valueLabel = createTextLabel(container, tostring(defaultVal), UDim2.new(0.3, 0, 0, 32), UDim2.new(0.7, 0, 0, 0), 12)

    -- Slider logic
    local isHolding = false
    local currentValue = defaultVal

    handle.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isHolding = true
        end
    end)

    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isHolding = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input, gameProcessed)
        if isHolding and input.UserInputType == Enum.UserInputType.MouseMovement then
            local sliderSize = sliderBg.AbsoluteSize.X
            local sliderPos = sliderBg.AbsolutePosition.X
            local mousePos = UserInputService:GetMouseLocation().X - sliderPos

            local percentage = math.clamp(mousePos / sliderSize, 0, 1)
            currentValue = math.round(minVal + (maxVal - minVal) * percentage)

            handle.Position = UDim2.new(percentage, -8, 0.5, -8)
            valueLabel.Text = tostring(currentValue)

            if callback then
                callback(currentValue)
            end
        end
    end)

    return container, function() return currentValue end
end

local function createToggle(parent, text, defaultState, callback)
    local container = Instance.new("Frame")
    container.Parent = parent
    container.Size = UDim2.new(1, -MODULE_PADDING * 2, 0, 30)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0

    -- Label
    local label = createTextLabel(container, text, UDim2.new(0.7, 0, 1, 0), UDim2.new(0, 0, 0, 0), 13)

    -- Toggle box
    local toggleBox = Instance.new("Frame")
    toggleBox.Parent = container
    toggleBox.Size = UDim2.new(0, 40, 0, 24)
    toggleBox.Position = UDim2.new(1, -45, 0.5, -12)
    toggleBox.BackgroundColor3 = defaultState and COLOR_ACTIVE or COLOR_BORDER
    toggleBox.BorderSizePixel = 0

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 4)
    toggleCorner.Parent = toggleBox

    -- Toggle button
    local toggleButton = Instance.new("TextButton")
    toggleButton.Parent = container
    toggleButton.Size = UDim2.new(0, 24, 0, 24)
    toggleButton.Position = defaultState and UDim2.new(1, -25, 0.5, -12) or UDim2.new(1, -45, 0.5, -12)
    toggleButton.BackgroundColor3 = COLOR_FG
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 3)
    buttonCorner.Parent = toggleButton

    local isToggled = defaultState

    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        toggleBox.BackgroundColor3 = isToggled and COLOR_ACTIVE or COLOR_BORDER

        local tween = game:GetService("TweenService"):Create(
            toggleButton,
            TweenInfo.new(0.2),
            {Position = isToggled and UDim2.new(1, -25, 0.5, -12) or UDim2.new(1, -45, 0.5, -12)}
        )
        tween:Play()

        if callback then
            callback(isToggled)
        end
    end)

    return container, function() return isToggled end
end

-- ========== CREATE MAIN UI ==========
local PlayerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OSUAHub"
screenGui.Parent = PlayerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main window
local mainWindow = createFrame(screenGui, "MainWindow", {
    Size = UDim2.new(0, 800, 0, 600),
    Position = UDim2.new(0.5, -400, 0.5, -300),
    BackgroundColor3 = COLOR_BG,
    BorderColor3 = COLOR_BORDER,
})

-- Header
local header = createFrame(mainWindow, "Header", {
    Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = COLOR_PANEL,
})

-- Title
local title = createTextLabel(header, "OUSA HUB", UDim2.new(1, -100, 1, 0), UDim2.new(0, UI_PADDING, 0, 0), 18)
title.Font = Enum.Font.GothamBold

-- Minimize button
local minimizeBtn = createButton(header, "MinimizeBtn", "−", UDim2.new(0, 35, 1, 0), UDim2.new(1, -90, 0, 0), function()
    mainWindow.Visible = false
end)

-- Close button
local closeBtn = createButton(header, "CloseBtn", "✕", UDim2.new(0, 35, 1, 0), UDim2.new(1, -50, 0, 0), function()
    screenGui:Destroy()
end)

-- Tab bar
local tabBar = createFrame(mainWindow, "TabBar", {
    Size = UDim2.new(1, 0, 0, TAB_HEIGHT),
    Position = UDim2.new(0, 0, 0, HEADER_HEIGHT),
    BackgroundColor3 = COLOR_PANEL,
})

local tabScroll = Instance.new("ScrollingFrame")
tabScroll.Name = "TabScroll"
tabScroll.Parent = tabBar
tabScroll.Size = UDim2.new(1, 0, 1, 0)
tabScroll.BackgroundTransparency = 1
tabScroll.BorderSizePixel = 0
tabScroll.ScrollDirection = Enum.ScrollDirection.X
tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = tabScroll
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 5)

-- Content area
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Parent = mainWindow
contentArea.Size = UDim2.new(1, 0, 1, -(HEADER_HEIGHT + TAB_HEIGHT))
contentArea.Position = UDim2.new(0, 0, 0, HEADER_HEIGHT + TAB_HEIGHT)
contentArea.BackgroundColor3 = COLOR_BG
contentArea.BorderSizePixel = 0

-- ========== TECHS DATA ==========
local TECHS = {
    {name = "Meow Tech", icon = "🐱", color = Color3.fromRGB(255, 100, 100)},
    {name = "King Tech", icon = "👑", color = Color3.fromRGB(255, 200, 0)},
    {name = "Oreo Tech", icon = "🍪", color = Color3.fromRGB(150, 100, 50)},
    {name = "Kitty Tech", icon = "😸", color = Color3.fromRGB(200, 100, 200)},
    {name = "Kakyo Tech", icon = "⚡", color = Color3.fromRGB(100, 200, 255)},
    {name = "Inner Dash", icon = "💨", color = Color3.fromRGB(100, 255, 150)},
    {name = "Instant Twisted", icon = "🌪️", color = Color3.fromRGB(200, 100, 255)},
    {name = "Lethal", icon = "💥", color = Color3.fromRGB(255, 0, 0)},
    {name = "Kyoto", icon = "🌸", color = Color3.fromRGB(255, 150, 200)},
}

-- ========== TECH CONFIG STORAGE ==========
local techConfigs = {}
for i, tech in ipairs(TECHS) do
    techConfigs[tech.name] = {
        enabled = false,
        startDelay = 0.3,
        duration = 0.3,
        jumpHeight = 50,
        cameraSpeed = 1,
        customParam = 0.5
    }
end

-- ========== CREATE TABS ==========
local tabs = {}

for i, tech in ipairs(TECHS) do
    -- Create tab button
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tech.name
    tabBtn.Parent = tabScroll
    tabBtn.Size = UDim2.new(0, 120, 0, TAB_HEIGHT)
    tabBtn.BackgroundColor3 = COLOR_PANEL
    tabBtn.BorderColor3 = COLOR_BORDER
    tabBtn.BorderSizePixel = BORDER_SIZE
    tabBtn.TextColor3 = COLOR_FG
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.Text = tech.icon .. " " .. tech.name

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, CORNER_RADIUS)
    tabCorner.Parent = tabBtn

    -- Create content frame
    local contentFrame = createFrame(contentArea, tech.name .. "Content", {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Visible = i == 1,
    })

    -- Scroll frame for content
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollFrame"
    scrollFrame.Parent = contentFrame
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 12

    local scrollLayout = Instance.new("UIListLayout")
    scrollLayout.Parent = scrollFrame
    scrollLayout.FillDirection = Enum.FillDirection.Vertical
    scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    scrollLayout.Padding = UDim.new(0, MODULE_PADDING)

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, MODULE_PADDING)
    padding.PaddingBottom = UDim.new(0, MODULE_PADDING)
    padding.PaddingLeft = UDim.new(0, MODULE_PADDING)
    padding.PaddingRight = UDim.new(0, MODULE_PADDING)
    padding.Parent = scrollFrame

    -- Enable/Disable toggle
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Parent = scrollFrame
    toggleContainer.Size = UDim2.new(1, 0, 0, 40)
    toggleContainer.BackgroundColor3 = COLOR_PANEL
    toggleContainer.BorderColor3 = COLOR_BORDER
    toggleContainer.BorderSizePixel = BORDER_SIZE
    toggleContainer.LayoutOrder = 1

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, CORNER_RADIUS)
    toggleCorner.Parent = toggleContainer

    local toggleLabel = createTextLabel(toggleContainer, "Enable " .. tech.name, UDim2.new(0.7, 0, 1, 0), UDim2.new(0, MODULE_PADDING, 0, 0), 14)
    toggleLabel.Font = Enum.Font.GothamBold

    local toggleFrame, getToggleValue = createToggle(toggleContainer, "", false, function(state)
        techConfigs[tech.name].enabled = state
    end)
    toggleFrame.Parent = toggleContainer
    toggleFrame.LayoutOrder = 2

    -- Start Delay slider
    local delayFrame, getDelayValue = createSlider(scrollFrame, "Start Delay", 0, 3, 0.3, function(value)
        techConfigs[tech.name].startDelay = value / 10
    end)
    delayFrame.LayoutOrder = 2

    -- Duration slider
    local durationFrame, getDurationValue = createSlider(scrollFrame, "Duration", 0, 5, 0.3, function(value)
        techConfigs[tech.name].duration = value / 10
    end)
    durationFrame.LayoutOrder = 3

    -- Jump Height slider
    local jumpFrame, getJumpValue = createSlider(scrollFrame, "Jump Height", 0, 100, 50, function(value)
        techConfigs[tech.name].jumpHeight = value
    end)
    jumpFrame.LayoutOrder = 4

    -- Camera Speed slider
    local cameraFrame, getCameraValue = createSlider(scrollFrame, "Camera Speed", 0, 5, 1, function(value)
        techConfigs[tech.name].cameraSpeed = value / 10
    end)
    cameraFrame.LayoutOrder = 5

    -- Custom parameter slider
    local customFrame, getCustomValue = createSlider(scrollFrame, "Power", 0, 20, 10, function(value)
        techConfigs[tech.name].customParam = value / 10
    end)
    customFrame.LayoutOrder = 6

    -- Execute button
    local executeBtn = createButton(scrollFrame, "Execute", "Execute Tech", UDim2.new(1, -(MODULE_PADDING * 2), 0, 35), UDim2.new(0, 0, 0, 0), function()
        if techConfigs[tech.name].enabled then
            -- Tech execution logic would go here
            print("Executing: " .. tech.name)
        else
            print(tech.name .. " is not enabled!")
        end
    end)
    executeBtn.LayoutOrder = 7
    executeBtn.BackgroundColor3 = tech.color

    -- Make it scrollable for canvas size
    scrollFrame.CanvasSize = UDim2.new(1, 0, 0, scrollLayout.AbsoluteContentSize.Y)
    scrollLayout.Changed:Connect(function()
        scrollFrame.CanvasSize = UDim2.new(1, 0, 0, scrollLayout.AbsoluteContentSize.Y + MODULE_PADDING * 2)
    end)

    -- Tab button functionality
    tabBtn.MouseButton1Click:Connect(function()
        -- Hide all tabs
        for _, frame in ipairs(contentArea:GetChildren()) do
            if frame:IsA("Frame") then
                frame.Visible = false
            end
        end

        -- Show current tab
        contentFrame.Visible = true

        -- Update tab button colors
        for _, btn in ipairs(tabScroll:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = btn == tabBtn and COLOR_ACTIVE or COLOR_PANEL
                btn.TextColor3 = btn == tabBtn and COLOR_BG or COLOR_FG
            end
        end
    end)

    -- Set first tab as active
    if i == 1 then
        tabBtn.BackgroundColor3 = COLOR_ACTIVE
        tabBtn.TextColor3 = COLOR_BG
    end

    table.insert(tabs, {
        button = tabBtn,
        content = contentFrame,
        config = techConfigs[tech.name]
    })
end

-- ========== UTILITY PANEL TAB ==========
local utilityToggleLayout = Instance.new("UIListLayout")

local utilityTabBtn = Instance.new("TextButton")
utilityTabBtn.Name = "UtilityTab"
utilityTabBtn.Parent = tabScroll
utilityTabBtn.Size = UDim2.new(0, 120, 0, TAB_HEIGHT)
utilityTabBtn.BackgroundColor3 = COLOR_PANEL
utilityTabBtn.BorderColor3 = COLOR_BORDER
utilityTabBtn.BorderSizePixel = BORDER_SIZE
utilityTabBtn.TextColor3 = COLOR_FG
utilityTabBtn.TextSize = 12
utilityTabBtn.Font = Enum.Font.GothamBold
utilityTabBtn.Text = "⚙️ Utilities"

local utilityCorner = Instance.new("UICorner")
utilityCorner.CornerRadius = UDim.new(0, CORNER_RADIUS)
utilityCorner.Parent = utilityTabBtn

local utilityContent = createFrame(contentArea, "UtilityContent", {
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    Visible = false,
})

local utilityScroll = Instance.new("ScrollingFrame")
utilityScroll.Name = "UtilityScroll"
utilityScroll.Parent = utilityContent
utilityScroll.Size = UDim2.new(1, 0, 1, 0)
utilityScroll.BackgroundTransparency = 1
utilityScroll.BorderSizePixel = 0

local utilityLayout = Instance.new("UIListLayout")
utilityLayout.Parent = utilityScroll
utilityLayout.FillDirection = Enum.FillDirection.Vertical
utilityLayout.SortOrder = Enum.SortOrder.LayoutOrder
utilityLayout.Padding = UDim.new(0, MODULE_PADDING)

local utilityPadding = Instance.new("UIPadding")
utilityPadding.PaddingTop = UDim.new(0, MODULE_PADDING)
utilityPadding.PaddingBottom = UDim.new(0, MODULE_PADDING)
utilityPadding.PaddingLeft = UDim.new(0, MODULE_PADDING)
utilityPadding.PaddingRight = UDim.new(0, MODULE_PADDING)
utilityPadding.Parent = utilityScroll

-- WalkSpeed toggle and slider
local walkSpeedEnabled = false
local walkSpeedValue = 50

local walkToggle, getWalkToggle = createToggle(utilityScroll, "Walk Speed Boost", false, function(state)
    walkSpeedEnabled = state
end)
walkToggle.LayoutOrder = 1

local walkSlider, getWalkSlider = createSlider(utilityScroll, "Walk Speed", 0, 100, 50, function(value)
    walkSpeedValue = value
    if walkSpeedEnabled and player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value / 2
        end
    end
end)
walkSlider.LayoutOrder = 2

-- Touch Fling toggle
local flingEnabled = false
local flingPower = 10000

local flingToggle, getFlingToggle = createToggle(utilityScroll, "Touch Fling", false, function(state)
    flingEnabled = state
end)
flingToggle.LayoutOrder = 3

-- No Dash Cooldown toggle
local noCooldownEnabled = false

local noCooldownToggle, getNoCooldownToggle = createToggle(utilityScroll, "No Dash Cooldown", false, function(state)
    noCooldownEnabled = state
    if state then
        workspace:SetAttribute("NoDashCooldown", true)
    else
        workspace:SetAttribute("NoDashCooldown", false)
    end
end)
noCooldownToggle.LayoutOrder = 4

-- Anti Death Counter toggle
local antiDeathEnabled = false

local antiDeathToggle, getAntiDeathToggle = createToggle(utilityScroll, "Anti Death Counter", false, function(state)
    antiDeathEnabled = state
end)
antiDeathToggle.LayoutOrder = 5

-- Copy Discord Link button
local discordBtn = createButton(utilityScroll, "DiscordBtn", "📋 Copy Discord Invite", UDim2.new(1, -(MODULE_PADDING * 2), 0, 35), UDim2.new(0, 0, 0, 0), function()
    if setclipboard then
        setclipboard("https://discord.gg/dCnvGNYANP")
    end
end)
discordBtn.LayoutOrder = 6

utilityScroll.CanvasSize = UDim2.new(1, 0, 0, utilityLayout.AbsoluteContentSize.Y)
utilityLayout.Changed:Connect(function()
    utilityScroll.CanvasSize = UDim2.new(1, 0, 0, utilityLayout.AbsoluteContentSize.Y + MODULE_PADDING * 2)
end)

utilityTabBtn.MouseButton1Click:Connect(function()
    for _, frame in ipairs(contentArea:GetChildren()) do
        if frame:IsA("Frame") then
            frame.Visible = false
        end
    end
    utilityContent.Visible = true

    for _, btn in ipairs(tabScroll:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.BackgroundColor3 = btn == utilityTabBtn and COLOR_ACTIVE or COLOR_PANEL
            btn.TextColor3 = btn == utilityTabBtn and COLOR_BG or COLOR_FG
        end
    end
end)

-- Update canvas size for tab scroll
tabScroll.CanvasSize = UDim2.new(0, tabLayout.AbsoluteContentSize.X + 20, 0, 0)
tabLayout.Changed:Connect(function()
    tabScroll.CanvasSize = UDim2.new(0, tabLayout.AbsoluteContentSize.X + 20, 0, 0)
end)

-- Make window draggable
local dragging = false
local dragInput
local dragStart
local startPos

header.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainWindow.Position

        dragInput = input.Changed:Connect(function()
            if input.UserState == Enum.UserInputState.End then
                dragging = false
                dragInput:Disconnect()
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainWindow.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

print("✅ OUSA Hub UI loaded successfully!")
