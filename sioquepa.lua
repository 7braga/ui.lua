---@source Deоbfuѕсаtеԁ Ѕucсesѕfullу Вy lua-x
---@see https://lua-x.online

local workspaceService = game:GetService("Workspace")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local statsService = game:GetService("Stats")
local coreGui = game:GetService("CoreGui")
local tweenService = game:GetService("TweenService")
local replicatedStorage = game:GetService("ReplicatedStorage")

if typeof(getgenv) == "function" then
  local genv = getgenv()

  if genv and genv._HYP_BB_R and type(genv._HYP_BB_R.Destroy) == "function" then
    pcall(function() genv._HYP_BB_R:Destroy() end)
    genv._HYP_BB_R = nil
  end
end

local v1 = {
  Workspace = workspaceService,
  RunService = runService,
  Players = players,
  UserInputService = userInputService,
  Stats = statsService,
  CoreGui = coreGui,
  TweenService = tweenService,
  ReplicatedStorage = replicatedStorage,
}

local localPlayer = v1.Players.LocalPlayer
assert(localPlayer, "LocalPlayer required")
local currentCamera = v1.Workspace.CurrentCamera
local v2 = type(Drawing) == "table" and type(Drawing.new) == "function"

local function f1()
  local identifyExecutor = syn and syn.identify_executor or identify_executor
    or identifyexecutor or getexecutorname

  if identifyExecutor then
    local ok, result = pcall(identifyExecutor)

    if ok and result and result ~= "" then
      return tostring(result)
    end
  end

  return "Universal"
end

local v3 = {
  Default = {
    Bg = Color3.fromRGB(13, 14, 17),
    Sidebar = Color3.fromRGB(10, 11, 14),
    Card = Color3.fromRGB(17, 18, 23),
    CardHover = Color3.fromRGB(24, 25, 33),
    Elevated = Color3.fromRGB(22, 23, 29),
    HoverCard = Color3.fromRGB(28, 29, 38),
    Stroke = Color3.fromRGB(32, 34, 43),
    StrokeDim = Color3.fromRGB(24, 25, 33),
    StrokeActive = Color3.fromRGB(42, 45, 58),
    Accent = Color3.fromRGB(255, 255, 255),
    AccentCyan = Color3.fromRGB(240, 242, 250),
    AccentGreen = Color3.fromRGB(34, 197, 94),
    AccentRed = Color3.fromRGB(239, 68, 68),
    Text = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(123, 126, 140),
    Muted = Color3.fromRGB(75, 78, 90),
    Danger = Color3.fromRGB(239, 68, 68),
    Success = Color3.fromRGB(34, 197, 94),
    Warning = Color3.fromRGB(245, 158, 11),
  },
  Neverlose = {
    Bg = Color3.fromRGB(10, 12, 18),
    Sidebar = Color3.fromRGB(8, 10, 15),
    Card = Color3.fromRGB(14, 18, 26),
    CardHover = Color3.fromRGB(20, 26, 38),
    Elevated = Color3.fromRGB(18, 24, 36),
    HoverCard = Color3.fromRGB(24, 32, 46),
    Stroke = Color3.fromRGB(28, 38, 56),
    StrokeDim = Color3.fromRGB(20, 28, 42),
    StrokeActive = Color3.fromRGB(36, 50, 75),
    Accent = Color3.fromRGB(0, 162, 255),
    AccentCyan = Color3.fromRGB(0, 220, 255),
    AccentGreen = Color3.fromRGB(34, 197, 94),
    AccentRed = Color3.fromRGB(239, 68, 68),
    Text = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(130, 145, 170),
    Muted = Color3.fromRGB(80, 95, 120),
    Danger = Color3.fromRGB(239, 68, 68),
    Success = Color3.fromRGB(34, 197, 94),
    Warning = Color3.fromRGB(245, 158, 11),
  },
  Cyberpunk = {
    Bg = Color3.fromRGB(14, 11, 19),
    Sidebar = Color3.fromRGB(11, 8, 15),
    Card = Color3.fromRGB(20, 16, 28),
    CardHover = Color3.fromRGB(28, 22, 38),
    Elevated = Color3.fromRGB(27, 21, 38),
    HoverCard = Color3.fromRGB(36, 28, 50),
    Stroke = Color3.fromRGB(48, 36, 68),
    StrokeDim = Color3.fromRGB(32, 24, 46),
    StrokeActive = Color3.fromRGB(65, 48, 92),
    Accent = Color3.fromRGB(168, 85, 247),
    AccentCyan = Color3.fromRGB(192, 132, 252),
    AccentGreen = Color3.fromRGB(34, 197, 94),
    AccentRed = Color3.fromRGB(239, 68, 68),
    Text = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(150, 135, 165),
    Muted = Color3.fromRGB(95, 80, 110),
    Danger = Color3.fromRGB(239, 68, 68),
    Success = Color3.fromRGB(34, 197, 94),
    Warning = Color3.fromRGB(245, 158, 11),
  },
  Vampire = {
    Bg = Color3.fromRGB(16, 10, 12),
    Sidebar = Color3.fromRGB(12, 7, 9),
    Card = Color3.fromRGB(24, 14, 17),
    CardHover = Color3.fromRGB(34, 19, 24),
    Elevated = Color3.fromRGB(34, 18, 22),
    HoverCard = Color3.fromRGB(45, 24, 30),
    Stroke = Color3.fromRGB(56, 28, 34),
    StrokeDim = Color3.fromRGB(38, 18, 22),
    StrokeActive = Color3.fromRGB(78, 38, 48),
    Accent = Color3.fromRGB(255, 42, 66),
    AccentCyan = Color3.fromRGB(255, 75, 95),
    AccentGreen = Color3.fromRGB(34, 197, 94),
    AccentRed = Color3.fromRGB(255, 42, 66),
    Text = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(165, 135, 140),
    Muted = Color3.fromRGB(110, 80, 85),
    Danger = Color3.fromRGB(255, 42, 66),
    Success = Color3.fromRGB(34, 197, 94),
    Warning = Color3.fromRGB(245, 158, 11),
  },
  Old = {
    Bg = Color3.fromRGB(15, 15, 15),
    Sidebar = Color3.fromRGB(22, 22, 22),
    Card = Color3.fromRGB(28, 28, 28),
    CardHover = Color3.fromRGB(36, 36, 36),
    Elevated = Color3.fromRGB(35, 35, 35),
    HoverCard = Color3.fromRGB(44, 44, 44),
    Stroke = Color3.fromRGB(50, 50, 50),
    StrokeDim = Color3.fromRGB(40, 40, 40),
    StrokeActive = Color3.fromRGB(65, 65, 65),
    Accent = Color3.fromRGB(160, 160, 160),
    AccentCyan = Color3.fromRGB(190, 190, 190),
    AccentGreen = Color3.fromRGB(34, 197, 94),
    AccentRed = Color3.fromRGB(239, 68, 68),
    Text = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(140, 140, 140),
    Muted = Color3.fromRGB(90, 90, 90),
    Danger = Color3.fromRGB(239, 68, 68),
    Success = Color3.fromRGB(34, 197, 94),
    Warning = Color3.fromRGB(245, 158, 11),
  },
}

local v4 = "Default"

local v5 = {
  Bg = v3.Default.Bg,
  Sidebar = v3.Default.Sidebar,
  Card = v3.Default.Card,
  CardHover = v3.Default.CardHover,
  Elevated = v3.Default.Elevated,
  HoverCard = v3.Default.HoverCard,
  Accent = v3.Default.Accent,
  AccentCyan = v3.Default.AccentCyan,
  AccentGreen = v3.Default.AccentGreen,
  AccentRed = v3.Default.AccentRed,
  Stroke = v3.Default.Stroke,
  StrokeDim = v3.Default.StrokeDim,
  StrokeActive = v3.Default.StrokeActive,
  Text = v3.Default.Text,
  TextSub = v3.Default.TextSub,
  Muted = v3.Default.Muted,
  Danger = v3.Default.Danger,
  Success = v3.Default.Success,
  Warning = v3.Default.Warning,
  Font = Enum.Font.Ubuntu,
  FontBold = Enum.Font.Ubuntu,
  Radius = 12,
  CardRadius = 8,
  MainW = 720,
  MainH = 470,
  TitleH = 38,
}

local v6 = {
  ActivePreset = "Competitive",
  TimingOffset = 0,
  AutoParry = true,
  ClashMode = true,
  ClashDistance = 28,
  HeadingCheck = true,
  CurvePrediction = true,
  AutoTarget = true,
  AutoTargetMode = "Closest",
  CustomTargetPlayer = "",
  AutoTargetSilent = true,
  AutoTargetVisual = true,
  UseCooldown = false,
  FrameDebounce = 0.01,
  ClashDebounce = 0.003,
  DirectionResetGuard = true,
  LegacyCooldown = 0.25,
  BaseReactionWindow = 0.14,
  ParryHitboxRadius = 4.5,
  FastBallLeadFactor = 0.0006,
  PingMultiplier = 0.5,
  VisualsEnabled = true,
  VisualRangeRing = true,
  VisualThickness = 2,
  BallHighlight = true,
  BallTracers = false,
  BallDistanceTag = true,
  PlayerESP = false,
  AutoFaceBall = false,
  AutoJumpOnParry = false,
  AntiAFK = false,
  CustomSpeed = false,
  WalkSpeedValue = 16,
  CustomJump = false,
  JumpPowerValue = 50,
  InfiniteJump = false,
  CustomFOV = false,
  FOVValue = 70,
  EmergencyDodge = false,
  ActiveMatchGuard = true,
  StreamerMode = false,
  MenuKeybind = Enum.KeyCode.RightShift,
}

local state = {
  LastParryTime = 0,
  WasMovingAway = false,
  LastTargetAttribute = nil,
  HasParriedCurrentFlight = false,
  LastDeflectionTick = 0,
  ActiveBall = nil,
  LastBallPos = nil,
  LastBallTime = 0,
  LastDistance = math.huge,
  SmoothedVelocity = Vector3.zero,
  History = {},
  Connections = {},
  ScreenGui = nil,
  MainFrame = nil,
  IsMenuOpen = true,
  ActiveTab = "Home",
  TabContainers = {},
  TabButtons = {},
  TabScrolls = {},
  DrawingElements = {},
  SearchFeatures = {},
  SearchContainer = nil,
  SearchScroll = nil,
  SearchBox = nil,
  ClearSearchBtn = nil,
  Stats = {
    BallName = "Awaiting match...",
    Distance = 0,
    Speed = 0,
    ETA = 0,
    TriggerWindow = 0.14,
    TargetingYou = false,
    PingMs = 0,
    Status = "Ready",
    ParryCount = 0,
    InMatch = false,
  },
}

local v7 = "RobloxHUD_" .. string.format("%08X", math.random(10000000, 99999999))

local function f2(screenGui)
end

local function f3()
  local v8 = gethui or getgenv and getgenv().gethui or get_hidden_gui or get_hidden_ui

  if type(v8) == "function" then
    local ok2, result2 = pcall(v8)

    if ok2 and result2 then
      return result2
    end
  end

  local ok3, result3 = pcall(function() return v1.CoreGui.Name end)

  if ok3 then
    return v1.CoreGui
  end

  return nil
end

local function getHumanoidRootPart()
  local character = localPlayer.Character

  if not character then
    return nil
  end

  local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
    return humanoidRootPart
  end

  return nil
end

local function getHumanoid()
  local character2 = localPlayer.Character

  if not character2 then
    return nil
  end

  return character2:FindFirstChildOfClass("Humanoid")
end

local function f4()
  if not v6.ActiveMatchGuard then
    return true
  end

  local character3 = localPlayer.Character

  if not character3 then
    return false
  end

  local alive = v1.Workspace:FindFirstChild("Alive")

  if alive and character3.Parent == alive then
    return true
  end

  if character3.Parent == v1.Workspace and not character3:FindFirstChild("ForceField") then
    return true
  end

  return false
end

local function f5()
  local ok4, result4 = pcall(function()
    local serverStatsItem = v1.Stats:FindFirstChild("ServerStatsItem")

    if serverStatsItem then
      local dataPing = serverStatsItem:FindFirstChild("Data Ping")

      if dataPing and dataPing:IsA("DoubleConstValue") then
        return dataPing:GetValue() / 1000
      end
    end

    return localPlayer:GetNetworkPing()
  end)

  if ok4 and type(result4) == "number" and result4 > 0 then
    state.Stats.PingMs = math.floor(result4 * 1000)
    return result4
  end

  state.Stats.PingMs = 45
  return 0.045
end

local function f6()
  pcall(function()
    local humanoid = getHumanoid()
    local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")

    if not animator then
      return
    end

    for _, value in ipairs(animator:GetPlayingAnimationTracks()) do
      local lower = value.Name:lower()

      if lower:find("parry") or lower:find("slash") or lower:find("swing") then
        value:Play()
        return
      end
    end
  end)
end

local function f7()
  local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

  if not playerGui then
    return nil
  end

  local hotbar = playerGui:FindFirstChild("Hotbar")

  if hotbar then
    local block = hotbar:FindFirstChild("Block") or hotbar:FindFirstChild("Parry")

    if block then
      return block
    end
  end

  local mobileButtons = playerGui:FindFirstChild("MobileButtons")
    or playerGui:FindFirstChild("MobileHUD")

  if mobileButtons then
    local block2 = mobileButtons:FindFirstChild("Block")
      or mobileButtons:FindFirstChild("Parry")

    if block2 then
      return block2
    end
  end

  for _, value2 in ipairs(playerGui:GetChildren()) do
    if value2:IsA("ScreenGui") then
      local findFirstChild = value2:FindFirstChild("Block", true)
        or value2:FindFirstChild("Parry", true)

      if findFirstChild
        and (findFirstChild:IsA("TextButton") or findFirstChild:IsA("ImageButton")) then
        return findFirstChild
      end
    end
  end

  return nil
end

local function f8()
  local humanoidRootPart2 = getHumanoidRootPart()

  if not humanoidRootPart2 then
    return nil, nil, false
  end

  local position = humanoidRootPart2.Position
  local list = {}
  local alive2 = v1.Workspace:FindFirstChild("Alive")

  if alive2 then
    for _, value3 in ipairs(alive2:GetChildren()) do
      if value3:IsA("Model") and value3 ~= localPlayer.Character then
        local humanoidRootPart3 = value3:FindFirstChild("HumanoidRootPart")
        local humanoid2 = value3:FindFirstChildOfClass("Humanoid")

        if humanoidRootPart3 and humanoid2 and humanoid2.Health > 0
          and not value3:FindFirstChild("ForceField") then
          table.insert(list, { char = value3, root = humanoidRootPart3, hum = humanoid2 })
        end
      end
    end
  end

  if #list == 0 then
    for _, value4 in ipairs(v1.Players:GetPlayers()) do
      if value4 ~= localPlayer and value4.Character
        and value4.Character ~= localPlayer.Character then
        local character4 = value4.Character
        local humanoidRootPart4 = character4:FindFirstChild("HumanoidRootPart")
        local humanoid3 = character4:FindFirstChildOfClass("Humanoid")

        if humanoidRootPart4 and humanoid3 and humanoid3.Health > 0
          and not character4:FindFirstChild("ForceField") then
          table.insert(list, { char = character4, root = humanoidRootPart4, hum = humanoid3 })
        end
      end
    end
  end

  if #list == 0 then
    return nil, nil, false
  end

  if v6.AutoTargetMode == "Specific"
    or v6.CustomTargetPlayer and v6.CustomTargetPlayer ~= "" and v6.CustomTargetPlayer ~= "None" then
    local gsub = tostring(v6.CustomTargetPlayer):lower():gsub("^%s*(.-)%s*$", "%1")

    if gsub ~= "" then
      for _, value5 in ipairs(list) do
        local lower2 = value5.char.Name:lower()
        local getPlayerFromCharacter = v1.Players:GetPlayerFromCharacter(value5.char)

        local lower3 = getPlayerFromCharacter and getPlayerFromCharacter.DisplayName:lower()
          or value5.char:GetAttribute("DisplayName")
            and tostring(value5.char:GetAttribute("DisplayName")):lower()
          or lower2

        if lower2 == gsub or lower3 == gsub then
          return value5.root, value5.char, true
        end
      end

      for _, value6 in ipairs(list) do
        local lower4 = value6.char.Name:lower()
        local getPlayerFromCharacter2 = v1.Players:GetPlayerFromCharacter(value6.char)

        local lower5 = getPlayerFromCharacter2 and getPlayerFromCharacter2.DisplayName:lower()
          or value6.char:GetAttribute("DisplayName")
            and tostring(value6.char:GetAttribute("DisplayName")):lower()
          or lower4

        if lower4:find(gsub, 1, true) or lower5:find(gsub, 1, true) then
          return value6.root, value6.char, true
        end
      end

      for _, value7 in ipairs(v1.Players:GetPlayers()) do
        if value7 ~= localPlayer then
          if value7.Name:lower():find(gsub, 1, true)
            or value7.DisplayName:lower():find(gsub, 1, true) then
            if value7.Character and value7.Character:FindFirstChild("HumanoidRootPart") then
              local humanoid4 = value7.Character:FindFirstChildOfClass("Humanoid")

              if humanoid4 and humanoid4.Health > 0
                and not value7.Character:FindFirstChild("ForceField") then
                return value7.Character.HumanoidRootPart, value7.Character, true
              end
            end
          end
        end
      end
    end
  end

  local root = nil
  local char = nil

  if v6.AutoTargetMode == "Cursor" and currentCamera then
    local getMouseLocation = v1.UserInputService:GetMouseLocation()
    local huge = math.huge

    for _, value8 in ipairs(list) do
      local screenPoint, onScreen = currentCamera:WorldToViewportPoint(value8.root.Position)

      if onScreen then
        local magnitude = (Vector2.new(screenPoint.X, screenPoint.Y) - getMouseLocation).Magnitude

        if magnitude < huge then
          huge = magnitude
          root = value8.root
          char = value8.char
        end
      end
    end
  elseif v6.AutoTargetMode == "Random" then
    local roll = math.random(1, #list)
    root = list[roll].root
    char = list[roll].char
  else
    local huge2 = math.huge

    for _, value9 in ipairs(list) do
      local magnitude2 = (value9.root.Position - position).Magnitude

      if magnitude2 < huge2 then
        huge2 = magnitude2
        root = value9.root
        char = value9.char
      end
    end
  end

  return root, char, false
end

local function f9()
  if not v6.AutoTarget then
    return
  end

  local v9, v10 = f8()

  if not v9 or not currentCamera then
    return
  end

  local humanoidRootPart5 = getHumanoidRootPart()
  local v11 = v9.Position + Vector3.new(0, 1.5, 0)
  local cframe = currentCamera.CFrame

  if humanoidRootPart5 then
    humanoidRootPart5.CFrame = CFrame.lookAt(humanoidRootPart5.Position, Vector3.new(
      v11.X, humanoidRootPart5.Position.Y, v11.Z
    ))
  end

  currentCamera.CFrame = CFrame.lookAt(currentCamera.CFrame.Position, v11)

  if v6.AutoTargetSilent then
    task.defer(function()
      if currentCamera and cframe then
        currentCamera.CFrame = cframe
      end
    end)
  end
end

local function f10(clashMode)
  local now = os.clock()

  if now - state.LastParryTime < 0.04 then
    return
  end

  state.LastParryTime = now
  state.HasParriedCurrentFlight = true
  state.LastDeflectionTick = now
  state.Stats.ParryCount = state.Stats.ParryCount + 1
  state.Stats.Status = clashMode and "CLASH DEFLECTION" or "PRECISION DEFLECTION"

  f9()
  local flag = false
  local v12 = getgenv and getgenv().keypress or keypress or key_press
  local v13 = getgenv and getgenv().keyrelease or keyrelease or key_release
  local v14 = getgenv and getgenv().mouse1click or mouse1click
  local v15 = getgenv and getgenv().mouse1press or mouse1press or mouse_press
  local v16 = getgenv and getgenv().mouse1release or mouse1release or mouse_release

  if type(v12) == "function" and type(v13) == "function" then
    pcall(v13, 70)
    pcall(v12, 70)

    task.defer(function() pcall(v13, 70) end)
    flag = true
  end

  if type(v14) == "function" then
    pcall(v14)
    flag = true
  elseif type(v15) == "function" and type(v16) == "function" then
    pcall(v16)
    pcall(v15)

    task.defer(function() pcall(v16) end)
    flag = true
  end

  if not flag then
    local v17 = f7()

    if v17 then
      local v18 = getgenv and getgenv().firesignal or firesignal

      if type(v18) == "function" then
        pcall(v18, v17.InputBegan, {
          UserInputType = Enum.UserInputType.MouseButton1,
          UserInputState = Enum.UserInputState.Begin,
          Position = Vector3.new(0, 0, 0),
        })

        pcall(v18, v17.Activated)
        flag = true
      elseif type(getconnections) == "function" then
        pcall(function()
          for _, value10 in ipairs(getconnections(v17.Activated)) do
            if type(value10.Fire) == "function" then
              value10:Fire()
              flag = true
            end
          end
        end)
      end
    end
  end

  f6()

  if v6.AutoJumpOnParry then
    local humanoid5 = getHumanoid()

    if humanoid5 then
      humanoid5:ChangeState(Enum.HumanoidStateType.Jumping)
    end
  end
end

local function f11()
  local humanoidRootPart6 = getHumanoidRootPart()
  local position2 = humanoidRootPart6 and humanoidRootPart6.Position or Vector3.zero
  local balls = v1.Workspace:FindFirstChild("Balls")

  if not balls then
    return nil
  end

  local v19 = nil
  local huge3 = math.huge

  for _, value11 in ipairs(balls:GetChildren()) do
    local primaryPart = nil

    if value11:IsA("BasePart") then
      primaryPart = value11
    elseif value11:IsA("Model") then
      primaryPart = value11.PrimaryPart or value11:FindFirstChildWhichIsA("BasePart")
    end

    if primaryPart then
      local magnitude3 = (primaryPart.Position - position2).Magnitude

      if magnitude3 < huge3 then
        huge3 = magnitude3
        v19 = primaryPart
      end
    end
  end

  return v19
end

local function getSmoothedVelocity(activeBall, now2)
  local position3 = activeBall.Position
  local zero = Vector3.zero
  local zero2 = Vector3.zero

  if state.LastBallPos and state.LastBallTime > 0 then
    local v20 = now2 - state.LastBallTime

    if v20 > 0.0001 and v20 < 0.3 then
      zero = (position3 - state.LastBallPos) / v20
    end
  end

  if zero.Magnitude < 1 and activeBall.AssemblyLinearVelocity.Magnitude > 1 then
    zero = activeBall.AssemblyLinearVelocity
  end

  if state.SmoothedVelocity.Magnitude > 2 and zero.Magnitude > 2 then
    local dot = state.SmoothedVelocity.Unit:Dot(zero.Unit)

    if dot < 0.2 then
      state.SmoothedVelocity = zero
      table.clear(state.History)
    else
      state.SmoothedVelocity = state.SmoothedVelocity:Lerp(zero, 0.75)
    end
  else
    state.SmoothedVelocity = zero
  end

  local magnitude4 = state.SmoothedVelocity.Magnitude

  state.LastBallPos = position3
  state.LastBallTime = now2

  table.insert(state.History, { pos = position3, time = now2 })

  while #state.History > 8 do
    table.remove(state.History, 1)
  end

  local v21 = #state.History

  if v21 >= 3 then
    local v22 = state.History[v21].time - state.History[v21 - 1].time
    local v23 = state.History[v21 - 1].time - state.History[v21 - 2].time

    if v22 > 0.0001 and v23 > 0.0001 then
      local v24 = (state.History[v21].pos - state.History[v21 - 1].pos) / v22
      local v25 = (state.History[v21 - 1].pos - state.History[v21 - 2].pos) / v23
      zero2 = (v24 - v25) / ((v22 + v23) * 0.5)
    end
  end

  return state.SmoothedVelocity, magnitude4, zero2
end

local function f12(position4, position5, p1, p2, assemblyLinearVelocity)
  local list2 = {}
  local magnitude5 = (position5 - position4).Magnitude
  local v26 = 0
  local v27 = position5
  local v28 = p1
  local v29 = 0.025
  local v30 = 28
  table.insert(list2, v27)

  for i = 1, v30 do
    local v31 = i * v29
    local v32 = math.exp(-v31 * 0.4)
    v28 = v28 + p2 * v32 * v29
    v27 = v27 + v28 * v29
    table.insert(list2, v27)
    local v33 = position4 + assemblyLinearVelocity * v31
    local magnitude6 = (v27 - v33).Magnitude

    if magnitude6 < magnitude5 then
      magnitude5 = magnitude6
      v26 = v31
    end
  end

  return v26, magnitude5, list2
end

local function f13()
  for _, value12 in pairs(state.DrawingElements) do
    pcall(function() value12:Remove() end)
  end

  table.clear(state.DrawingElements)
end

local function f14(p3, position6, clamped, p4, p5, activeBall2)
  if not v6.VisualsEnabled or not v2 or not currentCamera then
    f13()
    return
  end

  local danger = p5 and v5.Danger or p4 and v5.Warning or v5.AccentCyan
  local highest = math.max(0, #p3 - 1)

  for j = 1, highest do
    local v34 = "Line_" .. tostring(j)
    local line = state.DrawingElements[v34]

    if not line then
      line = Drawing.new("Line")
      line.Thickness = v6.VisualThickness
      state.DrawingElements[v34] = line
    end

    local screenPoint2, onScreen2 = currentCamera:WorldToViewportPoint(p3[j])
    local screenPoint3, onScreen3 = currentCamera:WorldToViewportPoint(p3[j + 1])

    if onScreen2 and onScreen3 then
      line.Visible = true
      line.Thickness = v6.VisualThickness
      line.From = Vector2.new(screenPoint2.X, screenPoint2.Y)
      line.To = Vector2.new(screenPoint3.X, screenPoint3.Y)
      line.Color = danger
      line.Transparency = math.clamp(1 - j / highest * 0.6, 0.4, 1)
    else
      line.Visible = false
    end
  end

  for k = highest + 1, 30 do
    local v35 = "Line_" .. tostring(k)
    local v36 = state.DrawingElements[v35]

    if v36 then
      v36.Visible = false
    end
  end

  if v6.VisualRangeRing then
    local rangeRing = state.DrawingElements.RangeRing

    if not rangeRing then
      rangeRing = Drawing.new("Circle")
      rangeRing.Thickness = 1.5
      rangeRing.NumSides = 36
      rangeRing.Filled = false

      state.DrawingElements.RangeRing = rangeRing
    end

    local screenPoint4, onScreen4 = currentCamera:WorldToViewportPoint(position6)

    if onScreen4 then
      local v37 = position6 + currentCamera.CFrame.RightVector * clamped
      local screenPoint5, onScreen5 = currentCamera:WorldToViewportPoint(v37)

      local magnitude7 = onScreen5
          and (Vector2.new(screenPoint5.X, screenPoint5.Y)
            - Vector2.new(screenPoint4.X, screenPoint4.Y)).Magnitude
        or 80

      rangeRing.Visible = true
      rangeRing.Position = Vector2.new(screenPoint4.X, screenPoint4.Y)
      rangeRing.Radius = magnitude7
      rangeRing.Color = danger
      rangeRing.Transparency = p5 and 0.85 or 0.45
    else
      rangeRing.Visible = false
    end
  else
    local rangeRing2 = state.DrawingElements.RangeRing

    if rangeRing2 then
      rangeRing2.Visible = false
    end
  end

  if activeBall2 and activeBall2:IsDescendantOf(v1.Workspace) then
    local position7 = activeBall2.Position
    local screenPoint6, onScreen6 = currentCamera:WorldToViewportPoint(position7)

    if v6.BallHighlight and onScreen6 then
      local ballCircle = state.DrawingElements.BallCircle

      if not ballCircle then
        ballCircle = Drawing.new("Circle")
        ballCircle.Thickness = 2
        ballCircle.NumSides = 24
        ballCircle.Filled = false

        state.DrawingElements.BallCircle = ballCircle
      end

      ballCircle.Visible = true
      ballCircle.Position = Vector2.new(screenPoint6.X, screenPoint6.Y)
      ballCircle.Radius = 14
      ballCircle.Color = danger
    else
      local ballCircle2 = state.DrawingElements.BallCircle

      if ballCircle2 then
        ballCircle2.Visible = false
      end
    end

    if v6.BallTracers and onScreen6 then
      local ballTracer = state.DrawingElements.BallTracer

      if not ballTracer then
        ballTracer = Drawing.new("Line")
        ballTracer.Thickness = 1.5
        state.DrawingElements.BallTracer = ballTracer
      end

      ballTracer.Visible = true

      ballTracer.From = Vector2.new(
        currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
      )

      ballTracer.To = Vector2.new(screenPoint6.X, screenPoint6.Y)
      ballTracer.Color = danger
    else
      local ballTracer2 = state.DrawingElements.BallTracer

      if ballTracer2 then
        ballTracer2.Visible = false
      end
    end

    if v6.BallDistanceTag and onScreen6 then
      local ballText = state.DrawingElements.BallText

      if not ballText then
        ballText = Drawing.new("Text")
        ballText.Size = 13
        ballText.Center = true
        ballText.Outline = true

        state.DrawingElements.BallText = ballText
      end

      ballText.Visible = true
      ballText.Position = Vector2.new(screenPoint6.X, screenPoint6.Y - 26)

      ballText.Text = string.format(
        "[%d studs | %d spd]", state.Stats.Distance, state.Stats.Speed
      )

      ballText.Color = danger
    else
      local ballText2 = state.DrawingElements.BallText

      if ballText2 then
        ballText2.Visible = false
      end
    end
  else
    local ballCircle3 = state.DrawingElements.BallCircle

    if ballCircle3 then
      ballCircle3.Visible = false
    end

    local ballTracer3 = state.DrawingElements.BallTracer

    if ballTracer3 then
      ballTracer3.Visible = false
    end

    local ballText3 = state.DrawingElements.BallText

    if ballText3 then
      ballText3.Visible = false
    end
  end

  if v6.AutoTarget and v6.AutoTargetVisual and currentCamera then
    local v38, v39, v40 = f8()

    if v38 then
      local screenPoint7, onScreen7 = currentCamera:WorldToViewportPoint(v38.Position
        + Vector3.new(0, 1.5, 0))

      if onScreen7 then
        local targetLockCircle = state.DrawingElements.TargetLockCircle

        if not targetLockCircle then
          targetLockCircle = Drawing.new("Circle")
          targetLockCircle.Thickness = 2
          targetLockCircle.NumSides = 24
          targetLockCircle.Filled = false

          state.DrawingElements.TargetLockCircle = targetLockCircle
        end

        targetLockCircle.Visible = true
        targetLockCircle.Position = Vector2.new(screenPoint7.X, screenPoint7.Y)
        targetLockCircle.Radius = v40 and 18 or 14
        targetLockCircle.Color = v40 and Color3.fromRGB(255, 45, 85) or v5.Danger
        targetLockCircle.Transparency = 0.9

        local targetLockTag = state.DrawingElements.TargetLockTag

        if not targetLockTag then
          targetLockTag = Drawing.new("Text")
          targetLockTag.Size = 12
          targetLockTag.Center = true
          targetLockTag.Outline = true

          state.DrawingElements.TargetLockTag = targetLockTag
        end

        targetLockTag.Visible = true
        targetLockTag.Position = Vector2.new(screenPoint7.X, screenPoint7.Y + 16)

        local v41 = v40 and "[CUSTOM LOCKED: " or "[AUTO TARGET: "

        targetLockTag.Text = v41 .. (v39 and v39.Name or "OPPONENT") .. "]"
        targetLockTag.Color = v40 and Color3.fromRGB(255, 45, 85) or v5.Danger
      else
        if state.DrawingElements.TargetLockCircle then
          state.DrawingElements.TargetLockCircle.Visible = false
        end

        if state.DrawingElements.TargetLockTag then
          state.DrawingElements.TargetLockTag.Visible = false
        end
      end
    else
      if state.DrawingElements.TargetLockCircle then
        state.DrawingElements.TargetLockCircle.Visible = false
      end

      if state.DrawingElements.TargetLockTag then
        state.DrawingElements.TargetLockTag.Visible = false
      end
    end
  else
    if state.DrawingElements.TargetLockCircle then
      state.DrawingElements.TargetLockCircle.Visible = false
    end

    if state.DrawingElements.TargetLockTag then
      state.DrawingElements.TargetLockTag.Visible = false
    end
  end
end

local function f15(activeBall3, position8, position9, p6, p7)
  if not v6.HeadingCheck then
    return true
  end

  local target = activeBall3:GetAttribute("target") or activeBall3:GetAttribute("Target")

  if target then
    if target == localPlayer.Name or target == tostring(localPlayer.UserId) then
      return true
    end

    return false
  end

  if p6.Magnitude > 5 then
    local unit = (position8 - position9).Unit
    local dot2 = p6.Unit:Dot(unit)

    if dot2 > 0.6 then
      return true
    end
  end

  if v6.CurvePrediction and p7 <= 14 then
    return true
  end

  return false
end

local function f16()
  if not v6.AutoParry then
    state.Stats.Status = "Disabled"
    f13()
    return
  end

  local humanoidRootPart7 = getHumanoidRootPart()

  if not humanoidRootPart7 then
    state.ActiveBall = nil
    state.Stats.Status = "Searching Character..."

    f13()
    return
  end

  local inMatch = f4()
  state.Stats.InMatch = inMatch

  if not inMatch then
    state.ActiveBall = nil
    state.Stats.Status = "Lobby Mode (Dormant)"
    state.Stats.BallName = "Lobby"

    f13()
    return
  end

  local activeBall4 = state.ActiveBall

  if not activeBall4 or not activeBall4:IsDescendantOf(v1.Workspace) then
    activeBall4 = f11()

    state.ActiveBall = activeBall4
    state.LastBallPos = nil
    state.LastBallTime = 0
    state.LastDistance = math.huge
    state.WasMovingAway = false
    state.SmoothedVelocity = Vector3.zero

    table.clear(state.History)

    if not activeBall4 then
      state.Stats.BallName = "Awaiting Ball in workspace.Balls"
      state.Stats.Distance = 0
      state.Stats.Speed = 0
      state.Stats.ETA = 0
      state.Stats.TargetingYou = false
      state.Stats.Status = "Waiting for Round"

      f13()
      return
    end
  end

  state.Stats.BallName = activeBall4.Name .. " (" .. activeBall4.ClassName .. ")"
  local now3 = os.clock()
  local position10 = humanoidRootPart7.Position
  local assemblyLinearVelocity2 = humanoidRootPart7.AssemblyLinearVelocity
  local position11 = activeBall4.Position
  local magnitude8 = (position11 - position10).Magnitude
  local target2 = activeBall4:GetAttribute("target") or activeBall4:GetAttribute("Target")
  local v42 = target2 == localPlayer.Name or target2 == tostring(localPlayer.UserId)

  if target2 ~= state.LastTargetAttribute then
    state.LastTargetAttribute = target2

    if v42 then
      state.HasParriedCurrentFlight = false
      state.WasMovingAway = false

      if v6.DirectionResetGuard then
        state.LastParryTime = 0
      end

      if magnitude8 <= 9 then
        f10(true)
        return
      end
    else
      state.HasParriedCurrentFlight = false
    end
  end

  local smoothedVelocity, magnitude9, zero3 = getSmoothedVelocity(activeBall4, now3)

  local v43, magnitude10, v44 = f12(
    position10, position11, smoothedVelocity, zero3, assemblyLinearVelocity2
  )

  if magnitude9 < 4 then
    state.Stats.Distance = math.floor(magnitude8)
    state.Stats.Speed = math.floor(magnitude9)
    state.Stats.ETA = 0
    state.Stats.TargetingYou = false
    state.Stats.Status = "Ball Static"

    f14(v44, position10, 20, false, false, activeBall4)
    return
  end

  local flag2 = false

  if state.LastDistance < math.huge then
    local v45 = magnitude8 - state.LastDistance

    if v45 > 0.08 then
      state.WasMovingAway = true
      state.HasParriedCurrentFlight = false
    elseif v45 < -0.04 then
      flag2 = true

      if state.WasMovingAway then
        state.HasParriedCurrentFlight = false

        if v6.DirectionResetGuard then
          state.LastParryTime = 0
        end

        state.WasMovingAway = false
      end
    end
  end

  state.LastDistance = magnitude8
  local unit2 = (position10 - position11).Unit
  local dot3 = smoothedVelocity:Dot(unit2)
  local dot4 = assemblyLinearVelocity2:Dot(unit2)
  local highest2 = math.max(0.1, dot3 - dot4)
  local highest3 = math.max(0, magnitude8 - v6.ParryHitboxRadius)
  local v46 = highest3 / highest2
  local v47 = f15(activeBall4, position10, position11, smoothedVelocity, magnitude10)
  local v48 = f5()
  local clamped2 = math.clamp(v48 * v6.PingMultiplier, 0.015, 0.12)
  local lowest = 0

  if highest2 > 60 then
    lowest = math.min(0.09, (highest2 - 60) * v6.FastBallLeadFactor)
  end

  local highest4 = math.max(0.06, v6.BaseReactionWindow + v6.TimingOffset + clamped2 + lowest)

  state.Stats.Distance = math.floor(magnitude8)
  state.Stats.Speed = math.floor(magnitude9)
  state.Stats.ETA = tonumber(string.format("%.3f", v46)) or 0
  state.Stats.TriggerWindow = tonumber(string.format("%.3f", highest4)) or 0.14
  state.Stats.TargetingYou = v47

  if v6.AutoFaceBall and flag2 and v47 then
    local vector = Vector3.new(position11.X, position10.Y, position11.Z)
    humanoidRootPart7.CFrame = CFrame.lookAt(position10, vector)
  end

  local clamped3 = math.clamp(highest2 * highest4 + v6.ParryHitboxRadius, 8, 75)

  local clashMode2 = v6.ClashMode
    and (magnitude8 <= v6.ClashDistance or magnitude8 <= 32 and highest2 >= 35)

  local v49 = not state.HasParriedCurrentFlight or now3 - state.LastDeflectionTick > 0.35

  if not v47 or not flag2 and magnitude8 > 10 or not v49 then
    state.Stats.Status = not v47 and "Ball Heading to Other Player"
      or not v49 and "Shield Active (Awaiting Contact)" or "Ball Moving Away"

    f14(v44, position10, clamped3, false, false, activeBall4)
    return
  end

  local flag3 = false
  local v50 = v46

  if v6.CurvePrediction and v43 > 0 and magnitude10 <= v6.ParryHitboxRadius + 2.5 and v43 < v46 then
    v50 = v43
  end

  if magnitude8 <= 9 and flag2 then
    flag3 = true
  elseif v50 <= highest4 then
    flag3 = true
  elseif magnitude8 <= v6.ParryHitboxRadius + 1.2 and flag2 then
    flag3 = true
  end

  f14(v44, position10, clamped3, v47, flag3, activeBall4)

  if flag3 then
    f10(clashMode2)
  else
    state.Stats.Status = string.format(
      "Approaching (Dist: %d, Spd: %d, ETA: %.2fs, Lead: %.3fs)", math.floor(magnitude8),
      math.floor(magnitude9), v50, highest4
    )
  end
end

local function f17(name, tab, section, frame)
  table.insert(state.SearchFeatures, {
    name = name,
    tab = tab,
    section = section,
    container = frame,
  })
end

local function makeTextLabel(parent, text, p8)
  local textSub = p8 or v5.TextSub

  local frame2 = Instance.new("Frame")
  frame2.Size = UDim2.new(1, 0, 0, 22)
  frame2.BackgroundTransparency = 1
  frame2.BorderSizePixel = 0
  frame2.Parent = parent

  local textLabel = Instance.new("TextLabel")
  textLabel.Size = UDim2.new(1, -8, 1, 0)
  textLabel.Position = UDim2.new(0, 4, 0, 0)
  textLabel.BackgroundTransparency = 1
  textLabel.Text = text:upper()
  textLabel.TextColor3 = textSub
  textLabel.Font = v5.Font
  textLabel.TextSize = 10.5
  textLabel.TextXAlignment = Enum.TextXAlignment.Left
  textLabel.Parent = frame2

  return frame2
end

local function makeTextButton(parent2, text2, p9, p10, p11, p12)
  local frame3 = Instance.new("Frame")
  frame3.Size = UDim2.new(1, 0, 0, 32)
  frame3.BackgroundColor3 = v5.Card
  frame3.BackgroundTransparency = 0.5
  frame3.BorderSizePixel = 0
  frame3.Parent = parent2

  Instance.new("UICorner", frame3).CornerRadius = UDim.new(0, v5.CardRadius)

  local instance = Instance.new("UIStroke", frame3)
  instance.Color = v5.StrokeDim
  instance.Thickness = 0.9

  local textButton = Instance.new("TextButton")
  textButton.Size = UDim2.new(0, 16, 0, 16)
  textButton.Position = UDim2.new(0, 10, 0.5, -8)
  textButton.BackgroundColor3 = p9 and v5.Text or v5.Elevated
  textButton.BackgroundTransparency = p9 and 0 or 0.6
  textButton.Text = ""
  textButton.AutoButtonColor = false
  textButton.Parent = frame3

  Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 4)

  local instance2 = Instance.new("UIStroke", textButton)
  instance2.Color = p9 and v5.Text or v5.Stroke
  instance2.Thickness = 0.8

  local imageLabel = Instance.new("ImageLabel")
  imageLabel.Size = UDim2.new(0, 12, 0, 12)
  imageLabel.Position = UDim2.new(0.5, -6, 0.5, -6)
  imageLabel.BackgroundTransparency = 1
  imageLabel.Image = "rbxassetid://7733715400"
  imageLabel.ImageColor3 = Color3.fromRGB(15, 16, 21)
  imageLabel.ScaleType = Enum.ScaleType.Fit
  imageLabel.Visible = p9
  imageLabel.Parent = textButton

  local textLabel2 = Instance.new("TextLabel")
  textLabel2.Size = UDim2.new(1, -50, 1, 0)
  textLabel2.Position = UDim2.new(0, 34, 0, 0)
  textLabel2.BackgroundTransparency = 1
  textLabel2.Text = text2
  textLabel2.TextColor3 = v5.Text
  textLabel2.Font = v5.Font
  textLabel2.TextSize = 12
  textLabel2.TextXAlignment = Enum.TextXAlignment.Left
  textLabel2.Parent = frame3

  local v51 = p9

  local function f18()
    v51 = not v51

    v1.TweenService:Create(textButton, TweenInfo.new(0.15), {
      BackgroundColor3 = v51 and v5.Text or v5.Elevated,
      BackgroundTransparency = v51 and 0 or 0.6,
    }):Play()

    imageLabel.Visible = v51

    v1.TweenService:Create(instance2, TweenInfo.new(0.15), {
      Color = v51 and v5.Text or v5.Stroke,
    }):Play()

    pcall(p10, v51)
  end

  textButton.MouseButton1Click:Connect(f18)

  local textButton2 = Instance.new("TextButton")
  textButton2.Size = UDim2.new(1, 0, 1, 0)
  textButton2.BackgroundTransparency = 1
  textButton2.Text = ""
  textButton2.Parent = frame3
  textButton2.MouseButton1Click:Connect(f18)

  frame3.MouseEnter:Connect(function()
    v1.TweenService:Create(instance, TweenInfo.new(0.15), {
      Color = v5.Stroke,
      Thickness = 1,
    }):Play()

    v1.TweenService:Create(frame3, TweenInfo.new(0.15), { BackgroundTransparency = 0.3 }):Play()
  end)

  frame3.MouseLeave:Connect(function()
    v1.TweenService:Create(instance, TweenInfo.new(0.15), {
      Color = v5.StrokeDim,
      Thickness = 0.9,
    }):Play()

    v1.TweenService:Create(frame3, TweenInfo.new(0.15), { BackgroundTransparency = 0.5 }):Play()
  end)

  if p11 and p12 then
    f17(text2, p11, p12, frame3)
  end

  return frame3
end

local function makeTextButton2(parent3, text3, p13, p14, text4, p15, p16, p17, p18, p19)
  local v52 = p16 or 1
  local v53 = p17 or ""

  local frame4 = Instance.new("Frame")
  frame4.Size = UDim2.new(1, 0, 0, 38)
  frame4.BackgroundColor3 = v5.Card
  frame4.BackgroundTransparency = 0.5
  frame4.BorderSizePixel = 0
  frame4.Parent = parent3

  Instance.new("UICorner", frame4).CornerRadius = UDim.new(0, v5.CardRadius)

  local instance3 = Instance.new("UIStroke", frame4)
  instance3.Color = v5.StrokeDim
  instance3.Thickness = 0.9

  local textLabel3 = Instance.new("TextLabel")
  textLabel3.Size = UDim2.new(0.6, 0, 0, 18)
  textLabel3.Position = UDim2.new(0, 10, 0, 4)
  textLabel3.BackgroundTransparency = 1
  textLabel3.Text = text3
  textLabel3.TextColor3 = v5.Text
  textLabel3.Font = v5.Font
  textLabel3.TextSize = 12
  textLabel3.TextXAlignment = Enum.TextXAlignment.Left
  textLabel3.Parent = frame4

  local function f19(clamped4)
    if v52 < 0.001 then
      return string.format("%.4f%s", clamped4, v53)
    elseif v52 < 0.01 then
      return string.format("%.3f%s", clamped4, v53)
    elseif v52 < 0.1 then
      return string.format("%.2f%s", clamped4, v53)
    end

    return tostring(math.round(clamped4 * 100) / 100) .. v53
  end

  local textLabel4 = Instance.new("TextLabel")
  textLabel4.Size = UDim2.new(0, 120, 0, 18)
  textLabel4.Position = UDim2.new(1, -130, 0, 4)
  textLabel4.BackgroundTransparency = 1
  textLabel4.Text = f19(text4)
  textLabel4.TextColor3 = v5.TextSub
  textLabel4.Font = v5.Font
  textLabel4.TextSize = 11
  textLabel4.TextXAlignment = Enum.TextXAlignment.Right
  textLabel4.Parent = frame4

  local textButton3 = Instance.new("TextButton")
  textButton3.Size = UDim2.new(1, -20, 0, 3)
  textButton3.Position = UDim2.new(0, 10, 0, 26)
  textButton3.BackgroundColor3 = Color3.fromRGB(32, 34, 43)
  textButton3.BorderSizePixel = 0
  textButton3.Text = ""
  textButton3.AutoButtonColor = false
  textButton3.Parent = frame4

  Instance.new("UICorner", textButton3).CornerRadius = UDim.new(1, 0)
  local frame5 = Instance.new("Frame")
  local clamped5 = math.clamp((text4 - p13) / (p14 - p13), 0, 1)

  frame5.Size = UDim2.new(clamped5, 0, 1, 0)
  frame5.BackgroundColor3 = v5.Text
  frame5.BorderSizePixel = 0
  frame5.Parent = textButton3

  Instance.new("UICorner", frame5).CornerRadius = UDim.new(1, 0)

  local frame6 = Instance.new("Frame")
  frame6.Size = UDim2.new(0, 9, 0, 9)
  frame6.Position = UDim2.new(clamped5, -4, 0.5, -4)
  frame6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  frame6.BorderSizePixel = 0
  frame6.Parent = textButton3

  Instance.new("UICorner", frame6).CornerRadius = UDim.new(1, 0)
  local flag4 = false

  local function f20(position12)
    local clamped6 = math.clamp((position12.X - textButton3.AbsolutePosition.X)
      / textButton3.AbsoluteSize.X, 0, 1)

    local v54 = p13 + (p14 - p13) * clamped6

    local clamped7 = math.round(v54 / v52) * v52
    clamped7 = math.clamp(clamped7, p13, p14)

    local v55 = (clamped7 - p13) / (p14 - p13)
    frame5.Size = UDim2.new(v55, 0, 1, 0)
    frame6.Position = UDim2.new(v55, -4, 0.5, -4)
    textLabel4.Text = f19(clamped7)
    pcall(p15, clamped7)
  end

  textButton3.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
      or input.UserInputType == Enum.UserInputType.Touch then
      flag4 = true
      f20(input.Position)
    end
  end)

  v1.UserInputService.InputChanged:Connect(function(input2)
    if flag4
      and (input2.UserInputType == Enum.UserInputType.MouseMovement
        or input2.UserInputType == Enum.UserInputType.Touch) then
      f20(input2.Position)
    end
  end)

  v1.UserInputService.InputEnded:Connect(function(input3)
    if input3.UserInputType == Enum.UserInputType.MouseButton1
      or input3.UserInputType == Enum.UserInputType.Touch then
      flag4 = false
    end
  end)

  frame4.MouseEnter:Connect(function()
    v1.TweenService:Create(instance3, TweenInfo.new(0.15), {
      Color = v5.Stroke,
      Thickness = 1,
    }):Play()

    v1.TweenService:Create(frame4, TweenInfo.new(0.15), { BackgroundTransparency = 0.3 }):Play()
  end)

  frame4.MouseLeave:Connect(function()
    v1.TweenService:Create(instance3, TweenInfo.new(0.15), {
      Color = v5.StrokeDim,
      Thickness = 0.9,
    }):Play()

    v1.TweenService:Create(frame4, TweenInfo.new(0.15), { BackgroundTransparency = 0.5 }):Play()
  end)

  if p18 and p19 then
    f17(text3, p18, p19, frame4)
  end

  return frame4
end

local function makeTextButton3(parent4, text5, text6, p20, p21, p22)
  local frame7 = Instance.new("Frame")
  frame7.Size = UDim2.new(1, 0, 0, 32)
  frame7.BackgroundColor3 = v5.Card
  frame7.BackgroundTransparency = 0.5
  frame7.BorderSizePixel = 0
  frame7.Parent = parent4

  Instance.new("UICorner", frame7).CornerRadius = UDim.new(0, v5.CardRadius)

  local instance4 = Instance.new("UIStroke", frame7)
  instance4.Color = v5.StrokeDim
  instance4.Thickness = 0.9

  local textLabel5 = Instance.new("TextLabel")
  textLabel5.Size = UDim2.new(1, -110, 1, 0)
  textLabel5.Position = UDim2.new(0, 10, 0, 0)
  textLabel5.BackgroundTransparency = 1
  textLabel5.Text = text5
  textLabel5.TextColor3 = v5.Text
  textLabel5.Font = v5.Font
  textLabel5.TextSize = 12
  textLabel5.TextXAlignment = Enum.TextXAlignment.Left
  textLabel5.Parent = frame7

  local frame8 = Instance.new("Frame")
  frame8.Size = UDim2.new(0, 90, 0, 20)
  frame8.Position = UDim2.new(1, -98, 0.5, -10)
  frame8.BackgroundColor3 = v5.Elevated
  frame8.BorderSizePixel = 0
  frame8.Parent = frame7

  Instance.new("UICorner", frame8).CornerRadius = UDim.new(0, 5)

  local instance5 = Instance.new("UIStroke", frame8)
  instance5.Color = v5.Stroke
  instance5.Thickness = 0.8

  local textButton4 = Instance.new("TextButton")
  textButton4.Size = UDim2.new(1, 0, 1, 0)
  textButton4.BackgroundTransparency = 1
  textButton4.Text = (text6 or "TRIGGER"):upper()
  textButton4.TextColor3 = v5.Text
  textButton4.Font = v5.Font
  textButton4.TextSize = 10.5
  textButton4.AutoButtonColor = false
  textButton4.Parent = frame8

  textButton4.MouseEnter:Connect(function()
    v1.TweenService:Create(frame8, TweenInfo.new(0.15), {
      BackgroundColor3 = Color3.fromRGB(34, 36, 46),
    }):Play()
  end)

  textButton4.MouseLeave:Connect(function()
    v1.TweenService:Create(frame8, TweenInfo.new(0.15), {
      BackgroundColor3 = v5.Elevated,
    }):Play()
  end)

  textButton4.MouseButton1Click:Connect(p20)

  frame7.MouseEnter:Connect(function()
    v1.TweenService:Create(instance4, TweenInfo.new(0.15), {
      Color = v5.Stroke,
      Thickness = 1,
    }):Play()

    v1.TweenService:Create(frame7, TweenInfo.new(0.15), { BackgroundTransparency = 0.3 }):Play()
  end)

  frame7.MouseLeave:Connect(function()
    v1.TweenService:Create(instance4, TweenInfo.new(0.15), {
      Color = v5.StrokeDim,
      Thickness = 0.9,
    }):Play()

    v1.TweenService:Create(frame7, TweenInfo.new(0.15), { BackgroundTransparency = 0.5 }):Play()
  end)

  if p21 and p22 then
    f17(text5, p21, p22, frame7)
  end

  return frame7
end

local function makeTextButton4(parent5, text7, list3, p23, text8, p24, p25, p26)
  local v56 = p23 or list3

  local frame9 = Instance.new("Frame")
  frame9.Size = UDim2.new(1, 0, 0, 0)
  frame9.BackgroundTransparency = 1
  frame9.AutomaticSize = Enum.AutomaticSize.Y
  frame9.BorderSizePixel = 0
  frame9.Parent = parent5

  local uiListLayout = Instance.new("UIListLayout")
  uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout.Padding = UDim.new(0, 3)
  uiListLayout.Parent = frame9

  local textButton5 = Instance.new("TextButton")
  textButton5.Size = UDim2.new(1, 0, 0, 32)
  textButton5.BackgroundColor3 = v5.Card
  textButton5.BackgroundTransparency = 0.5
  textButton5.BorderSizePixel = 0
  textButton5.Text = ""
  textButton5.AutoButtonColor = false
  textButton5.LayoutOrder = 1
  textButton5.Parent = frame9

-- https://lua-x.online
  Instance.new("UICorner", textButton5).CornerRadius = UDim.new(0, v5.CardRadius)

  local instance6 = Instance.new("UIStroke", textButton5)
  instance6.Color = v5.StrokeDim
  instance6.Thickness = 0.9

  local textLabel6 = Instance.new("TextLabel")
  textLabel6.Size = UDim2.new(1, -155, 1, 0)
  textLabel6.Position = UDim2.new(0, 10, 0, 0)
  textLabel6.BackgroundTransparency = 1
  textLabel6.Text = text7
  textLabel6.TextColor3 = v5.Text
  textLabel6.Font = v5.Font
  textLabel6.TextSize = 12
  textLabel6.TextXAlignment = Enum.TextXAlignment.Left
  textLabel6.Parent = textButton5

  local frame10 = Instance.new("Frame")
  frame10.Size = UDim2.new(0, 130, 0, 22)
  frame10.Position = UDim2.new(1, -138, 0.5, -11)
  frame10.BackgroundColor3 = v5.Elevated
  frame10.BorderSizePixel = 0
  frame10.Parent = textButton5

  Instance.new("UICorner", frame10).CornerRadius = UDim.new(0, 5)

  local instance7 = Instance.new("UIStroke", frame10)
  instance7.Color = v5.Stroke
  instance7.Thickness = 0.8

  local textLabel7 = Instance.new("TextLabel")
  textLabel7.Size = UDim2.new(1, -22, 1, 0)
  textLabel7.Position = UDim2.new(0, 8, 0, 0)
  textLabel7.BackgroundTransparency = 1
  textLabel7.Text = tostring(text8)
  textLabel7.TextColor3 = Color3.fromRGB(240, 242, 250)
  textLabel7.Font = v5.Font
  textLabel7.TextSize = 11
  textLabel7.TextXAlignment = Enum.TextXAlignment.Left
  textLabel7.TextTruncate = Enum.TextTruncate.AtEnd
  textLabel7.Parent = frame10

  local imageLabel2 = Instance.new("ImageLabel")
  imageLabel2.Size = UDim2.new(0, 14, 0, 14)
  imageLabel2.Position = UDim2.new(1, -18, 0.5, -7)
  imageLabel2.BackgroundTransparency = 1
  imageLabel2.Image = "rbxassetid://7733717447"
  imageLabel2.ImageColor3 = v5.TextSub
  imageLabel2.ScaleType = Enum.ScaleType.Fit
  imageLabel2.Parent = frame10

  local dropdownMenu = Instance.new("Frame")
  dropdownMenu.Name = "DropdownMenu"
  dropdownMenu.Size = UDim2.new(1, 0, 0, 0)
  dropdownMenu.BackgroundColor3 = Color3.fromRGB(15, 16, 21)
  dropdownMenu.BackgroundTransparency = 0.15
  dropdownMenu.BorderSizePixel = 0
  dropdownMenu.ClipsDescendants = true
  dropdownMenu.Visible = false
  dropdownMenu.AutomaticSize = Enum.AutomaticSize.Y
  dropdownMenu.LayoutOrder = 2
  dropdownMenu.Parent = frame9

  Instance.new("UICorner", dropdownMenu).CornerRadius = UDim.new(0, v5.CardRadius)

  local instance8 = Instance.new("UIStroke", dropdownMenu)
  instance8.Color = v5.Stroke
  instance8.Thickness = 0.9

  local uiListLayout2 = Instance.new("UIListLayout")
  uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout2.Padding = UDim.new(0, 2)
  uiListLayout2.Parent = dropdownMenu

  local instance9 = Instance.new("UIPadding", dropdownMenu)
  instance9.PaddingTop = UDim.new(0, 4)
  instance9.PaddingBottom = UDim.new(0, 4)
  instance9.PaddingLeft = UDim.new(0, 4)
  instance9.PaddingRight = UDim.new(0, 4)

  local v57 = false
  local v58 = text8

  local function f21(p27)
    v57 = p27 ~= nil and p27 or not v57
    dropdownMenu.Visible = v57

    v1.TweenService:Create(imageLabel2, TweenInfo.new(0.15), {
      Rotation = v57 and 180 or 0,
    }):Play()

    v1.TweenService:Create(instance7, TweenInfo.new(0.15), {
      Color = v57 and v5.Accent or v5.Stroke,
    }):Play()
  end

  local function makeTextButton5()
    for _, value13 in ipairs(dropdownMenu:GetChildren()) do
      if value13:IsA("TextButton") then
        value13:Destroy()
      end
    end

    for index, value14 in ipairs(list3) do
      local v59 = v56[index]
      local v60 = v59 == v58

      local textButton6 = Instance.new("TextButton")
      textButton6.Size = UDim2.new(1, 0, 0, 26)

      textButton6.BackgroundColor3 = v60 and Color3.fromRGB(28, 30, 40)
        or Color3.fromRGB(15, 16, 21)

      textButton6.BackgroundTransparency = v60 and 0 or 1
      textButton6.BorderSizePixel = 0
      textButton6.Text = ""
      textButton6.AutoButtonColor = false
      textButton6.Parent = dropdownMenu

      Instance.new("UICorner", textButton6).CornerRadius = UDim.new(0, 5)

      local textLabel8 = Instance.new("TextLabel")
      textLabel8.Size = UDim2.new(1, -26, 1, 0)
      textLabel8.Position = UDim2.new(0, 8, 0, 0)
      textLabel8.BackgroundTransparency = 1
      textLabel8.Text = tostring(value14)

      textLabel8.TextColor3 = v60 and Color3.fromRGB(255, 255, 255)
        or Color3.fromRGB(160, 165, 180)

      textLabel8.Font = v5.Font
      textLabel8.TextSize = 11.5
      textLabel8.TextXAlignment = Enum.TextXAlignment.Left
      textLabel8.Parent = textButton6

      local imageLabel3 = Instance.new("ImageLabel")
      imageLabel3.Size = UDim2.new(0, 14, 0, 14)
      imageLabel3.Position = UDim2.new(1, -20, 0.5, -7)
      imageLabel3.BackgroundTransparency = 1
      imageLabel3.Image = "rbxassetid://7733715400"
      imageLabel3.ImageColor3 = Color3.fromRGB(255, 255, 255)
      imageLabel3.ScaleType = Enum.ScaleType.Fit
      imageLabel3.Visible = v60
      imageLabel3.Parent = textButton6

      textButton6.MouseButton1Click:Connect(function()
        v58 = v59
        textLabel7.Text = tostring(value14)
        f21(false)
        makeTextButton5()
        pcall(p24, v59)
      end)

      if v60 then
        textLabel7.Text = tostring(value14)
      end
    end
  end

  textButton5.MouseButton1Click:Connect(function() f21() end)
  makeTextButton5()

  if p25 and p26 then
    f17(text7, p25, p26, frame9)
  end

  return frame9
end

local function makeTextLabel2(
  parent6, text9, customTargetPlayer, placeholderText, p28, p29, p30
)
  local frame11 = Instance.new("Frame")
  frame11.Size = UDim2.new(1, 0, 0, 32)
  frame11.BackgroundColor3 = v5.Card
  frame11.BackgroundTransparency = 0.5
  frame11.BorderSizePixel = 0
  frame11.Parent = parent6

  Instance.new("UICorner", frame11).CornerRadius = UDim.new(0, v5.CardRadius)

  local instance10 = Instance.new("UIStroke", frame11)
  instance10.Color = v5.StrokeDim
  instance10.Thickness = 0.9

  local textLabel9 = Instance.new("TextLabel")
  textLabel9.Size = UDim2.new(0.48, -10, 1, 0)
  textLabel9.Position = UDim2.new(0, 10, 0, 0)
  textLabel9.BackgroundTransparency = 1
  textLabel9.Text = text9
  textLabel9.TextColor3 = v5.Text
  textLabel9.Font = v5.Font
  textLabel9.TextSize = 12
  textLabel9.TextXAlignment = Enum.TextXAlignment.Left
  textLabel9.Parent = frame11

  local frame12 = Instance.new("Frame")
  frame12.Size = UDim2.new(0.5, 0, 0, 22)
  frame12.Position = UDim2.new(1, -8, 0.5, 0)
  frame12.AnchorPoint = Vector2.new(1, 0.5)
  frame12.BackgroundColor3 = v5.Elevated
  frame12.BorderSizePixel = 0
  frame12.Parent = frame11

  Instance.new("UICorner", frame12).CornerRadius = UDim.new(0, 5)

  local instance11 = Instance.new("UIStroke", frame12)
  instance11.Color = v5.Stroke
  instance11.Thickness = 0.8

  local textBox = Instance.new("TextBox")
  textBox.Size = UDim2.new(1, -12, 1, 0)
  textBox.Position = UDim2.new(0, 6, 0, 0)
  textBox.BackgroundTransparency = 1
  textBox.Text = customTargetPlayer or ""
  textBox.PlaceholderText = placeholderText or "Player name..."
  textBox.PlaceholderColor3 = v5.Muted
  textBox.TextColor3 = v5.Text
  textBox.Font = v5.Font
  textBox.TextSize = 11.5
  textBox.TextXAlignment = Enum.TextXAlignment.Left
  textBox.ClearTextOnFocus = false
  textBox.Parent = frame12
  textBox.FocusLost:Connect(function(p31) pcall(p28, textBox.Text) end)

  frame11.MouseEnter:Connect(function()
    v1.TweenService:Create(instance10, TweenInfo.new(0.15), {
      Color = v5.Stroke,
      Thickness = 1,
    }):Play()

    v1.TweenService:Create(frame11, TweenInfo.new(0.15), { BackgroundTransparency = 0.3 }):Play()
  end)

  frame11.MouseLeave:Connect(function()
    v1.TweenService:Create(instance10, TweenInfo.new(0.15), {
      Color = v5.StrokeDim,
      Thickness = 0.9,
    }):Play()

    v1.TweenService:Create(frame11, TweenInfo.new(0.15), { BackgroundTransparency = 0.5 }):Play()
  end)

  if p29 and p30 then
    f17(text9, p29, p30, frame11)
  end

  return frame11, textBox
end

local function f22(tab2)
  state.ActiveTab = tab2

  if state.SearchContainer then
    state.SearchContainer.Visible = false
  end

  for key, value15 in pairs(state.TabContainers) do
    value15.Visible = key == tab2
  end

  for key2, value16 in pairs(state.TabButtons) do
    local activeIndicator = value16:FindFirstChild("ActiveIndicator")
    local icon = value16:FindFirstChild("Icon")

    if key2 == tab2 then
      v1.TweenService:Create(value16, TweenInfo.new(0.18), {
        BackgroundTransparency = 0.1,
        BackgroundColor3 = Color3.fromRGB(18, 20, 26),
      }):Play()

      if activeIndicator then
        activeIndicator.BackgroundTransparency = 0

        v1.TweenService:Create(activeIndicator, TweenInfo.new(0.18), {
          Size = UDim2.new(0, 3, 0.7, 0),
        }):Play()
      end

      if icon then
        icon.ImageTransparency = 0
      end
    else
      v1.TweenService:Create(value16, TweenInfo.new(0.18), {
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.fromRGB(15, 16, 21),
      }):Play()

      if activeIndicator then
        activeIndicator.BackgroundTransparency = 1

        v1.TweenService:Create(activeIndicator, TweenInfo.new(0.18), {
          Size = UDim2.new(0, 0, 0.7, 0),
        }):Play()
      end

      if icon then
        icon.ImageTransparency = 0.35
      end
    end
  end
end

local function f23(p32)
  if not state.MainFrame then
    return
  end

  local isMenuOpen = p32 ~= nil and p32 or not state.MainFrame.Visible
  state.IsMenuOpen = isMenuOpen

  if isMenuOpen then
    state.MainFrame.Visible = true

    v1.TweenService:Create(state.MainFrame, TweenInfo.new(
      0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out
    ), {
      Size = UDim2.new(0, v5.MainW, 0, v5.MainH),
      Position = UDim2.new(0.5, -v5.MainW / 2, 0.5, -v5.MainH / 2),
      BackgroundTransparency = 0.02,
    }):Play()
  else
    local create = v1.TweenService:Create(state.MainFrame, TweenInfo.new(
      0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In
    ), {
      Size = UDim2.new(0, v5.MainW * 0.85, 0, v5.MainH * 0.85),
      Position = UDim2.new(0.5, -(v5.MainW * 0.85) / 2, 0.5, -(v5.MainH * 0.85) / 2),
      BackgroundTransparency = 1,
    })

    create:Play()

    create.Completed:Connect(function()
      if not state.IsMenuOpen then
        state.MainFrame.Visible = false
      end
    end)
  end
end

local function f24(key3)
  local v61 = v3[key3]

  if not v61 then
    return
  end

  v4 = key3

  v5.Bg = v61.Bg
  v5.Sidebar = v61.Sidebar
  v5.Card = v61.Card
  v5.CardHover = v61.CardHover
  v5.Elevated = v61.Elevated
  v5.Stroke = v61.Stroke
  v5.StrokeDim = v61.StrokeDim
  v5.Accent = v61.Accent
  v5.AccentCyan = v61.AccentCyan

  if state.MainFrame then
    state.MainFrame.BackgroundColor3 = v5.Bg
    local uiStroke = state.MainFrame:FindFirstChildOfClass("UIStroke")

    if uiStroke then
      uiStroke.Color = v5.Stroke
    end
  end
end

local function f25(p33)
  v6.ActivePreset = p33

  if p33 == "Legit" then
    v6.AutoParry = true
    v6.ClashMode = true
    v6.AutoTarget = true
    v6.AutoTargetMode = "Cursor"
    v6.AutoTargetSilent = true
    v6.UseCooldown = false
    v6.FrameDebounce = 0.014
    v6.ClashDebounce = 0.008
    v6.ClashDistance = 24
    v6.BaseReactionWindow = 0.12
    v6.ParryHitboxRadius = 4
    v6.FastBallLeadFactor = 0.0005
    v6.HeadingCheck = true
    v6.CurvePrediction = true
    v6.AutoFaceBall = false
  elseif p33 == "Competitive" then
    v6.AutoParry = true
    v6.ClashMode = true
    v6.AutoTarget = true
    v6.AutoTargetMode = "Closest"
    v6.AutoTargetSilent = true
    v6.UseCooldown = false
    v6.FrameDebounce = 0.01
    v6.ClashDebounce = 0.003
    v6.ClashDistance = 28
    v6.BaseReactionWindow = 0.14
    v6.ParryHitboxRadius = 4.5
    v6.FastBallLeadFactor = 0.0006
    v6.HeadingCheck = true
    v6.CurvePrediction = true
    v6.AutoFaceBall = false
  elseif p33 == "Clasher" or p33 == "Blatant" then
    v6.AutoParry = true
    v6.ClashMode = true
    v6.AutoTarget = true
    v6.AutoTargetMode = "Closest"
    v6.AutoTargetSilent = true
    v6.UseCooldown = false
    v6.FrameDebounce = 0.004
    v6.ClashDebounce = 0.001
    v6.ClashDistance = 32
    v6.BaseReactionWindow = 0.17
    v6.ParryHitboxRadius = 5.5
    v6.FastBallLeadFactor = 0.0009
    v6.HeadingCheck = true
    v6.CurvePrediction = true
    v6.AutoFaceBall = true
  end
end

local function makeTextButton6()
  local instance12 = f3()

  if not instance12 then
    return nil
  end

  local findFirstChild2 = instance12:FindFirstChild(v7)

  if findFirstChild2 then
    findFirstChild2:Destroy()
  end

  local screenGui2 = Instance.new("ScreenGui")
  screenGui2.Name = v7
  screenGui2.ResetOnSpawn = false
  screenGui2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  screenGui2.DisplayOrder = 99999

  local mainFrame = Instance.new("Frame")
  mainFrame.Name = "MainFrame"
  mainFrame.Size = UDim2.new(0, v5.MainW, 0, v5.MainH)
  mainFrame.Position = UDim2.new(0.5, -v5.MainW / 2, 0.5, -v5.MainH / 2)
  mainFrame.BackgroundColor3 = v5.Bg
  mainFrame.BackgroundTransparency = 0.02
  mainFrame.BorderSizePixel = 0
  mainFrame.ClipsDescendants = true
  mainFrame.Active = true
  mainFrame.Visible = true
  mainFrame.Parent = screenGui2

  state.MainFrame = mainFrame
  Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, v5.Radius)

  local instance13 = Instance.new("UIStroke", mainFrame)
  instance13.Thickness = 1
  instance13.Color = v5.Stroke

  local frame13 = Instance.new("Frame")
  frame13.Size = UDim2.new(1, 0, 0, v5.TitleH)
  frame13.BackgroundColor3 = v5.Sidebar
  frame13.BackgroundTransparency = 0.05
  frame13.BorderSizePixel = 0
  frame13.Parent = mainFrame

  local frame14 = Instance.new("Frame")
  frame14.Size = UDim2.new(1, 0, 0, 1)
  frame14.Position = UDim2.new(0, 0, 1, -1)
  frame14.BackgroundColor3 = v5.StrokeDim
  frame14.BorderSizePixel = 0
  frame14.Parent = frame13

  local titleLogo = Instance.new("TextLabel")
  titleLogo.Name = "TitleLogo"
  titleLogo.Size = UDim2.new(0, 180, 1, 0)
  titleLogo.Position = UDim2.new(0, 16, 0, 0)
  titleLogo.BackgroundTransparency = 1
  titleLogo.RichText = true
  titleLogo.Text = "<b>HYPNOSIS</b>  <font color='#7b7e8c'><font size='10'>BETA</font></font>"
  titleLogo.TextColor3 = v5.Text
  titleLogo.Font = v5.Font
  titleLogo.TextSize = 13.5
  titleLogo.TextXAlignment = Enum.TextXAlignment.Left
  titleLogo.Parent = frame13

  local textButton7 = Instance.new("TextButton")
  textButton7.Size = UDim2.new(0, 24, 0, 24)
  textButton7.Position = UDim2.new(1, -54, 0.5, -12)
  textButton7.BackgroundTransparency = 1
  textButton7.Text = "—"
  textButton7.TextColor3 = v5.TextSub
  textButton7.Font = v5.Font
  textButton7.TextSize = 14
  textButton7.AutoButtonColor = false
  textButton7.Parent = frame13
  textButton7.MouseButton1Click:Connect(function() f23(false) end)

  local imageButton = Instance.new("ImageButton")
  imageButton.Size = UDim2.new(0, 20, 0, 20)
  imageButton.Position = UDim2.new(1, -24, 0.5, -10)
  imageButton.BackgroundTransparency = 1
  imageButton.Image = "rbxassetid://7743878857"
  imageButton.ImageColor3 = v5.TextSub
  imageButton.ScaleType = Enum.ScaleType.Fit
  imageButton.AutoButtonColor = false
  imageButton.Parent = frame13
  imageButton.MouseButton1Click:Connect(function() f23(false) end)

  local titleSearchBar = Instance.new("Frame")
  titleSearchBar.Name = "TitleSearchBar"
  titleSearchBar.Size = UDim2.new(0, 210, 0, 24)
  titleSearchBar.Position = UDim2.new(1, -66, 0.5, 0)
  titleSearchBar.AnchorPoint = Vector2.new(1, 0.5)
  titleSearchBar.BackgroundColor3 = v5.Card
  titleSearchBar.BackgroundTransparency = 0.45
  titleSearchBar.BorderSizePixel = 0
  titleSearchBar.Active = true
  titleSearchBar.Parent = frame13

  Instance.new("UICorner", titleSearchBar).CornerRadius = UDim.new(0, 6)

  local instance14 = Instance.new("UIStroke", titleSearchBar)
  instance14.Color = v5.StrokeDim
  instance14.Thickness = 0.85

  local searchIcon = Instance.new("ImageLabel")
  searchIcon.Name = "SearchIcon"
  searchIcon.Size = UDim2.new(0, 13, 0, 13)
  searchIcon.Position = UDim2.new(0, 7, 0.5, -6.5)
  searchIcon.BackgroundTransparency = 1
  searchIcon.Image = "rbxassetid://7733954760"
  searchIcon.ImageColor3 = v5.TextSub
  searchIcon.ImageTransparency = 0.3
  searchIcon.ScaleType = Enum.ScaleType.Fit
  searchIcon.Parent = titleSearchBar

  local searchBox = Instance.new("TextBox")
  searchBox.Name = "SearchBox"
  searchBox.Size = UDim2.new(1, -44, 1, 0)
  searchBox.Position = UDim2.new(0, 24, 0, 0)
  searchBox.BackgroundTransparency = 1
  searchBox.Text = ""
  searchBox.PlaceholderText = "Search... (Ctrl+F)"
  searchBox.PlaceholderColor3 = v5.Muted
  searchBox.TextColor3 = v5.Text
  searchBox.Font = v5.Font
  searchBox.TextSize = 11
  searchBox.TextXAlignment = Enum.TextXAlignment.Left
  searchBox.ClearTextOnFocus = false
  searchBox.Active = true
  searchBox.Parent = titleSearchBar

  state.SearchBox = searchBox

  local clearSearchBtn = Instance.new("TextButton")
  clearSearchBtn.Name = "ClearSearchBtn"
  clearSearchBtn.Size = UDim2.new(0, 16, 0, 16)
  clearSearchBtn.Position = UDim2.new(1, -19, 0.5, -8)
  clearSearchBtn.BackgroundTransparency = 1
  clearSearchBtn.Text = "×"
  clearSearchBtn.TextColor3 = v5.TextSub
  clearSearchBtn.Font = v5.Font
  clearSearchBtn.TextSize = 14
  clearSearchBtn.AutoButtonColor = false
  clearSearchBtn.Visible = false
  clearSearchBtn.Parent = titleSearchBar

  state.ClearSearchBtn = clearSearchBtn

  clearSearchBtn.MouseButton1Click:Connect(function()
    searchBox.Text = ""
    searchBox:ReleaseFocus()

    clearSearchBtn.Visible = false

    if state.SearchContainer then
      state.SearchContainer.Visible = false
    end

    if state.TabContainers[state.ActiveTab] then
      state.TabContainers[state.ActiveTab].Visible = true
    end
  end)

  local flag5, position13, position14 = false, nil, nil

  frame13.InputBegan:Connect(function(input4)
    if input4.UserInputType == Enum.UserInputType.MouseButton1
      or input4.UserInputType == Enum.UserInputType.Touch then
      flag5 = true
      position13 = input4.Position
      position14 = mainFrame.Position
    end
  end)

  v1.UserInputService.InputChanged:Connect(function(input5)
    if flag5
      and (input5.UserInputType == Enum.UserInputType.MouseMovement
        or input5.UserInputType == Enum.UserInputType.Touch) then
      local v62 = input5.Position - position13

      mainFrame.Position = UDim2.new(
        position14.X.Scale, position14.X.Offset + v62.X, position14.Y.Scale,
        position14.Y.Offset + v62.Y
      )
    end
  end)

  v1.UserInputService.InputEnded:Connect(function(input6)
    if input6.UserInputType == Enum.UserInputType.MouseButton1
      or input6.UserInputType == Enum.UserInputType.Touch then
      flag5 = false
    end
  end)

  local v63 = 50

  local sidebar = Instance.new("Frame")
  sidebar.Name = "Sidebar"
  sidebar.Size = UDim2.new(0, 50, 1, -v5.TitleH)
  sidebar.Position = UDim2.new(0, 0, 0, v5.TitleH)
  sidebar.BackgroundColor3 = v5.Sidebar
  sidebar.BackgroundTransparency = 0.05
  sidebar.BorderSizePixel = 0
  sidebar.ClipsDescendants = true
  sidebar.Parent = mainFrame

  local frame15 = Instance.new("Frame")
  frame15.Size = UDim2.new(0, 1, 1, 0)
  frame15.Position = UDim2.new(1, -1, 0, 0)
  frame15.BackgroundColor3 = v5.StrokeDim
  frame15.BorderSizePixel = 0
  frame15.Parent = sidebar

  local sidebarContainer = Instance.new("ScrollingFrame")
  sidebarContainer.Name = "SidebarContainer"
  sidebarContainer.Size = UDim2.new(1, 0, 1, -8)
  sidebarContainer.Position = UDim2.new(0, 0, 0, 4)
  sidebarContainer.BackgroundTransparency = 1
  sidebarContainer.BorderSizePixel = 0
  sidebarContainer.ScrollBarThickness = 0
  sidebarContainer.ScrollingDirection = Enum.ScrollingDirection.Y
  sidebarContainer.ElasticBehavior = Enum.ElasticBehavior.Always
  sidebarContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
  sidebarContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
  sidebarContainer.Parent = sidebar

  local uiPadding = Instance.new("UIPadding")
  uiPadding.PaddingTop = UDim.new(0, 4)
  uiPadding.PaddingBottom = UDim.new(0, 14)
  uiPadding.Parent = sidebarContainer

  local uiListLayout3 = Instance.new("UIListLayout")
  uiListLayout3.Padding = UDim.new(0, 4)
  uiListLayout3.HorizontalAlignment = Enum.HorizontalAlignment.Center
  uiListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout3.Parent = sidebarContainer

  local frame16 = Instance.new("Frame")
  frame16.Size = UDim2.new(1, -v63 - 16, 1, -v5.TitleH - 12)
  frame16.Position = UDim2.new(0, v63 + 8, 0, v5.TitleH + 6)
  frame16.BackgroundTransparency = 1
  frame16.Parent = mainFrame

  local tabs = Instance.new("Folder")
  tabs.Name = "Tabs"
  tabs.Parent = frame16

  local searchTabContainer = Instance.new("CanvasGroup")
  searchTabContainer.Name = "SearchTabContainer"
  searchTabContainer.Size = UDim2.new(1, 0, 1, 0)
  searchTabContainer.BackgroundTransparency = 1
  searchTabContainer.BorderSizePixel = 0
  searchTabContainer.Visible = false
  searchTabContainer.Parent = frame16

  state.SearchContainer = searchTabContainer

  local searchScroll = Instance.new("ScrollingFrame")
  searchScroll.Name = "SearchScroll"
  searchScroll.Size = UDim2.new(1, 0, 1, 0)
  searchScroll.BackgroundTransparency = 1
  searchScroll.BorderSizePixel = 0
  searchScroll.ScrollBarThickness = 2
  searchScroll.ScrollBarImageColor3 = v5.Accent
  searchScroll.ScrollBarImageTransparency = 0.4
  searchScroll.Parent = searchTabContainer

  state.SearchScroll = searchScroll

  local uiPadding2 = Instance.new("UIPadding")
  uiPadding2.PaddingTop = UDim.new(0, 4)
  uiPadding2.PaddingBottom = UDim.new(0, 24)
  uiPadding2.PaddingRight = UDim.new(0, 6)
  uiPadding2.Parent = searchScroll

  local uiListLayout4 = Instance.new("UIListLayout")
  uiListLayout4.Padding = UDim.new(0, 6)
  uiListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout4.Parent = searchScroll

  uiListLayout4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    searchScroll.CanvasSize = UDim2.new(0, 0, 0, uiListLayout4.AbsoluteContentSize.Y + 30)
  end)

  searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local lower6 = searchBox.Text:gsub("^%s*(.-)%s*$", "%1"):lower()

    if #lower6 == 0 then
      clearSearchBtn.Visible = false
      searchTabContainer.Visible = false

      if state.TabContainers[state.ActiveTab] then
        state.TabContainers[state.ActiveTab].Visible = true
      end
    else
      clearSearchBtn.Visible = true

      for _, value17 in pairs(state.TabContainers) do
        value17.Visible = false
      end

      searchTabContainer.Visible = true

      for _, value18 in ipairs(searchScroll:GetChildren()) do
        if value18:IsA("Frame") then
          value18:Destroy()
        end
      end

      for _, value19 in ipairs(state.SearchFeatures) do
        if value19.name:lower():find(lower6) or value19.section:lower():find(lower6)
          or value19.tab:lower():find(lower6) then
          local frame17 = Instance.new("Frame")
          frame17.Size = UDim2.new(1, 0, 0, 32)
          frame17.BackgroundColor3 = v5.Card
          frame17.BackgroundTransparency = 0.5
          frame17.BorderSizePixel = 0
          frame17.Parent = searchScroll

          Instance.new("UICorner", frame17).CornerRadius = UDim.new(0, v5.CardRadius)

          local instance15 = Instance.new("UIStroke", frame17)
          instance15.Color = v5.StrokeDim
          instance15.Thickness = 0.85

          local textLabel10 = Instance.new("TextLabel")
          textLabel10.Size = UDim2.new(0.65, 0, 1, 0)
          textLabel10.Position = UDim2.new(0, 10, 0, 0)
          textLabel10.BackgroundTransparency = 1

          textLabel10.Text = value19.name .. "  <font color='#7b7e8c'>(" .. value19.tab .. " > "
            .. value19.section .. ")</font>"

          textLabel10.RichText = true
          textLabel10.TextColor3 = v5.Text
          textLabel10.Font = v5.Font
          textLabel10.TextSize = 11.5
          textLabel10.TextXAlignment = Enum.TextXAlignment.Left
          textLabel10.Parent = frame17

          local textButton8 = Instance.new("TextButton")
          textButton8.Size = UDim2.new(0, 70, 0, 20)
          textButton8.Position = UDim2.new(1, -78, 0.5, -10)
          textButton8.BackgroundColor3 = v5.Elevated
          textButton8.Text = "OPEN TAB"
          textButton8.TextColor3 = v5.TextSub
          textButton8.Font = v5.Font
          textButton8.TextSize = 10
          textButton8.AutoButtonColor = false
          textButton8.Parent = frame17

          Instance.new("UICorner", textButton8).CornerRadius = UDim.new(0, 4)

          textButton8.MouseButton1Click:Connect(function()
            searchBox.Text = ""
            searchBox:ReleaseFocus()
            f22(value19.tab)
          end)
        end
      end
    end
  end)

  local function makeTextButton7(key4, image, text10)
    local textButton9 = Instance.new("TextButton")
    textButton9.Name = key4 .. "TabBtn"
    textButton9.Size = UDim2.new(0, 34, 0, 34)
    textButton9.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
    textButton9.BackgroundTransparency = 1
    textButton9.Text = ""
    textButton9.AutoButtonColor = false
    textButton9.Parent = sidebarContainer

    Instance.new("UICorner", textButton9).CornerRadius = UDim.new(0, 7)

    local activeIndicator2 = Instance.new("Frame")
    activeIndicator2.Name = "ActiveIndicator"
    activeIndicator2.Size = UDim2.new(0, 0, 0.7, 0)
    activeIndicator2.Position = UDim2.new(0, -6, 0.15, 0)
    activeIndicator2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    activeIndicator2.BorderSizePixel = 0
    activeIndicator2.BackgroundTransparency = 1
    activeIndicator2.Parent = textButton9

    Instance.new("UICorner", activeIndicator2).CornerRadius = UDim.new(1, 0)

    local icon2 = Instance.new("ImageLabel")
    icon2.Name = "Icon"
    icon2.Size = UDim2.new(0, 20, 0, 20)
    icon2.Position = UDim2.new(0.5, -10, 0.5, -10)
    icon2.BackgroundTransparency = 1
    icon2.Image = image
    icon2.ImageColor3 = Color3.fromRGB(255, 255, 255)
    icon2.ImageTransparency = 0.35
    icon2.ScaleType = Enum.ScaleType.Fit
    icon2.Parent = textButton9

    textButton9.MouseEnter:Connect(function()
      if state.ActiveTab ~= key4 then
        v1.TweenService:Create(textButton9, TweenInfo.new(0.15), {
          BackgroundTransparency = 0.5,
          BackgroundColor3 = Color3.fromRGB(20, 21, 28),
        }):Play()

        v1.TweenService:Create(icon2, TweenInfo.new(0.15), { ImageTransparency = 0 }):Play()
      end
    end)

    textButton9.MouseLeave:Connect(function()
      if state.ActiveTab ~= key4 then
        v1.TweenService:Create(textButton9, TweenInfo.new(0.15), {
          BackgroundTransparency = 1,
          BackgroundColor3 = Color3.fromRGB(15, 16, 21),
        }):Play()

        v1.TweenService:Create(icon2, TweenInfo.new(0.15), { ImageTransparency = 0.35 }):Play()
      end
    end)

    textButton9.MouseButton1Click:Connect(function() f22(key4) end)

    state.TabButtons[key4] = textButton9

    local canvasGroup = Instance.new("CanvasGroup")
    canvasGroup.Name = key4 .. "TabContainer"
    canvasGroup.Size = UDim2.new(1, 0, 1, 0)
    canvasGroup.BackgroundTransparency = 1
    canvasGroup.BorderSizePixel = 0
    canvasGroup.Visible = false
    canvasGroup.Parent = tabs

    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Name = key4 .. "Scroll"
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = 2
    scrollingFrame.ScrollBarImageColor3 = v5.Accent
    scrollingFrame.ScrollBarImageTransparency = 0.5
    scrollingFrame.Parent = canvasGroup

    local uiPadding3 = Instance.new("UIPadding")
    uiPadding3.PaddingTop = UDim.new(0, 4)
    uiPadding3.PaddingBottom = UDim.new(0, 24)
    uiPadding3.PaddingRight = UDim.new(0, 6)
    uiPadding3.Parent = scrollingFrame

    local uiListLayout5 = Instance.new("UIListLayout")
    uiListLayout5.Padding = UDim.new(0, 8)
    uiListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout5.Parent = scrollingFrame

    uiListLayout5:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
      scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout5.AbsoluteContentSize.Y + 30)
    end)

    local headerBanner = Instance.new("Frame")
    headerBanner.Name = "HeaderBanner"
    headerBanner.Size = UDim2.new(1, 0, 0, 32)
    headerBanner.BackgroundTransparency = 1
    headerBanner.LayoutOrder = -100
    headerBanner.Parent = scrollingFrame

    local imageLabel4 = Instance.new("ImageLabel")
    imageLabel4.Size = UDim2.new(0, 18, 0, 18)
    imageLabel4.Position = UDim2.new(0, 4, 0.5, -9)
    imageLabel4.BackgroundTransparency = 1
    imageLabel4.Image = image
    imageLabel4.ImageColor3 = v5.Text
    imageLabel4.ScaleType = Enum.ScaleType.Fit
    imageLabel4.Parent = headerBanner

    local textLabel11 = Instance.new("TextLabel")
    textLabel11.Size = UDim2.new(1, -30, 1, 0)
    textLabel11.Position = UDim2.new(0, 28, 0, 0)
    textLabel11.BackgroundTransparency = 1
    textLabel11.Text = text10
    textLabel11.TextColor3 = v5.Text
    textLabel11.Font = v5.Font
    textLabel11.TextSize = 14
    textLabel11.TextXAlignment = Enum.TextXAlignment.Left
    textLabel11.Parent = headerBanner

    state.TabContainers[key4] = canvasGroup
    state.TabScrolls[key4] = scrollingFrame

    return scrollingFrame
  end

  local textButton10 = makeTextButton7("Home", "rbxassetid://7733960981", "Dashboard")

  do
    local frame18 = Instance.new("Frame")
    frame18.Size = UDim2.new(1, 0, 0, 64)
    frame18.BackgroundColor3 = v5.Card
    frame18.BackgroundTransparency = 0.4
    frame18.Parent = textButton10

    Instance.new("UICorner", frame18).CornerRadius = UDim.new(0, v5.CardRadius)

    local instance16 = Instance.new("UIStroke", frame18)
    instance16.Color = v5.Stroke
    instance16.Thickness = 0.9

    local textLabel12 = Instance.new("TextLabel")
    textLabel12.Size = UDim2.new(1, -74, 0, 20)
    textLabel12.Position = UDim2.new(0, 12, 0, 12)
    textLabel12.BackgroundTransparency = 1
    textLabel12.Text = "Welcome back, " .. localPlayer.DisplayName .. "!"
    textLabel12.TextColor3 = v5.Text
    textLabel12.Font = v5.Font
    textLabel12.TextSize = 15
    textLabel12.TextXAlignment = Enum.TextXAlignment.Left
    textLabel12.Parent = frame18

    local textLabel13 = Instance.new("TextLabel")
    textLabel13.Size = UDim2.new(1, -74, 0, 16)
    textLabel13.Position = UDim2.new(0, 12, 0, 34)
    textLabel13.BackgroundTransparency = 1

    textLabel13.Text = "Hypnosis BETA Blade Ball Edition — Executor: " .. f1()
      .. " | Status: Active"

    textLabel13.TextColor3 = v5.TextSub
    textLabel13.Font = v5.Font
    textLabel13.TextSize = 12
    textLabel13.TextXAlignment = Enum.TextXAlignment.Left
    textLabel13.Parent = frame18

    local imageLabel5 = Instance.new("ImageLabel")
    imageLabel5.Size = UDim2.new(0, 44, 0, 44)
    imageLabel5.Position = UDim2.new(1, -54, 0.5, -22)
    imageLabel5.BackgroundTransparency = 1
    imageLabel5.Parent = frame18

    Instance.new("UICorner", imageLabel5).CornerRadius = UDim.new(0.5, 0)

    local instance17 = Instance.new("UIStroke", imageLabel5)
    instance17.Color = v5.Accent
    instance17.Thickness = 1.2

    task.spawn(function()
      local ok5, image2 = pcall(function()
        return v1.Players:GetUserThumbnailAsync(
          localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100
        )
      end)

      if ok5 and image2 then
        imageLabel5.Image = image2
      end
    end)

    makeTextLabel(textButton10, "SYSTEM DASHBOARD & TELEMETRY", v5.Accent)

    local frame19 = Instance.new("Frame")
    frame19.Size = UDim2.new(1, 0, 0, 100)
    frame19.BackgroundColor3 = v5.Card
    frame19.BackgroundTransparency = 0.5
    frame19.Parent = textButton10

    Instance.new("UICorner", frame19).CornerRadius = UDim.new(0, v5.CardRadius)

    local instance18 = Instance.new("UIStroke", frame19)
    instance18.Color = v5.StrokeDim
    instance18.Thickness = 0.9

    local function makeTextLabel3(p34, text11)
      local textLabel14 = Instance.new("TextLabel")
      textLabel14.Size = UDim2.new(1, -20, 0, 18)
      textLabel14.Position = UDim2.new(0, 10, 0, p34)
      textLabel14.BackgroundTransparency = 1
      textLabel14.Text = text11
      textLabel14.TextColor3 = v5.TextSub
      textLabel14.Font = v5.Font
      textLabel14.TextSize = 11.5
      textLabel14.TextXAlignment = Enum.TextXAlignment.Left
      textLabel14.Parent = frame19

      return textLabel14
    end

    local textLabel15 = makeTextLabel3(8, "Engine State: Ready (Awaiting round...)")
    local textLabel16 = makeTextLabel3(28, "Active Ball: None")

    local textLabel17 = makeTextLabel3(
      48, "Distance: 0 studs | Speed: 0 studs/s | True ETA: 0.000s"
    )

    local textLabel18 = makeTextLabel3(68, "Controller Pipeline: Stealth UI & Hardware Key | Ping: "
      .. tostring(state.Stats.PingMs) .. "ms")

    v1.RunService.RenderStepped:Connect(function()
      if state.MainFrame and state.MainFrame.Visible and state.ActiveTab == "Home" then
        textLabel15.Text = "Engine State: " .. state.Stats.Status .. " ("
          .. (state.Stats.InMatch and "Armed" or "Lobby") .. ")"

        textLabel16.Text = "Active Ball: " .. state.Stats.BallName .. " | Target: "
          .. (state.Stats.TargetingYou and "YOU" or "Opponent")

        textLabel17.Text = "Dist: " .. tostring(state.Stats.Distance) .. " studs | Speed: "
          .. tostring(state.Stats.Speed) .. " studs/s | Lead: "
          .. tostring(state.Stats.TriggerWindow) .. "s"

        textLabel18.Text = "Deflections: " .. tostring(state.Stats.ParryCount)
          .. " | Integrity: Clean | Ping: " .. tostring(state.Stats.PingMs) .. "ms"
      end
    end)

    makeTextLabel(textButton10, "EASY COMBAT MODIFIER", v5.Accent)

    makeTextButton4(
      textButton10, "Active Combat Profile",
      { "Competitive (Default)", "Legit (Humanized)", "Clasher (Instant Spam)" },
      { "Competitive", "Legit", "Clasher" }, v6.ActivePreset, function(p35) f25(p35) end,
      "Home", "Quick Profile"
    )

    makeTextButton2(
      textButton10, "Reaction Timing Offset", -60, 60, math.floor(v6.TimingOffset * 1000),
      function(p36) v6.TimingOffset = p36 / 1000 end, 5, " ms", "Home", "Quick Profile"
    )

    makeTextButton(
      textButton10, "Auto Parry Deflection", v6.AutoParry,
      function(autoParry) v6.AutoParry = autoParry end, "Home", "Quick Profile"
    )

    makeTextButton(
      textButton10, "Auto Target Redirection", v6.AutoTarget,
      function(autoTarget) v6.AutoTarget = autoTarget end, "Home", "Quick Profile"
    )

    makeTextLabel2(textButton10, "Custom Target Player", v6.CustomTargetPlayer, "Username / DisplayName...", function(p37)
      v6.CustomTargetPlayer = p37

      if p37 and p37 ~= "" and p37 ~= "None" then
        v6.AutoTargetMode = "Specific"
      end
    end, "Home", "Quick Profile")

    makeTextButton(
      textButton10, "Clash Fast Spam Mode", v6.ClashMode,
      function(clashMode3) v6.ClashMode = clashMode3 end, "Home", "Quick Profile"
    )

    makeTextLabel(textButton10, "QUICK ACTIONS", v5.Accent)

    makeTextButton3(
      textButton10, "Trigger Test Deflection", "TRIGGER", function() f10(false) end, "Home",
      "Quick Actions"
    )
  end

  local textButton11 = makeTextButton7(
    "Combat", "rbxassetid://10734975692", "Combat Deflection"
  )

  makeTextLabel(textButton11, "EASY PLAYSTYLE MODIFIER (1-CLICK PROFILES)", v5.Accent)

  makeTextButton4(textButton11, "Combat Preset Profile", {
    "Competitive (Ranked / Default)", "Legit (Humanized)", "Clasher (Instant Spam)",
  }, { "Competitive", "Legit", "Clasher" }, v6.ActivePreset, function(p38) f25(p38) end, "Combat", "Quick Profile")

  makeTextButton2(
    textButton11, "Reaction Timing Offset", -60, 60, math.floor(v6.TimingOffset * 1000),
    function(p39) v6.TimingOffset = p39 / 1000 end, 5, " ms", "Combat", "Quick Profile"
  )

  makeTextButton(
    textButton11, "Auto Parry Deflection", v6.AutoParry,
    function(autoParry2) v6.AutoParry = autoParry2 end, "Combat", "Autoparry Engine"
  )

  makeTextButton(
    textButton11, "Clash Fast Spam Mode", v6.ClashMode,
    function(clashMode4) v6.ClashMode = clashMode4 end, "Combat", "Autoparry Engine"
  )

  makeTextLabel(
    textButton11, "AUTO TARGET & BALL REDIRECTION (CUSTOMIZABLE CURVE AIM)", v5.Accent
  )

  makeTextButton(
    textButton11, "Enable Auto Target Redirection", v6.AutoTarget,
    function(autoTarget2) v6.AutoTarget = autoTarget2 end, "Combat", "Auto Target"
  )

  makeTextButton4(
    textButton11, "Target Priority Mode",
    { "Closest Opponent", "Specific Player", "Cursor Aim", "Random Opponent" },
    { "Closest", "Specific", "Cursor", "Random" }, v6.AutoTargetMode,
    function(autoTargetMode) v6.AutoTargetMode = autoTargetMode end, "Combat", "Auto Target"
  )

  makeTextLabel2(textButton11, "Custom Target Name", v6.CustomTargetPlayer, "Username or DisplayName...", function(p40)
    v6.CustomTargetPlayer = p40

    if p40 and p40 ~= "" and p40 ~= "None" then
      v6.AutoTargetMode = "Specific"
    end
  end, "Combat", "Auto Target")

  makeTextButton3(textButton11, "Lock Nearest Player as Custom Target", "LOCK NEAREST", function()
    local _, v64 = f8()

    if v64 then
      v6.CustomTargetPlayer = v64.Name
      v6.AutoTargetMode = "Specific"
    end
  end, "Combat", "Auto Target")

  makeTextButton3(textButton11, "Clear Custom Target (Reset to Closest)", "RESET TARGET", function()
    v6.CustomTargetPlayer = ""
    v6.AutoTargetMode = "Closest"
  end, "Combat", "Auto Target")

  makeTextButton(
    textButton11, "Silent Redirection (Restore View)", v6.AutoTargetSilent,
    function(autoTargetSilent) v6.AutoTargetSilent = autoTargetSilent end, "Combat",
    "Auto Target"
  )

  makeTextButton(
    textButton11, "Show Target Lock Indicator", v6.AutoTargetVisual,
    function(autoTargetVisual) v6.AutoTargetVisual = autoTargetVisual end, "Combat",
    "Auto Target"
  )

  makeTextLabel(textButton11, "ADVANCED HITBOX & KINEMATICS (OPTIONAL TUNING)", v5.TextSub)

  makeTextButton2(
    textButton11, "Base Reaction Window", 0.08, 0.28, v6.BaseReactionWindow,
    function(baseReactionWindow) v6.BaseReactionWindow = baseReactionWindow end, 0.005, "s",
    "Combat", "Timing Calibration"
  )

  makeTextButton2(
    textButton11, "Clash Trigger Proximity", 15, 45, v6.ClashDistance,
    function(clashDistance) v6.ClashDistance = clashDistance end, 1, " studs", "Combat",
    "Debounce Calibration"
  )

  makeTextButton2(
    textButton11, "Parry Hitbox Reach (Sword)", 2, 7.5, v6.ParryHitboxRadius,
    function(parryHitboxRadius) v6.ParryHitboxRadius = parryHitboxRadius end, 0.5, " studs",
    "Combat", "Timing Calibration"
  )

  makeTextButton2(
    textButton11, "Fast Ball Lead Factor", 0.0002, 0.002, v6.FastBallLeadFactor,
    function(fastBallLeadFactor) v6.FastBallLeadFactor = fastBallLeadFactor end, 0.0001, "",
    "Combat", "Timing Calibration"
  )

  makeTextButton2(
    textButton11, "Ping Compensation Multiplier", 0.2, 1, v6.PingMultiplier,
    function(pingMultiplier) v6.PingMultiplier = pingMultiplier end, 0.05, "x", "Combat",
    "Timing Calibration"
  )

  makeTextLabel(textButton11, "ENGINE GUARDS & VERIFICATION", v5.TextSub)

  makeTextButton(
    textButton11, "Direction Reset Guard (Zero Lockout)", v6.DirectionResetGuard,
    function(directionResetGuard) v6.DirectionResetGuard = directionResetGuard end, "Combat",
    "Autoparry Engine"
  )

  makeTextButton(
    textButton11, "Heading & Velocity Verification", v6.HeadingCheck,
    function(headingCheck) v6.HeadingCheck = headingCheck end, "Combat", "Autoparry Engine"
  )

  makeTextButton(
    textButton11, "Curve Trajectory Math (Arc Predictor)", v6.CurvePrediction,
    function(curvePrediction) v6.CurvePrediction = curvePrediction end, "Combat",
    "Autoparry Engine"
  )

  makeTextLabel(textButton11, "TESTING & DEFLECTION ACTIONS", v5.Accent)

  makeTextButton3(
    textButton11, "Manual Precision Deflection", "TRIGGER", function() f10(false) end, "Combat",
    "Testing"
  )

  makeTextButton3(
    textButton11, "Manual Clash Spam Pulse", "PULSE", function() f10(true) end, "Combat",
    "Testing"
  )

  local textButton12 = makeTextButton7("Visuals", "rbxassetid://7743868936", "Visuals & HUD")

  do
    makeTextLabel(textButton12, "TRAJECTORY VISUALIZER (DRAWING API)", v5.Accent)

    makeTextButton(textButton12, "Enable 3D Trajectory Curve Arc", v6.VisualsEnabled, function(visualsEnabled)
      v6.VisualsEnabled = visualsEnabled

      if not visualsEnabled then
        f13()
      end
    end, "Visuals", "Trajectory")

    makeTextButton(textButton12, "Show 3D Parry Range Ring", v6.VisualRangeRing, function(visualRangeRing)
      v6.VisualRangeRing = visualRangeRing

      if not visualRangeRing and state.DrawingElements.RangeRing then
        state.DrawingElements.RangeRing.Visible = false
      end
    end, "Visuals", "Trajectory")

    makeTextButton2(
      textButton12, "Visual Line Thickness", 1, 5, v6.VisualThickness,
      function(visualThickness) v6.VisualThickness = visualThickness end, 1, "px", "Visuals",
      "Trajectory"
    )

    makeTextLabel(textButton12, "LIVE HUD TELEMETRY", v5.Accent)

    local frame20 = Instance.new("Frame")
    frame20.Size = UDim2.new(1, 0, 0, 95)
    frame20.BackgroundColor3 = v5.Card
    frame20.BackgroundTransparency = 0.5
    frame20.Parent = textButton12

    Instance.new("UICorner", frame20).CornerRadius = UDim.new(0, v5.CardRadius)

    local instance19 = Instance.new("UIStroke", frame20)
    instance19.Color = v5.StrokeDim
    instance19.Thickness = 0.9

    local function makeTextLabel4(p41, text12)
      local textLabel19 = Instance.new("TextLabel")
      textLabel19.Size = UDim2.new(1, -20, 0, 18)
      textLabel19.Position = UDim2.new(0, 10, 0, p41)
      textLabel19.BackgroundTransparency = 1
      textLabel19.Text = text12
      textLabel19.TextColor3 = v5.TextSub
      textLabel19.Font = v5.Font
      textLabel19.TextSize = 11.5
      textLabel19.TextXAlignment = Enum.TextXAlignment.Left
      textLabel19.Parent = frame20

      return textLabel19
    end

    local textLabel20 = makeTextLabel4(8, "Status: Ready")
    local textLabel21 = makeTextLabel4(28, "Active Ball: Searching...")
    local textLabel22 = makeTextLabel4(48, "Distance: -- | Speed: --")
    local textLabel23 = makeTextLabel4(68, "True ETA: -- | Lead Window: --")

    v1.RunService.RenderStepped:Connect(function()
      if state.MainFrame and state.MainFrame.Visible and state.ActiveTab == "Visuals" then
        textLabel20.Text = "Status: " .. state.Stats.Status
        textLabel21.Text = "Active Ball: " .. state.Stats.BallName

        textLabel22.Text = "Dist: " .. tostring(state.Stats.Distance) .. " studs | Speed: "
          .. tostring(state.Stats.Speed) .. " studs/s"

        textLabel23.Text = "True ETA: " .. tostring(state.Stats.ETA) .. "s | Lead Window: "
          .. tostring(state.Stats.TriggerWindow) .. "s"
      end
    end)
  end

  local textButton13 = makeTextButton7("ESP", "rbxassetid://7733774602", "ESP Modules")
  makeTextLabel(textButton13, "BALL VISUAL MODULES (DRAWING API OVERLAY)", v5.Accent)

  makeTextButton(
    textButton13, "Ball Target Circle Marker", v6.BallHighlight,
    function(ballHighlight) v6.BallHighlight = ballHighlight end, "ESP", "Ball Visuals"
  )

  makeTextButton(
    textButton13, "Ball Tracer Line", v6.BallTracers,
    function(ballTracers) v6.BallTracers = ballTracers end, "ESP", "Ball Visuals"
  )

  makeTextButton(
    textButton13, "Ball Distance & Speed Tag", v6.BallDistanceTag,
    function(ballDistanceTag) v6.BallDistanceTag = ballDistanceTag end, "ESP", "Ball Visuals"
  )

  local textButton14 = makeTextButton7("Farm", "rbxassetid://7734091286", "Auto Farm")
  makeTextLabel(textButton14, "COMBAT AUTOMATION", v5.Accent)

  makeTextButton(
    textButton14, "Auto Face Ball Direction", v6.AutoFaceBall,
    function(autoFaceBall) v6.AutoFaceBall = autoFaceBall end, "Farm", "Combat Automation"
  )

  makeTextButton(
    textButton14, "Auto Jump on Successful Deflection", v6.AutoJumpOnParry,
    function(autoJumpOnParry) v6.AutoJumpOnParry = autoJumpOnParry end, "Farm",
    "Combat Automation"
  )

  makeTextLabel(textButton14, "AFK & IDLE DEFENSE", v5.Accent)

  makeTextButton(
    textButton14, "Anti-AFK Protection (Passive Hardware Keepalive)", v6.AntiAFK,
    function(antiAFK) v6.AntiAFK = antiAFK end, "Farm", "AFK Defense"
  )

  local textButton15 = makeTextButton7("Self", "rbxassetid://7733655755", "Modifiers")

  do
    makeTextLabel(textButton15, "MOBILITY MODIFIERS", v5.Accent)

    makeTextButton(textButton15, "Enable Custom WalkSpeed", v6.CustomSpeed, function(customSpeed)
      v6.CustomSpeed = customSpeed
      local humanoid6 = getHumanoid()

      if humanoid6 then
        humanoid6.WalkSpeed = customSpeed and v6.WalkSpeedValue or 16
      end
    end, "Self", "Mobility")

    makeTextButton2(textButton15, "WalkSpeed Value", 16, 120, v6.WalkSpeedValue, function(p42)
      v6.WalkSpeedValue = p42

      if v6.CustomSpeed then
        local humanoid7 = getHumanoid()

        if humanoid7 then
          humanoid7.WalkSpeed = p42
        end
      end
    end, 1, " studs/s", "Self", "Mobility")

    makeTextButton(textButton15, "Enable Custom JumpPower", v6.CustomJump, function(customJump)
      v6.CustomJump = customJump
      local humanoid8 = getHumanoid()

      if humanoid8 then
        humanoid8.JumpPower = customJump and v6.JumpPowerValue or 50
      end
    end, "Self", "Mobility")

    makeTextButton2(textButton15, "JumpPower Value", 50, 180, v6.JumpPowerValue, function(p43)
      v6.JumpPowerValue = p43

      if v6.CustomJump then
        local humanoid9 = getHumanoid()

        if humanoid9 then
          humanoid9.JumpPower = p43
        end
      end
    end, 1, "", "Self", "Mobility")

    local connect = nil

    makeTextButton(textButton15, "Infinite Jump in Mid-Air", v6.InfiniteJump, function(infiniteJump)
      v6.InfiniteJump = infiniteJump

      if connect then
        connect:Disconnect()
        connect = nil
        state.Connections.InfiniteJump = nil
      end

      if infiniteJump then
        connect = v1.UserInputService.JumpRequest:Connect(function()
          if v6.InfiniteJump then
            local humanoid10 = getHumanoid()

            if humanoid10 then
              humanoid10:ChangeState(Enum.HumanoidStateType.Jumping)
            end
          end
        end)

        state.Connections.InfiniteJump = connect
      end
    end, "Self", "Mobility")

    makeTextLabel(textButton15, "ENVIRONMENT & CAMERA", v5.Accent)

    makeTextButton(textButton15, "Enable Custom Field of View", v6.CustomFOV, function(customFOV)
      v6.CustomFOV = customFOV

      if not customFOV and currentCamera then
        currentCamera.FieldOfView = 70
      end
    end, "Self", "Camera")

    makeTextButton2(textButton15, "Field of View (FOV)", 70, 120, v6.FOVValue, function(p44)
      v6.FOVValue = p44

      if v6.CustomFOV and currentCamera then
        currentCamera.FieldOfView = p44
      end
    end, 1, " deg", "Self", "Camera")
  end

  local textButton16 = makeTextButton7("Teleport", "rbxassetid://7733992789", "Teleports")
  makeTextLabel(textButton16, "ARENA TELEPORTS", v5.Accent)

  makeTextButton3(textButton16, "Teleport to Arena Center", "TELEPORT", function()
    local humanoidRootPart8 = getHumanoidRootPart()

    if humanoidRootPart8 then
      humanoidRootPart8.CFrame = CFrame.new(0, 22, 0)
    end
  end, "Teleport", "Arena")

  makeTextButton3(textButton16, "Teleport to Sky Safezone", "TELEPORT", function()
    local humanoidRootPart9 = getHumanoidRootPart()

    if humanoidRootPart9 then
      humanoidRootPart9.CFrame = humanoidRootPart9.CFrame + Vector3.new(0, 140, 0)
    end
  end, "Teleport", "Arena")

  makeTextButton3(textButton16, "Emergency Dodge Away from Ball", "DODGE", function()
    local humanoidRootPart10 = getHumanoidRootPart()

    if humanoidRootPart10 and currentCamera then
      humanoidRootPart10.CFrame = humanoidRootPart10.CFrame
        + currentCamera.CFrame.RightVector * 35
    end
  end, "Teleport", "Arena")

  makeTextLabel(textButton16, "OPPONENT TELEPORTS", v5.Accent)

  makeTextButton3(textButton16, "Teleport Behind Nearest Opponent", "TELEPORT", function()
    local humanoidRootPart11 = getHumanoidRootPart()

    if not humanoidRootPart11 then
      return
    end

    local huge4 = math.huge
    local v65 = nil

    for _, value20 in ipairs(v1.Players:GetPlayers()) do
      if value20 ~= localPlayer and value20.Character
        and value20.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart12 = value20.Character:FindFirstChild("HumanoidRootPart")
        local magnitude11 = (humanoidRootPart12.Position - humanoidRootPart11.Position).Magnitude

        if magnitude11 < huge4 then
          huge4 = magnitude11
          v65 = value20
        end
      end
    end

    if v65 and v65.Character and v65.Character:FindFirstChild("HumanoidRootPart") then
      local humanoidRootPart13 = v65.Character:FindFirstChild("HumanoidRootPart")
      humanoidRootPart11.CFrame = humanoidRootPart13.CFrame * CFrame.new(0, 0, 4)
    end
  end, "Teleport", "Opponents")

  local textButton17 = makeTextButton7("Config", "rbxassetid://7734058803", "Configs")
  makeTextLabel(textButton17, "ENGINE DEFENSE & INTEGRITY", v5.Accent)

  makeTextButton(
    textButton17, "Active Match Guard (Lobby Dormancy)", v6.ActiveMatchGuard,
    function(activeMatchGuard) v6.ActiveMatchGuard = activeMatchGuard end, "Config", "Integrity"
  )

  makeTextButton(
    textButton17, "Streamer Mode (Mask Identity)", v6.StreamerMode,
    function(streamerMode) v6.StreamerMode = streamerMode end, "Config", "Integrity"
  )

  makeTextLabel(textButton17, "THEME CUSTOMIZATION", v5.Accent)

  makeTextButton4(
    textButton17, "Active UI Theme", { "Default", "Neverlose", "Cyberpunk", "Vampire", "Old" },
    nil, v4, function(p45) f24(p45) end, "Config", "Themes"
  )

  makeTextLabel(textButton17, "HOTKEYS & INTERFACE", v5.Accent)

  makeTextButton4(textButton17, "Menu Keybind", { "RightShift", "Insert", "RightControl", "F4", "P" }, {
    Enum.KeyCode.RightShift, Enum.KeyCode.Insert, Enum.KeyCode.RightControl, Enum.KeyCode.F4,
    Enum.KeyCode.P,
  }, v6.MenuKeybind, function(menuKeybind) v6.MenuKeybind = menuKeybind end, "Config", "Hotkeys")

  makeTextButton3(
    textButton17, "Toggle UI Menu Visibility", "TOGGLE", function() f23() end, "Config",
    "Hotkeys"
  )

  makeTextLabel(textButton17, "MAINTENANCE & ENGINE RESTART", v5.Danger)

  makeTextButton3(textButton17, "Restart Hypnosis Engine", "RESTART", function()
    local v66 = typeof(getgenv) == "function" and getgenv() or nil

    if v66 and v66._HYP_BB_R and type(v66._HYP_BB_R.Restart) == "function" then
      v66._HYP_BB_R.Restart()
    end
  end, "Config", "Maintenance")

  makeTextButton3(textButton17, "Unload Hypnosis Engine Completely", "UNLOAD", function()
    local v67 = typeof(getgenv) == "function" and getgenv() or nil

    if v67 and v67._HYP_BB_R and type(v67._HYP_BB_R.Destroy) == "function" then
      v67._HYP_BB_R.Destroy()
    end
  end, "Config", "Maintenance")

  local textButton18 = makeTextButton7("Community", "rbxassetid://7733746980", "Config Hub")

  do
    makeTextLabel(textButton18, "BLADE BALL PLAYSTYLE PRESETS", v5.Accent)

    makeTextButton3(
      textButton18, "Load Competitive Preset (Optimal Default)", "LOAD",
      function() f25("Competitive") end, "Community", "Presets"
    )

    makeTextButton3(
      textButton18, "Load Legit Preset (Tight Window, Humanized)", "LOAD",
      function() f25("Legit") end, "Community", "Presets"
    )

    makeTextButton3(
      textButton18, "Load Blatant / Clasher Preset (Zero Debounce, Max Window)", "LOAD",
      function() f25("Clasher") end, "Community", "Presets"
    )

    makeTextButton3(textButton18, "Load Safe AFK Preset (Auto Face, Anti-AFK)", "LOAD", function()
      v6.AutoParry = true
      v6.UseCooldown = false
      v6.AutoFaceBall = true
      v6.AntiAFK = true
      v6.ActiveMatchGuard = true
    end, "Community", "Presets")

    makeTextLabel(textButton18, "ABOUT HYPNOSIS BLADE BALL", v5.Accent)

    local frame21 = Instance.new("Frame")
    frame21.Size = UDim2.new(1, 0, 0, 80)
    frame21.BackgroundColor3 = v5.Card
    frame21.BackgroundTransparency = 0.5
    frame21.Parent = textButton18

    Instance.new("UICorner", frame21).CornerRadius = UDim.new(0, v5.CardRadius)

    local instance20 = Instance.new("UIStroke", frame21)
    instance20.Color = v5.StrokeDim
    instance20.Thickness = 0.9

    local textLabel24 = Instance.new("TextLabel")
    textLabel24.Size = UDim2.new(1, -20, 1, -16)
    textLabel24.Position = UDim2.new(0, 10, 0, 8)
    textLabel24.BackgroundTransparency = 1

    textLabel24.Text = [[
Hypnosis BETA Blade Ball Edition
Authentic dark-theme UI with 9 synchronized tabs, real-time search engine, zero-cooldown clash spam deflection engine, and Drawing API curve arc visualizer (zero DataModel footprint).]]

    textLabel24.TextColor3 = v5.TextSub
    textLabel24.Font = v5.Font
    textLabel24.TextSize = 11.5
    textLabel24.TextXAlignment = Enum.TextXAlignment.Left
    textLabel24.TextYAlignment = Enum.TextYAlignment.Top
    textLabel24.Parent = frame21
  end

  local connect2 = v1.UserInputService.InputBegan:Connect(function(input7, p46)
    if p46 then
      return
    end

    if input7.KeyCode == v6.MenuKeybind then
      f23()
    end
  end)

  state.Connections.ToggleHotkey = connect2
  f2(screenGui2)
  screenGui2.Parent = instance12
  f22("Home")
  return screenGui2
end

local function f26()
  for _, value21 in pairs(state.Connections) do
    pcall(function() value21:Disconnect() end)
  end

  table.clear(state.Connections)
  f13()

  if state.ScreenGui then
    pcall(function() state.ScreenGui:Destroy() end)
    state.ScreenGui = nil
  end

  local instance21 = f3()

  if instance21 then
    local findFirstChild3 = instance21:FindFirstChild(v7)

    if findFirstChild3 then
      pcall(function() findFirstChild3:Destroy() end)
    end
  end
end

local function f27()
  f26()

  state.Connections.Heartbeat = v1.RunService.Heartbeat:Connect(f16)
  state.ScreenGui = makeTextButton6()

  task.spawn(function()
    while state.ScreenGui do
      task.wait(240)

      if v6.AntiAFK and not state.Stats.InMatch then
        pcall(function()
          local v68 = getgenv and getgenv().keypress or keypress
          local v69 = getgenv and getgenv().keyrelease or keyrelease

          if type(v68) == "function" and type(v69) == "function" then
            v68(32)
            task.wait(0.05)
            v69(32)
          end
        end)
      end
    end
  end)
end

f27()

local hypBBR = {
  Settings = v6,
  State = state,
  Trigger = function() f10(false) end,
  ToggleUI = f23,
  Destroy = f26,
  Restart = f27,
}

if typeof(getgenv) == "function" then
  local genv2 = getgenv()

  if genv2 then
    genv2._HYP_BB_R = hypBBR
  end
end

return hypBBR

-- https://lua-x.online
