-- This file was generated at discord.gg/syncrypt
local unpack_ = unpack or table.unpack
local t1 = {value7 = nil, value8 = {}, value11 = "__index"}
local t2 = {value1 = t1.value8}
local value12 = {__index = t2.value1, __metatable = nil}

t1.value7 = 22126428612671
t1.value12 = value12
t2.value2 = game:GetService("Players")
t1.value8 = 33503604964593
t1.value2 = "game"

local game_ = game

t1.value9 = 32235748178594
t1.value2 = "GetService"
t1.value2 = game_.GetService
t1.value6 = 18063688655067
t1.value2 = t1.value2(game_, "TweenService")
t1.value5 = "\191!\129\1\180\1931\215\228\164\200\24\5r\152\253"
t1.value3 = "game"
t2.value3 = t1.value2
t1.value3 = game:GetService("UserInputService")
t2.value4 = t1.value3
t1.value3 = game
t1.value4 = t1.value3.GetService
t1.value8 = "%\11\161\5N\15\2\199\29t\23\209\200\202.Z\14"
t1.value4 = t1.value4(t1.value3, "RunService")
t2.value5 = t1.value4

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

t1.value10 = "\144\2307s\131\167,\223s\28\129"
t1.value7 = "game"
t2.value6 = Workspace

local game_2 = game

t1.value7 = game_2.GetService
t1.value12 = "n\224\170{A\5e\188\247h\140"
t1.value7 = t1.value7(game_2, "HttpService")
t2.value7 = t1.value7
t1.value5 = game:GetService("VirtualUser")
t1.value11 = "5\25[64\231"
t1.value6 = "game"
t2.value8 = t1.value5
t1.value6 = game:GetService("Debris")
t2.value9 = t1.value6
t1.value6 = t2.value2.LocalPlayer
t2.value10 = t1.value6
t1.value6 = t2.value6.CurrentCamera
t2.value11 = t1.value6
t1.value10 = t2.value10:WaitForChild("PlayerGui")
t2.value12 = t1.value10

local WaitForChild = ReplicatedStorage.WaitForChild

t1.value11 = 5
t1.value10 = WaitForChild
t1.value10 = t1.value10(ReplicatedStorage, "Remotes", t1.value11)
t2.value13 = t1.value10

local value13 = t2.value13

t1.value10 = value13

if value13 then
    t1.value10 = t2.value13:FindFirstChild("ShootGun")
end

t2.value14 = t1.value10

local value132 = t2.value13
local value1 = t1.value1

t1.value10 = value132

if value132 then
    t1.value10 = t2.value13:FindFirstChild("Stab")
end

t2.value15 = t1.value10

local value133 = t2.value13

t1.value10 = value133

if value133 then
    t1.value10 = t2.value13:FindFirstChild("ThrowHit")
end

t2.value16 = t1.value10

local value134 = t2.value13

t1.value10 = value134

if value134 then
    t1.value10 = t2.value13:FindFirstChild("ThrowStart")
end

t2.value17 = t1.value10
t1.value10 = t2.value10.Idled
t1.value10:Connect(
    function()
        t2.value8:CaptureController()
        t2.value8:ClickButton2(Vector2.new())
    end
)

local ok, result = pcall(
    function()
        return game:GetService("CoreGui")
    end
)

t1.value10 = ok and result and result or t2.value12
t1.value13 = "ipairs"
t1.value1 = value1
t2.value18 = t1.value10
t1.value10 = ipairs

local t3 = {t2.value18, t2.value12}

for _, v in t1.value10(t3) do
    local MonochromeHubV2 = v:FindFirstChild("MonochromeHubV2")

    if MonochromeHubV2 then
        MonochromeHubV2:Destroy()
    end
end

local function v21(p1, p2)
    local instance = Instance.new(p1)

    for k, v in pairs(p2) do
        instance[k] = v
    end

    return instance
end

function t2.value19(p3, p4, p5, p6)
    local Sound = Instance.new("Sound")

    Sound.SoundId = "rbxassetid://" .. tostring(p3)
    Sound.Volume = p5 or 1
    Sound.Looped = p6 or false
    Sound.Parent = p4 or t2.value6
    Sound:Play()

    if p6 then
        return Sound
    end

    t2.value9:AddItem(Sound, 5)

    return Sound
end

t2.value20 = {
    GunCustomEnabled = false, GunCooldown = 0.03, KnifeCustomEnabled = false,
    KnifeThrowSpeed = 1000, KillAllEnabled = false, KillAllDelay = 0.1, KillAllMethod = "Default",
    LagEnabled = false, LagRemote = "ThrowHit", LagDelay = 0.01, LagBatch = 25,
    AntiLagEnabled = false, MovementEnabled = false, MovementSpeed = 16, MovementMode = "Normal",
    BhopEnabled = false, BhopBonus = 0, SpinnerEnabled = false, SpinnerSpeed = 30,
    NoclipEnabled = false, InfJumpEnabled = false, JumpPowerEnabled = false, JumpPowerValue = 50,
    GravityValue = 196.2, InvisibilityEnabled = false, InvisibilityActive = false,
    InvisibilityKeybind = Enum.KeyCode.Z, GunAuraEnabled = false, KnifeAuraEnabled = false,
    KnifeAuraRange = 25, HitboxEnabled = false, HitboxSize = 2, ESPEnabled = false,
    ESPTeamCheck = true, ESPColorName = "Red", ESPColor = Color3.fromRGB(255, 50, 50),
    FOVEnabled = false, FOVValue = 70, StretchEnabled = false, StretchValue = 1,
    FreezePlayersEnabled = false, ShahedEnabled = false, ShahedSpeed = 30, ShahedMaxTime = 20,
    ShahedRadius = 25,
    Binds = {
        ESP = Enum.KeyCode.E, KillAll = Enum.KeyCode.K, Speed = Enum.KeyCode.V,
        Invisible = Enum.KeyCode.Z, CloseHub = Enum.KeyCode.RightControl
    }
}

local color3 = Color3.fromRGB(20, 20, 20)
local color32 = Color3.fromRGB(255, 255, 255)
local color33 = Color3.fromRGB(255, 50, 50)
local color34 = Color3.fromRGB(50, 100, 255)
local color35 = Color3.fromRGB(255, 220, 50)
local color36 = Color3.fromRGB(255, 105, 180)
local color37 = Color3.fromRGB(255, 140, 0)
local color38 = Color3.fromRGB(50, 255, 100)
local color39 = Color3.fromRGB(160, 32, 240)
local color310 = Color3.fromRGB(0, 225, 255)
local color311 = Color3.fromRGB(128, 128, 128)
local color312 = Color3.fromRGB(139, 69, 19)

t2.value21 = nil
t2.value22 = {
    Black = color3, White = color32, Red = color33, Blue = color34, Yellow = color35,
    Pink = color36, Orange = color37, Green = color38, Purple = color39, Cyan = color310,
    Gray = color311, Brown = color312
}
t2.value23 = {}
t2.value24 = nil
t2.value25 = nil
t2.value24 = 0

function t2.value26()
    if not (tick() - t2.value24 > 5) then
        return t2.value23
    end

    t2.value23 = {}

    for _, descendant in ipairs(t2.value6:GetDescendants()) do
        local isBasePart = descendant:IsA("BasePart")

        if isBasePart then
            isBasePart = descendant.Name:lower():find("pad")
        end

        if isBasePart then
            local value23 = t2.value23

            table.insert(value23, descendant)
        end
    end

    t2.value24 = tick()

    return t2.value23
end
function t2.value27(p7)
    if not p7 or (p7 == t2.value10 and true or not p7.Parent) then
        return false
    end

    local Team = p7.Team
    local Character, Humanoid, v45, v46, Position, Parent

    if Team then
    elseif Team then
        return false
    else
        Character = p7.Character

        if Character and (Character.Parent and Character:IsDescendantOf(t2.value6)) then
            Humanoid = Character:FindFirstChildOfClass("Humanoid")
            v45 = not Humanoid
            v46 = Character.FindFirstChild(Character, "HumanoidRootPart")

            if v45 or (Humanoid.Health <= 0 or not (v46 and v46.Parent)) then
                return false
            else
                Position = v46.Position

                for _, v in ipairs(t2.value26()) do
                    if v then
                        Parent = v.Parent

                        if Parent then
                            Parent = (Position - v.Position).Magnitude <= 130
                        end
                    else
                        Parent = v
                    end

                    if Parent then
                        return false
                    end
                end

                return true, v46, Humanoid, Character
            end
        else
            return false
        end
    end

    Team = t2.value10.Team

    if Team then
    elseif Team then
        return false
    else
        Character = p7.Character

        if Character and (Character.Parent and Character:IsDescendantOf(t2.value6)) then
            Humanoid = Character:FindFirstChildOfClass("Humanoid")
            v45 = not Humanoid
            v46 = Character.FindFirstChild(Character, "HumanoidRootPart")

            if v45 or (Humanoid.Health <= 0 or not (v46 and v46.Parent)) then
                return false
            else
                Position = v46.Position

                for _, v in ipairs(t2.value26()) do
                    if v then
                        Parent = v.Parent

                        if Parent then
                            Parent = (Position - v.Position).Magnitude <= 130
                        end
                    else
                        Parent = v
                    end

                    if Parent then
                        return false
                    end
                end

                return true, v46, Humanoid, Character
            end
        else
            return false
        end
    end

    Team = p7.Team == t2.value10.Team

    if Team then
        return false
    else
        Character = p7.Character

        if Character and (Character.Parent and Character:IsDescendantOf(t2.value6)) then
            Humanoid = Character:FindFirstChildOfClass("Humanoid")
            v45 = not Humanoid
            v46 = Character.FindFirstChild(Character, "HumanoidRootPart")

            if v45 or (Humanoid.Health <= 0 or not (v46 and v46.Parent)) then
                return false
            else
                Position = v46.Position

                for _, v in ipairs(t2.value26()) do
                    if v then
                        Parent = v.Parent

                        if Parent then
                            Parent = (Position - v.Position).Magnitude <= 130
                        end
                    else
                        Parent = v
                    end

                    if Parent then
                        return false
                    end
                end

                return true, v46, Humanoid, Character
            end
        else
            return false
        end
    end
end

t2.value28 = nil

function t2.value29(p8)
    local Character = t2.value10.Character
    local GetChildren, isTool

    if not Character then
        v62 = t2.value10:FindFirstChild("Backpack")

        if v62 and Character then
            GetChildren = v62.GetChildren

            for _, v in ipairs(GetChildren(v62)) do
                isTool = v:IsA("Tool")

                if isTool then
                    isTool = v.Name ~= "Shahed"
                end

                if isTool then
                    Character:EquipTool(v)

                    if not p8 then
                        return v
                    end
                end
            end
        end

        return
    end

    Character = Character:FindFirstChildOfClass("Humanoid")

    local Backpack = t2.value10:FindFirstChild("Backpack")

    if Backpack and Character then
        GetChildren = Backpack.GetChildren

        for _, v in ipairs(GetChildren(Backpack)) do
            isTool = v:IsA("Tool")

            if isTool then
                isTool = v.Name ~= "Shahed"
            end

            if isTool then
                Character:EquipTool(v)

                if not p8 then
                    return v
                end
            end
        end
    end
end
function t2.value30()
    t2.value29(true)
end
function t2.value31()
    local Character = t2.value10.Character

    if Character then
        local Tool = Character:FindFirstChildOfClass("Tool")
        local v65

        if Tool then
            v65 = Tool.Name ~= "Shahed"
        else
            v65 = Tool
        end

        if v65 then
            return Tool
        else
            return t2.value29(false)
        end
    end
end

t2.value32 = "MonochromeHubV2_Config.json"

function t2.value33()
    if not writefile then
        return
    end

    local function v66()
        local t4 = {}

        for k, v in pairs(t2.value20) do
            local Name

            if typeof(v) == "EnumItem" then
                Name = v.Name
            else
                Name = false
            end

            local v71

            if Name then
                v71 = Name
            elseif typeof(v71) == "Color3" or not v71 then
                v71 = nil
            end

            t4[k] = v71
        end

        writefile(t2.value32, t2.value7:JSONEncode(t4))
    end

    pcall(v66)
end
function t2.value34()
    local readfile_ = readfile

    if readfile_ then
        readfile_ = isfile

        if readfile_ then
            readfile_ = isfile(t2.value32)
        end
    end

    if not readfile_ then
        return
    end

    local ok2, result2 = pcall(
        function()
            return t2.value7:JSONDecode(unpack_({readfile(t2.value32)}))
        end
    )

    if not ok2 then
        if ok2 then
            return result2
        end

        return
    end

    ok2 = type(result2) == "table"

    if ok2 then
        return result2
    end
end
function t2.value35(p9)
    if not p9 then
        return
    end

    local v75, v76, v77 = pairs(p9)

    while true do
        local v78

        v77, v78 = v75(v76, v77)

        if not v77 then
            break
        end

        if t2.value20[v77] ~= nil then
            local v79 = v77 == "InvisibilityKeybind"

            if v79 then
                v79 = type(v78) == "string"
            end

            if v79 then
                local function v80()
                    t2.value20[v77] = Enum.KeyCode[v78]
                end

                pcall(v80)
            else
                t2.value20[v77] = v78
            end
        end
    end

    local ESPColorName = t2.value20.ESPColorName

    if ESPColorName then
        ESPColorName = t2.value22[t2.value20.ESPColorName]
    end

    if not ESPColorName then
        return
    end

    t2.value20.ESPColor = t2.value22[t2.value20.ESPColorName]
end

t2.value28 = nil
t2.value36 = nil
t2.value37 = nil
t2.value38 = false
t2.value39 = nil
t2.value40 = nil
t2.value41 = nil
t2.value42 = nil
t2.value42 = nil
t2.value25 = 16
t2.value21 = nil

function t2.value43()
    t2.value38 = false

    if t2.value41 then
        task.cancel(t2.value41)
    end

    if t2.value42 then
        t2.value42:Disconnect()
        t2.value42 = nil
    end

    local function v82()
        t2.value10.ReplicationFocus = nil
    end

    pcall(v82)

    local InvisibilityActive = t2.value20.InvisibilityActive

    if InvisibilityActive then
        InvisibilityActive = t2.value28
    end

    local Character = InvisibilityActive or t2.value10.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        Humanoid.WalkSpeed = t2.value25
        t2.value11.CameraSubject = Humanoid
        t2.value11.CameraType = Enum.CameraType.Custom
    end

    if t2.value40 then
        t2.value40:Destroy()
    end

    if t2.value39 then
        t2.value39:Destroy()
        t2.value39 = nil
    end

    if not t2.value21 then
        return
    end

    t2.value21:Destroy()
    t2.value21 = nil
end
function t2.value44()
    local InvisibilityActive = t2.value20.InvisibilityActive
    local isTool

    if not InvisibilityActive then
        v91 = InvisibilityActive or t2.value10.Character

        if v91 then
            for _, child in ipairs(v91:GetChildren()) do
                isTool = child:IsA("Tool")

                if isTool then
                    isTool = child.Name ~= "Shahed"
                end

                if isTool then
                    return child
                end
            end

            return t2.value29(false)
        end

        return
    end

    InvisibilityActive = t2.value28

    local Character = InvisibilityActive or t2.value10.Character

    if Character then
        for _, child in ipairs(Character:GetChildren()) do
            isTool = child:IsA("Tool")

            if isTool then
                isTool = child.Name ~= "Shahed"
            end

            if isTool then
                return child
            end
        end

        return t2.value29(false)
    end
end

t2.value45 = nil
t2.value46 = nil

function t2.value47(p10)
    if not t2.value38 then
        return
    end

    local t5 = {
        Position = p10, Anchored = true, CanCollide = false, Transparency = 1, Parent = t2.value6
    }
    local Part = Instance.new("Part")

    for k, v in pairs(t5) do
        Part[k] = v
    end

    t2.value19(139810215781950, Part, 1, false)
    t2.value9:AddItem(Part, 5)
    v21(
        "Explosion",
        {Position = p10, BlastRadius = 15, DestroyJointRadiusPercent = 0, Parent = t2.value6}
    )
    t2.value44()

    for _, player in ipairs(t2.value2:GetPlayers()) do
        local v99, v100 = t2.value27(player)

        if v99 then
            v99 = (v100.Position - p10).Magnitude <= t2.value20.ShahedRadius
        end

        if v99 then
            if t2.value16 then
                t2.value16:FireServer(v100, p10)
            end

            if t2.value15 then
                t2.value15:FireServer(v100)
            end

            if t2.value14 then
                t2.value14:FireServer(p10, v100.Position, v100, v100.Position)
            end
        end
    end

    t2.value43()

    if not t2.value20.ShahedEnabled then
        return
    end

    task.delay(
        0.2,
        function()
            t2.value46()
        end
    )
end
function t2.value46()
    if not t2.value20.ShahedEnabled then
        return
    end

    local Backpack = t2.value10:WaitForChild("Backpack", 5)

    if not Backpack then
        return
    end

    if Backpack:FindFirstChild("Shahed") then
        Backpack.Shahed:Destroy()
    end

    local Character = t2.value10.Character

    if Character then
        Character = t2.value10.Character:FindFirstChild("Shahed")
    end

    if Character then
        t2.value10.Character.Shahed:Destroy()
    end

    local Tool = Instance.new("Tool")

    for k, v in pairs({Name = "Shahed", RequiresHandle = false, Parent = Backpack}) do
        Tool[k] = v
    end

    Tool.Activated:Connect(
        function()
            t2.value45()
        end
    )
end
function t2.value45()
    if t2.value38 then
        return
    end

    local InvisibilityActive = t2.value20.InvisibilityActive

    if InvisibilityActive then
        InvisibilityActive = t2.value28
    end

    local Character = InvisibilityActive or t2.value10.Character

    if not Character then
        return
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart

    if not (Humanoid and HumanoidRootPart) then
        return
    end

    t2.value38 = true

    local connection = nil

    connection = Humanoid.Died:Connect(
        function()
            connection:Disconnect()
            t2.value43()
        end
    )

    local _ = Humanoid.WalkSpeed

    Humanoid.WalkSpeed = 0

    local cFrame = CFrame.new(
        HumanoidRootPart.Position + Vector3.new(0, 4, 0),
        HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 10 + Vector3.new(0, 4, 0)
    )

    t2.value39 = v21(
        "Part",
        {
            Name = "ShahedDrone", Size = Vector3.new(2.5, 0.8, 3.5),
            Color = Color3.fromRGB(50, 50, 50), Material = Enum.Material.SmoothPlastic,
            CanCollide = false, Anchored = true, CFrame = cFrame, Parent = t2.value6
        }
    )
    t2.value19(136704576012970, t2.value39, 1, true)

    local Part = v21(
        "Part",
        {
            Size = Vector3.new(6, 0.2, 1.2), Color = Color3.fromRGB(35, 35, 35), CanCollide = false,
            Anchored = false, Parent = t2.value39
        }
    )

    v21("Weld", {Part0 = t2.value39, Part1 = Part, C0 = CFrame.new(0, 0, 0.3), Parent = t2.value39})
    t2.value11.CameraType = Enum.CameraType.Scriptable
    t2.value11.CameraSubject = t2.value39
    pcall(
        function()
            t2.value10.ReplicationFocus = t2.value39
        end
    )
    task.delay(
        t2.value20.ShahedMaxTime,
        function()
            local value38 = t2.value38

            if value38 then
                value38 = t2.value39
            end

            if not value38 then
                return
            end

            t2.value47(t2.value39.Position)
        end
    )

    local cFrame2 = cFrame

    t2.value5.RenderStepped:Connect(
        function(dt)
            if not (t2.value38 and t2.value39) then
                return
            end

            local MoveDirection = Humanoid.MoveDirection
            local v117, v118

            if MoveDirection.Magnitude > 0 then
                local v119 = cFrame2:VectorToObjectSpace(MoveDirection)

                v117 = -v119.X * 1.7 * dt
                v118 = v119.Z * 1.7 * dt
            else
                v118 = 0
                v117 = 0
            end

            cFrame2 = cFrame2 * CFrame.Angles(v118, v117, 0)

            local LookVector = cFrame2.LookVector
            local v121 = cFrame2.Position + LookVector * t2.value20.ShahedSpeed * dt

            cFrame2 = CFrame.new(v121) * (cFrame2 - cFrame2.Position)
            t2.value39.CFrame = cFrame2

            local v122 = cFrame2.Position - LookVector * 9 + Vector3.new(0, 3, 0)

            t2.value11.CFrame = CFrame.lookAt(v122, cFrame2.Position + LookVector * 5)

            local raycastParams = RaycastParams.new()

            raycastParams.FilterDescendantsInstances = {Character, t2.value28, t2.value39}
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude

            local hit = t2.value6:Raycast(
                cFrame2.Position, LookVector * (t2.value20.ShahedSpeed * dt + 1), raycastParams
            )

            if not hit then
                return
            end

            t2.value47(hit.Position)
        end
    )
end

t2.value10.CharacterAdded:Connect(
    function(character)
        t2.value43()
        character:WaitForChild("Humanoid")
        task.wait(0.5)

        if not t2.value20.ShahedEnabled then
            return
        end

        t2.value46()
    end
)

function t2.value48() end
function t2.value49(p11, p12)
    if p12 and p11 then
        local raycastParams = RaycastParams.new()

        raycastParams.FilterDescendantsInstances = {t2.value10.Character, t2.value28}
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude

        local hit = t2.value6:Raycast(p11, p12.Position - p11, raycastParams)
        local Instance_

        if hit then
            Instance_ = hit.Instance

            if not Instance_ then
                return Instance_
            end

            Instance_ = hit.Instance:IsDescendantOf(p12.Parent)
        else
            Instance_ = hit
        end

        return Instance_
    else
        return false
    end
end

t2.value50 = nil

function t2.value50()
    if t2.value36 then
        t2.value36:Disconnect()
    end

    if t2.value28 then
        t2.value28:Destroy()
        t2.value28 = nil
    end

    local Character = t2.value10.Character

    if not Character then
        t2.value37 = nil

        return
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local value37

    if HumanoidRootPart then
        value37 = t2.value37
    else
        value37 = HumanoidRootPart
    end

    if value37 then
        HumanoidRootPart.CFrame = t2.value37.CFrame

        local vector3 = Vector3.zero
        local vector32 = Vector3.zero

        HumanoidRootPart.AssemblyLinearVelocity = vector3
        HumanoidRootPart.AssemblyAngularVelocity = vector32
    end

    if not Humanoid then
        t2.value37 = nil

        return
    end

    t2.value11.CameraSubject = Humanoid
    Humanoid.PlatformStand = false
    t2.value37 = nil
end
function t2.value51(p13)
    t2.value20.InvisibilityActive = p13
    t2.value48(p13)

    if not p13 then
        return t2.value50()
    end

    local Character = t2.value10.Character

    if not Character then
        return
    end

    t2.value30()
    task.wait(0.05)

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if not (HumanoidRootPart and Humanoid) then
        return
    end

    t2.value50()
    Character.Archivable = true
    t2.value28 = Character:Clone()
    t2.value28.Parent = t2.value6
    Character.Archivable = false

    local ipairs_ = ipairs
    local value28 = t2.value28

    for _, descendant in ipairs_(value28.GetDescendants(value28)) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 0.5
        elseif descendant:IsA("Script") or descendant:IsA("LocalScript") then
            descendant:Destroy()
        end
    end

    local Humanoid2 = t2.value28:FindFirstChildOfClass("Humanoid")

    t2.value37 = t2.value28:FindFirstChild("HumanoidRootPart")

    if Humanoid2 then
        t2.value11.CameraSubject = Humanoid2
    end

    Humanoid.PlatformStand = true

    local Heartbeat = t2.value5.Heartbeat

    Heartbeat.Connect(
        Heartbeat,
        function()
            local InvisibilityActive = t2.value20.InvisibilityActive

            if InvisibilityActive then
                InvisibilityActive = t2.value28

                if InvisibilityActive then
                    InvisibilityActive = t2.value28.Parent == t2.value6

                    if InvisibilityActive then
                        InvisibilityActive = Humanoid2

                        if InvisibilityActive then
                            InvisibilityActive = Humanoid2.Health > 0

                            if InvisibilityActive then
                                InvisibilityActive = Humanoid

                                if InvisibilityActive then
                                    InvisibilityActive = Humanoid.Health > 0
                                end
                            end
                        end
                    end
                end
            end

            if not InvisibilityActive then
                t2.value20.InvisibilityActive = false
                t2.value48(false)
                t2.value50()

                return
            end

            local v144, ipairs_2, value2, v147, v148

            if t2.value11.CameraSubject == Humanoid2 then
                Humanoid2:Move(Humanoid.MoveDirection, false)
                Humanoid2.Jump = Humanoid.Jump
                HumanoidRootPart.CFrame = t2.value37.CFrame * CFrame.new(0, 100000, 0)
                v153 = HumanoidRootPart
                v154 = HumanoidRootPart
                v155 = Vector3.zero
                v156 = Vector3.zero
                v153.AssemblyLinearVelocity = v155
                v154.AssemblyAngularVelocity = v156
                v157 = Character:FindFirstChildOfClass("Tool")

                if v157 then
                    v144 = v157.Name:lower()

                    if v144:find("knife") or (v144:find("нож") or (v157:GetAttribute(
                        "ThrowSpeed"
                    ) or t2.value15)) then
                        ipairs_2 = ipairs
                        value2 = t2.value2

                        for _, player in ipairs_2(value2.GetPlayers(value2)) do
                            v147, v148 = t2.value27(player)

                            if v147 then
                                v147 = (v148.Position - t2.value37.Position).Magnitude <= 3

                                if v147 then
                                    v147 = t2.value49(t2.value37.Position, v148)
                                end
                            end

                            if v147 then
                                if t2.value15 then
                                    t2.value15:FireServer(v148)
                                end

                                if t2.value16 then
                                    t2.value16:FireServer(v148, v148.Position)
                                end
                            end
                        end

                        return
                    else
                        return
                    end
                end

                return
            end

            t2.value11.CameraSubject = Humanoid2
            Humanoid2:Move(Humanoid.MoveDirection, false)
            Humanoid2.Jump = Humanoid.Jump
            HumanoidRootPart.CFrame = t2.value37.CFrame * CFrame.new(0, 100000, 0)

            local v151 = HumanoidRootPart
            local v152 = HumanoidRootPart
            local vector3 = Vector3.zero
            local vector32 = Vector3.zero

            v151.AssemblyLinearVelocity = vector3
            v152.AssemblyAngularVelocity = vector32

            local Tool = Character:FindFirstChildOfClass("Tool")

            if Tool then
                v144 = Tool.Name:lower()

                if v144:find("knife") or (v144:find("нож") or (Tool:GetAttribute("ThrowSpeed") or t2.value15)) then
                    ipairs_2 = ipairs
                    value2 = t2.value2

                    for _, player in ipairs_2(value2.GetPlayers(value2)) do
                        v147, v148 = t2.value27(player)

                        if v147 then
                            v147 = (v148.Position - t2.value37.Position).Magnitude <= 3

                            if v147 then
                                v147 = t2.value49(t2.value37.Position, v148)
                            end
                        end

                        if v147 then
                            if t2.value15 then
                                t2.value15:FireServer(v148)
                            end

                            if t2.value16 then
                                t2.value16:FireServer(v148, v148.Position)
                            end
                        end
                    end

                    return
                else
                    return
                end
            end
        end
    )
end

local InputBegan = t2.value4.InputBegan

InputBegan.Connect(
    InputBegan,
    function(p14, p15)
        if p15 or not (t2.value20.InvisibilityActive and t2.value37) then
            return
        end

        if not (p14.UserInputType == Enum.UserInputType.MouseButton1 or p14.UserInputType == Enum.UserInputType.Touch) then
            return
        end

        local Character = t2.value10.Character

        if Character then
            Character = Character:FindFirstChildOfClass("Tool")
        end

        if not Character then
            return
        end

        local v160 = Character.Name:lower()

        if not (v160:find("gun") or (v160:find("пест") or (v160:find("пистолет") or (Character:GetAttribute(
            "Cooldown"
        ) or t2.value14)))) then
            return
        end

        local mouseLocation = t2.value4:GetMouseLocation()
        local v162 = t2.value11:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
        local raycastParams = RaycastParams.new()

        raycastParams.FilterDescendantsInstances = {t2.value10.Character, t2.value28}
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude

        local hit = t2.value6:Raycast(v162.Origin, v162.Direction * 1000, raycastParams)
        local Instance_

        if hit then
            Instance_ = hit.Instance
        else
            Instance_ = hit
        end

        if not Instance_ then
            return
        end

        local Model = hit.Instance:FindFirstAncestorOfClass("Model")

        if Model then
            Model = t2.value2:GetPlayerFromCharacter(Model)
        end

        local value14, v168 = t2.value27(Model)

        if value14 then
            value14 = t2.value49(t2.value37.Position, v168)

            if value14 then
                value14 = t2.value14
            end
        end

        if not value14 then
            return
        end

        t2.value14:FireServer(t2.value37.Position, v168.Position, v168, v168.Position)
    end
)
t2.value10.CharacterRemoving:Connect(
    function()
        if not t2.value20.InvisibilityActive then
            return
        end

        t2.value20.InvisibilityActive = false
        t2.value50()
    end
)
t2.value52 = 0
t2.value4.JumpRequest:Connect(
    function()
        local n1 = 6110090

        if t2.value20.InfJumpEnabled then
            local InvisibilityActive = t2.value20.InvisibilityActive

            if InvisibilityActive then
                InvisibilityActive = t2.value28
            end

            local Character = InvisibilityActive or t2.value10.Character

            if Character then
                Character = Character:FindFirstChildOfClass("Humanoid")
            end

            if Character then
                n1 = Character:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end

        if not t2.value20.BhopEnabled then
            return
        end

        local InvisibilityActive = t2.value20.InvisibilityActive

        if InvisibilityActive then
            InvisibilityActive = t2.value28

            if InvisibilityActive then
                InvisibilityActive = t2.value28:FindFirstChildOfClass("Humanoid")
            end
        end

        if not InvisibilityActive then
            InvisibilityActive = t2.value10.Character

            if InvisibilityActive then
                InvisibilityActive = t2.value10.Character:FindFirstChildOfClass("Humanoid")
            end
        end

        if not InvisibilityActive then
            return
        end

        t2.value20.BhopBonus = t2.value20.BhopBonus + 3
        t2.value52 = tick()
    end
)
t2.value5.Stepped:Connect(
    function()
        if not t2.value20.NoclipEnabled then
            return
        end

        local InvisibilityActive = t2.value20.InvisibilityActive

        if InvisibilityActive then
            InvisibilityActive = t2.value28
        end

        local Character = InvisibilityActive or t2.value10.Character

        if not Character then
            return
        end

        for _, descendant in ipairs(Character:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false
            end
        end
    end
)
t2.value53 = {}

local function createUIStroke(p16, p17, p18)
    local UIStroke = Instance.new("UIStroke")

    for k, v in pairs({Thickness = p17 or 1.2, Transparency = p18 or 0.8, Parent = p16}) do
        UIStroke[k] = v
    end

    local t6 = {
        Color = ColorSequence.new(
            {
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 15)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
            }
        ), Parent = UIStroke
    }
    local UIGradient = Instance.new("UIGradient")

    for k, v in pairs(t6) do
        UIGradient[k] = v
    end

    local value53 = t2.value53

    table.insert(value53, UIGradient)

    return UIStroke
end

t2.value5.RenderStepped:Connect(
    function()
        local rotation = tick() * 100 % 360

        for _, v in ipairs(t2.value53) do
            v.Rotation = rotation
        end
    end
)
t2.value54 = ({
    CreateWindow = function(_, p19)
        local function v189(p20)
            local Character = t2.value10.Character

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart")
            end

            if not Character then
                v196 = Character or Vector3.new(0, 10, 0)
                v197 = v196 + Vector3.new(math.random(-5, 5), math.random(1, 5), math.random(-5, 5))

                return p20 == "ShootGun" and {v196, v197, t2.value6, v197} or (p20 == "ThrowStart" and {
                    v196, (v197 - v196).Unit
                } or (p20 == "ThrowHit" and {t2.value6, v197} or (p20 == "Stab" and {t2.value6} or {})))
            end

            Character = Character.Position

            local vector3 = Character or Vector3.new(0, 10, 0)
            local v192 = vector3 + Vector3.new(
                math.random(-5, 5), math.random(1, 5), math.random(-5, 5)
            )

            return p20 == "ShootGun" and {vector3, v192, t2.value6, v192} or (p20 == "ThrowStart" and {
                vector3, (v192 - vector3).Unit
            } or (p20 == "ThrowHit" and {t2.value6, v192} or (p20 == "Stab" and {t2.value6} or {})))
        end

        task.spawn(
            function()
                local value135 = t2.value13

                if value135 then
                    value135 = t2.value13:FindFirstChild("ThrowStart")
                end

                local t7 = {
                    ShootGun = t2.value14, ThrowStart = value135, ThrowHit = t2.value16,
                    Stab = t2.value15
                }

                while true do
                    while t2.value20.LagEnabled do
                        local Character = t2.value10.Character

                        if Character then
                            Character = Character:FindFirstChildOfClass("Tool")
                        end

                        if Character then
                            local v198 = t7[t2.value20.LagRemote]

                            if v198 then
                                local v199 = v189(t2.value20.LagRemote)

                                for _ = 1, t2.value20.LagBatch do
                                    v198:FireServer(unpack(v199))
                                end
                            end
                        end

                        task.wait(t2.value20.LagDelay)
                    end

                    task.wait(0.2)
                end
            end
        )

        local t8 = {
            MaxObjectsPerSecond = 15, DisablePhysics = true, MuteSpamSounds = true,
            Keywords = {"knife", "blade", "throw", "handle", "projectile", "tool"}
        }
        local n2 = 0
        local now = os.clock()

        local function v202(p21)
            local v203 = p21.Name:lower()

            for _, keyword in ipairs(t8.Keywords) do
                if v203:find(keyword) then
                    return true
                end
            end

            return false
        end
        local function v206(child)
            if not t2.value20.AntiLagEnabled then
                return
            end

            if os.clock() - now >= 1 then
                n2 = 0
                os.clock()
            end

            local MuteSpamSounds = t8.MuteSpamSounds

            if MuteSpamSounds then
                MuteSpamSounds = child:IsA("Sound")
            end

            if MuteSpamSounds and (n2 > t8.MaxObjectsPerSecond or v202(child.Parent or child)) then
                child:Stop()
                child.Volume = 0
                child:Destroy()

                return
            end

            if not ((child:IsA("BasePart") or child:IsA("Model")) and v202(child)) then
                return
            end

            n2 = n2 + 1

            if n2 > t8.MaxObjectsPerSecond then
                task.defer(
                    function()
                        local Parent = child

                        if Parent then
                            Parent = child.Parent
                        end

                        if not Parent then
                            return
                        end

                        child:Destroy()
                    end
                )

                return
            end

            if not t8.DisablePhysics then
                return
            end

            if child:IsA("BasePart") then
                child.CanCollide = false
                child.CanTouch = false
                child.Massless = true

                return
            end

            for _, descendant in ipairs(child:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.CanCollide = false
                    descendant.CanTouch = false
                    descendant.Massless = true
                end
            end
        end

        t2.value6.ChildAdded:Connect(v206)
        t2.value6.DescendantAdded:Connect(
            function(descendant)
                if not (descendant:IsA("BasePart") or (descendant:IsA("Sound") or descendant:IsA(
                    "Model"
                ))) then
                    return
                end

                v206(descendant)
            end
        )

        local v211 = p19 or "MONO<b>HUB</b>"
        local ScreenGui = v21(
            "ScreenGui", {Name = "MonochromeHubV2", ResetOnSpawn = false, Parent = t2.value18}
        )

        local function v213(p22, p23)
            local v214

            if typeof(p23) == "table" then
                v214 = p23
            else
                v214 = false
            end

            local vector2 = Vector2.zero
            local vector22 = Vector2.zero
            local vector23 = Vector2.new(p22.Position.X.Offset, p22.Position.Y.Offset)
            local u218 = false
            local u219 = false

            for _, v in ipairs(v214 or {p23 or p22}) do
                if v:IsA("GuiObject") then
                    v.Active = true
                end

                v.InputBegan:Connect(
                    function(input)
                        if not (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                            return
                        end

                        u218 = true
                        u219 = false
                        vector2 = Vector2.new(input.Position.X, input.Position.Y)
                        vector22 = Vector2.new(p22.Position.X.Offset, p22.Position.Y.Offset)
                    end
                )
            end

            t2.value4.InputChanged:Connect(
                function(input)
                    local v222 = u218

                    if v222 then
                        v222 = input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
                    end

                    if not v222 then
                        return
                    end

                    local v223 = Vector2.new(input.Position.X, input.Position.Y) - vector2

                    if v223.Magnitude > 5 then
                        u219 = true
                    end

                    vector23 = vector22 + v223
                end
            )
            t2.value4.InputEnded:Connect(
                function(input)
                    if not (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                        return
                    end

                    u218 = false
                end
            )
            t2.value5.RenderStepped:Connect(
                function(dt)
                    local vector24 = Vector2.new(p22.Position.X.Offset, p22.Position.Y.Offset)

                    if not (u218 or (vector24 - vector23).Magnitude > 0.1) then
                        return
                    end

                    local v225 = vector23
                    local v226 = dt * 14
                    local v227 = vector24:Lerp(v225, (math.clamp(v226, 0, 1)))

                    p22.Position = UDim2.new(
                        p22.Position.X.Scale, v227.X, p22.Position.Y.Scale, v227.Y
                    )
                end
            )

            return function()
                return u219
            end
        end

        local Frame = v21(
            "Frame",
            {
                Name = "FloatingInvisWindow", Size = UDim2.new(0, 60, 0, 60),
                Position = UDim2.new(0.05, 0, 0.4, 0),
                BackgroundColor3 = Color3.fromRGB(15, 15, 18), BorderSizePixel = 0, Active = true,
                ZIndex = 999, Visible = t2.value20.InvisibilityEnabled, Parent = ScreenGui
            }
        )

        v21("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Frame})
        createUIStroke(Frame, 1.5, 0.3)

        local TextButton = v21(
            "TextButton",
            {
                Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "invisible",
                TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold,
                TextSize = 9, ZIndex = 1000, Parent = Frame
            }
        )
        local v230 = v213(Frame, {Frame, TextButton})

        TextButton.MouseButton1Click:Connect(
            function()
                if not v230() then
                    t2.value51(not t2.value20.InvisibilityActive)
                    t2.value33()
                end
            end
        )

        local v231 = t2.value34()

        if v231 then
            local Frame2 = v21(
                "Frame",
                {
                    Name = "ConfigModal", Size = UDim2.new(0, 320, 0, 210),
                    Position = UDim2.new(0.5, -160, 0.5, -105),
                    BackgroundColor3 = Color3.fromRGB(16, 16, 20), BorderSizePixel = 0,
                    ZIndex = 100, Parent = ScreenGui
                }
            )
            local UIScale = Instance.new("UIScale")

            for k, v in pairs({Scale = 0, Parent = Frame2}) do
                UIScale[k] = v
            end

            v21("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Frame2})
            createUIStroke(Frame2, 1.2, 0.4)
            v21(
                "TextLabel",
                {
                    Size = UDim2.new(1, -20, 0, 26), Position = UDim2.new(0, 10, 0, 8),
                    BackgroundTransparency = 1, Text = "Load saved configuration?",
                    TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold,
                    TextSize = 13, ZIndex = 101, Parent = Frame2
                }
            )
            v21(
                "TextLabel",
                {
                    Size = UDim2.new(1, -20, 0, 18), Position = UDim2.new(0, 10, 0, 32),
                    BackgroundTransparency = 1, Text = "A saved configuration file was detected:",
                    TextColor3 = Color3.fromRGB(160, 160, 165), Font = Enum.Font.Gotham,
                    TextSize = 10, ZIndex = 101, Parent = Frame2
                }
            )

            local TextButton2 = v21(
                "TextButton",
                {
                    Size = UDim2.new(1, -24, 0, 28), Position = UDim2.new(0, 12, 0, 55),
                    BackgroundColor3 = Color3.fromRGB(24, 24, 30),
                    Text = "  View Settings List ▼", TextColor3 = Color3.fromRGB(220, 220, 220),
                    Font = Enum.Font.GothamMedium, TextSize = 10,
                    TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 101, Parent = Frame2
                }
            )

            v21("UICorner", {CornerRadius = UDim.new(0, 6), Parent = TextButton2})

            local ScrollingFrame = v21(
                "ScrollingFrame",
                {
                    Size = UDim2.new(1, -24, 0, 65), Position = UDim2.new(0, 12, 0, 88),
                    BackgroundColor3 = Color3.fromRGB(20, 20, 24), BorderSizePixel = 0,
                    ZIndex = 102, Visible = false, ScrollBarThickness = 3, Parent = Frame2
                }
            )

            v21(
                "UIListLayout",
                {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4), Parent = ScrollingFrame}
            )

            local n3 = 0

            for k, v in pairs(v231) do
                v21(
                    "TextLabel",
                    {
                        Size = UDim2.new(1, -10, 0, 16), BackgroundTransparency = 1,
                        Text = " • " .. tostring(k) .. ": " .. tostring(v),
                        TextColor3 = Color3.fromRGB(180, 180, 185), Font = Enum.Font.Gotham,
                        TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 103,
                        Parent = ScrollingFrame
                    }
                )
                n3 = n3 + 1
            end

            ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, n3 * 20)

            local visible = false

            TextButton2.MouseButton1Click:Connect(
                function()
                    visible = not visible
                    ScrollingFrame.Visible = visible
                    TextButton2.Text = visible and "  Hide Settings List ▲" or "  View Settings List ▼"
                end
            )

            local TextButton3 = v21(
                "TextButton",
                {
                    Size = UDim2.new(0, 135, 0, 32), Position = UDim2.new(0, 12, 1, -42),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255), Text = "Load",
                    TextColor3 = Color3.fromRGB(0, 0, 0), Font = Enum.Font.GothamBold,
                    TextSize = 11, ZIndex = 101, Parent = Frame2
                }
            )

            v21("UICorner", {CornerRadius = UDim.new(0, 8), Parent = TextButton3})

            local TextButton4 = v21(
                "TextButton",
                {
                    Size = UDim2.new(0, 135, 0, 32), Position = UDim2.new(1, -147, 1, -42),
                    BackgroundColor3 = Color3.fromRGB(30, 30, 36), Text = "Reset",
                    TextColor3 = Color3.fromRGB(200, 200, 200), Font = Enum.Font.GothamBold,
                    TextSize = 11, ZIndex = 101, Parent = Frame2
                }
            )

            v21("UICorner", {CornerRadius = UDim.new(0, 8), Parent = TextButton4})
            t2.value3:Create(
                UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Scale = 1}
            ):Play()

            local u244 = false

            local function v245()
                t2.value35(v231)
                Frame.Visible = t2.value20.InvisibilityEnabled
                u244 = true
            end

            TextButton3.MouseButton1Click:Connect(v245)
            TextButton4.MouseButton1Click:Connect(
                function()
                    u244 = true
                end
            )

            while not u244 do
                task.wait(0.1)
            end

            t2.value3:Create(
                UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                {Scale = 0}
            ):Play()
            task.wait(0.25)
            Frame2:Destroy()
        end

        local Frame2 = v21(
            "Frame",
            {
                Name = "Notifications", Size = UDim2.new(0, 220, 1, -20),
                Position = UDim2.new(1, -230, 0, 15), BackgroundTransparency = 1, Parent = ScreenGui
            }
        )

        v21(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top, Padding = UDim.new(0, 6),
                Parent = Frame2
            }
        )

        local function v247(p24, p25, p26)
            local v248 = p26 or 3

            task.spawn(
                function()
                    local Frame3 = v21(
                        "Frame",
                        {
                            Size = UDim2.new(1, 0, 0, 50), Position = UDim2.new(1, 250, 0, 0),
                            BackgroundColor3 = Color3.fromRGB(18, 18, 22), BorderSizePixel = 0,
                            ClipsDescendants = true, Parent = Frame2
                        }
                    )

                    v21("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Frame3})
                    createUIStroke(Frame3, 1.2, 0.4)
                    v21(
                        "TextLabel",
                        {
                            Size = UDim2.new(1, -16, 0, 18), Position = UDim2.new(0, 10, 0, 5),
                            BackgroundTransparency = 1, Text = p24,
                            TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold,
                            TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = Frame3
                        }
                    )
                    v21(
                        "TextLabel",
                        {
                            Size = UDim2.new(1, -16, 0, 18), Position = UDim2.new(0, 10, 0, 21),
                            BackgroundTransparency = 1, Text = p25,
                            TextColor3 = Color3.fromRGB(170, 170, 175), Font = Enum.Font.Gotham,
                            TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = Frame3
                        }
                    )

                    local Frame4 = v21(
                        "Frame",
                        {
                            Size = UDim2.new(1, -20, 0, 3), Position = UDim2.new(0, 10, 1, -6),
                            BackgroundColor3 = Color3.fromRGB(30, 30, 36), BorderSizePixel = 0,
                            ClipsDescendants = true, Parent = Frame3
                        }
                    )
                    local Frame5 = v21(
                        "Frame",
                        {
                            Size = UDim2.new(1, 0, 1, 0),
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0,
                            Parent = Frame4
                        }
                    )
                    local value3 = t2.value3
                    local tweenInfo = TweenInfo.new(
                        0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out
                    )
                    local t9 = {Position = UDim2.new(0, 0, 0, 0)}

                    value3.Create(value3, Frame3, tweenInfo, t9):Play()

                    local value32 = t2.value3
                    local tweenInfo2 = TweenInfo.new(v248, Enum.EasingStyle.Linear)
                    local t10 = {Size = UDim2.new(0, 0, 1, 0)}

                    value32.Create(value32, Frame5, tweenInfo2, t10):Play()
                    task.wait(v248)

                    local value33 = t2.value3
                    local tweenInfo3 = TweenInfo.new(
                        0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In
                    )
                    local t11 = {Position = UDim2.new(1, 250, 0, 0)}
                    local v261 = value33.Create(value33, Frame3, tweenInfo3, t11)

                    v261:Play()
                    v261.Completed:Connect(
                        function()
                            Frame3:Destroy()
                        end
                    )
                end
            )
        end

        local Frame3 = v21(
            "Frame",
            {
                Name = "MainFrame", Size = UDim2.new(0, 520, 0, 350),
                Position = UDim2.new(0.5, -260, 0.5, -175),
                BackgroundColor3 = Color3.fromRGB(14, 14, 16), BorderSizePixel = 0,
                ClipsDescendants = true, Active = true, Parent = ScreenGui
            }
        )
        local Frame4 = v21(
            "Frame",
            {
                Name = "SnowContainer", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1,
                ClipsDescendants = true, ZIndex = 1, Parent = Frame3
            }
        )
        local t12 = {}

        for _ = 1, 25 do
            local v266 = math.random(2, 3)
            local Frame5 = v21(
                "Frame",
                {
                    Size = UDim2.new(0, v266, 0, v266),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = math.random(25, 65) / 100, BorderSizePixel = 0,
                    ZIndex = 1, Parent = Frame4
                }
            )

            v21("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Frame5})
            table.insert(
                t12,
                {
                    frame = Frame5, x = math.random(), y = math.random(),
                    speed = math.random(12, 32) / 1000, sway = math.random(1, 3) / 100,
                    freq = math.random(2, 5)
                }
            )
        end

        local RenderStepped = t2.value5.RenderStepped

        RenderStepped.Connect(
            RenderStepped,
            function(p27)
                local now2 = tick()

                for _, v in ipairs(t12) do
                    v.y = v.y + v.speed * p27 * 10

                    if v.y > 1 then
                        local x = math.random()

                        v.y = -0.05
                        v.x = x
                    end

                    local frame = v.frame
                    local uDim2New = UDim2.new
                    local x = v.x
                    local v276 = now2 * v.freq

                    frame.Position = uDim2New(x + math.sin(v276) * v.sway, 0, v.y, 0)
                end
            end
        )

        local UIScale = v21("UIScale", {Scale = 0, Parent = Frame3})

        v21("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Frame3})
        createUIStroke(Frame3, 1.5, 0.3)

        local Frame5 = v21(
            "Frame",
            {
                Name = "TopBarDrag", Size = UDim2.new(1, -70, 0, 35),
                Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, ZIndex = 2,
                Parent = Frame3
            }
        )
        local TextButton2 = v21(
            "TextButton",
            {
                Name = "ToggleCircle", Size = UDim2.new(0, 46, 0, 46),
                Position = UDim2.new(0, 20, 0.5, -23),
                BackgroundColor3 = Color3.fromRGB(20, 20, 25), Text = "M",
                TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold,
                TextSize = 18, AutoButtonColor = false, Active = true, Visible = false,
                Parent = ScreenGui
            }
        )
        local UIScale2 = Instance.new("UIScale")

        for k, v in pairs({Scale = 0, Parent = TextButton2}) do
            UIScale2[k] = v
        end

        v21("UICorner", {CornerRadius = UDim.new(1, 0), Parent = TextButton2})
        createUIStroke(TextButton2, 1.5, 0.3)
        v213(TextButton2)

        local function v283(p28, p29)
            if p29 then
                Frame3.Visible = p28
                TextButton2.Visible = not p28
                UIScale.Scale = p28 and 1 or 0
                UIScale2.Scale = p28 and 0 or 1

                return
            end

            if p28 then
                Frame3.Visible = true
                t2.value3:Create(
                    UIScale2, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                    {Scale = 0}
                ):Play()
                task.wait(0.15)
                TextButton2.Visible = false
                t2.value3:Create(
                    UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Scale = 1}
                ):Play()

                return
            end

            local tween = t2.value3:Create(
                UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                {Scale = 0}
            )

            tween:Play()
            tween.Completed:Connect(
                function()
                    local v285 = TextButton2

                    Frame3.Visible = false
                    v285.Visible = true
                    t2.value3:Create(
                        UIScale2,
                        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {Scale = 1}
                    ):Play()
                end
            )
        end

        Frame3.Visible = true
        t2.value3:Create(
            UIScale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Scale = 1}
        ):Play()

        local Frame6 = v21(
            "Frame",
            {
                Name = "TopControls", Size = UDim2.new(0, 60, 0, 26),
                Position = UDim2.new(1, -65, 0, 6), BackgroundTransparency = 1, ZIndex = 3,
                Parent = Frame3
            }
        )
        local TextButton3 = v21(
            "TextButton",
            {
                Size = UDim2.new(0, 24, 0, 24), Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = Color3.fromRGB(25, 25, 30), Text = "—",
                TextColor3 = Color3.fromRGB(200, 200, 200), Font = Enum.Font.GothamBold,
                TextSize = 12, Parent = Frame6
            }
        )

        v21("UICorner", {CornerRadius = UDim.new(0, 6), Parent = TextButton3})

        local TextButton4 = v21(
            "TextButton",
            {
                Size = UDim2.new(0, 24, 0, 24), Position = UDim2.new(0, 28, 0, 0),
                BackgroundColor3 = Color3.fromRGB(25, 25, 30), Text = "✕",
                TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold,
                TextSize = 10, Parent = Frame6
            }
        )

        v21("UICorner", {CornerRadius = UDim.new(0, 6), Parent = TextButton4})
        TextButton3.MouseButton1Click:Connect(
            function()
                v283(false, false)
            end
        )
        TextButton2.MouseButton1Click:Connect(
            function()
                v283(true, false)
            end
        )
        TextButton4.MouseButton1Click:Connect(
            function()
                t2.value3:Create(
                    UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                    {Scale = 0}
                ):Play()
                task.wait(0.4)
                ScreenGui:Destroy()
            end
        )

        local Frame7 = v21(
            "Frame",
            {
                Name = "Sidebar", Size = UDim2.new(0, 150, 1, 0),
                BackgroundColor3 = Color3.fromRGB(18, 18, 22), BorderSizePixel = 0, Active = true,
                ZIndex = 2, Parent = Frame3
            }
        )

        v213(Frame3, {Frame7, Frame5})
        v21("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Frame7})
        createUIStroke(Frame7, 1, 0.5)
        v21(
            "TextLabel",
            {
                Size = UDim2.new(1, -16, 0, 35), Position = UDim2.new(0, 10, 0, 6),
                BackgroundTransparency = 1, Text = v211, RichText = true,
                TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 15,
                Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
                Parent = Frame7
            }
        )

        local Frame8 = v21(
            "Frame",
            {
                Size = UDim2.new(1, -16, 0, 36), Position = UDim2.new(0, 8, 1, -44),
                BackgroundColor3 = Color3.fromRGB(24, 24, 28), ZIndex = 4, Parent = Frame7
            }
        )

        v21("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Frame8})
        createUIStroke(Frame8, 1, 0.6)

        local ImageLabel = v21(
            "ImageLabel",
            {
                Size = UDim2.new(0, 24, 0, 24), Position = UDim2.new(0, 6, 0.5, -12),
                BackgroundTransparency = 1,
                Image = "rbxthumb://type=AvatarHeadShot&id=" .. t2.value10.UserId .. "&w=150&h=150",
                ZIndex = 5, Parent = Frame8
            }
        )

        v21("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ImageLabel})
        v21(
            "TextLabel",
            {
                Size = UDim2.new(1, -38, 1, 0), Position = UDim2.new(0, 34, 0, 0),
                BackgroundTransparency = 1, Text = t2.value10.DisplayName or t2.value10.Name,
                TextColor3 = Color3.fromRGB(240, 240, 240), TextSize = 10,
                Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 5, Parent = Frame8
            }
        )

        local Frame9 = v21(
            "Frame",
            {
                Size = UDim2.new(1, -16, 1, -135), Position = UDim2.new(0, 8, 0, 45),
                BackgroundTransparency = 1, ZIndex = 3, Parent = Frame7
            }
        )

        v21(
            "UIListLayout",
            {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 5), Parent = Frame9}
        )

        local Frame10 = v21(
            "Frame",
            {
                Name = "ContentHolder", Size = UDim2.new(1, -160, 1, -40),
                Position = UDim2.new(0, 155, 0, 35), BackgroundTransparency = 1, ZIndex = 2,
                Parent = Frame3
            }
        )
        local t13 = {Notify = v247, ToggleHub = v283}
        local t14 = {}
        local u296 = nil

        local function v297(p30)
            if u296 == p30 then
                return
            end

            u296 = p30

            for k, v in pairs(t14) do
                if k == p30 then
                    local value3 = t2.value3
                    local Button = v.Button
                    local tweenInfo = TweenInfo.new(0.2)
                    local color313 = Color3.fromRGB(255, 255, 255)
                    local Color3_ = Color3

                    value3.Create(
                        value3, Button, tweenInfo,
                        {BackgroundColor3 = color313, TextColor3 = Color3_.fromRGB(0, 0, 0)}
                    ):Play()
                    v.Page.Visible = true

                    local v305, v306, v307 = ipairs(v.Page:GetChildren())
                    local t15 = {}

                    while true do
                        local v309

                        v307, v309 = v305(v306, v307)

                        if not v307 then
                            break
                        end

                        if v309:IsA("Frame") then
                            table.insert(t15, v309)
                        end
                    end

                    for i, v2 in ipairs(t15) do
                        local Inner = v2:FindFirstChild("Inner")

                        if Inner then
                            Inner.Position = UDim2.new(0, 50, 0, 0)
                            Inner.BackgroundTransparency = 0.5
                            task.delay(
                                (i - 1) * 0.03,
                                function()
                                    local value32 = t2.value3
                                    local v314 = Inner
                                    local tweenInfoNew = TweenInfo.new
                                    local Back = Enum.EasingStyle.Back
                                    local EasingDirection = Enum.EasingDirection

                                    value32.Create(
                                        value32, v314, tweenInfoNew(0.3, Back, EasingDirection.Out),
                                        {Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0}
                                    ):Play()
                                end
                            )
                        end
                    end
                else
                    local value3 = t2.value3
                    local Button = v.Button
                    local tweenInfo = TweenInfo.new(0.2)
                    local color313 = Color3.fromRGB

                    value3.Create(
                        value3, Button, tweenInfo,
                        {BackgroundColor3 = color313(22, 22, 26), TextColor3 = Color3.fromRGB(
                            160, 160, 165
                        )}
                    ):Play()
                    v.Page.Visible = false
                end
            end
        end

        function t13.CreateTab(_, p31)
            local TextButton5 = v21(
                "TextButton",
                {
                    Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Color3.fromRGB(22, 22, 26),
                    Text = p31, TextColor3 = Color3.fromRGB(160, 160, 165), TextSize = 11,
                    Font = Enum.Font.GothamMedium, AutoButtonColor = false, Active = true,
                    ZIndex = 3, Parent = Frame9
                }
            )

            v21("UICorner", {CornerRadius = UDim.new(0, 6), Parent = TextButton5})

            local ScrollingFrame = v21(
                "ScrollingFrame",
                {
                    Size = UDim2.new(1, -8, 1, -8), Position = UDim2.new(0, 4, 0, 4),
                    BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
                    ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255), Visible = false,
                    ZIndex = 2, AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.new(0, 0, 0, 0), Parent = Frame10
                }
            )

            v21(
                "UIListLayout",
                {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6), Parent = ScrollingFrame}
            )
            t14[p31] = {Button = TextButton5, Page = ScrollingFrame}
            TextButton5.MouseButton1Click:Connect(
                function()
                    v297(p31)
                end
            )

            if not u296 then
                v297(p31)
            end

            local t16 = {}

            local function v325(p32)
                local t17 = {
                    Size = UDim2.new(1, -8, 0, p32 or 38), BackgroundTransparency = 1, ZIndex = 2,
                    Parent = ScrollingFrame
                }
                local Frame11 = Instance.new("Frame")

                for k, v in pairs(t17) do
                    Frame11[k] = v
                end

                local Frame12 = v21(
                    "Frame",
                    {
                        Name = "Inner", Size = UDim2.new(1, 0, 1, 0),
                        BackgroundColor3 = Color3.fromRGB(22, 22, 26), BorderSizePixel = 0,
                        Active = true, ZIndex = 2, Parent = Frame11
                    }
                )

                v21("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Frame12})

                return Frame12
            end

            function t16.CreateKeybind(_, p33, p34, p35)
                local v331 = v325(38)
                local Unknown = p34 or Enum.KeyCode.Unknown
                local u333 = false

                v21(
                    "TextLabel",
                    {
                        Size = UDim2.new(0.6, 0, 1, 0), Position = UDim2.new(0, 10, 0, 0),
                        BackgroundTransparency = 1, Text = p33,
                        TextColor3 = Color3.fromRGB(240, 240, 240), TextSize = 11,
                        Font = Enum.Font.GothamMedium, TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 3, Parent = v331
                    }
                )

                local TextButton6 = v21(
                    "TextButton",
                    {
                        Size = UDim2.new(0.35, 0, 0, 22), Position = UDim2.new(0.62, 0, 0.5, -11),
                        BackgroundColor3 = Color3.fromRGB(32, 32, 38), Text = Unknown.Name,
                        TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Gotham,
                        TextSize = 10, ZIndex = 3, Parent = v331
                    }
                )

                v21("UICorner", {CornerRadius = UDim.new(0, 5), Parent = TextButton6})
                TextButton6.MouseButton1Click:Connect(
                    function()
                        u333 = true
                        TextButton6.Text = "..."
                    end
                )
                t2.value4.InputBegan:Connect(
                    function(input, gameProcessed)
                        local v335 = u333

                        if v335 then
                            v335 = input.UserInputType == Enum.UserInputType.Keyboard
                        end

                        if v335 then
                            Unknown = input.KeyCode
                            TextButton6.Text = Unknown.Name

                            if p35 then
                                p35(Unknown, false)

                                return
                            else
                                return
                            end
                        end

                        local v336 = not gameProcessed

                        if v336 then
                            if input.UserInputType == Enum.UserInputType.Keyboard then
                                v336 = input.KeyCode == Unknown
                            else
                                v336 = false
                            end
                        end

                        if not (v336 and p35) then
                            return
                        end

                        p35(Unknown, true)
                    end
                )
            end
            function t16.CreateToggle(_, p36, p37, p38)
                local v337 = v325(40)
                local u338 = p37 or false

                v21(
                    "TextLabel",
                    {
                        Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0),
                        BackgroundTransparency = 1, Text = p36,
                        TextColor3 = Color3.fromRGB(240, 240, 240), TextSize = 11,
                        Font = Enum.Font.GothamMedium, TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 3, Parent = v337
                    }
                )

                local v339 = v21
                local uDim2 = UDim2.new(0, 38, 0, 18)
                local uDim22 = UDim2.new(1, -48, 0.5, -9)

                if u338 then
                    local color313 = Color3.fromRGB(255, 255, 255)
                end

                local TextButton6 = v339(
                    "TextButton",
                    {
                        Size = uDim2, Position = uDim22,
                        BackgroundColor3 = v369 or Color3.fromRGB(35, 35, 40), Text = "",
                        Active = true, ZIndex = 3, Parent = v337
                    }
                )

                v21("UICorner", {CornerRadius = UDim.new(1, 0), Parent = TextButton6})

                local v344 = v21
                local uDim23 = UDim2.new(0, 12, 0, 12)

                if u338 then
                    local uDim24 = UDim2.new(1, -14, 0.5, -6)
                end

                local v373_ = v373 or UDim2.new(0, 2, 0.5, -6)

                if u338 then
                    local color313 = Color3.fromRGB(0, 0, 0)
                end

                local Frame11 = v344(
                    "Frame",
                    {
                        Size = uDim23, Position = v373_,
                        BackgroundColor3 = v375 or Color3.fromRGB(180, 180, 180),
                        BorderSizePixel = 0, ZIndex = 4, Parent = TextButton6
                    }
                )

                v21("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Frame11})

                local function v350(p39)
                    local value3 = t2.value3
                    local v352 = TextButton6
                    local tweenInfo = TweenInfo.new(0.2)
                    local color313

                    if p39 then
                        color313 = Color3.fromRGB(255, 255, 255)
                    else
                        color313 = p39
                    end

                    local color314 = color313 or Color3.fromRGB(35, 35, 40)

                    value3.Create(value3, v352, tweenInfo, {BackgroundColor3 = color314}):Play()

                    local value32 = t2.value3
                    local v357 = Frame11
                    local tweenInfo2 = TweenInfo.new(0.2)
                    local uDim24

                    if p39 then
                        uDim24 = UDim2.new(1, -14, 0.5, -6)
                    else
                        uDim24 = p39
                    end

                    local uDim25 = uDim24 or UDim2.new(0, 2, 0.5, -6)

                    if not p39 then
                        value32:Create(
                            v357, tweenInfo2,
                            {Position = uDim25, BackgroundColor3 = p39 or Color3.fromRGB(
                                180, 180, 180
                            )}
                        ):Play()

                        return
                    end

                    p39 = Color3.fromRGB(0, 0, 0)
                    value32:Create(
                        v357, tweenInfo2,
                        {Position = uDim25, BackgroundColor3 = p39 or Color3.fromRGB(180, 180, 180)}
                    ):Play()
                end

                TextButton6.MouseButton1Click:Connect(
                    function()
                        u338 = not u338
                        v350(u338)

                        if not p38 then
                            return
                        end

                        p38(u338)
                    end
                )

                return function(p40)
                    u338 = p40
                    v350(u338)
                end
            end
            function t16.CreateSlider(_, p41, p42, p43, p44, p45)
                local v361 = v325(44)
                local v362 = math.clamp(p44 or p42, p42, p43)

                v21(
                    "TextLabel",
                    {
                        Size = UDim2.new(0.5, 0, 0, 18), Position = UDim2.new(0, 10, 0, 4),
                        BackgroundTransparency = 1, Text = p41,
                        TextColor3 = Color3.fromRGB(240, 240, 240), TextSize = 11,
                        Font = Enum.Font.GothamMedium, TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 3, Parent = v361
                    }
                )

                local v363 = v362
                local TextBox = v21(
                    "TextBox",
                    {
                        Size = UDim2.new(0.3, 0, 0, 18), Position = UDim2.new(0.7, -10, 0, 4),
                        BackgroundTransparency = 1, Text = tostring(v363),
                        TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 11,
                        Font = Enum.Font.Gotham, TextXAlignment = Enum.TextXAlignment.Right,
                        ClearTextOnFocus = false, ZIndex = 4, Parent = v361
                    }
                )
                local Frame11 = v21(
                    "Frame",
                    {
                        Size = UDim2.new(1, -20, 0, 6), Position = UDim2.new(0, 10, 1, -12),
                        BackgroundColor3 = Color3.fromRGB(35, 35, 42), BorderSizePixel = 0,
                        Active = true, ZIndex = 3, Parent = v361
                    }
                )

                v21("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Frame11})

                local v366 = (v362 - p42) / (p43 - p42)
                local Frame12 = v21(
                    "Frame",
                    {
                        Size = UDim2.new(v366, 0, 1, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0,
                        ZIndex = 4, Parent = Frame11
                    }
                )

                v21("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Frame12})

                local u368 = false

                local function v370(p46)
                    local v371 = math.clamp(p46, p42, p43)
                    local v372 = p43 - p42 > 20

                    if v372 then
                        v372 = math.floor(v371)
                    end

                    if not v372 then
                        local v374 = v371 * 100

                        v372 = math.floor(v374) / 100
                    end

                    TextBox.Text = tostring(v372)

                    local v376 = (v372 - p42) / (p43 - p42)

                    Frame12.Size = UDim2.new(v376, 0, 1, 0)

                    if not p45 then
                        return
                    end

                    p45(v372)
                end

                TextBox.FocusLost:Connect(
                    function()
                        local Text = TextBox.Text
                        local v377 = tonumber(Text:match("-?%d+%.?%d*"))

                        if v377 then
                            v370(v377)
                        else
                            local v378 = v362

                            TextBox.Text = tostring(v378)
                        end
                    end
                )

                local function v379(p47)
                    local v380 = (p47.Position.X - Frame11.AbsolutePosition.X) / Frame11.AbsoluteSize.X
                    local v381 = math.clamp(v380, 0, 1)

                    v370(p42 + (p43 - p42) * v381)
                end

                Frame11.InputBegan:Connect(
                    function(input)
                        if not (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                            return
                        end

                        u368 = true
                        v379(input)
                    end
                )
                t2.value4.InputChanged:Connect(
                    function(input)
                        local v382 = u368

                        if v382 then
                            v382 = input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
                        end

                        if not v382 then
                            return
                        end

                        v379(input)
                    end
                )
                t2.value4.InputEnded:Connect(
                    function(input)
                        local _ = input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
                    end
                )
            end
            function t16.CreateDropdown(_, p48, p49, p50, p51)
                local v383 = v325(38)
                local u384 = false
                local v385 = p50 or p49[1]

                v21(
                    "TextLabel",
                    {
                        Size = UDim2.new(0.5, 0, 0, 38), Position = UDim2.new(0, 10, 0, 0),
                        BackgroundTransparency = 1, Text = p48,
                        TextColor3 = Color3.fromRGB(240, 240, 240), TextSize = 11,
                        Font = Enum.Font.GothamMedium, TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 3, Parent = v383
                    }
                )

                local v386 = v385
                local TextButton6 = v21(
                    "TextButton",
                    {
                        Size = UDim2.new(0.42, 0, 0, 24), Position = UDim2.new(0.55, 0, 0, 7),
                        BackgroundColor3 = Color3.fromRGB(32, 32, 38),
                        Text = tostring(v386) .. "  ▼",
                        TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Gotham,
                        TextSize = 10, ZIndex = 3, Parent = v383
                    }
                )

                v21("UICorner", {CornerRadius = UDim.new(0, 5), Parent = TextButton6})

                local ScrollingFrame2 = v21(
                    "ScrollingFrame",
                    {
                        Size = UDim2.new(0.42, 0, 0, 0), Position = UDim2.new(0.55, 0, 0, 34),
                        BackgroundColor3 = Color3.fromRGB(28, 28, 34), BorderSizePixel = 0,
                        Visible = false, ZIndex = 10, ScrollBarThickness = 2, Parent = v383
                    }
                )

                v21(
                    "UIListLayout",
                    {SortOrder = Enum.SortOrder.LayoutOrder, Parent = ScrollingFrame2}
                )
                v385 = v385

                local v388 = v385

                TextButton6.Text = tostring(v388) .. "  ▼"

                if p51 then
                    p51(v385)
                end

                local u389 = v385
                local n4 = 0

                for _, v in ipairs(p49) do
                    local MouseButton1Click = v21(
                        "TextButton",
                        {
                            Size = UDim2.new(1, 0, 0, 22),
                            BackgroundColor3 = Color3.fromRGB(28, 28, 34), Text = tostring(v),
                            TextColor3 = Color3.fromRGB(200, 200, 200), Font = Enum.Font.Gotham,
                            TextSize = 10, ZIndex = 11, Parent = ScrollingFrame2
                        }
                    ).MouseButton1Click

                    MouseButton1Click.Connect(
                        MouseButton1Click,
                        function()
                            u389 = v

                            local v394 = u389

                            TextButton6.Text = tostring(v394) .. "  ▼"

                            if not p51 then
                                v436 = ScrollingFrame2
                                u384 = false
                                v436.Visible = false
                                v383.Parent.Size = UDim2.new(1, -8, 0, 38)

                                return
                            end

                            p51(u389)

                            local v395 = ScrollingFrame2

                            u384 = false
                            v395.Visible = false
                            v383.Parent.Size = UDim2.new(1, -8, 0, 38)
                        end
                    )
                    n4 = n4 + 22
                end

                ScrollingFrame2.CanvasSize = UDim2.new(0, 0, 0, n4)
                TextButton6.MouseButton1Click:Connect(
                    function()
                        u384 = not u384

                        if u384 then
                            local v396 = #p49 * 22
                            local v397 = math.min(v396, 110)
                            local v398 = ScrollingFrame2
                            local v399 = ScrollingFrame2
                            local uDim2 = UDim2.new(0.42, 0, 0, v397)

                            v398.Visible = true
                            v399.Size = uDim2
                            v383.Parent.Size = UDim2.new(1, -8, 0, 40 + v397)
                        else
                            ScrollingFrame2.Visible = false
                            v383.Parent.Size = UDim2.new(1, -8, 0, 38)
                        end
                    end
                )
            end

            return t16
        end

        return t13
    end
}):CreateWindow("MONO<b>HUB</b>")

local Gun = t2.value54:CreateTab("Gun")
local Knife = t2.value54:CreateTab("Knife")
local Player = t2.value54:CreateTab("Player")
local Misc = t2.value54:CreateTab("Misc")
local Visuals = t2.value54:CreateTab("Visuals")
local Binds = t2.value54:CreateTab("Binds")

Binds:CreateKeybind(
    "ESP", t2.value20.Binds.ESP,
    function(p52, p53)
        if p53 then
            t2.value20.ESPEnabled = not t2.value20.ESPEnabled
        else
            t2.value20.Binds.ESP = p52
            t2.value33()
        end
    end
)
Binds:CreateKeybind(
    "Kill All", t2.value20.Binds.KillAll,
    function(p54, p55)
        if p55 then
            t2.value20.KillAllEnabled = not t2.value20.KillAllEnabled
        else
            t2.value20.Binds.KillAll = p54
            t2.value33()
        end
    end
)
Binds:CreateKeybind(
    "Speed", t2.value20.Binds.Speed,
    function(p56, p57)
        if p57 then
            t2.value20.MovementEnabled = not t2.value20.MovementEnabled
        else
            t2.value20.Binds.Speed = p56
            t2.value33()
        end
    end
)
Binds:CreateKeybind(
    "Invisibility", t2.value20.Binds.Invisible,
    function(p58, p59)
        if p59 then
            t2.value51(not t2.value20.InvisibilityActive)
        else
            t2.value20.Binds.Invisible = p58
            t2.value33()
        end
    end
)
Binds:CreateKeybind(
    "Open/Close Hub", t2.value20.Binds.CloseHub,
    function(p60, p61)
        if p61 then
            t2.value54.ToggleHub(not t2.value18.MonochromeHubV2.MainFrame.Visible, true)
        else
            t2.value20.Binds.CloseHub = p60
            t2.value33()
        end
    end
)
Gun:CreateToggle(
    "Custom Gun", t2.value20.GunCustomEnabled,
    function(p62)
        t2.value20.GunCustomEnabled = p62
        t2.value33()
    end
)
Gun:CreateSlider(
    "Gun Cooldown", 0, 1, t2.value20.GunCooldown,
    function(p63)
        t2.value20.GunCooldown = p63
        t2.value33()
    end
)
Gun:CreateToggle(
    "Gun Aura", t2.value20.GunAuraEnabled,
    function(p64)
        t2.value20.GunAuraEnabled = p64
        t2.value33()
    end
)
Knife:CreateToggle(
    "Custom Knife", t2.value20.KnifeCustomEnabled,
    function(p65)
        t2.value20.KnifeCustomEnabled = p65
        t2.value33()
    end
)
Knife:CreateSlider(
    "Throw Speed", 500, 9999, t2.value20.KnifeThrowSpeed,
    function(p66)
        t2.value20.KnifeThrowSpeed = p66
        t2.value33()
    end
)
Knife:CreateToggle(
    "Knife Aura", t2.value20.KnifeAuraEnabled,
    function(p67)
        t2.value20.KnifeAuraEnabled = p67
        t2.value33()
    end
)
Knife:CreateSlider(
    "Knife Aura Range", 5, 100, t2.value20.KnifeAuraRange,
    function(p68)
        t2.value20.KnifeAuraRange = p68
        t2.value33()
    end
)
Misc:CreateToggle(
    "Kill All", t2.value20.KillAllEnabled,
    function(p69)
        t2.value20.KillAllEnabled = p69
        t2.value33()
    end
)
Misc:CreateDropdown(
    "Kill All Method", {"Default", "Lag"}, t2.value20.KillAllMethod,
    function(p70)
        t2.value20.KillAllMethod = p70
        t2.value33()
    end
)
Misc:CreateSlider(
    "Kill All Delay", 0.06, 0.3, t2.value20.KillAllDelay,
    function(p71)
        t2.value20.KillAllDelay = p71
        t2.value33()
    end
)
Misc:CreateToggle(
    "Server Lag", t2.value20.LagEnabled,
    function(p72)
        t2.value20.LagEnabled = p72
        t2.value33()
    end
)
Misc:CreateToggle(
    "Anti Lag", t2.value20.AntiLagEnabled,
    function(p73)
        t2.value20.AntiLagEnabled = p73
        t2.value33()
    end
)
Misc:CreateDropdown(
    "Select Remote", {"ThrowHit", "ThrowStart", "ShootGun", "Stab"}, t2.value20.LagRemote,
    function(p74)
        t2.value20.LagRemote = p74
        t2.value33()
    end
)
Misc:CreateSlider(
    "Cooldown Send", 0.01, 0.5, t2.value20.LagDelay,
    function(p75)
        t2.value20.LagDelay = p75
        t2.value33()
    end
)
Misc:CreateSlider(
    "How Much Send", 1, 9999, t2.value20.LagBatch,
    function(p76)
        t2.value20.LagBatch = p76
        t2.value33()
    end
)
Player:CreateToggle(
    "Movement", t2.value20.MovementEnabled,
    function(p77)
        t2.value20.MovementEnabled = p77
        t2.value33()
    end
)
Player:CreateSlider(
    "Walk Speed", 0, 200, t2.value20.MovementSpeed,
    function(p78)
        t2.value20.MovementSpeed = p78
        t2.value33()
    end
)
Player:CreateToggle(
    "Bhop", t2.value20.BhopEnabled,
    function(p79)
        t2.value20.BhopEnabled = p79

        if p79 then
            t2.value33()

            return
        end

        t2.value20.BhopBonus = 0
        t2.value33()
    end
)
Player:CreateDropdown(
    "Movement Mode", {"Normal", "CFrame", "SafeWalk"}, t2.value20.MovementMode,
    function(p80)
        t2.value20.MovementMode = p80
        t2.value33()
    end
)
Player:CreateToggle(
    "Noclip", t2.value20.NoclipEnabled,
    function(p81)
        t2.value20.NoclipEnabled = p81
        t2.value33()
    end
)
Player:CreateToggle(
    "Infinite Jump", t2.value20.InfJumpEnabled,
    function(p82)
        t2.value20.InfJumpEnabled = p82
        t2.value33()
    end
)
Player:CreateToggle(
    "Jump", t2.value20.JumpPowerEnabled,
    function(p83)
        t2.value20.JumpPowerEnabled = p83
        t2.value33()
    end
)
Player:CreateSlider(
    "Jump Power", 50, 1000, t2.value20.JumpPowerValue,
    function(p84)
        t2.value20.JumpPowerValue = p84
        t2.value33()
    end
)
Player:CreateSlider(
    "Gravity", 0, 500, t2.value20.GravityValue,
    function(p85)
        t2.value20.GravityValue = p85
        t2.value33()
    end
)
Player:CreateToggle(
    "Invisibility", t2.value20.InvisibilityEnabled,
    function(p86)
        t2.value20.InvisibilityEnabled = p86

        local MonochromeHubV2 = t2.value18:FindFirstChild("MonochromeHubV2")

        if MonochromeHubV2 then
            MonochromeHubV2 = t2.value18.MonochromeHubV2:FindFirstChild("FloatingInvisWindow")
        end

        if not MonochromeHubV2 then
            MonochromeHubV2 = t2.value12:FindFirstChild("MonochromeHubV2")

            if MonochromeHubV2 then
                MonochromeHubV2 = t2.value12.MonochromeHubV2:FindFirstChild("FloatingInvisWindow")
            end
        end

        if MonochromeHubV2 then
            MonochromeHubV2.Visible = p86
        end

        if p86 then
            t2.value33()

            return
        end

        t2.value51(false)
        t2.value33()
    end
)
Player:CreateToggle(
    "Spinner", t2.value20.SpinnerEnabled,
    function(p87)
        t2.value20.SpinnerEnabled = p87
        t2.value33()
    end
)
Player:CreateSlider(
    "Spinner Speed", 1, 200, t2.value20.SpinnerSpeed,
    function(p88)
        t2.value20.SpinnerSpeed = p88
        t2.value33()
    end
)
Visuals:CreateToggle(
    "Freeze Players (Only u see)", t2.value20.FreezePlayersEnabled,
    function(p89)
        t2.value20.FreezePlayersEnabled = p89
        t2.value33()
    end
)
Visuals:CreateToggle(
    "Give Shahed", t2.value20.ShahedEnabled,
    function(p90)
        t2.value20.ShahedEnabled = p90

        if p90 then
            t2.value46()
        else
            t2.value43()

            local Backpack = t2.value10:FindFirstChild("Backpack")
            local Shahed

            if Backpack then
                Shahed = Backpack:FindFirstChild("Shahed")
            else
                Shahed = Backpack
            end

            if not Shahed then
                t2.value33()

                return
            end

            Backpack.Shahed:Destroy()
        end

        t2.value33()
    end
)
Visuals:CreateSlider(
    "Shahed Speed", 10, 100, t2.value20.ShahedSpeed,
    function(p91)
        t2.value20.ShahedSpeed = p91
        t2.value33()
    end
)
Visuals:CreateSlider(
    "Shahed Flight Time", 5, 60, t2.value20.ShahedMaxTime,
    function(p92)
        t2.value20.ShahedMaxTime = p92
        t2.value33()
    end
)
Visuals:CreateSlider(
    "Shahed Explosion Radius", 5, 50, t2.value20.ShahedRadius,
    function(p93)
        t2.value20.ShahedRadius = p93
        t2.value33()
    end
)
Visuals:CreateToggle(
    "Expand Hitbox", t2.value20.HitboxEnabled,
    function(p94)
        t2.value20.HitboxEnabled = p94
        t2.value33()
    end
)
Visuals:CreateSlider(
    "Hitbox Size", 0, 50, t2.value20.HitboxSize,
    function(p95)
        t2.value20.HitboxSize = p95
        t2.value33()
    end
)
Visuals:CreateToggle(
    "ESP", t2.value20.ESPEnabled,
    function(p96)
        t2.value20.ESPEnabled = p96
        t2.value33()
    end
)
Visuals:CreateToggle(
    "ESP Team Check", t2.value20.ESPTeamCheck,
    function(p97)
        t2.value20.ESPTeamCheck = p97
        t2.value33()
    end
)
Visuals:CreateDropdown(
    "ESP Color",
    {
        "Black", "White", "Red", "Blue", "Yellow", "Pink", "Orange", "Green", "Purple", "Cyan",
        "Gray", "Brown"
    }, t2.value20.ESPColorName,
    function(p98)
        t2.value20.ESPColorName = p98
        t2.value20.ESPColor = t2.value22[p98] or Color3.fromRGB(255, 50, 50)
        t2.value33()
    end
)
Visuals:CreateToggle(
    "FOV", t2.value20.FOVEnabled,
    function(p99)
        t2.value20.FOVEnabled = p99
        t2.value33()
    end
)
Visuals:CreateSlider(
    "FOV Value", 1, 120, t2.value20.FOVValue,
    function(p100)
        t2.value20.FOVValue = p100
        t2.value33()
    end
)
Visuals:CreateToggle(
    "Stretch", t2.value20.StretchEnabled,
    function(p101)
        t2.value20.StretchEnabled = p101
        t2.value33()
    end
)
Visuals:CreateSlider(
    "Stretch Value", 0.2, 1.2, t2.value20.StretchValue,
    function(p102)
        t2.value20.StretchValue = p102
        t2.value33()
    end
)

local RenderStepped = t2.value5.RenderStepped

RenderStepped.Connect(
    RenderStepped,
    function(p103)
        local InvisibilityActive = t2.value20.InvisibilityActive

        if InvisibilityActive then
            InvisibilityActive = t2.value28
        end

        local Character = InvisibilityActive or t2.value10.Character

        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

            if Humanoid and HumanoidRootPart then
                local BhopEnabled = t2.value20.BhopEnabled

                if BhopEnabled then
                    if Humanoid.FloorMaterial == Enum.Material.Air then
                        BhopEnabled = false
                    else
                        BhopEnabled = tick() - t2.value52 > 0.3
                    end
                end

                if BhopEnabled then
                    t2.value20.BhopBonus = 0
                end

                local MovementSpeed = t2.value20.MovementSpeed
                local BhopEnabled2 = t2.value20.BhopEnabled

                if BhopEnabled2 then
                    BhopEnabled2 = t2.value20.BhopBonus
                end

                local walkSpeed = MovementSpeed + (BhopEnabled2 or 0)

                if t2.value20.MovementEnabled then
                    if t2.value20.MovementMode == "Normal" or t2.value20.MovementMode == "SafeWalk" then
                        Humanoid.WalkSpeed = walkSpeed
                    else
                        local v419 = t2.value20.MovementMode == "CFrame"

                        if v419 then
                            v419 = Humanoid.MoveDirection.Magnitude > 0
                        end

                        if v419 then
                            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Humanoid.MoveDirection * (walkSpeed * p103)
                        end
                    end
                end

                if t2.value20.JumpPowerEnabled then
                    local JumpPowerValue = t2.value20.JumpPowerValue

                    Humanoid.UseJumpPower = true
                    Humanoid.JumpPower = JumpPowerValue
                end
            end
        end

        t2.value6.Gravity = t2.value20.GravityValue

        if t2.value20.FOVEnabled then
            t2.value11.FieldOfView = t2.value20.FOVValue
        end

        local StretchEnabled = t2.value20.StretchEnabled

        if StretchEnabled then
            StretchEnabled = t2.value20.StretchValue
        end

        if not StretchEnabled then
            return
        end

        t2.value11.CFrame = t2.value11.CFrame * CFrame.new(
            0, 0, 0, 1, 0, 0, 0, t2.value20.StretchValue, 0, 0, 0, 1
        )
    end
)
task.spawn(
    function()
        while task.wait(0.2) do
            local Character = t2.value10.Character

            if Character then
                local GetChildren = Character.GetChildren

                for _, v in ipairs(GetChildren(Character)) do
                    if v:IsA("Tool") then
                        local KnifeCustomEnabled = t2.value20.KnifeCustomEnabled

                        if KnifeCustomEnabled then
                            KnifeCustomEnabled = v:GetAttribute("ThrowSpeed")
                        end

                        if KnifeCustomEnabled then
                            local value20 = t2.value20

                            v.SetAttribute(v, "ThrowSpeed", value20.KnifeThrowSpeed)
                        end

                        local GunCustomEnabled = t2.value20.GunCustomEnabled

                        if GunCustomEnabled then
                            GunCustomEnabled = v:GetAttribute("Cooldown")
                        end

                        if GunCustomEnabled then
                            v.SetAttribute(v, "Cooldown", t2.value20.GunCooldown)
                        end
                    end
                end
            end
        end
    end
)
t2.value55 = {
    R15 = {
        {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"}, {"UpperTorso", "LeftUpperArm"},
        {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
        {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"},
        {"RightLowerArm", "RightHand"}, {"LowerTorso", "LeftUpperLeg"},
        {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
        {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"},
        {"RightLowerLeg", "RightFoot"}
    },
    R6 = {
        {"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"}, {"Torso", "Left Leg"},
        {"Torso", "Right Leg"}
    }
}
t2.value56 = nil
t2.value56 = {}

function t2.value57(p104)
    if not t2.value56[p104] then
        return
    end

    for _, v in pairs(t2.value56[p104]) do
        v.Visible = false

        if v.Remove then
            v:Remove()
        end
    end

    t2.value56[p104] = nil
end

t2.value2.PlayerRemoving:Connect(t2.value57)
t2.value5.RenderStepped:Connect(
    function()
        local
            v431, v432, v433, v434, v435, vector3, ipairs_, value2, v439, v440, v441, v442, v443,
            R6, v445, v446, v447, v448, v449, v450, Line, v452

        if not t2.value20.SpinnerEnabled then
            v558, v559, v560 = ipairs(t2.value2:GetPlayers())

            while true do
                v560, v431 = v558(v559, v560)

                if not v560 then
                    break
                end

                v432, v433, v434, v435 = t2.value27(v431)

                if v432 then
                    v433.Anchored = t2.value20.FreezePlayersEnabled

                    if t2.value20.HitboxEnabled then
                        vector3 = Vector3.new(
                            t2.value20.HitboxSize, t2.value20.HitboxSize, t2.value20.HitboxSize
                        )

                        if v433.Size ~= vector3 then
                            v433.Size = vector3
                        end

                        if v433.Transparency ~= 0.7 then
                            v433.Transparency = 0.7
                        end

                        if v433.CanCollide ~= false then
                            v433.CanCollide = false
                        end
                    else
                        if v433.Size ~= Vector3.new(2, 2, 1) then
                            v433.Size = Vector3.new(2, 2, 1)
                        end

                        if v433.Transparency ~= 1 then
                            v433.Transparency = 1
                        end
                    end
                end
            end

            if t2.value20.ESPEnabled then
                ipairs_ = ipairs
                value2 = t2.value2

                for _, player in ipairs_(value2.GetPlayers(value2)) do
                    v439, v440, v441, v442 = t2.value27(player)

                    if v439 then
                        if not t2.value56[player] then
                            t2.value56[player] = {}
                        end

                        v443 = v442:FindFirstChild("UpperTorso") ~= nil

                        if v443 then
                            v443 = t2.value55.R15
                        end

                        R6 = v443 or t2.value55.R6

                        for i, v in ipairs(R6) do
                            v445 = v442:FindFirstChild(v[1])
                            v446 = v442:FindFirstChild(v[2])

                            if v445 and v446 then
                                v447, v448 = t2.value11:WorldToViewportPoint(v445.Position)
                                v449, v450 = t2.value11:WorldToViewportPoint(v446.Position)
                                Line = t2.value56[player][i]

                                if not Line then
                                    Line = Drawing.new("Line")
                                    Line.Thickness = 1.5
                                    Line.Transparency = 1
                                    t2.value56[player][i] = Line
                                end

                                if v448 and v450 then
                                    Line.From = Vector2.new(v447.X, v447.Y)
                                    Line.To = Vector2.new(v449.X, v449.Y)
                                    Line.Color = t2.value20.ESPColor or Color3.fromRGB(255, 50, 50)
                                    Line.Visible = true
                                else
                                    Line.Visible = false
                                end
                            else
                                v452 = t2.value56[player]

                                if v452 then
                                    v452 = t2.value56[player][i]
                                end

                                if v452 then
                                    t2.value56[player][i].Visible = false
                                end
                            end
                        end
                    else
                        t2.value57(player)
                    end
                end
            else
                for k in pairs(t2.value56) do
                    t2.value57(k)
                end
            end

            return
        end

        local InvisibilityActive = t2.value20.InvisibilityActive

        if InvisibilityActive then
            InvisibilityActive = t2.value28
        end

        local Character = InvisibilityActive or t2.value10.Character

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart")
        end

        if not Character then
            v558, v559, v560 = ipairs(t2.value2:GetPlayers())

            while true do
                v560, v431 = v558(v559, v560)

                if not v560 then
                    break
                end

                v432, v433, v434, v435 = t2.value27(v431)

                if v432 then
                    v433.Anchored = t2.value20.FreezePlayersEnabled

                    if t2.value20.HitboxEnabled then
                        vector3 = Vector3.new(
                            t2.value20.HitboxSize, t2.value20.HitboxSize, t2.value20.HitboxSize
                        )

                        if v433.Size ~= vector3 then
                            v433.Size = vector3
                        end

                        if v433.Transparency ~= 0.7 then
                            v433.Transparency = 0.7
                        end

                        if v433.CanCollide ~= false then
                            v433.CanCollide = false
                        end
                    else
                        if v433.Size ~= Vector3.new(2, 2, 1) then
                            v433.Size = Vector3.new(2, 2, 1)
                        end

                        if v433.Transparency ~= 1 then
                            v433.Transparency = 1
                        end
                    end
                end
            end

            if t2.value20.ESPEnabled then
                ipairs_ = ipairs
                value2 = t2.value2

                for _, player in ipairs_(value2.GetPlayers(value2)) do
                    v439, v440, v441, v442 = t2.value27(player)

                    if v439 then
                        if not t2.value56[player] then
                            t2.value56[player] = {}
                        end

                        v443 = v442:FindFirstChild("UpperTorso") ~= nil

                        if v443 then
                            v443 = t2.value55.R15
                        end

                        R6 = v443 or t2.value55.R6

                        for i, v in ipairs(R6) do
                            v445 = v442:FindFirstChild(v[1])
                            v446 = v442:FindFirstChild(v[2])

                            if v445 and v446 then
                                v447, v448 = t2.value11:WorldToViewportPoint(v445.Position)
                                v449, v450 = t2.value11:WorldToViewportPoint(v446.Position)
                                Line = t2.value56[player][i]

                                if not Line then
                                    Line = Drawing.new("Line")
                                    Line.Thickness = 1.5
                                    Line.Transparency = 1
                                    t2.value56[player][i] = Line
                                end

                                if v448 and v450 then
                                    Line.From = Vector2.new(v447.X, v447.Y)
                                    Line.To = Vector2.new(v449.X, v449.Y)
                                    Line.Color = t2.value20.ESPColor or Color3.fromRGB(255, 50, 50)
                                    Line.Visible = true
                                else
                                    Line.Visible = false
                                end
                            else
                                v452 = t2.value56[player]

                                if v452 then
                                    v452 = t2.value56[player][i]
                                end

                                if v452 then
                                    t2.value56[player][i].Visible = false
                                end
                            end
                        end
                    else
                        t2.value57(player)
                    end
                end
            else
                for k in pairs(t2.value56) do
                    t2.value57(k)
                end
            end

            return
        end

        local CFrame_ = Character.CFrame
        local cFrame = CFrame.Angles
        local SpinnerSpeed = t2.value20.SpinnerSpeed

        Character.CFrame = CFrame_ * cFrame(0, math.rad(SpinnerSpeed), 0)

        local v468, v469, v470 = ipairs(t2.value2:GetPlayers())

        while true do
            v470, v431 = v468(v469, v470)

            if not v470 then
                break
            end

            v432, v433, v434, v435 = t2.value27(v431)

            if v432 then
                v433.Anchored = t2.value20.FreezePlayersEnabled

                if t2.value20.HitboxEnabled then
                    vector3 = Vector3.new(
                        t2.value20.HitboxSize, t2.value20.HitboxSize, t2.value20.HitboxSize
                    )

                    if v433.Size ~= vector3 then
                        v433.Size = vector3
                    end

                    if v433.Transparency ~= 0.7 then
                        v433.Transparency = 0.7
                    end

                    if v433.CanCollide ~= false then
                        v433.CanCollide = false
                    end
                else
                    if v433.Size ~= Vector3.new(2, 2, 1) then
                        v433.Size = Vector3.new(2, 2, 1)
                    end

                    if v433.Transparency ~= 1 then
                        v433.Transparency = 1
                    end
                end
            end
        end

        if t2.value20.ESPEnabled then
            ipairs_ = ipairs
            value2 = t2.value2

            for _, player in ipairs_(value2.GetPlayers(value2)) do
                v439, v440, v441, v442 = t2.value27(player)

                if v439 then
                    if not t2.value56[player] then
                        t2.value56[player] = {}
                    end

                    v443 = v442:FindFirstChild("UpperTorso") ~= nil

                    if v443 then
                        v443 = t2.value55.R15
                    end

                    R6 = v443 or t2.value55.R6

                    for i, v in ipairs(R6) do
                        v445 = v442:FindFirstChild(v[1])
                        v446 = v442:FindFirstChild(v[2])

                        if v445 and v446 then
                            v447, v448 = t2.value11:WorldToViewportPoint(v445.Position)
                            v449, v450 = t2.value11:WorldToViewportPoint(v446.Position)
                            Line = t2.value56[player][i]

                            if not Line then
                                Line = Drawing.new("Line")
                                Line.Thickness = 1.5
                                Line.Transparency = 1
                                t2.value56[player][i] = Line
                            end

                            if v448 and v450 then
                                Line.From = Vector2.new(v447.X, v447.Y)
                                Line.To = Vector2.new(v449.X, v449.Y)
                                Line.Color = t2.value20.ESPColor or Color3.fromRGB(255, 50, 50)
                                Line.Visible = true
                            else
                                Line.Visible = false
                            end
                        else
                            v452 = t2.value56[player]

                            if v452 then
                                v452 = t2.value56[player][i]
                            end

                            if v452 then
                                t2.value56[player][i].Visible = false
                            end
                        end
                    end
                else
                    t2.value57(player)
                end
            end
        else
            for k in pairs(t2.value56) do
                t2.value57(k)
            end
        end
    end
)
t2.value58 = nil
t2.value58 = {}

function t2.value59()
    for _, v in ipairs(t2.value58) do
        local Parent

        if v then
            Parent = v.Parent
        else
            Parent = v
        end

        if Parent then
            v:Destroy()
        end
    end

    t2.value58 = {}
end

local function v479(p105, p106)
    local Part = Instance.new("Part")

    Part.Anchored = true
    Part.CanCollide = false
    Part.Material = Enum.Material.Neon
    Part.Color = Color3.fromRGB(255, 255, 255)
    Part.Size = Vector3.new(0.12, 0.12, (p105 - p106).Magnitude)
    Part.CFrame = CFrame.new(p105:Lerp(p106, 0.5), p106)
    Part.Parent = t2.value6

    local value58 = t2.value58

    table.insert(value58, Part)
end

local CharacterAdded = t2.value10.CharacterAdded

CharacterAdded.Connect(
    CharacterAdded,
    function()
        t2.value59()
    end
)

function t2.value60(p107)
    local InvisibilityActive = t2.value20.InvisibilityActive
    local HumanoidRootPart, v485, raycastParams, t18, v488, hit, v490

    if not InvisibilityActive then
        v583 = InvisibilityActive or t2.value10.Character
        v584 = p107.Character

        if v583 and v584 then
            HumanoidRootPart = v583:FindFirstChild("HumanoidRootPart")

            if HumanoidRootPart then
                v485 = HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)
                raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                raycastParams.FilterDescendantsInstances = {v583, t2.value11}
                t18 = {
                    v584:FindFirstChild("UpperTorso") or v584:FindFirstChild("Torso"),
                    v584:FindFirstChild("HumanoidRootPart"), v584.FindFirstChild(v584, "Head")
                }

                for _, v in ipairs(t18) do
                    if v then
                        v488 = v.Position - v485
                        hit = t2.value6:Raycast(v485, v488, raycastParams)

                        if hit then
                            v490 = hit.Instance:IsDescendantOf(v584)
                        else
                            v490 = hit
                        end

                        if v490 then
                            return v, hit.Position, hit.Instance
                        end
                    end
                end

                return nil, nil, nil
            else
                return nil, nil, nil
            end
        else
            return nil, nil, nil
        end
    end

    InvisibilityActive = t2.value28

    local Character = InvisibilityActive or t2.value10.Character
    local Character2 = p107.Character

    if Character and Character2 then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart then
            v485 = HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)
            raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            raycastParams.FilterDescendantsInstances = {Character, t2.value11}
            t18 = {
                Character2:FindFirstChild("UpperTorso") or Character2:FindFirstChild("Torso"),
                Character2:FindFirstChild("HumanoidRootPart"),
                Character2.FindFirstChild(Character2, "Head")
            }

            for _, v in ipairs(t18) do
                if v then
                    v488 = v.Position - v485
                    hit = t2.value6:Raycast(v485, v488, raycastParams)

                    if hit then
                        v490 = hit.Instance:IsDescendantOf(Character2)
                    else
                        v490 = hit
                    end

                    if v490 then
                        return v, hit.Position, hit.Instance
                    end
                end
            end

            return nil, nil, nil
        else
            return nil, nil, nil
        end
    else
        return nil, nil, nil
    end
end

t2.value61 = 0
t2.value62 = 0.15
task.spawn(
    function()
        while true do
            if true then
            end

            task.wait(0.03)

            local GunAuraEnabled = t2.value20.GunAuraEnabled

            if GunAuraEnabled then
                GunAuraEnabled = not t2.value20.KillAllEnabled
            end

            if GunAuraEnabled then
                local InvisibilityActive = t2.value20.InvisibilityActive

                if InvisibilityActive then
                    InvisibilityActive = t2.value28
                end

                local Character = InvisibilityActive or t2.value10.Character

                if Character then
                    Character = Character:FindFirstChild("HumanoidRootPart")
                end

                local v500

                if Character then
                    v500 = tick() - t2.value61 >= t2.value62
                else
                    v500 = Character
                end

                if v500 then
                    t2.value31()

                    for _, player in ipairs(t2.value2:GetPlayers()) do
                        local v503, _, v505 = t2.value27(player)

                        if v503 then
                            v503 = v505.Health > 0
                        end

                        if v503 then
                            local v506, v507, v508 = t2.value60(player)

                            if v506 and v507 then
                                tick()

                                local v509 = Character.Position + Vector3.new(0, 1.5, 0)

                                t2.value19(139527135965700, Character, 1, false)
                                v479(v509, v507)

                                if t2.value14 then
                                    t2.value14:FireServer(v509, v507, v508, v507)
                                end

                                return
                            end
                        end
                    end
                end
            end
        end
    end
)
t2.value63 = 0
t2.value64 = false
t2.value65 = nil

function t2.value66()
    local ipairs_ = ipairs
    local value2 = t2.value2
    local t19 = {}

    for _, player in ipairs_(value2.GetPlayers(value2)) do
        local v515, v516 = t2.value27(player)

        if v515 then
            table.insert(t19, {player = player, root = v516})
        end
    end

    return t19
end

task.spawn(
    function()
        while true do
            local InvisibilityActive = t2.value20.InvisibilityActive

            if InvisibilityActive then
                InvisibilityActive = t2.value28
            end

            local Character = InvisibilityActive or t2.value10.Character

            if Character and Character:FindFirstChild("HumanoidRootPart") then
                local HumanoidRootPart = Character.HumanoidRootPart

                if t2.value20.KillAllEnabled then
                    local v520 = t2.value66()
                    local v521 = t2.value31()

                    if v521 then
                        v521 = #v520 > 0
                    end

                    if v521 then
                        if t2.value20.KillAllMethod == "Lag" then
                            if not t2.value65 then
                                t2.value65 = tick()
                            end

                            if tick() - t2.value65 <= 1 then
                                if t2.value17 then
                                    for _, v in ipairs(v520) do
                                        for _ = 1, 67 do
                                            t2.value17:FireServer(
                                                HumanoidRootPart.Position,
                                                (v.root.Position - HumanoidRootPart.Position).Unit
                                            )
                                        end
                                    end
                                end

                                task.wait(0.01)
                            else
                                if t2.value16 then
                                    local v525 = math.min(#v520, math.random(1, 4))
                                    local t20 = {table.unpack(v520)}
                                    local t21 = {}

                                    for _ = 1, v525 do
                                        local v529 = math.random(1, #t20)
                                        local v530 = t20[v529]

                                        table.insert(t21, v530)
                                        table.remove(t20, v529)
                                    end

                                    for _, v in ipairs(t21) do
                                        local root = v.root

                                        t2.value16:FireServer(root, root.Position)
                                    end
                                end

                                task.wait(0.5)
                            end
                        else
                            t2.value65 = nil

                            if not t2.value64 then
                                t2.value63 = tick()
                                t2.value64 = true
                            end

                            if tick() - t2.value63 >= 0.3 then
                                for _, v in ipairs(v520) do
                                    local root = v.root

                                    if t2.value20.KillAllEnabled then
                                        if t2.value16 then
                                            t2.value16:FireServer(root, root.Position)
                                        end

                                        if t2.value15 then
                                            t2.value15:FireServer(root)
                                        end

                                        if t2.value14 then
                                            t2.value14:FireServer(
                                                HumanoidRootPart.Position, root.Position, root,
                                                root.Position
                                            )
                                        end
                                    end
                                end
                            end

                            local wait = task.wait
                            local KillAllDelay = t2.value20.KillAllDelay or 0.1

                            wait((math.clamp(KillAllDelay, 0.06, 0.3)))
                        end
                    else
                        t2.value64 = false
                        t2.value65 = nil
                        task.wait(0.1)
                    end
                else
                    t2.value64 = false
                    t2.value65 = nil

                    local wait = task.wait
                    local KillAllDelay = t2.value20.KillAllDelay or 0.1

                    wait((math.clamp(KillAllDelay, 0.06, 0.3)))
                end

                local KnifeAuraEnabled = t2.value20.KnifeAuraEnabled

                if KnifeAuraEnabled then
                    KnifeAuraEnabled = not t2.value20.KillAllEnabled
                end

                if KnifeAuraEnabled then
                    local ipairs_ = ipairs
                    local value2 = t2.value2

                    for _, player in ipairs_(value2.GetPlayers(value2)) do
                        local v546, v547 = t2.value27(player)

                        if v546 then
                            v546 = (v547.Position - HumanoidRootPart.Position).Magnitude <= t2.value20.KnifeAuraRange
                        end

                        if v546 then
                            if t2.value16 then
                                t2.value16:FireServer(v547, v547.Position)
                            elseif t2.value15 then
                                t2.value15:FireServer(v547)
                            end
                        end
                    end
                end
            else
                t2.value64 = false
                t2.value65 = nil
                task.wait(0.1)
            end
        end
    end
)
