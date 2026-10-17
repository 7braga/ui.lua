-- ═══════════════════════════════════════════════════════════
-- BRAGAO HUB v15 - Silent Aim FUSIONADO (Bragao + Michelle)
-- ═══════════════════════════════════════════════════════════
print("[1] Iniciando...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local CS = game:GetService("CollectionService")
local VU = game:GetService("VirtualUser")
local SS = game:GetService("SoundService")
local lp = Players.LocalPlayer
local cam = workspace.CurrentCamera
local Mouse = lp:GetMouse()
print("[2] Servicios OK")

local Config = {
    SilentAimPlayers = false, SilentAimNPCs = false,
    Prediction = false, PredictionAmount = 0.1,
    AutoKen = false, InfiniteJump = false,
    WalkSpeed = 16, AntiAFK = false,
}

-- ═══ AIM CONFIG (fusion) ═══
local AimConfig = {
    -- De Bragao (predicción avanzada)
    AimPart = "Head",
    PingCompensation = true,
    DistanceMultiplier = true,
    VisibleCheck = false,
    TargetLockDuration = 0.15,
    SmoothingSamples = 3,
    MaxVisibleRange = 800,
    
    -- De Michelle (cobertura)
    AimMode = "360",              -- "360" | "180" | "FOV"
    TargetPriority = "Nearest",   -- "Nearest" | "Low HP" | "HighestHP" | "Looking At Me" | "Lock Player"
    LockedPlayerName = nil,
    OverrideMouseHit = true,
    FaceTarget = true,
    ProtectSafeZone = true,
    ProtectForceField = true,
    
    -- Blacklist por categoría
    Blacklist = {
        Melee = { Z = false, X = false, C = false, V = false, F = false },
        Sword = { Z = false, X = false, C = false, V = false, F = false },
        Fruit = { Z = false, X = false, C = false, V = false, F = false, TAP = false },
        Gun   = { Z = false, X = false, C = false, V = false, F = false },
    },
    
    -- Soru (skill C)
    SoruEnabled = false,
    SoruRange = 300,
    SoruPriority = "Nearest",
    SoruFOVRadius = 150,
}

local State = {
    silentInstalled = false, autoKenRunning = false,
    infJumpConn = nil, PlayersPosition = nil, NPCPosition = nil,
    maxRange = 500, antiAFKRunning = false,
    currentTool = nil, currentToolCategory = "Melee",
    currentSkillKey = nil, lastSkillTime = 0,
    LockedTarget = nil, LockTime = 0,
    NPCLockedTarget = nil, NPCLockTime = 0,
    PosBuffer = {}, NPCPosBuffer = {},
    SoruTarget = nil, SoruPos = nil,
}

local CommE, CommF
pcall(function()
    local rem = RS:WaitForChild("Remotes", 5)
    if rem then
        CommE = rem:WaitForChild("CommE", 5)
        CommF = rem:WaitForChild("CommF_", 5)
    end
end)
print("[3] Remotes OK")

local FOV = {
    Enabled = false, Size = 160, Thickness = 1.6,
    Color = Color3.fromRGB(0, 255, 140),
    EnemyColor = Color3.fromRGB(255, 70, 70),
    HighlightInFOV = true,
}

local Hitbox = { Enabled = false, Size = 10, Transparency = 0.7, EnemyOnly = true, NPCs = false }

local NearestEnemy = {
    Enabled = false, Color = Color3.fromRGB(255, 70, 70),
    ShowDistance = true, ShowName = true,
    ShowOnScreen = true, ShowOffScreen = true,
    MaxRange = 500, DotRadius = 40,
}

local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://6895079853"
clickSound.Volume = 0.35
clickSound.PlaybackSpeed = 1.05
clickSound.Parent = SS
local function playClick()
    pcall(function()
        local c = clickSound:Clone(); c.Parent = SS; c:Play()
        task.delay(1, function() c:Destroy() end)
    end)
end
print("[4] Sonido OK")

-- ═══════════════════════════════════════════════════════════
-- HELPERS BÁSICOS
-- ═══════════════════════════════════════════════════════════
local function getHRP()
    local c = lp.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end
local function getHum()
    local c = lp.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

-- ═══ TOOL CATEGORY (de Michelle) ═══
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

-- ═══ PROTECCIONES ═══
local function isTargetProtected(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return false end
    local char = targetPlayer.Character
    if AimConfig.ProtectSafeZone then
        if char:GetAttribute("SafeZone") == true then return true end
        if char:GetAttribute("PvpDisabled") == true then return true end
        if char:GetAttribute("CombatProtected") == true then return true end
        if char:GetAttribute("PVP") == false then return true end
    end
    if AimConfig.ProtectForceField then
        if char:FindFirstChildWhichIsA("ForceField") then return true end
    end
    return false
end

-- ═══ ALIANZA (aliados) ═══
local function isAllyWithMe(targetplayer)
    local myGui = lp:FindFirstChild("PlayerGui")
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

-- ═══ IS ENEMY (mejorado con protecciones) ═══
local function isEnemy(t)
    if not t or t == lp then return false end
    if isTargetProtected(t) then return false end
    local a, b = lp.Team, t.Team
    if a and b then
        if a.Name == "Pirates" and b.Name == "Marines" then return true end
        if a.Name == "Marines" and b.Name == "Pirates" then return true end
        if a.Name == "Pirates" and b.Name == "Pirates" then return not isAllyWithMe(t) end
        if a.Name == "Marines" and b.Name == "Marines" then return false end
    end
    return true
end

-- ═══ BLACKLIST ═══
local function isSkillBlacklisted(key)
    if not key then return false end
    local cat = State.currentToolCategory or "Melee"
    local bl = AimConfig.Blacklist[cat]
    if bl and bl[key] ~= nil then return bl[key] == true end
    return false
end

-- ═══ FACE TARGET ═══
local function faceTarget(targetPos)
    if not AimConfig.FaceTarget or not targetPos then return end
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local currentPos = hrp.Position
    local lookVector = Vector3.new(targetPos.X, currentPos.Y, targetPos.Z) - currentPos
    if lookVector.Magnitude < 0.001 then return end
    lookVector = lookVector.Unit
    hrp.CFrame = CFrame.lookAt(currentPos, currentPos + lookVector, Vector3.new(0, 1, 0))
end

-- ═══ SET SKILL KEY ═══
local function setCurrentSkillKey(key)
    State.currentSkillKey = key
    State.lastSkillTime = os.clock()
    if Config.SilentAimPlayers or Config.SilentAimNPCs then
        local targetPos = State.PlayersPosition or State.NPCPosition
        if targetPos then
            task.spawn(function() faceTarget(targetPos) end)
        end
    end
    task.spawn(function()
        local myTime = State.lastSkillTime
        task.wait(1.5)
        if State.lastSkillTime == myTime and State.currentSkillKey == key then
            State.currentSkillKey = nil
        end
    end)
end

-- ═══ FOV / 180 CHECK ═══
local function isInFOV(worldPos)
    if AimConfig.AimMode ~= "FOV" then return true end
    local screenPos, onScreen = cam:WorldToViewportPoint(worldPos)
    if not onScreen or screenPos.Z <= 0 then return false end
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
    return dist <= FOV.Size
end

local function is180Facing(hrp, myHRP)
    if AimConfig.AimMode ~= "180" then return true end
    local dir = (hrp.Position - myHRP.Position).Unit
    return myHRP.CFrame.LookVector:Dot(dir) > 0
end

-- ═══ VISIBLE CHECK ═══
local function isVisible(targetPart)
    if not AimConfig.VisibleCheck then return true end
    local myChar = lp.Character
    if not myChar then return true end
    local origin = cam.CFrame.Position
    local dir = targetPart.Position - origin
    if dir.Magnitude > AimConfig.MaxVisibleRange then return false end
    local ray = Ray.new(origin, dir)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {myChar, cam})
    return hit == nil or hit:IsDescendantOf(targetPart.Parent)
end

-- ═══ SMOOTHING ═══
local function smoothPosition(bufferKey, newPos)
    if AimConfig.SmoothingSamples <= 1 then return newPos end
    if not State.PosBuffer[bufferKey] then State.PosBuffer[bufferKey] = {} end
    local buf = State.PosBuffer[bufferKey]
    table.insert(buf, newPos)
    while #buf > AimConfig.SmoothingSamples do
        table.remove(buf, 1)
    end
    if #buf == 0 then return newPos end
    local sum = Vector3.zero
    for _, p in ipairs(buf) do sum = sum + p end
    return sum / #buf
end

-- ═══ PREDICTION AVANZADA ═══
local function getPredictedPosition(hrp, bufferKey)
    if not hrp then return nil end
    local char = hrp.Parent
    local h = char:FindFirstChildOfClass("Humanoid")
    if not h then return hrp.Position end
    local aimPart = hrp
    if AimConfig.AimPart ~= "HumanoidRootPart" then
        local p = char:FindFirstChild(AimConfig.AimPart)
        if p then aimPart = p end
    end
    if not Config.Prediction or h.WalkSpeed < 5 then
        return smoothPosition(bufferKey or char, aimPart.Position)
    end
    local vel = hrp.AssemblyLinearVelocity
    local predTime = Config.PredictionAmount
    if AimConfig.DistanceMultiplier then
        local myHRP = getHRP()
        if myHRP then
            local dist = (hrp.Position - myHRP.Position).Magnitude
            predTime = predTime + (dist * 0.0006)
        end
    end
    if AimConfig.PingCompensation then
        local ping = 0
        pcall(function() ping = lp:GetNetworkPing() end)
        predTime = predTime + (ping * 0.4)
    end
    return smoothPosition(bufferKey or char, aimPart.Position + (vel * predTime))
end

-- ═══ GET CLOSEST PLAYER (AimMode + Priority) ═══
local function getClosestPlayer()
    local hrp = getHRP()
    if not hrp then return nil end
    if State.LockedTarget and tick() - State.LockTime < AimConfig.TargetLockDuration then
        local c = State.LockedTarget.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            local e = c:FindFirstChild("HumanoidRootPart")
            if h and h.Health > 0 and e and isEnemy(State.LockedTarget) then
                if isInFOV(e.Position) and is180Facing(e, hrp) and isVisible(e) then
                    return State.LockedTarget
                end
            end
        end
    end
    if AimConfig.TargetPriority == "Lock Player" and AimConfig.LockedPlayerName then
        local locked = Players:FindFirstChild(AimConfig.LockedPlayerName)
        if locked and locked ~= lp and locked.Character then
            local h = locked.Character:FindFirstChildOfClass("Humanoid")
            local e = locked.Character:FindFirstChild("HumanoidRootPart")
            if h and h.Health > 0 and e and isEnemy(locked) then
                if isInFOV(e.Position) and is180Facing(e, hrp) and isVisible(e) then
                    State.LockedTarget = locked
                    State.LockTime = tick()
                    return locked
                end
            end
        end
        return nil
    end
    local valid = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and isEnemy(p) and p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            local e = p.Character:FindFirstChild("HumanoidRootPart")
            if h and h.Health > 0 and e then
                if isInFOV(e.Position) and is180Facing(e, hrp) and isVisible(e) then
                    local dist = (e.Position - hrp.Position).Magnitude
                    if dist <= State.maxRange then
                        table.insert(valid, { Player = p, HRP = e, Humanoid = h, Distance = dist })
                    end
                end
            end
        end
    end
    if #valid == 0 then return nil end
    local prio = AimConfig.TargetPriority
    if prio == "Nearest" then
        table.sort(valid, function(a, b) return a.Distance < b.Distance end)
    elseif prio == "Low HP" then
        table.sort(valid, function(a, b) return a.Humanoid.Health < b.Humanoid.Health end)
    elseif prio == "HighestHP" then
        table.sort(valid, function(a, b) return a.Humanoid.Health > b.Humanoid.Health end)
    elseif prio == "Looking At Me" then
        table.sort(valid, function(a, b)
            local dirA = (hrp.Position - a.HRP.Position).Unit
            local dirB = (hrp.Position - b.HRP.Position).Unit
            return a.HRP.CFrame.LookVector:Dot(dirA) > b.HRP.CFrame.LookVector:Dot(dirB)
        end)
    end
    local best = valid[1].Player
    if best then
        State.LockedTarget = best
        State.LockTime = tick()
    end
    return best
end

-- ═══ GET CLOSEST NPC ═══
local function getClosestNPC()
    local hrp = getHRP()
    if not hrp then return nil end
    if State.NPCLockedTarget and tick() - State.NPCLockTime < AimConfig.TargetLockDuration then
        local h = State.NPCLockedTarget:FindFirstChildOfClass("Humanoid")
        local e = State.NPCLockedTarget:FindFirstChild("HumanoidRootPart")
        if h and h.Health > 0 and e and State.NPCLockedTarget.Parent then
            if isInFOV(e.Position) and is180Facing(e, hrp) and isVisible(e) then
                return State.NPCLockedTarget
            end
        end
    end
    local best, bd = nil, State.maxRange
    local en = workspace:FindFirstChild("Enemies")
    if not en then return nil end
    for _, v in ipairs(en:GetChildren()) do
        local e = v:FindFirstChild("HumanoidRootPart")
        local h = v:FindFirstChildOfClass("Humanoid")
        if e and h and h.Health > 0 then
            if isInFOV(e.Position) and is180Facing(e, hrp) and isVisible(e) then
                local d = (e.Position - hrp.Position).Magnitude
                if d < bd then bd = d; best = v end
            end
        end
    end
    if best then
        State.NPCLockedTarget = best
        State.NPCLockTime = tick()
    end
    return best
end

-- ═══ SORU TARGET (skill C) ═══
local function getSoruTarget()
    local hrp = getHRP()
    if not hrp then return nil end
    local valid = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and isEnemy(p) and p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            local e = p.Character:FindFirstChild("HumanoidRootPart")
            if h and h.Health > 0 and e then
                local dist = (e.Position - hrp.Position).Magnitude
                if dist <= AimConfig.SoruRange then
                    local sp, onScreen = cam:WorldToViewportPoint(e.Position)
                    if onScreen and sp.Z > 0 then
                        local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                        local scrDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if scrDist <= AimConfig.SoruFOVRadius then
                            table.insert(valid, { Player = p, HRP = e, Humanoid = h, Distance = dist })
                        end
                    end
                end
            end
        end
    end
    if #valid == 0 then return nil end
    local prio = AimConfig.SoruPriority
    if prio == "Nearest" then
        table.sort(valid, function(a, b) return a.Distance < b.Distance end)
    elseif prio == "Low HP" then
        table.sort(valid, function(a, b) return a.Humanoid.Health < b.Humanoid.Health end)
    elseif prio == "Looking At Me" then
        table.sort(valid, function(a, b)
            local dirA = (hrp.Position - a.HRP.Position).Unit
            local dirB = (hrp.Position - b.HRP.Position).Unit
            return a.HRP.CFrame.LookVector:Dot(dirA) > b.HRP.CFrame.LookVector:Dot(dirB)
        end)
    end
    return valid[1].HRP
end

-- ═══════════════════════════════════════════════════════════
-- INSTALL SILENT AIM (FUSION)
-- ═══════════════════════════════════════════════════════════
local function installSilentAim()
    if State.silentInstalled then return end
    State.silentInstalled = true
    print("[Silent Aim] Instalado")

    -- Character tracking
    local function onChar(char)
        State.currentTool = nil
        State.currentToolCategory = "Melee"
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Tool") then
                State.currentTool = child
                State.currentToolCategory = getToolCategory(child)
            end
        end
        char.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                State.currentTool = child
                State.currentToolCategory = getToolCategory(child)
            end
        end)
        char.ChildRemoved:Connect(function(child)
            if child == State.currentTool then
                State.currentTool = nil
                State.currentToolCategory = "Melee"
            end
        end)
    end
    if lp.Character then onChar(lp.Character) end
    lp.CharacterAdded:Connect(onChar)

    -- Update loop
    RunService.Heartbeat:Connect(function()
        if not Config.SilentAimPlayers and not Config.SilentAimNPCs then
            State.PlayersPosition = nil
            State.NPCPosition = nil
            return
        end
        if Config.SilentAimPlayers then
            local e = getClosestPlayer()
            local eH = e and e.Character and e.Character:FindFirstChild("HumanoidRootPart")
            State.PlayersPosition = eH and getPredictedPosition(eH, e.Character) or nil
        else
            State.PlayersPosition = nil
        end
        if Config.SilentAimNPCs then
            local n = getClosestNPC()
            local eH = n and n:FindFirstChild("HumanoidRootPart")
            State.NPCPosition = eH and getPredictedPosition(eH, n) or nil
        else
            State.NPCPosition = nil
        end
        if AimConfig.SoruEnabled then
            State.SoruTarget = getSoruTarget()
            State.SoruPos = State.SoruTarget and State.SoruTarget.Position or nil
        end
    end)

    -- Skill detection via keyboard
    UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        local keyMap = {
            [Enum.KeyCode.Z] = "Z", [Enum.KeyCode.X] = "X",
            [Enum.KeyCode.C] = "C", [Enum.KeyCode.V] = "V",
            [Enum.KeyCode.F] = "F",
        }
        local key = keyMap[input.KeyCode]
        if key then setCurrentSkillKey(key) end
    end)

    -- Skill detection via UI buttons
    task.spawn(function()
        local pg = lp:WaitForChild("PlayerGui", 20)
        if not pg then return end
        local main = pg:FindFirstChild("Main") or pg:WaitForChild("Main", 15)
        if not main then return end
        local skills = main:FindFirstChild("Skills") or main:WaitForChild("Skills", 10)
        if not skills then return end
        local SKILL_KEYS = {"Z", "X", "C", "V", "F", "TAP"}
        local function hookBtn(btn)
            if not btn:IsA("GuiButton") then return end
            if btn:GetAttribute("BragaoHooked") then return end
            if table.find(SKILL_KEYS, btn.Name) then
                btn:SetAttribute("BragaoHooked", true)
                btn.Activated:Connect(function() setCurrentSkillKey(btn.Name) end)
            end
        end
        for _, d in ipairs(skills:GetDescendants()) do hookBtn(d) end
        skills.DescendantAdded:Connect(hookBtn)
    end)

    -- MouseModule override (Godhuman/Sanguine/Sword Z)
    pcall(function()
        local mouseModule = RS:FindFirstChild("Mouse")
        if not mouseModule then return end
        local mm = require(mouseModule)
        if type(mm) ~= "table" then return end
        local originalHit = rawget(mm, "Hit")
        local originalTarget = rawget(mm, "Target")
        local mmt = getrawmetatable(mm)
        if not mmt then return end
        setreadonly(mmt, false)
        mmt.__index = newcclosure(function(self, key)
            if key == "Hit" then
                if AimConfig.OverrideMouseHit
                    and (Config.SilentAimPlayers or Config.SilentAimNPCs)
                    and (State.PlayersPosition or State.NPCPosition)
                    and State.currentSkillKey == "Z"
                    and not isSkillBlacklisted("Z") then
                    return CFrame.new(State.PlayersPosition or State.NPCPosition)
                end
                return originalHit
            elseif key == "Target" then
                if AimConfig.OverrideMouseHit
                    and (Config.SilentAimPlayers or Config.SilentAimNPCs)
                    and (State.PlayersPosition or State.NPCPosition)
                    and State.currentSkillKey == "Z"
                    and not isSkillBlacklisted("Z") then
                    return nil
                end
                return originalTarget
            end
            return rawget(self, key)
        end)
        setreadonly(mmt, true)
    end)

    -- Namecall hook (fusión completa)
    pcall(function()
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local Method = getnamecallmethod()
            local args = {...}
            
            -- Skip TAP
            if args[1] == "TAP" then
                return oldNamecall(self, ...)
            end
            
            -- Detect skill key from args
            local skillKey = nil
            for _, arg in ipairs(args) do
                if type(arg) == "string" and table.find({"Z","X","C","V","F"}, arg) then
                    skillKey = arg
                    break
                end
            end
            if skillKey then
                if Config.SilentAimPlayers or Config.SilentAimNPCs then
                    local targetPos = State.PlayersPosition or State.NPCPosition
                    if targetPos then
                        task.spawn(function() faceTarget(targetPos) end)
                    end
                end
                setCurrentSkillKey(skillKey)
            end
            
            -- Soru aim
            if AimConfig.SoruEnabled and State.SoruPos and skillKey == "C" then
                for i, arg in ipairs(args) do
                    if typeof(arg) == "Vector3" then
                        args[i] = State.SoruPos
                    end
                end
            end
            
            -- Blacklist check
            local skip = false
            if skillKey and isSkillBlacklisted(skillKey) then
                skip = true
            elseif not skillKey and State.currentSkillKey and isSkillBlacklisted(State.currentSkillKey) then
                skip = true
            end
            
            if not skip then
                if Method == "FireServer" then
                    if typeof(args[1]) == "Vector3" then
                        if Config.SilentAimPlayers and State.PlayersPosition then
                            args[1] = State.PlayersPosition
                        elseif Config.SilentAimNPCs and State.NPCPosition then
                            args[1] = State.NPCPosition
                        end
                    end
                elseif Method == "InvokeServer" then
                    if State.currentTool and State.currentTool.Name == "Buddy Sword" then
                        if type(args[1]) == "string" and args[1] == "X" then
                            if Config.SilentAimPlayers and State.PlayersPosition then
                                args[2] = State.PlayersPosition
                            elseif Config.SilentAimNPCs and State.NPCPosition then
                                args[2] = State.NPCPosition
                            end
                        end
                    end
                end
            end
            
            return oldNamecall(self, unpack(args))
        end)
        setreadonly(mt, true)
    end)
end

-- Auto Ken (igual que antes)
local function startAutoKenLoop()
    if State.autoKenRunning then return end
    State.autoKenRunning = true
    task.spawn(function()
        while Config.AutoKen do
            task.wait(0.1)
            pcall(function()
                local c = lp.Character; if not c then return end
                if CS:HasTag(c, "Ken") and CommE then CommE:FireServer("Ken", true) end
            end)
        end
        State.autoKenRunning = false
    end)
end

-- Hitbox loop (igual)
local function resetHRP(hrp)
    hrp.Size = Vector3.new(2, 2, 1)
    hrp.Transparency = 1
    hrp.CanCollide = false
end

RunService.Heartbeat:Connect(function()
    if not Hitbox.Enabled then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local shouldExpand = (not Hitbox.EnemyOnly) or isEnemy(p)
                if shouldExpand then
                    hrp.Size = Vector3.new(Hitbox.Size, Hitbox.Size, Hitbox.Size)
                    hrp.Transparency = Hitbox.Transparency
                    hrp.CanCollide = false
                    hrp.Massless = true
                else
                    resetHRP(hrp)
                end
            end
        end
    end
    if Hitbox.NPCs then
        local en = workspace:FindFirstChild("Enemies")
        if en then
            for _, npc in ipairs(en:GetChildren()) do
                local hrp = npc:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Size = Vector3.new(Hitbox.Size, Hitbox.Size, Hitbox.Size)
                    hrp.Transparency = Hitbox.Transparency
                    hrp.CanCollide = false
                end
            end
        end
    end
end)
print("[5] Hitbox loop OK")

-- ═══════════════════════════════════════════════════════════
-- ESP + Drawing
-- ═══════════════════════════════════════════════════════════
local Drawing = Drawing or (getgenv and getgenv().Drawing)
local hasDrawing = pcall(function() return Drawing.new("Line") end)
if not hasDrawing then warn("[Bragao Hub] Tu executor NO soporta Drawing API") end

local ESP = {
    NameEnabled = false, TracersEnabled = false, BoxEnabled = false,
    HealthEnabled = false, ChamsEnabled = false, SkeletonEnabled = false,
    LimitDistance = false, MaxDistance = 250,
    NameColor = Color3.fromRGB(255, 255, 255),
    TracerColor = Color3.fromRGB(0, 255, 140),
    BoxColor = Color3.fromRGB(0, 255, 140),
    SkeletonColor = Color3.fromRGB(0, 255, 140),
    ChamsColor = Color3.fromRGB(0, 255, 140),
    TextSize = 14, TracerThickness = 1.5,
}

local FOVCircle, NEDot, NEText, NELine
if hasDrawing then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = FOV.Thickness; FOVCircle.NumSides = 64
    FOVCircle.Filled = false; FOVCircle.Transparency = 1; FOVCircle.Visible = false
    NEDot = Drawing.new("Circle"); NEDot.NumSides = 32; NEDot.Thickness = 2
    NEDot.Filled = false; NEDot.Visible = false
    NEText = Drawing.new("Text"); NEText.Center = true; NEText.Outline = true
    NEText.Size = 14; NEText.Font = 2; NEText.Visible = false
    NELine = Drawing.new("Line"); NELine.Thickness = 3; NELine.Visible = false
end

local ESPObjects = {}
local function CreateESP(player)
    if not hasDrawing then return end
    if player == lp then return end
    if ESPObjects[player] then return end
    local d = {
        Name = Drawing.new("Text"), Distance = Drawing.new("Text"),
        Tracer = Drawing.new("Line"), Box = Drawing.new("Square"),
        HealthBg = Drawing.new("Square"), Health = Drawing.new("Square"),
        Highlight = nil, Skeleton = {}
    }
    d.Name.Size = ESP.TextSize; d.Name.Center = true; d.Name.Outline = true
    d.Name.Color = ESP.NameColor; d.Name.Font = 2
    d.Distance.Size = ESP.TextSize - 1; d.Distance.Center = true
    d.Distance.Outline = true; d.Distance.Color = ESP.NameColor; d.Distance.Font = 2
    d.Tracer.Thickness = ESP.TracerThickness; d.Tracer.Color = ESP.TracerColor
    d.Box.Thickness = 1.5; d.Box.Filled = false; d.Box.Color = ESP.BoxColor
    d.HealthBg.Filled = true; d.HealthBg.Color = Color3.fromRGB(30,30,30)
    d.Health.Filled = true
    for i = 1, 12 do
        local line = Drawing.new("Line")
        line.Thickness = 1.4; line.Color = ESP.SkeletonColor
        d.Skeleton[i] = line
    end
    ESPObjects[player] = d
end

local function RemoveESP(player)
    if ESPObjects[player] then
        for _, v in pairs(ESPObjects[player]) do
            if type(v) == "table" then
                for _, line in pairs(v) do pcall(function() line:Remove() end) end
            elseif type(v) == "userdata" or type(v) == "table" then
                pcall(function() v:Remove() end)
            elseif typeof(v) == "Instance" then
                pcall(function() v:Destroy() end)
            end
        end
        ESPObjects[player] = nil
    end
end

for _, plr in pairs(Players:GetPlayers()) do CreateESP(plr) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)

local function GetBonePos(char, name)
    local part = char:FindFirstChild(name)
    return part and part.Position
end

RunService.RenderStepped:Connect(function()
    if not hasDrawing then return end
    for player, d in pairs(ESPObjects) do
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
            d.Name.Visible = false; d.Distance.Visible = false
            d.Tracer.Visible = false; d.Box.Visible = false
            d.HealthBg.Visible = false; d.Health.Visible = false
            if d.Highlight then d.Highlight.Enabled = false end
            for _, line in pairs(d.Skeleton) do line.Visible = false end
            continue
        end
        local hrp = char.HumanoidRootPart
        local hum = char.Humanoid
        local dist3D = (hrp.Position - cam.CFrame.Position).Magnitude
        if ESP.LimitDistance and dist3D > ESP.MaxDistance then
            d.Name.Visible = false; d.Distance.Visible = false
            d.Tracer.Visible = false; d.Box.Visible = false
            d.HealthBg.Visible = false; d.Health.Visible = false
            if d.Highlight then d.Highlight.Enabled = false end
            for _, line in pairs(d.Skeleton) do line.Visible = false end
            continue
        end
        local pos, onScreen = cam:WorldToViewportPoint(hrp.Position)
        if ESP.ChamsEnabled then
            if not d.Highlight or not d.Highlight.Parent then
                local hl = Instance.new("Highlight")
                hl.OutlineColor = Color3.new(1,1,1); hl.FillTransparency = 0.5
                hl.Parent = char; d.Highlight = hl
            end
            d.Highlight.Enabled = true
            d.Highlight.FillColor = ESP.ChamsColor
        else
            if d.Highlight then d.Highlight.Enabled = false end
        end
        if onScreen then
            local top = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.5, 0))
            local bottom = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
            local sizeY = math.abs(top.Y - bottom.Y) / 2
            local boxSize = Vector2.new(sizeY * 1.5, sizeY * 2.2)
            local boxPos = Vector2.new(pos.X - boxSize.X/2, pos.Y - boxSize.Y/2)
            if ESP.NameEnabled then
                d.Name.Text = player.Name; d.Name.Size = ESP.TextSize
                d.Name.Position = Vector2.new(pos.X, boxPos.Y - 18)
                d.Name.Color = ESP.NameColor; d.Name.Visible = true
                d.Distance.Text = math.floor(dist3D) .. "m"
                d.Distance.Size = ESP.TextSize - 1
                d.Distance.Position = Vector2.new(pos.X, boxPos.Y + boxSize.Y + 4)
                d.Distance.Color = ESP.NameColor; d.Distance.Visible = true
            else
                d.Name.Visible = false; d.Distance.Visible = false
            end
            if ESP.TracersEnabled then
                d.Tracer.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                d.Tracer.To = Vector2.new(pos.X, pos.Y)
                d.Tracer.Thickness = ESP.TracerThickness
                d.Tracer.Color = ESP.TracerColor; d.Tracer.Visible = true
            else
                d.Tracer.Visible = false
            end
            if ESP.BoxEnabled then
                d.Box.Size = boxSize; d.Box.Position = boxPos
                d.Box.Color = ESP.BoxColor; d.Box.Visible = true
            else
                d.Box.Visible = false
            end
            if ESP.HealthEnabled then
                local hp = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                d.HealthBg.Size = Vector2.new(3, boxSize.Y)
                d.HealthBg.Position = Vector2.new(boxPos.X - 7, boxPos.Y)
                d.HealthBg.Visible = true
                d.Health.Size = Vector2.new(3, boxSize.Y * hp)
                d.Health.Position = Vector2.new(boxPos.X - 7, boxPos.Y + boxSize.Y * (1-hp))
                d.Health.Color = Color3.fromRGB(255*(1-hp), 255*hp, 40)
                d.Health.Visible = true
            else
                d.HealthBg.Visible = false; d.Health.Visible = false
            end
            if ESP.SkeletonEnabled then
                local function scr(p)
                    if not p then return nil end
                    local s, on = cam:WorldToViewportPoint(p)
                    return on and Vector2.new(s.X, s.Y) or nil
                end
                local head = GetBonePos(char, "Head")
                local torso = GetBonePos(char, "UpperTorso") or GetBonePos(char, "Torso")
                local larm = GetBonePos(char, "LeftUpperArm") or GetBonePos(char, "Left Arm")
                local rarm = GetBonePos(char, "RightUpperArm") or GetBonePos(char, "Right Arm")
                local lleg = GetBonePos(char, "LeftUpperLeg") or GetBonePos(char, "Left Leg")
                local rleg = GetBonePos(char, "RightUpperLeg") or GetBonePos(char, "Right Leg")
                local lhand = GetBonePos(char, "LeftHand") or larm
                local rhand = GetBonePos(char, "RightHand") or rarm
                local lfoot = GetBonePos(char, "LeftFoot") or lleg
                local rfoot = GetBonePos(char, "RightFoot") or rleg
                local conns = {
                    {head, torso}, {torso, larm}, {torso, rarm},
                    {larm, lhand}, {rarm, rhand},
                    {torso, lleg}, {torso, rleg},
                    {lleg, lfoot}, {rleg, rfoot}
                }
                for i, c in ipairs(conns) do
                    local f = scr(c[1]); local t = scr(c[2])
                    if f and t and d.Skeleton[i] then
                        d.Skeleton[i].From = f; d.Skeleton[i].To = t
                        d.Skeleton[i].Color = ESP.SkeletonColor
                        d.Skeleton[i].Visible = true
                    elseif d.Skeleton[i] then
                        d.Skeleton[i].Visible = false
                    end
                end
            else
                for _, line in pairs(d.Skeleton) do line.Visible = false end
            end
        else
            d.Name.Visible = false; d.Distance.Visible = false
            d.Tracer.Visible = false; d.Box.Visible = false
            d.HealthBg.Visible = false; d.Health.Visible = false
            for _, line in pairs(d.Skeleton) do line.Visible = false end
        end
    end
end)

-- FOV loop
RunService.RenderStepped:Connect(function()
    if not hasDrawing or not FOVCircle then return end
    local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
    FOVCircle.Position = center
    FOVCircle.Radius = FOV.Size
    FOVCircle.Thickness = FOV.Thickness
    local anyInFOV = false
    if FOV.HighlightInFOV then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp and isEnemy(p) and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    local sp, onScreen = cam:WorldToViewportPoint(hrp.Position)
                    if onScreen and sp.Z > 0 then
                        local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if d <= FOV.Size then anyInFOV = true; break end
                    end
                end
            end
        end
    end
    FOVCircle.Color = (FOV.HighlightInFOV and anyInFOV) and FOV.EnemyColor or FOV.Color
    FOVCircle.Visible = FOV.Enabled
end)

-- Nearest enemy indicator loop
RunService.RenderStepped:Connect(function()
    if not hasDrawing or not NEDot then return end
    if not NearestEnemy.Enabled then
        NEDot.Visible = false; NEText.Visible = false; NELine.Visible = false
        return
    end
    local myHRP = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP then NEDot.Visible = false; NEText.Visible = false; NELine.Visible = false; return end
    local closest, closestDist = nil, NearestEnemy.MaxRange
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and isEnemy(p) and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local d = (hrp.Position - myHRP.Position).Magnitude
                if d < closestDist then closestDist = d; closest = p end
            end
        end
    end
    if not closest or not closest.Character then
        NEDot.Visible = false; NEText.Visible = false; NELine.Visible = false; return
    end
    local targetHRP = closest.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP then NEDot.Visible = false; NEText.Visible = false; NELine.Visible = false; return end
    local sp, onScreen = cam:WorldToViewportPoint(targetHRP.Position)
    local vp = cam.ViewportSize
    local center = Vector2.new(vp.X/2, vp.Y/2)
    local textParts = {}
    if NearestEnemy.ShowName then table.insert(textParts, closest.Name) end
    if NearestEnemy.ShowDistance then table.insert(textParts, "[" .. math.floor(closestDist) .. "m]") end
    local txt = table.concat(textParts, " ")
    if onScreen and sp.Z > 0 and NearestEnemy.ShowOnScreen then
        NEDot.Position = Vector2.new(sp.X, sp.Y)
        NEDot.Radius = NearestEnemy.DotRadius; NEDot.Color = NearestEnemy.Color
        NEDot.Thickness = 2; NEDot.Visible = true
        NEText.Position = Vector2.new(sp.X, sp.Y - NearestEnemy.DotRadius - 16)
        NEText.Text = txt; NEText.Color = NearestEnemy.Color
        NEText.Size = 14; NEText.Visible = true
        NELine.Visible = false
    elseif NearestEnemy.ShowOffScreen then
        NEDot.Visible = false; NEText.Visible = false
        local relPos = cam.CFrame:PointToObjectSpace(targetHRP.Position)
        local screenX = relPos.X; local screenY = -relPos.Y
        if relPos.Z > 0 then screenX = -screenX; screenY = -screenY end
        local angle = math.atan2(screenY, screenX)
        local radius = math.min(vp.X, vp.Y) / 2 - 60
        local from = center + Vector2.new(math.cos(angle) * radius * 0.5, math.sin(angle) * radius * 0.5)
        local to = center + Vector2.new(math.cos(angle) * radius, math.sin(angle) * radius)
        NELine.From = from; NELine.To = to
        NELine.Color = NearestEnemy.Color; NELine.Thickness = 3; NELine.Visible = true
        NEText.Position = to + Vector2.new(math.cos(angle) * 45, math.sin(angle) * 20)
        NEText.Text = txt; NEText.Color = NearestEnemy.Color
        NEText.Size = 13; NEText.Visible = true
    else
        NEDot.Visible = false; NEText.Visible = false; NELine.Visible = false
    end
end)
print("[6] ESP + FOV + Indicator OK")

local function setupInfiniteJump()
    if Config.InfiniteJump and not State.infJumpConn then
        State.infJumpConn = UIS.InputBegan:Connect(function(i, gp)
            if gp then return end
            if i.KeyCode == Enum.KeyCode.Space then
                local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    elseif not Config.InfiniteJump and State.infJumpConn then
        State.infJumpConn:Disconnect(); State.infJumpConn = nil
    end
end
RunService.Heartbeat:Connect(function()
    if Config.WalkSpeed > 16 then
        local h = getHum(); if h then h.WalkSpeed = Config.WalkSpeed end
    end
end)
local function setupAntiAFK()
    if Config.AntiAFK and not State.antiAFKRunning then
        State.antiAFKRunning = true
        task.spawn(function()
            while Config.AntiAFK do
                task.wait(60)
                pcall(function() VU:CaptureController(); VU:ClickButton1(Vector2.new(0, 0)) end)
            end
            State.antiAFKRunning = false
        end)
    end
end
print("[7] Gameplay funcs OK")

-- ═══════════════════════════════════════════════════════════
-- UI (framework)
-- ═══════════════════════════════════════════════════════════
local T = {
    BG = Color3.fromRGB(8,8,8), PANEL = Color3.fromRGB(14,14,14),
    TITLEBAR = Color3.fromRGB(12,12,12), ELEMENT = Color3.fromRGB(20,20,20),
    ELEMENT_HOV = Color3.fromRGB(30,30,30), ELEMENT_ACT = Color3.fromRGB(38,38,38),
    BORDER = Color3.fromRGB(55,55,55), BORDER_SOFT = Color3.fromRGB(40,40,40),
    TEXT = Color3.fromRGB(255,255,255), TEXT_DIM = Color3.fromRGB(150,150,150),
    ON = Color3.fromRGB(70,200,110), OFF = Color3.fromRGB(55,55,65),
    CLOSE_HOV = Color3.fromRGB(230,70,70), MIN_HOV = Color3.fromRGB(55,55,55),
}
T.ACCENT = Color3.fromRGB(255, 200, 0)
T.ACCENT_DIM = Color3.fromRGB(160, 125, 0)

local FONT = Enum.Font.SourceSans
local FONT_B = Enum.Font.SourceSansBold
local function tw(i, p, t) TweenService:Create(i, TweenInfo.new(t or 0.15), p):Play() end
local function new(class, props, parent)
    local i = Instance.new(class)
    for k, v in pairs(props or {}) do i[k] = v end
    if parent then i.Parent = parent end
    return i
end
local function corner(p, r) return new("UICorner", { CornerRadius = UDim.new(0, r or 6) }, p) end
local function stroke(p, c, th, tr)
    return new("UIStroke", { Color = c or T.BORDER, Thickness = th or 1,
        Transparency = tr or 0, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, p)
end

local screenGui = new("ScreenGui", {
    Name = "BragaoHub", ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true,
}, lp:WaitForChild("PlayerGui"))
print("[8] ScreenGui OK")

local notifHolder = new("Frame", {
    Name = "Notifs", BackgroundTransparency = 1,
    Size = UDim2.fromOffset(210, 400), Position = UDim2.new(1, -226, 0, 60),
}, screenGui)
new("UIListLayout", {
    Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Top, SortOrder = Enum.SortOrder.LayoutOrder,
}, notifHolder)

local function notify(title, content, color)
    color = color or T.ACCENT
    local h = content and 38 or 26
    local card = new("Frame", {
        BackgroundColor3 = T.PANEL, BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, h), BorderSizePixel = 0,
    }, notifHolder)
    corner(card, 5); stroke(card, T.BORDER_SOFT, 1, 0.2)
    new("Frame", { BackgroundColor3 = color, Size = UDim2.new(0, 2, 1, 0), BorderSizePixel = 0 }, card)
    local tl = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 9, 0, content and 4 or 0),
        Size = UDim2.new(1, -16, 0, content and 13 or 26),
        Font = FONT_B, Text = title, TextColor3 = T.TEXT, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)
    local cl
    if content then
        cl = new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 9, 0, 18),
            Size = UDim2.new(1, -16, 0, 15), Font = FONT,
            Text = content, TextColor3 = T.TEXT_DIM, TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }, card)
    end
    tw(card, { BackgroundTransparency = 0 }, 0.15)
    tw(tl, { TextTransparency = 0 }, 0.15)
    if cl then tw(cl, { TextTransparency = 0 }, 0.15) end
    task.spawn(function()
        task.wait(1.8)
        if not card.Parent then return end
        tw(card, { BackgroundTransparency = 1 }, 0.22)
        tw(tl, { TextTransparency = 1 }, 0.22)
        if cl then tw(cl, { TextTransparency = 1 }, 0.22) end
        task.wait(0.28)
        if card.Parent then card:Destroy() end
    end)
end
print("[9] Notify OK")

local mainFrame = new("Frame", {
    Name = "MainFrame", Size = UDim2.fromOffset(500, 400),
    Position = UDim2.new(0.5, -250, 0.5, -200),
    BackgroundColor3 = T.BG, BorderSizePixel = 0,
    Active = true, ClipsDescendants = true,
}, screenGui)
corner(mainFrame, 10); stroke(mainFrame, T.BORDER_SOFT, 1, 0.2)

local titleBar = new("Frame", {
    Name = "TitleBar", Size = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = T.TITLEBAR, BorderSizePixel = 0,
}, mainFrame)
corner(titleBar, 10)
new("Frame", { BackgroundColor3 = T.TITLEBAR, Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14), BorderSizePixel = 0 }, titleBar)
new("Frame", { BackgroundColor3 = T.BORDER_SOFT, Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, -1), BorderSizePixel = 0 }, titleBar)

local winTitle = new("TextLabel", {
    BackgroundTransparency = 1, Position = UDim2.new(0, 46, 0, 0),
    Size = UDim2.new(0, 300, 1, 0), Font = FONT_B,
    Text = "BRAGAO HUB", TextColor3 = T.ACCENT, TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
}, titleBar)

local closeBtn = new("TextButton", {
    BackgroundTransparency = 1, Position = UDim2.new(1, -34, 0, 8),
    Size = UDim2.fromOffset(24, 20), Font = FONT_B, Text = "X",
    TextColor3 = T.TEXT_DIM, TextSize = 15, AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
closeBtn.MouseEnter:Connect(function() tw(closeBtn, { TextColor3 = T.CLOSE_HOV }) end)
closeBtn.MouseLeave:Connect(function() tw(closeBtn, { TextColor3 = T.TEXT_DIM }) end)

local minBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT, Position = UDim2.new(1, -66, 0, 8),
    Size = UDim2.fromOffset(26, 20), Font = FONT_B, Text = "—",
    TextColor3 = T.TEXT, TextSize = 13, AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(minBtn, 4); stroke(minBtn, T.BORDER_SOFT, 1, 0.2)

local menuBtn = new("TextButton", {
    BackgroundColor3 = T.ELEMENT, Position = UDim2.new(0, 10, 0, 8),
    Size = UDim2.fromOffset(26, 20), Font = FONT_B, Text = "=",
    TextColor3 = T.TEXT, TextSize = 14, AutoButtonColor = false, BorderSizePixel = 0,
}, titleBar)
corner(menuBtn, 4); stroke(menuBtn, T.BORDER_SOFT, 1, 0.2)

menuBtn.MouseEnter:Connect(function() tw(menuBtn, { BackgroundColor3 = T.MIN_HOV }) end)
menuBtn.MouseLeave:Connect(function() tw(menuBtn, { BackgroundColor3 = T.ELEMENT }) end)
minBtn.MouseEnter:Connect(function() tw(minBtn, { BackgroundColor3 = T.MIN_HOV }) end)
minBtn.MouseLeave:Connect(function() tw(minBtn, { BackgroundColor3 = T.ELEMENT }) end)

local body = new("Frame", {
    Name = "Body", BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 36), Size = UDim2.new(1, 0, 1, -36),
}, mainFrame)

local sideW = 145
local sidebar = new("Frame", {
    Name = "Sidebar", BackgroundColor3 = T.PANEL,
    Size = UDim2.new(0, sideW, 1, 0), BorderSizePixel = 0,
}, body)
new("Frame", { BackgroundColor3 = T.BORDER_SOFT, Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(1, -1, 0, 0), BorderSizePixel = 0 }, sidebar)

local tabList = new("ScrollingFrame", {
    BackgroundTransparency = 1, Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6), BorderSizePixel = 0,
    ScrollBarThickness = 3, ScrollBarImageColor3 = T.BORDER,
    CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, sidebar)
new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, tabList)

local content = new("Frame", {
    Name = "Content", BackgroundTransparency = 1,
    Position = UDim2.new(0, sideW, 0, 0), Size = UDim2.new(1, -sideW, 1, 0),
}, body)

local dS, sP
titleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dS = i.Position; sP = mainFrame.Position
        local c; c = i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then dS = nil; c:Disconnect() end
        end)
    end
end)
UIS.InputChanged:Connect(function(i)
    if dS and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dS
        mainFrame.Position = UDim2.new(sP.X.Scale, sP.X.Offset + d.X, sP.Y.Scale, sP.Y.Offset + d.Y)
    end
end)

local sidebarOpen = true
menuBtn.MouseButton1Click:Connect(function()
    playClick()
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

local minimized, savedSize = false, mainFrame.Size
minBtn.MouseButton1Click:Connect(function()
    playClick()
    minimized = not minimized
    if minimized then
        savedSize = mainFrame.Size; body.Visible = false
        tw(mainFrame, { Size = UDim2.fromOffset(260, 36) }, 0.2)
    else
        body.Visible = true
        tw(mainFrame, { Size = savedSize }, 0.2)
    end
end)

local floatBtn = new("TextButton", {
    Name = "FloatButton", BackgroundColor3 = T.BG,
    Size = UDim2.fromOffset(130, 34), Position = UDim2.new(0, 20, 0, 20),
    Font = FONT_B, Text = "BRAGAO HUB", TextColor3 = T.ACCENT,
    TextSize = 12, AutoButtonColor = false, BorderSizePixel = 0,
    Visible = false, ZIndex = 50,
}, screenGui)
corner(floatBtn, 8)
stroke(floatBtn, T.ACCENT, 1, 0.1)

floatBtn.MouseButton1Click:Connect(function()
    playClick()
    floatBtn.Visible = false
    mainFrame.Visible = true
    local gs = savedSize
    mainFrame.Size = UDim2.fromOffset(gs.X.Offset * 0.85, gs.Y.Offset * 0.85)
    mainFrame.BackgroundTransparency = 1
    tw(mainFrame, { Size = gs, BackgroundTransparency = 0 }, 0.22)
end)

closeBtn.MouseButton1Click:Connect(function()
    playClick()
    local gs = mainFrame.Size
    tw(mainFrame, { Size = UDim2.fromOffset(gs.X.Offset * 0.85, gs.Y.Offset * 0.85), BackgroundTransparency = 1 }, 0.18)
    task.delay(0.22, function()
        mainFrame.Visible = false
        mainFrame.BackgroundTransparency = 0
        mainFrame.Size = savedSize
        floatBtn.Visible = true
    end)
end)

local fD, fS
floatBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        fD = i.Position; fS = floatBtn.Position
        local c; c = i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then fD = nil; c:Disconnect() end
        end)
    end
end)
UIS.InputChanged:Connect(function(i)
    if fD and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - fD
        floatBtn.Position = UDim2.new(fS.X.Scale, fS.X.Offset + d.X, fS.Y.Scale, fS.Y.Offset + d.Y)
    end
end)
print("[10] Float button OK")

local accentRefreshers = {}
local function registerAccent(fn) table.insert(accentRefreshers, fn) end
local function setAccent(color)
    T.ACCENT = color
    T.ACCENT_DIM = Color3.new(color.R * 0.6, color.G * 0.6, color.B * 0.6)
    for _, fn in ipairs(accentRefreshers) do pcall(fn) end
end
registerAccent(function() winTitle.TextColor3 = T.ACCENT end)
registerAccent(function() floatBtn.TextColor3 = T.ACCENT end)

local tabs, activeTab = {}, nil
local function createTab(title)
    local tab = { Title = title, Content = nil, Button = nil }
    tab.Content = new("ScrollingFrame", {
        Name = title, BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, -20), Position = UDim2.new(0, 10, 0, 10),
        BorderSizePixel = 0, ScrollBarThickness = 4,
        ScrollBarImageColor3 = T.BORDER,
        CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    }, content)
    new("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, tab.Content)
    tab.Button = new("TextButton", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 32),
        Font = FONT, Text = "  " .. title,
        TextColor3 = T.TEXT_DIM, TextSize = 12,
        AutoButtonColor = false, BorderSizePixel = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, tabList)
    corner(tab.Button, 5)
    local s = stroke(tab.Button, T.BORDER_SOFT, 1, 0.15)
    tab.Button.MouseEnter:Connect(function()
        if activeTab ~= tab then tw(tab.Button, { BackgroundColor3 = T.ELEMENT_HOV, TextColor3 = T.TEXT }) end
    end)
    tab.Button.MouseLeave:Connect(function()
        if activeTab ~= tab then tw(tab.Button, { BackgroundColor3 = T.ELEMENT, TextColor3 = T.TEXT_DIM }) end
    end)
    tab.Button.MouseButton1Click:Connect(function()
        playClick()
        if activeTab then
            activeTab.Content.Visible = false
            tw(activeTab.Button, { BackgroundColor3 = T.ELEMENT, TextColor3 = T.TEXT_DIM })
            local oS = activeTab.Button:FindFirstChildOfClass("UIStroke")
            if oS then oS.Color = T.BORDER_SOFT; oS.Transparency = 0.15 end
        end
        activeTab = tab
        tab.Content.Visible = true
        tab.Content.BackgroundTransparency = 1
        tab.Content.Position = UDim2.new(0, 22, 0, 10)
        tw(tab.Content, { Position = UDim2.new(0, 10, 0, 10) }, 0.22)
        tw(tab.Button, { BackgroundColor3 = T.ELEMENT_ACT, TextColor3 = T.TEXT })
        s.Color = T.ACCENT; s.Transparency = 0
    end)
    registerAccent(function() if activeTab == tab then s.Color = T.ACCENT end end)
    table.insert(tabs, tab)
    if #tabs == 1 then
        tab.Content.Visible = true; activeTab = tab
        tab.Content.BackgroundTransparency = 1
        tab.Content.Position = UDim2.new(0, 22, 0, 10)
        tw(tab.Content, { Position = UDim2.new(0, 10, 0, 10) }, 0.22)
        tw(tab.Button, { BackgroundColor3 = T.ELEMENT_ACT, TextColor3 = T.TEXT })
        s.Color = T.ACCENT; s.Transparency = 0
    end
    return tab
end
print("[11] createTab OK")

local activeList = {}
local activeUI = nil
local function refreshActiveUI()
    if not activeUI then return end
    for _, c in ipairs(activeUI:GetChildren()) do
        if c:IsA("TextLabel") or c:IsA("Frame") then c:Destroy() end
    end
    local count = 0
    for name, state in pairs(activeList) do
        if state then
            count = count + 1
            local row = new("Frame", {
                BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 22), BorderSizePixel = 0,
            }, activeUI)
            corner(row, 4); stroke(row, T.BORDER_SOFT, 1, 0.2)
            new("Frame", { BackgroundColor3 = T.ON, Size = UDim2.fromOffset(6, 6),
                Position = UDim2.new(0, 10, 0.5, -3), BorderSizePixel = 0 }, row)
            new("TextLabel", {
                BackgroundTransparency = 1, Position = UDim2.new(0, 24, 0, 0),
                Size = UDim2.new(1, -30, 1, 0), Font = FONT,
                Text = name, TextColor3 = T.TEXT, TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, row)
        end
    end
    if count == 0 then
        new("TextLabel", {
            BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22),
            Font = FONT, Text = "  Ninguna activa",
            TextColor3 = T.TEXT_DIM, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, activeUI)
    end
end
print("[12] refreshActiveUI OK")

-- ═══ COMPONENTES ═══
local function section(tab, title)
    local sec = new("Frame", {
        BackgroundColor3 = T.PANEL, Size = UDim2.new(1, 0, 0, 26), BorderSizePixel = 0,
    }, tab.Content)
    corner(sec, 6); stroke(sec, T.BORDER_SOFT, 1, 0.3)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -20, 1, 0), Font = FONT_B,
        Text = title, TextColor3 = T.TEXT, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, sec)
end

local function toggle(tab, cfg)
    cfg = cfg or {}
    local hasDesc = cfg.Desc and cfg.Desc ~= ""
    local H = hasDesc and 48 or 38
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, H), BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)
    local dot = new("Frame", {
        BackgroundColor3 = T.ON, Size = UDim2.fromOffset(6, 6),
        Position = UDim2.new(0, 10, hasDesc and 0 or 0.5, hasDesc and 12 or -3),
        BorderSizePixel = 0, BackgroundTransparency = cfg.Value and 0 or 1,
    }, c)
    corner(dot, 3)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 24, 0, hasDesc and 6 or 0),
        Size = UDim2.new(1, -100, 0, hasDesc and 15 or H),
        Font = FONT_B, Text = cfg.Title or "Toggle",
        TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)
    if hasDesc then
        new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 24, 0, 22),
            Size = UDim2.new(1, -100, 0, 13), Font = FONT,
            Text = cfg.Desc, TextColor3 = T.TEXT_DIM, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end
    local switch = new("Frame", {
        BackgroundColor3 = cfg.Value and T.ON or T.OFF,
        Position = UDim2.new(1, -48, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(36, 18), BorderSizePixel = 0,
    }, c)
    corner(switch, 9); stroke(switch, T.BORDER_SOFT, 1, 0.25)
    local knob = new("Frame", {
        BackgroundColor3 = T.TEXT,
        Position = cfg.Value and UDim2.new(1, -16, 0, 2) or UDim2.new(0, 2, 0, 2),
        Size = UDim2.fromOffset(14, 14), BorderSizePixel = 0,
    }, switch)
    corner(knob, 7)
    local btn = new("TextButton", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Text = "", AutoButtonColor = false,
    }, c)
    local state = cfg.Value or false
    btn.MouseButton1Click:Connect(function()
        state = not state
        playClick()
        tw(switch, { BackgroundColor3 = state and T.ON or T.OFF }, 0.2)
        tw(knob, { Position = state and UDim2.new(1, -16, 0, 2) or UDim2.new(0, 2, 0, 2) }, 0.2)
        tw(dot, { BackgroundTransparency = state and 0 or 1 }, 0.15)
        activeList[cfg.Title] = state
        refreshActiveUI()
        notify(state and "Activado" or "Desactivado", cfg.Title, state and T.ON or T.CLOSE_HOV)
        if cfg.Callback then cfg.Callback(state) end
    end)
end

local function input(tab, cfg)
    cfg = cfg or {}
    local hasDesc = cfg.Desc and cfg.Desc ~= ""
    local H = hasDesc and 72 or 58
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, H), BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 6),
        Size = UDim2.new(1, -100, 0, 15), Font = FONT_B,
        Text = cfg.Title or "Input", TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)
    if hasDesc then
        new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 22),
            Size = UDim2.new(1, -100, 0, 13), Font = FONT,
            Text = cfg.Desc, TextColor3 = T.TEXT_DIM, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end
    local boxY = hasDesc and 42 or 28
    local box = new("Frame", {
        BackgroundColor3 = T.BG, Position = UDim2.new(0, 12, 0, boxY),
        Size = UDim2.new(1, -24, 0, 24), BorderSizePixel = 0,
    }, c)
    corner(box, 5); stroke(box, T.BORDER_SOFT, 1, 0.2)
    local tb = new("TextBox", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 8, 0, 0),
        Size = UDim2.new(1, -16, 1, 0), Font = FONT,
        Text = tostring(cfg.Value or ""),
        PlaceholderText = cfg.Placeholder or "escribe aqui...",
        PlaceholderColor3 = T.TEXT_DIM, TextColor3 = T.TEXT,
        TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
    }, box)
    tb.FocusLost:Connect(function()
        if cfg.Callback then cfg.Callback(tb.Text) end
    end)
end

local function slider(tab, cfg)
    cfg = cfg or {}
    local min = cfg.Min or 0; local max = cfg.Max or 100
    local step = cfg.Step or 1; local val = cfg.Default or min
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 64), BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 7),
        Size = UDim2.new(1, -100, 0, 15), Font = FONT_B,
        Text = cfg.Title or "Slider", TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)
    local valLbl = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(1, -80, 0, 7),
        Size = UDim2.new(0, 68, 0, 15), Font = FONT_B,
        Text = tostring(val), TextColor3 = T.ACCENT, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, c)
    local barBg = new("Frame", {
        BackgroundColor3 = T.OFF, Position = UDim2.new(0, 12, 0, 40),
        Size = UDim2.new(1, -24, 0, 8), BorderSizePixel = 0,
    }, c)
    corner(barBg, 4); stroke(barBg, T.BORDER_SOFT, 1, 0.25)
    local fill = new("Frame", {
        BackgroundColor3 = T.ACCENT, Size = UDim2.new(0, 0, 1, 0), BorderSizePixel = 0,
    }, barBg)
    corner(fill, 4)
    local knob = new("Frame", {
        BackgroundColor3 = T.TEXT, Size = UDim2.fromOffset(14, 14),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0), BorderSizePixel = 0,
    }, barBg)
    corner(knob, 7); stroke(knob, T.BORDER_SOFT, 1)
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
        val = snapped; upd(val)
        if cfg.Callback then cfg.Callback(val) end
    end
    barBg.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true; setFromX(i.Position.X)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            setFromX(i.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    registerAccent(function() fill.BackgroundColor3 = T.ACCENT; valLbl.TextColor3 = T.ACCENT end)
end

local function dropdown(tab, cfg)
    cfg = cfg or {}
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, cfg.Desc and 50 or 42), BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, cfg.Desc and 5 or 0),
        Size = UDim2.new(1, -110, 0, cfg.Desc and 15 or 42), Font = FONT_B,
        Text = cfg.Title or "Dropdown", TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)
    if cfg.Desc then
        new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 20),
            Size = UDim2.new(1, -110, 0, 13), Font = FONT,
            Text = cfg.Desc, TextColor3 = T.TEXT_DIM, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
    end
    local curVal = cfg.Value or (cfg.Values and cfg.Values[1]) or "-"
    local btn = new("TextButton", {
        BackgroundColor3 = T.BG, Position = UDim2.new(1, -105, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 95, 0, 26),
        Font = FONT, Text = curVal .. "  v",
        TextColor3 = T.TEXT, TextSize = 11, AutoButtonColor = false, BorderSizePixel = 0,
    }, c)
    corner(btn, 5); stroke(btn, T.BORDER_SOFT, 1, 0.25)
    local list = new("Frame", {
        BackgroundColor3 = T.BG,
        Size = UDim2.new(0, 130, 0, (#(cfg.Values or {}) * 26) + 6),
        Position = UDim2.new(1, -135, 1, 4),
        Visible = false, BorderSizePixel = 0, ZIndex = 100,
    }, c)
    corner(list, 5); stroke(list, T.BORDER_SOFT, 1, 0.2)
    new("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, list)
    local open = false
    local function refresh()
        for _, item in ipairs(list:GetChildren()) do
            if item:IsA("TextButton") then item:Destroy() end
        end
        for _, v in ipairs(cfg.Values or {}) do
            local item = new("TextButton", {
                BackgroundColor3 = v == curVal and T.ELEMENT_ACT or T.BG,
                Size = UDim2.new(1, -6, 0, 22), Font = FONT, Text = v,
                TextColor3 = v == curVal and T.ACCENT or T.TEXT,
                TextSize = 11, AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 101,
            }, list)
            item.Position = UDim2.new(0, 3, 0, 3 + (#list:GetChildren() - 1) * 24)
            item.MouseEnter:Connect(function() if v ~= curVal then item.BackgroundColor3 = T.ELEMENT_HOV end end)
            item.MouseLeave:Connect(function() if v ~= curVal then item.BackgroundColor3 = T.BG end end)
            item.MouseButton1Click:Connect(function()
                curVal = v; btn.Text = v .. "  v"
                list.Visible = false; open = false
                refresh()
                if cfg.Callback then cfg.Callback(v) end
            end)
        end
    end
    btn.MouseButton1Click:Connect(function()
        open = not open
        list.Visible = open
        if open then refresh() end
    end)
end

local function colorPickerRGB(tab, title, defaultColor, callback)
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 160), BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 10),
        Size = UDim2.new(1, -70, 0, 15), Font = FONT_B,
        Text = title, TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)
    local preview = new("Frame", {
        BackgroundColor3 = defaultColor, Position = UDim2.new(1, -56, 0, 8),
        Size = UDim2.fromOffset(42, 42), BorderSizePixel = 0,
    }, c)
    corner(preview, 5); stroke(preview, T.BORDER_SOFT, 1, 0.4)
    local hexLbl = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(1, -60, 0, 52),
        Size = UDim2.fromOffset(50, 12), Font = FONT,
        Text = "#------", TextColor3 = T.TEXT_DIM, TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Center,
    }, c)
    local curR = math.floor(defaultColor.R * 255 + 0.5)
    local curG = math.floor(defaultColor.G * 255 + 0.5)
    local curB = math.floor(defaultColor.B * 255 + 0.5)
    local function apply()
        preview.BackgroundColor3 = Color3.fromRGB(curR, curG, curB)
        hexLbl.Text = string.format("#%02X%02X%02X", curR, curG, curB)
        if callback then callback(Color3.fromRGB(curR, curG, curB)) end
    end
    local function buildSlider(y, label, initialVal, tint, onChange)
        new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, y),
            Size = UDim2.new(0, 20, 0, 16), Font = FONT_B,
            Text = label, TextColor3 = tint, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, c)
        local valLbl = new("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.new(1, -54, 0, y),
            Size = UDim2.new(0, 40, 0, 16), Font = FONT_B,
            Text = tostring(initialVal), TextColor3 = T.TEXT, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Right,
        }, c)
        local barBg = new("Frame", {
            BackgroundColor3 = T.OFF, Position = UDim2.new(0, 36, 0, y + 4),
            Size = UDim2.new(1, -102, 0, 8), BorderSizePixel = 0,
        }, c)
        corner(barBg, 4); stroke(barBg, T.BORDER_SOFT, 1, 0.25)
        local pct0 = initialVal / 255
        local fill = new("Frame", {
            BackgroundColor3 = tint, Size = UDim2.new(pct0, 0, 1, 0), BorderSizePixel = 0,
        }, barBg)
        corner(fill, 4)
        local knob = new("Frame", {
            BackgroundColor3 = T.TEXT, Size = UDim2.fromOffset(12, 12),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(pct0, 0, 0.5, 0), BorderSizePixel = 0,
        }, barBg)
        corner(knob, 6); stroke(knob, T.BORDER_SOFT, 1)
        local dragging = false
        local function setFromX(x)
            local abs = barBg.AbsolutePosition.X
            local w = barBg.AbsoluteSize.X
            local pct = math.clamp((x - abs) / w, 0, 1)
            local v = math.floor(pct * 255 + 0.5)
            fill.Size = UDim2.new(pct, 0, 1, 0)
            knob.Position = UDim2.new(pct, 0, 0.5, 0)
            valLbl.Text = tostring(v)
            onChange(v); apply()
        end
        barBg.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = true; setFromX(i.Position.X)
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                setFromX(i.Position.X)
            end
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end
    buildSlider(66, "R", curR, Color3.fromRGB(255, 90, 90), function(v) curR = v end)
    buildSlider(94, "G", curG, Color3.fromRGB(90, 255, 120), function(v) curG = v end)
    buildSlider(122, "B", curB, Color3.fromRGB(90, 150, 255), function(v) curB = v end)
    apply()
end

local ACCENT_PRESETS = {
    { Name = "Amarillo", C = Color3.fromRGB(255, 200, 0) },
    { Name = "Rojo",     C = Color3.fromRGB(230, 70, 70) },
    { Name = "Verde",    C = Color3.fromRGB(70, 200, 110) },
    { Name = "Azul",     C = Color3.fromRGB(80, 160, 255) },
    { Name = "Morado",   C = Color3.fromRGB(170, 100, 255) },
    { Name = "Rosa",     C = Color3.fromRGB(255, 120, 180) },
    { Name = "Cyan",     C = Color3.fromRGB(80, 220, 220) },
    { Name = "Blanco",   C = Color3.fromRGB(240, 240, 240) },
}
local function colorPicker(tab, title)
    local c = new("Frame", {
        BackgroundColor3 = T.ELEMENT, Size = UDim2.new(1, 0, 0, 92), BorderSizePixel = 0,
    }, tab.Content)
    corner(c, 6); stroke(c, T.BORDER_SOFT, 1, 0.15)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 6),
        Size = UDim2.new(1, -20, 0, 15), Font = FONT_B,
        Text = title, TextColor3 = T.TEXT, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, c)
    local grid = new("Frame", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 28),
        Size = UDim2.new(1, -24, 0, 56), BorderSizePixel = 0,
    }, c)
    new("UIGridLayout", {
        CellSize = UDim2.fromOffset(32, 24), CellPadding = UDim2.fromOffset(8, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, grid)
    for _, preset in ipairs(ACCENT_PRESETS) do
        local b = new("TextButton", {
            BackgroundColor3 = preset.C, Size = UDim2.fromOffset(32, 24),
            Text = "", AutoButtonColor = false, BorderSizePixel = 0,
        }, grid)
        corner(b, 5); stroke(b, T.BORDER_SOFT, 1, 0.3)
        b.MouseButton1Click:Connect(function()
            playClick()
            setAccent(preset.C)
            notify("Tema cambiado", preset.Name, preset.C)
        end)
    end
end
print("[13] Componentes OK")

local watermarkEnabled = false
local wmFrame = new("Frame", {
    Name = "Watermark", BackgroundColor3 = T.BG, BackgroundTransparency = 0.15,
    Size = UDim2.fromOffset(230, 24), Position = UDim2.new(1, -240, 0, 8),
    Visible = false, BorderSizePixel = 0, Active = true,
}, screenGui)
corner(wmFrame, 5); stroke(wmFrame, T.BORDER_SOFT, 1, 0.2)
local wmLabel = new("TextLabel", {
    BackgroundTransparency = 1, Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 5, 0, 0), Font = FONT_B,
    Text = "BRAGAO HUB  |  FPS: --  |  -- ms",
    TextColor3 = T.TEXT, TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Center,
}, wmFrame)

local wD, wS
wmFrame.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        wD = i.Position; wS = wmFrame.Position
        local c; c = i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then wD = nil; c:Disconnect() end
        end)
    end
end)
UIS.InputChanged:Connect(function(i)
    if wD and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - wD
        wmFrame.Position = UDim2.new(wS.X.Scale, wS.X.Offset + d.X, wS.Y.Scale, wS.Y.Offset + d.Y)
    end
end)

local fpsCount, fpsTime, currentFPS = 0, 0, 60
RunService.RenderStepped:Connect(function(dt)
    fpsCount = fpsCount + 1
    fpsTime = fpsTime + dt
    if fpsTime >= 1 then currentFPS = fpsCount; fpsCount = 0; fpsTime = 0 end
end)
task.spawn(function()
    while true do
        task.wait(0.5)
        if watermarkEnabled then
            local ping = 0
            pcall(function() ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
            wmLabel.Text = string.format("BRAGAO HUB  |  FPS: %d  |  %d ms", currentFPS, ping)
        end
    end
end)
print("[14] Watermark OK")

local tabCombat   = createTab("Combat")
local tabAim      = createTab("Aim")
local tabBlacklist= createTab("Blacklist")
local tabMovement = createTab("Movement")
local tabVisual   = createTab("Visual")
local tabUtils    = createTab("Utils")
print("[15] Tabs creadas")

-- ═══ COMBAT ═══
section(tabCombat, "Silent Aim")
toggle(tabCombat, { Title = "Silent Aim Players", Desc = "Apunta a jugadores enemigos", Value = false,
    Callback = function(v) Config.SilentAimPlayers = v; if v then installSilentAim() end end })
slider(tabCombat, { Title = "Detection Range", Desc = "Distancia maxima (studs)",
    Min = 50, Max = 2000, Step = 10, Default = State.maxRange,
    Callback = function(v) State.maxRange = v end })
toggle(tabCombat, { Title = "Silent Aim NPCs", Desc = "Apunta a NPCs enemigos", Value = false,
    Callback = function(v) Config.SilentAimNPCs = v; if v then installSilentAim() end end })
toggle(tabCombat, { Title = "Auto Ken", Desc = "Activa Ken automaticamente", Value = false,
    Callback = function(v) Config.AutoKen = v; if v then startAutoKenLoop() end end })

section(tabCombat, "Hitbox Expander")
toggle(tabCombat, { Title = "Hitbox Expander", Value = false,
    Callback = function(v)
        Hitbox.Enabled = v
        if not v then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= lp and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then resetHRP(hrp) end
                end
            end
        end
    end })
toggle(tabCombat, { Title = "Enemy Only", Value = true, Callback = function(v) Hitbox.EnemyOnly = v end })
toggle(tabCombat, { Title = "Aplicar a NPCs", Value = false, Callback = function(v) Hitbox.NPCs = v end })
slider(tabCombat, { Title = "Hitbox Size", Min = 2, Max = 30, Step = 1, Default = 10,
    Callback = function(v) Hitbox.Size = v end })
slider(tabCombat, { Title = "Transparency", Min = 0, Max = 1, Step = 0.05, Default = 0.7,
    Callback = function(v) Hitbox.Transparency = v end })

section(tabCombat, "Nearest Enemy Indicator")
toggle(tabCombat, { Title = "Mostrar indicador", Value = false, Callback = function(v) NearestEnemy.Enabled = v end })
toggle(tabCombat, { Title = "Mostrar en pantalla", Value = true, Callback = function(v) NearestEnemy.ShowOnScreen = v end })
toggle(tabCombat, { Title = "Mostrar fuera de pantalla", Value = true, Callback = function(v) NearestEnemy.ShowOffScreen = v end })
toggle(tabCombat, { Title = "Mostrar nombre", Value = true, Callback = function(v) NearestEnemy.ShowName = v end })
toggle(tabCombat, { Title = "Mostrar distancia", Value = true, Callback = function(v) NearestEnemy.ShowDistance = v end })
slider(tabCombat, { Title = "Max Range", Min = 50, Max = 2000, Step = 10, Default = 500,
    Callback = function(v) NearestEnemy.MaxRange = v end })
slider(tabCombat, { Title = "Dot Radius", Min = 15, Max = 100, Step = 1, Default = 40,
    Callback = function(v) NearestEnemy.DotRadius = v end })
colorPickerRGB(tabCombat, "Indicator Color", NearestEnemy.Color, function(c) NearestEnemy.Color = c end)

-- ═══ AIM ═══
section(tabAim, "Prediction (Bragao)")
toggle(tabAim, { Title = "Prediction", Desc = "Predice posicion del enemigo", Value = false,
    Callback = function(v) Config.Prediction = v end })
input(tabAim, { Title = "Prediction Amount", Desc = "Multiplicador base (ej. 0.1)",
    Value = tostring(Config.PredictionAmount), Placeholder = "0.1",
    Callback = function(t) local n = tonumber(t); if n then Config.PredictionAmount = n end end })
input(tabAim, { Title = "Max Range (input)", Value = tostring(State.maxRange), Placeholder = "500",
    Callback = function(t) local n = tonumber(t); if n then State.maxRange = n end end })

section(tabAim, "Precision Avanzada (Bragao)")
dropdown(tabAim, { Title = "Aim Part", Desc = "Parte del cuerpo a apuntar",
    Values = {"Head", "HumanoidRootPart", "UpperTorso"},
    Value = AimConfig.AimPart,
    Callback = function(v) AimConfig.AimPart = v; State.PosBuffer = {} end })
toggle(tabAim, { Title = "Ping Compensation", Desc = "Compensa el delay", Value = true,
    Callback = function(v) AimConfig.PingCompensation = v end })
toggle(tabAim, { Title = "Distance Multiplier", Desc = "Mas prediccion a mayor distancia", Value = true,
    Callback = function(v) AimConfig.DistanceMultiplier = v end })
toggle(tabAim, { Title = "Visible Check", Desc = "Ignora enemigos detras de paredes", Value = false,
    Callback = function(v) AimConfig.VisibleCheck = v end })
slider(tabAim, { Title = "Target Lock", Desc = "Segundos manteniendo target",
    Min = 0, Max = 1, Step = 0.01, Default = 0.15,
    Callback = function(v) AimConfig.TargetLockDuration = v end })
slider(tabAim, { Title = "Smoothing", Desc = "Suavizado (1 = off)",
    Min = 1, Max = 10, Step = 1, Default = 3,
    Callback = function(v) AimConfig.SmoothingSamples = v; State.PosBuffer = {} end })
slider(tabAim, { Title = "Max Visible Range", Desc = "Rango del raycast",
    Min = 100, Max = 2000, Step = 50, Default = 800,
    Callback = function(v) AimConfig.MaxVisibleRange = v end })

section(tabAim, "Coverage (Michelle)")
dropdown(tabAim, { Title = "Aim Mode", Desc = "360 = todos, 180 = enfrente, FOV = circulo",
    Values = {"360", "180", "FOV"},
    Value = AimConfig.AimMode,
    Callback = function(v) AimConfig.AimMode = v end })
dropdown(tabAim, { Title = "Target Priority", Desc = "Como elegir objetivo",
    Values = {"Nearest", "Low HP", "HighestHP", "Looking At Me", "Lock Player"},
    Value = AimConfig.TargetPriority,
    Callback = function(v) AimConfig.TargetPriority = v end })
input(tabAim, { Title = "Lock Player Name", Desc = "Nombre exacto (si Priority = Lock Player)",
    Value = AimConfig.LockedPlayerName or "", Placeholder = "Username",
    Callback = function(t) AimConfig.LockedPlayerName = (t ~= "" and t) or nil end })
toggle(tabAim, { Title = "Override Mouse.Hit", Desc = "Godhuman/Sanguine/Sword Z apuntan al enemigo", Value = true,
    Callback = function(v) AimConfig.OverrideMouseHit = v end })
toggle(tabAim, { Title = "Face Target", Desc = "Gira personaje al enemigo al usar skill", Value = true,
    Callback = function(v) AimConfig.FaceTarget = v end })

section(tabAim, "Protecciones")
toggle(tabAim, { Title = "Protect Safe Zone", Desc = "No apunta en safe zones", Value = true,
    Callback = function(v) AimConfig.ProtectSafeZone = v end })
toggle(tabAim, { Title = "Protect ForceField", Desc = "No apunta con ForceField", Value = true,
    Callback = function(v) AimConfig.ProtectForceField = v end })

section(tabAim, "Soru Auto Aim (Skill C)")
toggle(tabAim, { Title = "Soru Enabled", Desc = "Apuntar Soru automaticamente", Value = false,
    Callback = function(v) AimConfig.SoruEnabled = v end })
slider(tabAim, { Title = "Soru Range", Min = 50, Max = 1000, Step = 10, Default = 300,
    Callback = function(v) AimConfig.SoruRange = v end })
dropdown(tabAim, { Title = "Soru Priority", Values = {"Nearest", "Low HP", "Looking At Me"},
    Value = "Nearest",
    Callback = function(v) AimConfig.SoruPriority = v end })
slider(tabAim, { Title = "Soru FOV Radius", Min = 10, Max = 1000, Step = 10, Default = 150,
    Callback = function(v) AimConfig.SoruFOVRadius = v end })

-- ═══ BLACKLIST ═══
section(tabBlacklist, "Melees")
for _, key in ipairs({"Z", "X", "C", "V", "F"}) do
    toggle(tabBlacklist, { Title = "Melee " .. key, Desc = "No aplicar silent aim",
        Value = AimConfig.Blacklist.Melee[key],
        Callback = function(v) AimConfig.Blacklist.Melee[key] = v end })
end

section(tabBlacklist, "Swords")
for _, key in ipairs({"Z", "X", "C", "V", "F"}) do
    toggle(tabBlacklist, { Title = "Sword " .. key, Desc = "No aplicar silent aim",
        Value = AimConfig.Blacklist.Sword[key],
        Callback = function(v) AimConfig.Blacklist.Sword[key] = v end })
end

section(tabBlacklist, "Fruits")
for _, key in ipairs({"Z", "X", "C", "V", "F", "TAP"}) do
    toggle(tabBlacklist, { Title = "Fruit " .. key, Desc = "No aplicar silent aim",
        Value = AimConfig.Blacklist.Fruit[key],
        Callback = function(v) AimConfig.Blacklist.Fruit[key] = v end })
end

section(tabBlacklist, "Guns")
for _, key in ipairs({"Z", "X", "C", "V", "F"}) do
    toggle(tabBlacklist, { Title = "Gun " .. key, Desc = "No aplicar silent aim",
        Value = AimConfig.Blacklist.Gun[key],
        Callback = function(v) AimConfig.Blacklist.Gun[key] = v end })
end

-- ═══ MOVEMENT ═══
section(tabMovement, "Salto")
toggle(tabMovement, { Title = "Infinite Jump", Value = false,
    Callback = function(v) Config.InfiniteJump = v; setupInfiniteJump() end })
section(tabMovement, "Velocidad")
input(tabMovement, { Title = "Walk Speed", Desc = "16 - 100",
    Value = tostring(Config.WalkSpeed), Placeholder = "16",
    Callback = function(t) local n = tonumber(t); if n then n = math.clamp(n, 16, 100); Config.WalkSpeed = n end end })

-- ═══ VISUAL ═══
section(tabVisual, "ESP Toggles")
toggle(tabVisual, { Title = "ESP Name + Distance", Value = false, Callback = function(v) ESP.NameEnabled = v end })
toggle(tabVisual, { Title = "ESP Tracers", Value = false, Callback = function(v) ESP.TracersEnabled = v end })
toggle(tabVisual, { Title = "Box ESP", Value = false, Callback = function(v) ESP.BoxEnabled = v end })
toggle(tabVisual, { Title = "Health Bar ESP", Value = false, Callback = function(v) ESP.HealthEnabled = v end })
toggle(tabVisual, { Title = "Chams", Value = false, Callback = function(v) ESP.ChamsEnabled = v end })
toggle(tabVisual, { Title = "Skeleton ESP", Value = false, Callback = function(v) ESP.SkeletonEnabled = v end })

section(tabVisual, "Ajustes")
slider(tabVisual, { Title = "Text Size", Min = 10, Max = 22, Step = 1, Default = 14,
    Callback = function(v) ESP.TextSize = v end })
slider(tabVisual, { Title = "Tracer Thickness", Min = 0.5, Max = 4, Step = 0.1, Default = 1.5,
    Callback = function(v) ESP.TracerThickness = v end })

section(tabVisual, "Limite de distancia")
toggle(tabVisual, { Title = "Limitar distancia ESP", Value = false, Callback = function(v) ESP.LimitDistance = v end })
slider(tabVisual, { Title = "Max Distance", Min = 50, Max = 500, Step = 10, Default = 250,
    Callback = function(v) ESP.MaxDistance = v end })

section(tabVisual, "Colores ESP")
colorPickerRGB(tabVisual, "Name Color", ESP.NameColor, function(c) ESP.NameColor = c end)
colorPickerRGB(tabVisual, "Tracer Color", ESP.TracerColor, function(c) ESP.TracerColor = c end)
colorPickerRGB(tabVisual, "Box Color", ESP.BoxColor, function(c) ESP.BoxColor = c end)
colorPickerRGB(tabVisual, "Skeleton Color", ESP.SkeletonColor, function(c) ESP.SkeletonColor = c end)
colorPickerRGB(tabVisual, "Chams Color", ESP.ChamsColor, function(c) ESP.ChamsColor = c end)

section(tabVisual, "FOV Circle")
toggle(tabVisual, { Title = "Mostrar FOV Circle", Value = false, Callback = function(v) FOV.Enabled = v end })
toggle(tabVisual, { Title = "Highlight FOV cuando enemigo dentro", Value = true,
    Callback = function(v) FOV.HighlightInFOV = v end })
slider(tabVisual, { Title = "FOV Size", Min = 40, Max = 400, Step = 1, Default = 160,
    Callback = function(v) FOV.Size = v end })
slider(tabVisual, { Title = "FOV Thickness", Min = 0.5, Max = 4, Step = 0.1, Default = 1.6,
    Callback = function(v) FOV.Thickness = v end })
colorPickerRGB(tabVisual, "FOV Base Color", FOV.Color, function(c) FOV.Color = c end)
colorPickerRGB(tabVisual, "FOV Enemy Color", FOV.EnemyColor, function(c) FOV.EnemyColor = c end)

section(tabVisual, "Tema UI")
colorPicker(tabVisual, "Color de acento")

-- ═══ UTILS ═══
section(tabUtils, "Utilidades")
toggle(tabUtils, { Title = "Anti-AFK", Value = false,
    Callback = function(v) Config.AntiAFK = v; setupAntiAFK() end })
toggle(tabUtils, { Title = "Watermark", Value = false,
    Callback = function(v) watermarkEnabled = v; wmFrame.Visible = v end })

section(tabUtils, "Opciones activas")
activeUI = new("Frame", {
    BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y, BorderSizePixel = 0,
}, tabUtils.Content)
new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, activeUI)
refreshActiveUI()

print("[16] Opciones OK")

notify("Bragao Hub v15", "Silent Aim fusionado (Bragao+Michelle)", T.ACCENT)
print("[17] LISTO")
