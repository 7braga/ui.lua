-- ═══════════════════════════════════════════════════════════════
-- TSB TECHS EXTRAÍDAS
-- King Tech | Oreo | Lethal Dash | Boomy | Insta | Lethal Normal
-- ═══════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- ═══ CONSTANTES ═══
local UPPERCUT = {
    [13156066514] = true,  -- Uppercut animation ID
}

local TARGET_ANIM_ID = 12296113986  -- Lethal trigger animation
local onCooldown = false

-- ═══ CONFIGURACIÓN DE TECHS ═══
local Config = {
    KingTechEnabled = false,
    OreoDripzEnabled = false,
    LethalDashEnabled = false,
    BoomyEnabled = false,
    InstaLethalEnabled = false,
    LethalNormalEnabled = false,
}

-- King settings
local kingstart = 0.3
local kingwait = 0.2

-- Oreo/Dripz settings
local oreostart = 0.3
local oreowait = 0.5
local oreocam = 1
local oreojump = 54

-- Boomy settings
local boomystart = 1.7
local boomyjump = 65
local boomywait = 0.1
local boomycam = 3

-- Instant Lethal settings
local instantlethalstart = 1.7
local instantlethalwait = 0.5

-- Lethal Normal settings
local meowlethalstart = 1.7
local meowlethaldur = 0.5

-- Lethal Dash settings
local normallethalstart = 1.7
local secondforflip = 0.2

-- ═══ FUNCIONES AUXILIARES ═══
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

-- ═══ TECHS ═══

-- KING TECH
local function kingTech(anim)
    if Config.KingTechEnabled and UPPERCUT[anim.AnimationId] then
        if not onCooldown then
            local enemy = getClosestEnemy(10)
            if enemy then
                task.delay(kingstart, function()
                    autoPressQ()
                    forceJump()
                    task.delay(kingwait, flip)
                end)
            end
        end
    end
end

-- OREO / DRIPZ TECH
local function oreoTech(anim)
    if Config.OreoDripzEnabled and UPPERCUT[anim.AnimationId] then
        if not onCooldown then
            local enemy = getClosestEnemy(10)
            if enemy then
                task.delay(oreostart, function()
                    autoPressQ()
                    forceJump(oreojump)
                end)
                
                task.delay(oreowait, function()
                    local startTime = tick()
                    local cam = workspace.CurrentCamera
                    local targetChar = enemy
                    local targetPart = targetChar:FindFirstChild("Right Arm")
                    
                    if not targetPart then
                        targetPart = getRoot(targetChar)
                    end
                    
                    local DRIPZ_CAMERA_SPEED = oreocam
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
                            local newYaw = currentYaw + (targetYaw - currentYaw) * DRIPZ_CAMERA_SPEED
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
end

-- BOOMY TECH
local function boomyTech(animId)
    if Config.BoomyEnabled and animId == TARGET_ANIM_ID then
        local enemy = getClosestEnemy(10)
        if enemy then
            task.delay(boomystart, function()
                autoPressQ()
                flip()
                forceJump(boomyjump)
                task.wait(boomywait)
                
                local startTime = tick()
                local cam = workspace.CurrentCamera
                local targetChar = enemy
                local targetPart = targetChar:FindFirstChild("Right Arm")
                
                if not targetPart then
                    targetPart = getRoot(targetChar)
                end
                
                local DRIPZ_CAMERA_SPEED = boomycam
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
                        local newYaw = currentYaw + (targetYaw - currentYaw) * DRIPZ_CAMERA_SPEED
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

-- INSTA LETHAL TECH
local function instaLethalTech(animId)
    if Config.InstaLethalEnabled and animId == TARGET_ANIM_ID then
        if not onCooldown then
            local enemy = getClosestEnemy(10)
            if enemy then
                task.delay(instantlethalstart, function()
                    autoPressQ()
                    forceJump(60)
                    task.delay(instantlethalwait, function()
                        -- Code cleanup
                    end)
                    
                    local startTime = tick()
                    local cam = workspace.CurrentCamera
                    local targetChar = enemy
                    local targetPart = targetChar:FindFirstChild("Right Arm")
                    
                    if not targetPart then
                        targetPart = getRoot(targetChar)
                    end
                    
                    local DRIPZ_CAMERA_SPEED = 3
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
                            local newYaw = currentYaw + (targetYaw - currentYaw) * DRIPZ_CAMERA_SPEED
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
end

-- LETHAL NORMAL TECH
local function lethalNormalTech(animId)
    if Config.LethalNormalEnabled and animId == TARGET_ANIM_ID then
        task.spawn(function()
            task.delay(meowlethalstart, function()
                local enemy = getClosestEnemy(10)
                if enemy then
                    fireQ()
                    attachTo(enemy, meowlethaldur, true)
                end
            end)
        end)
    end
end

-- LETHAL DASH TECH
local function lethalDashTech(animId)
    if Config.LethalDashEnabled and animId == TARGET_ANIM_ID then
        task.spawn(function()
            task.delay(normallethalstart, function()
                forceJump()
                autoPressQ()
                task.delay(secondforflip, function()
                    flip()
                end)
            end)
        end)
    end
end

-- ═══ EJECUTAR TECHS EN LOOP ═══
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

-- ═══ COMANDOS EN CONSOLA PARA ACTIVAR ═══
print("═══════════════════════════════════════════════════════")
print("TSB TECHS EXTRAÍDAS - Comandos en consola:")
print("═══════════════════════════════════════════════════════")
print("")
print("_G.Config.KingTechEnabled = true/false")
print("_G.Config.OreoDripzEnabled = true/false")
print("_G.Config.LethalDashEnabled = true/false")
print("_G.Config.BoomyEnabled = true/false")
print("_G.Config.InstaLethalEnabled = true/false")
print("_G.Config.LethalNormalEnabled = true/false")
print("")
print("Ejemplo: _G.Config.KingTechEnabled = true")
print("═══════════════════════════════════════════════════════")

_G.Config = Config
