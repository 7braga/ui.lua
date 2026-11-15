if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game.GameId ~= 66654135 then
	game:GetService("Players").LocalPlayer:Kick("eter hub: This script is for Murder Mystery 2 only.")
	return
end

local tbl = {Print = print}
tbl.Started = os.clock()
tbl.Last = os.clock()
tbl.Done = 0
tbl.Total = 4
local ok, result = pcall(getrenv)

if ok and type(result) == "table" and type(result.print) == "function" then
	tbl.Print = result.print
end

function tbl.Show()
	local ok, result = pcall(identifyexecutor)
	local resultRef = result

	if not ok or type(resultRef) ~= "string" then
		resultRef = "Unknown"
	end

	local v1 = string.rep("=", 54)

	tbl.Print(table.concat({
		"",
		v1,
		"   eter hub  //  by zluu  //  Murder Mystery 2",
		"   Executor: " .. resultRef .. "   //   Player: " .. game:GetService("Players").LocalPlayer.Name,
		v1,
	}, "\n"))
end

function tbl.Step(arg1)
	local v1 = os.clock()
	tbl.Done = math.min(tbl.Done + 1, tbl.Total)
	local v2 = math.floor(tbl.Done / tbl.Total * 20 + 0.5)
	local Print = tbl.Print
	local format = string.format
	local v3 = string.rep("#", v2) .. string.rep(".", 20 - v2)
	local floor = math.floor
	local Done = tbl.Done

	Print(format(
		"[eter hub] [%s] %3d%%  %-24s +%dms",
		v3,
		floor(Done / tbl.Total * 100),
		arg1,
		math.floor((v1 - tbl.Last) * 1000)
	))

	tbl.Last = v1
end

function tbl.Ready()
	local v1 = string.rep("=", 54)
	tbl.Print(table.concat(
		{v1, string.format("   >> eter hub READY in %dms", math.floor((os.clock() - tbl.Started) * 1000)), v1},
		"\n"
	))
end

pcall(tbl.Show)
pcall(tbl.Step, "Core")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local tbl1 = {}

tbl1.Config = {
	TeamName = "eter hub",
	Slogan = "by zluu",
	LogoId = "rbxassetid://94398897297532",
	DiscordLink = "https://discord.gg/hTV5zPjjae",
	RequiredKey = "MUaRpInkee",
	KeyDuration = 86400,
	SplashDuration = 6,
	SaveFolder = "eter_hub_MM2",
	UpdateLog = {
		{
			"eter hub Release",
			"Custom Purple-White Adaptive UI (PC & Mobile)\n24h Per-Account Key System\nImproved Farming, Combat & Movement",
		},
	},
	LoadTimeout = 10,
	AlertTries = 20,
	AlertRetry = 0.5,
	JobFailLimit = 5,
	JobFailWindow = 10,
	StatusRefresh = 1,
	TickDelay = 0.5,
	RoleRefresh = 1,
	ShootStands = {
		Vector3.new(0, 0, 6),
		Vector3.new(0, 0, -6),
		Vector3.new(6, 0, 0),
		Vector3.new(-6, 0, 0),
		Vector3.new(0, 6, 3),
	},
	ShootAttempts = 3,
	ShootConfirm = 0.8,
	ShootSettle = 0.25,
	ShootReturn = 0.3,
	ShootCooldown = 1.2,
	StabCooldown = 0.9,
	BusyTimeout = 6,
	StabOffset = 2,
	KillAuraRange = 18,
	GunGrabHold = 0.35,
	FarmSpeed = 25,
	FarmSpeedMax = 28,
	FarmMurdererRadius = 30,
	FarmArrive = 1.5,
	FarmBrake = 20,
	FarmGroundLift = 4,
	FarmGroundReach = 400,
	FarmIdleWait = 0.3,
	FarmSettle = 0.15,
	FarmSkipTime = 4,
	FlingVelocityCap = 120,
	XRayTransparency = 0.6,
	DodgeRange = 22,
	DodgeCooldown = 2.5,
	VictimPriority = {Sheriff = 1, Hero = 1, Innocent = 2},
	FlingForce = 90000,
	FlingTime = 2.5,
	FlySpeed = 70,
	SpeedDefault = 16,
	JumpDefault = 50,
	LobbyName = "RegularLobby",
	Colors = {
		Murderer = Color3.fromHSV(0, 0.75, 1),
		Sheriff = Color3.fromHSV(0.6, 0.7, 1),
		Hero = Color3.fromHSV(0.14, 0.8, 1),
		Innocent = Color3.fromHSV(0.33, 0.6, 0.95),
		Gun = Color3.fromHSV(0.12, 0.9, 1),
		Coin = Color3.fromHSV(0.15, 0.6, 1),
	},
}

local Config = tbl1.Config

local tbl2 = {
	Alive = true,
	Conns = {},
	Roles = {},
	LastRoleFetch = 0,
	LastShoot = 0,
	LastStab = 0,
	ActionBusy = false,
	BusySince = 0,
	ShootBusy = false,
	LastDodge = 0,
	FarmBusy = false,
}

tbl2.FarmHome = nil
tbl2.FarmMover = nil
tbl2.Bag = {Current = 0, Max = 0}
tbl2.SkippedCoins = {}
tbl2.XRayMap = nil
tbl2.XRayParts = {}
tbl2.Skins = {}
tbl2.KillBusy = false
tbl2.NoclipConn = nil
tbl2.NoclipSaved = {}
tbl2.FlyConn = nil
tbl2.FlyVelocity = nil
tbl2.StickTarget = nil
tbl2.Hook = nil
local tbl3 = {Players = {}}
tbl3.Gun = nil
tbl2.Esp = tbl3
tbl2.LightingDefaults = nil
tbl2.Halted = {}

local tbl4 = {
	AutoGrabGun = false,
	AutoShoot = false,
	SilentAim = false,
	AutoKillAll = false,
	KillAura = false,
	KnifeAim = false,
	AutoDodge = false,
	Kaitun = false,
	AutoFarm = false,
	FarmSpeed = 25,
	ResetWhenFull = false,
	AntiFling = false,
	XRay = false,
	Aimbot = false,
	AimSmooth = 70,
}

tbl4.SkinSource = nil
tbl4.EspPlayers = false
tbl4.EspGun = false
tbl4.RoleNotify = false
tbl4.SpeedOn = false
tbl4.WalkSpeed = 24
tbl4.JumpOn = false
tbl4.JumpPower = 70
tbl4.InfJump = false
tbl4.Noclip = false
tbl4.Fly = false
tbl4.Fullbright = false
tbl4.AntiAfk = false
tbl4.TrollTarget = nil
tbl4.TeleportTarget = nil
tbl2.Opt = tbl4
tbl1.State = tbl2
local State = tbl1.State

for _, v1 in ipairs({
	"Util",
	"KeySystem",
	"Round",
	"Sheriff",
	"Murderer",
	"Troll",
	"Survive",
	"Kaitun",
	"Farm",
	"Aim",
	"Skin",
	"Teleport",
	"Movement",
	"Esp",
	"Visual",
	"Session",
	"Scheduler",
}) do
	tbl1[v1] = {}
end

function tbl1.Util.Try(arg1, ...)
	local ok, result = pcall(arg1, ...)

	if not ok then
		warn("[eter hub]", result)
	end

	return ok, result
end

function tbl1.Util.Alert(arg1)
	warn("[eter hub] " .. arg1)
	task.spawn(function()
		local StarterGui = game:GetService("StarterGui")
		for _ = 1, tonumber(Config.AlertTries) do
			if pcall(StarterGui.SetCore, StarterGui, "SendNotification", {Title = "eter hub", Text = arg1, Duration = 8}) then
				return
			end
			task.wait(Config.AlertRetry)
		end
	end)
end

function tbl1.Util.HttpGet(arg1)
	local ok, result = pcall(game.HttpGet, game, arg1)

	if ok and type(result) == "string" then
		return result
	end

	local v1 = type(request) == "function" and request or type(http_request) == "function" and http_request or type(syn) == "table" and syn.request or type(http) == "table" and http.request

	if type(v1) ~= "function" then
		return nil
	end

	local ok1, result1 = pcall(v1, {Url = arg1, Method = "GET"})

	if ok1 and type(result1) == "table" and tonumber(result1.StatusCode) == 200 then
		if type(result1.Body) == "string" then
			return result1.Body
		end
	end

	return nil
end

function tbl1.Util.Mount(arg1)
	local ok, result = pcall(gethui)

	if ok and typeof(result) == "Instance" and pcall(function()
		arg1.Parent = result
	end) then
		return
	end

	if pcall(function()
		arg1.Parent = game:GetService("CoreGui")
	end) then
		return
	end

	arg1.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", Config.LoadTimeout)
end

function tbl1.Util.CopyClipboard(arg1)
	local v1 = setclipboard or toclipboard or Clipboard and Clipboard.set

	if type(v1) == "function" then
		pcall(v1, arg1)
		return true
	end

	return false
end

function tbl1.KeySystem.GetFilePath()
	local str = tostring(LocalPlayer.UserId)
	return Config.SaveFolder .. "/key_" .. str .. ".json"
end

function tbl1.KeySystem.EnsureFolder()
	if type(isfolder) == "function" and type(makefolder) == "function" then
		pcall(function()
			if not isfolder(Config.SaveFolder) then
				makefolder(Config.SaveFolder)
			end
		end)
	end
end

function tbl1.KeySystem.LoadRecord()
	local str = tostring(LocalPlayer.UserId)

	if type(isfile) == "function" and type(readfile) == "function" then
		local v1 = tbl1.KeySystem.GetFilePath()

		local ok, result = pcall(function()
			if isfile(v1) then
				return readfile(v1)
			end
			return nil
		end)

		if ok and type(result) == "string" and #result > 0 then
			local ok1, result1 = pcall(HttpService.JSONDecode, HttpService, result)
			if ok1 and type(result1) == "table" then
				return result1
			end
		end
	end

	local v2 = getgenv and getgenv().EterHubKeyStore

	if type(v2) == "table" then
		if type(v2[str]) == "table" then
			return v2[str]
		end
	end

	return nil
end

function tbl1.KeySystem.SaveRecord(arg1)
	local str = tostring(LocalPlayer.UserId)
	local tbl = {UserId = str, Key = arg1, Timestamp = os.time()}
	tbl1.KeySystem.EnsureFolder()

	if type(writefile) == "function" then
		pcall(function()
			writefile(tbl1.KeySystem.GetFilePath(), HttpService:JSONEncode(tbl))
		end)
	end

	if getgenv then
		getgenv().EterHubKeyStore = getgenv().EterHubKeyStore or {}
		getgenv().EterHubKeyStore[str] = tbl
	end
end

function tbl1.KeySystem.ClearRecord()
	local str = tostring(LocalPlayer.UserId)

	if type(isfile) == "function" and type(delfile) == "function" then
		pcall(function()
			local v1 = tbl1.KeySystem.GetFilePath()
			if isfile(v1) then
				delfile(v1)
			end
		end)
	end

	if getgenv then
		if type(getgenv().EterHubKeyStore) == "table" then
			getgenv().EterHubKeyStore[str] = nil
		end
	end
end

function tbl1.KeySystem.RemainingSeconds()
	-- key system removido, siempre retorna 24h
	return Config.KeyDuration
end

function tbl1.KeySystem.IsValid()
	return true -- key system removido por zluu hub
end

function tbl1.Util.LoadLibrary()
	local tbl = {
		Toggles = {},
		Options = {},
		UnloadCallbacks = {},
		ShimmerGradients = {},
		Theme = {
			BgMain = Color3.fromRGB(32, 18, 52),
			BgSecondary = Color3.fromRGB(48, 28, 76),
			BgGroup = Color3.fromRGB(38, 22, 62),
			ButtonBg = Color3.fromRGB(145, 95, 225),
			Accent = Color3.fromRGB(170, 110, 255),
			AccentBright = Color3.fromRGB(220, 190, 255),
			TextPrimary = Color3.fromRGB(255, 255, 255),
			TextSecondary = Color3.fromRGB(220, 205, 240),
			Danger = Color3.fromRGB(255, 95, 120),
			Warning = Color3.fromRGB(255, 195, 90),
			Success = Color3.fromRGB(115, 245, 175),
			BgTransparency = 0.22,
			GroupTransparency = 0.28,
			ButtonTransparency = 0.48,
		},
		Icons = {
			cookie = "rbxassetid://6034509993",
			crosshair = "rbxassetid://6034837797",
			globe = "rbxassetid://6034287594",
			zap = "rbxassetid://6034684930",
			user = "rbxassetid://6034287516",
			eye = "rbxassetid://6031075931",
			["sliders-horizontal"] = "rbxassetid://6031280882",
			settings = "rbxassetid://6031280882",
			bell = "rbxassetid://6034304908",
		},
	}

	tbl.Compat = {
		Caps = {
			Touch = type(firetouchinterest) == "function",
			Namecall = type(hookmetamethod) == "function" or type(getrawmetatable) == "function",
			CheckCaller = type(checkcaller) == "function",
		},
		Has = function(arg1)
			for _, v1 in ipairs(arg1 or {}) do
				if not tbl.Compat.Caps[v1] then
					return false
				end
			end
			return true
		end,
		HookMeta = function(arg1, arg2, arg3)
			if type(hookmetamethod) == "function" then
				local v1 = hookmetamethod(arg1, arg2, function(...)
					return arg3(...)
				end)
				return v1, function()
					pcall(hookmetamethod, arg1, arg2, v1)
				end
			end

			if type(getrawmetatable) == "function" then
				local v2 = getrawmetatable(arg1)

				local v3 = setreadonly or make_writeable and function(arg1, arg2)
					if not arg2 then
						make_writeable(arg1)
					end
				end

				if v3 then
					pcall(v3, v2, false)
				end

				local v4 = v2[arg2]
				v2[arg2] = arg3

				if v3 then
					pcall(v3, v2, true)
				end

				return v4, function()
					if v3 then
						pcall(v3, v2, false)
					end

					v2[arg2] = v4

					if v3 then
						pcall(v3, v2, true)
					end
				end
			end

			return nil, function() end
		end,
		NeedCap = function(arg1, arg2)
			if not tbl.Compat.Has(arg2) then
				tbl.Compat.Block(arg1, "Unsupported by your executor")
			end
		end,
		Block = function(arg1, arg2)
			local v1 = tbl.Options[arg1] or tbl.Toggles[arg1]
			if v1 and v1.SetLocked then
				v1:SetLocked(true, arg2)
			end
		end,
	}

	function tbl.T(_, arg2, _)
		return arg2
	end

	function tbl:AddShimmerBorder(parent, arg3, arg4)
		local uIStroke = Instance.new("UIStroke")
		uIStroke.Thickness = arg3 or 1.6
		uIStroke.Transparency = arg4 or 0.1
		uIStroke.Color = Color3.fromRGB(255, 255, 255)
		uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uIStroke.Parent = parent
		local uIGradient = Instance.new("UIGradient")

		uIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 90, 255)),
			ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.7, Color3.fromRGB(195, 135, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 90, 255)),
		})

		uIGradient.Rotation = 0
		uIGradient.Parent = uIStroke
		table.insert(self.ShimmerGradients, uIGradient)
		return uIStroke, uIGradient
	end

	function tbl:AddPurpleWhiteGradient(parent, arg3)
		local uIGradient = Instance.new("UIGradient")

		uIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.55, Color3.fromRGB(225, 195, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(185, 130, 255)),
		})

		uIGradient.Rotation = arg3 or 35
		uIGradient.Parent = parent
		return uIGradient
	end

	function tbl:Corner(parent, arg3)
		local uICorner = Instance.new("UICorner")
		uICorner.CornerRadius = UDim.new(0, arg3 or 10)
		uICorner.Parent = parent
		return uICorner
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "EterHub_" .. HttpService:GenerateGUID(false):sub(1, 8)
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder = 999990

	pcall(function()
		screenGui.IgnoreGuiInset = true
	end)

	tbl1.Util.Mount(screenGui)
	tbl.ScreenGui = screenGui
	local uIScale = Instance.new("UIScale")
	uIScale.Parent = screenGui

	local function func()
		local CurrentCamera = workspace.CurrentCamera

		if not CurrentCamera then
			return
		end

		local ViewportSize = CurrentCamera.ViewportSize
		local v1 = math.min(ViewportSize.X, ViewportSize.Y)

		if v1 < 500 then
			uIScale.Scale = math.clamp(v1 / 520, 0.62, 0.92)
		elseif ViewportSize.X < 900 then
			uIScale.Scale = math.clamp(ViewportSize.X / 950, 0.72, 0.95)
		else
			uIScale.Scale = 1
		end
	end

	func()

	if workspace.CurrentCamera then
		tbl1.Util.Connect(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), func)
	end

	local num = 0

	tbl1.Util.Connect(RunService.RenderStepped, function(arg1)
		num = (num + arg1 * 65) % 360
		for i = #tbl.ShimmerGradients, 1, -1 do
			local v1 = tbl.ShimmerGradients[i]
			if v1 and v1.Parent then
				v1.Rotation = num
			else
				table.remove(tbl.ShimmerGradients, i)
			end
		end
	end)

	local frame = Instance.new("Frame")
	frame.Name = "Notifications"
	frame.AnchorPoint = Vector2.new(1, 1)
	frame.Position = UDim2.new(1, -18, 1, -18)
	frame.Size = UDim2.new(0, 300, 1, -36)
	frame.BackgroundTransparency = 1
	frame.ZIndex = 5000
	frame.Parent = screenGui
	local uIListLayout = Instance.new("UIListLayout")
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	uIListLayout.Padding = UDim.new(0, 8)
	uIListLayout.Parent = frame

	function tbl:Notify(arg2, arg3, arg4, arg5)
		local v1 = arg2
		local v2 = arg3

		if not arg3 then
			v2 = tostring(arg2)
			v1 = "eter hub"
		end

		local v3 = arg4 or 4
		local Accent = self.Theme.Accent
		local frame1, ShimmerBorder, frame2, textLabel, v4, textLabel1, v5, v6

		if arg5 == "Success" then
			Accent = self.Theme.Success
		elseif arg5 == "Warning" then
			Accent = self.Theme.Warning
		else
			if arg5 ~= "Danger" then
				if arg5 ~= "Error" then
					frame1 = Instance.new("Frame")
					frame1.Size = UDim2.new(1, 0, 0, 64)
					frame1.BackgroundColor3 = self.Theme.BgMain
					frame1.BackgroundTransparency = 1
					frame1.ClipsDescendants = true
					frame1.Parent = frame
					self:Corner(frame1, 10)
					self:AddPurpleWhiteGradient(frame1, 25)
					ShimmerBorder = self:AddShimmerBorder(frame1, 1.5, 1)
					frame2 = Instance.new("Frame")
					frame2.Size = UDim2.new(0, 4, 1, -12)
					frame2.Position = UDim2.new(0, 6, 0, 6)
					frame2.BackgroundColor3 = Accent
					frame2.BackgroundTransparency = 1
					frame2.Parent = frame1
					self:Corner(frame2, 4)
					textLabel = Instance.new("TextLabel")
					textLabel.Size = UDim2.new(1, -24, 0, 20)
					textLabel.Position = UDim2.new(0, 18, 0, 8)
					textLabel.BackgroundTransparency = 1
					v4 = Enum
					textLabel.Font = v4.Font.GothamBold
					textLabel.TextSize = 14
					textLabel.TextColor3 = self.Theme.TextPrimary
					textLabel.TextTransparency = 1
					textLabel.TextXAlignment = v4.TextXAlignment.Left
					textLabel.Text = tostring(v1)
					textLabel.Parent = frame1
					textLabel1 = Instance.new("TextLabel")
					textLabel1.Size = UDim2.new(1, -24, 0, 30)
					textLabel1.Position = UDim2.new(0, 18, 0, 26)
					textLabel1.BackgroundTransparency = 1
					v5 = Enum
					textLabel1.Font = v5.Font.Gotham
					textLabel1.TextSize = 12
					textLabel1.TextColor3 = self.Theme.TextSecondary
					textLabel1.TextTransparency = 1
					textLabel1.TextWrapped = true
					textLabel1.TextXAlignment = v5.TextXAlignment.Left
					textLabel1.TextYAlignment = v5.TextYAlignment.Top
					textLabel1.Text = tostring(v2)
					textLabel1.Parent = frame1
					v6 = Enum

					TweenService:Create(
						frame1,
						TweenInfo.new(0.3, v6.EasingStyle.Quint, v6.EasingDirection.Out),
						{BackgroundTransparency = self.Theme.BgTransparency}
					):Play()

					TweenService:Create(ShimmerBorder, TweenInfo.new(0.3), {Transparency = 0.05}):Play()
					TweenService:Create(frame2, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
					TweenService:Create(textLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
					TweenService:Create(textLabel1, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

					task.delay(v3, function()
						if not frame1.Parent then
							return
						end

						TweenService:Create(
							frame1,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
							{BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0)}
						):Play()

						TweenService:Create(ShimmerBorder, TweenInfo.new(0.25), {Transparency = 1}):Play()
						TweenService:Create(textLabel, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
						TweenService:Create(textLabel1, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
						task.wait(0.32)

						if frame1.Parent then
							frame1:Destroy()
						end
					end)

					return
				end
			end
			Accent = self.Theme.Danger
		end

		frame1 = Instance.new("Frame")
		frame1.Size = UDim2.new(1, 0, 0, 64)
		frame1.BackgroundColor3 = self.Theme.BgMain
		frame1.BackgroundTransparency = 1
		frame1.ClipsDescendants = true
		frame1.Parent = frame
		self:Corner(frame1, 10)
		self:AddPurpleWhiteGradient(frame1, 25)
		ShimmerBorder = self:AddShimmerBorder(frame1, 1.5, 1)
		frame2 = Instance.new("Frame")
		frame2.Size = UDim2.new(0, 4, 1, -12)
		frame2.Position = UDim2.new(0, 6, 0, 6)
		frame2.BackgroundColor3 = Accent
		frame2.BackgroundTransparency = 1
		frame2.Parent = frame1
		self:Corner(frame2, 4)
		textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, -24, 0, 20)
		textLabel.Position = UDim2.new(0, 18, 0, 8)
		textLabel.BackgroundTransparency = 1
		v4 = Enum
		textLabel.Font = v4.Font.GothamBold
		textLabel.TextSize = 14
		textLabel.TextColor3 = self.Theme.TextPrimary
		textLabel.TextTransparency = 1
		textLabel.TextXAlignment = v4.TextXAlignment.Left
		textLabel.Text = tostring(v1)
		textLabel.Parent = frame1
		textLabel1 = Instance.new("TextLabel")
		textLabel1.Size = UDim2.new(1, -24, 0, 30)
		textLabel1.Position = UDim2.new(0, 18, 0, 26)
		textLabel1.BackgroundTransparency = 1
		v5 = Enum
		textLabel1.Font = v5.Font.Gotham
		textLabel1.TextSize = 12
		textLabel1.TextColor3 = self.Theme.TextSecondary
		textLabel1.TextTransparency = 1
		textLabel1.TextWrapped = true
		textLabel1.TextXAlignment = v5.TextXAlignment.Left
		textLabel1.TextYAlignment = v5.TextYAlignment.Top
		textLabel1.Text = tostring(v2)
		textLabel1.Parent = frame1
		v6 = Enum

		TweenService:Create(
			frame1,
			TweenInfo.new(0.3, v6.EasingStyle.Quint, v6.EasingDirection.Out),
			{BackgroundTransparency = self.Theme.BgTransparency}
		):Play()

		TweenService:Create(ShimmerBorder, TweenInfo.new(0.3), {Transparency = 0.05}):Play()
		TweenService:Create(frame2, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
		TweenService:Create(textLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
		TweenService:Create(textLabel1, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

		task.delay(v3, function()
			if not frame1.Parent then
				return
			end

			TweenService:Create(
				frame1,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
				{BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0)}
			):Play()

			TweenService:Create(ShimmerBorder, TweenInfo.new(0.25), {Transparency = 1}):Play()
			TweenService:Create(textLabel, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
			TweenService:Create(textLabel1, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
			task.wait(0.32)

			if frame1.Parent then
				frame1:Destroy()
			end
		end)
	end

	function tbl:MakeDraggable(arg2, arg3)
		local flag = false
		local v1
		local Position
		local Position1

		arg2.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				flag = true
				Position = input.Position
				Position1 = arg3.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						flag = false
					end
				end)
			end
		end)

		arg2.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				v1 = input
			end
		end)

		tbl1.Util.Connect(UserInputService.InputChanged, function(arg1)
			if arg1 == v1 and flag then
				local v2 = arg1.Position - Position
				local v3 = uIScale.Scale > 0 and uIScale.Scale or 1

				arg3.Position = UDim2.new(
					Position1.X.Scale,
					Position1.X.Offset + v2.X / v3,
					Position1.Y.Scale,
					Position1.Y.Offset + v2.Y / v3
				)
			end
		end)
	end

	function tbl:ShowKeyVerification(arg2)
		if tbl1.KeySystem.IsValid() then
			arg2()
			return
		end

		local frame = Instance.new("Frame")
		frame.Name = "KeyVerification"
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.BackgroundColor3 = Color3.fromRGB(12, 6, 22)
		frame.BackgroundTransparency = 1
		frame.ZIndex = 3000
		frame.Parent = screenGui
		local frame1 = Instance.new("Frame")
		frame1.Name = "KeyCard"
		frame1.AnchorPoint = Vector2.new(0.5, 0.5)
		frame1.Position = UDim2.new(0.5, 0, 0.5, 0)
		frame1.Size = UDim2.new(0, 440, 0, 310)
		frame1.BackgroundColor3 = self.Theme.BgMain
		frame1.BackgroundTransparency = 1
		frame1.Parent = frame
		self:Corner(frame1, 16)
		self:AddPurpleWhiteGradient(frame1, 35)
		local ShimmerBorder = self:AddShimmerBorder(frame1, 2.2, 1)
		local uIScale = Instance.new("UIScale")
		uIScale.Scale = 0.82
		uIScale.Parent = frame1
		local frame2 = Instance.new("Frame")
		frame2.Size = UDim2.new(0, 48, 0, 48)
		frame2.Position = UDim2.new(0, 22, 0, 18)
		frame2.BackgroundColor3 = Color3.fromRGB(245, 240, 255)
		frame2.BackgroundTransparency = 1
		frame2.Parent = frame1
		self:Corner(frame2, 12)
		local ShimmerBorder1 = self:AddShimmerBorder(frame2, 1.4, 1)
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		imageLabel.Size = UDim2.new(0, 38, 0, 38)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = Config.LogoId
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.ImageTransparency = 1
		imageLabel.Parent = frame2
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, -90, 0, 26)
		textLabel.Position = UDim2.new(0, 82, 0, 19)
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 22
		textLabel.TextColor3 = self.Theme.TextPrimary
		textLabel.TextTransparency = 1
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Text = "eter hub  •  Key Verification"
		textLabel.Parent = frame1
		local textLabel1 = Instance.new("TextLabel")
		textLabel1.Size = UDim2.new(1, -90, 0, 18)
		textLabel1.Position = UDim2.new(0, 82, 0, 44)
		textLabel1.BackgroundTransparency = 1
		textLabel1.Font = Enum.Font.Gotham
		textLabel1.TextSize = 13
		textLabel1.TextColor3 = self.Theme.TextSecondary
		textLabel1.TextTransparency = 1
		textLabel1.TextXAlignment = Enum.TextXAlignment.Left
		textLabel1.Text = "Account: " .. LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")"
		textLabel1.Parent = frame1
		local frame3 = Instance.new("Frame")
		frame3.Size = UDim2.new(1, -44, 0, 50)
		frame3.Position = UDim2.new(0, 22, 0, 76)
		frame3.BackgroundColor3 = Color3.fromRGB(65, 35, 105)
		frame3.BackgroundTransparency = 1
		frame3.Parent = frame1
		self:Corner(frame3, 10)
		local ShimmerBorder2 = self:AddShimmerBorder(frame3, 1.2, 1)
		local textLabel2 = Instance.new("TextLabel")
		textLabel2.Size = UDim2.new(1, -20, 1, -8)
		textLabel2.Position = UDim2.new(0, 10, 0, 4)
		textLabel2.BackgroundTransparency = 1
		textLabel2.Font = Enum.Font.GothamMedium
		textLabel2.TextSize = 12
		textLabel2.TextColor3 = Color3.fromRGB(245, 225, 255)
		textLabel2.TextTransparency = 1
		textLabel2.TextWrapped = true
		textLabel2.Text = "⚠ Notice: Your key resets every 24 hours and must be entered separately on each Roblox account."
		textLabel2.Parent = frame3
		local frame4 = Instance.new("Frame")
		frame4.Size = UDim2.new(1, -44, 0, 46)
		frame4.Position = UDim2.new(0, 22, 0, 140)
		frame4.BackgroundColor3 = Color3.fromRGB(55, 30, 90)
		frame4.BackgroundTransparency = 1
		frame4.Parent = frame1
		self:Corner(frame4, 10)
		local ShimmerBorder3 = self:AddShimmerBorder(frame4, 1.5, 1)
		local textBox = Instance.new("TextBox")
		textBox.Size = UDim2.new(1, -24, 1, 0)
		textBox.Position = UDim2.new(0, 12, 0, 0)
		textBox.BackgroundTransparency = 1
		textBox.ClearTextOnFocus = false
		textBox.Font = Enum.Font.GothamMedium
		textBox.TextSize = 15
		textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		textBox.PlaceholderColor3 = Color3.fromRGB(205, 185, 230)
		textBox.PlaceholderText = "Enter your key here (case & space sensitive)..."
		textBox.Text = ""
		textBox.TextTransparency = 1
		textBox.Parent = frame4
		local textLabel3 = Instance.new("TextLabel")
		textLabel3.Size = UDim2.new(1, -44, 0, 20)
		textLabel3.Position = UDim2.new(0, 22, 0, 194)
		textLabel3.BackgroundTransparency = 1
		textLabel3.Font = Enum.Font.GothamMedium
		textLabel3.TextSize = 13
		textLabel3.TextColor3 = self.Theme.AccentBright
		textLabel3.Text = "Please enter your key or click Get Key below."
		textLabel3.TextTransparency = 1
		textLabel3.Parent = frame1
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(0.5, -28, 0, 46)
		textButton.Position = UDim2.new(0, 22, 0, 226)
		textButton.BackgroundColor3 = self.Theme.ButtonBg
		textButton.BackgroundTransparency = 1
		textButton.AutoButtonColor = false
		textButton.Font = Enum.Font.GothamBold
		textButton.TextSize = 15
		textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		textButton.Text = "Verify"
		textButton.TextTransparency = 1
		textButton.Parent = frame1
		self:Corner(textButton, 10)
		local ShimmerBorder4 = self:AddShimmerBorder(textButton, 1.6, 1)
		local textButton1 = Instance.new("TextButton")
		textButton1.Size = UDim2.new(0.5, -28, 0, 46)
		textButton1.Position = UDim2.new(0.5, 6, 0, 226)
		textButton1.BackgroundColor3 = self.Theme.ButtonBg
		textButton1.BackgroundTransparency = 1
		textButton1.AutoButtonColor = false
		textButton1.Font = Enum.Font.GothamBold
		textButton1.TextSize = 15
		textButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
		textButton1.Text = "Get Key"
		textButton1.TextTransparency = 1
		textButton1.Parent = frame1
		self:Corner(textButton1, 10)
		local ShimmerBorder5 = self:AddShimmerBorder(textButton1, 1.6, 1)
		self:MakeDraggable(frame1, frame1)

		for _, v1 in ipairs({textButton, textButton1}) do
			v1.MouseEnter:Connect(function()
				TweenService:Create(v1, TweenInfo.new(0.2), {BackgroundTransparency = self.Theme.ButtonTransparency - 0.12}):Play()
			end)
			v1.MouseLeave:Connect(function()
				TweenService:Create(v1, TweenInfo.new(0.2), {BackgroundTransparency = self.Theme.ButtonTransparency}):Play()
			end)
		end

		TweenService:Create(
			frame,
			TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0.45}
		):Play()

		TweenService:Create(uIScale, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

		TweenService:Create(
			frame1,
			TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
			{BackgroundTransparency = self.Theme.BgTransparency}
		):Play()

		TweenService:Create(frame2, TweenInfo.new(0.4), {BackgroundTransparency = 0.12}):Play()
		TweenService:Create(imageLabel, TweenInfo.new(0.4), {ImageTransparency = 0}):Play()
		TweenService:Create(textLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		TweenService:Create(textLabel1, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		TweenService:Create(frame3, TweenInfo.new(0.4), {BackgroundTransparency = 0.38}):Play()
		TweenService:Create(textLabel2, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		TweenService:Create(frame4, TweenInfo.new(0.4), {BackgroundTransparency = 0.42}):Play()
		TweenService:Create(textBox, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		TweenService:Create(textLabel3, TweenInfo.new(0.4), {TextTransparency = 0}):Play()

		TweenService:Create(
			textButton,
			TweenInfo.new(0.4),
			{BackgroundTransparency = self.Theme.ButtonTransparency, TextTransparency = 0}
		):Play()

		TweenService:Create(
			textButton1,
			TweenInfo.new(0.4),
			{BackgroundTransparency = self.Theme.ButtonTransparency, TextTransparency = 0}
		):Play()

		for _, v2 in ipairs({ShimmerBorder, ShimmerBorder1, ShimmerBorder2, ShimmerBorder3, ShimmerBorder4, ShimmerBorder5}) do
			TweenService:Create(v2, TweenInfo.new(0.4), {Transparency = 0.05}):Play()
		end

		textButton1.Activated:Connect(function()
			tbl1.Util.CopyClipboard(Config.DiscordLink)
			textLabel3.TextColor3 = self.Theme.Success
			textLabel3.Text = "Copied key link: " .. Config.DiscordLink
			self:Notify("eter hub", "Key link copied to clipboard: " .. Config.DiscordLink, 5, "Success")
		end)

		local flag = false

		textButton.Activated:Connect(function()
			if flag then
				return
			end

			local Text = textBox.Text

			if Text == Config.RequiredKey then
				flag = true
				tbl1.KeySystem.SaveRecord(Text)
				textLabel3.TextColor3 = self.Theme.Success
				textLabel3.Text = "Key verified! Loading eter hub..."
				self:Notify("eter hub", "Key verified! Active for 24 hours on this account.", 4, "Success")
				TweenService:Create(uIScale, TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0.82}):Play()

				TweenService:Create(
					frame1,
					TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					{BackgroundTransparency = 1}
				):Play()

				TweenService:Create(frame, TweenInfo.new(0.38), {BackgroundTransparency = 1}):Play()
				TweenService:Create(frame2, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
				TweenService:Create(imageLabel, TweenInfo.new(0.25), {ImageTransparency = 1}):Play()
				TweenService:Create(textLabel, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
				TweenService:Create(textLabel1, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
				TweenService:Create(frame3, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
				TweenService:Create(textLabel2, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
				TweenService:Create(frame4, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
				TweenService:Create(textBox, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
				TweenService:Create(textLabel3, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
				TweenService:Create(textButton, TweenInfo.new(0.25), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
				TweenService:Create(textButton1, TweenInfo.new(0.25), {BackgroundTransparency = 1, TextTransparency = 1}):Play()

				for _, v1 in ipairs({ShimmerBorder, ShimmerBorder1, ShimmerBorder2, ShimmerBorder3, ShimmerBorder4, ShimmerBorder5}) do
					TweenService:Create(v1, TweenInfo.new(0.25), {Transparency = 1}):Play()
				end

				task.wait(0.42)
				frame:Destroy()
				arg2()
			else
				textLabel3.TextColor3 = self.Theme.Danger
				textLabel3.Text = "Invalid key! Check uppercase/lowercase letters and spaces."

				self:Notify(
					"eter hub",
					"Invalid key! Make sure there are no extra spaces and case matches.",
					4,
					"Danger"
				)
			end
		end)
	end

	function tbl:PlaySplashScreen(arg2)
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "EterHubSplash"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 2147483647
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		pcall(function()
			screenGui.ScreenInsets = Enum.ScreenInsets.None
		end)

		tbl1.Util.Mount(screenGui)
		local frame = Instance.new("Frame")
		frame.Name = "WhiteCover"
		frame.Position = UDim2.new(0, 0, 0, -150)
		frame.Size = UDim2.new(1, 0, 1, 300)
		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.ZIndex = 10000
		frame.Parent = screenGui
		local frame1 = Instance.new("Frame")
		frame1.AnchorPoint = Vector2.new(0.5, 0.5)
		frame1.Position = UDim2.new(0.5, 0, 0.5, 0)
		frame1.Size = UDim2.new(0, 360, 0, 340)
		frame1.BackgroundTransparency = 1
		frame1.ZIndex = 10002
		frame1.Parent = screenGui
		local uIScale = Instance.new("UIScale")
		uIScale.Scale = 0.88
		uIScale.Parent = frame1
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = "EterHubLogo"
		imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel.Position = UDim2.new(0.5, 0, 0.36, 0)
		imageLabel.Size = UDim2.new(0, 195, 0, 195)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = Config.LogoId
		imageLabel.ImageTransparency = 1
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.ZIndex = 10003
		imageLabel.Parent = frame1
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = "EterHubTitle"
		textLabel.AnchorPoint = Vector2.new(0.5, 0)
		textLabel.Position = UDim2.new(0.5, 0, 0.69, 0)
		textLabel.Size = UDim2.new(1, 0, 0, 52)
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.GothamBlack
		textLabel.TextSize = 48
		textLabel.TextColor3 = Color3.fromRGB(35, 14, 65)
		textLabel.TextTransparency = 1
		textLabel.Text = "eter hub."
		textLabel.ZIndex = 10003
		textLabel.Parent = frame1
		local textLabel1 = Instance.new("TextLabel")
		textLabel1.Name = "EterHubSubtitle"
		textLabel1.AnchorPoint = Vector2.new(0.5, 0)
		textLabel1.Position = UDim2.new(0.5, 0, 0.84, 0)
		textLabel1.Size = UDim2.new(1, 0, 0, 32)
		textLabel1.BackgroundTransparency = 1
		textLabel1.Font = Enum.Font.GothamBold
		textLabel1.TextSize = 26
		textLabel1.TextColor3 = Color3.fromRGB(125, 72, 195)
		textLabel1.TextTransparency = 1
		textLabel1.Text = "by zluu"
		textLabel1.ZIndex = 10003
		textLabel1.Parent = frame1
		local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 0}):Play()
		TweenService:Create(uIScale, tweenInfo, {Scale = 1}):Play()
		TweenService:Create(imageLabel, tweenInfo, {ImageTransparency = 0}):Play()
		TweenService:Create(textLabel, tweenInfo, {TextTransparency = 0}):Play()
		TweenService:Create(textLabel1, tweenInfo, {TextTransparency = 0}):Play()
		task.wait(4.8)
		local tweenInfo1 = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
		TweenService:Create(frame, tweenInfo1, {BackgroundTransparency = 1}):Play()
		TweenService:Create(uIScale, tweenInfo1, {Scale = 1.06}):Play()
		TweenService:Create(imageLabel, tweenInfo1, {ImageTransparency = 1}):Play()
		TweenService:Create(textLabel, tweenInfo1, {TextTransparency = 1}):Play()
		TweenService:Create(textLabel1, tweenInfo1, {TextTransparency = 1}):Play()
		task.wait(1.22)
		screenGui:Destroy()

		if arg2 then
			arg2()
		end
	end

	function tbl:CreateWindow(arg2)
		local v1 = arg2 or {}
		local v2 = v1.MenuKey or Enum.KeyCode.LeftControl
		local tbl2 = {Tabs = {}}
		tbl2.ActiveTab = nil
		tbl2.IsOpen = true
		self.Window = tbl2
		local frame = Instance.new("Frame")
		frame.Name = "EterHubMainWindow"
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		frame.Size = UDim2.new(0, 740, 0, 470)
		frame.BackgroundColor3 = self.Theme.BgMain
		frame.BackgroundTransparency = 1
		frame.Visible = false
		frame.Parent = screenGui
		self:Corner(frame, 16)
		self:AddPurpleWhiteGradient(frame, 35)
		local ShimmerBorder = self:AddShimmerBorder(frame, 2.2, 1)
		local uIScale = Instance.new("UIScale")
		uIScale.Scale = 0.85
		uIScale.Parent = frame
		local frame1 = Instance.new("Frame")
		frame1.Name = "TopBar"
		frame1.Size = UDim2.new(1, -24, 0, 54)
		frame1.Position = UDim2.new(0, 12, 0, 10)
		frame1.BackgroundColor3 = self.Theme.BgSecondary
		frame1.BackgroundTransparency = self.Theme.GroupTransparency
		frame1.Parent = frame
		self:Corner(frame1, 12)
		self:AddShimmerBorder(frame1, 1.3, 0.15)
		self:MakeDraggable(frame1, frame)
		local frame2 = Instance.new("Frame")
		frame2.Size = UDim2.new(0, 38, 0, 38)
		frame2.Position = UDim2.new(0, 10, 0.5, -19)
		frame2.BackgroundColor3 = Color3.fromRGB(245, 240, 255)
		frame2.BackgroundTransparency = 0.12
		frame2.Parent = frame1
		self:Corner(frame2, 10)
		self:AddShimmerBorder(frame2, 1.2, 0.15)
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		imageLabel.Size = UDim2.new(0, 30, 0, 30)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = Config.LogoId
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.Parent = frame2
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(0, 280, 0, 22)
		textLabel.Position = UDim2.new(0, 58, 0, 7)
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.GothamBlack
		textLabel.TextSize = 18
		textLabel.TextColor3 = self.Theme.TextPrimary
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Text = v1.Title or "eter hub."
		textLabel.Parent = frame1
		local textLabel1 = Instance.new("TextLabel")
		textLabel1.Size = UDim2.new(0, 320, 0, 16)
		textLabel1.Position = UDim2.new(0, 58, 0, 29)
		textLabel1.BackgroundTransparency = 1
		textLabel1.Font = Enum.Font.GothamMedium
		textLabel1.TextSize = 12
		textLabel1.TextColor3 = self.Theme.TextSecondary
		textLabel1.TextXAlignment = Enum.TextXAlignment.Left
		textLabel1.Text = v1.SubTitle or "Murder Mystery 2  •  zluu hub"
		textLabel1.Parent = frame1
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(0, 80, 0, 32)
		textButton.Position = UDim2.new(1, -90, 0.5, -16)
		textButton.BackgroundColor3 = self.Theme.ButtonBg
		textButton.BackgroundTransparency = self.Theme.ButtonTransparency
		textButton.AutoButtonColor = false
		textButton.Font = Enum.Font.GothamBold
		textButton.TextSize = 13
		textButton.TextColor3 = self.Theme.TextPrimary
		textButton.Text = "Hide"
		textButton.Parent = frame1
		self:Corner(textButton, 8)
		self:AddShimmerBorder(textButton, 1.2, 0.1)
		local scrollingFrame = Instance.new("ScrollingFrame")
		scrollingFrame.Name = "Sidebar"
		scrollingFrame.Size = UDim2.new(0, 175, 1, -84)
		scrollingFrame.Position = UDim2.new(0, 12, 0, 72)
		scrollingFrame.BackgroundColor3 = self.Theme.BgSecondary
		scrollingFrame.BackgroundTransparency = self.Theme.GroupTransparency
		scrollingFrame.BorderSizePixel = 0
		scrollingFrame.ScrollBarThickness = 2
		scrollingFrame.ScrollBarImageColor3 = self.Theme.AccentBright
		scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		scrollingFrame.Parent = frame
		self:Corner(scrollingFrame, 12)
		self:AddShimmerBorder(scrollingFrame, 1.3, 0.15)
		local uIPadding = Instance.new("UIPadding")
		uIPadding.PaddingTop = UDim.new(0, 10)
		uIPadding.PaddingBottom = UDim.new(0, 10)
		uIPadding.PaddingLeft = UDim.new(0, 8)
		uIPadding.PaddingRight = UDim.new(0, 8)
		uIPadding.Parent = scrollingFrame
		local uIListLayout = Instance.new("UIListLayout")
		uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout.Padding = UDim.new(0, 6)
		uIListLayout.Parent = scrollingFrame
		local frame3 = Instance.new("Frame")
		frame3.Name = "Pages"
		frame3.Size = UDim2.new(1, -207, 1, -84)
		frame3.Position = UDim2.new(0, 195, 0, 72)
		frame3.BackgroundTransparency = 1
		frame3.Parent = frame
		local textButton1 = Instance.new("TextButton")
		textButton1.Name = "EterHubFloatingToggle"
		textButton1.Size = UDim2.new(0, 52, 0, 52)
		textButton1.Position = UDim2.new(0, 20, 0.5, -26)
		textButton1.BackgroundColor3 = Color3.fromRGB(245, 240, 255)
		textButton1.BackgroundTransparency = 0.12
		textButton1.Text = ""
		textButton1.AutoButtonColor = false
		textButton1.Visible = false
		textButton1.ZIndex = 4500
		textButton1.Parent = screenGui
		self:Corner(textButton1, 14)
		self:AddShimmerBorder(textButton1, 2, 0.05)
		self:MakeDraggable(textButton1, textButton1)
		local imageLabel1 = Instance.new("ImageLabel")
		imageLabel1.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel1.Position = UDim2.new(0.5, 0, 0.5, 0)
		imageLabel1.Size = UDim2.new(0, 40, 0, 40)
		imageLabel1.BackgroundTransparency = 1
		imageLabel1.Image = Config.LogoId
		imageLabel1.ScaleType = Enum.ScaleType.Fit
		imageLabel1.ZIndex = 4501
		imageLabel1.Parent = textButton1
		local flag = false

		function tbl2:SetOpen(isOpen)
			if flag then
				return
			end

			flag = true
			self.IsOpen = isOpen

			if isOpen then
				frame.Visible = true
				TweenService:Create(uIScale, TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

				TweenService:Create(
					frame,
					TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
					{BackgroundTransparency = tbl.Theme.BgTransparency}
				):Play()

				TweenService:Create(ShimmerBorder, TweenInfo.new(0.32), {Transparency = 0.05}):Play()
				task.wait(0.38)
			else
				TweenService:Create(uIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0.85}):Play()

				TweenService:Create(
					frame,
					TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					{BackgroundTransparency = 1}
				):Play()

				TweenService:Create(ShimmerBorder, TweenInfo.new(0.25), {Transparency = 1}):Play()
				task.wait(0.3)
				frame.Visible = false
			end

			flag = false
		end

		textButton.Activated:Connect(function()
			tbl2:SetOpen(false)
		end)

		textButton1.Activated:Connect(function()
			tbl2:SetOpen(not tbl2.IsOpen)
		end)

		tbl1.Util.Connect(UserInputService.InputBegan, function(arg1, arg2)
			if not arg2 and arg1.KeyCode == v2 and frame.Parent then
				tbl2:SetOpen(not tbl2.IsOpen)
			end
		end)

		local num = 0

		function tbl2:AddTabSection(arg2)
			local textLabel = Instance.new("TextLabel")
			num = num + 1
			textLabel.LayoutOrder = num
			textLabel.Size = UDim2.new(1, 0, 0, 20)
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.GothamBold
			textLabel.TextSize = 11
			textLabel.TextColor3 = tbl.Theme.AccentBright
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			textLabel.Text = "  " .. string.upper(tostring(arg2))
			textLabel.Parent = scrollingFrame
		end

		function tbl2:AddTab(arg2, arg3, _)
			local tbl3 = {}
			local textButton = Instance.new("TextButton")
			num = num + 1
			textButton.LayoutOrder = num
			textButton.Size = UDim2.new(1, 0, 0, 38)
			textButton.BackgroundColor3 = tbl.Theme.ButtonBg
			textButton.BackgroundTransparency = tbl.Theme.ButtonTransparency
			textButton.AutoButtonColor = false
			textButton.Text = ""
			textButton.Parent = scrollingFrame
			tbl:Corner(textButton, 9)
			local ShimmerBorder = tbl:AddShimmerBorder(textButton, 1.3, 0.35)
			local imageLabel = Instance.new("ImageLabel")
			imageLabel.Size = UDim2.new(0, 18, 0, 18)
			imageLabel.Position = UDim2.new(0, 10, 0.5, -9)
			imageLabel.BackgroundTransparency = 1
			imageLabel.Image = tbl.Icons[arg3] or Config.LogoId
			imageLabel.ScaleType = Enum.ScaleType.Fit
			imageLabel.ImageColor3 = tbl.Theme.TextPrimary
			imageLabel.Parent = textButton
			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, -36, 1, 0)
			textLabel.Position = UDim2.new(0, 34, 0, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.GothamBold
			textLabel.TextSize = 13
			textLabel.TextColor3 = tbl.Theme.TextSecondary
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			textLabel.Text = tostring(arg2)
			textLabel.Parent = textButton
			local scrollingFrame1 = Instance.new("ScrollingFrame")
			scrollingFrame1.Name = tostring(arg2) .. "_Page"
			scrollingFrame1.Size = UDim2.new(1, 0, 1, 0)
			scrollingFrame1.BackgroundTransparency = 1
			scrollingFrame1.BorderSizePixel = 0
			scrollingFrame1.ScrollBarThickness = 3
			scrollingFrame1.ScrollBarImageColor3 = tbl.Theme.AccentBright
			scrollingFrame1.AutomaticCanvasSize = Enum.AutomaticSize.Y
			scrollingFrame1.CanvasSize = UDim2.new(0, 0, 0, 0)
			scrollingFrame1.Visible = false
			scrollingFrame1.Parent = frame3
			local frame = Instance.new("Frame")
			frame.Name = "LeftColumn"
			frame.Size = UDim2.new(0.5, -6, 0, 0)
			frame.Position = UDim2.new(0, 0, 0, 0)
			frame.AutomaticSize = Enum.AutomaticSize.Y
			frame.BackgroundTransparency = 1
			frame.Parent = scrollingFrame1
			local uIListLayout = Instance.new("UIListLayout")
			uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			uIListLayout.Padding = UDim.new(0, 10)
			uIListLayout.Parent = frame
			local frame1 = Instance.new("Frame")
			frame1.Name = "RightColumn"
			frame1.Size = UDim2.new(0.5, -6, 0, 0)
			frame1.Position = UDim2.new(0.5, 6, 0, 0)
			frame1.AutomaticSize = Enum.AutomaticSize.Y
			frame1.BackgroundTransparency = 1
			frame1.Parent = scrollingFrame1
			local uIListLayout1 = Instance.new("UIListLayout")
			uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
			uIListLayout1.Padding = UDim.new(0, 10)
			uIListLayout1.Parent = frame1

			local function func()
				for _, tab in ipairs(tbl2.Tabs) do
					tab.Page.Visible = false
					local Button = tab.Button
					local tweenInfo = TweenInfo.new(0.2)
					TweenService:Create(Button, tweenInfo, {BackgroundTransparency = tbl.Theme.ButtonTransparency}):Play()
					tab.Label.TextColor3 = tbl.Theme.TextSecondary
					tab.Stroke.Transparency = 0.35
				end

				scrollingFrame1.Visible = true
				local tweenInfo1 = TweenInfo.new(0.2)
				TweenService:Create(textButton, tweenInfo1, {BackgroundTransparency = tbl.Theme.ButtonTransparency - 0.18}):Play()
				textLabel.TextColor3 = tbl.Theme.TextPrimary
				ShimmerBorder.Transparency = 0.02
				tbl2.ActiveTab = tbl3
			end

			textButton.Activated:Connect(func)
			tbl3.Button = textButton
			tbl3.Label = textLabel
			tbl3.Stroke = ShimmerBorder
			tbl3.Page = scrollingFrame1
			table.insert(tbl2.Tabs, tbl3)

			if #tbl2.Tabs == 1 then
				func()
			end

			local function func1(parent, arg2)
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, 0, 0, 0)
				frame.AutomaticSize = Enum.AutomaticSize.Y
				frame.BackgroundColor3 = tbl.Theme.BgGroup
				frame.BackgroundTransparency = tbl.Theme.GroupTransparency
				frame.Parent = parent
				tbl:Corner(frame, 11)
				tbl:AddShimmerBorder(frame, 1.3, 0.15)
				local uIPadding = Instance.new("UIPadding")
				uIPadding.PaddingTop = UDim.new(0, 10)
				uIPadding.PaddingBottom = UDim.new(0, 10)
				uIPadding.PaddingLeft = UDim.new(0, 10)
				uIPadding.PaddingRight = UDim.new(0, 10)
				uIPadding.Parent = frame
				local uIListLayout = Instance.new("UIListLayout")
				uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				uIListLayout.Padding = UDim.new(0, 7)
				uIListLayout.Parent = frame
				local textLabel = Instance.new("TextLabel")
				textLabel.LayoutOrder = 0
				textLabel.Size = UDim2.new(1, 0, 0, 20)
				textLabel.BackgroundTransparency = 1
				textLabel.Font = Enum.Font.GothamBold
				textLabel.TextSize = 14
				textLabel.TextColor3 = tbl.Theme.AccentBright
				textLabel.TextXAlignment = Enum.TextXAlignment.Left
				textLabel.Text = tostring(arg2)
				textLabel.Parent = frame
				local num = 0

				return {
					Card = frame,
					NextItemOrder = function()
						num = num + 1
						return num
					end,
					AddToggle = function(_, arg2, arg3)
						local v1 = arg3 or {}
						local tbl2 = {Value = v1.Default or false, Locked = false}
						local textButton = Instance.new("TextButton")
						num = num + 1
						textButton.LayoutOrder = num
						textButton.Size = UDim2.new(1, 0, 0, v1.Description and 44 or 32)
						textButton.BackgroundColor3 = tbl.Theme.ButtonBg
						textButton.BackgroundTransparency = tbl.Theme.ButtonTransparency
						textButton.AutoButtonColor = false
						textButton.Text = ""
						textButton.Parent = frame
						tbl:Corner(textButton, 8)
						tbl:AddShimmerBorder(textButton, 1.1, 0.25)
						local textLabel = Instance.new("TextLabel")
						textLabel.Size = UDim2.new(1, -56, 0, 18)
						textLabel.Position = UDim2.new(0, 10, 0, v1.Description and 5 or 7)
						textLabel.BackgroundTransparency = 1
						textLabel.Font = Enum.Font.GothamBold
						textLabel.TextSize = 13
						textLabel.TextColor3 = tbl.Theme.TextPrimary
						textLabel.TextXAlignment = Enum.TextXAlignment.Left
						textLabel.Text = tostring(v1.Text or arg2)
						textLabel.Parent = textButton

						if v1.Description then
							local textLabel1 = Instance.new("TextLabel")
							textLabel1.Size = UDim2.new(1, -56, 0, 16)
							textLabel1.Position = UDim2.new(0, 10, 0, 23)
							textLabel1.BackgroundTransparency = 1
							textLabel1.Font = Enum.Font.Gotham
							textLabel1.TextSize = 11
							textLabel1.TextColor3 = tbl.Theme.TextSecondary
							textLabel1.TextXAlignment = Enum.TextXAlignment.Left
							textLabel1.TextTruncate = Enum.TextTruncate.AtEnd
							textLabel1.Text = tostring(v1.Description)
							textLabel1.Parent = textButton
						end

						local frame1 = Instance.new("Frame")
						frame1.Size = UDim2.new(0, 36, 0, 18)
						frame1.Position = UDim2.new(1, -44, 0.5, -9)
						frame1.BackgroundColor3 = Color3.fromRGB(70, 45, 110)
						frame1.BackgroundTransparency = 0.2
						frame1.Parent = textButton
						tbl:Corner(frame1, 9)
						tbl:AddShimmerBorder(frame1, 1, 0.2)
						local frame2 = Instance.new("Frame")
						frame2.Size = UDim2.new(0, 14, 0, 14)
						frame2.Position = UDim2.new(0, 2, 0.5, -7)
						frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						frame2.Parent = frame1
						tbl:Corner(frame2, 7)

						function tbl2:SetValue(arg2)
							if self.Locked then
								return
							end

							self.Value = not not arg2

							TweenService:Create(
								frame1,
								TweenInfo.new(0.2),
								{BackgroundColor3 = self.Value and tbl.Theme.Accent or Color3.fromRGB(70, 45, 110)}
							):Play()

							TweenService:Create(
								frame2,
								TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{Position = self.Value and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}
							):Play()

							if v1.Callback then
								tbl1.Util.Try(v1.Callback, self.Value)
							end
						end

						function tbl2:SetLocked(locked, arg3)
							self.Locked = locked
							if locked then
								textLabel.Text = tostring(v1.Text or arg2) .. " [" .. tostring(arg3 or "Unavailable") .. "]"
								textLabel.TextColor3 = tbl.Theme.Warning
							end
						end

						function tbl2:AddKeyPicker(_, arg3)
							local v1 = arg3 or {}
							local v2 = v1.Default or "None"

							if v2 ~= "None" and Enum.KeyCode[v2] then
								local v3 = Enum.KeyCode[v2]

								tbl1.Util.Connect(UserInputService.InputBegan, function(arg1, arg2)
									if not arg2 and arg1.KeyCode == v3 then
										if v1.Mode == "Hold" then
											tbl2:SetValue(true)
										else
											tbl2:SetValue(not tbl2.Value)
										end
									end
								end)

								if v1.Mode == "Hold" then
									tbl1.Util.Connect(UserInputService.InputEnded, function(arg1)
										if arg1.KeyCode == v3 then
											tbl2:SetValue(false)
										end
									end)
								end
							end

							return tbl2
						end

						textButton.Activated:Connect(function()
							tbl2:SetValue(not tbl2.Value)
						end)

						tbl.Toggles[arg2] = tbl2
						tbl.Options[arg2] = tbl2

						if tbl2.Value then
							tbl2:SetValue(true)
						end

						return tbl2
					end,
					AddButton = function(_, arg2)
						local v1 = arg2 or {}
						local frame1 = Instance.new("Frame")
						num = num + 1
						frame1.LayoutOrder = num
						frame1.Size = UDim2.new(1, 0, 0, 32)
						frame1.BackgroundTransparency = 1
						frame1.Parent = frame
						local uIListLayout = Instance.new("UIListLayout")
						uIListLayout.FillDirection = Enum.FillDirection.Horizontal
						uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
						uIListLayout.Padding = UDim.new(0, 6)
						uIListLayout.Parent = frame1
						local tbl2 = {}

						local function func()
							local v1 = #tbl2
							for _, v2 in ipairs(tbl2) do
								v2.Size = UDim2.new(1 / v1, -(v1 - 1) * 6 / v1, 1, 0)
							end
						end

						local function func1(arg1)
							local textButton = Instance.new("TextButton")
							textButton.BackgroundColor3 = tbl.Theme.ButtonBg
							textButton.BackgroundTransparency = tbl.Theme.ButtonTransparency
							textButton.AutoButtonColor = false
							textButton.Font = Enum.Font.GothamBold
							textButton.TextSize = 13
							textButton.TextColor3 = tbl.Theme.TextPrimary
							textButton.Text = tostring(arg1.Text or "Button")
							textButton.Parent = frame1
							tbl:Corner(textButton, 8)
							tbl:AddShimmerBorder(textButton, 1.2, 0.15)
							local num = 0

							textButton.Activated:Connect(function()
								if arg1.DoubleClick then
									local v1 = os.clock()
									if v1 - num > 0.6 then
										num = v1
										textButton.Text = "Click again: " .. tostring(arg1.Text)

										task.delay(0.65, function()
											if textButton.Parent then
												textButton.Text = tostring(arg1.Text)
											end
										end)

										return
									end
								end
								if arg1.Func then
									task.spawn(tbl1.Util.Try, arg1.Func)
								end
							end)

							table.insert(tbl2, textButton)
							func()
						end

						func1(v1)
						local tbl3 = {}

						function tbl3:AddButton(arg2)
							func1(arg2 or {})
							return tbl3
						end

						return tbl3
					end,
					AddSlider = function(_, arg2, arg3)
						local v1 = arg3 or {}
						local v2 = tonumber(v1.Min) or 0
						local v3 = tonumber(v1.Max) or 100
						local v4 = tonumber(v1.Default) or v2
						local v5 = v1.Suffix or ""
						local tbl2 = {Value = v4}
						local frame1 = Instance.new("Frame")
						num = num + 1
						frame1.LayoutOrder = num
						frame1.Size = UDim2.new(1, 0, 0, 44)
						frame1.BackgroundColor3 = tbl.Theme.ButtonBg
						frame1.BackgroundTransparency = tbl.Theme.ButtonTransparency
						frame1.Parent = frame
						tbl:Corner(frame1, 8)
						tbl:AddShimmerBorder(frame1, 1.1, 0.25)
						local textLabel = Instance.new("TextLabel")
						textLabel.Size = UDim2.new(1, -20, 0, 18)
						textLabel.Position = UDim2.new(0, 10, 0, 5)
						textLabel.BackgroundTransparency = 1
						textLabel.Font = Enum.Font.GothamBold
						textLabel.TextSize = 12
						textLabel.TextColor3 = tbl.Theme.TextPrimary
						textLabel.TextXAlignment = Enum.TextXAlignment.Left
						textLabel.Text = string.format("%s: %d%s", tostring(v1.Text or arg2), v4, v5)
						textLabel.Parent = frame1
						local frame2 = Instance.new("Frame")
						frame2.Size = UDim2.new(1, -20, 0, 8)
						frame2.Position = UDim2.new(0, 10, 0, 28)
						frame2.BackgroundColor3 = Color3.fromRGB(60, 35, 95)
						frame2.Parent = frame1
						tbl:Corner(frame2, 4)
						local frame3 = Instance.new("Frame")
						frame3.Size = UDim2.new(math.clamp((v4 - v2) / math.max(1, v3 - v2), 0, 1), 0, 1, 0)
						frame3.BackgroundColor3 = tbl.Theme.AccentBright
						frame3.Parent = frame2
						tbl:Corner(frame3, 4)

						function tbl2:SetValue(arg21)
							local v4 = math.floor(math.clamp(arg21, v2, v3) + 0.5)
							self.Value = v4
							local v6 = (v4 - v2) / math.max(1, v3 - v2)
							frame3.Size = UDim2.new(v6, 0, 1, 0)
							textLabel.Text = string.format("%s: %d%s", tostring(v1.Text or arg2), v4, v5)

							if v1.Callback then
								tbl1.Util.Try(v1.Callback, v4)
							end
						end

						local flag = false

						local function func(arg1)
							local v1 = math.clamp((arg1.Position.X - frame2.AbsolutePosition.X) / math.max(1, frame2.AbsoluteSize.X), 0, 1)
							tbl2:SetValue(v2 + (v3 - v2) * v1)
						end

						frame1.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
								flag = true
								func(input)

								input.Changed:Connect(function()
									if input.UserInputState == Enum.UserInputState.End then
										flag = false
									end
								end)
							end
						end)

						tbl1.Util.Connect(UserInputService.InputChanged, function(arg1)
							if flag and (arg1.UserInputType == Enum.UserInputType.MouseMovement or arg1.UserInputType == Enum.UserInputType.Touch) then
								func(arg1)
							end
						end)

						tbl.Options[arg2] = tbl2
						return tbl2
					end,
					AddDropdown = function(_, arg2, arg3)
						local v1 = arg3 or {}
						local tbl2 = {}
						tbl2.Value = nil
						local textButton = Instance.new("TextButton")
						num = num + 1
						textButton.LayoutOrder = num
						textButton.Size = UDim2.new(1, 0, 0, 34)
						textButton.BackgroundColor3 = tbl.Theme.ButtonBg
						textButton.BackgroundTransparency = tbl.Theme.ButtonTransparency
						textButton.AutoButtonColor = false
						textButton.Font = Enum.Font.GothamBold
						textButton.TextSize = 12
						textButton.TextColor3 = tbl.Theme.TextPrimary
						textButton.Text = tostring(v1.Text or arg2) .. ": None"
						textButton.Parent = frame
						tbl:Corner(textButton, 8)
						tbl:AddShimmerBorder(textButton, 1.1, 0.25)
						local frame1 = Instance.new("Frame")
						num = num + 1
						frame1.LayoutOrder = num
						frame1.Size = UDim2.new(1, 0, 0, 0)
						frame1.AutomaticSize = Enum.AutomaticSize.Y
						frame1.BackgroundColor3 = tbl.Theme.BgSecondary
						frame1.BackgroundTransparency = 0.25
						frame1.Visible = false
						frame1.Parent = frame
						tbl:Corner(frame1, 8)
						tbl:AddShimmerBorder(frame1, 1, 0.3)
						local uIListLayout = Instance.new("UIListLayout")
						uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
						uIListLayout.Padding = UDim.new(0, 4)
						uIListLayout.Parent = frame1
						local uIPadding = Instance.new("UIPadding")
						uIPadding.PaddingTop = UDim.new(0, 6)
						uIPadding.PaddingBottom = UDim.new(0, 6)
						uIPadding.PaddingLeft = UDim.new(0, 6)
						uIPadding.PaddingRight = UDim.new(0, 6)
						uIPadding.Parent = frame1

						function tbl2:SetValue(value)
							self.Value = value
							textButton.Text = tostring(v1.Text or arg2) .. ": " .. tostring(value or "None")

							if v1.Callback then
								tbl1.Util.Try(v1.Callback, value)
							end
						end

						local function func()
							for _, child in ipairs(frame1:GetChildren()) do
								if child:IsA("TextButton") then
									child:Destroy()
								end
							end

							local tbl1 = {}

							if v1.SpecialType == "Player" then
								for _, player in ipairs(Players:GetPlayers()) do
									if player ~= LocalPlayer then
										table.insert(tbl1, player.Name)
									end
								end
							else
								tbl1 = v1.Values or {}
							end

							for _, v2 in ipairs(tbl1) do
								local textButton = Instance.new("TextButton")
								textButton.Size = UDim2.new(1, 0, 0, 26)
								textButton.BackgroundColor3 = tbl.Theme.ButtonBg
								textButton.BackgroundTransparency = tbl.Theme.ButtonTransparency
								textButton.AutoButtonColor = false
								textButton.Font = Enum.Font.GothamMedium
								textButton.TextSize = 12
								textButton.TextColor3 = tbl.Theme.TextPrimary
								textButton.Text = tostring(v2)
								textButton.Parent = frame1
								tbl:Corner(textButton, 6)

								textButton.Activated:Connect(function()
									tbl2:SetValue(v2)
									frame1.Visible = false
								end)
							end
						end

						textButton.Activated:Connect(function()
							if not frame1.Visible then
								func()
							end
							frame1.Visible = not frame1.Visible
						end)

						tbl.Options[arg2] = tbl2
						return tbl2
					end,
					AddProgressBar = function(_, arg2, arg3)
						local v1 = arg3 or {}
						local tbl1 = {Value = v1.Default or 0}
						local frame1 = Instance.new("Frame")
						num = num + 1
						frame1.LayoutOrder = num
						frame1.Size = UDim2.new(1, 0, 0, 42)
						frame1.BackgroundColor3 = tbl.Theme.ButtonBg
						frame1.BackgroundTransparency = tbl.Theme.ButtonTransparency
						frame1.Parent = frame
						tbl:Corner(frame1, 8)
						tbl:AddShimmerBorder(frame1, 1.1, 0.25)
						local textLabel = Instance.new("TextLabel")
						textLabel.Size = UDim2.new(1, -20, 0, 18)
						textLabel.Position = UDim2.new(0, 10, 0, 4)
						textLabel.BackgroundTransparency = 1
						textLabel.Font = Enum.Font.GothamBold
						textLabel.TextSize = 12
						textLabel.TextColor3 = tbl.Theme.TextPrimary
						textLabel.TextXAlignment = Enum.TextXAlignment.Left
						textLabel.Text = tostring(v1.Text or arg2) .. ": 0%"
						textLabel.Parent = frame1
						local frame2 = Instance.new("Frame")
						frame2.Size = UDim2.new(1, -20, 0, 8)
						frame2.Position = UDim2.new(0, 10, 0, 26)
						frame2.BackgroundColor3 = Color3.fromRGB(60, 35, 95)
						frame2.Parent = frame1
						tbl:Corner(frame2, 4)
						local frame3 = Instance.new("Frame")
						frame3.Size = UDim2.new(0, 0, 1, 0)
						frame3.BackgroundColor3 = tbl.Theme.AccentBright
						frame3.Parent = frame2
						tbl:Corner(frame3, 4)

						function tbl1:SetValue(arg21)
							local v2 = math.clamp(tonumber(arg21) or 0, 0, 1)
							self.Value = v2
							TweenService:Create(frame3, TweenInfo.new(0.2), {Size = UDim2.new(v2, 0, 1, 0)}):Play()
							textLabel.Text = string.format("%s: %d%%", tostring(v1.Text or arg2), math.floor(v2 * 100 + 0.5))
						end

						tbl.Options[arg2] = tbl1
						return tbl1
					end,
					AddParagraph = function(_, arg2)
						local v1 = arg2 or {}
						local frame1 = Instance.new("Frame")
						num = num + 1
						frame1.LayoutOrder = num
						frame1.Size = UDim2.new(1, 0, 0, 0)
						frame1.AutomaticSize = Enum.AutomaticSize.Y
						frame1.BackgroundColor3 = tbl.Theme.ButtonBg
						frame1.BackgroundTransparency = tbl.Theme.ButtonTransparency
						frame1.Parent = frame
						tbl:Corner(frame1, 8)
						tbl:AddShimmerBorder(frame1, 1, 0.3)
						local uIPadding = Instance.new("UIPadding")
						uIPadding.PaddingTop = UDim.new(0, 6)
						uIPadding.PaddingBottom = UDim.new(0, 6)
						uIPadding.PaddingLeft = UDim.new(0, 8)
						uIPadding.PaddingRight = UDim.new(0, 8)
						uIPadding.Parent = frame1
						local textLabel = Instance.new("TextLabel")
						textLabel.Size = UDim2.new(1, 0, 0, 0)
						textLabel.AutomaticSize = Enum.AutomaticSize.Y
						textLabel.BackgroundTransparency = 1
						textLabel.Font = Enum.Font.GothamMedium
						textLabel.TextSize = 12
						textLabel.TextColor3 = tbl.Theme.TextPrimary
						textLabel.TextWrapped = true
						textLabel.TextXAlignment = Enum.TextXAlignment.Left
						textLabel.Text = tostring(v1.Title or "") .. "\n" .. tostring(v1.Content or "")
						textLabel.Parent = frame1
					end,
					AddLabel = function(_, arg2)
						local textLabel = Instance.new("TextLabel")
						num = num + 1
						textLabel.LayoutOrder = num
						textLabel.Size = UDim2.new(1, 0, 0, 20)
						textLabel.BackgroundTransparency = 1
						textLabel.Font = Enum.Font.GothamMedium
						textLabel.TextSize = 12
						textLabel.TextColor3 = tbl.Theme.TextSecondary
						textLabel.TextXAlignment = Enum.TextXAlignment.Left
						textLabel.Text = tostring(arg2 or "")
						textLabel.Parent = frame

						return {
							SetText = function(_, arg2)
								textLabel.Text = tostring(arg2 or "")
							end,
						}
					end,
					AddInput = function(_, arg2, arg3)
						local v1 = arg3 or {}
						local tbl2 = {Value = v1.Default or ""}
						local textBox = Instance.new("TextBox")
						num = num + 1
						textBox.LayoutOrder = num
						textBox.Size = UDim2.new(1, 0, 0, 32)
						textBox.BackgroundColor3 = tbl.Theme.ButtonBg
						textBox.BackgroundTransparency = tbl.Theme.ButtonTransparency
						textBox.Font = Enum.Font.GothamMedium
						textBox.TextSize = 12
						textBox.TextColor3 = tbl.Theme.TextPrimary
						textBox.PlaceholderColor3 = tbl.Theme.TextSecondary
						textBox.PlaceholderText = tostring(v1.Placeholder or v1.Text or "")
						textBox.Text = tostring(v1.Default or "")
						textBox.ClearTextOnFocus = false
						textBox.Parent = frame
						tbl:Corner(textBox, 8)
						tbl:AddShimmerBorder(textBox, 1.1, 0.25)

						textBox:GetPropertyChangedSignal("Text"):Connect(function()
							tbl2.Value = textBox.Text
							if v1.Callback then
								tbl1.Util.Try(v1.Callback, textBox.Text)
							end
						end)

						tbl.Options[arg2] = tbl2
						return tbl2
					end,
				}
			end

			function tbl3:AddLeftGroupbox(arg2, _)
				return (func1(frame, arg2))
			end

			function tbl3:AddRightGroupbox(arg2, _)
				return (func1(frame1, arg2))
			end

			return tbl3
		end

		function tbl2.AddSettingsTab(arg1)
			local settingsTab = arg1:AddTab("Settings", "settings", "Player profile, key timer & UI controls")
			local LeftGroupbox = settingsTab:AddLeftGroupbox("Player Profile & Key")
			local frame = Instance.new("Frame")
			frame.LayoutOrder = LeftGroupbox.NextItemOrder()
			frame.Size = UDim2.new(1, 0, 0, 82)
			frame.BackgroundColor3 = tbl.Theme.ButtonBg
			frame.BackgroundTransparency = tbl.Theme.ButtonTransparency
			frame.Parent = LeftGroupbox.Card
			tbl:Corner(frame, 10)
			tbl:AddShimmerBorder(frame, 1.3, 0.15)
			local frame1 = Instance.new("Frame")
			frame1.Size = UDim2.new(0, 62, 0, 62)
			frame1.Position = UDim2.new(0, 10, 0.5, -31)
			frame1.BackgroundColor3 = Color3.fromRGB(55, 30, 90)
			frame1.BackgroundTransparency = 0.2
			frame1.Parent = frame
			tbl:Corner(frame1, 31)
			tbl:AddShimmerBorder(frame1, 1.5, 0.05)
			local imageLabel = Instance.new("ImageLabel")
			imageLabel.Size = UDim2.new(1, 0, 1, 0)
			imageLabel.BackgroundTransparency = 1
			imageLabel.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", LocalPlayer.UserId)
			imageLabel.ScaleType = Enum.ScaleType.Fit
			imageLabel.Parent = frame1
			tbl:Corner(imageLabel, 31)

			task.spawn(function()
				local ok, result = pcall(
					Players.GetUserThumbnailAsync,
					Players,
					LocalPlayer.UserId,
					Enum.ThumbnailType.HeadShot,
					Enum.ThumbnailSize.Size150x150
				)
				if ok and type(result) == "string" and #result > 0 then
					imageLabel.Image = result
				end
			end)

			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, -84, 0, 22)
			textLabel.Position = UDim2.new(0, 80, 0, 12)
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.GothamBlack
			textLabel.TextSize = 15
			textLabel.TextColor3 = tbl.Theme.TextPrimary
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			textLabel.TextTruncate = Enum.TextTruncate.AtEnd
			textLabel.Text = LocalPlayer.DisplayName
			textLabel.Parent = frame
			local textLabel1 = Instance.new("TextLabel")
			textLabel1.Size = UDim2.new(1, -84, 0, 16)
			textLabel1.Position = UDim2.new(0, 80, 0, 33)
			textLabel1.BackgroundTransparency = 1
			textLabel1.Font = Enum.Font.GothamMedium
			textLabel1.TextSize = 12
			textLabel1.TextColor3 = tbl.Theme.TextSecondary
			textLabel1.TextXAlignment = Enum.TextXAlignment.Left
			textLabel1.TextTruncate = Enum.TextTruncate.AtEnd
			textLabel1.Text = "@" .. LocalPlayer.Name .. "  •  ID: " .. tostring(LocalPlayer.UserId)
			textLabel1.Parent = frame
			local textLabel2 = Instance.new("TextLabel")
			textLabel2.Size = UDim2.new(1, -84, 0, 18)
			textLabel2.Position = UDim2.new(0, 80, 0, 52)
			textLabel2.BackgroundTransparency = 1
			textLabel2.Font = Enum.Font.GothamBold
			textLabel2.TextSize = 12
			textLabel2.TextColor3 = tbl.Theme.Success
			textLabel2.TextXAlignment = Enum.TextXAlignment.Left
			textLabel2.Text = "Key Drops In: Calculating..."
			textLabel2.Parent = frame
			local Label = LeftGroupbox:AddLabel("Reset Time: Calculating...")
			local keyTimeProgressBar = LeftGroupbox:AddProgressBar("KeyTimeProgress", {Text = "24h Key Validity", Max = 1, Default = 1})

			LeftGroupbox:AddButton({
				Text = "Copy Discord Link",
				Func = function()
					tbl1.Util.CopyClipboard(Config.DiscordLink)
					tbl:Notify("eter hub", "Copied Discord link: " .. Config.DiscordLink, 4, "Success")
				end,
			})

			local interfaceControlsGroupbox = settingsTab:AddRightGroupbox("Interface Controls")
			interfaceControlsGroupbox:AddLabel("Toggle Menu (PC): LeftControl")
			interfaceControlsGroupbox:AddLabel("Mobile & PC: Use floating eter hub icon")

			interfaceControlsGroupbox:AddButton({
				Text = "Unload eter hub",
				DoubleClick = true,
				Func = function()
					tbl:Unload()
				end,
			})

			tbl:Every(1, function()
				local v1 = tbl1.KeySystem.RemainingSeconds()

				if v1 <= 0 then
					tbl1.KeySystem.ClearRecord()
					tbl:Notify("eter hub Key Expired", "24 hours have passed! Please re-enter your key.", 6, "Warning")
					task.wait(1.5)
					tbl:Unload()
					return
				end

				local v2 = math.floor(v1 / 3600)
				local v3 = math.floor(v1 % 3600 / 60)
				local v4 = math.floor(v1 % 60)
				textLabel2.Text = string.format("Key Drops In: %02dh %02dm %02ds", v2, v3, v4)
				local v5 = tbl1.KeySystem.LoadRecord()

				if v5 and v5.Timestamp then
					local v6 = tonumber(v5.Timestamp) + Config.KeyDuration
					Label:SetText("Drops At: " .. os.date("%Y-%m-%d %H:%M:%S", v6))
				end

				keyTimeProgressBar:SetValue(math.clamp(v1 / Config.KeyDuration, 0, 1))
			end)
		end

-- https://lua-x.online
		task.spawn(function()
			self:ShowKeyVerification(function()
				self:PlaySplashScreen(function()
					textButton1.Visible = true

					if v1.OnUnlocked then
						tbl1.Util.Try(v1.OnUnlocked)
					end

					tbl2:SetOpen(true)
				end)
			end)
		end)

		return tbl2
	end

	function tbl:Every(arg2, arg3)
		task.spawn(function()
			while State.Alive and screenGui.Parent do
				tbl1.Util.Try(arg3)
				task.wait(arg2)
			end
		end)
	end

	function tbl:OnUnload(arg2)
		table.insert(self.UnloadCallbacks, arg2)
	end

	function tbl:Unload()
		for _, unloadCallback in ipairs(self.UnloadCallbacks) do
			tbl1.Util.Try(unloadCallback)
		end
		if screenGui and screenGui.Parent then
			screenGui:Destroy()
		end
	end

	function tbl.LoadAutoloadConfig(_)
	end

	return tbl
end

tbl1.GameLib = {}
local GameLib = tbl1.GameLib

function GameLib.Remote(arg1, name, className)
	local v1 = arg1 and arg1:FindFirstChild(name) or ReplicatedStorage:FindFirstChild(name, true)
	return v1 and v1:IsA(className) and v1 or nil
end

local Remotes = ReplicatedStorage:WaitForChild("Remotes", Config.LoadTimeout)
local v2 = Remotes and Remotes:WaitForChild("Gameplay", Config.LoadTimeout)
local v3 = Remotes and Remotes:FindFirstChild("Extras")
GameLib.PlayerData = GameLib.Remote(v2, "GetCurrentPlayerData", "RemoteFunction")
GameLib.CoinCollected = GameLib.Remote(v2, "CoinCollected", "BaseRemoteEvent")
GameLib.CoinsStarted = GameLib.Remote(v2, "CoinsStarted", "BaseRemoteEvent")
GameLib.RoundStart = GameLib.Remote(v2, "RoundStart", "BaseRemoteEvent")
GameLib.RedeemCode = GameLib.Remote(v3, "RedeemCode", "RemoteFunction")
GameLib.Needs = {RoleNotify = {"RoundStart"}, ResetWhenFull = {"CoinCollected"}}

function GameLib.Missing(arg1)
	for _, v1 in ipairs(GameLib.Needs[arg1] or {}) do
		if not GameLib[v1] then
			return v1
		end
	end
	return nil
end

function tbl1.Util:Connect(arg2)
	local connection = self:Connect(arg2)
	table.insert(State.Conns, connection)
	return connection
end

function tbl1.Util.Root(arg1)
	local Character = (arg1 or LocalPlayer).Character
	return Character and Character:FindFirstChild("HumanoidRootPart")
end

function tbl1.Util.Humanoid(arg1)
	local Character = (arg1 or LocalPlayer).Character
	return Character and Character:FindFirstChildOfClass("Humanoid")
end

function tbl1.Util.Tool(player, name)
	local Character = player.Character
	local Backpack = player:FindFirstChild("Backpack")
	return Character and Character:FindFirstChild(name) or Backpack and Backpack:FindFirstChild(name)
end

function tbl1.Round.RefreshRoles()
	if os.clock() - State.LastRoleFetch < Config.RoleRefresh then
		return
	end

	State.LastRoleFetch = os.clock()

	if not GameLib.PlayerData then
		return
	end

	local ok, result = pcall(GameLib.PlayerData.InvokeServer, GameLib.PlayerData)

	if ok and type(result) == "table" then
		State.Roles = result
	end
end

function tbl1.Round.RoleOf(arg1)
	local v1 = State.Roles[arg1.Name]

	if v1 and not v1.Dead and v1.Role then
		return v1.Role
	end

	if tbl1.Util.Tool(arg1, "Knife") then
		return "Murderer"
	end

	if tbl1.Util.Tool(arg1, "Gun") then
		return "Sheriff"
	end

	return v1 and v1.Dead and "Dead" or "Innocent"
end

function tbl1.Round.FindByRole(arg1)
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and tbl1.Round.RoleOf(player) == arg1 and tbl1.Util.Root(player) then
			return player
		end
	end
	return nil
end

function tbl1.Round.Map()
	for _, child in ipairs(workspace:GetChildren()) do
		if child.Name ~= Config.LobbyName and child:IsA("Model") and child:FindFirstChild("CoinContainer") then
			return child
		end
	end
	return nil
end

function tbl1.Round.Lobby()
	local v1 = workspace:FindFirstChild(Config.LobbyName)

	if v1 then
		return v1
	end

	for _, child in ipairs(workspace:GetChildren()) do
		if child:IsA("Model") and child.Name:find("Lobby") then
			return child
		end
	end

	return nil
end

function tbl1.Round.IAmPlaying()
	local v1 = State.Roles[LocalPlayer.Name]
	local v2 = tbl1.Util.Humanoid()
	return tbl1.Round.Map() ~= nil and v2 ~= nil and v2.Health > 0 and v1 ~= nil and not v1.Dead
end

function tbl1.Round.GunDrop()
	local v1 = tbl1.Round.Map()
	return v1 and v1:FindFirstChild("GunDrop", true) or workspace:FindFirstChild("GunDrop")
end

function tbl1.Movement.SetNoclip(arg1)
	if State.NoclipConn then
		State.NoclipConn:Disconnect()
		State.NoclipConn = nil
	end

	if not arg1 then
		tbl1.Movement.RestoreCollision()
		return
	end

	local NoclipSaved = State.NoclipSaved

	State.NoclipConn = tbl1.Util.Connect(RunService.Stepped, function()
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		for _, child in ipairs(Character:GetChildren()) do
			if child:IsA("BasePart") then
				if NoclipSaved[child] == nil then
					NoclipSaved[child] = child.CanCollide
				end
				child.CanCollide = false
			end
		end
	end)
end

function tbl1.Movement.RestoreCollision()
	for k, v1 in pairs(State.NoclipSaved) do
		if k.Parent then
			k.CanCollide = v1
		end
	end
	table.clear(State.NoclipSaved)
end

function tbl1.Movement.RefreshNoclip()
	tbl1.Movement.SetNoclip(State.Opt.Noclip or State.FarmBusy)
end

function tbl1.Movement.Apply()
	local v1 = tbl1.Util.Humanoid()

	if not v1 then
		return
	end

	local Opt = State.Opt

	if Opt.SpeedOn then
		v1.WalkSpeed = Opt.WalkSpeed
	end

	if Opt.JumpOn then
		v1.UseJumpPower = true
		v1.JumpPower = Opt.JumpPower
	end
end

function tbl1.Movement.RestoreSpeed()
	local v1 = tbl1.Util.Humanoid()
	if v1 then
		v1.WalkSpeed = Config.SpeedDefault
	end
end

function tbl1.Movement.RestoreJump()
	local v1 = tbl1.Util.Humanoid()
	if v1 then
		v1.JumpPower = Config.JumpDefault
	end
end

function tbl1.Movement.InitInfJump()
	tbl1.Util.Connect(UserInputService.JumpRequest, function()
		local v1 = tbl1.Util.Humanoid()
		if State.Opt.InfJump and v1 then
			v1:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end

function tbl1.Movement.SetFly(arg1)
	if State.FlyConn then
		State.FlyConn:Disconnect()
		State.FlyConn = nil
	end

	if State.FlyVelocity then
		State.FlyVelocity:Destroy()
		State.FlyVelocity = nil
	end

	local v1 = tbl1.Util.Humanoid()

	if v1 then
		v1.PlatformStand = false
	end

	if not arg1 then
		return
	end

	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.one * 1000000000
	bodyVelocity.Velocity = Vector3.zero
	State.FlyVelocity = bodyVelocity

	State.FlyConn = tbl1.Util.Connect(RunService.RenderStepped, function()
		local v1 = tbl1.Util.Root()
		local v2 = tbl1.Util.Humanoid()

		if not v1 or not v2 then
			return
		end

		bodyVelocity.Parent = v1
		v2.PlatformStand = true
		local v3 = (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0)
		bodyVelocity.Velocity = (v2.MoveDirection + Vector3.yAxis * v3) * Config.FlySpeed
	end)
end

function tbl1.Util.Busy()
	return State.ActionBusy and os.clock() - State.BusySince < Config.BusyTimeout
end

function tbl1.Util.SetBusy(actionBusy)
	State.ActionBusy = actionBusy
	State.BusySince = os.clock()
end

function tbl1.Util.WarpAndReturn(cFrame, arg2)
	local v1 = tbl1.Util.Root()

	if not v1 or not cFrame or tbl1.Util.Busy() then
		return false
	end

	tbl1.Util.SetBusy(true)
	local CFrame1 = v1.CFrame

	local v2 = tbl1.Util.Try(function()
		v1.CFrame = cFrame
		v1.AssemblyLinearVelocity = Vector3.zero
		arg2()
	end)

	local v3 = tbl1.Util.Root()

	if v3 then
		v3.CFrame = CFrame1
	end

	tbl1.Util.SetBusy(false)
	return v2
end

function tbl1.Sheriff.Gun()
	return tbl1.Util.Tool(LocalPlayer, "Gun")
end

function tbl1.Sheriff.Equip(arg1)
	local v1 = tbl1.Util.Humanoid()
	if v1 and arg1.Parent ~= LocalPlayer.Character then
		v1:EquipTool(arg1)
	end
end

function tbl1.Sheriff.ClearStand(player, arg2)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, player.Character}

	for _, shootStand in ipairs(Config.ShootStands) do
		local Position = (arg2.CFrame * CFrame.new(shootStand)).Position
		if not workspace:Raycast(Position, arg2.Position - Position, raycastParams) then
			return CFrame.lookAt(Position, arg2.Position)
		end
	end

	return CFrame.lookAt((arg2.CFrame * CFrame.new(Config.ShootStands[1])).Position, arg2.Position)
end

function tbl1.Sheriff.ShootTarget(arg1)
	local v1 = tbl1.Sheriff.Gun()
	local v2 = tbl1.Util.Root(arg1)

	if not v1 or not v2 or os.clock() - State.LastShoot < Config.ShootCooldown then
		return false
	end

	State.LastShoot = os.clock()
	tbl1.Sheriff.Equip(v1)

	return tbl1.Util.WarpAndReturn(tbl1.Sheriff.ClearStand(arg1, v2), function()
		task.wait(Config.ShootSettle)
		local v3 = tbl1.Util.Root()
		local v4 = v3 and v3:FindFirstChild("GunRaycastAttachment")
		local v5 = tbl1.Util.Root(arg1)
		v1.Shoot:FireServer(v4 and v4.WorldCFrame or v3.CFrame, (v5 or v2).CFrame)
		task.wait(Config.ShootReturn)
	end)
end

function tbl1.Util.IsDead(arg1)
	local v1 = tbl1.Util.Humanoid(arg1)
	return not v1 or v1.Health <= 0
end

function tbl1.Sheriff.ShootMurderer()
	tbl1.Round.RefreshRoles()
	local v1 = tbl1.Round.FindByRole("Murderer")

	if not v1 then
		return false, "No murderer found"
	end

	for _ = 1, tonumber(Config.ShootAttempts) do
		if not tbl1.Sheriff.Gun() then
			break
		end

		tbl1.Sheriff.ShootTarget(v1)
		task.wait(Config.ShootConfirm)

		if tbl1.Util.IsDead(v1) then
			return true, v1.Name
		end

		task.wait(math.max(0, Config.ShootCooldown - Config.ShootConfirm))
	end

	return false, v1.Name .. " survived"
end

function tbl1.Sheriff.AutoShootStep()
	if not State.Opt.AutoShoot or State.ShootBusy or not tbl1.Sheriff.Gun() or not tbl1.Round.IAmPlaying() then
		return
	end

	State.ShootBusy = true

	task.spawn(function()
		tbl1.Util.Try(tbl1.Sheriff.ShootMurderer)
		State.ShootBusy = false
	end)
end

function tbl1.Sheriff.GrabGun()
	local v1 = tbl1.Round.GunDrop()

	if not v1 or tbl1.Sheriff.Gun() or not tbl1.Round.IAmPlaying() then
		return false
	end

	local v2 = v1:IsA("BasePart") and v1

	if not v2 then
		v2 = v1:FindFirstChildWhichIsA("BasePart", true)
		if not v2 then
			return false
		end
	end

	return tbl1.Util.WarpAndReturn(v2.CFrame, function()
		local v1 = tbl1.Util.Root()

		if v1 and tbl1.Library.Compat.Caps.Touch then
			local v3 = v2
			firetouchinterest(v1, v3, 0)
			firetouchinterest(v1, v3, 1)
		end

		task.wait(Config.GunGrabHold)
	end)
end

function tbl1.Sheriff.AutoGrabStep()
	if State.Opt.AutoGrabGun and tbl1.Round.RoleOf(LocalPlayer) ~= "Murderer" and tbl1.Round.GunDrop() then
		task.spawn(tbl1.Sheriff.GrabGun)
	end
end

function tbl1.Murderer.Knife()
	return tbl1.Util.Tool(LocalPlayer, "Knife")
end

function tbl1.Murderer.Stab(arg1)
	local v1 = tbl1.Murderer.Knife()
	local v2 = tbl1.Util.Root(arg1)

	if not v1 or not v2 then
		return false
	end

	tbl1.Sheriff.Equip(v1)
	local Events = v1:FindFirstChild("Events")

	if not Events then
		return false
	end

	local v3 = v2.CFrame * CFrame.new(0, 0, Config.StabOffset)

	return tbl1.Util.WarpAndReturn(v3, function()
		Events.KnifeStabbed:FireServer()
		task.wait()
		local v1 = tbl1.Util.Root(arg1)
		Events.HandleTouched:FireServer(v1 or v2)
		task.wait(Config.StabCooldown)
	end)
end

function tbl1.Murderer.Victims()
	local tbl = {}

	for _, player in ipairs(Players:GetPlayers()) do
		local v1 = tbl1.Util.Humanoid(player)
		local v2 = State.Roles[player.Name]
		local v3 = v2 == nil or not v2.Dead

		if player ~= LocalPlayer and v1 and v1.Health > 0 and v3 and tbl1.Util.Root(player) then
			table.insert(tbl, player)
		end
	end

	table.sort(tbl, function(a, b)
		return (Config.VictimPriority[tbl1.Round.RoleOf(a)] or 3) < (Config.VictimPriority[tbl1.Round.RoleOf(b)] or 3)
	end)

	return tbl
end

function tbl1.Murderer.KillAll()
	if not tbl1.Murderer.Knife() then
		return 0
	end

	local num = 0

	for _, v1 in ipairs(tbl1.Murderer.Victims()) do
		if not State.Alive or not tbl1.Murderer.Knife() then
			break
		end
		if tbl1.Murderer.Stab(v1) then
			num = num + 1
		end
	end

	return num
end

function tbl1.Murderer.AutoKillStep()
	if not State.Opt.AutoKillAll or State.KillBusy or not tbl1.Murderer.Knife() or not tbl1.Round.IAmPlaying() then
		return
	end

	State.KillBusy = true

	task.spawn(function()
		tbl1.Util.Try(tbl1.Murderer.KillAll)
		State.KillBusy = false
	end)
end

function tbl1.Murderer.KillAuraStep()
	local v1 = tbl1.Murderer.Knife()
	local v2 = tbl1.Util.Root()

	if not State.Opt.KillAura or not v1 or not v2 or os.clock() - State.LastStab < Config.StabCooldown then
		return
	end

	local Events = v1:FindFirstChild("Events")

	for _, v3 in ipairs(tbl1.Murderer.Victims()) do
		local v4 = tbl1.Util.Root(v3)
		if Events and v4 and (v4.Position - v2.Position).Magnitude <= Config.KillAuraRange then
			State.LastStab = os.clock()
			tbl1.Sheriff.Equip(v1)
			Events.KnifeStabbed:FireServer()
			Events.HandleTouched:FireServer(v4)
			return
		end
	end
end

function tbl1.Murderer.NearestVictimRoot(arg1)
	local v4
	local v5

	for _, v1 in ipairs(tbl1.Murderer.Victims()) do
		local v2 = tbl1.Util.Root(v1)
		local v3 = v2 and (v2.Position - arg1).Magnitude

		if v3 and (not v5 or v3 < v5) then
			v4 = v2
			v5 = v3
		end
	end

	return v4
end

function tbl1.Sheriff.SyncAimHook()
	local v1 = State.Alive and (State.Opt.SilentAim or State.Opt.KnifeAim)
	if v1 and not State.Hook then
		tbl1.Util.Try(tbl1.Sheriff.InstallAimHook)
	elseif not v1 and State.Hook then
		local Hook = State.Hook
		State.Hook = nil
		tbl1.Util.Try(Hook)
	end
end

function tbl1.Sheriff.InstallAimHook()
	if not tbl1.Library.Compat.Has({"Namecall", "CheckCaller"}) then
		return
	end

	local v3

	local v1, v2 = tbl1.Library.Compat.HookMeta(game, "__namecall", function(arg1, ...)
		if not State.Alive or getnamecallmethod() ~= "FireServer" or checkcaller() then
			return v3(arg1, ...)
		end

		local Parent = arg1.Parent
		local Opt = State.Opt

		if Opt.SilentAim and arg1.Name == "Shoot" and Parent and Parent.Name == "Gun" then
			local v1 = tbl1.Round.FindByRole("Murderer")
			local v2 = v1 and tbl1.Util.Root(v1)

			if v2 then
				return v3(arg1, (...), v2.CFrame)
			end
		elseif Opt.KnifeAim and arg1.Name == "KnifeThrown" and Parent then
			if Parent.Name == "Events" then
				local v4 = (...)
				local v5 = tbl1.Murderer.NearestVictimRoot(v4.Position)

				if v5 then
					return v3(arg1, v4, v5.Position)
				end
			end
		end

		return v3(arg1, ...)
	end)

	v3 = v1
	State.Hook = v2
end

function tbl1.Survive.SafestSpot(arg1)
	local v1 = tbl1.Round.Map()
	local v3
	local v4

	for _, v2 in ipairs(v1 and v1.CoinContainer:GetChildren() or {}) do
		if v2:IsA("BasePart") then
			local Magnitude = (v2.Position - arg1).Magnitude
			if not v4 or Magnitude > v4 then
				v3 = v2
				v4 = Magnitude
			end
		end
	end

	return v3 and CFrame.new(v3.Position + Vector3.new(0, 3, 0))
end

function tbl1.Survive.DodgeStep()
	local v1 = tbl1.Util.Root()
	local v2 = tbl1.Round.FindByRole("Murderer")
	local v3 = v2 and tbl1.Util.Root(v2)

	if not State.Opt.AutoDodge or not v1 or not v3 or tbl1.Murderer.Knife() or tbl1.Util.Busy() then
		return
	end

	if os.clock() - State.LastDodge < Config.DodgeCooldown or (v3.Position - v1.Position).Magnitude > Config.DodgeRange then
		return
	end

	local v4 = tbl1.Survive.SafestSpot(v3.Position)

	if v4 then
		State.LastDodge = os.clock()
		v1.CFrame = v4
		v1.AssemblyLinearVelocity = Vector3.zero
	end
end

function tbl1.Kaitun.Step()
	if not State.Opt.Kaitun or not tbl1.Round.IAmPlaying() then
		return
	end

	local Opt = State.Opt
	Opt.AutoKillAll = tbl1.Murderer.Knife() ~= nil
	Opt.AutoShoot = tbl1.Sheriff.Gun() ~= nil
	Opt.AutoGrabGun = true
	Opt.AutoDodge = true
	Opt.AutoFarm = true
end

function tbl1.Farm.NearestCoin(arg1, arg2)
	local v1 = not tbl1.Murderer.Knife() and tbl1.Round.FindByRole("Murderer")
	local v2 = v1 and tbl1.Util.Root(v1)
	local v6
	local v7

	for _, child in ipairs(arg1.CoinContainer:GetChildren()) do
		local CoinVisual = child:FindFirstChild("CoinVisual")
		local v3 = State.SkippedCoins[child]
		local v4 = v3 and os.clock() - v3 < Config.FarmSkipTime
		local v5 = v2 and (child.Position - v2.Position).Magnitude < Config.FarmMurdererRadius

		if child:IsA("BasePart") and CoinVisual and not CoinVisual:GetAttribute("Collected") and not v4 and not v5 then
			local Magnitude = (child.Position - arg2).Magnitude
			if not v7 or Magnitude < v7 then
				v6 = child
				v7 = Magnitude
			end
		end
	end

	return v6
end

function tbl1.Farm.BagFull()
	return State.Bag.Max > 0 and State.Bag.Current >= State.Bag.Max
end

function tbl1.Farm.CanRun()
	return State.Alive and State.Opt.AutoFarm and tbl1.Round.IAmPlaying() and not tbl1.Farm.BagFull()
end

function tbl1.Farm.AttachMover(parent)
	local attachment = Instance.new("Attachment")
	attachment.Parent = parent
	local linearVelocity = Instance.new("LinearVelocity")
	linearVelocity.Attachment0 = attachment
	linearVelocity.MaxForce = math.huge
	linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
	linearVelocity.VectorVelocity = Vector3.zero
	linearVelocity.Parent = parent
	State.FarmMover = {Attachment = attachment, Velocity = linearVelocity}
	return linearVelocity
end

function tbl1.Farm.DetachMover()
	local FarmMover = State.FarmMover
	if FarmMover then
		FarmMover.Velocity:Destroy()
		FarmMover.Attachment:Destroy()
		State.FarmMover = nil
	end
end

function tbl1.Farm.GlideTo(arg1)
	local v1 = tbl1.Util.Root()
	local FarmMover = State.FarmMover

	if not v1 or not FarmMover or FarmMover.Velocity.Parent ~= v1 then
		tbl1.Farm.DetachMover()
		FarmMover = v1 and {Velocity = tbl1.Farm.AttachMover(v1)}
	end

	while FarmMover and tbl1.Farm.CanRun() and v1.Parent do
		local v2 = arg1 - v1.Position

		if v2.Magnitude <= Config.FarmArrive then
			break
		end

		FarmMover.Velocity.VectorVelocity = v2.Unit * math.min(State.Opt.FarmSpeed, v2.Magnitude * Config.FarmBrake)
		RunService.Heartbeat:Wait()
	end

	if FarmMover then
		FarmMover.Velocity.VectorVelocity = Vector3.zero
	end
end

function tbl1.Farm.Run()
	local v1 = tbl1.Util.Root()

	if v1 then
		tbl1.Farm.AttachMover(v1)
	end

	tbl1.Movement.RefreshNoclip()
	State.FarmHome = v1 and v1.CFrame

	while tbl1.Farm.CanRun() do
		local v2 = tbl1.Round.Map()
		local v3 = tbl1.Util.Root()
		local v4 = v2 and v3 and tbl1.Farm.NearestCoin(v2, v3.Position)

		if v4 and not tbl1.Util.Busy() then
			tbl1.Farm.GlideTo(v4.Position)
			task.wait(Config.FarmSettle)
			State.SkippedCoins[v4] = os.clock()
		else
			local FarmMover = State.FarmMover

			if FarmMover then
				FarmMover.Velocity.VectorVelocity = Vector3.zero
			end

			task.wait(Config.FarmIdleWait)
		end
	end
end

function tbl1.Farm.Settle()
	local v1 = tbl1.Util.Root()
	local FarmHome = State.FarmHome
	State.FarmHome = nil

	if not v1 then
		return
	end

	v1.AssemblyLinearVelocity = Vector3.zero
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}

	if workspace:Raycast(
		v1.Position + Vector3.new(0, Config.FarmGroundLift, 0),
		Vector3.new(0, -Config.FarmGroundReach, 0),
		raycastParams
	) or not FarmHome then
		return
	end

	v1.CFrame = FarmHome
end

function tbl1.Farm.Step()
	if State.FarmBusy or not tbl1.Farm.CanRun() then
		return
	end

	State.FarmBusy = true

	task.spawn(function()
		local v1 = tbl1.Util.Try(tbl1.Farm.Run)
		tbl1.Farm.DetachMover()
		tbl1.Farm.Settle()
		State.FarmBusy = false
		tbl1.Movement.RefreshNoclip()
		local v2 = tbl1.Util.Humanoid()

		if v1 and v2 and State.Opt.ResetWhenFull and tbl1.Farm.BagFull() then
			v2.Health = 0
		end
	end)
end

function tbl1.Farm.InitBagTracking()
	if GameLib.CoinCollected then
		tbl1.Util.Connect(GameLib.CoinCollected.OnClientEvent, function(_, arg2, arg3)
			State.Bag.Current = tonumber(arg2) or 0
			State.Bag.Max = tonumber(arg3) or 0
		end)
	end

	if GameLib.CoinsStarted then
		tbl1.Util.Connect(GameLib.CoinsStarted.OnClientEvent, function()
			local Bag = State.Bag
			State.Bag.Current = 0
			Bag.Max = 0
			table.clear(State.SkippedCoins)
		end)
	end

	if not GameLib.RoundStart then
		return
	end

	tbl1.Util.Connect(GameLib.RoundStart.OnClientEvent, function()
		local Bag = State.Bag
		State.Bag.Current = 0
		Bag.Max = 0
		table.clear(State.Roles)
	end)
end

function tbl1.Movement.AntiFlingStep()
	if not State.Opt.AntiFling then
		return
	end

	for _, player in ipairs(Players:GetPlayers()) do
		local v1 = player ~= LocalPlayer and player.Character
		if v1 then
			for _, child in ipairs(v1:GetChildren()) do
				if child:IsA("BasePart") then
					child.CanCollide = false
				end
			end
		end
	end

	local v2 = tbl1.Util.Root()

	if
		v2
		and not tbl1.Util.Busy()
		and not State.Opt.Fly
		and v2.AssemblyLinearVelocity.Magnitude > Config.FlingVelocityCap
	then
		v2.AssemblyLinearVelocity = Vector3.zero
		v2.AssemblyAngularVelocity = Vector3.zero
	end
end

function tbl1.Aim.Target()
	if tbl1.Murderer.Knife() then
		return tbl1.Murderer.Victims()[1]
	end
	return tbl1.Round.FindByRole("Murderer")
end

function tbl1.Aim.Step(arg1)
	if not State.Opt.Aimbot then
		return
	end

	local v1 = tbl1.Aim.Target()

	if v1 and v1.Character then
		local Head = v1.Character:FindFirstChild("Head")
		if Head then
			local CurrentCamera = workspace.CurrentCamera
			local v2 = CFrame.lookAt(CurrentCamera.CFrame.Position, Head.Position)
			local v3 = 1 - (State.Opt.AimSmooth / 100) ^ (arg1 * 60)
			CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(v2, math.clamp(v3, 0, 1))
			return
		end
	end
end

function tbl1.Visual.ClearXRay()
	for k, xRayPart in pairs(State.XRayParts) do
		if k.Parent then
			k.Transparency = xRayPart
		end
	end

	table.clear(State.XRayParts)
	State.XRayMap = nil
end

function tbl1.Visual.XRayStep()
	if not State.Opt.XRay then
		if State.XRayMap then
			tbl1.Visual.ClearXRay()
		end
		return
	end

	local v1 = tbl1.Round.Map() or tbl1.Round.Lobby()

	if not v1 or State.XRayMap == v1 then
		return
	end

	tbl1.Visual.ClearXRay()
	State.XRayMap = v1
	local CoinContainer = v1:FindFirstChild("CoinContainer")

	for _, descendant in ipairs(v1:GetDescendants()) do
		if descendant:IsA("BasePart") and not (CoinContainer and descendant:IsDescendantOf(CoinContainer)) then
			State.XRayParts[descendant] = descendant.Transparency
			descendant.Transparency = math.max(descendant.Transparency, Config.XRayTransparency)
		end
	end
end

function tbl1.Skin.MeshOf(arg1)
	local v1 = arg1 and arg1:FindFirstChild("Handle")
	return v1 and v1:FindFirstChildWhichIsA("SpecialMesh")
end

function tbl1.Skin.Copy(name, arg2)
	local v1 = name and Players:FindFirstChild(name)
	local v2 = v1 and tbl1.Skin.MeshOf(tbl1.Util.Tool(v1, arg2))

	if not v2 then
		return false
	end

	State.Skins[arg2] = {MeshId = v2.MeshId, TextureId = v2.TextureId, Scale = v2.Scale}
	return true
end

function tbl1.Skin.ApplyStep()
	for k, skin in pairs(State.Skins) do
		local v1 = tbl1.Skin.MeshOf(tbl1.Util.Tool(LocalPlayer, k))
		if v1 and v1.MeshId ~= skin.MeshId then
			local TextureId = skin.TextureId
			local Scale = skin.Scale
			v1.MeshId = skin.MeshId
			v1.TextureId = TextureId
			v1.Scale = Scale
		end
	end
end

function tbl1.Troll.Target()
	return State.Opt.TrollTarget and Players:FindFirstChild(State.Opt.TrollTarget)
end

function tbl1.Troll.Fling(arg1)
	local v1 = tbl1.Util.Root()
	local v2 = tbl1.Util.Root(arg1)

	if not v1 or not v2 or tbl1.Util.Busy() then
		return false
	end

	tbl1.Util.SetBusy(true)
	local CFrame1 = v1.CFrame
	local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
	bodyAngularVelocity.MaxTorque = Vector3.one * math.huge
	bodyAngularVelocity.AngularVelocity = Vector3.new(0, Config.FlingForce, 0)
	bodyAngularVelocity.Parent = v1
	tbl1.Movement.SetNoclip(true)
	local v3 = os.clock()

	while os.clock() - v3 < Config.FlingTime do
		local v4 = tbl1.Util.Root(arg1)

		if not v4 or not v1.Parent then
			break
		end

		v1.CFrame = v4.CFrame
		v1.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		RunService.Heartbeat:Wait()
	end

	bodyAngularVelocity:Destroy()

	if v1.Parent then
		v1.AssemblyAngularVelocity = Vector3.zero
		v1.AssemblyLinearVelocity = Vector3.zero
		v1.CFrame = CFrame1
	end

	tbl1.Util.SetBusy(false)
	tbl1.Movement.RefreshNoclip()
	return true
end

function tbl1.Troll.Spectate(arg1)
	local v1 = arg1 and tbl1.Util.Humanoid(arg1) or tbl1.Util.Humanoid()
	if v1 then
		workspace.CurrentCamera.CameraSubject = v1
	end
end

function tbl1.Troll.StickStep()
	local v1 = State.StickTarget and Players:FindFirstChild(State.StickTarget)
	local v2 = tbl1.Util.Root()
	local v3 = v1 and tbl1.Util.Root(v1)

	if v2 and v3 and not tbl1.Util.Busy() then
		v2.CFrame = v3.CFrame * CFrame.new(0, 0, 2)
	end
end

function tbl1.Teleport.To(arg1)
	local v1 = tbl1.Util.Root()

	if v1 and arg1 then
		v1.CFrame = arg1 + Vector3.new(0, 3, 0)
		return true
	end

	return false
end

function tbl1.Teleport.ToPlayer(name)
	local v1 = name and Players:FindFirstChild(name)
	local v2 = v1 and tbl1.Util.Root(v1)
	return tbl1.Teleport.To(v2 and v2.CFrame)
end

function tbl1.Teleport.ToLobby()
	local v1 = tbl1.Round.Lobby()
	local v2 = v1 and (v1:FindFirstChild("Spawns", true) or v1:FindFirstChildWhichIsA("SpawnLocation", true))
	local v3 = v2 and (v2:IsA("BasePart") and v2 or v2:FindFirstChildWhichIsA("BasePart"))

	if not v3 and v1 then
		v3 = v1:FindFirstChildWhichIsA("BasePart", true)
	end

	return tbl1.Teleport.To(v3 and v3.CFrame)
end

function tbl1.Teleport.ToMap()
	local v1 = tbl1.Round.Map()
	local v2 = v1 and v1:FindFirstChild("Spawns")
	local v3 = v2 and v2:FindFirstChildWhichIsA("BasePart") or v1 and v1.CoinContainer:FindFirstChildWhichIsA("BasePart")
	return tbl1.Teleport.To(v3 and v3.CFrame)
end

function tbl1.Esp.Init()
	tbl1.Esp.Folder = Instance.new("Folder")
	tbl1.Esp.Folder.Name = HttpService:GenerateGUID(false)
	tbl1.Util.Mount(tbl1.Esp.Folder)
end

function tbl1.Esp.MakeHighlight(adornee, fillColor)
	local highlight = Instance.new("Highlight")
	highlight.FillColor = fillColor
	highlight.OutlineColor = fillColor
	highlight.FillTransparency = 0.65
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Adornee = adornee
	highlight.Parent = tbl1.Esp.Folder
	return highlight
end

function tbl1.Esp.MakeLabel(adornee, textColor3)
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Size = UDim2.fromOffset(180, 36)
	billboardGui.StudsOffset = Vector3.new(0, 3.5, 0)
	billboardGui.AlwaysOnTop = true
	billboardGui.Adornee = adornee
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.fromScale(1, 1)
	textLabel.BackgroundTransparency = 1
	textLabel.TextColor3 = textColor3
	textLabel.TextStrokeTransparency = 0.4
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 13
	textLabel.Parent = billboardGui
	billboardGui.Parent = tbl1.Esp.Folder
	return billboardGui, textLabel
end

function tbl1.Esp.DropEntry(arg1)
	if arg1 then
		arg1.Highlight:Destroy()
		arg1.Gui:Destroy()
	end
end

function tbl1.Esp.RefreshPlayers()
	local Players1 = State.Esp.Players
	local v1 = tbl1.Util.Root()

	for _, player in ipairs(Players:GetPlayers()) do
		local Character = player.Character
		local v2 = tbl1.Util.Root(player)
		local v3 = Players1[player]
		local v4 = tbl1.Round.RoleOf(player)

		if State.Opt.EspPlayers and player ~= LocalPlayer and Character and v2 and v4 ~= "Dead" then
			if not v3 or v3.Character ~= Character then
				tbl1.Esp.DropEntry(v3)
				local v5, v6 = tbl1.Esp.MakeLabel(v2, Color3.new(1, 1, 1))

				local tbl = {
					Character = Character,
					Highlight = tbl1.Esp.MakeHighlight(Character, Color3.new(1, 1, 1)),
					Gui = v5,
					Label = v6,
				}

				v3 = tbl
				Players1[player] = tbl
			end

			local v7 = Config.Colors[v4] or Config.Colors.Innocent
			local v8 = v1 and math.floor((v2.Position - v1.Position).Magnitude) or 0
			local Highlight = v3.Highlight
			local Label = v3.Label
			v3.Highlight.FillColor = v7
			Highlight.OutlineColor = v7
			Label.TextColor3 = v7
			v3.Label.Text = string.format("%s [%s] %dm", player.DisplayName, v4, v8)
		else
			tbl1.Esp.DropEntry(v3)
			Players1[player] = nil
		end
	end

	for k, v9 in pairs(Players1) do
		if not k.Parent then
			tbl1.Esp.DropEntry(v9)
			Players1[k] = nil
		end
	end
end

function tbl1.Esp.RefreshGun()
	local v1 = State.Opt.EspGun and tbl1.Round.GunDrop()
	local Gun = State.Esp.Gun

	if Gun and Gun.Adornee == v1 then
		return
	end

	tbl1.Esp.DropEntry(Gun)
	State.Esp.Gun = nil

	if v1 then
		local v2, v3 = tbl1.Esp.MakeLabel(v1, Config.Colors.Gun)
		v3.Text = "GUN DROP"
		State.Esp.Gun = {Adornee = v1, Highlight = tbl1.Esp.MakeHighlight(v1, Config.Colors.Gun), Gui = v2}
	end
end

function tbl1.Esp.Destroy()
	if tbl1.Esp.Folder then
		tbl1.Esp.Folder:Destroy()
	end

	table.clear(State.Esp.Players)
	State.Esp.Gun = nil
end

function tbl1.Visual.SetFullbright(arg1)
	if arg1 and not State.LightingDefaults then
		State.LightingDefaults = {
			Ambient = Lighting.Ambient,
			Brightness = Lighting.Brightness,
			ClockTime = Lighting.ClockTime,
			FogEnd = Lighting.FogEnd,
			GlobalShadows = Lighting.GlobalShadows,
		}

		Lighting.Ambient = Color3.new(1, 1, 1)
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 1000000000
		Lighting.GlobalShadows = false
	elseif not arg1 and State.LightingDefaults then
		for k, lightingDefault in pairs(State.LightingDefaults) do
			Lighting[k] = lightingDefault
		end
		State.LightingDefaults = nil
	end
end

function tbl1.Session.RedeemCode(arg1)
	local RedeemCode = GameLib.RedeemCode

	if not RedeemCode then
		return "The code box was not found in this game version"
	end

	local ok, result = pcall(RedeemCode.InvokeServer, RedeemCode, arg1)
	return ok and tostring(result) or "Request failed"
end

function tbl1.Session.Rejoin()
	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end

function tbl1.Session.Hop()
	local v1 = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100", game.PlaceId)
	local v2 = tbl1.Util.HttpGet(v1)
	local ok, result = pcall(HttpService.JSONDecode, HttpService, v2 or "")

	if ok then
		if type(result) == "table" then
			for _, v3 in ipairs(result.data or {}) do
				if v3.id ~= game.JobId and v3.playing < v3.maxPlayers then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, v3.id, LocalPlayer)
					return
				end
			end
			return
		end
	end
end

function tbl1.Session.InitAntiAfk()
	tbl1.Util.Connect(LocalPlayer.Idled, function()
		if State.Opt.AntiAfk then
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end
	end)
end

function tbl1.Session.InitRoleNotify(arg1)
	if not GameLib.RoundStart then
		return
	end
	tbl1.Util.Connect(GameLib.RoundStart.OnClientEvent, function()
		task.wait(2)
		State.LastRoleFetch = 0
		tbl1.Round.RefreshRoles()

		if not State.Opt.RoleNotify then
			return
		end

		local v1 = tbl1.Round.FindByRole("Murderer")
		local v2 = tbl1.Round.FindByRole("Sheriff")

		arg1(string.format(
			"Murderer: %s | Sheriff: %s | You: %s",
			v1 and v1.Name or "?",
			v2 and v2.Name or "?",
			tbl1.Round.RoleOf(LocalPlayer)
		))
	end)
end

tbl1.Scheduler.Jobs = {
	Tick = {
		{"Roles", tbl1.Round.RefreshRoles},
		{"Auto Win", tbl1.Kaitun.Step, "Kaitun"},
		{"Auto Farm", tbl1.Farm.Step, "AutoFarm"},
		{"X-Ray", tbl1.Visual.XRayStep, "XRay"},
		{"Skins", tbl1.Skin.ApplyStep},
		{"Movement", tbl1.Movement.Apply, {"SpeedOn", "JumpOn"}},
		{"Auto Grab Gun", tbl1.Sheriff.AutoGrabStep, "AutoGrabGun"},
		{"Auto Shoot", tbl1.Sheriff.AutoShootStep, "AutoShoot"},
		{"Auto Kill All", tbl1.Murderer.AutoKillStep, "AutoKillAll"},
		{"Role ESP", tbl1.Esp.RefreshPlayers, "EspPlayers"},
		{"Gun ESP", tbl1.Esp.RefreshGun, "EspGun"},
	},
	Stepped = {{"Anti Fling", tbl1.Movement.AntiFlingStep, "AntiFling"}},
	Render = {{"Aimbot", tbl1.Aim.Step, "Aimbot"}},
	Heartbeat = {
		{"Kill Aura", tbl1.Murderer.KillAuraStep, "KillAura"},
		{"Auto Dodge", tbl1.Survive.DodgeStep, "AutoDodge"},
		{"Stick To Player", tbl1.Troll.StickStep, "StickTo"},
	},
}

function tbl1.Scheduler.OnToggles(arg1)
	local tbl = {}

	if not tbl1.Library or arg1[3] == nil then
		return tbl
	end

	for _, v1 in ipairs(type(arg1[3]) == "table" and arg1[3] or {arg1[3]}) do
		local v2 = tbl1.Library.Toggles[v1]
		if v2 and v2.Value then
			tbl[#tbl + 1] = v2
		end
	end

	return tbl
end

function tbl1.Scheduler.Halt(arg1, arg2)
	local v1 = tostring(arg2):match("^[^\n]*")
	arg1.Streak = nil

	if #tbl1.Scheduler.OnToggles(arg1) == 0 then
		arg1.Stopped = true
		warn("[eter hub] " .. arg1[1] .. " paused until turned on:", v1)
		return
	end

	arg1.Halting = true
	warn("[eter hub] " .. arg1[1] .. " stopped:", v1)
	table.insert(State.Halted, {arg1, v1})
end

function tbl1.Scheduler.Run(arg1, ...)
	if arg1.Halting then
		return
	end

	if arg1.Stopped then
		if #tbl1.Scheduler.OnToggles(arg1) == 0 then
			return
		end
		arg1.Stopped = nil
	end

	local ok, result = pcall(arg1[2], ...)

	if ok then
		arg1.Streak = nil
		return
	end

	local Streak = arg1.Streak

	if not Streak then
		local tbl = {count = 0, since = os.clock()}
		Streak = tbl
		arg1.Streak = tbl
		warn("[eter hub] " .. arg1[1] .. ":", result)
	end

	Streak.count = Streak.count + 1

	if arg1[3] == nil or Streak.count < Config.JobFailLimit or os.clock() - Streak.since < Config.JobFailWindow then
		return
	end

	tbl1.Scheduler.Halt(arg1, result)
end

function tbl1.Scheduler.RunLane(arg1, ...)
	for _, v1 in ipairs(tbl1.Scheduler.Jobs[arg1]) do
		tbl1.Scheduler.Run(v1, ...)
	end
end

function tbl1.Scheduler.Boot(arg1)
	tbl1.Esp.Init()
	tbl1.Farm.InitBagTracking()

	tbl1.Util.Connect(RunService.Stepped, function()
		tbl1.Scheduler.RunLane("Stepped")
	end)

	tbl1.Movement.InitInfJump()
	tbl1.Session.InitAntiAfk()
	tbl1.Session.InitRoleNotify(arg1)

	tbl1.Util.Connect(RunService.RenderStepped, function(arg1)
		tbl1.Scheduler.RunLane("Render", arg1)
	end)

	tbl1.Util.Connect(RunService.Heartbeat, function()
		tbl1.Scheduler.RunLane("Heartbeat")
	end)

	task.spawn(function()
		while State.Alive do
			tbl1.Scheduler.RunLane("Tick")
			task.wait(Config.TickDelay)
		end
	end)
end

function tbl1.Scheduler.Stop()
	State.Alive = false
	getgenv().MurderMystery2Unload = nil
	tbl1.Sheriff.SyncAimHook()
	State.StickTarget = nil
	tbl1.Movement.SetFly(false)
	tbl1.Movement.SetNoclip(false)

	for _, conn in ipairs(State.Conns) do
		conn:Disconnect()
	end

	table.clear(State.Conns)

	if State.Opt.SpeedOn then
		tbl1.Movement.RestoreSpeed()
	end

	if State.Opt.JumpOn then
		tbl1.Movement.RestoreJump()
	end

	tbl1.Troll.Spectate(nil)
	tbl1.Visual.SetFullbright(false)
	tbl1.Visual.ClearXRay()
	tbl1.Farm.DetachMover()
	tbl1.Esp.Destroy()
end

local function func()
	local v1 = tbl1.Util.LoadLibrary()

	if not v1 then
		return false
	end

	tbl1.Library = v1
	pcall(tbl.Step, "UI Library")
	local Opt = State.Opt
	local tbl2 = {}

	local function func(arg1, arg2)
		v1:Notify("eter hub", arg1, 5, arg2 or "Info")
	end

	local function func1(arg1)
		local v2 = v1.Options[arg1]
		Opt[arg1] = v2 and v2.Value or nil
		return Opt[arg1]
	end

	local function func2(arg1)
		local combatTab = arg1:AddTab("Combat", "crosshair", "Sheriff and murderer tools")
		local LeftGroupbox = combatTab:AddLeftGroupbox("Sheriff / Hero")
		local tbl = {Text = "Silent Aim", Description = "Every shot you fire goes to the murderer", Default = false}
		local str = "SilentAim"

		function tbl.Callback(arg1)
			Opt[str] = arg1
			tbl1.Sheriff.SyncAimHook()
		end

		LeftGroupbox:AddToggle("SilentAim", tbl):AddKeyPicker("SilentAimKey", {Default = "None", Mode = "Toggle"})
		v1.Compat.NeedCap("SilentAim", {"Namecall", "CheckCaller"})

		local tbl2 = {
			Text = "Auto Shoot Murderer",
			Description = "Kills the murderer as soon as you hold the gun",
			Default = false,
			Risky = true,
		}

		local str1 = "AutoShoot"

		function tbl2.Callback(arg1)
			Opt[str1] = arg1
		end

		LeftGroupbox:AddToggle("AutoShoot", tbl2):AddKeyPicker("AutoShootKey", {Default = "None", Mode = "Toggle"})

		LeftGroupbox:AddButton({
			Text = "Shoot Murderer Now",
			Style = "Primary",
			Func = function()
				local v2, v3 = tbl1.Sheriff.ShootMurderer()
				local v4 = v2 and "Shot " .. tostring(v3) or tostring(v3 or "You need the gun")
				v1:Notify("eter hub", v4, 5, v2 and "Success" or "Warning" or "Info")
			end,
		})

		local tbl3 = {
			Text = "Auto Grab Gun",
			Description = "Picks up the dropped gun the moment the sheriff dies",
			Default = false,
		}

		local str2 = "AutoGrabGun"

		function tbl3.Callback(arg1)
			Opt[str2] = arg1
		end

		LeftGroupbox:AddToggle("AutoGrabGun", tbl3):AddKeyPicker("AutoGrabGunKey", {Default = "None", Mode = "Toggle"})

		LeftGroupbox:AddButton({
			Text = "Grab Gun Now",
			Func = function()
				local v2 = tbl1.Sheriff.GrabGun()
				v1:Notify(
					"eter hub",
					v2 and "Gun grabbed" or "No gun on the ground",
					5,
					v2 and "Success" or "Warning" or "Info"
				)
			end,
		})

		local murdererGroupbox = combatTab:AddRightGroupbox("Murderer")

		local tbl4 = {
			Text = "Auto Kill All",
			Description = "Ends the round by killing everyone when you are the murderer",
			Default = false,
			Risky = true,
		}

		local str3 = "AutoKillAll"

		function tbl4.Callback(arg1)
			Opt[str3] = arg1
		end

		murdererGroupbox:AddToggle("AutoKillAll", tbl4):AddKeyPicker("AutoKillAllKey", {Default = "None", Mode = "Toggle"})

		murdererGroupbox:AddButton({
			Text = "Kill All Now",
			Style = "Primary",
			Func = function()
				task.spawn(function()
					local v2, v3 = string.format("Killed %d players", tbl1.Murderer.KillAll())
					v1:Notify("eter hub", v2, 5, v3 or "Info")
				end)
			end,
		})

		local tbl5 = {
			Text = "Kill Aura",
			Description = "Kills anyone who gets close while you hold the knife",
			Default = false,
			Risky = true,
		}

		local str4 = "KillAura"

		function tbl5.Callback(arg1)
			Opt[str4] = arg1
		end

		murdererGroupbox:AddToggle("KillAura", tbl5):AddKeyPicker("KillAuraKey", {Default = "None", Mode = "Toggle"})
		local tbl6 = {Text = "Knife Throw Aim", Description = "Thrown knives fly to the nearest player", Default = false}
		local str5 = "KnifeAim"

		function tbl6.Callback(arg1)
			Opt[str5] = arg1
		end

		murdererGroupbox:AddToggle("KnifeAim", tbl6)
		v1.Compat.NeedCap("KnifeAim", {"Namecall", "CheckCaller"})
		local aimbotGroupbox = combatTab:AddRightGroupbox("Aimbot")

		local tbl7 = {
			Text = "Aimbot",
			Description = "Locks your camera on the murderer, or on the next victim when you hold the knife",
			Default = false,
		}

		local str6 = "Aimbot"

		function tbl7.Callback(arg1)
			Opt[str6] = arg1
		end

		aimbotGroupbox:AddToggle("Aimbot", tbl7):AddKeyPicker("AimbotKey", {Default = "Q", Mode = "Hold"})

		aimbotGroupbox:AddSlider("AimSmooth", {
			Text = "Smoothness",
			Min = 0,
			Max = 95,
			Default = Opt.AimSmooth,
			Rounding = 0,
			Suffix = "%",
			Callback = function(value)
				Opt.AimSmooth = tonumber(value) or 0
			end,
		})

		local autoPlayGroupbox = combatTab:AddLeftGroupbox("Auto Play")

		autoPlayGroupbox:AddToggle("Kaitun", {
			Text = "Auto Win",
			Description = "Plays every round for you in any role",
			Default = false,
			Risky = true,
			Callback = function(value)
				Opt.Kaitun = value

				if value then
					return
				end

				for _, v2 in ipairs({"AutoKillAll", "AutoShoot", "AutoGrabGun", "AutoDodge", "AutoFarm"}) do
					Opt[v2] = v1.Options[v2].Value
				end
			end,
		}):AddKeyPicker("KaitunKey", {Default = "None", Mode = "Toggle"})

		local tbl8 = {
			Text = "Auto Dodge Murderer",
			Description = "Escapes to the far side of the map when the murderer gets close",
			Default = false,
		}

		local str7 = "AutoDodge"

		function tbl8.Callback(arg1)
			Opt[str7] = arg1
		end

		autoPlayGroupbox:AddToggle("AutoDodge", tbl8):AddKeyPicker("AutoDodgeKey", {Default = "None", Mode = "Toggle"})
	end

	local function func3(arg1)
		local teleportTab = arg1:AddTab("Teleport", "globe", "Map, lobby and players")
		local placesGroupbox = teleportTab:AddLeftGroupbox("Places")
		placesGroupbox:AddButton({Text = "Lobby", Func = tbl1.Teleport.ToLobby}):AddButton({Text = "Map", Func = tbl1.Teleport.ToMap})

		placesGroupbox:AddButton({
			Text = "To Murderer",
			Func = function()
				local v1 = tbl1.Round.FindByRole("Murderer")
				tbl1.Teleport.ToPlayer(v1 and v1.Name)
			end,
		}):AddButton({
			Text = "To Sheriff",
			Func = function()
				local v1 = tbl1.Round.FindByRole("Sheriff")
				tbl1.Teleport.ToPlayer(v1 and v1.Name)
			end,
		})

		local playersGroupbox = teleportTab:AddRightGroupbox("Players")
		local tbl = {Text = "Player", SpecialType = "Player", Searchable = true}
		local str = "TeleportTarget"

		function tbl.Callback(arg1)
			Opt[str] = arg1
		end

		playersGroupbox:AddDropdown("TeleportTarget", tbl)

		playersGroupbox:AddButton({
			Text = "Teleport",
			Style = "Primary",
			Func = function()
				tbl1.Teleport.ToPlayer((func1("TeleportTarget")))
			end,
		})
	end

	local function func4(arg1)
		local trollTab = arg1:AddTab("Troll", "zap", "Fling, stick and spectate")
		local targetGroupbox = trollTab:AddLeftGroupbox("Target")

		targetGroupbox:AddDropdown("TrollTarget", {
			Text = "Player",
			SpecialType = "Player",
			Searchable = true,
			Callback = function(value)
				Opt.TrollTarget = value
				local StickTo = v1.Options.StickTo
				local Spectate = v1.Options.Spectate

				if StickTo and StickTo.Value then
					State.StickTarget = value
				end

				if Spectate and Spectate.Value then
					tbl1.Troll.Spectate(tbl1.Troll.Target())
				end
			end,
		})

		targetGroupbox:AddButton({
			Text = "Fling",
			Style = "Primary",
			Func = function()
				func1("TrollTarget")
				local v1 = tbl1.Troll.Target()

				if v1 then
					task.spawn(tbl1.Troll.Fling, v1)
				end
			end,
		}):AddButton({
			Text = "Fling Murderer",
			Func = function()
				local v1 = tbl1.Round.FindByRole("Murderer")
				if v1 then
					task.spawn(tbl1.Troll.Fling, v1)
				end
			end,
		})

		targetGroupbox:AddButton({
			Text = "Fling Everyone",
			Style = "Warning",
			DoubleClick = true,
			Func = function()
				task.spawn(function()
					for _, player in ipairs(Players:GetPlayers()) do
						if player ~= LocalPlayer and tbl1.Util.Root(player) then
							tbl1.Troll.Fling(player)
						end
					end
				end)
			end,
		})

		local followGroupbox = trollTab:AddRightGroupbox("Follow")

		followGroupbox:AddToggle("StickTo", {
			Text = "Stick To Player",
			Description = "Stays glued right behind the selected player",
			Default = false,
			Callback = function(value)
				State.StickTarget = value and func1("TrollTarget") or nil
			end,
		})

		followGroupbox:AddToggle("Spectate", {
			Text = "Spectate",
			Default = false,
			Callback = function(value)
				func1("TrollTarget")
				tbl1.Troll.Spectate(value and tbl1.Troll.Target() or nil)
			end,
		})
	end

	local function func5(arg1)
		local playerTab = arg1:AddTab("Player", "user", "Movement")
		local movementGroupbox = playerTab:AddLeftGroupbox("Movement")

		movementGroupbox:AddToggle("SpeedOn", {
			Text = "Walk Speed",
			Default = false,
			Callback = function(value)
				Opt.SpeedOn = value
				if not value then
					tbl1.Movement.RestoreSpeed()
				end
			end,
		})

		movementGroupbox:AddSlider("WalkSpeed", {
			Text = "Speed",
			Min = 16,
			Max = 120,
			Default = Opt.WalkSpeed,
			Rounding = 0,
			Callback = function(value)
				Opt.WalkSpeed = tonumber(value) or Config.SpeedDefault
			end,
		})

		movementGroupbox:AddToggle("JumpOn", {
			Text = "Jump Power",
			Default = false,
			Callback = function(value)
				Opt.JumpOn = value
				if not value then
					tbl1.Movement.RestoreJump()
				end
			end,
		})

		movementGroupbox:AddSlider("JumpPower", {
			Text = "Power",
			Min = 50,
			Max = 200,
			Default = Opt.JumpPower,
			Rounding = 0,
			Callback = function(value)
				Opt.JumpPower = tonumber(value) or Config.JumpDefault
			end,
		})

		local extraGroupbox = playerTab:AddRightGroupbox("Extra")
		local tbl = {Text = "Anti Fling", Description = "Other players cannot push or launch you", Default = false}
		local str = "AntiFling"

		function tbl.Callback(arg1)
			Opt[str] = arg1
		end

		extraGroupbox:AddToggle("AntiFling", tbl)
		local tbl2 = {Text = "Infinite Jump", Default = false}
		local str1 = "InfJump"

		function tbl2.Callback(arg1)
			Opt[str1] = arg1
		end

		extraGroupbox:AddToggle("InfJump", tbl2)

		extraGroupbox:AddToggle("Noclip", {
			Text = "Noclip",
			Default = false,
			Callback = function(value)
				Opt.Noclip = value
				tbl1.Movement.RefreshNoclip()
			end,
		}):AddKeyPicker("NoclipKey", {Default = "None", Mode = "Toggle"})

		extraGroupbox:AddToggle("Fly", {
			Text = "Fly",
			Description = "Space to go up, Left Ctrl to go down",
			Default = false,
			Callback = function(value)
				Opt.Fly = value
				tbl1.Movement.SetFly(value)
			end,
		}):AddKeyPicker("FlyKey", {Default = "None", Mode = "Toggle"})
	end

	local function func6(arg1)
		local visualsTab = arg1:AddTab("Visuals", "eye", "Roles and gun")
		local espGroupbox = visualsTab:AddLeftGroupbox("ESP")

		local tbl = {
			Text = "Role ESP",
			Description = "Murderer red, sheriff blue, hero yellow, innocents green",
			Default = false,
		}

		local str = "EspPlayers"

		function tbl.Callback(arg1)
			Opt[str] = arg1
		end

		espGroupbox:AddToggle("EspPlayers", tbl)
		local tbl2 = {Text = "Gun Drop ESP", Default = false}
		local str1 = "EspGun"

		function tbl2.Callback(arg1)
			Opt[str1] = arg1
		end

		espGroupbox:AddToggle("EspGun", tbl2)

		local tbl3 = {
			Text = "Role Notify",
			Description = "Tells you who the murderer and sheriff are at round start",
			Default = false,
		}

		local str2 = "RoleNotify"

		function tbl3.Callback(arg1)
			Opt[str2] = arg1
		end

		espGroupbox:AddToggle("RoleNotify", tbl3)
		local worldGroupbox = visualsTab:AddRightGroupbox("World")
		local tbl4 = {Text = "X-Ray", Description = "See through walls on every map", Default = false}
		local str3 = "XRay"

		function tbl4.Callback(arg1)
			Opt[str3] = arg1
		end

		worldGroupbox:AddToggle("XRay", tbl4)

		worldGroupbox:AddToggle("Fullbright", {
			Text = "Fullbright",
			Default = false,
			Callback = function(value)
				Opt.Fullbright = value
				tbl1.Visual.SetFullbright(value)
			end,
		})

		local skinsGroupbox = visualsTab:AddRightGroupbox("Skins")
		local tbl5 = {Text = "Copy From", SpecialType = "Player", Searchable = true}
		local str4 = "SkinSource"

		function tbl5.Callback(arg1)
			Opt[str4] = arg1
		end

		skinsGroupbox:AddDropdown("SkinSource", tbl5)

		skinsGroupbox:AddButton({
			Text = "Copy Knife",
			Style = "Primary",
			Func = function()
				local v2 = tbl1.Skin.Copy(func1("SkinSource"), "Knife")
				v1:Notify(
					"eter hub",
					v2 and "Knife skin applied" or "That player has no knife loaded",
					5,
					v2 and "Success" or "Warning" or "Info"
				)
			end,
		}):AddButton({
			Text = "Copy Gun",
			Func = function()
				local v2 = tbl1.Skin.Copy(func1("SkinSource"), "Gun")
				v1:Notify(
					"eter hub",
					v2 and "Gun skin applied" or "That player has no gun loaded",
					5,
					v2 and "Success" or "Warning" or "Info"
				)
			end,
		})

		skinsGroupbox:AddButton({
			Text = "Reset Skins",
			Func = function()
				table.clear(State.Skins)
			end,
		})
	end

	local function func7(arg1)
		local farmTab = arg1:AddTab("Farm", "cookie", "Coins every round")
		local coinFarmGroupbox = farmTab:AddLeftGroupbox("Coin Farm")

		local tbl = {
			Text = "Auto Farm Coins",
			Description = "Glides smoothly to every coin until your bag is full and stays away from the murderer",
			Default = false,
		}

		local str = "AutoFarm"

		function tbl.Callback(arg1)
			Opt[str] = arg1
		end

		coinFarmGroupbox:AddToggle("AutoFarm", tbl):AddKeyPicker("AutoFarmKey", {Default = "None", Mode = "Toggle"})

		coinFarmGroupbox:AddSlider("FarmSpeed", {
			Text = "Farm Speed",
			Min = 16,
			Max = Config.FarmSpeedMax,
			Default = Config.FarmSpeed,
			Rounding = 0,
			Callback = function(value)
				Opt.FarmSpeed = tonumber(value) or Config.FarmSpeed
			end,
		})

		local tbl1 = {
			Text = "Reset When Bag Full",
			Description = "Respawns after the bag fills so the murderer cannot catch you",
			Default = false,
		}

		local str1 = "ResetWhenFull"

		function tbl1.Callback(arg1)
			Opt[str1] = arg1
		end

		coinFarmGroupbox:AddToggle("ResetWhenFull", tbl1)
		tbl2.Bag = coinFarmGroupbox:AddProgressBar("StatusBag", {Text = "Coin Bag", Max = 1, Default = 0})
		local aerisInfoGroupbox = farmTab:AddRightGroupbox("eter hub Info", "bell")
		local v1 = math.min(2, #Config.UpdateLog)

		for i = 1, v1 do
			local v2 = Config.UpdateLog[i]
			aerisInfoGroupbox:AddParagraph({Title = v2[1], Content = v2[2]})
		end

		local roundGroupbox = farmTab:AddRightGroupbox("Round")
		tbl2.Role = roundGroupbox:AddLabel("You: -")
		tbl2.Murderer = roundGroupbox:AddLabel("Murderer: ?")
		tbl2.Sheriff = roundGroupbox:AddLabel("Sheriff: ?")
		tbl2.BagCount = roundGroupbox:AddLabel("Bag: 0 / 0")
	end

	local function func8(arg1)
		local miscTab = arg1:AddTab("Misc", "sliders-horizontal", "Session tools")
		local sessionGroupbox = miscTab:AddLeftGroupbox("Session")
		local tbl = {Text = "Anti AFK", Default = false}
		local str = "AntiAfk"

		function tbl.Callback(arg1)
			Opt[str] = arg1
		end

		sessionGroupbox:AddToggle("AntiAfk", tbl)
		sessionGroupbox:AddButton({Text = "Rejoin", DoubleClick = true, Func = tbl1.Session.Rejoin}):AddButton({Text = "Server Hop", DoubleClick = true, Func = tbl1.Session.Hop})

		sessionGroupbox:AddButton({
			Text = "Panic - All Off",
			Style = "Danger",
			Func = function()
				for _, toggle in pairs(v1.Toggles) do
					if toggle.Value == true then
						toggle:SetValue(false)
					end
				end
			end,
		})

		local codesGroupbox = miscTab:AddRightGroupbox("Codes")
		local str1 = ""

		codesGroupbox:AddInput("RedeemCodeInput", {
			Text = "Code",
			Default = "",
			Placeholder = "Enter code",
			NoSave = true,
			Callback = function(value)
				str1 = value
			end,
		})

		codesGroupbox:AddButton({
			Text = "Redeem",
			Style = "Primary",
			Func = function()
				if str1 == "" then
					return
				end

				local v2, v3 = tbl1.Session.RedeemCode(str1)
				v1:Notify("eter hub", v2, 5, v3 or "Info")
			end,
		})
	end

	local function func9()
		while #State.Halted > 0 do
			local v2 = table.remove(State.Halted, 1)
			local v3 = v2[1]

			for _, v4 in ipairs(tbl1.Scheduler.OnToggles(v3)) do
				v4:SetValue(false)
			end

			v3.Halting = nil
			v1:Notify("eter hub", v3[1] .. " stopped: " .. v2[2], 5, "Warning")
		end
	end

	local tbl3 = {}

	local function func10(arg1, arg2)
		if tbl3[arg1] == arg2 or not tbl2[arg1] then
			return
		end

		tbl3[arg1] = arg2
		tbl2[arg1]:SetText(arg2)
	end

	local function func11()
		local v1 = tbl1.Round.Map() ~= nil
		local v2 = v1 and tbl1.Round.FindByRole("Murderer")
		local v3 = v1 and (tbl1.Round.FindByRole("Sheriff") or tbl1.Round.FindByRole("Hero"))
		local v4 = tbl1.Round.IAmPlaying() and tostring(tbl1.Round.RoleOf(LocalPlayer))
		local v5 = v1 and State.Bag.Current or 0
		local v6 = v1 and State.Bag.Max or 0
		func10("Role", "You: " .. (v4 or "Lobby"))
		func10("Murderer", "Murderer: " .. (v2 and v2.Name or "?"))
		func10("Sheriff", "Sheriff: " .. (v3 and v3.Name or "?"))
		func10("BagCount", string.format("Bag: %d / %d", v5, v6))
		local v7 = v6 > 0 and math.min(v5 / v6, 1) or 0

		if tbl2.Bag and tbl2.Bag.Value ~= v7 then
			tbl2.Bag:SetValue(v7)
		end
	end

	local function func12()
		for k in pairs(GameLib.Needs) do
			local v2 = GameLib.Missing(k)
			if v2 and v1.Options[k] then
				v1.Compat.Block(k, "Not found after a game update")
				warn("[eter hub] " .. k .. " off, missing remote " .. v2)
			end
		end
		for _, v3 in ipairs({"PlayerData", "CoinsStarted", "RedeemCode"}) do
			if not GameLib[v3] then
				warn("[eter hub] missing remote " .. v3)
			end
		end
	end

	local function func13()
		v1:Every(Config.StatusRefresh, function()
			func9()
			if tbl2.Role then
				func11()
			end
		end)
	end

	local function func14()
		local Window = v1.Window
		Window:AddTabSection("Game")
		tbl1.Util.Try(func7, Window)
		tbl1.Util.Try(func2, Window)
		tbl1.Util.Try(func3, Window)
		tbl1.Util.Try(func4, Window)
		Window:AddTabSection("Other")
		tbl1.Util.Try(func5, Window)
		tbl1.Util.Try(func6, Window)
		tbl1.Util.Try(func8, Window)
		tbl1.Util.Try(Window.AddSettingsTab, Window)
		tbl1.Util.Try(func12)
		tbl1.Util.Try(func13)
	end

	v1:OnUnload(tbl1.Scheduler.Stop)

	getgenv().MurderMystery2Unload = function()
		v1:Unload()
	end

	v1:CreateWindow({
		Title = "eter hub · MM2",
		SubTitle = "Murder Mystery 2  •  zluu hub",
		MenuKey = Enum.KeyCode.LeftControl,
		ConfigFolder = Config.SaveFolder,
		Language = "en",
		Theme = "AerisPurpleWhite",
		OnUnlocked = function()
			func14()
			tbl1.Util.Try(tbl1.Scheduler.Boot, func)
			v1:Notify("zluu hub", "MM2 script cargado ✓", 5, "Success")
			tbl1.Util.Try(v1.LoadAutoloadConfig, v1)
		end,
	})

	return true
end

if getgenv().MurderMystery2Unload then
	pcall(getgenv().MurderMystery2Unload)
end

pcall(tbl.Step, "Systems")

if func() then
	pcall(tbl.Step, "Interface")
	pcall(tbl.Ready)
end
