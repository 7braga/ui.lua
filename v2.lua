local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

game:GetService("TweenService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local function v9(o)local l=o:FindFirstChild('Dat\x61');if l and l:FindFirstChild("L\101\118\101l")then return l.Level.Value;end;return"\u{03F}\63\u{3F}";end

local t1 = {
	FileName = "CentuDox-67.json",
	Data = {}
}

local function v12()
	t1.Data = {
		FastAttack = false,
		InfiniteEnergy = false,
		UnbreakableSkills = false,
		AntiStun = false,
		PlayerEsp = false,
		WalkOnWater = false,
		AutoRaceV3 = false,
		AutoRaceV4 = false,
		SpeedEnabled = false,
		DashEnabled = false,
		SpeedValue = 16,
		DashValue = 300,
		FADistance = 100,
		AimbotSkills = false,
		AimbotSkillsNPC = false,
		AimbotSkillsPlayer = false,
		PlayerTracers = true,
		NPCTracers = true,
		PredictionAmount = 0.2,
		CamlockEnabled = false
	}
end
local function v13()
	pcall(function()
		writefile(t1.FileName, HttpService:JSONEncode(t1.Data))
	end)
end

if not (function()
	local ok, result = pcall(function()
		return HttpService:JSONDecode(readfile(t1.FileName))
	end)

	if not ok or typeof(result) ~= "table" then
		return false
	end

	v12()

	for k, v in pairs(result) do
		t1.Data[k] = v
	end

	return true
end)() then
	v12()
	v13()
end

getgenv().Setting = getgenv().Setting or {}

local Setting = getgenv().Setting

Setting.PredictionAmount = t1.Data.PredictionAmount or 0.2
Setting.MaxDistance = 1000
_G.FastAttackEnabled = t1.Data.FastAttack
_G.InfiniteEnergy = t1.Data.InfiniteEnergy
_G.UnbreakableSkills = t1.Data.UnbreakableSkills
_G.AntiStun = t1.Data.AntiStun
_G.PlayerEsp = t1.Data.PlayerEsp
_G.WalkOnWater = t1.Data.WalkOnWater
_G.AutoRaceV3 = t1.Data.AutoRaceV3
_G.AutoRaceV4 = t1.Data.AutoRaceV4

local SpeedEnabled = t1.Data.SpeedEnabled
local DashEnabled = t1.Data.DashEnabled

_G.FADistance = t1.Data.FADistance or 100
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "CentuDox Hub",
	Text = "Config Loaded Successfully!",
	Duration = 3
})

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))

ScreenGui.Name = "CentuDox_Integrated_Ultimate"
ScreenGui.ResetOnSpawn = false

local TextButton = Instance.new("TextButton", ScreenGui)

TextButton.Size = UDim2.new(0, 80, 0, 30)
TextButton.Position = UDim2.new(0, 20, 0, 20)
TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BackgroundTransparency = 0.3
TextButton.Text = "MENU"
TextButton.TextColor3 = Color3.fromRGB(0, 170, 255)
TextButton.Font = Enum.Font.Jura
TextButton.TextSize = 18
TextButton.Active = true
TextButton.Draggable = true
Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 6)

local UIStroke = Instance.new("UIStroke", TextButton)

UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 1.5

local CanvasGroup = Instance.new("CanvasGroup", ScreenGui)

CanvasGroup.Size = UDim2.new(0, 210, 0, 350)
CanvasGroup.Position = UDim2.new(0, 20, 0, 60)
CanvasGroup.BackgroundTransparency = 1
CanvasGroup.Visible = false
Instance.new("UICorner", CanvasGroup).CornerRadius = UDim.new(0, 7)

local UIStroke2 = Instance.new("UIStroke", CanvasGroup)

UIStroke2.Thickness = 1.6
UIStroke2.Color = Color3.fromRGB(0, 170, 255)

local ImageLabel = Instance.new("ImageLabel", CanvasGroup)

ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.BackgroundTransparency = 0.2
ImageLabel.Image = "rbxassetid://103239668295637"
ImageLabel.ImageTransparency = 0.5
Instance.new("UIGradient", ImageLabel).Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 10, 20)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 45, 90))
})

local TextLabel = Instance.new("TextLabel", CanvasGroup)

TextLabel.Size = UDim2.new(1, 0, 0, 32)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "👑 CentuDox V3 👑"
TextLabel.Font = Enum.Font.Jura
TextLabel.TextSize = 15
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local ScrollingFrame = Instance.new("ScrollingFrame", CanvasGroup)

ScrollingFrame.Size = UDim2.new(1, -12, 1, -42)
ScrollingFrame.Position = UDim2.new(0, 6, 0, 37)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 2
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)

local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)

UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 8)
end)

local function v30(p1)
	Instance.new("UICorner", p1).CornerRadius = UDim.new(0, 4)

	local UIStroke3 = Instance.new("UIStroke", p1)

	UIStroke3.Thickness = 1
	UIStroke3.Color = Color3.fromRGB(0, 170, 255)
	UIStroke3.Transparency = 0.6
end
local function createTextButton(p2, p3)
	local TextButton2 = Instance.new("TextButton", ScrollingFrame)

	TextButton2.Size = UDim2.new(0, 210, 0, 32)
	TextButton2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	TextButton2.BackgroundTransparency = 0.5
	TextButton2.Text = p2
	TextButton2.Font = Enum.Font.Jura
	TextButton2.TextSize = 13
	TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
	v30(TextButton2)
	TextButton2.MouseButton1Click:Connect(p3)

	return TextButton2
end
local function createFrame(p4, p5, p6)
	local Frame = Instance.new("Frame", ScrollingFrame)

	Frame.Size = UDim2.new(0, 210, 0, 32)
	Frame.BackgroundTransparency = 1

	local TextButton2 = Instance.new("TextButton", Frame)

	TextButton2.Size = UDim2.new(0, 150, 1, 0)
	TextButton2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	TextButton2.BackgroundTransparency = 0.5
	TextButton2.Text = p4
	TextButton2.Font = Enum.Font.Jura
	TextButton2.TextSize = 12
	TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
	v30(TextButton2)

	local TextButton3 = Instance.new("TextButton", Frame)

	TextButton3.Position = UDim2.new(0, 155, 0, 0)
	TextButton3.Size = UDim2.new(0, 55, 1, 0)
	TextButton3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	TextButton3.BackgroundTransparency = 0.5
	TextButton3.Text = "OFF"
	TextButton3.Font = Enum.Font.Jura
	TextButton3.TextColor3 = Color3.fromRGB(255, 80, 80)
	v30(TextButton3)

	local function v38()
		local v39 = p5()

		TextButton3.Text = v39 and "ON" or "OFF"
		TextButton3.TextColor3 = v39 and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 80, 80)

		if p6 then
			t1.Data[p6] = v39
			v13()
		end
	end

	TextButton2.MouseButton1Click:Connect(v38)
	TextButton3.MouseButton1Click:Connect(v38)

	if p6 and t1.Data[p6] then
		TextButton3.Text = "ON"
		TextButton3.TextColor3 = Color3.fromRGB(0, 255, 150)
	end

	return Frame
end

TextButton.MouseButton1Click:Connect(function()
	CanvasGroup.Visible = not CanvasGroup.Visible
end)
createTextButton("CentuDox Camlock", function()
	if ScreenGui:FindFirstChild("CamLockUI") then
		return
	end

	local CamlockEnabled = t1.Data.CamlockEnabled or false
	local n1 = 0.163186
	local u42

	local function v43()
		local o = math.huge
		local v = Vector2.new(GuiService:GetScreenResolution().X / 2, GuiService:GetScreenResolution().Y / 2)
		local s = nil

		for e, e in ipairs(Players:GetPlayers()) do
			if e ~= LocalPlayer then
				local l = e.Character

				if l and l:FindFirstChild("HumanoidRootPart") and l:FindFirstChild("Humanoid") then
					if l.Humanoid.Health > 0 then
						local y, e = workspace.CurrentCamera:WorldToViewportPoint(l.HumanoidRootPart.Position)

						if e then
							local O = (v - Vector2.new(y.X, y.Y)).Magnitude

							if O < o then
								s = l.HumanoidRootPart
								o = O
							end
						end
					end
				end
			end
		end

		return s
	end

	local TextButton2 = Instance.new("TextButton", ScreenGui)

	TextButton2.Name = "CamLockUI"
	TextButton2.Size = UDim2.new(0, 200, 0, 50)
	TextButton2.Position = UDim2.new(0.5, -100, 0.2, 0)
	TextButton2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	TextButton2.BackgroundTransparency = 0.4
	TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextButton2.Text = CamlockEnabled and "CentuDox: ON" or "CentuDox: OFF"
	TextButton2.Font = Enum.Font.Jura
	TextButton2.TextSize = 18
	TextButton2.Active = true
	TextButton2.Draggable = true
	Instance.new("UICorner", TextButton2).CornerRadius = UDim.new(0, 8)

	local UIStroke3 = Instance.new("UIStroke", TextButton2)

	UIStroke3.Thickness = 2
	UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	local connection

	TextButton2.MouseButton1Click:Connect(function()
		CamlockEnabled = not CamlockEnabled
		t1.Data.CamlockEnabled = CamlockEnabled
		v13()

		if CamlockEnabled then
			TextButton2.Text = "CentuDox: ON"
			TextButton2.TextColor3 = Color3.fromRGB(0, 255, 255)
			u42 = v43()
			connection = RunService.RenderStepped:Connect(function()
				if CamlockEnabled and u42 and u42.Parent then
					workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, u42.Position + (u42.Velocity * n1))
				else
					if connection then
						connection:Disconnect()
					end

					CamlockEnabled = false
					t1.Data.CamlockEnabled = false
					v13()
					TextButton2.Text = "CentuDox: OFF"
					TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
				end
			end)
		else
			TextButton2.Text = "CentuDox: OFF"
			TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)

			if connection then
				connection:Disconnect()
			end

			u42 = nil
		end
	end)
end)

local function v56(p7)
	if not p7 then
		return nil
	end

	local Humanoid = p7.Parent:FindFirstChildOfClass("Humanoid")

	if Humanoid and not (Humanoid.WalkSpeed < 8) then
		return p7.Position + p7.Velocity * Setting.PredictionAmount
	end

	return p7.Position
end

local AimbotSkillsPlayer = t1.Data.AimbotSkillsPlayer or false
local PlayerTracers = t1.Data.PlayerTracers or true
local u60
local u61
local u62
local Line = Drawing.new("Line")

Line.Thickness = 2.5
Line.Color = Color3.fromRGB(0, 170, 255)
Line.Transparency = 1
Line.Visible = false

local AimbotSkillsNPC = t1.Data.AimbotSkillsNPC or false
local NPCTracers = t1.Data.NPCTracers or true
local u66
local u67
local Line2 = Drawing.new("Line")

Line2.Thickness = 2.5
Line2.Color = Color3.fromRGB(255, 170, 0)
Line2.Transparency = 1
Line2.Visible = false

local function v69(o)
	local O = LocalPlayer:FindFirstChild("PlayerGui")

	if not O then
		return false
	end

	local l = O:FindFirstChild("Main") and O.Main:FindFirstChild("Allies") and O.Main.Allies.Container.Allies:FindFirstChild("ScrollingFrame")

	return l and l:FindFirstChild(o.Name) ~= nil
end
local function v72(o)
	local O = Workspace:FindFirstChild("_WorldOrigin")
	local l = O and O:FindFirstChild("SafeZones")

	if not l then
		return false
	end

	for O, O in ipairs(l:GetChildren()) do
		if O:IsA("BasePart") then
			local l = O:FindFirstChildOfClass("SpecialMesh")
			local s = l and (l.Scale.X / 2) or 50
			local l = (O.Position - o).Magnitude

			if l <= s then
				return true
			end
		end
	end

	return false
end
local function v80(o)
	if not o then
		return nil
	end

	local e = nil
	local F = Setting.MaxDistance

	for O, O in pairs(Players:GetPlayers()) do
		if O ~= LocalPlayer and O.Character and O.Character:FindFirstChild("HumanoidRootPart") and O.Character:FindFirstChild("Humanoid") then
			if O.Character.Humanoid.Health > 0 then
				local y = O.Character.HumanoidRootPart

				if v72(y.Position) then
					continue
				end

				local s = O:GetAttribute("PvpDisabled") or false

				if s then
					continue
				end

				if LocalPlayer.Team and O.Team then
					if LocalPlayer.Team.Name == "Marines" and O.Team.Name == "Marines" then
						continue
					end
				end

				if v69(O) then
					continue
				end

				local l = (o.Position - y.Position).Magnitude

				if l < F then
					F = l
					e = O
				end
			end
		end
	end

	return e
end
local function v88(o)
	if not o then
		return nil
	end

	local O, s = nil, Setting.MaxDistance
	local l = workspace:FindFirstChild("Enemies")

	if l then
		for y, y in ipairs(l:GetChildren()) do
			local l = y:FindFirstChildOfClass("Humanoid")
			local v = y:FindFirstChild("HumanoidRootPart") or y:FindFirstChild("UpperTorso")

			if l and l.Health > 0 and v then
				local l = (v.Position - o.Position).Magnitude

				if l <= s then
					s = l
					O = y
				end
			end
		end
	end

	return O
end

task.spawn(function()
	while task.wait(0.1) do
		if AimbotSkillsNPC then
			local o = LocalPlayer.Character
			local O = o and o:FindFirstChild("HumanoidRootPart")

			if O then
				u66 = v88(O)
			end
		else
			u66 = nil
		end
	end
end)
task.spawn(function()
	while task.wait(0.1) do
		if AimbotSkillsPlayer then
			local o = LocalPlayer.Character
			local s = o and o:FindFirstChild("HumanoidRootPart")

			if s then
				u60 = v80(s)
			end
		else
			u60 = nil
		end
	end
end)

local function v101()
	local Character_ = LocalPlayer.Character

	if not Character_ then
		return nil
	end

	local Tool = Character_:FindFirstChildOfClass("Tool")

	if not Tool then
		return nil
	end

	local ToolTip = Tool.ToolTip

	if ToolTip == "Melee" then
		return ToolTip
	end

	return nil
end
local function v105()
	u62 = v101()
end

local v106 = getrawmetatable(game)
local __namecall = v106.__namecall

setreadonly(v106, false)
v106.__namecall = newcclosure(function(...)
	local o = getnamecallmethod()
	local F = { ... }

	if tostring(o) == "FireServer" then
		if tostring(F[1]) == "RemoteEvent" then
			if tostring(F[2]) ~= "true" and tostring(F[2]) ~= "false" then
				if AimbotSkillsPlayer and u61 and not u62 then
					F[2] = u61

					return __namecall(unpack(F))
				elseif AimbotSkillsNPC and u67 then
					F[2] = u67

					return __namecall(unpack(F))
				end
			end
		end
	end

	return __namecall(...)
end)
setreadonly(v106, true)

local Mouse = ReplicatedStorage:FindFirstChild("Mouse")

if Mouse then
	local module

	pcall(function()
		module = require(Mouse)
	end)

	if module and typeof(module) == "table" then
		pcall(function()
			local t2 = {
				Hit = rawget(module, "Hit"),
				Target = rawget(module, "Target")
			}
			local v113 = getrawmetatable(module)

			if v113 then
				setreadonly(v113, false)
			else
				v113 = {}
				setmetatable(module, v113)
			end

			rawset(module, "Hit", nil)
			rawset(module, "Target", nil)
			v113.__index = function(o, o)
				if o == "Hit" then
					if AimbotSkillsPlayer and u61 and u62 then
						return CFrame.new(u61)
					end

					return t2.Hit
				elseif o == "Target" then
					if AimbotSkillsPlayer and u61 and u62 then
						return u61
					end

					return t2.Target
				end
			end
			v113.__newindex = function(o, O, s)
				if O == "Hit" or O == "Target" then
					t2[O] = s
				else
					rawset(o, O, s)
				end
			end
			setreadonly(v113, true)
		end)
	end
end

pcall(function()
	local v114

	v114 = hookfunction(require(ReplicatedStorage.Modules.CombatUtil).GetTargetPosition, function(o, v, e, F, ...)
		if AimbotSkillsPlayer and u61 then
			local l = LocalPlayer.Character
			local O = l and l:FindFirstChildOfClass("Tool")
			local l = O and (O:FindFirstChild("Melee") or O.ToolTip == "Melee")

			if not l then
				e = u61
			end
		end

		return v114(o, v, e, F, ...)
	end)
end)
RunService.Heartbeat:Connect(function()
	if not AimbotSkillsPlayer or not u60 then
		u61 = nil
		Line.Visible = false

		return
	end

	local o = LocalPlayer.Character
	local O = o and o:FindFirstChild("HumanoidRootPart")
	local o = u60.Character
	local l = o and o:FindFirstChild("HumanoidRootPart")

	if not O or not l or (l.Position - O.Position).Magnitude > Setting.MaxDistance then
		u61 = nil
		Line.Visible = false

		return
	end

	u61 = v56(l)

	if PlayerTracers and u61 then
		local o, l = workspace.CurrentCamera:WorldToViewportPoint(O.Position)
		local O, s = workspace.CurrentCamera:WorldToViewportPoint(u61)

		if l and s then
			Line.From = Vector2.new(o.X, o.Y)
			Line.To = Vector2.new(O.X, O.Y)
			Line.Visible = true
		else
			Line.Visible = false
		end
	else
		Line.Visible = false
	end
end)
RunService.Heartbeat:Connect(function()
	if not AimbotSkillsNPC or not u66 or not u66.Parent then
		u67 = nil
		Line2.Visible = false

		return
	end

	local o = LocalPlayer.Character
	local y = o and o:FindFirstChild("HumanoidRootPart")
	local o = u66:FindFirstChild("HumanoidRootPart") or u66:FindFirstChild("UpperTorso")

	if not y or not o or (o.Position - y.Position).Magnitude > Setting.MaxDistance then
		u67 = nil
		Line2.Visible = false

		return
	end

	u67 = v56(o)

	if NPCTracers and u67 then
		local o, l = workspace.CurrentCamera:WorldToViewportPoint(y.Position)
		local s, y = workspace.CurrentCamera:WorldToViewportPoint(u67)

		if l and y then
			Line2.From = Vector2.new(o.X, o.Y)
			Line2.To = Vector2.new(s.X, s.Y)
			Line2.Visible = true
		else
			Line2.Visible = false
		end
	else
		Line2.Visible = false
	end
end)
LocalPlayer.CharacterAdded:Connect(function(character)
	Character = character
	character.ChildAdded:Connect(v105)
	character.ChildRemoved:Connect(v105)
	v105()
end)

if LocalPlayer.Character then
	LocalPlayer.Character.ChildAdded:Connect(v105)
	LocalPlayer.Character.ChildRemoved:Connect(v105)
	v105()
end

createFrame("Aimbot Skills + Gun M1 👤", function()
	AimbotSkillsPlayer = not AimbotSkillsPlayer
	t1.Data.AimbotSkillsPlayer = AimbotSkillsPlayer
	v13()

	if not AimbotSkillsPlayer then
		u60 = nil
		u61 = nil
		Line.Visible = false
	end

	return AimbotSkillsPlayer
end, "AimbotSkillsPlayer")
createFrame("Player Tracers Off/On ✏️", function()
	PlayerTracers = not PlayerTracers
	t1.Data.PlayerTracers = PlayerTracers
	v13()

	if not PlayerTracers then
		Line.Visible = false
	end

	return PlayerTracers
end, "PlayerTracers")
createFrame("Aimbot Skills + Gun M1 👾", function()
	AimbotSkillsNPC = not AimbotSkillsNPC
	t1.Data.AimbotSkillsNPC = AimbotSkillsNPC
	v13()

	if not AimbotSkillsNPC then
		u66 = nil
		u67 = nil
		Line2.Visible = false
	end

	return AimbotSkillsNPC
end, "AimbotSkillsNPC")
createFrame("NPC Tracers Off/On ✏️", function()
	NPCTracers = not NPCTracers
	t1.Data.NPCTracers = NPCTracers
	v13()

	if not NPCTracers then
		Line2.Visible = false
	end

	return NPCTracers
end, "NPCTracers")

local t3 = {}

t3.__index = t3
t3.new = function()
	return setmetatable({
		Debounce = 0,
		ComboDebounce = tick(),
		M1Combo = 5
	}, t3)
end
t3.GetBladeHits = function(o,o,l)local O=o:GetPivot().Position;local s={};local function y(v)if not v then return;end;for e,e in ipairs(v:GetChildren())do if e~=o and e:FindFirstChild('Hu\109\u{61}n\111id')and e.Humanoid.Health>0 then local o=e:FindFirstChild("Hu\x6Da\z no\105dRoo\116\z  Pa\114\116");if o and(O-o.Position).Magnitude<=l then table.insert(s,{e,o});end;end;end;end;y(workspace:FindFirstChild("\69\110\em\105e\115"));y(workspace:FindFirstChild('Charac\zter\115'));return s;end
t3.UseFruitM1 = function(o,o,l,O,s)if not s[1]or not l:FindFirstChild("\L\101\zft\z  ClickR\e\109\111t\e")then return;end;local y=s[1][2];local s=(y.Position-o:GetPivot().Position).Unit;l.LeftClickRemote:FireServer(s,O);end
t3.Attack = function(p8)
	if tick() - p8.Debounce < 0.01 then
		return
	end

	local Character_ = LocalPlayer.Character

	if not Character_ or not Character_:FindFirstChild("Humanoid") then
		return
	end

	local Tool = Character_:FindFirstChildOfClass("Tool")

	if not Tool then
		return
	end

	local ToolTip = Tool.ToolTip
	local bladeHits = p8:GetBladeHits(Character_, _G.FADistance)

	if #bladeHits > 0 then
		if tick() - p8.ComboDebounce > 0.5 then
			p8.M1Combo = 1
		else
			p8.M1Combo = p8.M1Combo >= 3 and 1 or p8.M1Combo + 1
		end

		p8.ComboDebounce = tick()

		local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")

		if ToolTip == "Blox Fruit" and Tool:FindFirstChild("LeftClickRemote") then
			p8:UseFruitM1(Character_, Tool, p8.M1Combo, bladeHits)
		elseif table.find({
				"Melee",
				"Sword"
			}, ToolTip) then
			Net:WaitForChild("RE/RegisterAttack"):FireServer(0.1)
			Net:WaitForChild("RE/RegisterHit"):FireServer(bladeHits[1][2], bladeHits)
		end

		p8.Debounce = tick()
	end
end

local v147 = t3.new()

RunService.Stepped:Connect(function()
	if _G.FastAttackEnabled then
		v147:Attack()
	end
end)
createFrame("Fast Attack", function()
	_G.FastAttackEnabled = not _G.FastAttackEnabled
	t1.Data.FastAttack = _G.FastAttackEnabled
	v13()

	return _G.FastAttackEnabled
end, "FastAttack")

local Frame = Instance.new("Frame", ScrollingFrame)

Frame.Name = "FastAttackDistanceFrame"
Frame.Size = UDim2.new(0, 210, 0, 30)
Frame.BackgroundTransparency = 1

local TextLabel2 = Instance.new("TextLabel", Frame)

TextLabel2.Size = UDim2.new(0, 120, 1, 0)
TextLabel2.Text = "  Attack Distance:"
TextLabel2.Font = Enum.Font.Jura
TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel2.TextSize = 12
TextLabel2.BackgroundTransparency = 1
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left

local TextBox = Instance.new("TextBox", Frame)

TextBox.Size = UDim2.new(0, 70, 0, 22)
TextBox.Position = UDim2.new(0, 130, 0, 4)
TextBox.BackgroundColor3 = Color3.new(0, 0, 0)
TextBox.Text = tostring(t1.Data.FADistance or 100)
TextBox.Font = Enum.Font.Jura
TextBox.TextColor3 = Color3.fromRGB(0, 170, 255)
v30(TextBox)
TextBox.FocusLost:Connect(function()
	_G.FADistance = tonumber(TextBox.Text) or 100
	t1.Data.FADistance = _G.FADistance
	v13()
	TextBox.Text = tostring(_G.FADistance)
end)

local connection

local function v152()
	local Energy = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Energy", 10)

	if not Energy then
		return
	end

	if connection then
		connection:Disconnect()
	end

	connection = Energy.Changed:Connect(function()
		if _G.InfiniteEnergy then
			Energy.Value = Energy.MaxValue
		end
	end)

	if _G.InfiniteEnergy then
		Energy.Value = Energy.MaxValue
	end
end

LocalPlayer.CharacterAdded:Connect(function()
	v152()
end)

if LocalPlayer.Character then
	task.spawn(v152)
end

createFrame("Infinite Energy", function()
	_G.InfiniteEnergy = not _G.InfiniteEnergy
	t1.Data.InfiniteEnergy = _G.InfiniteEnergy
	v13()

	if _G.InfiniteEnergy then
		task.spawn(v152)
	end

	return _G.InfiniteEnergy
end, "InfiniteEnergy")
createTextButton("Jump Boost", function()
	if ScreenGui:FindFirstChild("JumpBtn") then
		return
	end

	local TextButton2 = Instance.new("TextButton", ScreenGui)

	TextButton2.Name = "JumpBtn"
	TextButton2.Size = UDim2.new(0, 100, 0, 35)
	TextButton2.Position = UDim2.new(0.5, -50, 0.8, 0)
	TextButton2.BackgroundColor3 = Color3.new(0, 0, 0)
	TextButton2.TextColor3 = Color3.new(0, 0.7, 1)
	TextButton2.Text = "JUMP"
	TextButton2.Font = Enum.Font.Jura
	TextButton2.Draggable = true
	v30(TextButton2)

	local u155 = false
	local connection2

	TextButton2.MouseButton1Down:Connect(function()
		u155 = true
		TextButton2.Text = "GO!"

		local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

		if Humanoid then
			local JumpPower = Humanoid.JumpPower

			Humanoid.UseJumpPower = true
			Humanoid.JumpPower = 100
			connection2 = RunService.Heartbeat:Connect(function()
				if u155 then
					Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end)
			task.delay(0.5, function()
				if Humanoid then
					Humanoid.JumpPower = JumpPower
				end
			end)
		end
	end)
	TextButton2.MouseButton1Up:Connect(function()
		u155 = false
		TextButton2.Text = "JUMP"

		if connection2 then
			connection2:Disconnect()
		end
	end)
end)
createTextButton("Auto Combo/Macro", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/JustParadozCode/CentuDox-Hub/refs/heads/main/Auto%2ombo%0C20V3.xyz"))()
end)
createTextButton("Flashstep Aimbot Nearest", function()
	if ScreenGui:FindFirstChild("SoruFloatingBtn") then
		return
	end

	local Soru = require(ReplicatedStorage:WaitForChild("Effect")).new("Shared.Soru")
	local Util = require(ReplicatedStorage:WaitForChild("Util"))
	local n2 = 0
	local TextButton2 = Instance.new("TextButton", ScreenGui)

	TextButton2.Name = "SoruFloatingBtn"
	TextButton2.Size = UDim2.new(0, 110, 0, 35)
	TextButton2.Position = UDim2.new(0.5, -55, 0.8, 0)
	TextButton2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	TextButton2.BackgroundTransparency = 0.4
	TextButton2.TextColor3 = Color3.fromRGB(0, 170, 255)
	TextButton2.Text = "SORU NEAREST"
	TextButton2.Font = Enum.Font.Jura
	TextButton2.TextSize = 11
	TextButton2.Active = true
	v30(TextButton2)

	local u163 = false
	local u164
	local Position
	local Position2
	local u167 = false

	local function v168(p9)
		local v169 = p9.Position - Position

		TextButton2.Position = UDim2.new(Position2.X.Scale, Position2.X.Offset + v169.X, Position2.Y.Scale, Position2.Y.Offset + v169.Y)
	end

	TextButton2.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			u163 = true
			u167 = false
			Position = input.Position
			Position2 = TextButton2.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					u163 = false
				end
			end)
		end
	end)
	TextButton2.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			u164 = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == u164 and u163 then
			if (input.Position - Position).Magnitude > 5 then
				u167 = true
			end

			v168(input)
		end
	end)
	TextButton2.MouseButton1Click:Connect(function()
		if u167 then
			return
		end

		if tick() - n2 < 1.5 then
			return
		end

		local Character_ = LocalPlayer.Character
		local HumanoidRootPart = Character_ and Character_:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local v172
		local n3 = 250

		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				if player.Character:FindFirstChild("HumanoidRootPart") then
					local HumanoidRootPart2 = player.Character.HumanoidRootPart
					local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude

					if Magnitude < n3 and not v69(player) then
						n3 = Magnitude
						v172 = HumanoidRootPart2
					end
				end
			end
		end

		if v172 then
			n2 = tick()

			local CFrame_ = HumanoidRootPart.CFrame
			local cFrame = CFrame.new(v172.Position + v172.CFrame.LookVector * -3, v172.Position)

			ReplicatedStorage.Remotes.CommE:FireServer("Soru", CFrame_, cFrame, workspace:GetServerTimeNow(), math.random(1, 900000000))
			Soru:play({
				CFrame = CFrame_,
				Character = Character_,
				Mode = 1,
				player = LocalPlayer
			})
			HumanoidRootPart.CFrame = cFrame

			local v180 = Util.Anims:Get(Character_, "FlashStepRegular")

			if v180 then
				v180:Play(0, nil, 2)
			end

			Soru:play({
				CFrame = cFrame,
				Character = Character_,
				Mode = 2
			})
			TextButton2.Text = "GO!"
			TextButton2.TextColor3 = Color3.fromRGB(0, 255, 150)
			task.delay(0.5, function()
				TextButton2.Text = "SORU NEAREST"
				TextButton2.TextColor3 = Color3.fromRGB(0, 170, 255)
			end)
		else
			TextButton2.Text = "NO TARGET"
			TextButton2.TextColor3 = Color3.fromRGB(255, 80, 80)
			task.delay(0.5, function()
				TextButton2.Text = "SORU NEAREST"
				TextButton2.TextColor3 = Color3.fromRGB(0, 170, 255)
			end)
		end
	end)
end)
RunService.RenderStepped:Connect(function()
	if _G.PlayerEsp then
		for o, o in ipairs(Players:GetPlayers()) do
			if o ~= LocalPlayer and o.Character and o.Character:FindFirstChild("Head") then
				local y = o.Character:FindFirstChild("CentuESP") or Instance.new("BillboardGui", o.Character)

				y.Name = "CentuESP"
				y.Size = UDim2.new(0, 200, 0, 70)
				y.StudsOffset = Vector3.new(0, 2, 0)
				y.AlwaysOnTop = true
				y.Adornee = o.Character.Head
				y.Enabled = true

				local v = y:FindFirstChild("Label") or Instance.new("TextLabel", y)

				v.Name = "Label"
				v.BackgroundTransparency = 1
				v.Size = UDim2.new(1, 0, 1, 0)
				v.Font = Enum.Font.Jura
				v.RichText = true
				v.TextSize = 15
				v.TextStrokeTransparency = 0.4
				v.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

				local y = math.floor((o.Character.Head.Position - workspace.CurrentCamera.CFrame.Position).Magnitude)
				local O = math.floor(o.Character:FindFirstChildOfClass("Humanoid") and o.Character.Humanoid.Health or 0)
				local e = o:GetAttribute("PvpDisabled") or false
				local F = e and "<font color=\"#FF0000\">[PvP OFF]</font>" or "<font color=\"#00FF00\">[PvP ON]</font>"

				v.TextColor3 = (o.Team and o.Team.Name == "Marines") and Color3.fromRGB(0, 35, 100) or Color3.fromRGB(100, 0, 0)
				v.Text = string.format("<b>%s</b> [Lvl %s] %s\n%d HP | %d M", o.Name, tostring(v9(o)), F, O, y)
			end
		end
	else
		for o, o in ipairs(Players:GetPlayers()) do
			local l = o.Character and o.Character:FindFirstChild("CentuESP")

			if l then
				l.Enabled = false
			end
		end
	end
end)
createFrame("ESP", function()
	_G.PlayerEsp = not _G.PlayerEsp
	t1.Data.PlayerEsp = _G.PlayerEsp
	v13()

	return _G.PlayerEsp
end, "PlayerEsp")
createFrame("Unbreakable Skills", function()
	_G.UnbreakableSkills = not _G.UnbreakableSkills
	t1.Data.UnbreakableSkills = _G.UnbreakableSkills
	v13()

	return _G.UnbreakableSkills
end, "UnbreakableSkills")
createFrame("Anti Stun", function()
	_G.AntiStun = not _G.AntiStun
	t1.Data.AntiStun = _G.AntiStun
	v13()

	return _G.AntiStun
end, "AntiStun")
createFrame("Water Walk", function()
	_G.WalkOnWater = not _G.WalkOnWater
	t1.Data.WalkOnWater = _G.WalkOnWater
	v13()

	return _G.WalkOnWater
end, "WalkOnWater")
createFrame("Auto Race V3", function()
	_G.AutoRaceV3 = not _G.AutoRaceV3
	t1.Data.AutoRaceV3 = _G.AutoRaceV3
	v13()

	return _G.AutoRaceV3
end, "AutoRaceV3")
createFrame("Auto Race V4", function()
	_G.AutoRaceV4 = not _G.AutoRaceV4
	t1.Data.AutoRaceV4 = _G.AutoRaceV4
	v13()

	return _G.AutoRaceV4
end, "AutoRaceV4")

local Frame2 = Instance.new("Frame", ScrollingFrame)

Frame2.Size = UDim2.new(0, 210, 0, 32)
Frame2.BackgroundTransparency = 1

local TextBox2 = Instance.new("TextBox", Frame2)

TextBox2.Size = UDim2.new(0, 50, 1, 0)
TextBox2.Text = tostring(t1.Data.SpeedValue or 16)
TextBox2.Font = Enum.Font.Jura
TextBox2.BackgroundColor3 = Color3.new(0, 0, 0)
v30(TextBox2)

local TextButton2 = Instance.new("TextButton", Frame2)

TextButton2.Size = UDim2.new(0, 155, 1, 0)
TextButton2.Position = UDim2.new(0, 55, 0, 0)
TextButton2.Text = SpeedEnabled and "Speed ON" or "Speed OFF"
TextButton2.Font = Enum.Font.Jura
TextButton2.BackgroundColor3 = Color3.new(0, 0, 0)
v30(TextButton2)
TextButton2.TextColor3 = SpeedEnabled and Color3.new(0, 1, 0.6) or Color3.new(1, 0.3, 0.3)
TextButton2.MouseButton1Click:Connect(function()
	SpeedEnabled = not SpeedEnabled
	t1.Data.SpeedEnabled = SpeedEnabled
	v13()
	TextButton2.Text = SpeedEnabled and "Speed ON" or "Speed OFF"
	TextButton2.TextColor3 = SpeedEnabled and Color3.new(0, 1, 0.6) or Color3.new(1, 0.3, 0.3)
end)
TextBox2.FocusLost:Connect(function()
	local speedValue = tonumber(TextBox2.Text) or 16

	t1.Data.SpeedValue = speedValue
	TextBox2.Text = tostring(speedValue)
	v13()
end)

local Frame3 = Instance.new("Frame", ScrollingFrame)

Frame3.Size = UDim2.new(0, 210, 0, 32)
Frame3.BackgroundTransparency = 1

local TextBox3 = Instance.new("TextBox", Frame3)

TextBox3.Size = UDim2.new(0, 50, 1, 0)
TextBox3.Text = tostring(t1.Data.DashValue or 300)
TextBox3.Font = Enum.Font.Jura
TextBox3.BackgroundColor3 = Color3.new(0, 0, 0)
v30(TextBox3)

local TextButton3 = Instance.new("TextButton", Frame3)

TextButton3.Size = UDim2.new(0, 155, 1, 0)
TextButton3.Position = UDim2.new(0, 55, 0, 0)
TextButton3.Text = DashEnabled and "Dash ON" or "Dash OFF"
TextButton3.Font = Enum.Font.Jura
TextButton3.BackgroundColor3 = Color3.new(0, 0, 0)
v30(TextButton3)
TextButton3.TextColor3 = DashEnabled and Color3.new(0, 1, 0.6) or Color3.new(1, 0.3, 0.3)
TextButton3.MouseButton1Click:Connect(function()
	DashEnabled = not DashEnabled
	t1.Data.DashEnabled = DashEnabled
	v13()
	TextButton3.Text = DashEnabled and "Dash ON" or "Dash OFF"
	TextButton3.TextColor3 = DashEnabled and Color3.new(0, 1, 0.6) or Color3.new(1, 0.3, 0.3)
end)
TextBox3.FocusLost:Connect(function()
	local dashValue = tonumber(TextBox3.Text) or 300

	t1.Data.DashValue = dashValue
	TextBox3.Text = tostring(dashValue)
	v13()
end)
RunService.RenderStepped:Connect(function()
	local o = LocalPlayer.Character

	if not o then
		return
	end

	local e = o:FindFirstChildOfClass("Humanoid")
	local F = o:FindFirstChild("HumanoidRootPart")

	if SpeedEnabled and e then
		e.WalkSpeed = tonumber(TextBox2.Text) or t1.Data.SpeedValue or 16
	end

	if DashEnabled then
		o:SetAttribute("DashLength", tonumber(TextBox3.Text) or t1.Data.DashValue or 300)
	end

	if _G.AntiStun and F and e and e.MoveDirection.Magnitude > 0 then
		local o = false

		if e.WalkSpeed == 0 then
			o = true
		else
			for l, l in ipairs(e:GetPlayingAnimationTracks()) do
				if l.IsPlaying and (l.Animation.AnimationId:find("attack") or l.Animation.AnimationId:find("skill")) then
					o = true

					break
				end
			end
		end

		if not o then
			F.CFrame = F.CFrame + e.MoveDirection.Unit * 1.7
		end
	end
end)
task.spawn(function()while task.wait(0.1)do local o=workspace:FindFirstChild("Map")and workspace.Map:FindFirstChild('W\97\116er\z \66\z \97se\45Pl\z\x61\u{6E}e');if o then o.Size=_G.WalkOnWater and Vector3.new(1000,112,1000)or Vector3.new(1000,10,1000);end;end;end)
task.spawn(function()
	while true do
		task.wait(0.1)

		if _G.UnbreakableSkills and LocalPlayer.Character then
			pcall(function()
				LocalPlayer.Character:SetAttribute("UnbreakableAll", true)
			end)
		end
	end
end)
task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoRaceV3 then
			ReplicatedStorage.Remotes.CommE:FireServer("ActivateAbility")
			task.wait(30)
		end

		if _G.AutoRaceV4 then
			local o = LocalPlayer:WaitForChild("PlayerGui")
			local O = o:FindFirstChild("Main")
			local o = O and O:FindFirstChild("RaceEnergy") and O.RaceEnergy:FindFirstChild("Fill")

			if o and o.Size.X.Scale >= 0.9 then
				local o = LocalPlayer:WaitForChild("Backpack")
				local O = LocalPlayer.Character
				local l = o:FindFirstChild("Awakening") or (O and O:FindFirstChild("Awakening"))

				if l then
					local o = l:FindFirstChild("RemoteFunction")

					if o then
						o:InvokeServer(true)
						task.wait(5)
					end
				end
			end
		end
	end
end)
print("CentuDox V3 Fully Loaded!")
