-- ═══════════════════════════════════════════════════════════════
-- TSB TECHS EXTRAÍDAS - UI AVANZADA
-- Tabs | Sliders | Toggles | Minimizar | Cerrar
-- ═══════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- ═══ CONSTANTES ═══
local UPPERCUT = {
    [13156066514] = true,
}

local TARGET_ANIM_ID = 12296113986

-- ═══ CONFIGURACIÓN ═══
local Config = {
    KingTechEnabled = false,
    OreoDripzEnabled = false,
    LethalDashEnabled = false,
    BoomyEnabled = false,
    InstaLethalEnabled = false,
    LethalNormalEnabled = false,
    
    -- King settings
    kingstart = 0.3,
    kingwait = 0.2,
    
    -- Oreo settings
    oreostart = 0.3,
    oreowait = 0.5,
    oreocam = 1,
    oreojump = 54,
    
    -- Boomy settings
    boomystart = 1.7,
    boomyjump = 65,
    boomywait = 0.1,
    boomycam = 3,
    
    -- Instant Lethal settings
    instantlethalstart = 1.7,
    instantlethalwait = 0.5,
    
    -- Lethal Normal settings
    meowlethalstart = 1.7,
    meowlethaldur = 0.5,
    
    -- Lethal Dash settings
    normallethalstart = 1.7,
    secondforflip = 0.2,
}

-- ═══ COLORES ═══
local Colors = {
    BgMain = Color3.fromRGB(20, 20, 25),
    BgSecond = Color3.fromRGB(30, 30, 35),
    BgTab = Color3.fromRGB(25, 25, 32),
    TextMain = Color3.fromRGB(255, 255, 255),
    TextSecond = Color3.fromRGB(150, 150, 160),
    Accent = Color3.fromRGB(0, 150, 255),
    AccentHover = Color3.fromRGB(0, 180, 255),
    Success = Color3.fromRGB(76, 200, 100),
    Danger = Color3.fromRGB(220, 70, 70),
    Border = Color3.fromRGB(50, 50, 60),
}

-- ═══ FUNCIONES AUXILIARES ═══
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
    s.Color = color or Colors.Border
    s.Thickness = thickness or 1.5
    s.Parent = parent
end

local function notify(title, message, duration)
    local notifGui = new("ScreenGui", {
        Name = "TSBNotif",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = player:WaitForChild("PlayerGui")
    })
    
    local notifFrame = new("Frame", {
        BackgroundColor3 = Colors.BgSecond,
        Size = UDim2.new(0, 300, 0, 80),
        Position = UDim2.new(1, -320, 1, -100),
        BorderSizePixel = 0,
        Parent = notifGui
    })
    corner(notifFrame, 8)
    stroke(notifFrame, Colors.Accent)
    
    new("TextLabel", {
        BackgroundTransparency = 1,
        TextColor3 = Colors.Accent,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Text = title,
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.new(0, 10, 0, 5),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notifFrame
    })
    
    new("TextLabel", {
        BackgroundTransparency = 1,
        TextColor3 = Colors.TextSecond,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        Text = message,
        TextWrapped = true,
        Size = UDim2.new(1, -20, 1, -35),
        Position = UDim2.new(0, 10, 0, 30),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notifFrame
    })
    
    task.delay(duration or 3, function()
        TweenService:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 
            {Position = UDim2.new(1, 0, 1, -100)}):Play()
        task.wait(0.4)
        notifGui:Destroy()
    end)
end

-- ═══ MAIN UI ═══
local screenGui = new("ScreenGui", {
    Name = "TSB_UI",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = player:WaitForChild("PlayerGui")
})

local mainFrame = new("Frame", {
    BackgroundColor3 = Colors.BgMain,
    Size = UDim2.new(0, 320, 0, 600),
    Position = UDim2.new(1, -340, 0.5, -300),
    BorderSizePixel = 0,
    Parent = screenGui
})
corner(mainFrame, 12)
stroke(mainFrame, Colors.Accent, 2)

-- ═══ HEADER ═══
local header = new("Frame", {
    BackgroundColor3 = Colors.Accent,
    Size = UDim2.new(1, 0, 0, 45),
    BorderSizePixel = 0,
    Parent = mainFrame
})
corner(header, 12)

new("TextLabel", {
    BackgroundTransparency = 1,
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    Text = "⚔️ TSB TECHS",
    Size = UDim2.new(1, -90, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = header
})

-- Minimizar
local minimizeBtn = new("TextButton", {
    BackgroundColor3 = Colors.AccentHover,
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    Text = "_",
    Size = UDim2.new(0, 35, 1, 0),
    Position = UDim2.new(1, -75, 0, 0),
    BorderSizePixel = 0,
    Parent = header
})
corner(minimizeBtn)

-- Cerrar
local closeBtn = new("TextButton", {
    BackgroundColor3 = Colors.Danger,
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    Text = "✕",
    Size = UDim2.new(0, 35, 1, 0),
    Position = UDim2.new(1, -35, 0, 0),
    BorderSizePixel = 0,
    Parent = header
})
corner(closeBtn)

-- ═══ DRAGGABLE ═══
local dragging = false
local dragOffset = Vector2.new(0, 0)

header.InputBegan:Connect(function(input, gp)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragOffset = UserInputService:GetMouseLocation() - mainFrame.AbsolutePosition
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        mainFrame.Position = UDim2.new(0, UserInputService:GetMouseLocation().X - dragOffset.X, 0, UserInputService:GetMouseLocation().Y - dragOffset.Y)
    end
end)

-- ═══ TABS CONTAINER ═══
local tabButtons = new("Frame", {
    BackgroundColor3 = Colors.BgSecond,
    Size = UDim2.new(1, 0, 0, 40),
    Position = UDim2.new(0, 0, 0, 45),
    BorderSizePixel = 0,
    Parent = mainFrame
})

new("UIListLayout", {
    Orientation = Enum.Orientation.Horizontal,
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    Padding = UDim.new(0, 0),
    Parent = tabButtons
})

local contentArea = new("Frame", {
    BackgroundColor3 = Colors.BgTab,
    Size = UDim2.new(1, 0, 1, -85),
    Position = UDim2.new(0, 0, 0, 85),
    BorderSizePixel = 0,
    Parent = mainFrame
})

-- ═══ TAB SYSTEM ═══
local currentTab = nil

local function createTab(name, displayName)
    local tabBtn = new("TextButton", {
        BackgroundColor3 = Colors.BgTab,
        TextColor3 = Colors.TextSecond,
        TextSize = 9,
        Font = Enum.Font.GothamBold,
        Text = displayName,
        Size = UDim2.new(0, 53, 1, 0),
        BorderSizePixel = 0,
        Parent = tabButtons
    })
    
    local tabContent = new("ScrollingFrame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = false,
        ScrollBarThickness = 4,
        Parent = contentArea
    })
    
    local layout = new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = tabContent
    
    new("UIPadding", {
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
        Parent = tabContent
    })
    
    tabBtn.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.Visible = false
        end
        tabContent.Visible = true
        currentTab = tabContent
        
        for _, btn in pairs(tabButtons:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = (btn == tabBtn) and Colors.Accent or Colors.BgTab
                btn.TextColor3 = (btn == tabBtn) and Color3.new(1,1,1) or Colors.TextSecond
            end
        end
    end)
    
    local function addToggle(text, configKey)
        local container = new("Frame", {
            BackgroundColor3 = Colors.BgSecond,
            Size = UDim2.new(1, 0, 0, 35),
            BorderSizePixel = 0,
            Parent = tabContent
        })
        corner(container, 6)
        
        new("TextLabel", {
            BackgroundTransparency = 1,
            TextColor3 = Colors.TextMain,
            TextSize = 10,
            Font = Enum.Font.Gotham,
            Text = text,
            Size = UDim2.new(1, -50, 1, 0),
            Position = UDim2.new(0, 8, 0, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = container
        })
        
        local toggleBg = new("Frame", {
            BackgroundColor3 = Config[configKey] and Colors.Success or Colors.BgMain,
            Size = UDim2.new(0, 35, 0, 20),
            Position = UDim2.new(1, -43, 0.5, -10),
            BorderSizePixel = 0,
            Parent = container
        })
        corner(toggleBg, 10)
        
        toggleBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Config[configKey] = not Config[configKey]
                toggleBg.BackgroundColor3 = Config[configKey] and Colors.Success or Colors.BgMain
                notify("Tech", text .. " - " .. (Config[configKey] and "✓ ON" or "✗ OFF"))
            end
        end)
        
        toggleBg.Active = true
    end
    
    local function addSlider(text, configKey, min, max)
        local container = new("Frame", {
            BackgroundColor3 = Colors.BgSecond,
            Size = UDim2.new(1, 0, 0, 45),
            BorderSizePixel = 0,
            Parent = tabContent
        })
        corner(container, 6)
        
        local label = new("TextLabel", {
            BackgroundTransparency = 1,
            TextColor3 = Colors.TextMain,
            TextSize = 9,
            Font = Enum.Font.GothamBold,
            Text = text .. ": " .. tostring(math.floor(Config[configKey] * 100) / 100),
            Size = UDim2.new(1, -10, 0, 16),
            Position = UDim2.new(0, 5, 0, 4),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = container
        })
        
        local sliderBg = new("Frame", {
            BackgroundColor3 = Colors.BgMain,
            Size = UDim2.new(1, -16, 0, 5),
            Position = UDim2.new(0, 8, 0, 24),
            BorderSizePixel = 0,
            Parent = container
        })
        corner(sliderBg, 3)
        
        local percentage = (Config[configKey] - min) / (max - min)
        local sliderFill = new("Frame", {
            BackgroundColor3 = Colors.Accent,
            Size = UDim2.new(percentage, 0, 1, 0),
            BorderSizePixel = 0,
            Parent = sliderBg
        })
        corner(sliderFill, 3)
        
        local draggingSlider = false
        
        sliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSlider = true
            end
        end)
        
        sliderBg.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSlider = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mouse = player:GetMouse()
                local percentage2 = math.clamp((mouse.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                local value = min + (max - min) * percentage2
                
                Config[configKey] = value
                sliderFill.Size = UDim2.new(percentage2, 0, 1, 0)
                label.Text = text .. ": " .. tostring(math.floor(value * 100) / 100)
            end
        end)
    end
    
    return {
        AddToggle = addToggle,
        AddSlider = addSlider
    }
end

-- ═══ CREAR TABS ═══

-- TAB 1: KING TECH
local kingTab = createTab("king", "👑 King")
kingTab.AddToggle("Enable", "KingTechEnabled")
kingTab.AddSlider("Start Delay", "kingstart", 0, 1)
kingTab.AddSlider("Flip Delay", "kingwait", 0, 1)

-- TAB 2: OREO/DRIPZ
local oreoTab = createTab("oreo", "🎨 Oreo")
oreoTab.AddToggle("Enable", "OreoDripzEnabled")
oreoTab.AddSlider("Start Delay", "oreostart", 0, 1)
oreoTab.AddSlider("Follow Delay", "oreowait", 0, 1)
oreoTab.AddSlider("Cam Speed", "oreocam", 0.1, 5)
oreoTab.AddSlider("Jump Height", "oreojump", 30, 100)

-- TAB 3: LETHAL DASH
local dashTab = createTab("dash", "💨 Dash")
dashTab.AddToggle("Enable", "LethalDashEnabled")
dashTab.AddSlider("Start Delay", "normallethalstart", 0, 3)
dashTab.AddSlider("Flip Delay", "secondforflip", 0, 1)

-- TAB 4: BOOMY
local boomyTab = createTab("boomy", "💣 Boomy")
boomyTab.AddToggle("Enable", "BoomyEnabled")
boomyTab.AddSlider("Start Delay", "boomystart", 0, 3)
boomyTab.AddSlider("Jump Height", "boomyjump", 30, 100)
boomyTab.AddSlider("Wait", "boomywait", 0, 1)
boomyTab.AddSlider("Cam Speed", "boomycam", 0.1, 5)

-- TAB 5: INSTA LETHAL
local instaTab = createTab("insta", "⚡ Insta")
instaTab.AddToggle("Enable", "InstaLethalEnabled")
instaTab.AddSlider("Start Delay", "instantlethalstart", 0, 3)
instaTab.AddSlider("Wait", "instantlethalwait", 0, 1)

-- TAB 6: LETHAL NORMAL
local normalTab = createTab("normal", "🔥 Normal")
normalTab.AddToggle("Enable", "LethalNormalEnabled")
normalTab.AddSlider("Start Delay", "meowlethalstart", 0, 3)
normalTab.AddSlider("Attach Duration", "meowlethaldur", 0, 1)

-- ═══ MINIMIZE LOGIC ═══
local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 45)}):Play()
        minimizeBtn.Text = "□"
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 600)}):Play()
        minimizeBtn.Text = "_"
    end
end)

-- CLOSE
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = mainFrame.Position + UDim2.new(0, 400, 0, 0)}):Play()
    task.wait(0.4)
    screenGui:Destroy()
end)

-- ═══ FUNCIONES DE COMBATE ═══
local function getRoot(char)
    return char:FindFirstChild("HumanoidRootPart")
end

local function getClosestEnemy(range)
    local closestEnemy = nil
    local closestDist = range or 50
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local targetRoot = getRoot(targetPlayer.Character)
            local playerRoot = getRoot(character)
            
            if targetRoot and playerRoot then
                local dist = (targetRoot.Position - playerRoot.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestEnemy = targetPlayer.Character
                end
            end
        end
    end
    
    return closestEnemy
end

local function forceJump(jumpPower)
    jumpPower = jumpPower or 50
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        local hrp = getRoot(character)
        if hrp then
            hrp.AssemblyLinearVelocity = Vector3.new(
                hrp.AssemblyLinearVelocity.X,
                jumpPower / 20,
                hrp.AssemblyLinearVelocity.Z
            )
        end
    end
end

local function autoPressQ()
    UserInputService:SendKeyEvent(true, Enum.KeyCode.Q, false)
    task.wait(0.05)
    UserInputService:SendKeyEvent(false, Enum.KeyCode.Q, false)
end

local function flip()
    local hrp = getRoot(character)
    if hrp then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, 0, math.rad(180))
    end
end

local function fireQ()
    UserInputService:SendKeyEvent(true, Enum.KeyCode.Q, false)
    task.wait(0.1)
    UserInputService:SendKeyEvent(false, Enum.KeyCode.Q, false)
end

local function attachTo(targetChar, duration, doFlip)
    local hrp = getRoot(character)
    local targetRoot = getRoot(targetChar)
    
    if hrp and targetRoot then
        local startTime = tick()
        local connection
        
        connection = RunService.Heartbeat:Connect(function()
            if not hrp or not hrp.Parent or not targetRoot or not targetRoot.Parent then
                connection:Disconnect()
                return
            end
            
            if tick() - startTime >= duration then
                connection:Disconnect()
                if doFlip then flip() end
                return
            end
            
            hrp.CFrame = targetRoot.CFrame + targetRoot.CFrame.LookVector * 3
        end)
    end
end

-- ═══ TECHS EXECUTION ═══

local function kingTech(anim)
    if Config.KingTechEnabled and UPPERCUT[anim.AnimationId] then
        local enemy = getClosestEnemy(10)
        if enemy then
            task.delay(Config.kingstart, function()
                autoPressQ()
                forceJump()
                task.delay(Config.kingwait, flip)
            end)
        end
    end
end

local function oreoTech(anim)
    if Config.OreoDripzEnabled and UPPERCUT[anim.AnimationId] then
        local enemy = getClosestEnemy(10)
        if enemy then
            task.delay(Config.oreostart, function()
                autoPressQ()
                forceJump(Config.oreojump)
            end)
            
            task.delay(Config.oreowait, function()
                local startTime = tick()
                local cam = workspace.CurrentCamera
                local targetChar = enemy
                local targetPart = targetChar:FindFirstChild("Right Arm")
                
                if not targetPart then
                    targetPart = getRoot(targetChar)
                end
                
                local connection
                connection = RunService.RenderStepped:Connect(function()
                    if not targetPart or not targetPart.Parent then
                        connection:Disconnect()
                        return
                    end
                    
                    local camCF = cam.CFrame
                    local camPos = camCF.Position
                    local armCF = targetPart.CFrame
                    local backOffset = armCF:VectorToWorldSpace(Vector3.new(0, 0, -1))
                    local backPosition = armCF.Position + backOffset
                    
                    local dir = Vector3.new(
                        backPosition.X - camPos.X,
                        0,
                        backPosition.Z - camPos.Z
                    )
                    
                    if dir.Magnitude > 0 then
                        dir = dir.Unit
                        local targetYaw = math.atan2(dir.Z, dir.X)
                        local currentYaw = math.atan2(camCF.LookVector.Z, camCF.LookVector.X)
                        local newYaw = currentYaw + (targetYaw - currentYaw) * Config.oreocam
                        local pitch = math.asin(camCF.LookVector.Y)
                        local newLook = Vector3.new(
                            math.cos(newYaw) * math.cos(pitch),
                            math.sin(pitch),
                            math.sin(newYaw) * math.cos(pitch)
                        )
                        cam.CFrame = CFrame.new(camPos, camPos + newLook)
                    end
                    
                    if tick() - startTime >= 0.2 then
                        connection:Disconnect()
                    end
                end)
            end)
        end
    end
end

local function boomyTech(animId)
    if Config.BoomyEnabled and animId == TARGET_ANIM_ID then
        local enemy = getClosestEnemy(10)
        if enemy then
            task.delay(Config.boomystart, function()
                autoPressQ()
                flip()
                forceJump(Config.boomyjump)
                task.wait(Config.boomywait)
                
                local startTime = tick()
                local cam = workspace.CurrentCamera
                local targetChar = enemy
                local targetPart = targetChar:FindFirstChild("Right Arm")
                
                if not targetPart then
                    targetPart = getRoot(targetChar)
                end
                
                local connection
                connection = RunService.RenderStepped:Connect(function()
                    if not targetPart or not targetPart.Parent then
                        connection:Disconnect()
                        return
                    end
                    
                    local camCF = cam.CFrame
                    local camPos = camCF.Position
                    local lookCF = targetPart.CFrame
                    local backPosition = lookCF.Position
                    
                    local dir = Vector3.new(
                        backPosition.X - camPos.X,
                        0,
                        backPosition.Z - camPos.Z
                    )
                    
                    if dir.Magnitude > 0 then
                        dir = dir.Unit
                        local targetYaw = math.atan2(dir.Z, dir.X)
                        local currentYaw = math.atan2(camCF.LookVector.Z, camCF.LookVector.X)
                        local newYaw = currentYaw + (targetYaw - currentYaw) * Config.boomycam
                        local pitch = math.asin(camCF.LookVector.Y)
                        local newLook = Vector3.new(
                            math.cos(newYaw) * math.cos(pitch),
                            math.sin(pitch),
                            math.sin(newYaw) * math.cos(pitch)
                        )
                        cam.CFrame = CFrame.new(camPos, camPos + newLook)
                    end
                    
                    if tick() - startTime >= 0.2 then
                        connection:Disconnect()
                    end
                end)
            end)
        end
    end
end

local function instaLethalTech(animId)
    if Config.InstaLethalEnabled and animId == TARGET_ANIM_ID then
        local enemy = getClosestEnemy(10)
        if enemy then
            task.delay(Config.instantlethalstart, function()
                autoPressQ()
                forceJump(60)
                task.delay(Config.instantlethalwait, function()
                    -- cleanup
                end)
                
                local startTime = tick()
                local cam = workspace.CurrentCamera
                local targetChar = enemy
                local targetPart = targetChar:FindFirstChild("Right Arm")
                
                if not targetPart then
                    targetPart = getRoot(targetChar)
                end
                
                local connection
                connection = RunService.RenderStepped:Connect(function()
                    if not targetPart or not targetPart.Parent then
                        connection:Disconnect()
                        return
                    end
                    
                    local camCF = cam.CFrame
                    local camPos = camCF.Position
                    local lookCF = targetPart.CFrame
                    local backPosition = lookCF.Position
                    
                    local dir = Vector3.new(
                        backPosition.X - camPos.X,
                        0,
                        backPosition.Z - camPos.Z
                    )
                    
                    if dir.Magnitude > 0 then
                        dir = dir.Unit
                        local targetYaw = math.atan2(dir.Z, dir.X)
                        local currentYaw = math.atan2(camCF.LookVector.Z, camCF.LookVector.X)
                        local newYaw = currentYaw + (targetYaw - currentYaw) * 3
                        local pitch = math.asin(camCF.LookVector.Y)
                        local newLook = Vector3.new(
                            math.cos(newYaw) * math.cos(pitch),
                            math.sin(pitch),
                            math.sin(newYaw) * math.cos(pitch)
                        )
                        cam.CFrame = CFrame.new(camPos, camPos + newLook)
                    end
                    
                    if tick() - startTime >= 0.3 then
                        connection:Disconnect()
                    end
                end)
            end)
        end
    end
end

local function lethalNormalTech(animId)
    if Config.LethalNormalEnabled and animId == TARGET_ANIM_ID then
        task.spawn(function()
            task.delay(Config.meowlethalstart, function()
                local enemy = getClosestEnemy(10)
                if enemy then
                    fireQ()
                    attachTo(enemy, Config.meowlethaldur, true)
                end
            end)
        end)
    end
end

local function lethalDashTech(animId)
    if Config.LethalDashEnabled and animId == TARGET_ANIM_ID then
        task.spawn(function()
            task.delay(Config.normallethalstart, function()
                forceJump()
                autoPressQ()
                task.delay(Config.secondforflip, function()
                    flip()
                end)
            end)
        end)
    end
end

-- ═══ CONECTAR ANIMACIONES ═══
local humanoidAnimator = character:WaitForChild("Humanoid").Animator

humanoidAnimator.AnimationPlayed:Connect(function(anim)
    kingTech(anim)
    oreoTech(anim)
    
    local animId = tonumber(string.match(anim.Animation.AnimationId, "%d+$"))
    
    boomyTech(animId)
    instaLethalTech(animId)
    lethalNormalTech(animId)
    lethalDashTech(animId)
end)

-- ═══ GLOBAL ACCESS ═══
_G.TSBConfig = Config

-- Show first tab
if tabButtons:FindFirstChild("TextButton") then
    tabButtons:FindFirstChild("TextButton"):MouseButton1Click:Emit()
end

notify("TSB Techs", "✓ UI Cargada correctamente")
print("✓ TSB TECHS UI AVANZADA - Iniciado")
