--[[
    ==============================================================
    @7bragao  (ig)
   
    ==============================================================
--]]

local env = (type(getgenv) == "function" and getgenv()) or _G
if env.__LEXMESS_LOADED then
    local v1 = env.__LEXMESS_CLEANUP
    if v1 then
        pcall(v1)
    end
end
env.__LEXMESS_LOADED = true
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local TextChatService = game:GetService("TextChatService")
local WindUI =
    loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local LocalPlayer = Players.LocalPlayer
local function fn1(p1, p2)
    local v2, v3 = pcall(p2)
    if not v2 then
        warn("[LexBlade] " .. p1 .. " failed: " .. tostring(v3))
    end
    return v2
end
local v4 = {
    available = type(writefile) == "function" and type(readfile) == "function",
    baseFolder = "bragaHub",
    filePath = "brgaMessHub/lastSword.txt",
}
local function fn2()
    if not v4.available then
        return
    end
    pcall(function()
        if type(isfolder) == "function" and type(makefolder) == "function" then
            if not isfolder(v4.baseFolder) then
                makefolder(v4.baseFolder)
            end
        end
    end)
end
local function fn3(p3, p4)
    if not v4.available then
        return false
    end
    fn2()
    return pcall(function()
        writefile(p3, tostring(p4))
    end)
end
local function fn4(p5)
    if not v4.available then
        return nil
    end
    local v5, v6 = pcall(function()
        if type(isfile) == "function" then
            if not isfile(p5) then
                return nil
            end
            return readfile(p5)
        else
            return readfile(p5)
        end
    end)
    if v5 and type(v6) == "string" and v6 ~= "" then
        return v6
    end
    return nil
end
local v7 = 0.32
local v8 = 0.00050
local v9 = 0.45
local v10 = 0.16
local v11 = 1.05
local v12 = 0.03
local v13 = 60
local v14 = 0.12
local v15 = 0.05
local v16 = 0.10
local v17 = 25
local v18 = 8
local v19 = 3
local v20 = 0.38
local v21 = "LexMessCameraCurve"
local v22 = { Legit = 0.20, Pro = 0.15, Master = 0.10, Machine = 0.06 }
local v23 = 1.5
local v24 = 0.3
local v25 = {
    { maxPing = 30, base = 0.28, speedFac = 0.00040, max = 0.40, min = 0.14, pingFac = 0.50 },
    { maxPing = 80, base = 0.32, speedFac = 0.00050, max = 0.45, min = 0.16, pingFac = 1.00 },
    { maxPing = 150, base = 0.36, speedFac = 0.00060, max = 0.50, min = 0.18, pingFac = 1.05 },
    { maxPing = 250, base = 0.42, speedFac = 0.00070, max = 0.58, min = 0.20, pingFac = 1.10 },
    { maxPing = 9999, base = 0.48, speedFac = 0.00080, max = 0.65, min = 0.22, pingFac = 1.15 },
}
local v26 = {
    { minFps = 144, factor = 0.015, cap = 0.08 },
    { minFps = 120, factor = 0.020, cap = 0.09 },
    { minFps = 90, factor = 0.025, cap = 0.10 },
    { minFps = 60, factor = 0.030, cap = 0.12 },
    { minFps = 45, factor = 0.040, cap = 0.14 },
    { minFps = 30, factor = 0.055, cap = 0.16 },
    { minFps = 20, factor = 0.070, cap = 0.18 },
    { minFps = 0, factor = 0.090, cap = 0.20 },
}
local v27 = {
    { maxQuality = 0.03, radius = 15, threshold = 4, mode = "Legit", priority = true },
    { maxQuality = 0.08, radius = 18, threshold = 3, mode = "Pro", priority = true },
    { maxQuality = 0.15, radius = 22, threshold = 3, mode = "Master", priority = true },
    { maxQuality = 0.30, radius = 28, threshold = 2, mode = "Machine", priority = true },
    { maxQuality = 9999, radius = 35, threshold = 2, mode = "Machine", priority = true },
}
local v28 = {
    "singularity",
    "rapture",
    "death slash",
    "deathslash",
    "slashes of fury",
    "slash of fury",
    "dribble",
    "gale",
    "gale's edge",
    "fracture",
    "pull",
    "telekinesis",
    "windup",
    "rage",
    "raging deflect",
    "flash counter",
}
local v29 = {
    "reaper",
    "guardian angel",
    "quad jump",
    "luck",
    "misfortune",
    "golden ball",
    "martyrdom",
    "nab",
    "pinpoint",
    "tactician",
    "tact",
}
local v30 = { "CurrentlyEquippedAbility", "EquippedAbility", "Ability", "selectedAbility", "ability" }
local v31 = 1.2
local v32 = 20
local v33 = 0.5
local v34 = 0.50
local v35 = { "Secret", "Unique", "Limited", "LimitedU", "Legendary", "Rare", "Duo", "Normal" }
local v36 = 50
local v37 = 200
local v38 = "v.0.2.0259"
local v39 = {
    autoParry = false,
    parryMethod = "Dual",
    parryAccuracy = 100,
    useDynamicWindow = true,
    simpleRatio = 0.55,
    autoWindow = false,
    useAutoPing = true,
    windowBase = v7,
    windowSpeedFac = v8,
    windowMax = v9,
    windowMin = v10,
    windowPingFac = v11,
    useFpsComp = true,
    autoFps = false,
    fpsCompFactor = v12,
    fpsCompMax = v14,
    fpsOverride = 0,
    fastSpikeResponse = true,
    maxParryDistance = 100,
    maxParryAngle = 180,
    sameBallLockout = 0.08,
    curvePrediction = true,
    autoClash = false,
    autoClashConfig = false,
    clashDetectRadius = 20,
    clashExchangeThreshold = 3,
    clashSpamMode = "Pro",
    clashPriority = true,
    abilityCounter = false,
    abilitySpikeThreshold = v34,
    curveDeflectMode = "Off",
    curveDeflectStrength = 35,
    unlockSwords = false,
    unlockExplosions = false,
    unlockEmotes = false,
    unlockFinishers = false,
    orbOn = false,
    showImpactTime = true,
    walkEnabled = false,
    walkSpeed = 24,
    jumpEnabled = false,
    jumpPower = 60,
    infJump = false,
    antiAfk = false,
    fpsBoost = false,
    orbDebug = false,
    lastEquippedSword = "Base Sword",
    autoReequip = false,
    presenceEnabled = false,
    billboardEnabled = true,
}
do
    local v40 = fn4(v4.filePath)
    if v40 and v40 ~= "" and v40 ~= "Base Sword" then
        v39.lastEquippedSword = v40
    end
end
local v41 = {
    frames = 0,
    elapsed = 0,
    current = 60,
    smoothed = 60,
    instant = 60,
    lastDt = 1 / 60,
    spikeActive = false,
    spikeStartTime = 0,
    lowestRecent = 60,
    lowestRecentTime = 0,
}
local function fn5(p6)
    local v42 = math.clamp(p6, 0.001, v16)
    if v42 > 0.001 then
        v41.instant = math.clamp(1 / v42, 5, 500)
        v41.lastDt = v42
    end
    local v43 = os.clock()
    if p6 > v15 then
        v41.spikeActive = true
        v41.spikeStartTime = v43
        if v41.instant < v41.lowestRecent or v43 - v41.lowestRecentTime > 0.5 then
            v41.lowestRecent = v41.instant
            v41.lowestRecentTime = v43
        end
    elseif v41.spikeActive and v43 - v41.spikeStartTime > 0.3 then
        v41.spikeActive = false
    end
    v41.frames = v41.frames + 1
    v41.elapsed = v41.elapsed + v42
    if v41.elapsed >= 0.25 then
        local v44 = v41.frames / v41.elapsed
        v41.smoothed = v41.smoothed + (v44 - v41.smoothed) * 0.3
        v41.current = v44
        v41.frames = 0
        v41.elapsed = 0
    end
    if v39.fpsOverride > 0 then
        return v39.fpsOverride
    end
    return math.clamp(v41.smoothed, 10, 360)
end
local function fn6()
    if v39.fpsOverride > 0 then
        return v39.fpsOverride
    end
    if not v39.fastSpikeResponse then
        return math.clamp(v41.smoothed, 10, 360)
    end
    local v45 = math.min(v41.smoothed, v41.instant)
    if v41.spikeActive then
        v45 = math.min(v45, v41.lowestRecent)
    end
    return math.clamp(v45, 5, 360)
end
local function fn7(p7)
    if not v39.useFpsComp then
        return 0
    end
    local v46 = v13 / math.max(p7, 5)
    return math.min(v46 * v39.fpsCompFactor, v39.fpsCompMax)
end
local function fn8(p8)
    for v47, v48 in ipairs(v26) do
        if p8 >= v48.minFps then
            v39.fpsCompFactor = v48.factor
            v39.fpsCompMax = v48.cap
            return
        end
    end
end
local v49 = {}
local function fn9(p9)
    table.insert(v49, p9)
    return p9
end
local function fn10()
    for v50, v51 in ipairs(v49) do
        pcall(function()
            v51:Disconnect()
        end)
    end
    v49 = {}
end
local function fn11()
    local v52 = LocalPlayer.Character
    return v52 and v52:FindFirstChildOfClass("Humanoid")
end
local function fn12()
    local v53 = LocalPlayer.Character
    return v53 and v53:FindFirstChild("HumanoidRootPart")
end
local function fn13(p10, p11)
    pcall(function()
        WindUI:Notify({ Title = p10, Content = p11, Duration = 4 })
    end)
end
local function fn14()
    local v54, v55 = pcall(function()
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    return v54 and (v55 / 1000) or 0
end
local v56 = Workspace:WaitForChild("Balls", 30)
local function fn15()
    if not v56 then
        return nil
    end
    for v57, v58 in ipairs(v56:GetChildren()) do
        if v58:IsA("BasePart") and v58:GetAttribute("realBall") == true then
            return v58
        end
    end
    return nil
end
local function fn16(p12)
    local v59 = p12:GetAttribute("target")
    if v59 ~= nil then
        return v59 == LocalPlayer.Name
    end
    local v60 = LocalPlayer.Character
    return v60 ~= nil and v60:FindFirstChild("Highlight") ~= nil
end
local v61 = nil
local v62 = (type(keypress) == "function" and type(keyrelease) == "function")
local function fn17()
    if v61 and v61.Parent then
        return true
    end
    local v63 = ReplicatedStorage:FindFirstChild("Remotes")
    if not v63 then
        return false
    end
    local v64 = v63:FindFirstChild("ParryButtonPress")
    if v64 then
        v61 = v64
        return true
    end
    return false
end
local function fn18()
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.01)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
end
local function fn19()
    if not fn17() then
        return
    end
    pcall(function()
        v61:Fire()
    end)
end
local function fn20()
    if not v62 then
        fn18()
        return
    end
    pcall(function()
        keypress(0x46)
        task.wait(0.01)
        keyrelease(0x46)
    end)
end
local function fn21()
    local v65 = v39.parryMethod
    if v65 == "Mouse" then
        fn18()
    elseif v65 == "Remote" then
        fn19()
    elseif v65 == "Keypress" then
        fn20()
    else
        fn19()
        fn18()
    end
end
local v66, v67, v68 = nil, nil, false
local v69, v70 = 0, nil
local v71, v72, v73 = false, 0, 0
local v74 = {}
local v75 = { ball = nil, pos = nil, speed = 0, smooth = 0, accel = 0, hasSample = false, lastImpact = 0 }
local function fn22()
    v75.ball = nil
    v75.pos = nil
    v75.speed = 0
    v75.smooth = 0
    v75.accel = 0
    v75.hasSample = false
    v75.lastImpact = 0
end
local function fn23(p13)
    if not p13 then
        return
    end
    local v76 = os.clock()
    for v77 = #v74, 1, -1 do
        if v76 - v74[v77].time > v23 then
            table.remove(v74, v77)
        end
    end
    local v78 = v74[#v74]
    if not v78 or v78.target ~= p13 then
        table.insert(v74, { time = v76, target = p13 })
    end
end
local function fn24(p14, p15)
    local v79 = {}
    for v80, v81 in ipairs(Players:GetPlayers()) do
        if v81 ~= LocalPlayer then
            local v82 = v81.Character
            local v83 = v82 and v82:FindFirstChild("HumanoidRootPart")
            if v83 and (v83.Position - p14.Position).Magnitude <= p15 then
                v79[v81.Name] = true
            end
        end
    end
    return v79
end
local function fn25(p16, p17, p18)
    if not p16 then
        return false
    end
    local v84 = fn24(p16, p18)
    if next(v84) == nil then
        return false
    end
    local v85 = 0
    for v86, v87 in ipairs(v74) do
        if v87.target == LocalPlayer.Name or v84[v87.target] then
            v85 = v85 + 1
        end
    end
    return v85 >= p17
end
local function fn26(p19)
    if not v39.autoClash or not p19 then
        v71 = false
        return
    end
    local v88 = fn25(p19, v39.clashExchangeThreshold, v39.clashDetectRadius)
    local v89 = os.clock()
    if v88 then
        v72 = v89
        v71 = true
    elseif v89 - v72 > v24 then
        v71 = false
    end
end
local function fn27(p20, p21)
    local v90 = p20:FindFirstChild("zoomies")
    if v90 then
        local v91, v92 = pcall(function()
            return v90.VectorVelocity
        end)
        if v91 and typeof(v92) == "Vector3" and v92.Magnitude > 0.1 then
            return v92
        end
    end
    local v93 = p20.AssemblyLinearVelocity
    if v93.Magnitude > 0.1 then
        return v93
    end
    if v75.pos and p21 > 0 then
        return (p20.Position - v75.pos) / p21
    end
    return Vector3.zero
end
local function fn28(p22, p23, p24)
    if p23 <= 0.01 then
        return math.huge
    end
    if p24 > 0.5 then
        local v94 = p23 * p23 + 2 * p24 * p22
        return (-p23 + math.sqrt(v94)) / p24
    end
    return p22 / p23
end
local v95 = {
    active = false,
    startTime = 0,
    duration = v20,
    yaw = 0,
    pitch = 0,
    roll = 0,
    fovBoost = 0,
    originalFov = nil,
}
local function fn29()
    v95.active = false
    v95.yaw = 0
    v95.pitch = 0
    v95.roll = 0
    v95.fovBoost = 0
    if v95.originalFov then
        local v96 = Workspace.CurrentCamera
        if v96 then
            pcall(function()
                v96.FieldOfView = v95.originalFov
            end)
        end
    end
    v95.originalFov = nil
end
local function fn30(p25)
    if p25 == "Off" or not p25 then
        return
    end
    local v97 = v39.curveDeflectStrength / 100
    if v97 <= 0 then
        return
    end
    local v98 = p25
    if p25 == "Random" or p25 == "Camera" then
        local v99 = { "Right", "Left", "Up", "Down" }
        v98 = v99[math.random(1, 4)]
    end
    local v100 = v17 * v97
    local v101 = v18 * v97
    local v102 = v19 * v97
    local v103, v104, v105 = 0, 0, 0
    if v98 == "Right" then
        v103 = v100
        v105 = -v101
    elseif v98 == "Left" then
        v103 = -v100
        v105 = v101
    elseif v98 == "Up" then
        v104 = v100
    elseif v98 == "Down" then
        v104 = -v100
    else
        return
    end
    v95.active = true
    v95.startTime = os.clock()
    v95.duration = v20
    v95.yaw = v103
    v95.pitch = v104
    v95.roll = v105
    v95.fovBoost = v102
    local v106 = Workspace.CurrentCamera
    if v106 and not v95.originalFov then
        v95.originalFov = v106.FieldOfView
    end
end
local function fn31()
    if not v95.active then
        return
    end
    local v107 = os.clock() - v95.startTime
    if v107 >= v95.duration then
        fn29()
        return
    end
    local v108 = v107 / v95.duration
    local v109 = (1 - v108) * (1 - v108)
    local v110 = Workspace.CurrentCamera
    if not v110 then
        return
    end
    pcall(function()
        v110.CFrame = v110.CFrame
            * CFrame.Angles(math.rad(v95.pitch * v109), math.rad(v95.yaw * v109), math.rad(v95.roll * v109))
    end)
    if v95.originalFov and v95.fovBoost ~= 0 then
        pcall(function()
            v110.FieldOfView = v95.originalFov + v95.fovBoost * v109
        end)
    end
end
pcall(function()
    RunService:UnbindFromRenderStep(v21)
end)
pcall(function()
    RunService:BindToRenderStep(v21, Enum.RenderPriority.Camera.Value + 1, fn31)
end)
local v111 = {
    active = false,
    type = nil,
    startTime = 0,
    duration = 0,
    windowMod = 1.0,
    lastDir = Vector3.zero,
    detectionCooldown = 0,
    avgSpeed = 0,
    preDeflectSpeed = 0,
    lastDeflector = nil,
    lastDeflectTime = 0,
    lastDeflectBall = nil,
    lastBallTarget = nil,
    lostTargetAt = 0,
    lastBall = nil,
}
local function fn32(p26)
    if not p26 then
        return nil
    end
    for v112, v113 in ipairs(v30) do
        local v114, v115 = pcall(function()
            return p26:GetAttribute(v113)
        end)
        if v114 and typeof(v115) == "string" and v115 ~= "" then
            return v115
        end
    end
    local v116 = p26.Character
    if v116 then
        for v117, v118 in ipairs(v30) do
            local v119, v120 = pcall(function()
                return v116:GetAttribute(v118)
            end)
            if v119 and typeof(v120) == "string" and v120 ~= "" then
                return v120
            end
        end
    end
    return nil
end
local function fn33(p27)
    if not p27 then
        return false
    end
    local v121 = p27:lower()
    for v122, v123 in ipairs(v29) do
        if v121:find(v123, 1, true) then
            return false
        end
    end
    for v124, v125 in ipairs(v28) do
        if v121:find(v125, 1, true) then
            return true
        end
    end
    return false
end
local function fn34(p28)
    if not p28 then
        return
    end
    local v126 = p28.AssemblyLinearVelocity.Magnitude
    if v126 > 0.1 then
        v111.preDeflectSpeed = v126
    end
end
local function fn35(p29)
    if not p29 then
        return false, 0
    end
    if v111.preDeflectSpeed <= 0.1 then
        return false, 0
    end
    local v127 = p29.AssemblyLinearVelocity.Magnitude
    local v128 = (v127 - v111.preDeflectSpeed) / v111.preDeflectSpeed
    return v128 >= v39.abilitySpikeThreshold, v128
end
local function fn36(p30, p31, p32)
    if p30 and p30 ~= LocalPlayer.Name and p30 ~= p31 then
        if p32 then
            fn34(p32)
        end
        local v129 = Players:FindFirstChild(p30)
        if v129 then
            local v130 = fn32(v129)
            if v130 and fn33(v130) then
                v111.lastDeflector = p30
                v111.lastDeflectTime = os.clock()
                v111.lastDeflectBall = p32
            else
                v111.lastDeflector = nil
                v111.lastDeflectTime = 0
            end
        end
    end
end
local function fn37()
    v111.active = false
    v111.type = nil
    v111.startTime = 0
    v111.duration = 0
    v111.windowMod = 1.0
    v111.lastDir = Vector3.zero
    v111.detectionCooldown = 0
    v111.avgSpeed = 0
    v111.preDeflectSpeed = 0
    v111.lastDeflector = nil
    v111.lastDeflectTime = 0
    v111.lastDeflectBall = nil
    v111.lastBallTarget = nil
    v111.lostTargetAt = 0
    v111.lastBall = nil
end
local function fn38(p33, p34)
    if not p33 then
        return nil
    end
    if not v111.lastDeflector then
        return nil
    end
    local v131 = os.clock() - v111.lastDeflectTime
    if v131 > v31 then
        v111.lastDeflector = nil
        return nil
    end
    local v132, v133 = fn35(p33)
    if v132 then
        return {
            type = string.format("SpeedSpike:%.0f%%:%s", v133 * 100, v111.lastDeflector),
            mod = 1.30,
            duration = 0.6,
        }
    end
    if v111.lastDir.Magnitude > 1 and p34 > 0 then
        local v134 = p33.AssemblyLinearVelocity.Unit
        if v134.Magnitude > 0 then
            local v135 = math.clamp(v134:Dot(v111.lastDir), -1, 1)
            local v136 = math.deg(math.acos(v135))
            if v136 > v32 then
                return { type = "Curve:" .. v111.lastDeflector, mod = 1.20, duration = 0.4 }
            end
        end
    end
    return nil
end
local function fn39(p35, p36)
    if not v39.abilityCounter then
        fn37()
        return
    end
    local v137 = os.clock()
    if p35 ~= v111.lastBall then
        fn37()
        v111.lastBall = p35
    end
    if p35 then
        local v138 = p35:GetAttribute("target")
        if v138 ~= v111.lastBallTarget then
            fn36(v111.lastBallTarget, v138, p35)
            v111.lastBallTarget = v138
        end
    end
    if not p35 or not fn16(p35) then
        if v111.lostTargetAt == 0 then
            v111.lostTargetAt = v137
        end
        v111.active = false
        v111.windowMod = 1.0
        if v137 - v111.lostTargetAt >= v33 then
            fn37()
        end
        return
    end
    v111.lostTargetAt = 0
    if v111.active and v137 - v111.startTime > v111.duration then
        v111.active = false
        v111.windowMod = 1.0
    end
    if v137 - v111.detectionCooldown < 0.15 then
        local v139 = p35.AssemblyLinearVelocity
        if v139.Magnitude > 0.1 then
            v111.lastDir = v139.Unit
        end
        return
    end
    local v140 = fn38(p35, p36)
    if v140 then
        v111.active = true
        v111.type = v140.type
        v111.startTime = v137
        v111.duration = v140.duration
        v111.windowMod = v140.mod
        v111.detectionCooldown = v137
    end
    local v141 = p35.AssemblyLinearVelocity
    if v141.Magnitude > 0.1 then
        v111.lastDir = v141.Unit
    end
end
local function fn40()
    if not v39.abilityCounter then
        return 1.0
    end
    if v111.active then
        return v111.windowMod
    end
    return 1.0
end
local function fn41(p37)
    if v67 then
        v67:Disconnect()
        v67 = nil
    end
    v66 = p37
    v68 = false
    v74 = {}
    v111.lastBall = p37
    v111.lastBallTarget = p37:GetAttribute("target")
    v67 = p37:GetAttributeChangedSignal("target"):Connect(function()
        local v142 = p37:GetAttribute("target")
        local v143 = v111.lastBallTarget
        fn23(v142)
        if v143 ~= v142 then
            if v143 == LocalPlayer.Name and v39.curveDeflectMode ~= "Off" then
                fn30(v39.curveDeflectMode)
            end
            fn36(v143, v142, p37)
            v111.lastBallTarget = v142
        end
        if v142 == LocalPlayer.Name then
            v68 = false
        end
    end)
    local v144 = p37:GetAttribute("target")
    if v144 then
        fn23(v144)
        v111.lastBallTarget = v144
    end
    if fn16(p37) then
        v68 = false
    end
end
if v56 then
    fn9(v56.ChildAdded:Connect(function(p38)
        if p38:IsA("BasePart") and p38:GetAttribute("realBall") == true then
            fn41(p38)
        end
    end))
    local v145 = fn15()
    if v145 then
        fn41(v145)
    end
end
local v146 =
    { initialized = false, originals = {}, fakeCache = {}, allSwordNames = nil, swordsByRarity = nil }
local v147 = "lexfake_"
local function fn42(p39)
    return type(p39) == "string" and p39:sub(1, #v147) == v147
end
local function fn43(p40, p41)
    local v148 = tostring(p41)
    if v148:sub(1, #v147) == v147 then
        return v148
    end
    return v147 .. tostring(p40) .. "_" .. v148
end
local function fn44(p42)
    local v149 = p42:sub(#v147 + 1)
    local v150 = v149:find("_")
    if not v150 then
        return nil, nil
    end
    return v149:sub(1, v150 - 1), v149:sub(v150 + 1)
end
local function fn45(p43)
    if p43 == "Sword" then
        return v39.unlockSwords
    end
    if p43 == "Explosion" then
        return v39.unlockExplosions
    end
    if p43 == "Emote" then
        return v39.unlockEmotes
    end
    if p43 == "Finisher" then
        return v39.unlockFinishers
    end
    return false
end
local function fn46(p44, p45, p46)
    return {
        Name = p46,
        Id = p44,
        ItemType = p45,
        TradeLock = { Type = "Permanent", Value = true },
    }
end
function v146.enumerateSwords()
    if v146.allSwordNames then
        return v146.allSwordNames
    end
    local v151 = {}
    local v152 = {}
    local v153, v154 = pcall(function()
        return require(ReplicatedStorage.Shared.ReplicatedInstances.Swords)
    end)
    if v153 and v154 then
        local v155, v156 = pcall(function()
            return v154:GetCollection()
        end)
        if v155 and v156 then
            for v157 in pairs(v156) do
                if not v152[v157] then
                    v152[v157] = true
                    table.insert(v151, v157)
                end
            end
        end
    end
    table.sort(v151)
    v146.allSwordNames = v151
    return v151
end
function v146.groupSwordsByRarity()
    if v146.swordsByRarity then
        return v146.swordsByRarity
    end
    local v158 = {}
    for v159, v160 in ipairs(v35) do
        v158[v160] = {}
    end
    v158["Other"] = {}
    local v161, v162 = pcall(function()
        return require(ReplicatedStorage.Shared.ReplicatedInstances.Swords)
    end)
    if not v161 or not v162 then
        v146.swordsByRarity = v158
        return v158
    end
    for v163, v164 in ipairs(v146.enumerateSwords()) do
        local v165 = nil
        pcall(function()
            v165 = v162:GetSword(v164)
        end)
        local v166 = v165 and v165.Rarity
        if v166 and v158[v166] then
            table.insert(v158[v166], v164)
        else
            table.insert(v158["Other"], v164)
        end
    end
    for v167, v168 in pairs(v158) do
        table.sort(v168)
    end
    v146.swordsByRarity = v158
    return v158
end
function v146.getSwordsInRarity(p47)
    if p47 == "All" then
        return v146.enumerateSwords()
    end
    local v169 = v146.groupSwordsByRarity()
    return v169[p47] or {}
end
function v146.enumerateCosmetics(p48)
    local v170 = {}
    local v171 = {}
    local function fn47(p49)
        if type(p49) == "string" and p49 ~= "" and not v171[p49] then
            v171[p49] = true
            table.insert(v170, p49)
        end
    end
    local v172 = ReplicatedStorage:FindFirstChild("Misc")
    if p48 == "Sword" then
        for v173, v174 in ipairs(v146.enumerateSwords()) do
            fn47(v174)
        end
    elseif p48 == "Explosion" then
        if v172 then
            local v175 = v172:FindFirstChild("DataExplosions")
            if v175 then
                for v176, v177 in ipairs(v175:GetChildren()) do
                    fn47(v177.Name)
                end
            end
        end
    elseif p48 == "Finisher" then
        if v172 then
            local v178 = v172:FindFirstChild("DataFinishers")
            if v178 then
                for v179, v180 in ipairs(v178:GetChildren()) do
                    fn47(v180.Name)
                end
            end
        end
    elseif p48 == "Ability" then
        if v172 then
            local v181 = v172:FindFirstChild("DataAbilities")
            if v181 then
                for v182, v183 in ipairs(v181:GetChildren()) do
                    fn47(v183.Name)
                end
            end
        end
    elseif p48 == "Emote" then
        local v184, v185 = pcall(function()
            return require(ReplicatedStorage.Shared.ReplicatedInstances.EmoteVFX)
        end)
        if v184 and v185 then
            local v186, v187 = pcall(function()
                return v185:GetCollection()
            end)
            if v186 and v187 then
                for v188 in pairs(v187) do
                    fn47(v188)
                end
            end
        end
    end
    return v170
end
function v146.buildFakeInventory(p50)
    if v146.fakeCache[p50] then
        return v146.fakeCache[p50]
    end
    local v189 = {}
    for v190, v191 in ipairs(v146.enumerateCosmetics(p50)) do
        local v192 = fn43(p50, v191)
        v189[v192] = fn46(v192, p50, v191)
    end
    v146.fakeCache[p50] = v189
    return v189
end
function v146.forceEquipSword(p51)
    if type(p51) ~= "string" or p51 == "" then
        return false, "Empty sword name"
    end
    local v193 = LocalPlayer.Character
    if not v193 then
        return false, "No character (dead or loading)"
    end
    local v194, v195 = pcall(function()
        return require(ReplicatedStorage.Shared.ReplicatedInstances.Swords)
    end)
    if not v194 or not v195 then
        return false, "Swords module load failed"
    end
    local v196 = nil
    pcall(function()
        v196 = v195:GetSword(p51)
    end)
    if not v196 then
        return false, "Sword not in collection: " .. p51
    end
    local v197, v198 = pcall(function()
        return v195:EquipSwordTo(v193, p51, 1, false)
    end)
    if not v197 then
        return false, "EquipSwordTo errored: " .. tostring(v198)
    end
    if typeof(v198) ~= "Instance" then
        return false, "EquipSwordTo returned " .. typeof(v198)
    end
    pcall(function()
        LocalPlayer:SetAttribute("CurrentlyEquippedSword", p51)
    end)
    pcall(function()
        v193:SetAttribute("CurrentlyEquippedSword", p51)
    end)
    return true, v198
end
function v146.installOwnershipHooks()
    local v199 = ReplicatedStorage:FindFirstChild("Shared")
    local v200 = v199 and v199:FindFirstChild("Inventory")
    local v201 = v200 and v200:FindFirstChild("Shared")
    if not v201 then
        return false, "ReplicatedStorage.Shared.Inventory.Shared not found"
    end
    local v202, v203 = pcall(require, v201)
    if not v202 or not v203 then
        return false, "Failed to require Shared.Inventory.Shared: " .. tostring(v203)
    end
    v146.shared = v203
    v146.originals.OwnsItem = v203.OwnsItem
    v146.originals.GetItem = v203.GetItem
    v146.originals.FindItems = v203.FindItems
    v146.originals.FindItemsWithKey = v203.FindItemsWithKey
    v146.originals.Get = v203.Get
    v203.OwnsItem = function(self, p52, p53, p54)
        if fn45(p53) then
            return true
        end
        return v146.originals.OwnsItem(self, p52, p53, p54)
    end
    v203.GetItem = function(self, p55, p56, p57)
        if fn42(p57) then
            local v204, v205 = fn44(p57)
            return fn46(p57, v204 or p56, v205)
        end
        return v146.originals.GetItem(self, p55, p56, p57)
    end
    v203.FindItems = function(self, p58, p59, p60, p61)
        local v206 = v146.originals.FindItems(self, p58, p59, p60, p61)
        if fn45(p59) and (not v206 or #v206 == 0) then
            return { fn43(p59, p60) }
        end
        return v206
    end
    v203.FindItemsWithKey = function(self, p62, p63, p64)
        local v207 = v146.originals.FindItemsWithKey(self, p62, p63, p64)
        if fn45(p63) and (not v207 or #v207 == 0) then
            return { fn43(p63, p64) }
        end
        return v207
    end
    v203.Get = function(self, p65, p66)
        local v208 = v146.originals.Get(self, p65, p66)
        if not fn45(p66) then
            return v208
        end
        local v209 = {}
        if type(v208) == "table" then
            for v210, v211 in pairs(v208) do
                if not fn42(v210) then
                    v209[v210] = v211
                end
            end
        end
        local v212 = v146.buildFakeInventory(p66)
        for v213, v214 in pairs(v212) do
            v209[v213] = v214
        end
        return v209
    end
    return true
end
function v146.init(p67)
    if v146.initialized and not p67 then
        return true, "Hooks already active"
    end
    local v215, v216 = v146.installOwnershipHooks()
    if not v215 then
        return false, v216
    end
    v146.initialized = true
    return true, "Hooks installed"
end
local v217 = nil
local function fn48(p68)
    if not p68 or p68 == "" or p68 == "Base Sword" then
        return
    end
    v39.lastEquippedSword = p68
    fn3(v4.filePath, p68)
end
local function fn49()
    if not v39.autoReequip then
        return
    end
    if v39.lastEquippedSword == "" or v39.lastEquippedSword == "Base Sword" then
        return
    end
    local v218 = LocalPlayer.Character
    if not v218 then
        return
    end
    v218:WaitForChild("HumanoidRootPart", 10)
    task.wait(0.4)
    local v219, v220 = v146.forceEquipSword(v39.lastEquippedSword)
    if v219 then
        if v39.orbDebug then
            print("[AutoReequip] Reapplied: " .. v39.lastEquippedSword)
        end
    else
        if v39.orbDebug then
            warn("[AutoReequip] Failed: " .. tostring(v220))
        end
    end
end
local function fn50()
    if v217 then
        return
    end
    v217 = LocalPlayer.CharacterAdded:Connect(function()
        task.spawn(fn49)
    end)
end
local function fn51()
    if v217 then
        v217:Disconnect()
        v217 = nil
    end
end
local v221 = nil
local function fn52()
    if v221 then
        return
    end
    v221 = LocalPlayer.Idled:Connect(function()
        if not v39.antiAfk then
            return
        end
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
end
local function fn53()
    if v221 then
        v221:Disconnect()
        v221 = nil
    end
end
local v222 = { globalShadows = nil, postEffects = {}, active = false }
local function fn54()
    v222.globalShadows = Lighting.GlobalShadows
    v222.postEffects = {}
    for v223, v224 in ipairs(Lighting:GetChildren()) do
        if v224:IsA("PostEffect") then
            v222.postEffects[v224] = v224.Enabled
        end
    end
    v222.active = true
end
local function fn55()
    if not v222.active then
        return
    end
    if v222.globalShadows ~= nil then
        pcall(function()
            Lighting.GlobalShadows = v222.globalShadows
        end)
    end
    for v225, v226 in pairs(v222.postEffects) do
        if v225 and v225.Parent then
            pcall(function()
                v225.Enabled = v226
            end)
        end
    end
    v222.globalShadows = nil
    v222.postEffects = {}
    v222.active = false
end
local function fn56()
    if not v222.active then
        fn54()
    end
    Lighting.GlobalShadows = false
    for v227, v228 in ipairs(Lighting:GetChildren()) do
        if v228:IsA("PostEffect") then
            v228.Enabled = false
        end
    end
end
local function fn57(p69)
    local v229 = p69 * 1000
    for v230, v231 in ipairs(v25) do
        if v229 <= v231.maxPing then
            v39.windowBase = v231.base
            v39.windowSpeedFac = v231.speedFac
            v39.windowMax = v231.max
            v39.windowMin = v231.min
            v39.windowPingFac = v231.pingFac
            return
        end
    end
end
local function fn58(p70, p71)
    local v232 = p70 * (60 / math.max(p71, 10))
    for v233, v234 in ipairs(v27) do
        if v232 <= v234.maxQuality then
            v39.clashDetectRadius = v234.radius
            v39.clashExchangeThreshold = v234.threshold
            v39.clashSpamMode = v234.mode
            v39.clashPriority = v234.priority
            return
        end
    end
end
local function fn59(p72, p73)
    local v235
    if not v39.useDynamicWindow then
        v235 = v39.simpleRatio
        if v39.useAutoPing or v39.autoWindow then
            v235 = v235 + fn14()
        end
    else
        v235 = v39.windowBase + (p72 * v39.windowSpeedFac)
        v235 = math.clamp(v235, v39.windowMin, v39.windowMax)
        local v236 = v39.useAutoPing or v39.autoWindow
        if v236 then
            v235 = v235 + (fn14() * (v39.windowPingFac or 1.05))
        end
    end
    v235 = v235 + fn7(p73)
    v235 = v235 * fn40()
    return v235
end
local function fn60(p74, p75)
    local v237 = (p74.Position - p75.Position).Magnitude
    if v39.maxParryDistance > 0 and v237 > v39.maxParryDistance then
        return false
    end
    if v39.maxParryAngle < 180 then
        local v238 = (p74.Position - p75.Position).Unit
        local v239 = p75.CFrame.LookVector
        local v240 = math.clamp(v238:Dot(v239), -1, 1)
        local v241 = math.deg(math.acos(v240))
        if v241 > v39.maxParryAngle then
            return false
        end
    end
    return true
end
local v242, v243, v244 = nil, nil, nil
local v245, v246 = nil, nil
local v247 = Color3.fromRGB(255, 255, 255)
local v248 = Color3.fromRGB(255, 60, 60)
local v249 = Color3.fromRGB(255, 190, 40)
local v250 = Color3.fromRGB(80, 220, 100)
local v251 = Color3.fromRGB(190, 190, 190)
local v252 = Color3.fromRGB(180, 120, 255)
local v253, v254 = 6, 80
local v255 = 0.15
local v256 = 400
local v257 = 0.15
local v258, v259 = 100, 200
local v260, v261 = 30, 100
local v262, v263 = 60, 25
local v264, v265 = 0.08, 0.15
local v266, v267 = 40, 25
local v268 = { "status", "impact", "speed", "distance", "accel", "ping", "fps", "ability" }
local function fn61()
    local v269 = Instance.new("Part")
    v269.Name = "ParryOrb"
    v269.Shape = Enum.PartType.Ball
    v269.Anchored = true
    v269.CanCollide = false
    v269.CanQuery = false
    v269.CanTouch = false
    v269.Massless = true
    v269.CastShadow = false
    v269.Material = Enum.Material.ForceField
    v269.Color = v247
    v269.Transparency = 0.75
    v269.Size = Vector3.new(v253 * 2, v253 * 2, v253 * 2)
    v269.Parent = Workspace
    local v270 = Instance.new("BillboardGui")
    v270.Name = "ParryOrbInfo"
    v270.Size = UDim2.fromOffset(120, 30)
    v270.AlwaysOnTop = true
    v270.Adornee = v269
    v270.StudsOffset = Vector3.new(0, v253 + 2, 0)
    v270.Parent = v269
    local v271 = Instance.new("TextLabel")
    v271.Size = UDim2.fromScale(1, 1)
    v271.BackgroundTransparency = 1
    v271.TextColor3 = v247
    v271.TextStrokeTransparency = 0.5
    v271.Font = Enum.Font.GothamBold
    v271.TextSize = 16
    v271.Text = ""
    v271.Visible = false
    v271.Parent = v270
    return v269, v271, v270
end
local function fn62()
    if v242 then
        v242:Destroy()
    end
    v242, v243, v244 = nil, nil, nil
end
local function fn63()
    local v272 = Instance.new("BillboardGui")
    v272.Name = "ParryHeadStats"
    v272.Size = UDim2.fromOffset(210, 158)
    v272.AlwaysOnTop = true
    v272.StudsOffset = Vector3.new(0, 3.4, 0)
    v272.ResetOnSpawn = false
    v272.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local v273 = Instance.new("Frame")
    v273.Size = UDim2.fromScale(1, 1)
    v273.BackgroundTransparency = 1
    v273.Parent = v272
    local v274 = Instance.new("UIListLayout")
    v274.SortOrder = Enum.SortOrder.LayoutOrder
    v274.VerticalAlignment = Enum.VerticalAlignment.Bottom
    v274.Parent = v273
    local v275 = {}
    for v276, v277 in ipairs(v268) do
        local v278 = Instance.new("TextLabel")
        v278.Name = v277
        v278.LayoutOrder = v276
        v278.Size = UDim2.new(1, 0, 0, 19)
        v278.BackgroundTransparency = 1
        v278.Font = Enum.Font.GothamBold
        v278.TextSize = v277 == "status" and 17 or 14
        v278.TextColor3 = v251
        v278.TextStrokeTransparency = 0.4
        v278.Text = ""
        v278.Parent = v273
        v275[v277] = v278
    end
    return v272, v275
end
local function fn64()
    if v245 then
        v245:Destroy()
    end
    v245, v246 = nil, nil
end
local function fn65(p76, p77, p78)
    if not v246 then
        return
    end
    local v279 = v246[p76]
    if v279 then
        v279.Text = p77
        v279.TextColor3 = p78
    end
end
local function fn66(p79, p80, p81)
    if p79 >= p81 then
        return v248
    end
    if p79 >= p80 then
        return v249
    end
    return v250
end
local function fn67(p82, p83, p84)
    if p82 <= p84 then
        return v248
    end
    if p82 <= p83 then
        return v249
    end
    return v250
end
local function fn68(p85, p86)
    if p85 <= p86 then
        return v248
    end
    if p85 <= p86 + v257 then
        return v249
    end
    return v250
end
local function fn69(p87, p88, p89)
    return p87 * p89 + 0.5 * p88 * p89 * p89
end
local function fn70(p90)
    if not v242 then
        return
    end
    if not p90 then
        v242.Transparency = 1
        v243.Visible = false
        return
    end
    v242.Size = Vector3.new(p90.radius * 2, p90.radius * 2, p90.radius * 2)
    v242.CFrame = CFrame.new(p90.root.Position)
    local v280 = v71 and v249 or (v111.active and v252) or (p90.inRange and v248 or v247)
    v242.Color = v280
    v242.Transparency = p90.inRange and 0.5 or 0.75
    v244.StudsOffset = Vector3.new(0, p90.radius + 2, 0)
    if v39.showImpactTime and p90.impact and p90.impact < 5 then
        v243.Visible = true
        v243.Text = string.format("%.0f ms", p90.impact * 1000)
        v243.TextColor3 = v280
    else
        v243.Visible = false
    end
end
local function fn71(p91)
    local v281 = LocalPlayer.Character
    local v282 = v281 and v281:FindFirstChild("Head")
    if not v282 or not p91 then
        if v245 then
            v245.Enabled = false
        end
        return
    end
    if not v245 or not v245.Parent then
        v245, v246 = fn63()
    end
    v245.Adornee = v282
    v245.Enabled = true
    fn65("ping", string.format("Ping: %.0f ms", p91.ping * 1000), fn66(p91.ping, v264, v265))
    fn65(
        "fps",
        string.format("FPS: %.0f | Comp: %.0f ms", p91.fps, (p91.fpsComp or 0) * 1000),
        fn67(p91.fps, v266, v267)
    )
    if v39.abilityCounter and v111.active then
        fn65("ability", string.format("Ability: %s (x%.2f)", v111.type or "?", v111.windowMod), v252)
    else
        fn65("ability", "Ability: --", v251)
    end
    if v71 then
        fn65("status", "CLASH ACTIVE", v249)
    elseif v111.active then
        fn65("status", "ABILITY DETECTED", v252)
    elseif not p91.targeted then
        fn65("status", "NOT TARGETED", v251)
    else
        local v283 = fn68(p91.impact, p91.window)
        if v283 == v248 then
            fn65("status", "PARRY NOW", v248)
        elseif v283 == v249 then
            fn65("status", "GET READY", v249)
        else
            fn65("status", "INCOMING", v250)
        end
    end
    if not p91.targeted then
        fn65("impact", "Impact: --", v251)
        fn65("speed", "Speed: --", v251)
        fn65("distance", "Distance: --", v251)
        fn65("accel", "Accel: --", v251)
        return
    end
    if p91.impact < 10 then
        fn65("impact", string.format("Impact: %.0f ms", p91.impact * 1000), fn68(p91.impact, p91.window))
    else
        fn65("impact", "Impact: --", v251)
    end
    fn65("speed", string.format("Speed: %.0f st/s", p91.speed), fn66(p91.speed, v258, v259))
    fn65("distance", string.format("Distance: %.0f st", p91.distance), fn67(p91.distance, v262, v263))
    fn65("accel", string.format("Accel: %.0f st/s\194\178", p91.accel), fn66(p91.accel, v260, v261))
end
local function fn72(p92)
    local v284 = fn5(p92)
    local v285 = fn6()
    local v286 = LocalPlayer.Character
    local v287 = v286 and v286:FindFirstChild("HumanoidRootPart")
    if not v287 then
        return
    end
    local v288 = fn14()
    if v39.autoWindow then
        fn57(v288)
    end
    if v39.autoFps then
        fn8(v285)
    end
    if v39.autoClashConfig then
        fn58(v288, v285)
    end
    local v289 = fn7(v285)
    local v290 = {
        root = v287,
        ping = v288,
        fps = v285,
        fpsComp = v289,
        window = fn59(0, v285),
        targeted = false,
        inRange = false,
        radius = v253,
        impact = math.huge,
    }
    local v291 = fn15()
    fn39(v291, p92)
    if v291 and fn16(v291) then
        if v75.ball ~= v291 then
            fn22()
            v75.ball = v291
        end
        local v292 = fn27(v291, p92)
        local v293 = v287.Position - v291.Position
        local v294 = v293.Magnitude
        local v295 = v292 - v287.AssemblyLinearVelocity
        local v296 = v294 > 0 and math.max(0, v295:Dot(v293.Unit)) or 0
        local v297 = v292.Magnitude
        if v75.hasSample and p92 > 0 then
            v75.smooth = v75.smooth + (v297 - v75.smooth) * 0.5
            local v298 = math.clamp((v297 - v75.speed) / p92, 0, v256)
            v75.accel = v75.accel + (v298 - v75.accel) * v255
        else
            v75.smooth = v297
        end
        v75.speed = v297
        v75.hasSample = true
        local v299 = v39.curvePrediction and v75.smooth or v296
        local v300 = fn28(v294, v299, v75.accel)
        local v301 = fn59(v75.smooth, v285)
        v290.targeted = true
        v290.distance = v294
        v290.speed = v297
        v290.accel = v75.accel
        v290.impact = v300
        v290.window = v301
        v290.inRange = v300 <= v301
        v290.radius = math.clamp(fn69(v299, v75.accel, v301), v253, v254)
        v75.lastImpact = v300
        v75.pos = v291.Position
    else
        fn22()
    end
    fn26(v287)
    local v302 = false
    if v39.autoParry then
        local v303 = v39.autoClash and v71 and v39.clashPriority
        if not v303 then
            if v291 and v291 ~= v66 then
                fn41(v291)
            end
            if v291 and fn16(v291) and not v68 then
                local v304 = fn60(v291, v287)
                if v304 then
                    local v305 = os.clock()
                    if v291 == v70 and (v305 - v69) < v39.sameBallLockout then
                        v304 = false
                    end
                end
                if v304 and v75.smooth > 1 then
                    local v306 = v290.impact
                        or fn28((v291.Position - v287.Position).Magnitude, v75.smooth, v75.accel)
                    if v306 <= v290.window then
                        if math.random() <= (v39.parryAccuracy / 100) then
                            fn21()
                            v302 = true
                            v68 = true
                            v70 = v291
                            v69 = os.clock()
                        end
                    end
                end
            end
        end
    end
    if v39.autoClash and v71 and not v302 then
        local v307 = os.clock()
        local v308 = v22[v39.clashSpamMode] or 0.10
        if v307 - v73 >= v308 then
            fn21()
            v302 = true
            v73 = v307
        end
    end
    if v39.abilityCounter and v111.active and not v302 and v291 and fn16(v291) then
        local v309 = v290.impact or math.huge
        if v309 <= v290.window and not v68 then
            fn21()
            v68 = true
            v70 = v291
            v69 = os.clock()
        end
    end
    if v39.orbOn then
        fn70(v290)
    end
    if v39.orbOn or v39.showImpactTime then
        fn71(v290)
    end
    local v310 = fn11()
    if v310 then
        if v39.walkEnabled then
            v310.WalkSpeed = v39.walkSpeed
        end
        if v39.jumpEnabled then
            v310.UseJumpPower = true
            v310.JumpPower = v39.jumpPower
        end
    end
end
local v311 = nil
local function fn73()
    local v312 = v39.autoParry
        or v39.autoClash
        or v39.abilityCounter
        or v39.walkEnabled
        or v39.jumpEnabled
        or v39.orbOn
        or v39.showImpactTime
    if v312 and not v311 then
        v311 = RunService.RenderStepped:Connect(function(p93)
            local v313, v314 = pcall(fn72, p93)
            if not v313 and v39.orbDebug then
                warn("[LexMess] " .. tostring(v314))
            end
        end)
        fn9(v311)
    elseif not v312 and v311 then
        v311:Disconnect()
        v311 = nil
        fn22()
        v71 = false
        fn37()
        fn29()
    end
end
local v315 = WindUI:CreateWindow({
    Title = "brgao BLADE",
    Icon = "zap",
    Author = "v.0.2.0259 by LEX",
    Folder = "LexBladesHub",
    Size = UDim2.fromOffset(600, 720),
    Theme = "Dark",
})
local v316 = v315.ConfigManager
local v317 = v316:CreateConfig("main")
local v318 = v315:Tab({ Title = "Auto Parry", Icon = "swords" })
local v319 = v315:Tab({ Title = "Visuals", Icon = "eye" })
local v320 = v315:Tab({ Title = "Social", Icon = "users" })
local v321 = v315:Tab({ Title = "Unlocks", Icon = "lock-open" })
local v322 = v315:Tab({ Title = "Movement", Icon = "footprints" })
local v323 = v315:Tab({ Title = "Misc", Icon = "settings" })
local v324 = {
    enabled = false,
    billboardsEnabled = true,
    known = {},
    leftUsers = {},
    replyCooldowns = {},
    lastOutboundReply = 0,
    conns = {},
    chatHooked = false,
    prevChatCallback = nil,
    playerWatchConns = {},
    seenMessages = {},
    billboardAnimConn = nil,
}
local v325 = { [7295943857] = "C", LvLeX0 }
local v326 = {
    ["C"] = {
        name = "LB CREATOR",
        color = Color3.fromRGB(255, 215, 0),
        rank = 5,
        textSize = 30,
        gradient = true,
        pulse = { speed = 3, min = 28, max = 32 },
        glowBox = {
            enabled = true,
            transparencyMin = 0.35,
            transparencyMax = 0.55,
            strokeTransparency = 0.1,
        },
        particles = {
            texture = "rbxasset://textures/particles/sparkles_main.dds",
            color = Color3.fromRGB(255, 215, 0),
            rate = 25,
            lifetime = 2.5,
            speed = 4,
            size = NumberSequence.new(0.6),
            spread = 60,
        },
    },
    ["A"] = {
        name = "LB ADMIN",
        color = Color3.fromRGB(255, 60, 60),
        rank = 4,
        textSize = 28,
        gradient = false,
        pulse = { speed = 2.5, min = 26, max = 29 },
        glowBox = {
            enabled = true,
            transparencyMin = 0.45,
            transparencyMax = 0.65,
            strokeTransparency = 0.2,
        },
        particles = {
            texture = "rbxasset://textures/particles/sparkles_main.dds",
            color = Color3.fromRGB(255, 60, 60),
            rate = 15,
            lifetime = 2,
            speed = 3,
            size = NumberSequence.new(0.5),
            spread = 45,
        },
    },
    ["M"] = {
        name = "LB MOD",
        color = Color3.fromRGB(180, 120, 255),
        rank = 3,
        textSize = 26,
        gradient = false,
        pulse = { speed = 2, min = 24, max = 27 },
        glowBox = {
            enabled = true,
            transparencyMin = 0.55,
            transparencyMax = 0.75,
            strokeTransparency = 0.3,
        },
        particles = {
            texture = "rbxasset://textures/particles/sparkles_main.dds",
            color = Color3.fromRGB(180, 120, 255),
            rate = 10,
            lifetime = 1.8,
            speed = 2.5,
            size = NumberSequence.new(0.4),
            spread = 40,
        },
    },
    ["T"] = {
        name = "LB TESTER",
        color = Color3.fromRGB(80, 220, 100),
        rank = 2,
        textSize = 25,
        gradient = false,
        pulse = { speed = 1.5, min = 23, max = 25 },
        glowBox = { enabled = false },
        particles = {
            texture = "rbxasset://textures/particles/sparkles_main.dds",
            color = Color3.fromRGB(80, 220, 100),
            rate = 5,
            lifetime = 1.4,
            speed = 1.8,
            size = NumberSequence.new(0.3),
            spread = 30,
        },
    },
    ["U"] = {
        name = "LB USER",
        color = Color3.fromRGB(190, 190, 190),
        rank = 1,
        textSize = 24,
        gradient = false,
        pulse = nil,
        glowBox = { enabled = false },
        particles = nil,
    },
}
local v327 = "0259"
local v328 = "!lb-"
local v329 = "^!lb%-(%d%d%d%d)%-(%a)$"
local function fn74()
    return v325[LocalPlayer.UserId] or "U"
end
local function fn75(p94)
    return v326[p94] or v326["U"]
end
local function fn76(p95, p96)
    local v330 = v325[p95] or "U"
    if p96 ~= "U" and p96 ~= v330 and v39.orbDebug then
        warn(
            string.format(
                "[Presence] Rejected tier claim '%s' from UserId %d (verified: %s)",
                tostring(p96),
                p95,
                v330
            )
        )
    end
    return v330
end
local function fn77()
    return v328 .. v327 .. "-" .. fn74()
end
local function fn78(p97)
    return type(p97) == "string" and p97:sub(1, #v328) == v328
end
local fn79, fn80, fn81, fn82
local v331 = {}
local function fn83(p98)
    if not p98 then
        return
    end
    v331[p98.Name] = nil
    local v332 = p98.Character
    if not v332 then
        return
    end
    local v333 = v332:FindFirstChild("Head")
    if not v333 then
        return
    end
    local v334 = v333:FindFirstChild("LexBladePresence")
    if v334 then
        v334:Destroy()
    end
    local v335 = v333:FindFirstChild("LexBladeParticles")
    if v335 then
        v335:Destroy()
    end
end
local function fn84(p99, p100)
    if not v324.billboardsEnabled then
        return
    end
    if not p99 then
        return
    end
    local v336 = p99.Character
    if not v336 then
        return
    end
    local v337 = v336:FindFirstChild("Head")
    if not v337 then
        return
    end
    fn83(p99)
    local v338 = fn75(p100)
    local v339 = Instance.new("BillboardGui")
    v339.Name = "LexBladePresence"
    v339.Size = UDim2.new(0, 280, 0, 84)
    v339.StudsOffset = Vector3.new(0, 3.6, 0)
    v339.AlwaysOnTop = true
    v339.LightInfluence = 0
    v339.Adornee = v337
    v339.Parent = v337
    local v340 = nil
    if v338.glowBox and v338.glowBox.enabled then
        v340 = Instance.new("Frame")
        v340.Name = "GlowBox"
        v340.Size = UDim2.new(0, 250, 0, 76)
        v340.Position = UDim2.new(0.5, 0, 0.5, 0)
        v340.AnchorPoint = Vector2.new(0.5, 0.5)
        v340.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        v340.BackgroundTransparency = v338.glowBox.transparencyMax
        v340.BorderSizePixel = 0
        v340.Parent = v339
        local v341 = Instance.new("UICorner")
        v341.CornerRadius = UDim.new(0, 10)
        v341.Parent = v340
        local v342 = Instance.new("UIStroke")
        v342.Color = v338.color
        v342.Thickness = 2
        v342.Transparency = v338.glowBox.strokeTransparency
        v342.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        v342.Parent = v340
    end
    local v343 = Instance.new("TextLabel")
    v343.Name = "TierLabel"
    v343.Size = UDim2.new(1, 0, 0, 46)
    v343.Position = UDim2.new(0, 0, 0, 4)
    v343.BackgroundTransparency = 1
    v343.Text = v338.name
    v343.TextColor3 = v338.color
    v343.TextStrokeTransparency = 0
    v343.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    v343.Font = Enum.Font.GothamBlack
    v343.TextSize = v338.textSize
    v343.Parent = v339
    local v344 = nil
    if v338.gradient then
        v344 = Instance.new("UIGradient")
        v344.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 215, 0)),
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 180)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 170, 0)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 255, 180)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 215, 0)),
        })
        v344.Parent = v343
        v343.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    local v345 = Instance.new("TextLabel")
    v345.Name = "NameLabel"
    v345.Size = UDim2.new(1, 0, 0, 26)
    v345.Position = UDim2.new(0, 0, 0, 50)
    v345.BackgroundTransparency = 1
    v345.Text = p99.Name
    v345.TextColor3 = Color3.fromRGB(240, 240, 240)
    v345.TextStrokeTransparency = 0
    v345.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    v345.Font = Enum.Font.GothamBold
    v345.TextSize = 18
    v345.Parent = v339
    if v338.particles then
        local v346 = v337:FindFirstChild("LexBladeParticles")
        if v346 then
            v346:Destroy()
        end
        local v347 = Instance.new("Attachment")
        v347.Name = "LexBladeParticles"
        v347.Position = Vector3.new(0, 1.8, 0)
        v347.Parent = v337
        local v348 = Instance.new("ParticleEmitter")
        v348.Name = "TierParticles"
        v348.Texture = v338.particles.texture
        v348.Color = ColorSequence.new(v338.particles.color)
        v348.Size = v338.particles.size
        v348.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0.0, 1),
            NumberSequenceKeypoint.new(0.15, 0.2),
            NumberSequenceKeypoint.new(0.85, 0.2),
            NumberSequenceKeypoint.new(1.0, 1),
        })
        v348.Lifetime = NumberRange.new(v338.particles.lifetime)
        v348.Rate = v338.particles.rate
        v348.Speed = NumberRange.new(v338.particles.speed)
        v348.SpreadAngle = Vector2.new(v338.particles.spread, v338.particles.spread)
        v348.LightEmission = 1
        v348.Rotation = NumberRange.new(-180, 180)
        v348.RotSpeed = NumberRange.new(-90, 90)
        v348.Parent = v347
    end
    v331[p99.Name] = {
        gui = v339,
        tierLabel = v343,
        nameLabel = v345,
        gradient = v344,
        glowBox = v340,
        style = v338,
        startTime = os.clock(),
    }
end
local function fn85()
    if v324.billboardAnimConn then
        return
    end
    v324.billboardAnimConn = RunService.Heartbeat:Connect(function()
        local v349 = os.clock()
        for v350, v351 in pairs(v331) do
            if not Players:FindFirstChild(v350) or not v351.gui or not v351.gui.Parent then
                v331[v350] = nil
            else
                local v352 = v351.style
                if v352.pulse and v351.tierLabel and v351.tierLabel.Parent then
                    local v353 = v349 - v351.startTime
                    local v354 = (math.sin(v353 * v352.pulse.speed) + 1) / 2
                    v351.tierLabel.TextSize = v352.pulse.min + (v352.pulse.max - v352.pulse.min) * v354
                end
                if v351.gradient and v351.gradient.Parent then
                    v351.gradient.Rotation = (v349 * 120) % 360
                end
                if v351.glowBox and v351.glowBox.Parent then
                    local v355 = v349 - v351.startTime
                    local v356 = (math.sin(v355 * 1.8) + 1) / 2
                    local v357 = v352.glowBox.transparencyMin or 0.5
                    local v358 = v352.glowBox.transparencyMax or 0.7
                    v351.glowBox.BackgroundTransparency = v357 + (v358 - v357) * v356
                end
            end
        end
    end)
    table.insert(v324.conns, v324.billboardAnimConn)
end
local function fn86()
    if v324.billboardAnimConn then
        pcall(function()
            v324.billboardAnimConn:Disconnect()
        end)
        v324.billboardAnimConn = nil
    end
end
local function fn87(p101)
    if v324.playerWatchConns[p101.Name] then
        return
    end
    if p101.Character and p101.Character:FindFirstChild("Head") then
        local v359 = v324.known[p101.Name] and v324.known[p101.Name].tier or "U"
        fn84(p101, v359)
    end
    local v360 = p101.CharacterAdded:Connect(function(p102)
        p102:WaitForChild("Head", 10)
        task.wait(0.5)
        if v324.enabled and v324.known[p101.Name] then
            fn84(p101, v324.known[p101.Name].tier)
        end
    end)
    v324.playerWatchConns[p101.Name] = v360
end
local function fn88(p103)
    local v361 = v324.playerWatchConns[p103]
    if v361 then
        pcall(function()
            v361:Disconnect()
        end)
        v324.playerWatchConns[p103] = nil
    end
end
fn80 = function(p104, p105)
    if not v324.known[p104] then
        return
    end
    v324.known[p104] = nil
    local v362 = Players:FindFirstChild(p104)
    if v362 then
        fn83(v362)
    end
    fn88(p104)
    if not p105 then
        pcall(function()
            WindUI:Notify({
                Title = p104 .. " has left",
                Content = "Presence broadcast ended",
                Duration = 4,
                Icon = "user-minus",
            })
        end)
    end
end
fn79 = function(p106, p107)
    if not p106 or p106 == "" then
        return false
    end
    if p106 == LocalPlayer.Name then
        return false
    end
    local v363 = Players:FindFirstChild(p106)
    if not v363 then
        return false
    end
    local v364 = os.clock()
    local v365 = v324.known[p106]
    local v366 = v365 ~= nil
    if v366 and (v364 - v365.lastSeen) < 5 then
        v365.lastSeen = v364
        return false
    end
    local v367 = fn75(p107)
    v324.known[p106] = {
        tier = p107,
        tierName = v367.name,
        color = v367.color,
        rank = v367.rank,
        lastSeen = v364,
    }
    fn87(v363)
    fn84(v363, p107)
    if not v366 then
        pcall(function()
            WindUI:Notify({
                Title = string.format("%s is using Lex Blade", p106),
                Content = string.format("Tier: %s", v367.name),
                Duration = 6,
                Icon = "user-check",
            })
        end)
    end
    return not v366
end
fn81 = function(p108)
    task.spawn(function()
        pcall(function()
            local v368 = TextChatService:FindFirstChild("TextChannels")
            local v369 = v368 and v368:FindFirstChild("RBXGeneral")
            if v369 then
                v369:SendAsync(p108)
            end
        end)
    end)
end
fn82 = function()
    fn81(v328 .. v327 .. "-L")
end
local function fn89(p109, p110)
    if not p109 then
        return
    end
    local v370 = Players:FindFirstChild(p109)
    if not v370 then
        if v324.known[p109] then
            fn80(p109, true)
        end
        v324.leftUsers[p109] = true
        v324.replyCooldowns[p109] = nil
        return
    end
    if p110 == "L" then
        if v324.known[p109] then
            fn80(p109, false)
        end
        v324.leftUsers[p109] = true
        v324.replyCooldowns[p109] = nil
        return
    end
    v324.leftUsers[p109] = nil
    p110 = fn76(v370.UserId, p110)
    local v371 = fn79(p109, p110)
    local v372 = os.clock()
    local v373 = v324.replyCooldowns[p109] or 0
    local v374 = (v372 - (v324.lastOutboundReply or 0)) > 3
    if v371 and (v372 - v373) > 10 and v374 then
        v324.replyCooldowns[p109] = v372
        v324.lastOutboundReply = v372
        local v375 = 0.8 + math.random() * 3.5
        task.delay(v375, function()
            if v324.enabled then
                fn81(fn77())
            end
        end)
    end
end
local function fn90()
    if v324.chatHooked then
        return
    end
    v324.chatHooked = true
    pcall(function()
        v324.prevChatCallback = TextChatService.OnIncomingMessage
        TextChatService.OnIncomingMessage = function(p111)
            local v376 = p111.Text or ""
            if fn78(v376) then
                if v324.enabled then
                    local v377, v378 = v376:match(v329)
                    if v377 == v327 and v378 then
                        local v379 = nil
                        pcall(function()
                            local v380 = p111.TextSource
                            if v380 and v380.UserId then
                                local v381 = Players:GetPlayerByUserId(v380.UserId)
                                if v381 then
                                    v379 = v381.Name
                                end
                            end
                        end)
                        if v379 then
                            task.spawn(fn89, v379, v378)
                        end
                    end
                end
                local v382 = Instance.new("TextChatMessageProperties")
                v382.Text = ""
                return v382
            end
            if v324.prevChatCallback then
                return v324.prevChatCallback(p111)
            end
        end
    end)
    pcall(function()
        local v383 = TextChatService.MessageReceived:Connect(function(p112)
            local v384 = p112.Text or ""
            if fn78(v384) and v324.enabled then
                local v385 = tostring(p112.MessageId or p112.Text)
                if v324.seenMessages[v385] then
                    return
                end
                v324.seenMessages[v385] = true
                if math.random(1, 20) == 1 then
                    v324.seenMessages = {}
                end
                local v386, v387 = v384:match(v329)
                if v386 == v327 and v387 then
                    local v388 = nil
                    pcall(function()
                        local v389 = p112.TextSource
                        if v389 and v389.UserId then
                            local v390 = Players:GetPlayerByUserId(v389.UserId)
                            if v390 then
                                v388 = v390.Name
                            end
                        end
                    end)
                    if v388 then
                        task.spawn(fn89, v388, v387)
                    end
                end
            end
        end)
        table.insert(v324.conns, v383)
    end)
    pcall(function()
        Players.PlayerRemoving:Connect(function(p113)
            if v324.known[p113.Name] then
                fn80(p113.Name, false)
            end
        end)
    end)
end
fn90()
fn1("Auto Parry", function()
    v318:Section({ Title = "Auto Parry" })
    v318:Toggle({
        Title = "Auto Parry",
        Flag = "autoParry",
        Value = false,
        Callback = function(p114)
            v39.autoParry = p114
            if p114 then
                local v391 = fn15()
                if v391 then
                    fn41(v391)
                end
            else
                v68 = false
            end
            fn73()
        end,
    })
    v318:Dropdown({
        Title = "Parry Method",
        Values = { "Dual", "Mouse", "Remote", "Keypress" },
        Value = "Dual",
        Flag = "parryMethod",
        Callback = function(p115)
            v39.parryMethod = p115
        end,
    })
    v318:Slider({
        Title = "Parry Accuracy (%)",
        Value = { Min = 0, Max = 100, Default = 100 },
        Step = 5,
        Flag = "parryAccuracy",
        Callback = function(p116)
            v39.parryAccuracy = p116
        end,
    })
    v318:Section({ Title = "Timing Window" })
    local v392 = {}
    v318:Toggle({
        Title = "Auto-Window",
        Flag = "autoWindow",
        Value = false,
        Callback = function(p117)
            v39.autoWindow = p117
            if p117 then
                fn57(fn14())
            end
            for v393, v394 in pairs(v392) do
                pcall(function()
                    if p117 then
                        v394:Lock()
                    else
                        v394:Unlock()
                    end
                end)
            end
        end,
    })
    v318:Toggle({
        Title = "Dynamic Window",
        Flag = "useDynamicWindow",
        Value = true,
        Callback = function(p118)
            v39.useDynamicWindow = p118
        end,
    })
    v392.simpleRatio = v318:Slider({
        Title = "Simple Ratio",
        Value = { Min = 0.2, Max = 1.0, Default = 0.55 },
        Step = 0.05,
        Flag = "simpleRatio",
        Callback = function(p119)
            v39.simpleRatio = p119
        end,
    })
    v392.windowBase = v318:Slider({
        Title = "Window Base (s)",
        Value = { Min = 0.1, Max = 0.6, Default = 0.32 },
        Step = 0.01,
        Flag = "windowBase",
        Callback = function(p120)
            v39.windowBase = p120
        end,
    })
    v392.windowSpeedFac = v318:Slider({
        Title = "Window Speed Factor",
        Value = { Min = 0.0, Max = 0.002, Default = 0.00050 },
        Step = 0.00005,
        Flag = "windowSpeedFac",
        Callback = function(p121)
            v39.windowSpeedFac = p121
        end,
    })
    v392.windowMax = v318:Slider({
        Title = "Window Max (s)",
        Value = { Min = 0.2, Max = 0.8, Default = 0.45 },
        Step = 0.01,
        Flag = "windowMax",
        Callback = function(p122)
            v39.windowMax = p122
        end,
    })
    v392.windowMin = v318:Slider({
        Title = "Window Min (s)",
        Value = { Min = 0.05, Max = 0.4, Default = 0.16 },
        Step = 0.01,
        Flag = "windowMin",
        Callback = function(p123)
            v39.windowMin = p123
        end,
    })
    v392.useAutoPing = v318:Toggle({
        Title = "Add Ping To Window",
        Flag = "useAutoPing",
        Value = true,
        Callback = function(p124)
            v39.useAutoPing = p124
        end,
    })
    v318:Section({ Title = "FPS Sorter" })
    local v395 = {}
    v318:Toggle({
        Title = "Auto-FPS",
        Flag = "autoFps",
        Value = false,
        Callback = function(p125)
            v39.autoFps = p125
            if p125 then
                fn8(v41.smoothed)
            end
            for v396, v397 in pairs(v395) do
                pcall(function()
                    if p125 then
                        v397:Lock()
                    else
                        v397:Unlock()
                    end
                end)
            end
        end,
    })
    v318:Toggle({
        Title = "FPS Comp",
        Flag = "useFpsComp",
        Value = true,
        Callback = function(p126)
            v39.useFpsComp = p126
        end,
    })
    v318:Toggle({
        Title = "Fast Spike Response",
        Flag = "fastSpikeResponse",
        Value = true,
        Callback = function(p127)
            v39.fastSpikeResponse = p127
        end,
    })
    v395.fpsCompFactor = v318:Slider({
        Title = "FPS Comp Factor",
        Value = { Min = 0.0, Max = 0.10, Default = 0.03 },
        Step = 0.005,
        Flag = "fpsCompFactor",
        Callback = function(p128)
            v39.fpsCompFactor = p128
        end,
    })
    v395.fpsCompMax = v318:Slider({
        Title = "FPS Comp Max Cap (s)",
        Value = { Min = 0.02, Max = 0.30, Default = 0.12 },
        Step = 0.01,
        Flag = "fpsCompMax",
        Callback = function(p129)
            v39.fpsCompMax = p129
        end,
    })
    v395.fpsOverride = v318:Slider({
        Title = "FPS Override",
        Value = { Min = 0, Max = 360, Default = 0 },
        Step = 5,
        Flag = "fpsOverride",
        Callback = function(p130)
            v39.fpsOverride = p130
        end,
    })
    v318:Section({ Title = "Camera Curve Effect" })
    v318:Dropdown({
        Title = "Curve Effect",
        Values = { "Off", "Right", "Left", "Up", "Down", "Random", "Camera" },
        Value = "Off",
        Flag = "curveDeflectMode",
        Callback = function(p131)
            v39.curveDeflectMode = p131
            if p131 == "Off" then
                fn29()
            end
        end,
    })
    v318:Slider({
        Title = "Camera Effect Strength (%)",
        Value = { Min = 0, Max = 100, Default = 35 },
        Step = 5,
        Flag = "curveDeflectStrength",
        Callback = function(p132)
            v39.curveDeflectStrength = p132
        end,
    })
    v318:Button({
        Title = "Test Camera Effect",
        Callback = function()
            if v39.curveDeflectMode == "Off" then
                fn13("Camera Curve", "Select a mode first")
                return
            end
            fn30(v39.curveDeflectMode)
        end,
    })
    v318:Section({ Title = "Clash Settings" })
    local v398 = {}
    v318:Toggle({
        Title = "Auto Clash",
        Flag = "autoClash",
        Value = false,
        Callback = function(p133)
            v39.autoClash = p133
            if not p133 then
                v71 = false
                v74 = {}
            end
            fn73()
        end,
    })
    v318:Toggle({
        Title = "Auto-Configure Clash",
        Flag = "autoClashConfig",
        Value = false,
        Callback = function(p134)
            v39.autoClashConfig = p134
            if p134 then
                fn58(fn14(), v41.smoothed)
            end
            for v399, v400 in pairs(v398) do
                pcall(function()
                    if p134 then
                        v400:Lock()
                    else
                        v400:Unlock()
                    end
                end)
            end
        end,
    })
    v398.clashDetectRadius = v318:Slider({
        Title = "Clash Detection Radius (studs)",
        Value = { Min = 10, Max = 40, Default = 20 },
        Step = 1,
        Flag = "clashDetectRadius",
        Callback = function(p135)
            v39.clashDetectRadius = p135
        end,
    })
    v398.clashExchangeThreshold = v318:Slider({
        Title = "Exchange Threshold",
        Value = { Min = 2, Max = 8, Default = 3 },
        Step = 1,
        Flag = "clashExchangeThreshold",
        Callback = function(p136)
            v39.clashExchangeThreshold = p136
        end,
    })
    v398.clashSpamMode = v318:Dropdown({
        Title = "Clash Spam Speed",
        Values = {
            "Legit",
            "Pro",
            "Master",
            "Machine",
        },
        Value = "Pro",
        Flag = "clashSpamMode",
        Callback = function(p137)
            v39.clashSpamMode = p137
        end,
    })
    v398.clashPriority = v318:Toggle({
        Title = "Clash Priority",
        Flag = "clashPriority",
        Value = true,
        Callback = function(p138)
            v39.clashPriority = p138
        end,
    })
    v318:Section({ Title = "Ability Counter" })
    v318:Toggle({
        Title = "Ability Counter",
        Flag = "abilityCounter",
        Value = false,
        Callback = function(p139)
            v39.abilityCounter = p139
            if not p139 then
                fn37()
            end
            fn73()
        end,
    })
    v318:Slider({
        Title = "Speed Spike Threshold (%)",
        Value = { Min = 20, Max = 100, Default = 50 },
        Step = 5,
        Flag = "abilitySpikeThreshold",
        Callback = function(p140)
            v39.abilitySpikeThreshold = p140 / 100
        end,
    })
    v318:Section({ Title = "Filters" })
    v318:Slider({
        Title = "Max Parry Distance (studs)",
        Value = { Min = 0, Max = 200, Default = 100 },
        Step = 5,
        Flag = "maxParryDistance",
        Callback = function(p141)
            v39.maxParryDistance = p141
        end,
    })
    v318:Slider({
        Title = "Max Parry Angle (degrees)",
        Value = { Min = 30, Max = 180, Default = 180 },
        Step = 5,
        Flag = "maxParryAngle",
        Callback = function(p142)
            v39.maxParryAngle = p142
        end,
    })
    v318:Slider({
        Title = "Same-Ball Lockout (ms)",
        Value = { Min = 0, Max = 300, Default = 80 },
        Step = 5,
        Flag = "sameBallLockout",
        Callback = function(p143)
            v39.sameBallLockout = p143 / 1000
        end,
    })
    v318:Toggle({
        Title = "Curve Prediction",
        Flag = "curvePrediction",
        Value = true,
        Callback = function(p144)
            v39.curvePrediction = p144
        end,
    })
end)
fn1("Visuals", function()
    v319:Toggle({
        Title = "Parry Orb",
        Flag = "orbOn",
        Value = false,
        Callback = function(p145)
            v39.orbOn = p145
            if p145 then
                fn62()
                v242, v243, v244 = fn61()
            else
                fn62()
            end
            fn73()
        end,
    })
    v319:Toggle({
        Title = "Overhead Stats",
        Flag = "showImpactTime",
        Value = true,
        Callback = function(p146)
            v39.showImpactTime = p146
            fn73()
        end,
    })
end)
fn1("Social", function()
    v320:Section({ Title = "Presence" })
    v320:Paragraph({
        Title = "What This Does",
        Desc = "When enabled, other Lex Blade users in the same server are notified that you are here. You'll be notified when they are present too, and their tier will display above their head with escalating visual effects.",
    })
    v320:Toggle({
        Title = "Broadcast Presence",
        Desc = "Announce your presence to other Lex Blade users in this server",
        Flag = "presenceEnabled",
        Value = false,
        Callback = function(p147)
            v324.enabled = p147
            v39.presenceEnabled = p147
            if p147 then
                v324.leftUsers = {}
                v324.replyCooldowns = {}
                v324.lastOutboundReply = 0
                fn85()
                task.spawn(function()
                    task.wait(1)
                    fn81(fn77())
                end)
                fn13("Presence", "Enabled. Broadcasting as " .. fn75(fn74()).name .. ".")
            else
                fn82()
                for v401, v402 in pairs(v324.known) do
                    local v403 = Players:FindFirstChild(v401)
                    if v403 then
                        fn83(v403)
                    end
                    fn88(v401)
                end
                v324.known = {}
                fn13("Presence", "Disabled.")
            end
        end,
    })
    v320:Toggle({
        Title = "Show Billboard Above Head",
        Desc = "Display the tier label above detected users' heads",
        Flag = "billboardEnabled",
        Value = true,
        Callback = function(p148)
            v324.billboardsEnabled = p148
            if p148 then
                for v404, v405 in pairs(v324.known) do
                    local v406 = Players:FindFirstChild(v404)
                    if v406 then
                        fn84(v406, v405.tier)
                    end
                end
            else
                for v407, v408 in pairs(v324.known) do
                    local v409 = Players:FindFirstChild(v407)
                    if v409 then
                        fn83(v409)
                    end
                end
            end
        end,
    })
    v320:Section({ Title = "Detected Users" })
    local v410 = v320:Paragraph({ Title = "Active Users", Desc = "No users detected." })
    task.spawn(function()
        while task.wait(2) do
            local v411 = {}
            for v412, v413 in pairs(v324.known) do
                table.insert(v411, { name = v412, data = v413 })
            end
            table.sort(v411, function(p149, p150)
                if p149.data.rank ~= p150.data.rank then
                    return p149.data.rank > p150.data.rank
                end
                return p149.name:lower() < p150.name:lower()
            end)
            local v414 = {}
            for v415, v416 in ipairs(v411) do
                table.insert(v414, string.format("%s  \226\128\162  %s", v416.name, v416.data.tierName))
            end
            local v417 = (#v414 == 0) and "No users detected." or table.concat(v414, "\n")
            pcall(function()
                if v410 and type(v410.SetDesc) == "function" then
                    v410:SetDesc(v417)
                elseif v410 then
                    v410.Desc = v417
                end
            end)
        end
    end)
end)
pcall(function()
    table.insert(
        v49,
        game:BindToClose(function()
            if v324.enabled then
                pcall(fn82)
                task.wait(0.3)
            end
        end)
    )
end)
fn1("Unlocks setup", function()
    pcall(function()
        v321:Lock()
    end)
end)
local v418 = {
    rarity = "Secret",
    searchText = "",
    sword = nil,
    swordDropdown = nil,
    rarityDropdown = nil,
    searchInput = nil,
}
local v419 = false
local fn91
fn1("Unlocks loading UI", function()
    local v420 = v321:Section({
        Title = "Loading Assets",
    })
    v420:Paragraph({
        Title = "Please Wait",
        Desc = "Enumerating the sword collection and classifying by rarity. The tab will unlock automatically when finished.",
    })
    local v421 = nil
    if type(v321.ProgressBar) == "function" then
        v421 = v321:ProgressBar({
            Title = "Sword Data",
            Desc = "Preparing list...",
            Value = { Min = 0, Max = 100, Default = 0 },
            ShowValue = true,
        })
    end
    local function fn92()
        v146.enumerateSwords()
        local v422 = v146.allSwordNames or {}
        local v423 = #v422
        local v424 = {}
        for v425, v426 in ipairs(v35) do
            v424[v426] = {}
        end
        v424["Other"] = {}
        local v427, v428 = pcall(function()
            return require(ReplicatedStorage.Shared.ReplicatedInstances.Swords)
        end)
        if v427 and v428 and v423 > 0 then
            local v429 = 0
            for v430 = 1, v423, v36 do
                local v431 = math.min(v430 + v36 - 1, v423)
                for v432 = v430, v431 do
                    local v433 = v422[v432]
                    local v434 = nil
                    pcall(function()
                        v434 = v428:GetSword(v433)
                    end)
                    local v435 = v434 and v434.Rarity
                    if v435 and v424[v435] then
                        table.insert(v424[v435], v433)
                    else
                        table.insert(v424["Other"], v433)
                    end
                end
                v429 = v431
                if v421 then
                    local v436 = math.floor(v429 / v423 * 100)
                    pcall(function()
                        v421:Set(v436)
                        v421.Desc = string.format("Classified %d / %d swords", v429, v423)
                    end)
                end
                task.wait(0.02)
            end
        end
        for v437, v438 in pairs(v424) do
            table.sort(v438)
        end
        v146.swordsByRarity = v424
        return v423
    end
    local function fn93()
        v321:Section({ Title = "Locker Visibility" })
        v321:Paragraph({
            Title = "What This Does",
            Desc = "Every unowned cosmetic becomes unlocked for you. It will appear within your locker.",
        })
        v321:Toggle({
            Title = "Unlock All Swords",
            Flag = "unlockSwords",
            Value = false,
            Callback = function(p151)
                v39.unlockSwords = p151
            end,
        })
        v321:Toggle({
            Title = "Unlock All Explosions",
            Flag = "unlockExplosions",
            Value = false,
            Callback = function(p152)
                v39.unlockExplosions = p152
            end,
        })
        v321:Button({
            Title = "Apply Items",
            Desc = "Items become visible within your locker",
            Callback = function()
                local v439, v440 = v146.init(true)
                if v439 then
                    fn13("Unlocks", tostring(v440))
                else
                    fn13("Unlocks", "Failed: " .. tostring(v440))
                end
            end,
        })
        v321:Section({ Title = "Force Equip Sword" })
        v321:Paragraph({
            Title = "How To Use",
            Desc = "For some executors you will have to use this section, this is due to limitations. Simply search for your sword or search via drop down.",
        })
        v418.rarityDropdown = v321:Dropdown({
            Title = "Rarity Filter",
            Desc = "Narrows down the sword list by rarity",
            Values = {
                "Secret",
                "Unique",
                "Limited",
                "LimitedU",
                "Legendary",
                "Rare",
                "Duo",
                "Normal",
                "All",
            },
            Value = "Secret",
            Callback = function(p153)
                v418.rarity = p153
                fn91()
            end,
        })
        if type(v321.Input) == "function" then
            v418.searchInput = v321:Input({
                Title = "Search Swords",
                Desc = "Type part of a sword name to filter the list below",
                Callback = function(p154)
                    v418.searchText = p154 or ""
                    fn91()
                end,
            })
            pcall(function()
                v418.searchInput:SetPlaceholder("Search swords...")
            end)
        end
        v418.swordDropdown = v321:Dropdown({
            Title = "Sword",
            Desc = "Use the rarity filter and search box above to narrow this list",
            Values = { "Loading..." },
            Value = "Loading...",
            Callback = function(p155)
                v418.sword = p155
            end,
        })
        v321:Button({
            Title = "Equip Selected Sword",
            Desc = "Applies the chosen sword visually to your character",
            Callback = function()
                local v441 = v418.sword
                if not v441 or v441 == "Loading..." or v441:sub(1, 1) == "(" then
                    fn13("Force Equip", "Pick a sword first")
                    return
                end
                local v442, v443 = v146.forceEquipSword(v441)
                if v442 then
                    fn48(v441)
                    fn13("Force Equip", "Equipped: " .. v441)
                else
                    fn13("Force Equip", "Failed: " .. tostring(v443))
                end
            end,
        })
        v321:Toggle({
            Title = "Auto Re-equip on Respawn",
            Desc = "Reapplies your last Force Equipped sword when you respawn.",
            Flag = "autoReequip",
            Value = false,
            Callback = function(p156)
                v39.autoReequip = p156
                if p156 then
                    fn50()
                    fn13("Auto Re-equip", "Enabled.")
                else
                    fn51()
                    fn13("Auto Re-equip", "Disabled.")
                end
            end,
        })
        v321:Button({
            Title = "Clear Local Override",
            Desc = "Removes the currently shown sword",
            Callback = function()
                local v444 = LocalPlayer.Character
                if not v444 then
                    return
                end
                for v445, v446 in ipairs(v444:GetChildren()) do
                    if v446:GetAttribute("_equippedSword") then
                        v446:Destroy()
                    end
                end
                v39.lastEquippedSword = "Base Sword"
                fn3(v4.filePath, "")
                fn13("Force Equip", "Local override cleared.")
            end,
        })
        v321:Section({ Title = "Info" })
        v321:Paragraph({
            Title = "Why Explosions Can't Be Equipped",
            Desc = "When you kill someone, the server picks your equipped explosion and broadcasts it to all clients. There's no client-side path to swap this. However, this isn't entirely impossible...",
        })
        v321:Paragraph({
            Title = "Why Locker Equip Button Doesn't Work",
            Desc = "Low level executors such as Solara, Real (ones I have tested) and others don't intercept an equip call when our hook intercepts it. That's why we use Force Equip instead. Although, not all executors need to",
        })
    end
    fn91 = function()
        if not v419 then
            return
        end
        local v447 = v146.getSwordsInRarity(v418.rarity)
        local v448 = v418.searchText
        local v449
        if v448 and v448 ~= "" then
            local v450 = v448:lower()
            v449 = {}
            for v451, v452 in ipairs(v447) do
                if v452:lower():find(v450, 1, true) then
                    table.insert(v449, v452)
                end
            end
        else
            v449 = v447
        end
        if #v449 == 0 then
            v418.sword = "(no swords match)"
            if v418.swordDropdown then
                pcall(function()
                    v418.swordDropdown:Refresh({ "(no swords match)" })
                end)
            end
            return
        end
        local v453
        if #v449 > v37 then
            v453 = {}
            for v454 = 1, v37 do
                v453[v454] = v449[v454]
            end
            v453[#v453 + 1] =
                string.format("(+ %d more \226\128\148 type more in Search to narrow)", #v449 - v37)
        else
            v453 = v449
        end
        v418.sword = v453[1]
        if v418.swordDropdown then
            pcall(function()
                v418.swordDropdown:Refresh(v453)
            end)
        end
    end
    task.spawn(function()
        local v455, v456 = pcall(function()
            local v457 = fn92()
            if v421 then
                pcall(function()
                    v421:Destroy()
                end)
            end
            if v420 then
                pcall(function()
                    v420:Destroy()
                end)
            end
            v419 = true
            fn93()
            fn91()
            pcall(function()
                v321:Unlock()
            end)
        end)
        if not v455 then
            warn("[LexBlade] Unlocks async failed: " .. tostring(v456))
        end
    end)
end)
fn1("Movement", function()
    v322:Toggle({
        Title = "Custom Walk Speed",
        Flag = "walkEnabled",
        Value = false,
        Callback = function(p157)
            v39.walkEnabled = p157
            fn73()
        end,
    })
    v322:Slider({
        Title = "Walk Speed",
        Value = { Min = 16, Max = 200, Default = 24 },
        Step = 1,
        Flag = "walkSpeed",
        Callback = function(p158)
            v39.walkSpeed = p158
        end,
    })
    v322:Toggle({
        Title = "Custom Jump Power",
        Flag = "jumpEnabled",
        Value = false,
        Callback = function(p159)
            v39.jumpEnabled = p159
            fn73()
        end,
    })
    v322:Slider({
        Title = "Jump Power",
        Value = { Min = 50, Max = 300, Default = 60 },
        Step = 1,
        Flag = "jumpPower",
        Callback = function(p160)
            v39.jumpPower = p160
        end,
    })
    v322:Toggle({
        Title = "Infinite Jump",
        Flag = "infJump",
        Value = false,
        Callback = function(p161)
            v39.infJump = p161
        end,
    })
end)
pcall(function()
    fn9(UserInputService.JumpRequest:Connect(function()
        if v39.infJump then
            local v458 = fn11()
            if v458 then
                v458:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end))
end)
fn1("Misc", function()
    v323:Toggle({
        Title = "Anti AFK",
        Flag = "antiAfk",
        Value = false,
        Callback = function(p162)
            v39.antiAfk = p162
            if p162 then
                fn52()
            else
                fn53()
            end
        end,
    })
    v323:Toggle({
        Title = "FPS Boost",
        Flag = "fpsBoost",
        Value = false,
        Callback = function(p163)
            v39.fpsBoost = p163
            if p163 then
                fn56()
            else
                fn55()
            end
        end,
    })
    v323:Section({ Title = "Config" })
    v323:Button({
        Title = "Save Config",
        Callback = function()
            v317:Save()
        end,
    })
    v323:Button({
        Title = "Load Config",
        Callback = function()
            v317:Load()
        end,
    })
    v323:Button({
        Title = "Rejoin Server",
        Callback = function()
            pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            end)
        end,
    })
    v323:Button({
        Title = "Unload Script",
        Callback = function()
            if v324.enabled then
                pcall(fn82)
                task.wait(0.3)
            end
            for v459, v460 in ipairs(v324.conns) do
                pcall(function()
                    v460:Disconnect()
                end)
            end
            v324.conns = {}
            for v461, v462 in pairs(v324.playerWatchConns) do
                fn88(v461)
            end
            fn86()
            v331 = {}
            fn10()
            fn62()
            fn64()
            fn29()
            fn51()
            fn53()
            fn55()
            pcall(function()
                RunService:UnbindFromRenderStep(v21)
            end)
            pcall(function()
                if v315 and type(v315.Destroy) == "function" then
                    v315:Destroy()
                end
            end)
            local function fn94(p164)
                if not p164 then
                    return
                end
                for v463, v464 in ipairs(p164:GetChildren()) do
                    if v464:IsA("ScreenGui") and v464.Name:lower():find("wind") then
                        pcall(function()
                            v464:Destroy()
                        end)
                    end
                end
            end
            fn94(LocalPlayer:FindFirstChild("PlayerGui"))
            fn94(CoreGui)
            if env.__LEXMESS_CLEANUP then
                pcall(env.__LEXMESS_CLEANUP)
            end
            print("[Lex Blade] Script unloaded.")
        end,
    })
end)
env.__LEXMESS_CLEANUP = function()
    env.__LEXMESS_LOADED = false
    if v324 and v324.enabled then
        pcall(fn82)
    end
    if v324 and v324.conns then
        for v465, v466 in ipairs(v324.conns) do
            pcall(function()
                v466:Disconnect()
            end)
        end
        v324.conns = {}
    end
    if v324 and v324.playerWatchConns then
        for v467, v468 in pairs(v324.playerWatchConns) do
            pcall(function()
                v468:Disconnect()
            end)
        end
        v324.playerWatchConns = {}
    end
    fn86()
    v331 = {}
    fn10()
    fn62()
    fn64()
    v71 = false
    fn37()
    fn29()
    fn51()
    fn53()
    fn55()
    pcall(function()
        RunService:UnbindFromRenderStep(v21)
    end)
    v74 = {}
    pcall(function()
        if v315 and type(v315.Destroy) == "function" then
            v315:Destroy()
        end
    end)
    local function fn95(p165)
        if not p165 then
            return
        end
        for v469, v470 in ipairs(p165:GetChildren()) do
            if v470:IsA("ScreenGui") and v470.Name:lower():find("wind") then
                pcall(function()
                    v470:Destroy()
                end)
            end
        end
    end
    fn95(LocalPlayer:FindFirstChild("PlayerGui"))
    fn95(CoreGui)
end
if next(v325) == nil then
    warn(
        "[LexBlade] TIER_TABLE is empty: every user, including creators, will show as LB USER. Add UserIds to enable higher tiers."
    )
end
if not v62 then
    task.spawn(function()
        task.wait(3)
        fn13("Auto Parry", "Keypress not supported. Mouse and Remote will work.")
    end)
end
if not v4.available then
    task.spawn(function()
        task.wait(3.5)
        fn13("Persistence", "Filesystem API unavailable. Last sword will not persist across sessions.")
    end)
end
fn13("Lex Blade", "Loaded. V.0.2.0259 ")
