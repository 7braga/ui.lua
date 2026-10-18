if _G.OnyxV2Cleanup then
	_G.__OnyxReloading = true
	pcall(_G.OnyxV2Cleanup)
	_G.__OnyxReloading = nil
end

do
	local ok, text = pcall(function()
		return identifyexecutor()
	end)

	ok = ok and type(text) == "string"
	local str = ""

	if not ok then
		text = str
	end

	if text == "" then
		local ok2, result = pcall(function()
			return getexecutorname()
		end)

		if ok2 and type(result) == "string" then
			text = result
		end
	end

	text = text:match("^%s*(%a+)") or text
	local str2 = text:lower()
	local flag = false

	for _, v in ipairs({ "solara", "xeno" }) do
		if str2:find(v, 1, true) then
			flag = true
		end
	end

	if flag then
		local color = Color3.fromRGB(236, 236, 244)
		local color2 = Color3.fromRGB(168, 168, 184)
		local color3 = Color3.fromRGB(29, 29, 37)
		local color4 = Color3.fromRGB(158, 158, 174)
		local color5 = Color3.fromRGB(232, 232, 240)
		local color6 = Color3.fromRGB(22, 22, 28)
		local color7 = Color3.fromRGB(140, 140, 165)
		local hui = gethui and gethui() or game:GetService("CoreGui")
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "OnyxExecutorWarning"
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.DisplayOrder = 2000000
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.Parent = hui
		local frame = Instance.new("Frame")
		frame.Size = UDim2.fromScale(1, 1)
		frame.BackgroundColor3 = Color3.new(0, 0, 0)
		frame.BackgroundTransparency = 0.4
		frame.BorderSizePixel = 0
		frame.ZIndex = 1
		frame.Parent = screenGui
		local x = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.X or 800
		local frame2 = Instance.new("Frame")
		frame2.AnchorPoint = Vector2.new(0.5, 0.5)
		frame2.Position = UDim2.fromScale(0.5, 0.5)
		frame2.Size = UDim2.fromOffset(math.min(440, math.max(300, x - 40)), 236)
		frame2.BackgroundColor3 = Color3.fromRGB(23, 23, 28)
		frame2.BorderSizePixel = 0
		frame2.ZIndex = 2
		frame2.Parent = screenGui
		Instance.new("UICorner", frame2).CornerRadius = UDim.new(0, 22)
		local uiGradient = Instance.new("UIGradient", frame2)
		uiGradient.Rotation = 90

		uiGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 36)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 16, 20)),
		})

		local uiStroke = Instance.new("UIStroke", frame2)
		uiStroke.Color = color7
		uiStroke.Thickness = 1
		uiStroke.Transparency = 0.7
		local textLabel = Instance.new("TextLabel")
		textLabel.BackgroundTransparency = 1
		textLabel.Position = UDim2.new(0, 26, 0, 24)
		textLabel.Size = UDim2.new(1, -52, 0, 24)
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 18
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.TextColor3 = color
		textLabel.Text = "Executor Warning"
		textLabel.ZIndex = 3
		textLabel.Parent = frame2
		local textLabel2 = Instance.new("TextLabel")
		textLabel2.BackgroundTransparency = 1
		textLabel2.Position = UDim2.new(0, 26, 0, 48)
		textLabel2.Size = UDim2.new(1, -52, 0, 18)
		textLabel2.Font = Enum.Font.Gotham
		textLabel2.TextSize = 12
		textLabel2.TextXAlignment = Enum.TextXAlignment.Left
		textLabel2.TextColor3 = color4
		textLabel2.Text = text
		textLabel2.ZIndex = 3
		textLabel2.Parent = frame2
		local textLabel3 = Instance.new("TextLabel")
		textLabel3.BackgroundTransparency = 1
		textLabel3.Position = UDim2.new(0, 26, 0, 78)
		textLabel3.Size = UDim2.new(1, -52, 0, 96)
		textLabel3.Font = Enum.Font.Gotham
		textLabel3.TextSize = 14
		textLabel3.TextWrapped = true
		textLabel3.LineHeight = 1.15
		textLabel3.TextXAlignment = Enum.TextXAlignment.Left
		textLabel3.TextYAlignment = Enum.TextYAlignment.Top
		textLabel3.TextColor3 = color2

		textLabel3.Text = "Seems like you are using " .. text .. [[. This executor might not support all features of the script, and may result in bigger glitches or bugs.

Please use a better executor next time.]]

		textLabel3.ZIndex = 3
		textLabel3.Parent = frame2
		local textButton = Instance.new("TextButton")
		textButton.AnchorPoint = Vector2.new(0.5, 1)
		textButton.Position = UDim2.new(0.5, 0, 1, -22)
		textButton.Size = UDim2.new(1, -52, 0, 38)
		textButton.BackgroundColor3 = color3
		textButton.BorderSizePixel = 0
		textButton.AutoButtonColor = false
		textButton.Font = Enum.Font.GothamBold
		textButton.TextSize = 13
		textButton.TextColor3 = color4
		textButton.Text = "Understood  (5)"
		textButton.ZIndex = 3
		textButton.Parent = frame2
		Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 12)
		local flag2 = false
		local flag3 = false

		task.spawn(function()
			for i = 5, 1, -1 do
				textButton.Text = "Understood  (" .. i .. ")"
				task.wait(1)
			end

			flag2 = true
			textButton.Text = "Understood"
			textButton.BackgroundColor3 = color5
			textButton.TextColor3 = color6
		end)

		local function fn()
			if not flag2 or flag3 then
				return
			end
			flag3 = true

			pcall(function()
				screenGui:Destroy()
			end)
		end

		textButton.MouseButton1Click:Connect(fn)
		textButton.TouchTap:Connect(fn)
		local n = 0

		while not flag3 and n < 120 do
			task.wait(0.2)
			n += 0.2
		end

		pcall(function()
			screenGui:Destroy()
		end)
	end
end

LOADUI = {}

do
	local hui = gethui and gethui() or game:GetService("CoreGui")
	local onyxLoading = hui:FindFirstChild("OnyxLoading")

	if onyxLoading then
		onyxLoading:Destroy()
	end

	local TweenService_ = game:GetService("TweenService")
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "OnyxLoading"
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 99998
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = hui
	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromScale(1, 1)
	frame.BackgroundColor3 = Color3.new(0, 0, 0)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.Parent = screenGui
	local frame2 = Instance.new("Frame")
	frame2.AnchorPoint = Vector2.new(0.5, 0.5)
	frame2.Position = UDim2.fromScale(0.5, 0.5)
	frame2.Size = UDim2.fromOffset(math.min(360, math.max(280, (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.X or 800) - 40)), 102)
	frame2.BackgroundColor3 = Color3.fromRGB(23, 23, 28)
	frame2.BackgroundTransparency = 1
	frame2.BorderSizePixel = 0
	frame2.Parent = screenGui
	Instance.new("UICorner", frame2).CornerRadius = UDim.new(0, 18)
	local uiGradient = Instance.new("UIGradient", frame2)
	uiGradient.Rotation = 90
	local new = ColorSequenceKeypoint.new
	local color = Color3.fromRGB
	uiGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 36)), new(1, color(16, 16, 20)) })
	local uiStroke = Instance.new("UIStroke", frame2)
	uiStroke.Color = Color3.fromRGB(140, 140, 165)
	uiStroke.Thickness = 1
	uiStroke.Transparency = 1
	local frame3 = Instance.new("Frame")
	frame3.Position = UDim2.fromOffset(22, 18)
	frame3.Size = UDim2.fromOffset(44, 44)
	frame3.BackgroundColor3 = Color3.fromRGB(38, 38, 47)
	frame3.BackgroundTransparency = 1
	frame3.BorderSizePixel = 0
	frame3.Parent = frame2
	Instance.new("UICorner", frame3).CornerRadius = UDim.new(1, 0)
	local uiStroke2 = Instance.new("UIStroke", frame3)
	uiStroke2.Color = Color3.fromRGB(140, 140, 165)
	uiStroke2.Thickness = 1
	uiStroke2.Transparency = 1
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel.Position = UDim2.fromScale(0.5, 0.5)
	imageLabel.Size = UDim2.fromOffset(23, 23)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Image = "rbxassetid://110926118391987"
	imageLabel.ImageColor3 = Color3.fromRGB(236, 236, 244)
	imageLabel.ImageTransparency = 1
	imageLabel.Parent = frame3
	local textLabel = Instance.new("TextLabel")
	textLabel.Position = UDim2.fromOffset(81, 20)
	textLabel.Size = UDim2.new(1, -103, 0, 22)
	textLabel.BackgroundTransparency = 1
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 19
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.TextColor3 = Color3.fromRGB(242, 242, 248)
	textLabel.TextTransparency = 1
	textLabel.Text = "Loading Bragas"
	textLabel.Parent = frame2
	local textLabel2 = Instance.new("TextLabel")
	textLabel2.Position = UDim2.fromOffset(81, 43)
	textLabel2.Size = UDim2.new(1, -103, 0, 19)
	textLabel2.BackgroundTransparency = 1
	textLabel2.Font = Enum.Font.Gotham
	textLabel2.TextSize = 16
	textLabel2.TextXAlignment = Enum.TextXAlignment.Left
	textLabel2.TextColor3 = Color3.fromRGB(139, 139, 153)
	textLabel2.TextTransparency = 1
	textLabel2.Text = "Starting up"
	textLabel2.Parent = frame2
	local frame4 = Instance.new("Frame")
	frame4.Position = UDim2.fromOffset(22, 79)
	frame4.Size = UDim2.new(1, -44, 0, 5)
	frame4.BackgroundColor3 = Color3.fromRGB(38, 38, 47)
	frame4.BackgroundTransparency = 1
	frame4.BorderSizePixel = 0
	frame4.Parent = frame2
	Instance.new("UICorner", frame4).CornerRadius = UDim.new(1, 0)
	local frame5 = Instance.new("Frame")
	frame5.Size = UDim2.new(0, 0, 1, 0)
	frame5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame5.BackgroundTransparency = 1
	frame5.BorderSizePixel = 0
	frame5.Parent = frame4
	Instance.new("UICorner", frame5).CornerRadius = UDim.new(1, 0)
	local colorSequence = ColorSequence.new
	local new2 = ColorSequenceKeypoint.new
	local color2 = Color3.fromRGB
	Instance.new("UIGradient", frame5).Color = colorSequence({ ColorSequenceKeypoint.new(0, Color3.fromRGB(143, 143, 158)), new2(1, color2(255, 255, 255)) })
	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService_:Create(frame, tweenInfo, { BackgroundTransparency = 0.5 }):Play()
	TweenService_:Create(frame2, tweenInfo, { BackgroundTransparency = 0 }):Play()
	TweenService_:Create(uiStroke, tweenInfo, { Transparency = 0.58 }):Play()
	TweenService_:Create(frame3, tweenInfo, { BackgroundTransparency = 0 }):Play()
	TweenService_:Create(uiStroke2, tweenInfo, { Transparency = 0.5 }):Play()
	TweenService_:Create(imageLabel, tweenInfo, { ImageTransparency = 0 }):Play()
	TweenService_:Create(textLabel, tweenInfo, { TextTransparency = 0 }):Play()
	TweenService_:Create(textLabel2, tweenInfo, { TextTransparency = 0 }):Play()
	TweenService_:Create(frame4, tweenInfo, { BackgroundTransparency = 0 }):Play()
	TweenService_:Create(frame5, tweenInfo, { BackgroundTransparency = 0 }):Play()
	local flag = true
	local tbl = {}

	local function fn()
		for _, child in ipairs(hui:GetChildren()) do
			local flag2 = child:IsA("ScreenGui") and child.Enabled and child ~= screenGui

			if flag2 then
				flag2 = child.Name == "WindUI" or child.Name:match("^WindUI/") or child.Name:match("^Onyx.+Button$")
			end

			if flag2 then
				child.Enabled = false
				tbl[#tbl + 1] = child
			end
		end
	end

	LOADUI.reveal = function()
		for _, v in ipairs(tbl) do
			pcall(function()
				v.Enabled = true
			end)
		end

		tbl = {}
	end

	task.spawn(function()
		while flag do
			pcall(fn)
			task.wait(0.05)
		end
	end)

	local n = 0

	LOADUI.step = function(arg, arg2)
		if not flag then
			return
		end

		pcall(function()
			if type(arg) == "number" and arg > n then
				n = math.clamp(arg, 0, 1)
				TweenService_:Create(frame5, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(n, 0, 1, 0) }):Play()
			end

			if arg2 then
				textLabel2.Text = tostring(arg2)
			end
		end)
	end

	LOADUI.done = function()
		if not flag then
			return
		end
		flag = false

		pcall(function()
			textLabel2.Text = "Ready"
			TweenService_:Create(frame5, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0) }):Play()

			task.delay(0.34, function()
				LOADUI.reveal()
				local tweenInfo2 = TweenInfo.new(0.26, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				TweenService_:Create(frame, tweenInfo2, { BackgroundTransparency = 1 }):Play()
				TweenService_:Create(frame2, tweenInfo2, { BackgroundTransparency = 1 }):Play()
				TweenService_:Create(uiStroke, tweenInfo2, { Transparency = 1 }):Play()
				TweenService_:Create(frame3, tweenInfo2, { BackgroundTransparency = 1 }):Play()
				TweenService_:Create(uiStroke2, tweenInfo2, { Transparency = 1 }):Play()
				TweenService_:Create(imageLabel, tweenInfo2, { ImageTransparency = 1 }):Play()
				TweenService_:Create(textLabel, tweenInfo2, { TextTransparency = 1 }):Play()
				TweenService_:Create(textLabel2, tweenInfo2, { TextTransparency = 1 }):Play()
				TweenService_:Create(frame4, tweenInfo2, { BackgroundTransparency = 1 }):Play()
				TweenService_:Create(frame5, tweenInfo2, { BackgroundTransparency = 1 }):Play()

				task.delay(0.3, function()
					pcall(function()
						screenGui:Destroy()
					end)
				end)
			end)
		end)
	end
end

task.delay(30, function()
	LOADUI.done()
end)

task.spawn(function()
	print("-- LOADING ONYX --")

	for _, v in ipairs({ 0, 5, 11, 22 }) do
		local n = math.floor(v / 22 * 100 + 0.5)
		print("[" .. string.rep("#", v) .. string.rep(" ", 22 - v) .. "] " .. string.format("%02d%%", n))
		task.wait(0.25)
	end

	print("Loaded. discord.gg/dCnvGNYANP")
end)

if _G.OnyxV2 then
	local onyxV2 = _G.OnyxV2
	local flag = false

	pcall(function()
		flag = not onyxV2.Destroyed and onyxV2.UIElements and onyxV2.UIElements.Main and onyxV2.UIElements.Main.Parent ~= nil
	end)

	if flag then
		pcall(function()
			onyxV2:Destroy()
		end)

		local now = os.clock()

		while true do
			task.wait(0.1)
			if not (onyxV2.Destroyed or os.clock() - now > 3) then
				continue
			end
			break
		end

		task.wait(0.7)
	end

	_G.OnyxV2 = nil
end

_G.OnyxV2Cleanup = nil

pcall(function()
	local v = ipairs
	local CoreGui_ = game:GetService("CoreGui")

	for _, child in v(CoreGui_:GetChildren()) do
		if child.Name == "OnyxESP" or child.Name:match("^Onyx.+Button$") then
			child:Destroy()
		end
	end
end)

pcall(function()
	local hui = gethui and gethui() or game:GetService("CoreGui")

	for _, child in ipairs(hui:GetChildren()) do
		if child.Name == "WindUI" or child.Name:match("^WindUI/") then
			child:Destroy()
		end
	end
end)

LOADUI.step(0.12, "Fetching library")
local v

do
	local response = nil

	local function fn(arg)
		if makefolder and isfolder and not isfolder(arg) then
			pcall(makefolder, arg)
		end
	end

	if isfile and readfile and isfile("OnyxV2/windui.lua") then
		local ok, result = pcall(readfile, "OnyxV2/windui.lua")

		if ok and type(result) == "string" and #result > 100000 then
			response = result
		end
	end

	local flag = response ~= nil
	response = response or game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")
	local chunk = loadstring(response)

	if not chunk and flag then
		response = game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")
		chunk = loadstring(response)
		flag = false
	end

	if not flag and writefile then
		pcall(function()
			fn("OnyxV2")
			writefile("OnyxV2/windui.lua", response)
		end)
	end

	if writefile and isfile and not isfile("OnyxV2/icons-main.lua") then
		pcall(function()
			local str, v2 = game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"):gsub("return game:HttpGet%(url%)", function()
				return [[do
    local _p = "OnyxV2/icons/" .. url:gsub("%W", "_") .. ".txt"
    if isfile and readfile and isfile(_p) then
        local _o, _d = pcall(readfile, _p)
        if _o and type(_d) == "string" and #_d > 0 then return _d end
    end
    local _d = game:HttpGet(url)
    pcall(function()
        if makefolder and isfolder and not isfolder("OnyxV2/icons") then makefolder("OnyxV2/icons") end
        writefile(_p, _d)
    end)
    return _d
end]]
			end)

			if v2 > 0 and loadstring(str) then
				fn("OnyxV2")
				writefile("OnyxV2/icons-main.lua", str)
			end
		end)
	end

	if isfile and isfile("OnyxV2/icons-main.lua") then
		local str, v2 = response:gsub("game%.HttpGet and game:HttpGet%(%w+%)or %w+:GetAsync%(%w+%)", "readfile(\"" .. "OnyxV2/icons-main.lua\")")

		if v2 > 0 then
			chunk = loadstring(str) or chunk
		end
	end

	v = chunk()
end

v:AddTheme({
	Name = "Onyx",
	Background = v:Gradient({
		["0"] = { Color = Color3.fromHex("#161619"), Transparency = 0.12 },
		["100"] = { Color = Color3.fromHex("#161619"), Transparency = 0.12 },
	}, { Rotation = 90 }),
	Accent = v:Gradient({
		["0"] = { Color = Color3.fromHex("#101014"), Transparency = 0 },
		["100"] = { Color = Color3.fromHex("#2a2a32"), Transparency = 0 },
	}, { Rotation = 90 }),
	Dialog = Color3.fromHex("#141418"),
	Outline = Color3.fromHex("#ffffff"),
	Text = Color3.fromHex("#ffffff"),
	Placeholder = Color3.fromHex("#a1a1aa"),
	Button = Color3.fromHex("#3f3f46"),
	Icon = Color3.fromHex("#d4d4d8"),
	Toggle = Color3.fromHex("#ffffff"),
	Slider = Color3.fromHex("#ffffff"),
	Checkbox = Color3.fromHex("#ffffff"),
	SliderIcon = Color3.fromHex("#71717a"),
	Primary = Color3.fromHex("#ffffff"),
	PanelBackground = Color3.fromHex("#ffffff"),
	PanelBackgroundTransparency = 0.94,
	LabelBackground = Color3.fromHex("#000000"),
	LabelBackgroundTransparency = 0.8,
	ElementBackground = Color3.fromHex("#18181b"),
	ElementBackgroundTransparency = 0.3,
})

v:SetTheme("Onyx")
LOADUI.step(0.4, "Building window")
local v2

do
	local v3 = v
	local createWindow = v3.CreateWindow

	local tbl = {
		Title = "Bragas - Premium",
		Icon = "solar:planet-bold",
		Author = "Murder Mystery 2",
		Folder = "OnyxV2",
		Background = "https://raw.githubusercontent.com/onyx-scripts/main/main/onyxscripts.png",
		Size = UDim2.fromOffset(math.max(560, math.min(850, (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)).X - 24)), math.max(350, math.min(560, (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)).Y - 24))),
	}

	tbl.MaxSize = Vector2.new(850, 560)
	tbl.HideSearchBar = false
	tbl.Transparent = true
	tbl.Theme = "Onyx"
	tbl.Resizable = true
	tbl.ToggleKey = nil
	tbl.BackgroundImageTransparency = 0.35
	tbl.Acrylic = false
	tbl.ShadowTransparency = 0.3
	tbl.Radius = 18
	tbl.IconRadius = 1
	tbl.IconSize = 27
	tbl.SideBarWidth = 185
	tbl.Topbar = { Height = 56, ButtonsType = "Default" }
	tbl.User = { Enabled = false, Anonymous = false }
	v2 = createWindow(v3, tbl)
end

v2:Tag({ Title = "@Bragas", Icon = "youtube", Color = Color3.fromHex("#ffffff"), Radius = 6 })

v2:Tag({
	Title = "discord.gg/dCnvGNYANP",
	Icon = "message-square-more",
	Color = Color3.fromHex("#ffffff"),
	Radius = 6,
})

v2:Tag({ Title = "Mobile & PC", Icon = "smartphone", Color = Color3.fromHex("#ffffff"), Radius = 6 })

task.spawn(function()
	local tbl = { ["discord.gg/dCnvGNYANP"] = true, ["Mobile & PC"] = true, ["@Bragas"] = true }
	local colorSequence = ColorSequence.new
	local tbl2 = {}
	local v3 = ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 26, 32))
	local v4 = ColorSequenceKeypoint.new(0.35, Color3.fromRGB(46, 46, 56))
	local v5 = ColorSequenceKeypoint.new(0.7, Color3.fromRGB(32, 32, 39))
	local new = ColorSequenceKeypoint.new
	local color = Color3.fromRGB
	tbl2[1] = v3
	tbl2[2] = v4
	tbl2[3] = v5

	do
		local values = table.pack(new(1, color(42, 42, 51)))
		table.move(values, 1, values.n, 4, tbl2)
	end

	local v6 = colorSequence(tbl2)
	local color2 = Color3.fromRGB(228, 228, 236)

	for i = 1, 120 do
		local n = 0

		pcall(function()
			for _, descendant in ipairs(v2.UIElements.Main:GetDescendants()) do
				if descendant:IsA("TextLabel") and tbl[descendant.Text] then
					local parent = descendant.Parent and descendant.Parent.Parent

					if parent and parent:IsA("ImageLabel") then
						if not parent:FindFirstChildWhichIsA("UIGradient") then
							local uiGradient = Instance.new("UIGradient")
							uiGradient.Rotation = 45
							uiGradient.Color = v6
							uiGradient.Parent = parent
						end

						for _, descendant2 in ipairs(parent:GetDescendants()) do
							if descendant2:IsA("TextLabel") then
								descendant2.TextColor3 = color2
							elseif descendant2:IsA("ImageLabel") and descendant2 ~= parent then
								descendant2.ImageColor3 = color2
							end
						end

						n += 1
					end
				end
			end
		end)

		local n2 = 0

		for k in pairs(tbl) do
			n2 += 1
		end

		if n >= n2 then
			local tbl3 = {}

			pcall(function()
				for _, descendant in ipairs(v2.UIElements.Main:GetDescendants()) do
					if descendant:IsA("TextLabel") and tbl[descendant.Text] and descendant.Parent then
						local v7 = nil

						for _, child in ipairs(descendant.Parent:GetChildren()) do
							if child ~= descendant and child:IsA("GuiObject") then
								v7 = child
							end
						end

						if v7 then
							tbl3[#tbl3 + 1] = { lbl = descendant, icon = v7 }
						end
					end
				end
			end)

			local function fn(arg, arg2)
				if arg2 then
					local uiListLayout = arg.lbl.Parent and arg.lbl.Parent:FindFirstChildOfClass("UIListLayout")

					if uiListLayout then
						local parent = uiListLayout.Parent
						uiListLayout.Parent = nil
						RunService.RenderStepped:Wait()

						if parent.Parent then
							uiListLayout.Parent = parent
						end
					end

					return
				end

				local size = arg.icon.Size
				arg.icon.Size = UDim2.new(size.X.Scale, size.X.Offset + 1, size.Y.Scale, size.Y.Offset)
				RunService.RenderStepped:Wait()

				if arg.icon.Parent then
					arg.icon.Size = size
				end
			end

			local now = os.clock()
			local n3 = 0

			while _G.OnyxV2 == v2 and n3 < 40 do
				for _, v7 in ipairs(tbl3) do
					if v7.lbl.Parent and v7.icon.Parent and v7.icon.AbsoluteSize.X > 0 and v7.lbl.AbsoluteSize.X > 0 and v7.lbl.AbsolutePosition.X < v7.icon.AbsolutePosition.X + v7.icon.AbsoluteSize.X then
						n3 += 1
						pcall(fn, v7, n3 > 6)
					end
				end

				task.wait(os.clock() - now < 25 and 0.3 or 3)
			end

			return
		end

		RunService.RenderStepped:Wait()
	end
end)

v2:SetBackgroundTransparency(0.4)

task.spawn(function()
	local RunService_ = game:GetService("RunService")

	for i = 1, 120 do
		local background = v2.UIElements and v2.UIElements.Main and v2.UIElements.Main:FindFirstChild("Background")

		if background then
			local flag = false

			for _, child in ipairs(background:GetChildren()) do
				if child:IsA("ImageLabel") and child.Size == UDim2.new(1, 0, 1, 0) then
					child.ScaleType = Enum.ScaleType.Stretch
					flag = true
				end
			end

			if flag then
				return
			end
		end

		RunService_.RenderStepped:Wait()
	end
end)

task.spawn(function()
	local TweenService_ = game:GetService("TweenService")
	local RunService_ = game:GetService("RunService")

	local function fn()
		local main = v2.UIElements and v2.UIElements.Main
		if not main then
			return nil
		end
		local topbar = main:FindFirstChild("Topbar", true)

		for _, v3 in ipairs({ "Left", "Title", "Title" }) do
			topbar = topbar and topbar:FindFirstChild(v3)
		end

		if topbar and topbar:IsA("TextLabel") then
			return topbar
		end

		for _, descendant in ipairs(main:GetDescendants()) do
			if descendant:IsA("TextLabel") and descendant.Text == v2.Title then
				return descendant
			end
		end

		return nil
	end

	local v3 = nil

	for i = 1, 120 do
		v3 = fn()
		if not v3 then
			RunService_.RenderStepped:Wait()
			continue
		end
		break
	end

	if not v3 or v3:FindFirstChild("OnyxTitleSheen") then
		return
	end
	local uiGradient = v3:FindFirstChildWhichIsA("UIGradient")

	if uiGradient then
		uiGradient:Destroy()
	end

	local uiGradient2 = Instance.new("UIGradient")
	uiGradient2.Name = "OnyxTitleSheen"
	uiGradient2.Rotation = 12
	local colorSequence = ColorSequence.new
	local tbl = {}
	local v4 = ColorSequenceKeypoint.new(0, Color3.fromRGB(148, 148, 164))
	local v5 = ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255, 255, 255))
	local v6 = ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255, 255, 255))
	local new = ColorSequenceKeypoint.new
	local color = Color3.fromRGB
	tbl[1] = v4
	tbl[2] = v5
	tbl[3] = v6

	do
		local values = table.pack(new(1, color(148, 148, 164)))
		table.move(values, 1, values.n, 4, tbl)
	end

	uiGradient2.Color = colorSequence(tbl)
	uiGradient2.Offset = Vector2.new(-0.55000001192092896, 0)
	uiGradient2.Parent = v3
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Name = "OnyxTitleGlow"
	uiStroke.Color = Color3.fromRGB(236, 239, 250)
	uiStroke.Thickness = 1.4
	uiStroke.Transparency = 0.82
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	uiStroke.Parent = v3
	TweenService_:Create(uiGradient2, TweenInfo.new(2.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { Offset = Vector2.new(0.55000001192092896, 0) }):Play()
	TweenService_:Create(uiStroke, TweenInfo.new(1.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { Transparency = 0.42 }):Play()
end)

local color = Color3.fromHex

v2:EditOpenButton({
	Title = "Bragas",
	Icon = "solar:planet-bold",
	CornerRadius = UDim.new(0, 16),
	StrokeThickness = 2,
	Color = ColorSequence.new(Color3.fromHex("#2a2a32"), color("#c9c9d4")),
	OnlyMobile = false,
	Enabled = true,
	Draggable = true,
})

_G.OnyxV2 = v2
local tbl

tbl = {
	farmTargetTime = 0,
	shellsOn = false,
	shellsRunning = false,
	flingAllRunning = false,
	hudScale = 1,
	flingWhenDone = false,
	flingDoneFired = false,
	sawCoins = false,
	lastMap = nil,
	killWhenFull = false,
	killFired = false,
	el = {},
	conns = {},
	revealed = {},
	clipWas = {},
	farmClipWas = {},
	config = nil,
	hudBtns = {},
	hudPos = {},
	cfgSnapshot = nil,
	cfgWiped = false,
	hudDir = "WindUI/OnyxV2/hud",
	hudFile = "WindUI/OnyxV2/hud/autosave.json",
}

pcall(function()
	if makefolder and isfolder and not isfolder(tbl.hudDir) then
		makefolder(tbl.hudDir)
	end
end)

tbl.sfxId = {
	error = 131039887376992,
	gun = 131390520971848,
	click = 139800881181209,
	toggle = 136108770017536,
}

tbl.sfxVol = { error = 0.55, gun = 0.75, click = 0.65, toggle = 0.6 }
tbl.sfxOn = { error = true, gun = true, click = true, toggle = true }
tbl.sfxReady = false
tbl.sfxQuiet = false
tbl.sfx = {}

tbl.playSfx = function(name)
	if not tbl.sfxOn[name] then
		return
	end
	local v3 = tbl.sfxId[name]
	if not v3 then
		return
	end

	pcall(function()
		local SoundService = game:GetService("SoundService")
		local onyxSFX = SoundService:FindFirstChild("OnyxSFX")

		if not onyxSFX then
			onyxSFX = Instance.new("Folder")
			onyxSFX.Name = "OnyxSFX"
			onyxSFX.Parent = SoundService
		end

		local sound = tbl.sfx[name]

		if not sound or not sound.Parent then
			sound = onyxSFX:FindFirstChild(name) or Instance.new("Sound")
			sound.Name = name
			sound.SoundId = "rbxassetid://" .. v3
			sound.Volume = tbl.sfxVol[name] or 0.5
			sound.Parent = onyxSFX
			tbl.sfx[name] = sound
		end

		sound.TimePosition = 0
		sound:Play()
	end)
end

local tab = v2.Tab

v2.Tab = function(arg, arg2)
	local v3 = tab(arg, arg2)

	if type(v3) == "table" and type(v3.Toggle) == "function" then
		local toggle = v3.Toggle

		v3.Toggle = function(arg3, arg4)
			if type(arg4) == "table" then
				local callback = arg4.Callback

				arg4.Callback = function(...)
					if tbl.sfxReady and not tbl.sfxQuiet then
						tbl.playSfx("toggle")
					end

					if callback then
						return callback(...)
					end
				end
			end

			return toggle(arg3, arg4)
		end
	end

	return v3
end

tbl.notifyReady = false
tbl.realNotify = v.Notify

v.Notify = function(arg, arg2)
	if not tbl.notifyReady then
		return
	end

	if type(arg2) == "table" and (arg2.Icon == "x" or arg2.Icon == "clock") then
		tbl.playSfx("error")
	end

	return tbl.realNotify(arg, arg2)
end

tbl.notifyNow = function(arg)
	return tbl.realNotify(v, arg)
end

task.delay(4, function()
	tbl.notifyReady = true
end)

task.delay(20, function()
	tbl.sfxReady = true
end)

task.spawn(function()
	local CoreGui_ = game:GetService("CoreGui")

	local function fn(child)
		if not (child and child:IsA("GuiObject")) then
			return
		end

		task.spawn(function()
			local imageLabel = nil

			for i = 1, 60 do
				imageLabel = child:FindFirstChildWhichIsA("ImageLabel")
				if not (imageLabel or not child.Parent) then
					task.wait()
					continue
				end
				break
			end

			if not imageLabel or imageLabel:FindFirstChild("OnyxToastRamp") then
				return
			end
			local uiGradient = Instance.new("UIGradient")
			uiGradient.Name = "OnyxToastRamp"
			uiGradient.Rotation = 45

			uiGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(118, 118, 130)),
			})

			uiGradient.Parent = imageLabel
		end)
	end

	local windUINotifications = nil

	for i = 1, 900 do
		windUINotifications = CoreGui_:FindFirstChild("WindUI/Notifications", true)
		if not windUINotifications then
			task.wait(0.2)
			continue
		end
		break
	end

	if not windUINotifications then
		return
	end
	local frame = nil

	for i = 1, 900 do
		frame = windUINotifications:FindFirstChildWhichIsA("Frame")
		if not frame then
			task.wait(0.2)
			continue
		end
		break
	end

	if not frame then
		return
	end

	for _, child in ipairs(frame:GetChildren()) do
		fn(child)
	end

	frame.ChildAdded:Connect(fn)
end)

tbl.findOpenPill = function()
	local windUI = (gethui and gethui() or game:GetService("CoreGui")):FindFirstChild("WindUI")
	windUI = windUI and windUI:FindFirstChild("Window")
	if not windUI then
		return nil, nil
	end
	local v3 = nil
	local v4 = nil

	for _, child in ipairs(windUI:GetChildren()) do
		if child:IsA("Frame") then
			if child:FindFirstChild("Main") then
				v3 = child
			elseif child:FindFirstChildWhichIsA("TextButton", true) then
				v4 = child
			end
		end
	end

	return v4, v3
end

tbl.pinOpenPill = function()
	task.spawn(function()
		local v3 = nil
		local v4 = nil

		for i = 1, 200 do
			v3, v4 = tbl.findOpenPill()
			if not (v3 and v4) then
				task.wait(0.05)
				continue
			end
			break
		end

		if not (v3 and v4) then
			return
		end

		local function fn()
			local visible = not v4.Visible

			if v3.Visible ~= visible then
				v3.Visible = visible
			end
		end

		fn()
		tbl.conns[#tbl.conns + 1] = v4:GetPropertyChangedSignal("Visible"):Connect(fn)
		tbl.conns[#tbl.conns + 1] = v3:GetPropertyChangedSignal("Visible"):Connect(fn)
	end)
end

tbl.mouseAimPoint = function()
	local currentCamera = Workspace.CurrentCamera
	if not currentCamera then
		return nil
	end

	local ok, result = pcall(function()
		local mouseLocation = UserInputService:GetMouseLocation()
		local v3 = currentCamera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { LocalPlayer.Character }
		local hit = Workspace:Raycast(v3.Origin, v3.Direction * 300, raycastParams)
		return hit and hit.Position or v3.Origin + v3.Direction * 300
	end)

	return ok and result or nil
end

tbl.xrayWas = {}
tbl.xrayOn = false

tbl.setXray = function(xrayOn)
	tbl.xrayOn = xrayOn

	if xrayOn then
		for _, descendant in ipairs(Workspace:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant.Transparency < 0.5 then
				local model = descendant:FindFirstAncestorWhichIsA("Model")

				if not (model and Players:GetPlayerFromCharacter(model)) then
					if tbl.xrayWas[descendant] == nil then
						tbl.xrayWas[descendant] = descendant.Transparency
					end

					descendant.Transparency = 0.5
				end
			end
		end
	else
		for k, v3 in next, tbl.xrayWas, nil do
			pcall(function()
				if k.Parent then
					k.Transparency = v3
				end
			end)
		end

		tbl.xrayWas = {}
	end
end

tbl.dropConns = function(arg)
	if type(arg) ~= "table" then
		return
	end

	for _, v3 in ipairs(arg) do
		pcall(function()
			v3:Disconnect()
		end)
	end

	for i = #arg, 1, -1 do
		arg[i] = nil
	end
end

tbl.unreveal = function()
	for k, v3 in next, tbl.revealed, nil do
		pcall(function()
			if k.Parent then
				k.Transparency = v3
			end
		end)
	end

	tbl.revealed = {}
end

tbl.reclip = function(arg)
	for k in next, arg, nil do
		pcall(function()
			if k.Parent then
				k.CanCollide = true
			end
		end)
	end

	for k in next, arg, nil do
		arg[k] = nil
	end
end

tbl.DISCORD_INVITE = "dCnvGNYANP"
tbl.DISCORD_FETCH = "dCnvGNYANP"
tbl.discordInfo = nil
tbl.discordTried = false

tbl.discordFetch = function()
	if tbl.discordTried then
		return tbl.discordInfo
	end
	tbl.discordTried = true
	local str = "https://discord.com/api/v10/invites/" .. tbl.DISCORD_FETCH .. "?with_counts=true&with_expiration=true"
	local body = nil
	local request_ = v and v.Creator and v.Creator.Request or syn and syn.request or http_request or request
	local request_2

	if request_ then
		request_2 = request_
	else
		request_2 = http and http.request
	end

	if request_2 then
		local ok, result = pcall(function()
			return request_2({ Url = str, Method = "GET", Headers = { ["User-Agent"] = "Onyx/2", Accept = "application/json" } })
		end)

		ok = ok and result

		if ok then
			ok = tonumber(result.StatusCode or 200) == 200
		end

		if ok then
			body = result.Body
		end
	end

	if not body then
		local ok, result = pcall(function()
			return game:HttpGet(str)
		end)

		if ok then
			body = result
		end
	end

	if not body then
		return nil
	end

	local ok, result = pcall(function()
		return game:GetService("HttpService"):JSONDecode(body)
	end)

	if not ok or type(result) ~= "table" or not result.guild then
		return nil
	end
	local icon = result.guild.id and result.guild.icon
	local str2 = nil

	if icon then
		str2 = "https://cdn.discordapp.com/icons/" .. result.guild.id .. "/" .. result.guild.icon .. ".png?size=1024"
	end

	tbl.discordInfo = {
		name = result.guild.name or "Bragas",
		members = result.approximate_member_count,
		online = result.approximate_presence_count,
		icon = str2,
	}

	return tbl.discordInfo
end

tbl.CLIPBOARD_FNS = {
	"setclipboard",
	"toclipboard",
	"tosetclipboard",
	"set_clipboard",
	"write_clipboard",
	"setClipboard",
}

tbl.copyText = function(arg)
	local genv = getgenv and getgenv() or _G

	for _, clipboardFn in ipairs(tbl.CLIPBOARD_FNS) do
		local value = rawget(genv, clipboardFn)
		local result

		if type(value) ~= "function" then
			local ok

			ok, result = pcall(function()
				return getfenv(0)[clipboardFn]
			end)

			if not (ok and type(result) == "function") then
				result = value
			end
		else
			result = value
		end

		if type(result) == "function" and pcall(result, arg) then
			return true
		end
	end

	local v3 = ipairs
	local tbl2 = {}
	local tbl3 = { syn, "write_clipboard" }
	local tbl4 = { syn, "set_clipboard" }
	local tbl5 = { rawget(genv, "Clipboard"), "set" }
	local tbl6 = { rawget(genv, "Clipboard"), "Set" }
	tbl2[1] = tbl3
	tbl2[2] = tbl4
	tbl2[3] = tbl5
	tbl2[4] = tbl6

	for _, v4 in v3(tbl2) do
		local v5 = v4[1]
		local v6 = v4[2]

		if type(v5) == "table" and type(rawget(v5, v6)) == "function" then
			if pcall(v5[v6], arg) then
				return true
			end
		end
	end

	return false
end

tbl.copyInvite = function()
	local str = "https://discord.gg/" .. tbl.DISCORD_INVITE
	return tbl.copyText(str), str
end

tbl.discordCard = function(arg)
	local v3 = tbl.discordFetch()

	local tbl2 = {
		Title = "Join Server",
		Callback = function()
			local v4, v5 = tbl.copyInvite()

			v:Notify({
				Title = v4 and "Copied!" or "Discord",
				Content = v4 and v5 .. " is on your clipboard." or v5,
				Duration = 5,
				Icon = v4 and "check" or "info",
			})
		end,
	}

	local paragraph = arg.Paragraph
	local tbl3 = { Title = v3 and v3.name or "Bragas" }
	local str

	if v3 then
		str = "Member Count : " .. tostring(v3.members or "?")
	else
		str = v3
	end

	tbl3.Desc = (str or "discord.gg/" .. tbl.DISCORD_INVITE) .. [[

Join our discord to report bugs, give suggestions or ask a question! If you can't, just ask in our YouTube description.]]

	tbl3.Image = v3 and v3.icon or "message-square-more"
	tbl3.ImageSize = 48
	tbl3.Buttons = { tbl2 }
	paragraph(arg, tbl3)
end

task.spawn(function()
	local RunService_ = game:GetService("RunService")

	for i = 1, 300 do
		local main = v2.UIElements and v2.UIElements.Main

		if main then
			if not tbl.bgAsset then
				local background = main:FindFirstChild("Background")
				local v3 = ipairs
				local children = background and background:GetChildren() or {}

				for _, child in v3(children) do
					if child:IsA("ImageLabel") and child.Size == UDim2.new(1, 0, 1, 0) and tostring(child.Image) ~= "" then
						tbl.bgAsset = child.Image
					end
				end
			end

			if not tbl.markIcon then
				local topbar = main:FindFirstChild("Topbar", true)
				local v3 = ipairs
				topbar = topbar and topbar:GetDescendants() or {}

				for _, v4 in v3(topbar) do
					if v4:IsA("ImageLabel") and v4.Size == UDim2.new(1, 0, 1, 0) and tostring(v4.Image):find("rbxassetid", 1, true) then
						tbl.markIcon = v4:Clone()
						break
					end
				end
			end

			if tbl.bgAsset and tbl.markIcon then
				return
			end
		end

		RunService_.RenderStepped:Wait()
	end
end)

tbl.card = function(arg)
	local tbl2 = arg or {}

	local function fn()
	end

	pcall(function()
		local hui = gethui and gethui() or CoreGui
		local onyxCard = hui:FindFirstChild("OnyxCard")

		if onyxCard then
			onyxCard:Destroy()
		end

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "OnyxCard"
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.DisplayOrder = 99999
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.Parent = hui
		local TweenService_ = game:GetService("TweenService")
		local color2 = Color3.fromRGB(140, 140, 165)
		local color3 = Color3.fromRGB(158, 158, 174)
		local color4 = Color3.fromRGB(168, 168, 184)
		local color5 = Color3.fromRGB(29, 29, 37)
		local color6 = Color3.fromRGB(233, 233, 242)
		local color7 = Color3.fromRGB(232, 232, 240)
		local color8 = Color3.fromRGB(22, 22, 28)
		local color9 = Color3.fromRGB(236, 236, 244)
		local actions = tbl2.actions
		local flag = type(actions) == "table" and #actions > 0
		local n = flag and 254 or 204
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.fromScale(1, 1)
		textButton.BackgroundColor3 = Color3.new(0, 0, 0)
		textButton.BackgroundTransparency = 1
		textButton.BorderSizePixel = 0
		textButton.AutoButtonColor = false
		textButton.Text = ""
		textButton.Parent = screenGui
		local frame = Instance.new("Frame")
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Position = UDim2.fromScale(0.5, 0.5)
		frame.Size = UDim2.fromOffset(math.min(440, math.max(300, (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.X or 800) - 40)), n)
		frame.BackgroundColor3 = Color3.fromRGB(23, 23, 28)
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.ClipsDescendants = true
		frame.Parent = screenGui
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 22)
		local uiScale = Instance.new("UIScale", frame)
		uiScale.Scale = 0.96
		local uiGradient = Instance.new("UIGradient", frame)
		uiGradient.Rotation = 90
		local new = ColorSequenceKeypoint.new
		local color10 = Color3.fromRGB
		uiGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 36)), new(1, color10(16, 16, 20)) })
		local uiStroke = Instance.new("UIStroke", frame)
		uiStroke.Color = color2
		uiStroke.Thickness = 1
		uiStroke.Transparency = 1
		local flag2 = tbl.bgAsset and tbl.bgAsset ~= ""
		local imageLabel = nil

		if flag2 then
			imageLabel = Instance.new("ImageLabel")
			imageLabel.Size = UDim2.fromScale(1, 1)
			imageLabel.BackgroundTransparency = 1
			imageLabel.Image = tbl.bgAsset
			imageLabel.ScaleType = Enum.ScaleType.Crop
			imageLabel.ImageTransparency = 1
			imageLabel.ZIndex = 0
			imageLabel.Parent = frame
			Instance.new("UICorner", imageLabel).CornerRadius = UDim.new(0, 22)
		end

		local frame2 = Instance.new("Frame")
		frame2.Position = UDim2.fromOffset(22, 20)
		frame2.Size = UDim2.fromOffset(48, 48)
		frame2.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
		frame2.BackgroundTransparency = 1
		frame2.BorderSizePixel = 0
		frame2.ZIndex = 1
		frame2.Parent = frame
		Instance.new("UICorner", frame2).CornerRadius = UDim.new(1, 0)
		local uiStroke2 = Instance.new("UIStroke", frame2)
		uiStroke2.Color = color2
		uiStroke2.Thickness = 1
		uiStroke2.Transparency = 1
		local clone

		if tbl.markIcon then
			clone = tbl.markIcon:Clone()
		else
			clone = Instance.new("ImageLabel")
			clone.Image = "rbxassetid://120139782405970"
		end

		clone.Name = "Mark"
		clone.AnchorPoint = Vector2.new(0.5, 0.5)
		clone.Position = UDim2.fromScale(0.5, 0.5)
		clone.Size = UDim2.fromOffset(26, 26)
		clone.BackgroundTransparency = 1
		clone.ImageColor3 = color6
		clone.ImageTransparency = 1
		clone.Visible = true
		clone.Parent = frame2
		local textLabel = Instance.new("TextLabel")
		textLabel.Position = UDim2.fromOffset(86, 22)
		textLabel.Size = UDim2.new(1, -108, 0, 26)
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 22
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextTransparency = 1
		textLabel.Text = tostring(tbl2.title or "Bragas")
		textLabel.ZIndex = 1
		textLabel.Parent = frame
		local uiGradient2 = Instance.new("UIGradient", textLabel)
		uiGradient2.Rotation = 10
		local colorSequence = ColorSequence.new
		local tbl3 = {}
		local v3 = ColorSequenceKeypoint.new(0, Color3.fromRGB(154, 154, 168))
		local v4 = ColorSequenceKeypoint.new(0.42, Color3.fromRGB(255, 255, 255))
		local v5 = ColorSequenceKeypoint.new(0.58, Color3.fromRGB(255, 255, 255))
		local new2 = ColorSequenceKeypoint.new
		local color11 = Color3.fromRGB
		tbl3[1] = v3
		tbl3[2] = v4
		tbl3[3] = v5

		do
			local values = table.pack(new2(1, color11(154, 154, 168)))
			table.move(values, 1, values.n, 4, tbl3)
		end

		uiGradient2.Color = colorSequence(tbl3)
		local textLabel2 = Instance.new("TextLabel")
		textLabel2.Position = UDim2.fromOffset(86, 50)
		textLabel2.Size = UDim2.new(1, -108, 0, 18)
		textLabel2.BackgroundTransparency = 1
		textLabel2.Font = Enum.Font.Gotham
		textLabel2.TextSize = 14
		textLabel2.TextXAlignment = Enum.TextXAlignment.Left
		textLabel2.TextColor3 = color3
		textLabel2.TextTransparency = 1
		textLabel2.Text = tostring(tbl2.subtitle or "")
		textLabel2.ZIndex = 1
		textLabel2.Parent = frame
		local textLabel3 = Instance.new("TextLabel")
		textLabel3.Position = UDim2.fromOffset(22, 82)
		textLabel3.Size = UDim2.new(1, -44, 0, 42)
		textLabel3.BackgroundTransparency = 1
		textLabel3.Font = Enum.Font.Gotham
		textLabel3.TextSize = 15
		textLabel3.LineHeight = 1.25
		textLabel3.TextWrapped = true
		textLabel3.TextXAlignment = Enum.TextXAlignment.Left
		textLabel3.TextYAlignment = Enum.TextYAlignment.Top
		textLabel3.TextColor3 = color4
		textLabel3.TextTransparency = 1
		textLabel3.Text = tostring(tbl2.body or "")
		textLabel3.ZIndex = 1
		textLabel3.Parent = frame
		local frame3 = Instance.new("Frame")
		frame3.Position = UDim2.fromOffset(22, 136)
		frame3.Size = UDim2.new(1, -44, 0, 48)
		frame3.BackgroundColor3 = color5
		frame3.BackgroundTransparency = 1
		frame3.BorderSizePixel = 0
		frame3.ZIndex = 1
		frame3.Parent = frame
		Instance.new("UICorner", frame3).CornerRadius = UDim.new(0, 14)
		local uiStroke3 = Instance.new("UIStroke", frame3)
		uiStroke3.Color = color2
		uiStroke3.Thickness = 1
		uiStroke3.Transparency = 1
		local textLabel4 = Instance.new("TextLabel")
		textLabel4.AnchorPoint = Vector2.new(0, 0.5)
		textLabel4.Position = UDim2.new(0, 15, 0.5, 0)
		textLabel4.Size = UDim2.new(1, -135, 0, 20)
		textLabel4.BackgroundTransparency = 1
		textLabel4.Font = Enum.Font.Gotham
		textLabel4.TextSize = 15
		textLabel4.TextXAlignment = Enum.TextXAlignment.Left
		textLabel4.TextColor3 = color6
		textLabel4.TextTransparency = 1
		textLabel4.Text = "discord.gg/" .. tbl.DISCORD_INVITE
		textLabel4.Parent = frame3
		local textButton2 = Instance.new("TextButton")
		textButton2.AnchorPoint = Vector2.new(1, 0.5)
		textButton2.Position = UDim2.new(1, -7, 0.5, 0)
		textButton2.Size = UDim2.fromOffset(100, 34)
		textButton2.BackgroundColor3 = color7
		textButton2.BackgroundTransparency = 1
		textButton2.BorderSizePixel = 0
		textButton2.AutoButtonColor = false
		textButton2.Font = Enum.Font.GothamMedium
		textButton2.TextSize = 15
		textButton2.TextColor3 = color8
		textButton2.TextTransparency = 1
		textButton2.Text = "Copy"
		textButton2.Parent = frame3
		Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 11)

		fn = function()
			pcall(function()
				screenGui:Destroy()
			end)
		end

		local function fn2(arg2, arg3)
			local n2 = 0

			local function fn3()
				local now = os.clock()
				if now - n2 < 0.25 then
					return
				end
				n2 = now
				arg3()
			end

			arg2.MouseButton1Click:Connect(fn3)
			arg2.TouchTap:Connect(fn3)
		end

		local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad)

		textButton2.MouseEnter:Connect(function()
			TweenService_:Create(textButton2, tweenInfo, { BackgroundColor3 = Color3.fromRGB(255, 255, 255) }):Play()
		end)

		textButton2.MouseLeave:Connect(function()
			TweenService_:Create(textButton2, tweenInfo, { BackgroundColor3 = color7 }):Play()
		end)

		local uiScale2 = Instance.new("UIScale", textButton2)

		textButton2.MouseButton1Down:Connect(function()
			TweenService_:Create(uiScale2, TweenInfo.new(0.07), { Scale = 0.96 }):Play()
		end)

		textButton2.MouseButton1Up:Connect(function()
			TweenService_:Create(uiScale2, TweenInfo.new(0.12), { Scale = 1 }):Play()
		end)

		fn2(textButton2, function()
			TweenService_:Create(uiScale2, TweenInfo.new(0.12), { Scale = 1 }):Play()
			tbl.copyInvite()
			textButton2.Text = "Copied"
			textLabel4.Text = "Copied to your clipboard"

			task.delay(1.8, function()
				if textButton2.Parent then
					textButton2.Text = "Copy"
				end

				if textLabel4.Parent then
					textLabel4.Text = "discord.gg/" .. tbl.DISCORD_INVITE
				end
			end)
		end)

		fn2(textButton, fn)
		local tbl4 = {}

		if flag then
			local frame4 = Instance.new("Frame")
			frame4.AnchorPoint = Vector2.new(1, 0)
			frame4.Position = UDim2.new(1, -22, 0, 196)
			frame4.Size = UDim2.new(1, -44, 0, 38)
			frame4.BackgroundTransparency = 1
			frame4.ZIndex = 1
			frame4.Parent = frame
			local uiListLayout = Instance.new("UIListLayout", frame4)
			uiListLayout.FillDirection = Enum.FillDirection.Horizontal
			uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			uiListLayout.Padding = UDim.new(0, 10)
			uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			local n2 = #actions
			local offset = uiListLayout.Padding.Offset
			local n3 = 0

			for _, action in ipairs(actions) do
				n3 += action.flex or 1
			end

			for i, action in ipairs(actions) do
				local tint = action.tint or action.primary and color7 or Color3.fromRGB(34, 34, 42)
				local primary = action.primary and color8 or color9
				local textButton3 = Instance.new("TextButton")
				textButton3.LayoutOrder = i
				local n4 = (action.flex or 1) / n3
				textButton3.Size = action.width and UDim2.fromOffset(action.width, 36) or UDim2.new(n4, -offset * (n2 - 1) * n4, 0, 36)
				textButton3.BackgroundColor3 = tint
				textButton3.BackgroundTransparency = 1
				textButton3.BorderSizePixel = 0
				textButton3.AutoButtonColor = false
				textButton3.Font = Enum.Font.GothamMedium
				textButton3.TextSize = 15
				textButton3.TextColor3 = primary
				textButton3.TextTransparency = 1
				textButton3.Text = tostring(action.label or "")
				textButton3.Parent = frame4
				Instance.new("UICorner", textButton3).CornerRadius = UDim.new(0, 11)

				if not action.primary and not action.tint then
					local uiStroke4 = Instance.new("UIStroke", textButton3)
					uiStroke4.Color = color2
					uiStroke4.Thickness = 1
					uiStroke4.Transparency = 1
					table.insert(tbl4, { obj = uiStroke4, prop = "Transparency", to = 0.5 })
				end

				table.insert(tbl4, { obj = textButton3, prop = "BackgroundTransparency", to = 0 })
				table.insert(tbl4, { obj = textButton3, prop = "TextTransparency", to = 0 })
				local uiScale3 = Instance.new("UIScale", textButton3)

				textButton3.MouseButton1Down:Connect(function()
					TweenService_:Create(uiScale3, TweenInfo.new(0.07), { Scale = 0.96 }):Play()
				end)

				textButton3.MouseButton1Up:Connect(function()
					TweenService_:Create(uiScale3, TweenInfo.new(0.12), { Scale = 1 }):Play()
				end)

				local callback = action.callback

				fn2(textButton3, function()
					TweenService_:Create(uiScale3, TweenInfo.new(0.12), { Scale = 1 }):Play()

					if action.closes ~= false then
						fn()
					end

					if callback then
						task.spawn(callback)
					end
				end)
			end
		end

		local tweenInfo2 = TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local tweenInfo3 = TweenInfo.new(0.34, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		frame.Position = UDim2.fromScale(0.5, 0.52)
		TweenService_:Create(frame, tweenInfo3, { Position = UDim2.fromScale(0.5, 0.5) }):Play()
		TweenService_:Create(uiScale, tweenInfo3, { Scale = 1 }):Play()
		TweenService_:Create(textButton, tweenInfo2, { BackgroundTransparency = 0.5 }):Play()
		TweenService_:Create(frame, tweenInfo2, { BackgroundTransparency = 0 }):Play()
		TweenService_:Create(uiStroke, tweenInfo2, { Transparency = 0.42 }):Play()
		TweenService_:Create(frame2, tweenInfo2, { BackgroundTransparency = 0 }):Play()
		TweenService_:Create(uiStroke2, tweenInfo2, { Transparency = 0.42 }):Play()
		TweenService_:Create(clone, tweenInfo2, { ImageTransparency = 0 }):Play()
		TweenService_:Create(textLabel, tweenInfo2, { TextTransparency = 0 }):Play()
		TweenService_:Create(textLabel2, tweenInfo2, { TextTransparency = 0 }):Play()
		TweenService_:Create(textLabel3, tweenInfo2, { TextTransparency = 0 }):Play()
		TweenService_:Create(frame3, tweenInfo2, { BackgroundTransparency = 0 }):Play()
		TweenService_:Create(uiStroke3, tweenInfo2, { Transparency = 0.42 }):Play()
		TweenService_:Create(textLabel4, tweenInfo2, { TextTransparency = 0 }):Play()
		TweenService_:Create(textButton2, tweenInfo2, { BackgroundTransparency = 0, TextTransparency = 0 }):Play()

		if imageLabel then
			TweenService_:Create(imageLabel, tweenInfo2, { ImageTransparency = 0.84 }):Play()
		end

		for _, v6 in ipairs(tbl4) do
			TweenService_:Create(v6.obj, tweenInfo2, { [v6.prop] = v6.to }):Play()
		end

		local timeout = tbl2.timeout or 25

		if timeout > 0 then
			task.delay(timeout, function()
				fn()
			end)
		end
	end)

	return fn
end

tbl.farewell = function()
	if _G.__OnyxReloading then
		return
	end

	if tbl.saidBye then
		return
	end
	tbl.saidBye = true

	tbl.card({
		title = "Bye bye!",
		subtitle = "Thanks for running Bragas",
		body = "Something let you down? Tell us in the server.",
	})
end

tbl.inLobbyNow = function()
	local localPlayer = game:GetService("Players").LocalPlayer
	localPlayer = localPlayer and localPlayer:FindFirstChild("PlayerGui")
	localPlayer = localPlayer and localPlayer:FindFirstChild("MainGUI")
	localPlayer = localPlayer and localPlayer:FindFirstChild("Game")
	if not localPlayer then
		return true
	end
	return localPlayer:FindFirstChild("Inventory") == nil
end

tbl.coinFails = {}
tbl.coinSkips = {}

tbl.coinSkip = function(arg)
	local v3 = tbl.coinSkips[arg]
	if not v3 then
		return false
	end

	if v3 < tick() then
		tbl.coinSkips[arg] = nil
		tbl.coinFails[arg] = nil
		return false
	end

	return true
end

tbl.coinFailed = function(arg)
	local n = (tbl.coinFails[arg] or 0) + 1
	tbl.coinFails[arg] = n

	if n >= 2 then
		tbl.coinSkips[arg] = tick() + 20
	end
end

tbl.coinReset = function()
	local v3 = tbl
	tbl.coinFails = {}
	v3.coinSkips = {}
end

pcall(function()
	if not (isfile and delfile) then
		return
	end

	if isfile("WindUI/OnyxV2/config/onyx_hud.json") then
		if writefile and not isfile(tbl.hudFile) then
			writefile(tbl.hudFile, readfile("WindUI/OnyxV2/config/onyx_hud.json"))
		end

		delfile("WindUI/OnyxV2/config/onyx_hud.json")
	end

	if listfiles then
		for _, v3 in ipairs(listfiles("WindUI/OnyxV2/config")) do
			local match = tostring(v3):match("[^/\\]+$") or ""

			if match:match("^onyx_hud") then
				local match2 = match:match("^onyx_hud_(.+)%.json$")

				if match2 and writefile then
					pcall(function()
						writefile(tbl.hudDir .. "/" .. match2 .. ".json", readfile(v3))
					end)
				end

				pcall(function()
					delfile(v3)
				end)
			end
		end
	end
end)

pcall(function()
	if isfile and isfile(tbl.hudFile) then
		local data = game:GetService("HttpService"):JSONDecode(readfile(tbl.hudFile))

		if type(data) == "table" then
			tbl.hudPos = data
		end
	end
end)

pcall(function()
	tbl.config = v2.ConfigManager:CreateConfig("autosave")

	if tbl.config and tbl.config.SetAsCurrent then
		tbl.config:SetAsCurrent()
	end
end)

Players = game:GetService("Players")
RunService = game:GetService("RunService")
Workspace = game:GetService("Workspace")
ReplicatedStorage = game:GetService("ReplicatedStorage")
CoreGui = game:GetService("CoreGui")
HttpService = game:GetService("HttpService")
CollectionService = game:GetService("CollectionService")
local localPlayer, flag, flag2, flag3, flag4, flag5, v3, fn, fn2, fn3
local fn4, fn5, fn6, fn7, fn8

do
	local function fn9(arg)
		pcall(function()
			CollectionService:AddTag(arg, "WeaponPassthrough")
		end)
	end

	localPlayer = Players.LocalPlayer

	espColors = {
		murderer = Color3.fromRGB(255, 0, 4),
		sheriff = Color3.fromRGB(0, 153, 255),
		innocent = Color3.fromRGB(0, 255, 8),
		gun = Color3.fromRGB(0, 153, 255),
		trap = Color3.fromHex("#A855F7"),
	}

	flag = false
	flag2 = false
	flag3 = false
	flag4 = false
	flag5 = false
	local v4 = nil
	local index = {}
	index.__index = index

	index.new = function()
		local obj = setmetatable({}, index)
		obj.ScreenGui = Instance.new("ScreenGui")
		obj.ScreenGui.Name = "OnyxESP"
		obj.ScreenGui.IgnoreGuiInset = true
		obj.ScreenGui.ResetOnSpawn = false
		obj.ScreenGui.Parent = CoreGui
		obj.Groups = {}
		return obj
	end

	index.Add = function(arg, adornee, arg2)
		if not adornee then
			return
		end
		local highlight = Instance.new("Highlight")
		highlight.Name = "HL_" .. HttpService:GenerateGUID(false)
		highlight.Adornee = adornee
		highlight.FillColor = arg2.Color
		highlight.OutlineColor = arg2.Color
		highlight.FillTransparency = arg2.FillTransparency
		highlight.OutlineTransparency = arg2.OutlineTransparency
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = arg.ScreenGui
		local tbl2 = arg.Groups[arg2.GroupName]

		if not tbl2 then
			tbl2 = {}
			arg.Groups[arg2.GroupName] = tbl2
		end

		table.insert(tbl2, highlight)

		if arg2.Label then
			local billboardGui = Instance.new("BillboardGui")
			billboardGui.Name = "LBL_" .. HttpService:GenerateGUID(false)
			billboardGui.Adornee = arg2.LabelAdornee or adornee
			billboardGui.AlwaysOnTop = true
			billboardGui.Size = UDim2.new(0, 140, 0, 16)
			billboardGui.StudsOffset = Vector3.new(0, arg2.LabelAdornee and 2.2 or 2, 0)

			if arg2.LabelMaxDistance then
				billboardGui.MaxDistance = arg2.LabelMaxDistance
			end

			billboardGui.Parent = arg.ScreenGui
			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, 0, 1, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.FredokaOne
			textLabel.TextSize = 11
			textLabel.TextColor3 = arg2.Color
			textLabel.Text = arg2.Label
			textLabel.Parent = billboardGui
			local uiStroke = Instance.new("UIStroke")
			uiStroke.Thickness = 0.5
			uiStroke.Color = Color3.new(0, 0, 0)
			uiStroke.Parent = textLabel
			table.insert(tbl2, billboardGui)
		end
	end

	index.RemoveGroup = function(arg, arg2)
		local v5 = arg.Groups[arg2]
		if not v5 then
			return
		end

		for _, v6 in ipairs(v5) do
			v6.Adornee = nil
			v6:Destroy()
		end

		arg.Groups[arg2] = nil
	end

	index.Destroy = function(arg)
		for k in pairs(arg.Groups) do
			arg:RemoveGroup(k)
		end

		if arg.ScreenGui then
			arg.ScreenGui:Destroy()
		end
	end

	v3 = index.new()

	fn = function()
		for _, player in ipairs(Players:GetPlayers()) do
			local backpack = player:FindFirstChildOfClass("Backpack")
			if backpack and backpack:FindFirstChild("Knife") then
				return player
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("Knife") then
				return player
			end
		end

		if v4 then
			for k, v5 in pairs(v4) do
				if v5.Role == "Murderer" and Players:FindFirstChild(k) then
					return Players:FindFirstChild(k)
				end
			end
		end

		return nil
	end

	fn2 = function()
		for _, player in ipairs(Players:GetPlayers()) do
			local backpack = player:FindFirstChildOfClass("Backpack")
			if backpack and backpack:FindFirstChild("Gun") then
				return player
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("Gun") then
				return player
			end
		end

		if v4 then
			for k, v5 in pairs(v4) do
				if v5.Role == "Sheriff" and Players:FindFirstChild(k) then
					return Players:FindFirstChild(k)
				end
			end
		end

		return nil
	end

	local function fn10(arg)
		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" and descendant.Transparency >= 1 then
				fn9(descendant)

				if tbl.revealed[descendant] == nil then
					tbl.revealed[descendant] = descendant.Transparency
				end

				descendant.Transparency = 0.9
			end
		end
	end

	ROLEBOX = { conns = {} }

	ROLEBOX.hide = function(arg)
		if not arg:IsA("BoxHandleAdornment") then
			return
		end
		arg.Visible = false

		table.insert(ROLEBOX.conns, arg:GetPropertyChangedSignal("Visible"):Connect(function()
			if arg.Visible then
				arg.Visible = false
			end
		end))
	end

	ROLEBOX.watch = function(arg)
		for _, descendant in ipairs(arg:GetDescendants()) do
			ROLEBOX.hide(descendant)
		end

		table.insert(ROLEBOX.conns, arg.DescendantAdded:Connect(ROLEBOX.hide))
	end

	ROLEBOX.start = function()
		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character then
				ROLEBOX.watch(player.Character)
			end

			table.insert(ROLEBOX.conns, player.CharacterAdded:Connect(ROLEBOX.watch))
		end

		table.insert(ROLEBOX.conns, Players.PlayerAdded:Connect(function(player)
			table.insert(ROLEBOX.conns, player.CharacterAdded:Connect(ROLEBOX.watch))
		end))
	end

	ROLEBOX.stop = function()
		for _, conn in ipairs(ROLEBOX.conns) do
			pcall(function()
				conn:Disconnect()
			end)
		end

		ROLEBOX.conns = {}

		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character then
				for _, descendant in ipairs(player.Character:GetDescendants()) do
					if descendant:IsA("BoxHandleAdornment") then
						descendant.Visible = true
					end
				end
			end
		end
	end

	ROLEBOX.start()

	fn3 = function()
		return flag or flag2 or flag3
	end

	fn4 = function()
		v3:RemoveGroup("players")
		if not fn3() then
			return
		end
		local n = 1

		if flag2 then
			n = 0.75
		end

		local n2 = 1

		if flag then
			n2 = 0.1
		end

		local v5 = fn()
		local v6 = fn2()

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				fn10(player.Character)
				local innocent = espColors.innocent

				if player == v5 then
					innocent = espColors.murderer
				elseif player == v6 then
					innocent = espColors.sheriff
				end

				v3:Add(player.Character, {
					Color = innocent,
					GroupName = "players",
					FillTransparency = n,
					OutlineTransparency = n2,
					Label = flag3 and player.DisplayName or nil,
					LabelAdornee = player.Character:FindFirstChild("Head"),
					LabelMaxDistance = 300,
				})
			end
		end
	end

	local function fn11(arg)
		v3:Add(arg, {
			Color = espColors.gun,
			GroupName = "gun",
			Label = "Gun",
			FillTransparency = 0.5,
			OutlineTransparency = 0,
		})
	end

	local function fn12(arg)
		fn9(arg)

		pcall(function()
			arg.Transparency = 0
		end)

		v3:Add(arg, {
			Color = espColors.trap,
			GroupName = "trap",
			Label = "Trap",
			FillTransparency = 0.5,
			OutlineTransparency = 0,
		})
	end

	fn5 = function()
		v3:RemoveGroup("gun")
		if not flag4 then
			return
		end

		for _, descendant in ipairs(Workspace:GetDescendants()) do
			if descendant.Name == "GunDrop" and (descendant:IsA("BasePart") or descendant:IsA("Model")) then
				fn11(descendant)
			end
		end
	end

	fn6 = function()
		v3:RemoveGroup("trap")
		if not flag5 then
			return
		end

		for _, descendant in ipairs(Workspace:GetDescendants()) do
			if descendant.Name == "Trap" and descendant.Parent and (descendant.Parent:IsA("Folder") or descendant.Parent:IsA("Model")) then
				fn12(descendant)
			end
		end
	end

	local n = 0

	tbl.espRecolourSoon = function()
		if not fn3() then
			return
		end
		pcall(fn4)

		for _, v5 in ipairs({ 0.1, 0.3, 0.6 }) do
			task.delay(v5, function()
				if fn3() then
					pcall(fn4)
				end
			end)
		end
	end

	pcall(function()
		tbl.conns[#tbl.conns + 1] = Workspace.DescendantAdded:Connect(function(descendant)
			if flag5 and descendant.Name == "Trap" and descendant.Parent and (descendant.Parent:IsA("Folder") or descendant.Parent:IsA("Model")) then
				fn12(descendant)
			end

			if descendant.Name == "Gun" and descendant:IsA("Tool") then
				if descendant.Parent and Players:GetPlayerFromCharacter(descendant.Parent) then
					tbl.espRecolourSoon()
				end
			end

			if descendant.Name == "GunDrop" and (descendant:IsA("BasePart") or descendant:IsA("Model")) then
				if flag4 then
					fn11(descendant)
				end

				if tick() - n > 3 then
					n = tick()
					tbl.playSfx("gun")

					v:Notify({
						Title = "Gun Dropped!",
						Content = "The sheriff died — the gun is on the floor.",
						Duration = 5,
						Icon = "crosshair",
					})
				end
			end
		end)

		tbl.conns[#tbl.conns + 1] = Workspace.DescendantRemoving:Connect(function(descendant)
			if flag4 and descendant.Name == "GunDrop" then
				task.defer(fn5)
			end

			if flag5 and descendant.Name == "Trap" then
				task.defer(fn6)
			end

			if descendant.Name == "GunDrop" then
				task.defer(tbl.espRecolourSoon)
			end
		end)
	end)

	local flag6 = false

	fn7 = function()
		if flag6 then
			return
		end
		flag6 = true

		task.spawn(function()
			while flag6 do
				task.wait(1)

				if fn3() then
					pcall(fn4)
				end
			end
		end)
	end

	fn8 = function()
		flag6 = false
	end

	tbl.tr = {
		lines = false,
		dist = false,
		arrows = false,
		parts = {},
		murd = nil,
		sher = nil,
		roleAt = 0,
		conn = nil,
	}

	tbl.tr.any = function()
		return tbl.tr.lines or tbl.tr.dist or tbl.tr.arrows
	end

	tbl.tr.colorOf = function(arg)
		if arg == tbl.tr.murd then
			return espColors.murderer
		end

		if arg == tbl.tr.sher then
			return espColors.sheriff
		end
		return espColors.innocent
	end

	tbl.tr.slot = function(arg)
		local v5 = tbl.tr.parts[arg]
		if v5 and v5.line and v5.line.Parent then
			return v5
		end
		local screenGui = v3 and v3.ScreenGui
		if not screenGui or not screenGui.Parent then
			return nil
		end
		local tbl2 = { line = Instance.new("Frame") }
		tbl2.line.Name = "OnyxTracer"
		tbl2.line.AnchorPoint = Vector2.new(0.5, 0.5)
		tbl2.line.BorderSizePixel = 0
		tbl2.line.Visible = false
		tbl2.line.ZIndex = 2
		tbl2.line.Parent = screenGui
		tbl2.lbl = Instance.new("TextLabel")
		tbl2.lbl.Name = "OnyxDist"
		tbl2.lbl.AnchorPoint = Vector2.new(0.5, 0)
		tbl2.lbl.BackgroundTransparency = 1
		tbl2.lbl.Size = UDim2.fromOffset(90, 14)
		tbl2.lbl.Font = Enum.Font.FredokaOne
		tbl2.lbl.TextSize = 11
		tbl2.lbl.Visible = false
		tbl2.lbl.ZIndex = 3
		tbl2.lbl.Parent = screenGui
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Thickness = 0.5
		uiStroke.Color = Color3.new(0, 0, 0)
		uiStroke.Parent = tbl2.lbl
		tbl2.arw = Instance.new("TextLabel")
		tbl2.arw.Name = "OnyxArrow"
		tbl2.arw.AnchorPoint = Vector2.new(0.5, 0.5)
		tbl2.arw.BackgroundTransparency = 1
		tbl2.arw.Size = UDim2.fromOffset(28, 28)
		tbl2.arw.Font = Enum.Font.SourceSansBold
		tbl2.arw.TextSize = 24
		tbl2.arw.Text = utf8.char(9650)
		tbl2.arw.Visible = false
		tbl2.arw.ZIndex = 3
		tbl2.arw.Parent = screenGui
		local uiStroke2 = Instance.new("UIStroke")
		uiStroke2.Thickness = 1
		uiStroke2.Color = Color3.new(0, 0, 0)
		uiStroke2.Parent = tbl2.arw
		tbl.tr.parts[arg] = tbl2
		return tbl2
	end

	tbl.tr.drop = function(arg)
		local v5 = tbl.tr.parts[arg]
		if not v5 then
			return
		end
		tbl.tr.parts[arg] = nil

		for _, v6 in pairs(v5) do
			pcall(function()
				v6:Destroy()
			end)
		end
	end

	tbl.tr.step = function()
		local currentCamera = Workspace.CurrentCamera
		if not currentCamera then
			return
		end
		local viewportSize = currentCamera.ViewportSize
		if viewportSize.X < 1 or viewportSize.Y < 1 then
			return
		end
		local now = os.clock()

		if now - tbl.tr.roleAt > 0.5 then
			tbl.tr.roleAt = now
			tbl.tr.murd = fn()
			tbl.tr.sher = fn2()

			for k in pairs(tbl.tr.parts) do
				if k.Parent == nil then
					tbl.tr.drop(k)
				end
			end
		end

		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		local n2 = viewportSize.X * 0.5
		local y = viewportSize.Y
		local n3 = viewportSize.X * 0.5
		local n4 = viewportSize.Y * 0.5
		local n5 = math.min(viewportSize.X, viewportSize.Y) * 0.33
		local v5 = tbl.tr.any()

		for _, player in ipairs(Players:GetPlayers()) do
			local v6 = tbl.tr.parts[player]
			local character2 = player ~= localPlayer and player.Character or nil
			local humanoidRootPart = character2 and character2:FindFirstChild("HumanoidRootPart")
			character2 = character2 and character2:FindFirstChildOfClass("Humanoid")

			if v5 and humanoidRootPart and character2 and character2.Health > 0 then
				v6 = v6 or tbl.tr.slot(player)
			elseif v6 then
				local lbl = v6.lbl
				local arw = v6.arw
				v6.line.Visible = false
				lbl.Visible = false
				arw.Visible = false
				v6 = nil
			end

			if v6 then
				local v7 = tbl.tr.colorOf(player)
				local v8, flag7 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)
				local flag8 = v8.Z <= 0
				flag7 = flag7 and not flag8

				if tbl.tr.lines and flag7 then
					local n6 = v8.X - n2
					local n7 = v8.Y - y
					v6.line.BackgroundColor3 = v7
					v6.line.Size = UDim2.fromOffset(2, math.sqrt(n6 * n6 + n7 * n7))
					v6.line.Position = UDim2.fromOffset(n2 + n6 * 0.5, y + n7 * 0.5)
					v6.line.Rotation = math.deg(math.atan2(n7, n6)) - 90
					v6.line.Visible = true
				else
					v6.line.Visible = false
				end

				if tbl.tr.dist and flag7 then
					local magnitude = character and (humanoidRootPart.Position - character.Position).Magnitude or (humanoidRootPart.Position - currentCamera.CFrame.Position).Magnitude
					local v9 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position - Vector3.new(0, 3.2, 0))
					v6.lbl.TextColor3 = v7
					v6.lbl.Text = math.floor(magnitude + 0.5) .. "m"
					v6.lbl.Position = UDim2.fromOffset(v9.X, v9.Y)
					v6.lbl.Visible = true
				else
					v6.lbl.Visible = false
				end

				if tbl.tr.arrows and not flag7 then
					local n6 = v8.X - n3
					local n7 = v8.Y - n4

					if flag8 then
						n6 = -n6
						n7 = -n7
					end

					local n8 = math.sqrt(n6 * n6 + n7 * n7)

					if n8 < 1 then
						n6 = 0
						n7 = -1
						n8 = 1
					end

					v6.arw.TextColor3 = v7
					v6.arw.Position = UDim2.fromOffset(n3 + n6 / n8 * n5, n4 + n7 / n8 * n5)
					v6.arw.Rotation = math.deg(math.atan2(n7, n6)) + 90
					v6.arw.Visible = true
				else
					v6.arw.Visible = false
				end
			end
		end
	end

	tbl.tr.start = function()
		if tbl.tr.conn then
			return
		end

		tbl.tr.conn = RunService.RenderStepped:Connect(function()
			pcall(tbl.tr.step)
		end)
	end

	tbl.tr.stop = function()
		if tbl.tr.conn then
			pcall(function()
				tbl.tr.conn:Disconnect()
			end)

			tbl.tr.conn = nil
		end

		for k in pairs(tbl.tr.parts) do
			tbl.tr.drop(k)
		end
	end

	tbl.tr.sync = function()
		if tbl.tr.any() then
			tbl.tr.start()
		else
			tbl.tr.stop()
		end
	end

	pcall(function()
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		remotes = remotes and remotes:FindFirstChild("Gameplay")
		local playerDataChanged = remotes and remotes:FindFirstChild("PlayerDataChanged")

		if playerDataChanged and playerDataChanged:IsA("RemoteEvent") then
			tbl.conns[#tbl.conns + 1] = playerDataChanged.OnClientEvent:Connect(function(arg)
				v4 = arg

				if fn3() then
					fn4()
				end
			end)
		end
	end)
end

TeleportService = game:GetService("TeleportService")
local flag6, fn9, flag7, fn10, fn11, fn12, fn13, fn14, fn15

do
	local placeId = game.PlaceId
	local jobId = game.JobId
	flag6 = false

	fn9 = function(arg)
		if flag6 then
			v:Notify({
				Title = "Fling Active!",
				Content = "Wait for the current fling to finish!",
				Duration = 1.5,
				Icon = "clock",
			})

			return
		end

		if not arg or not arg.Character then
			v:Notify({ Title = "Error!", Content = "Could not find that player!", Duration = 1.5, Icon = "x" })
			return
		end

		if not arg.Character:FindFirstChildOfClass("Humanoid") then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end
		local rootPart = humanoid.RootPart
		if not rootPart then
			return
		end
		flag6 = true
		local cFrame = rootPart.CFrame
		local fallenPartsDestroyHeight = Workspace.FallenPartsDestroyHeight
		local health = humanoid.Health
		local character2 = arg.Character
		local humanoid2 = character2:FindFirstChildOfClass("Humanoid")
		local rootPart2 = humanoid2 and humanoid2.RootPart
		local head = character2:FindFirstChild("Head")
		local accessory = character2:FindFirstChildOfClass("Accessory")
		accessory = accessory and accessory:FindFirstChild("Handle")
		if humanoid2 and humanoid2.Sit then
			flag6 = false
			return
		end

		if head then
			Workspace.CurrentCamera.CameraSubject = head
		elseif accessory then
			Workspace.CurrentCamera.CameraSubject = accessory
		elseif humanoid2 then
			Workspace.CurrentCamera.CameraSubject = humanoid2
		end

		local function fn16(arg2, arg3, arg4)
			rootPart.CFrame = CFrame.new(arg2.Position) * arg3 * arg4

			pcall(function()
				character:SetPrimaryPartCFrame(CFrame.new(arg2.Position) * arg3 * arg4)
			end)

			rootPart.Velocity = Vector3.new(90000000, 900000000, 90000000)
			rootPart.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
		end

		local function fn17(arg2)
			local now = tick()
			local n = 0

			while true do
				if not (not rootPart or not humanoid2 or not flag6) then
					if arg2.Velocity.Magnitude < 50 then
						n += 100
						local n2 = humanoid2.MoveDirection * arg2.Velocity.Magnitude / 1.25
						local cframe = CFrame.Angles
						fn16(arg2, CFrame.new(0, 1.5, 0) + n2, cframe(math.rad(n), 0, 0))
						task.wait()
						local n3 = humanoid2.MoveDirection * arg2.Velocity.Magnitude / 1.25
						local cframe2 = CFrame.Angles
						fn16(arg2, CFrame.new(0, -1.5, 0) + n3, cframe2(math.rad(n), 0, 0))
						task.wait()
						local n4 = humanoid2.MoveDirection * arg2.Velocity.Magnitude / 1.25
						local cframe3 = CFrame.Angles
						fn16(arg2, CFrame.new(2.25, 1.5, -2.25) + n4, cframe3(math.rad(n), 0, 0))
						task.wait()
						local n5 = humanoid2.MoveDirection * arg2.Velocity.Magnitude / 1.25
						local cframe4 = CFrame.Angles
						fn16(arg2, CFrame.new(-2.25, -1.5, 2.25) + n5, cframe4(math.rad(n), 0, 0))
						task.wait()
						local moveDirection = humanoid2.MoveDirection
						local cframe5 = CFrame.Angles
						fn16(arg2, CFrame.new(0, 1.5, 0) + moveDirection, cframe5(math.rad(n), 0, 0))
						task.wait()
						local moveDirection2 = humanoid2.MoveDirection
						local cframe6 = CFrame.Angles
						fn16(arg2, CFrame.new(0, -1.5, 0) + moveDirection2, cframe6(math.rad(n), 0, 0))
						task.wait()
					else
						local cframe = CFrame.Angles
						fn16(arg2, CFrame.new(0, 1.5, humanoid2.WalkSpeed), cframe(1.5707963267948966, 0, 0))
						task.wait()
						local cframe2 = CFrame.Angles
						fn16(arg2, CFrame.new(0, -1.5, -humanoid2.WalkSpeed), cframe2(0, 0, 0))
						task.wait()
						local cframe3 = CFrame.Angles
						fn16(arg2, CFrame.new(0, 1.5, humanoid2.WalkSpeed), cframe3(1.5707963267948966, 0, 0))
						task.wait()
						local cframe4 = CFrame.Angles
						fn16(arg2, CFrame.new(0, -1.5, 0), cframe4(1.5707963267948966, 0, 0))
						task.wait()
						local cframe5 = CFrame.Angles
						fn16(arg2, CFrame.new(0, -1.5, 0), cframe5(0, 0, 0))
						task.wait()
						local cframe6 = CFrame.Angles
						fn16(arg2, CFrame.new(0, -1.5, 0), cframe6(-1.5707963267948966, 0, 0))
						task.wait()
						local cframe7 = CFrame.Angles
						fn16(arg2, CFrame.new(0, -1.5, 0), cframe7(0, 0, 0))
						task.wait()
					end

					if not (arg2.Velocity.Magnitude > 500 or arg2.Parent ~= arg.Character or arg.Parent ~= Players or humanoid.Health <= 0 or humanoid.Health < health or humanoid2 and humanoid2.Sit or tick() > now + 2 or not flag6) then
						continue
					end
				end

				break
			end
		end

		Workspace.FallenPartsDestroyHeight = (0/0)
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Name = "SkidFlingBV"
		bodyVelocity.Parent = rootPart
		bodyVelocity.Velocity = Vector3.zero
		bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

		pcall(function()
			if rootPart2 and head then
				if (rootPart2.CFrame.p - head.CFrame.p).Magnitude <= 5 then
					fn17(rootPart2)
				else
					fn17(head)
				end
			elseif rootPart2 then
				fn17(rootPart2)
			elseif head then
				fn17(head)
			elseif accessory then
				fn17(accessory)
			end
		end)

		bodyVelocity:Destroy()
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
		Workspace.CurrentCamera.CameraSubject = humanoid

		if cFrame then
			pcall(function()
				for i = 1, 50 do
					rootPart.CFrame = cFrame * CFrame.new(0, 0.5, 0)

					pcall(function()
						character:SetPrimaryPartCFrame(cFrame * CFrame.new(0, 0.5, 0))
					end)

					humanoid:ChangeState("GettingUp")

					for _, child in ipairs(character:GetChildren()) do
						if child:IsA("BasePart") then
							child.Velocity = Vector3.zero
							child.RotVelocity = Vector3.zero
						end
					end

					task.wait()
					if not ((rootPart.Position - cFrame.p).Magnitude < 25) then
						continue
					end
					break
				end
			end)
		end

		Workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight
		flag6 = false

		if humanoid.Health <= 0 then
			v:Notify({
				Title = "Fling Backfired",
				Content = arg.Name .. " killed you mid-fling.",
				Duration = 3,
				Icon = "x",
			})
		elseif humanoid.Health < health then
			v:Notify({
				Title = "Flinged!",
				Content = "Flinged " .. arg.Name .. " - took a hit, bailed early.",
				Duration = 2,
				Icon = "flame",
			})
		else
			v:Notify({ Title = "Flinged!", Content = "Flinged " .. arg.Name .. "!", Duration = 1.5, Icon = "flame" })
		end
	end

	flag7 = false
	local flag8 = false

	fn10 = function()
		return nil
	end

	fn11 = function()
		if flag8 then
			return
		end
		flag8 = true

		task.spawn(function()
			while flag7 do
				task.wait(0.5)

				pcall(function()
					if not flag7 then
						return
					end

					if flag6 then
						return
					end
					local v4 = fn10()
					if not v4 then
						return
					end
					local v5 = Players:FindFirstChild(v4)

					if v5 and v5 ~= localPlayer and v5.Character then
						fn9(v5)
					end
				end)

				if flag6 then
					while flag6 and flag7 do
						task.wait(0.2)
					end

					task.wait(1)
				end
			end

			flag8 = false
		end)
	end

	fn12 = function()
		flag7 = false
	end

	fn13 = function(arg, arg2)
		arg = arg and arg.Character
		if not arg or not arg:FindFirstChild("HumanoidRootPart") then
			v:Notify({ Title = "Error!", Content = "No " .. arg2 .. " found!", Duration = 1.5, Icon = "x" })
			return
		end
		local character = localPlayer.Character
		if not character or not character:FindFirstChild("HumanoidRootPart") then
			return
		end
		character.HumanoidRootPart.Velocity = Vector3.zero
		character.HumanoidRootPart.CFrame = arg.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
		v:Notify({ Title = "Teleported!", Content = "Teleported to " .. arg2, Duration = 1.5, Icon = "check" })
	end

	local function fn16(arg)
		local ok, result = pcall(function()
			if syn and syn.request then
				return HttpService:JSONDecode(syn.request({ Url = arg, Method = "GET" }).Body)
			end

			if http and http.request then
				return HttpService:JSONDecode(http.request({ Url = arg, Method = "GET" }).Body)
			end

			if request then
				return HttpService:JSONDecode(request({ Url = arg, Method = "GET" }).Body)
			end

			if httpget then
				return HttpService:JSONDecode(httpget(arg))
			end
			return HttpService:JSONDecode(game:HttpGet(arg))
		end)

		if ok then
			return result
		end
		return nil
	end

	fn14 = function()
		v:Notify({ Title = "Server Hop", Content = "Teleporting to a new server...", Duration = 3, Icon = "loader" })
		task.wait(0.5)

		local ok, result = pcall(function()
			TeleportService:Teleport(placeId)
		end)

		if not ok then
			v:Notify({ Title = "Error!", Content = "Failed to hop: " .. tostring(result), Duration = 3, Icon = "x" })
		end
	end

	fn15 = function()
		v:Notify({
			Title = "Smallest Server",
			Content = "Finding the emptiest server...",
			Duration = 3,
			Icon = "loader",
		})

		local tbl2 = {}
		local n = 0
		local str = ""

		while n < 5 do
			n += 1
			local str2 = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"

			if str and str ~= "" then
				str2 ..= "&cursor=" .. str
			end

			local v4 = fn16(str2)
			if not v4 or not v4.data then
				break
			end

			for _, v5 in ipairs(v4.data) do
				if v5.id ~= jobId and v5.playing and v5.maxPlayers and v5.playing < v5.maxPlayers then
					table.insert(tbl2, v5)
				end
			end

			str = v4.nextPageCursor
			if not str or str == "" then
				break
			end
		end

		if #tbl2 == 0 then
			v:Notify({
				Title = "No Servers!",
				Content = "No joinable servers found. Trying random hop...",
				Duration = 2,
				Icon = "x",
			})

			task.wait(1)

			pcall(function()
				TeleportService:Teleport(placeId)
			end)

			return
		end

		table.sort(tbl2, function(arg, arg2)
			return arg.playing < arg2.playing
		end)

		local v4 = tbl2[1]

		v:Notify({
			Title = "Joining!",
			Content = "Joining server with " .. v4.playing .. " players...",
			Duration = 2,
			Icon = "check",
		})

		task.wait(0.5)

		pcall(function()
			TeleportService:TeleportToPlaceInstance(placeId, v4.id)
		end)
	end

	tbl.HOP_MIN_PLAYERS = 2
	tbl.HOP_GRACE = 15
	tbl.HOP_RETRY = 60
	tbl.HOP_CONFIRM = 6
	tbl.hopThread = nil
	tbl.hopping = false

	tbl.hopAttempt = function()
		v:Notify({
			Title = "Server Empty",
			Content = "Under " .. tbl.HOP_MIN_PLAYERS .. " players here - hopping...",
			Duration = 4,
			Icon = "loader",
		})

		task.wait(0.5)

		if pcall(function()
			TeleportService:Teleport(placeId)
		end) then
			task.wait(tbl.HOP_CONFIRM)
		end

		v:Notify({
			Title = "Matchmaking Refused",
			Content = "Picking from the server list...",
			Duration = 3,
			Icon = "x",
		})

		local v4 = nil
		local n = 0
		local str = ""

		while n < 4 do
			n += 1
			local str2 = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100"

			if str ~= "" then
				str2 ..= "&cursor=" .. str
			end

			local v5 = fn16(str2)

			if not (not v5 or not v5.data) then
				for _, v6 in ipairs(v5.data) do
					if v6.id ~= jobId and v6.playing and v6.maxPlayers and v6.playing < v6.maxPlayers then
						if not v4 or v6.playing > v4.playing then
							v4 = v6
						end
					end
				end

				str = v5.nextPageCursor or ""
				if str ~= "" then
					continue
				end
			end

			break
		end

		if v4 then
			v:Notify({
				Title = "Hopping",
				Content = "Joining a server with " .. v4.playing .. " players...",
				Duration = 3,
				Icon = "check",
			})

			task.wait(0.5)

			if pcall(function()
				TeleportService:TeleportToPlaceInstance(placeId, v4.id)
			end) then
				task.wait(tbl.HOP_CONFIRM)
			end
		end

		return false
	end
end

tbl.populatedHop = function()
	if tbl.hopping then
		return false
	end
	tbl.hopping = true
	local ok, result = pcall(tbl.hopAttempt)
	if ok and result then
		return true
	end
	tbl.hopping = false

	v:Notify({
		Title = "Hop Failed",
		Content = ok and "The server would not let go. Trying again in a minute." or "Hop errored - trying again in a minute.",
		Duration = 4,
		Icon = "x",
	})

	return false
end

tbl.stopFarmHopWatch = function()
	if tbl.hopThread then
		pcall(task.cancel, tbl.hopThread)
		tbl.hopThread = nil
	end
end

tbl.startFarmHopWatch = function()
	tbl.stopFarmHopWatch()

	tbl.hopThread = task.spawn(function()
		local n = 0

		while true do
			task.wait(3)
			if not tbl.farmHopOn then
				n = 0
				continue
			end

			if not (#Players:GetPlayers() < tbl.HOP_MIN_PLAYERS) then
				n = 0
				continue
			end
			n += 3
			if not (tbl.HOP_GRACE <= n) then
				continue
			end
			local ok, result = pcall(tbl.populatedHop)
			local flag8 = false

			if ok then
				flag8 = result and true or false
			end

			if not flag8 then
				task.wait(tbl.HOP_RETRY)
				n = 0
				continue
			end

			break
		end
	end)
end

UserInputService = game:GetService("UserInputService")
tbl.touches = {}

pcall(function()
	tbl.conns[#tbl.conns + 1] = UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			tbl.touches[input] = true
		end
	end)
end)

tbl.pointerHeld = function()
	for k in pairs(tbl.touches) do
		if k.UserInputState == Enum.UserInputState.End or k.UserInputState == Enum.UserInputState.Cancel then
			tbl.touches[k] = nil
		end
	end

	if next(tbl.touches) then
		return true
	end
	local flag8 = false

	pcall(function()
		for _, v4 in ipairs(UserInputService:GetMouseButtonsPressed()) do
			if v4.UserInputType == Enum.UserInputType.MouseButton1 then
				flag8 = true
			end
		end
	end)

	return flag8
end

task.spawn(function()
	while _G.OnyxV2 == v2 do
		task.wait(0.25)

		if v.CurrentInput ~= nil and not tbl.pointerHeld() then
			v.CurrentInput = nil
		end
	end
end)

local flag8
flag8 = false
local flag9, n, flag10, flag11, walkSpeed, jumpPower, fn16, fn17, fn18, fn19
local fn20, fn21, fn22, fn23, fn24, fn25

do
	local connection = nil
	flag9 = false
	local connection2 = nil
	local bodyVelocity = nil
	local bodyGyro = nil
	n = 50
	flag10 = false
	local connection3 = nil
	local n2 = 0
	flag11 = false
	local connection4 = nil
	walkSpeed = 16
	jumpPower = 50

	fn16 = function(walkSpeed2)
		walkSpeed = walkSpeed2

		pcall(function()
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.WalkSpeed = walkSpeed2
			end
		end)
	end

	fn17 = function(jumpPower2)
		jumpPower = jumpPower2

		pcall(function()
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.JumpPower = jumpPower2
				humanoid.UseJumpPower = true
			end
		end)
	end

	fn18 = function()
		if connection then
			return
		end

		connection = RunService.Stepped:Connect(function()
			if not flag8 then
				return
			end

			pcall(function()
				local character = localPlayer.Character

				if character then
					for _, descendant in ipairs(character:GetDescendants()) do
						if descendant:IsA("BasePart") and descendant.CanCollide then
							if tbl.clipWas[descendant] == nil then
								tbl.clipWas[descendant] = true
							end

							descendant.CanCollide = false
						end
					end
				end
			end)
		end)
	end

	fn19 = function()
		if connection then
			connection:Disconnect()
			connection = nil
		end

		tbl.reclip(tbl.clipWas)
	end

	fn20 = function()
		if connection2 then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end
		bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Name = "FlyVelocity"
		bodyVelocity.Velocity = Vector3.zero
		bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bodyVelocity.Parent = humanoidRootPart
		bodyGyro = Instance.new("BodyGyro")
		bodyGyro.Name = "FlyGyro"
		bodyGyro.P = 90000
		bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.CFrame = humanoidRootPart.CFrame
		bodyGyro.Parent = humanoidRootPart
		humanoid.PlatformStand = true

		connection2 = RunService.Heartbeat:Connect(function()
			pcall(function()
				if not flag9 then
					return
				end
				local currentCamera = Workspace.CurrentCamera
				bodyGyro.CFrame = currentCamera.CFrame
				local v4 = UserInputService
				local vector = Vector3.zero

				if v4:IsKeyDown(Enum.KeyCode.W) then
					vector = Vector3.zero + currentCamera.CFrame.LookVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					vector -= currentCamera.CFrame.LookVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					vector -= currentCamera.CFrame.RightVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					vector += currentCamera.CFrame.RightVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					vector += Vector3.new(0, 1, 0)
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
					vector -= Vector3.new(0, 1, 0)
				end

				if vector.Magnitude > 0 then
					bodyVelocity.Velocity = vector.Unit * n
				else
					bodyVelocity.Velocity = Vector3.zero
				end
			end)
		end)
	end

	fn21 = function()
		if connection2 then
			connection2:Disconnect()
			connection2 = nil
		end

		if bodyVelocity then
			bodyVelocity:Destroy()
			bodyVelocity = nil
		end

		if bodyGyro then
			bodyGyro:Destroy()
			bodyGyro = nil
		end

		pcall(function()
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.PlatformStand = false
			end
		end)
	end

	fn22 = function()
		if connection3 then
			return
		end

		connection3 = UserInputService.JumpRequest:Connect(function()
			if not flag10 then
				return
			end
			local now = tick()
			if now - n2 < 0.15 then
				return
			end
			n2 = now

			pcall(function()
				local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
				local flag12

				if humanoid then
					local jumping = Enum.HumanoidStateType.Jumping
					flag12 = humanoid:GetState() ~= jumping
				else
					flag12 = humanoid
				end

				if flag12 then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end)
		end)
	end

	fn23 = function()
		if connection3 then
			connection3:Disconnect()
			connection3 = nil
		end
	end

	fn24 = function()
		if connection4 then
			return
		end

		connection4 = RunService.Heartbeat:Connect(function()
			if not flag11 then
				return
			end

			pcall(function()
				local character = localPlayer.Character
				if not character then
					return
				end
				local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart then
					return
				end

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= localPlayer and player.Character then
						for _, descendant in ipairs(player.Character:GetDescendants()) do
							if descendant:IsA("BasePart") and not descendant.Anchored and descendant.Velocity.Magnitude > 200 then
								if (descendant.Position - humanoidRootPart.Position).Magnitude < 30 then
									descendant.Velocity = Vector3.zero
									descendant.RotVelocity = Vector3.zero
									descendant.Anchored = true

									task.delay(0.3, function()
										if descendant and descendant.Parent then
											descendant.Anchored = false
										end
									end)
								end
							end
						end
					end
				end
			end)
		end)
	end

	fn25 = function()
		if connection4 then
			connection4:Disconnect()
			connection4 = nil
		end
	end
end

tbl.conns[#tbl.conns + 1] = localPlayer.CharacterAdded:Connect(function(character)
	character:WaitForChild("Humanoid")
	task.wait(0.5)

	pcall(function()
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			if walkSpeed ~= 16 then
				humanoid.WalkSpeed = walkSpeed
			end

			if jumpPower ~= 50 then
				humanoid.JumpPower = jumpPower
				humanoid.UseJumpPower = true
			end
		end
	end)

	if flag9 then
		pcall(fn21)
		task.wait(0.2)
		pcall(fn20)
	end

	if flag8 then
		pcall(fn19)
		pcall(fn18)
	end
end)

TweenService = game:GetService("TweenService")
VirtualUser = game:GetService("VirtualUser")
local v4, n2, flag12, flag13, fn26, fn27, fn28, fn29, fn30, fn31
local fn32

do
	local flag14 = false
	local flag15 = false
	v4 = nil
	local flag16 = nil
	local flag17 = false
	local tween = nil
	local v5 = nil
	local connection = nil
	n2 = 23
	local n3 = 0
	local v6 = nil
	flag12 = false
	local flag18 = false
	flag13 = false
	local connection2 = nil

	local function fn33(arg, arg2, arg3)
		local v7 = next
		local children, v8 = arg:GetChildren()

		for _, v9 in v7, children, v8 do
			if v9.Name == arg2 and (not arg3 or v9.ClassName == arg3) then
				return v9
			end
		end
	end

	fn26 = function(arg)
		if arg and arg.Character then
			return fn33(arg.Character, "HumanoidRootPart") or fn33(arg.Character, "PrimaryPart")
		end
	end

	local function fn34()
		local v7 = fn26(localPlayer)
		if not v7 or not v4 then
			return nil
		end
		local coinContainer = fn33(v4, "CoinContainer")
		if not coinContainer then
			return nil
		end
		local v8 = next
		local children, v9 = coinContainer:GetChildren()
		local huge = math.huge
		local v10 = nil

		for _, v11 in v8, children, v9 do
			if v11.Name == "Coin_Server" and not v11:GetAttribute("Collected") and not tbl.coinSkip(v11) then
				local magnitude = (v7.Position - v11.Position).Magnitude

				if magnitude < huge then
					huge = magnitude
					v10 = v11
				end
			end
		end

		return v10
	end

	local function fn35()
		local roundTimerPart = Workspace:FindFirstChild("RoundTimerPart")
		if roundTimerPart then
			return tonumber(roundTimerPart:GetAttribute("Time")) or 0
		end
		return 0
	end

	local function fn36()
		local ok, result = pcall(function()
			local container

			if not tbl.inLobbyNow() then
				container = localPlayer.PlayerGui.MainGUI.Game.CoinBags.Container
			else
				container = localPlayer.PlayerGui.MainGUI.Lobby.Dock.CoinBags.Container
			end

			if not container then
				return 0
			end
			local v7 = next
			local children, v8 = container:GetChildren()
			local v9 = nil

			for _, v10 in v7, children, v8 do
				if v10:IsA("GuiObject") and v10:FindFirstChild("CurrencyFrame") then
					if v10.Visible then
						v9 = v10
						break
					elseif v10.Name == "Coin" and not v9 then
						v9 = v10
					end
				end
			end

			if not v9 then
				return 0
			end
			local full = v9:FindFirstChild("Full")
			if full and full.Visible then
				return 999
			end
			local currencyFrame = v9:FindFirstChild("CurrencyFrame")
			currencyFrame = currencyFrame and currencyFrame:FindFirstChild("Icon")
			currencyFrame = currencyFrame and currencyFrame:FindFirstChild("Coins")
			currencyFrame = currencyFrame and currencyFrame.Text
			if currencyFrame and (string.lower(currencyFrame):find("full") or string.lower(currencyFrame):find("max")) then
				return 999
			end
			return tonumber(currencyFrame) or 0
		end)

		if ok then
			return result
		end
		return 0
	end

	local function fn37(arg)
		if arg then
			if not connection then
				connection = RunService.Stepped:Connect(function()
					local character = localPlayer.Character

					if character then
						local v7 = next
						local descendants, v8 = character:GetDescendants()

						for _, v9 in v7, descendants, v8 do
							if v9:IsA("BasePart") and v9.CanCollide then
								if tbl.farmClipWas[v9] == nil then
									tbl.farmClipWas[v9] = true
								end

								v9.CanCollide = false
							end
						end
					end
				end)
			end
		else
			if connection then
				connection:Disconnect()
				connection = nil
			end

			tbl.reclip(tbl.farmClipWas)
		end
	end

	local function fn38(arg)
		local upperTorso = localPlayer.Character and localPlayer.Character:FindFirstChild("UpperTorso")
		if not upperTorso then
			return
		end
		local odhAutoFarmBodyGyro = upperTorso:FindFirstChild("ODH Auto Farm BodyGyro")
		local odhAutoFarmBodyVelocity = upperTorso:FindFirstChild("ODH Auto Farm BodyVelocity")

		if arg then
			odhAutoFarmBodyGyro = odhAutoFarmBodyGyro or odhAutoFarmBodyVelocity
			if odhAutoFarmBodyGyro then
				return
			end
			local v7 = fn26(localPlayer)
			if not v7 then
				return
			end
			local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
			if not humanoid then
				return
			end
			local cFrame = v7.CFrame
			local cFrame2 = CFrame.new(cFrame.X, cFrame.Y, cFrame.Z) * CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966)
			fn37(true)
			local bodyGyro = Instance.new("BodyGyro")
			bodyGyro.Name = "ODH Auto Farm BodyGyro"
			bodyGyro.Parent = upperTorso
			bodyGyro.P = 90000
			bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			bodyGyro.CFrame = cFrame2
			local bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.Name = "ODH Auto Farm BodyVelocity"
			bodyVelocity.Parent = upperTorso
			bodyVelocity.Velocity = Vector3.zero
			bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			v7.CFrame = cFrame2
			humanoid.PlatformStand = true
		else
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")

			if humanoid then
				if odhAutoFarmBodyGyro then
					odhAutoFarmBodyGyro:Destroy()
				end

				if odhAutoFarmBodyVelocity then
					odhAutoFarmBodyVelocity:Destroy()
				end

				humanoid.PlatformStand = false
				fn37(false)
			end
		end
	end

	local function fn39()
		if not v4 then
			return
		end
		local v7 = next
		local children, v8 = v4.Spawns:GetChildren()
		local v9 = nil

		for _, v10 in v7, children, v8 do
			if v10.Name == "Spawn" or v10.Name == "PlayerSpawn" or v10.Name == "SpawnLocation" then
				v9 = v10
			end
		end

		if not v9 then
			return
		end
		local cFrame = v9.CFrame
		local v10 = fn26(localPlayer)

		if v10 then
			v10.Velocity = Vector3.zero
			v10.CFrame = CFrame.new(cFrame.X, cFrame.Y + 5, cFrame.Z)
		end
	end

	local function fn40()
		pcall(function()
			local playerGui = localPlayer:FindFirstChild("PlayerGui")
			playerGui = playerGui and playerGui:FindFirstChild("MainGUI")
			playerGui = playerGui and playerGui:FindFirstChild("Game")

			if playerGui then
				flag16 = not playerGui:FindFirstChild("Inventory")
			end
		end)

		local v7 = next
		local children, v8 = Workspace:GetChildren()

		for _, v9 in v7, children, v8 do
			if v9:FindFirstChild("CoinAreas") or v9:FindFirstChild("CoinContainer") then
				v4 = v9
			end
		end

		flag17 = false
		tween = nil
		v5 = nil
	end

	local function fn41()
		if flag17 then
			flag17 = false
			v5 = nil

			if localPlayer.Character then
				if tween then
					tween:Cancel()
					tween = nil
				end

				fn38(false)

				if fn35() > 0 and v4 then
					fn39()
				end
			end
		end
	end

	fn27 = function()
		if flag14 then
			return
		end
		flag14 = true
		fn40()

		task.spawn(function()
			while flag14 do
				task.wait(0.1)

				pcall(function()
					if not flag14 then
						return
					end

					if not localPlayer.Character then
						flag15 = false
					else
						local remotes = ReplicatedStorage:FindFirstChild("Remotes")
						local extras = remotes and remotes:FindFirstChild("Extras")
						local getPlayerData = extras and extras:FindFirstChild("GetPlayerData")

						if getPlayerData then
							local ok, result = pcall(function()
								return getPlayerData:InvokeServer()
							end)

							if ok and result then
								local flag19 = result[localPlayer.Name]

								if flag19 then
									flag19 = not flag19.Dead and not flag19.Killed
								end

								flag15 = flag19
							end
						end
					end

					local v7 = next
					local children, v8 = Workspace:GetChildren()

					for _, v9 in v7, children, v8 do
						if v9:FindFirstChild("CoinAreas") or v9:FindFirstChild("CoinContainer") then
							v4 = v9
						end
					end

					if v4 ~= tbl.lastMap then
						tbl.lastMap = v4
						tbl.sawCoins = false
						tbl.flingDoneFired = false
						tbl.killFired = false
						tbl.coinReset()
					end

					local v9 = fn26(localPlayer)

					if flag15 and v4 and v9 and not tbl.sawCoins and not fn34() then
						if tbl.hideUnderMap(v9) then
							return
						end
					end

					if fn35() > 0 then
						local v10 = fn36()

						if (localPlayer:GetAttribute("Elite") and 50 or 40) <= v10 then
							fn41()
							tbl.finishFling()

							if tbl.killWhenFull and not tbl.killFired and fn() == localPlayer then
								tbl.killFired = true

								task.spawn(function()
									pcall(killAll)
								end)
							end
						elseif flag15 and localPlayer.Character then
							local v11 = fn26(localPlayer)
							local v12 = v11 and fn34()

							if v11 and v12 then
								tbl.sawCoins = true

								if v12 ~= v5 or v5 and v5:GetAttribute("Collected") then
									v5 = v12
									flag17 = true
									tbl.farmTargetTime = tick()

									if tween then
										tween:Cancel()
										tween = nil
									end

									fn38(true)
									local cFrame = v12.CFrame
									local n4 = (v11.Position - v12.Position).Magnitude / n2

									if n4 > 15 then
										n4 = 3
									end

									if n4 < 0.05 then
										n4 = 0.05
									end

									v11.Velocity = Vector3.zero

									tween = TweenService:Create(v11, TweenInfo.new(n4, Enum.EasingStyle.Linear), {
										CFrame = CFrame.new(cFrame.X, cFrame.Y - 3.5, cFrame.Z) * CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966),
									})

									tween:Play()
									v11.Velocity = Vector3.zero
								else
									local magnitude = (v11.Position - v12.Position).Magnitude

									if magnitude <= 6 and not v12:GetAttribute("Collected") then
										v12.CFrame = CFrame.new(v11.Position + Vector3.new(math.random(-80, 80) / 100, math.random(-50, 300) / 100, math.random(-80, 80) / 100))

										if (v12.Position - v11.Position).Magnitude > 0.1 then
											v11.CFrame = v11.CFrame * CFrame.new(0, math.random(-20, 20) / 100, math.random(-20, 20) / 100)
										end

										if v6 ~= v12 then
											v6 = v12
											n3 = tick()
										end

										if tick() - n3 > 2 then
											v6 = nil
											n3 = 0
											v5 = nil
										end
									elseif magnitude > 6 then
										local farmTargetTime = tbl.farmTargetTime

										if tick() - farmTargetTime > 4 then
											tbl.coinFailed(v12)
											v5 = nil
											v6 = nil
											n3 = 0
										end
									end
								end
							elseif v11 then
								if tbl.sawCoins then
									fn41()
									tbl.finishFling()
								end
							end
						else
							fn41()
						end
					else
						fn41()
					end
				end)
			end
		end)
	end

	tbl.inActiveRound = function()
		if tbl.inLobbyNow() then
			return false
		end

		if not flag15 then
			return false
		end
		local v7 = next
		local children, v8 = Workspace:GetChildren()
		local v9 = nil

		for _, v10 in v7, children, v8 do
			if v10:FindFirstChild("CoinAreas") or v10:FindFirstChild("CoinContainer") then
				v9 = v10
			end
		end

		if not v9 then
			return false
		end
		local character = localPlayer.Character
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not character or character.Health <= 0 then
			return false
		end
		v4 = v9
		return true
	end

	tbl.teleportHome = function()
		if not v4 then
			return
		end
		local spawns = v4:FindFirstChild("Spawns")
		if not spawns then
			return
		end
		local v7 = next
		local children, v8 = spawns:GetChildren()
		local v9 = nil
		local v10 = nil

		for _, v11 in v7, children, v8 do
			if v11:IsA("BasePart") then
				v9 = v9 or v11

				if v11.Name == "Spawn" or v11.Name == "PlayerSpawn" or v11.Name == "SpawnLocation" then
					v10 = v11
				end
			end
		end

		v10 = v10 or v9
		if not v10 then
			return
		end
		local v11 = fn26(localPlayer)
		if not v11 then
			return
		end
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.PlatformStand = false
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end

		local cFrame = v10.CFrame
		v11.Velocity = Vector3.zero
		v11.RotVelocity = Vector3.zero
		v11.CFrame = CFrame.new(cFrame.X, cFrame.Y + v10.Size.Y / 2 + 4, cFrame.Z)
	end

	fn28 = function()
		flag14 = false

		if tween then
			pcall(function()
				tween:Cancel()
			end)

			tween = nil
		end

		pcall(function()
			fn38(false)
		end)

		local flag19 = false

		pcall(function()
			if not (localPlayer.Character and fn26(localPlayer)) then
				return
			end
			flag19 = tbl.inActiveRound()

			if flag19 then
				tbl.teleportHome()
			end
		end)

		task.spawn(function()
			task.wait(0.35)

			pcall(function()
				if tween then
					tween:Cancel()
					tween = nil
				end
			end)

			pcall(function()
				fn38(false)
			end)

			local flag20 = false

			pcall(function()
				local character = localPlayer.Character
				if not character then
					return
				end
				local v7 = next
				local descendants, v8 = character:GetDescendants()

				for _, v9 in v7, descendants, v8 do
					if v9.Name == "ODH Auto Farm BodyGyro" or v9.Name == "ODH Auto Farm BodyVelocity" then
						v9:Destroy()
						flag20 = true
					end
				end

				local humanoid = character:FindFirstChildOfClass("Humanoid")

				if humanoid and humanoid.PlatformStand then
					humanoid.PlatformStand = false
					humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
					flag20 = true
				end
			end)

			if flag19 and flag20 then
				pcall(tbl.teleportHome)
			end
		end)
	end

	tbl.claimRewardPopup = function()
		local playerGui = localPlayer:FindFirstChild("PlayerGui")
		if not playerGui then
			return false
		end
		local claim = nil
		local crossPlatform = playerGui:FindFirstChild("CrossPlatform")
		local medium = crossPlatform and crossPlatform:FindFirstChild("NewItem") and crossPlatform.NewItem:FindFirstChild("Medium")

		if medium and medium.Visible then
			claim = medium:FindFirstChild("Container") and medium.Container:FindFirstChild("Claim")
		else
			medium = playerGui:FindFirstChild("MainGUI") and playerGui.MainGUI:FindFirstChild("Game")
			medium = medium and medium:FindFirstChild("NewItem")
			local visible = medium and medium.Visible
			local v7 = nil

			if visible then
				claim = medium:FindFirstChild("Container") and medium.Container:FindFirstChild("Claim")
			else
				medium = v7
			end
		end

		if not medium or not claim then
			return false
		end
		if getconnections then
			for _, v7 in ipairs({ "Activated", "MouseButton1Click" }) do
				local ok, result = pcall(getconnections, claim[v7])

				if ok and result and #result > 0 then
					for _, v8 in next, result, nil do
						pcall(function()
							v8:Fire()
						end)
					end

					return true
				end
			end
		end

		return (pcall(function()
			local VirtualInputManager = game:GetService("VirtualInputManager")
			local absolutePosition = claim.AbsolutePosition
			local absoluteSize = claim.AbsoluteSize
			local n4 = absolutePosition.X + absoluteSize.X / 2
			local n5 = absolutePosition.Y + absoluteSize.Y / 2 + 36
			VirtualInputManager:SendMouseButtonEvent(n4, n5, 0, true, game, 1)
			task.wait(0.05)
			VirtualInputManager:SendMouseButtonEvent(n4, n5, 0, false, game, 1)
		end))
	end

	tbl.startShells = function()
		if tbl.shellsRunning then
			return
		end
		tbl.shellsRunning = true

		task.spawn(function()
			while tbl.shellsOn do
				task.wait(0.5)
				pcall(tbl.claimRewardPopup)
			end

			tbl.shellsRunning = false
		end)
	end

	tbl.stopShells = function()
		tbl.shellsOn = false
	end

	tbl.SBOX_DELAY = 1
	tbl.CUR_NAME = { SummerKey2026 = "Shells" }

	tbl.curName = function(arg)
		return tbl.CUR_NAME[arg] or tostring(arg)
	end

	tbl.BOX_CURRENCY = { Summer2026Box = "SummerKey2026" }

	tbl.BOXES = {
		{ "Summer2026Box", "Summer Box '26" },
		{ "MysteryBox1", "Mystery Box #1" },
		{ "MysteryBox2", "Mystery Box #2" },
		{ "KnifeBox1", "Knife Box #1" },
		{ "KnifeBox2", "Knife Box #2" },
		{ "KnifeBox3", "Knife Box #3" },
		{ "KnifeBox4", "Knife Box #4" },
		{ "KnifeBox5", "Knife Box #5" },
		{ "GunBox1", "Gun Box #1" },
		{ "GunBox2", "Gun Box #2" },
		{ "GunBox3", "Gun Box #3" },
		{ "MLG Box", "Rainbow Box" },
	}

	tbl.boxOn = {}
	tbl.boxRunning = {}
	tbl.boxWaiting = {}

	tbl.boxPrice = function(arg)
		local str = tbl.BOX_CURRENCY[arg] or "Coins"
		local ok, result = pcall(require, game:GetService("ReplicatedStorage").Database.Sync.NewShop)
		if not ok or type(result) ~= "table" then
			return str, nil
		end
		local v7 = result[arg]
		local price = type(v7) == "table" and type(v7.Price) == "table" and v7.Price or nil
		return str, price and tonumber(price[str]) or nil
	end

	tbl.boxImage = function(arg)
		local ok, result = pcall(require, game:GetService("ReplicatedStorage").Database.Sync.MysteryBox)
		if not ok or type(result) ~= "table" then
			return nil
		end
		local v7 = result[arg]
		return type(v7) == "table" and v7.Image or nil
	end

	tbl.boxFunds = function(arg)
		local v7 = tbl.readOwned()
		if not v7 then
			return nil
		end
		return tonumber(v7[arg]) or 0
	end

	tbl.openBox = function(arg)
		local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
		remotes = remotes and remotes:FindFirstChild("Shop")
		remotes = remotes and remotes:FindFirstChild("OpenCrate")
		if not remotes then
			return nil, "the OpenCrate remote is gone"
		end
		local str = tbl.BOX_CURRENCY[arg] or "Coins"

		local ok, result = pcall(function()
			return remotes:InvokeServer(arg, "MysteryBox", str)
		end)

		if not ok then
			return nil, tostring(result)
		end
		return result
	end

	tbl.startBox = function(arg, arg2)
		if tbl.boxRunning[arg] then
			return
		end
		tbl.boxRunning[arg] = true

		task.spawn(function()
			local n4 = 0

			while tbl.boxOn[arg] do
				local v7, v8 = tbl.boxPrice(arg)
				local v9 = tbl.boxFunds(v7)

				if v8 and v9 and v9 < v8 then
					if not tbl.boxWaiting[arg] then
						tbl.boxWaiting[arg] = true

						v:Notify({
							Title = arg2,
							Content = "Waiting for " .. tbl.comma(v8 - v9) .. " more " .. tbl.curName(v7) .. ". It opens on its own once you can afford one.",
							Duration = 5,
							Icon = "clock",
						})
					end

					task.wait(5)
				else
					tbl.boxWaiting[arg] = false
					local v10, v11 = tbl.openBox(arg)

					if not v10 then
						local v12 = tbl.boxFunds(v7)

						if v8 and v12 and v12 < v8 then
							task.wait(5)
						else
							tbl.boxOn[arg] = false

							if tbl.el.box and tbl.el.box[arg] then
								tbl.setToggle(tbl.el.box[arg], false)
							end

							v:Notify({
								Title = arg2,
								Content = (n4 > 0 and "Opened " .. n4 .. ", then stopped: " or "Nothing opened: ") .. (v11 or "the server refused") .. ".",
								Duration = 6,
								Icon = "x",
							})

							break
						end
					else
						n4 += 1

						task.wait(tbl.SBOX_DELAY)
					end
				end
			end

			tbl.boxRunning[arg] = false
			tbl.boxWaiting[arg] = false
		end)
	end

	tbl.stopBox = function(arg)
		tbl.boxOn[arg] = false
	end

	_G.__OnyxBuild = "gatestyle-38"
	_G.__OnyxGen = (_G.__OnyxGen or 0) + 1
	tbl.gen = _G.__OnyxGen

	tbl.current = function()
		return tbl.gen == _G.__OnyxGen
	end

	tbl.comma = function(arg)
		local num = tonumber(arg)
		if num == nil then
			return "?"
		end
		local str = num < 0 and "-" or ""
		local v7 = tostring
		local v8 = table.pack(math.floor(math.abs(num)))
		return str .. v7(table.unpack(v8, 1, v8.n)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end

	tbl.SHELL_KEY = "SummerKey2026"
	tbl.SBOX_COST = 120
	tbl.shellsLeft = nil

	tbl.readOwned = function()
		local ok, result = pcall(require, game:GetService("ReplicatedStorage").Modules.ProfileData)
		if not ok or type(result) ~= "table" then
			return nil
		end
		local owned = result.Materials and result.Materials.Owned
		return type(owned) == "table" and owned or nil
	end

	tbl.readShells = function()
		local v7 = tbl.readOwned()
		if not v7 then
			return nil
		end
		local shellsLeft = tonumber(v7[tbl.SHELL_KEY]) or 0
		tbl.shellsLeft = shellsLeft
		return shellsLeft
	end

	tbl.roundCoins = 0
	tbl.roundCoinsAuth = nil
	tbl.roundBags = {}
	tbl.roundLive = false

	tbl.roundRoster = function()
		local ok, result = pcall(require, game:GetService("ReplicatedStorage").Modules.CurrentRoundClient)
		if not ok or type(result) ~= "table" then
			return nil
		end
		return type(result.PlayerData) == "table" and result.PlayerData or nil
	end

	tbl.myRoundRec = function()
		local v7 = tbl.roundRoster()
		return v7 and v7[localPlayer.Name] or nil
	end

	tbl.roundSnapshot = function()
		local v7 = tbl.myRoundRec()
		if type(v7) == "table" and type(v7.Coins) == "number" then
			tbl.roundCoinsAuth = v7.Coins
		end
	end

	tbl.roundBegin = function()
		tbl.roundCoins = 0
		tbl.roundCoinsAuth = nil
		tbl.roundBags = {}
		tbl.roundLive = true
		tbl.roundSnapshot()
	end

	tbl.roundFinish = function()
		if not tbl.roundLive then
			return
		end
		tbl.roundLive = false
		tbl.roundSnapshot()
	end

	task.spawn(function()
		local ReplicatedStorage_ = game:GetService("ReplicatedStorage")
		local roundTimerPart = workspace:WaitForChild("RoundTimerPart", 30)

		if roundTimerPart then
			local num = tonumber(roundTimerPart:GetAttribute("Time"))
			if num and num > 0 then
				tbl.roundBegin()
			end

			tbl.conns[#tbl.conns + 1] = roundTimerPart:GetAttributeChangedSignal("Time"):Connect(function()
				if not tbl.current() then
					return
				end
				local remaining = tonumber(roundTimerPart:GetAttribute("Time"))
				if remaining == nil then
					return
				end

				if remaining > 0 and not tbl.roundLive then
					tbl.roundBegin()
				elseif remaining <= 0 and tbl.roundLive then
					tbl.roundFinish()
				end
			end)
		end

		local remotes = ReplicatedStorage_:FindFirstChild("Remotes")
		remotes = remotes and remotes:FindFirstChild("Gameplay")
		if not remotes then
			return
		end
		local coinCollected = remotes:FindFirstChild("CoinCollected")

		if coinCollected then
			tbl.conns[#tbl.conns + 1] = coinCollected.OnClientEvent:Connect(function(arg, arg2)
				if not tbl.current() then
					return
				end
				local num = tonumber(arg2)

				if num then
					tbl.roundBags[tostring(arg or "Coin")] = num
					local roundCoins = 0

					for _, roundBag in pairs(tbl.roundBags) do
						roundCoins += roundBag
					end

					tbl.roundCoins = roundCoins
				end

				tbl.roundSnapshot()
			end)
		end

		local playerDataChanged = remotes:FindFirstChild("PlayerDataChanged")

		if playerDataChanged then
			tbl.conns[#tbl.conns + 1] = playerDataChanged.OnClientEvent:Connect(function()
				if not tbl.current() then
					return
				end
				tbl.roundSnapshot()
			end)
		end
	end)

	tbl.setToggle = function(arg, arg2, arg3)
		tbl.sfxQuiet = true
		local flag19 = false

		pcall(function()
			if arg then
				for _, v7 in ipairs({ "SetValue", "Set", "UpdateValue" }) do
					if type(arg[v7]) ~= "function" then
						continue
					end

					if pcall(function()
						arg[v7](arg, arg2)
					end) then
						flag19 = true
						return
					end
				end
			end
		end)

		if not flag19 and arg3 then
			pcall(arg3, arg2)
		end

		tbl.sfxQuiet = false
		return flag19
	end

	tbl.underMapDepth = 15

	tbl.underMapCF = function()
		if not v4 then
			return nil
		end
		local spawns = v4:FindFirstChild("Spawns")
		local position = nil

		if spawns then
			local v7 = next
			local children, v8 = spawns:GetChildren()
			position = nil

			for _, v9 in v7, children, v8 do
				if v9:IsA("BasePart") then
					position = v9.Position
					break
				else
					position = nil
				end
			end
		end

		if not position then
			local ok, result = pcall(function()
				return v4:GetPivot()
			end)

			if ok and result then
				position = result.Position
			end
		end

		if not position then
			return nil
		end
		return CFrame.new(position.X, position.Y - tbl.underMapDepth, position.Z)
	end

	tbl.hideUnderMap = function(arg)
		local v7 = tbl.underMapCF()
		if not v7 then
			return false
		end
		fn38(true)
		flag17 = true

		if (arg.Position - v7.Position).Magnitude > 5 then
			arg.Velocity = Vector3.zero
			arg.CFrame = v7
		end

		return true
	end

	tbl.finishFling = function()
		if not tbl.flingWhenDone then
			return
		end

		if tbl.flingDoneFired then
			return
		end

		if flag6 then
			return
		end
		local roundCoinsAuth = tbl.roundCoinsAuth or tbl.roundCoins or 0
		if roundCoinsAuth <= 0 and fn36() <= 0 then
			return
		end
		tbl.finishEarned = roundCoinsAuth > 0 and roundCoinsAuth or fn36()
		local v7 = fn()
		if not v7 or v7 == localPlayer or not v7.Character then
			return
		end
		tbl.flingDoneFired = true

		task.spawn(function()
			if flag12 then
				local str = " coins. Resetting, then flinging " .. v7.Name .. "..."

				v:Notify({
					Title = "Farm Done!",
					Content = "Collected " .. tbl.comma(tbl.finishEarned) .. str,
					Duration = 3,
					Icon = "flame",
				})

				local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

				if humanoid and humanoid.Health > 0 then
					humanoid.Health = 0
				end

				local now = tick()
				local flag19

				while true do
					task.wait(0.2)
					local character = localPlayer.Character
					local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")
					flag19 = character ~= nil and humanoid2 ~= nil and humanoid2.Health > 0 and character:FindFirstChild("HumanoidRootPart") ~= nil
					if not (flag19 or tick() - now > 12) then
						continue
					end
					break
				end

				if not flag19 then
					return
				end
				task.wait(0.6)
				v7 = fn()
				if not v7 or v7 == localPlayer or not v7.Character then
					return
				end
			else
				local str = " coins. Flinging " .. v7.Name .. "..."

				v:Notify({
					Title = "Farm Done!",
					Content = "Collected " .. tbl.comma(tbl.finishEarned) .. str,
					Duration = 2,
					Icon = "flame",
				})
			end

			pcall(fn9, v7)
		end)
	end

	tbl.diedMidRound = false

	tbl.conns[#tbl.conns + 1] = localPlayer.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid", 5)

		if humanoid then
			tbl.conns[#tbl.conns + 1] = humanoid.Died:Connect(function()
				local v7 = fn()
				tbl.diedMidRound = v7 ~= nil and v7 ~= localPlayer
			end)
		end

		if not tbl.diedMidRound then
			return
		end
		tbl.diedMidRound = false
		if not tbl.flingWhenDone then
			return
		end

		if tbl.flingDoneFired then
			return
		end

		task.spawn(function()
			task.wait(1.2)
			if not tbl.flingWhenDone or tbl.flingDoneFired or flag6 then
				return
			end
			local v7 = fn()
			if not v7 or v7 == localPlayer or not v7.Character then
				return
			end
			tbl.flingDoneFired = true

			v:Notify({
				Title = "Out Of The Round",
				Content = "Flinging " .. v7.Name .. "...",
				Duration = 3,
				Icon = "flame",
			})

			pcall(fn9, v7)
		end)
	end)

	tbl.flingAll = function()
		if tbl.flingAllRunning then
			tbl.flingAllRunning = false
			v:Notify({ Title = "Fling All Stopped!", Content = "Cancelled.", Duration = 2, Icon = "power-off" })
			return
		end

		local tbl2 = {}

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				tbl2[#tbl2 + 1] = player
			end
		end

		if #tbl2 == 0 then
			v:Notify({ Title = "Fling All", Content = "Nobody to fling!", Duration = 2, Icon = "x" })
			return
		end
		tbl.flingAllRunning = true

		task.spawn(function()
			v:Notify({ Title = "Fling All", Content = "Flinging " .. #tbl2 .. " players...", Duration = 2, Icon = "flame" })
			local n4 = 0

			for _, v7 in ipairs(tbl2) do
				if tbl.flingAllRunning then
					if v7.Parent and v7.Character then
						pcall(fn9, v7)
						local now = tick()

						while flag6 and tbl.flingAllRunning and tick() - now < 12 do
							task.wait(0.1)
						end

						n4 += 1
					end

					continue
				end

				break
			end

			if tbl.flingAllRunning then
				v:Notify({
					Title = "Fling All Done!",
					Content = "Flung " .. n4 .. " players.",
					Duration = 2,
					Icon = "check",
				})
			end

			tbl.flingAllRunning = false
		end)
	end

	fn29 = function()
		if flag18 then
			return
		end
		flag18 = true

		task.spawn(function()
			while flag12 do
				task.wait(1)

				pcall(function()
					if fn36() >= 999 then
						local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

						if humanoid then
							humanoid.Health = 0
						end
					end
				end)
			end

			flag18 = false
		end)
	end

	fn30 = function()
		flag12 = false
	end

	fn31 = function()
		if connection2 then
			return
		end

		connection2 = localPlayer.Idled:Connect(function()
			if not flag13 then
				return
			end

			pcall(function()
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new())
			end)
		end)
	end

	fn32 = function()
		if connection2 then
			connection2:Disconnect()
			connection2 = nil
		end
	end
end

local flag14
flag14 = false
tbl.velTrack = {}
tbl.aimLead = 0.16

tbl.startVelTracker = function()
	if tbl.velConn then
		return
	end

	tbl.velConn = RunService.Heartbeat:Connect(function()
		local now = os.clock()

		for _, player in ipairs(Players:GetPlayers()) do
			local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

			if not humanoidRootPart then
				tbl.velTrack[player] = nil
			else
				local v5 = tbl.velTrack[player]

				if not v5 then
					tbl.velTrack[player] = { p = humanoidRootPart.Position, t = now, v = Vector3.zero }
				elseif now - v5.t >= 0.03 then
					v5.v = (humanoidRootPart.Position - v5.p) / (now - v5.t)
					v5.p = humanoidRootPart.Position
					v5.t = now
				end
			end
		end
	end)
end

tbl.stopVelTracker = function()
	if tbl.velConn then
		pcall(function()
			tbl.velConn:Disconnect()
		end)
	end

	tbl.velConn = nil
	tbl.velTrack = {}
end

tbl.leadTime = function()
	local aimLead = tonumber(_G.__ONYX_AIMLEAD) or tbl.aimLead

	local ok, result = pcall(function()
		return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
	end)

	local flag15 = ok and type(result) == "number" and result > 0 and result < 1
	local n3 = 0.04

	if flag15 then
		n3 = result
	end

	return math.clamp(n3 + aimLead, 0, 0.3)
end

tbl.aimAt = function(arg, arg2)
	local humanoid = arg.Character and arg.Character:FindFirstChildOfClass("Humanoid")
	local n3

	if humanoid and humanoid.MoveDirection.Magnitude > 0.1 then
		n3 = humanoid.MoveDirection.Unit * humanoid.WalkSpeed
	else
		n3 = arg2.AssemblyLinearVelocity or Vector3.zero

		if n3.Magnitude < 0.5 then
			local v5 = tbl.velTrack[arg]

			if v5 and v5.v.Magnitude >= 0.5 then
				n3 = v5.v
			end
		end
	end

	if n3.Magnitude < 0.5 then
		return arg2.Position
	end
	local v5 = tbl.leadTime()
	local n4 = arg2.Position + Vector3.new(n3.X, 0, n3.Z) * v5
	local n5 = n4 - arg2.Position

	if n5.Magnitude > 8 then
		n4 = arg2.Position + n5.Unit * 8
	end

	_G.__ONYX_AIM = { aim = n4, targetPos = arg2.Position, vel = n3, lead = v5, t = os.clock() }
	return n4
end

tbl.startVelTracker()
local tbl2
tbl2 = nil
COOLDOWN = { Shoot = 3.2, Throw = 2 }
local connection, v5, connection2, fn33, fn34, fn35, fn36, fn37, fn38, n3
local connection3, tbl3, fn39, connection4, fn40, tbl4, fn41, tbl5, tbl6, tbl7
local fn42, fn43, fn44, fn45, tbl8, tbl9

do
	local function fn46(arg)
		arg = arg and arg:GetAttribute("ThrowSpeed")
		if type(arg) == "number" and arg > 0 then
			return 2 * arg
		end
		return COOLDOWN.Throw
	end

	local flag15 = false
	local flag16 = false
	connection = nil

	local function fn47()
		local ok, result = pcall(function()
			return require(ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("WeaponService"))
		end)

		if not ok or type(result) ~= "table" or not result.GunFired then
			return nil
		end

		return result.GunFired.OnClientEvent:Connect(function(arg)
			local character = localPlayer.Character
			if not character or typeof(arg) ~= "Instance" then
				return
			end

			if not arg:IsDescendantOf(character) then
				return
			end
			local shoot = COOLDOWN.Shoot
			flag15 = true

			if tbl2 then
				tbl2.startCooldown("Shoot", shoot, "SHOOT\nMURDERER")
			end

			task.spawn(function()
				task.wait(shoot)
				flag15 = false
			end)
		end)
	end

	v5 = fn47()

	local function fn48()
		local character = localPlayer.Character
		local backpack = localPlayer:FindFirstChild("Backpack")
		return character and character:FindFirstChild("Knife") or backpack and backpack:FindFirstChild("Knife")
	end

	local function fn49(arg)
		arg = arg and arg.Animation
		if not arg or arg.Name ~= "ThrowKnife" then
			return
		end

		if flag16 then
			return
		end
		local v6 = fn46(fn48())
		flag16 = true

		if tbl2 then
			tbl2.startCooldown("Throw", v6, "THROW\nKNIFE")
		end

		task.spawn(function()
			task.wait(v6)
			flag16 = false
		end)
	end

	local function fn50()
		if connection then
			pcall(function()
				connection:Disconnect()
			end)
		end

		connection = nil
		local character = localPlayer.Character
		character = character and character:FindFirstChildOfClass("Humanoid")
		character = character and character:FindFirstChildOfClass("Animator")
		if not character then
			return
		end
		connection = character.AnimationPlayed:Connect(fn49)
	end

	fn50()

	connection2 = localPlayer.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid")
		task.wait(0.3)
		fn50()
	end)

	fn33 = function(arg, arg2)
		if not arg or not arg2 then
			return false
		end
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { localPlayer.Character }
		raycastParams.RespectCanCollide = true
		local tbl10 = {}

		for _, v6 in ipairs({ "HumanoidRootPart", "Head", "UpperTorso", "Torso", "LeftFoot", "RightFoot" }) do
			local v7 = arg:FindFirstChild(v6)

			if v7 then
				table.insert(tbl10, v7.Position)
			end
		end

		if #tbl10 == 0 and arg.PrimaryPart then
			table.insert(tbl10, arg.PrimaryPart.Position)
		end

		for _, v6 in ipairs(tbl10) do
			local hit = workspace:Raycast(arg2.Position, v6 - arg2.Position, raycastParams)
			if not hit then
				return true
			end

			if hit.Instance and hit.Instance:IsDescendantOf(arg) then
				return true
			end

			if hit.Instance and hit.Instance.Transparency > 0.5 then
				return true
			end

			if hit.Instance and hit.Instance.CanCollide == false then
				return true
			end
		end

		return false
	end

	local function fn51(arg, arg2, arg3)
		local character = arg.Character
		if not character then
			return nil
		end
		local upperTorso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("HumanoidRootPart")
		if not upperTorso then
			return nil
		end
		local position = upperTorso.Position
		local assemblyLinearVelocity = upperTorso.AssemblyLinearVelocity or Vector3.new()
		local character2 = localPlayer.Character
		local upperTorso2

		if character2 then
			upperTorso2 = localPlayer.Character:FindFirstChild("UpperTorso") or localPlayer.Character:FindFirstChild("HumanoidRootPart")
		else
			upperTorso2 = character2
		end

		if not upperTorso2 then
			return position
		end
		local magnitude = (position - upperTorso2.Position).Magnitude
		if magnitude < 1 then
			return position
		end
		return position + assemblyLinearVelocity * math.min(magnitude / arg2 * (arg3 or 1), 0.5)
	end

	fn34 = function()
		local character = localPlayer.Character
		if not character then
			return nil
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return nil
		end
		local huge = math.huge
		local v6 = nil

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart2 then
					local magnitude = (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v6 = player
					end
				end
			end
		end

		return v6
	end

	fn35 = function()
		if flag15 then
			return
		end
		flag15 = true

		local function fn52(arg)
			task.spawn(function()
				task.wait(arg)
				flag15 = false
			end)
		end

		if fn2() ~= localPlayer then
			fn52(0.5)
			v:Notify({ Title = "Not Sheriff!", Content = "You don't have the gun.", Duration = 2, Icon = "x" })
			return
		end

		local v6 = fn()

		if not v6 or not v6.Character then
			v:Notify({ Title = "Error!", Content = "No murderer this round!", Duration = 2, Icon = "x" })
			fn52(0.5)
			return
		end

		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			fn52(0.5)
			return
		end

		if flag14 then
			if not fn33(v6.Character, localPlayer.Character:FindFirstChild("RightHand") or humanoidRootPart) then
				v:Notify({
					Title = "Wall Detected!",
					Content = "Murderer is behind a wall. Turn off Wall Check to shoot through it.",
					Duration = 3,
					Icon = "shield",
				})

				fn52(0.5)
				return
			end
		end

		local gun = localPlayer.Character and localPlayer.Character:FindFirstChild("Gun")

		if not gun then
			local backpack = localPlayer:FindFirstChild("Backpack")
			backpack = backpack and backpack:FindFirstChild("Gun")

			if backpack and localPlayer.Character then
				localPlayer.Character.Humanoid:EquipTool(backpack)
				task.wait(0.1)
				gun = localPlayer.Character:FindFirstChild("Gun")
			end

			if not gun then
				fn52(0.5)
				return
			end
		end

		local shoot = gun:FindFirstChild("Shoot")
		if not shoot or not shoot:IsA("RemoteEvent") then
			fn52(0.5)
			return
		end
		local gunRaycastAttachment = humanoidRootPart:FindFirstChild("GunRaycastAttachment")
		gunRaycastAttachment = gunRaycastAttachment and gunRaycastAttachment.WorldCFrame or CFrame.new(humanoidRootPart.Position)
		local humanoidRootPart2 = v6.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart2 then
			fn52(0.5)
			return
		end

		if (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude > 300 then
			v:Notify({ Title = "Too Far!", Content = "The gun only reaches 300 studs.", Duration = 2, Icon = "x" })
			fn52(0.5)
			return
		end

		shoot:FireServer(gunRaycastAttachment, CFrame.new(tbl.aimAt(v6, humanoidRootPart2)))
		fn52(0.35)
	end

	fn36 = function()
		if flag16 then
			return
		end
		flag16 = true

		local function fn52(arg)
			task.spawn(function()
				task.wait(arg)
				flag16 = false
			end)
		end

		if fn() ~= localPlayer then
			v:Notify({ Title = "Not Murderer!", Content = "You don't have the knife.", Duration = 2, Icon = "x" })
			fn52(0.5)
			return
		end

		local v6 = fn34()

		if not v6 or not v6.Character then
			v:Notify({ Title = "Error!", Content = "No one nearby to throw at.", Duration = 2, Icon = "x" })
			fn52(0.5)
			return
		end

		local rightHand = localPlayer.Character:FindFirstChild("RightHand") or localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not rightHand then
			fn52(0.5)
			return
		end

		if flag14 and not fn33(v6.Character, rightHand) then
			v:Notify({
				Title = "Wall Detected!",
				Content = v6.Name .. " is behind a wall.",
				Duration = 2,
				Icon = "shield",
			})

			fn52(0.5)
			return
		end

		local knife = localPlayer.Character:FindFirstChild("Knife")

		if not knife then
			local backpack = localPlayer:FindFirstChild("Backpack")
			backpack = backpack and backpack:FindFirstChild("Knife")

			if backpack then
				localPlayer.Character.Humanoid:EquipTool(backpack)
				task.wait(0.1)
				knife = localPlayer.Character:FindFirstChild("Knife")
			end
		end

		if not knife then
			fn52(0.5)
			return
		end
		local v7 = fn51(v6, 600, 0.95)
		if not v7 then
			fn52(0.5)
			return
		end
		local throw = knife:FindFirstChild("Throw") or knife:FindFirstChild("Events") and knife.Events:FindFirstChild("KnifeThrown")

		if throw and throw:IsA("RemoteEvent") then
			throw:FireServer(CFrame.new(rightHand.Position), CFrame.new(v7))

			pcall(function()
				local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
				humanoid = humanoid and humanoid:FindFirstChildOfClass("Animator")
				local throwKnife = knife:FindFirstChild("ThrowKnife", true)

				if humanoid and throwKnife then
					humanoid:LoadAnimation(throwKnife):Play(0.1, 6, 1)
				end
			end)

			local v8 = fn46(knife)

			if tbl2 then
				tbl2.startCooldown("Throw", v8, "THROW\nKNIFE")
			end

			fn52(v8)
		else
			fn52(0.5)
		end
	end

	local function fn52()
		for _, descendant in ipairs(Workspace:GetDescendants()) do
			if descendant.Name == "GunDrop" and descendant.Parent then
				return descendant
			end
		end

		return nil
	end

	local function fn53()
		local v6 = fn52()
		if not v6 then
			return false, "nodrop"
		end
		local character = localPlayer.Character
		if not character then
			return false, "nochar"
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return false, "nochar"
		end
		local v7 = nil

		if v6:IsA("BasePart") and v6:FindFirstChild("TouchInterest") then
			v7 = v6
		end

		if not v7 then
			for _, descendant in ipairs(v6:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant:FindFirstChild("TouchInterest") then
					v7 = descendant
					break
				end
			end
		end

		if not v7 then
			if v6:IsA("BasePart") then
				v7 = v6
			else
				for _, descendant in ipairs(v6:GetDescendants()) do
					if descendant:IsA("BasePart") then
						v7 = descendant
						break
					end
				end
			end
		end

		if not v7 then
			return false, "notouch"
		end

		for i = 1, 5 do
			pcall(function()
				firetouchinterest(humanoidRootPart, v7, 0)
				firetouchinterest(humanoidRootPart, v7, 1)
			end)

			task.wait(0.05)
			local backpack = localPlayer:FindFirstChildOfClass("Backpack")
			if character:FindFirstChild("Gun") or backpack and backpack:FindFirstChild("Gun") then
				return true
			end
		end

		local backpack = localPlayer:FindFirstChildOfClass("Backpack")
		if character:FindFirstChild("Gun") or backpack and backpack:FindFirstChild("Gun") then
			return true
		end
		return false, "refused"
	end

	local thread = nil

	fn37 = function()
		if thread then
			pcall(task.cancel, thread)
			thread = nil
		end
	end

	fn38 = function()
		fn37()

		thread = task.spawn(function()
			while true do
				task.wait(0.12)
				local character = localPlayer.Character
				local backpack = localPlayer:FindFirstChildOfClass("Backpack")

				if not (character and character:FindFirstChild("Gun") or backpack and backpack:FindFirstChild("Gun")) then
					pcall(fn53)
				end
			end
		end)
	end

	BOMB_COOLDOWN = 22
	n3 = 0
	connection3 = nil
	tbl3 = {}

	fn39 = function()
		local now = tick()

		if now - n3 < BOMB_COOLDOWN then
			v:Notify({
				Title = "Cooldown",
				Content = string.format("Bomb jump on cooldown for %.1fs", BOMB_COOLDOWN - now - n3),
				Duration = 2,
				Icon = "clock",
			})

			return
		end

		pcall(function()
			local character = localPlayer.Character
			if not character then
				return
			end
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if not humanoid or not humanoidRootPart then
				return
			end
			local tool = character:FindFirstChildOfClass("Tool")
			local fakeBomb = character:FindFirstChild("FakeBomb")

			if not fakeBomb then
				fakeBomb = localPlayer:FindFirstChild("Backpack")
				fakeBomb = fakeBomb and fakeBomb:FindFirstChild("FakeBomb")

				if fakeBomb then
					humanoid:EquipTool(fakeBomb)
					task.wait(0.1)
					fakeBomb = character:FindFirstChild("FakeBomb")
				end
			end

			if not fakeBomb then
				local remotes = ReplicatedStorage:FindFirstChild("Remotes")
				local extras = remotes and remotes:FindFirstChild("Extras")
				extras = extras and extras:FindFirstChild("ReplicateToy")

				if extras then
					extras:InvokeServer("FakeBomb")
					task.wait(0.15)
					fakeBomb = character:FindFirstChild("FakeBomb")

					if not fakeBomb then
						local backpack = localPlayer:FindFirstChild("Backpack")

						if backpack and backpack:FindFirstChild("FakeBomb") then
							humanoid:EquipTool(backpack.FakeBomb)
							task.wait(0.1)
							fakeBomb = character:FindFirstChild("FakeBomb")
						end
					end
				end
			end

			if not fakeBomb then
				v:Notify({ Title = "No Bomb", Content = "Couldn't get the FakeBomb toy.", Duration = 2, Icon = "x" })
				return
			end
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			task.wait(0.05)
			local remote = fakeBomb:FindFirstChild("Remote")

			if remote then
				local position = humanoidRootPart.Position
				remote:FireServer(CFrame.new(position.X, position.Y - 3, position.Z), 50)
				n3 = tick()

				if tbl2 then
					tbl2.startCooldown("Bomb", BOMB_COOLDOWN, "BOMB\nJUMP")
				end
			end

			task.wait(0.1)
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			task.wait(0.1)
			humanoid:UnequipTools()

			if tool and tool ~= fakeBomb and tool.Name ~= "FakeBomb" then
				task.wait(0.1)

				if tool.Parent then
					pcall(function()
						humanoid:EquipTool(tool)
					end)
				end
			end
		end)
	end

	local function fn54()
		n3 = 0

		if tbl2 then
			tbl2.clearCooldown("Bomb")
		end
	end

	local function fn55(arg)
		if connection3 then
			pcall(function()
				connection3:Disconnect()
			end)
		end

		connection3 = nil
		arg = arg and arg:FindFirstChildOfClass("Humanoid")

		if arg then
			connection3 = arg.Died:Connect(fn54)
		end
	end

	fn55(localPlayer.Character)

	connection4 = localPlayer.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid")
		fn54()
		fn55(character)
	end)

	local n4 = 4
	local n5 = 14
	local n6 = 0.2
	local flag17 = false
	local n7 = 0

	local function fn56(arg, arg2, arg3, arg4)
		if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
			RunService:BindToRenderStep("OnyxWallFlick", Enum.RenderPriority.Camera.Value + 1, function()
				local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart then
					return
				end
				local cframe = CFrame.Angles
				humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + arg2) * cframe(0, math.rad(arg3), 0)
			end)

			task.wait(arg4)

			pcall(function()
				RunService:UnbindFromRenderStep("OnyxWallFlick")
			end)

			pcall(function()
				arg.CFrame = CFrame.lookAt(arg.Position, arg.Position + arg2)
			end)
		else
			local cframe = CFrame.lookAt(arg.Position, arg.Position + arg2)

			pcall(function()
				arg.CFrame = cframe * CFrame.Angles(0, math.rad(arg3), 0)
			end)

			task.wait(arg4)

			pcall(function()
				arg.CFrame = CFrame.lookAt(arg.Position, arg.Position + arg2)
			end)
		end
	end

	local function fn57(arg, arg2)
		local raycastParams = RaycastParams.new()

		if not pcall(function()
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		end) then
			raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
		end

		raycastParams.FilterDescendantsInstances = { arg }

		for _, v6 in ipairs({ arg2.CFrame.LookVector, arg2.CFrame.RightVector, -arg2.CFrame.RightVector }) do
			local hit = Workspace:Raycast(arg2.Position, v6 * n4, raycastParams)
			if hit and hit.Instance and hit.Instance.CanCollide then
				return hit
			end
		end

		return nil
	end

	fn40 = function()
		local v6 = flag17
		local flag18

		if flag17 then
			flag18 = v6
		else
			flag18 = os.clock() - n7 < n6
		end

		if flag18 then
			return
		end
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end

		if not fn57(character, humanoidRootPart) then
			v:Notify({ Title = "No wall", Content = "Stand next to a wall first.", Duration = 1.5, Icon = "x" })
			return
		end
		flag17 = true

		task.spawn(function()
			local function fn58()
				flag17 = false
				n7 = os.clock()
			end

			local character2 = localPlayer.Character
			local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
			local humanoid = character2 and character2:FindFirstChildOfClass("Humanoid")
			if not humanoidRootPart2 or not humanoid then
				fn58()
				return
			end
			local v7 = fn57(character2, humanoidRootPart2)
			if not v7 then
				fn58()
				return
			end
			local n8 = -v7.Normal
			local vector = Vector3.new(n8.X, 0, n8.Z)
			if vector.Magnitude < 0.05 then
				fn58()
				return
			end
			local unit = vector.Unit

			local function fn59()
				pcall(function()
					humanoidRootPart2.AssemblyLinearVelocity = Vector3.new(unit.X * n5, humanoidRootPart2.AssemblyLinearVelocity.Y, unit.Z * n5)
				end)

				humanoid.Jump = true

				pcall(function()
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end)
			end

			fn59()
			task.wait(0.12)
			fn56(humanoidRootPart2, unit, 60, 0.08)
			task.wait(0.03)
			fn59()
			fn58()
		end)
	end

	tbl2 = { guis = {}, parts = {}, locked = false }

	ICONS = {
		crosshair = "rbxassetid://134242818164054",
		hand = "rbxassetid://130703864968637",
		sword = "rbxassetid://124448418211665",
		bomb = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=342187115",
		target = "rbxassetid://87563802520297",
		climb = "rbxassetid://100467452364672",
		skull = "rbxassetid://137726256442333",
		plane = "rbxassetid://126985561580989",
		expand = "rbxassetid://137492887754537",
		ghost = "rbxassetid://113822048130017",
		badge = "rbxassetid://116620312917084",
		xray = "rbxassetid://340313896",
	}

	IS_MOBILE = UserInputService.TouchEnabled
	TILE_W = IS_MOBILE and 72 or 84
	TILE_H = TILE_W
	TILE_GAP = 10

	if IS_MOBILE then
		tbl.hudScale = 0.7
	end

	COOLDOWN_GREY = Color3.fromRGB(72, 72, 80)

	local function fn58(arg, arg2)
		return Color3.new(arg.R + (1 - arg.R) * arg2, arg.G + (1 - arg.G) * arg2, arg.B + (1 - arg.B) * arg2)
	end

	tbl2.bgRest = function()
		return 0.18
	end

	tbl2.bgHover = function()
		return 0.06
	end

	tbl2.plateT = function(arg, arg2)
		if arg then
			arg2 = arg2 and 0.3 or 0.35
			return arg2
		end
		return arg2 and 0.7 or 0.82
	end

	tbl2.iconC = function(arg, arg2)
		return fn58(arg, arg2 and 0.8 or 0.55)
	end

	tbl2.glyphC = function(arg, arg2)
		if arg and arg.raw then
			return Color3.fromRGB(255, 255, 255)
		end
		return tbl2.iconC(arg and arg.accent, arg2)
	end

	tbl2.labelC = function(arg)
		if arg then
			return Color3.fromRGB(240, 240, 246)
		end
		return Color3.fromRGB(146, 146, 158)
	end

	tbl2.labelStrokeT = function()
		return 1
	end

	tbl2.iconPx = function(arg)
		local v6 = HUDIconSize and HUDIconSize[arg]
		if not v6 then
			return nil
		end
		return math.max(8, math.floor(v6 * TILE_H / 84 + 0.5))
	end

	tbl2.SLOT_PLATED = IS_MOBILE and 30 or 34
	tbl2.SLOT_PLAIN = IS_MOBILE and 22 or 25
	tbl2.SLOT_GAP = 6
	tbl2.GLYPH_MAX = tbl2.SLOT_PLAIN + 2 * (tbl2.SLOT_GAP - 1)

	tbl2.layout = function(arg, footer)
		local offset = arg.btn.Size.Y.Offset
		arg.footer = footer
		local n8 = 3 * (IS_MOBILE and 8 or 9)
		local slotPlain = tbl2.plateless() and tbl2.SLOT_PLAIN or tbl2.SLOT_PLATED
		local n9 = math.max(slotPlain, math.min(tbl2.iconPx(arg.name) or 0, tbl2.GLYPH_MAX))
		local n10 = slotPlain + tbl2.SLOT_GAP + (n8 + math.ceil((arg.lines or 2) * arg.label.TextSize * arg.label.LineHeight)) / 2
		local n11 = math.floor((offset - n10) / 2)
		local n12 = n11 + n10 - offset - footer - 3

		if n12 > 0 then
			n11 -= math.ceil(n12)
		end

		local n13 = math.max(2, n11)
		arg.plate.Position = UDim2.new(0.5, 0, 0, n13 + math.floor(slotPlain / 2))
		arg.label.AnchorPoint = Vector2.new(0.5, 0)
		arg.label.TextYAlignment = Enum.TextYAlignment.Center
		arg.label.Size = UDim2.new(1, -6, 0, n8)
		arg.label.Position = UDim2.new(0.5, 0, 0, n13 + slotPlain + tbl2.SLOT_GAP)

		if n9 < arg.icon.Size.Y.Offset then
			arg.icon.Size = UDim2.fromOffset(n9, n9)
		end
	end

	tbl2.create = function(arg, text, arg2, color2, arg3, arg4)
		if tbl2.guis[arg] then
			return
		end
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "Onyx" .. arg .. "Button"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.Parent = CoreGui
		local v6 = IS_MOBILE
		local v7 = TILE_W
		local v8 = TILE_H
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(0, v7, 0, v8)
		local v9 = tbl.hudPos[arg]
		textButton.Position = v9 and UDim2.new(v9[1], v9[2], v9[3], v9[4]) or arg2
		textButton.AnchorPoint = Vector2.new(0.5, 0.5)
		textButton.Text = ""
		textButton.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
		textButton.BackgroundTransparency = tbl2.bgRest()
		textButton.BorderSizePixel = 0
		textButton.AutoButtonColor = false
		textButton.ZIndex = 2
		textButton.Name = arg .. "Btn"
		textButton.Parent = screenGui
		Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 16)
		local uiScale = Instance.new("UIScale")
		uiScale.Scale = tbl.hudScale or 1
		uiScale.Parent = textButton
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Thickness = 1.5
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uiStroke.Color = color2
		uiStroke.Transparency = 0.15
		uiStroke.Parent = textButton
		local frame = Instance.new("Frame")
		frame.Name = "Plate"
		frame.Size = UDim2.new(0, tbl2.SLOT_PLATED, 0, tbl2.SLOT_PLATED)
		frame.Position = UDim2.new(0.5, 0, 0, math.floor(v8 * 0.36))
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.BackgroundColor3 = color2
		frame.BackgroundTransparency = tbl2.plateT(false, false)
		frame.BorderSizePixel = 0
		frame.ZIndex = 3
		frame.Parent = textButton
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 11)
		local uiStroke2 = Instance.new("UIStroke")
		uiStroke2.Thickness = 1
		uiStroke2.Color = color2
		uiStroke2.Transparency = 0.55
		uiStroke2.Parent = frame
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = "Icon"
		imageLabel.Size = UDim2.new(0, 23, 0, 23)
		imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = ICONS[arg3] or ""
		imageLabel.ImageColor3 = tbl2.iconC(color2, false)
		imageLabel.ZIndex = 5
		imageLabel.Parent = frame
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = "Label"
		textLabel.Size = UDim2.new(1, -10, 0, 24)
		textLabel.Position = UDim2.new(0.5, 0, 1, -7)
		textLabel.AnchorPoint = Vector2.new(0.5, 1)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = text
		textLabel.TextSize = v6 and 9 or 10
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextColor3 = tbl2.labelC(false)
		textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.TextStrokeTransparency = tbl2.labelStrokeT()
		textLabel.TextWrapped = true
		textLabel.LineHeight = 1.1
		textLabel.ZIndex = 6
		textLabel.Parent = textButton
		local n8 = select(2, text:gsub("\n", "")) + 1

		if n8 >= 3 then
			frame.Size = UDim2.new(0, tbl2.SLOT_PLATED - 6, 0, tbl2.SLOT_PLATED - 6)
			imageLabel.Size = UDim2.new(0, 20, 0, 20)
			textLabel.TextSize = v6 and 8 or 9
			textLabel.LineHeight = 1
		end

		local v10 = HUDIconArt and HUDIconArt[arg]

		if v10 then
			imageLabel.ImageRectOffset = Vector2.new(v10[1], v10[2])
			imageLabel.ImageRectSize = Vector2.new(v10[3], v10[3])
			imageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
		end

		local v11 = tbl2.iconPx(arg)

		if v11 then
			imageLabel.Size = UDim2.new(0, v11, 0, v11)
			frame.ClipsDescendants = false
		end

		tbl2.parts[arg] = {
			btn = textButton,
			stroke = uiStroke,
			plate = frame,
			plateStroke = uiStroke2,
			icon = imageLabel,
			label = textLabel,
			accent = color2,
			active = false,
			scale = uiScale,
			lines = n8,
			raw = (HUDIconArt and HUDIconArt[arg]) ~= nil,
			name = arg,
		}

		tbl2.layout(tbl2.parts[arg], 0)
		pcall(tbl2.applyDesign, tbl2.parts[arg])

		local function fn59(arg5, arg6, arg7)
			TweenService:Create(arg5, TweenInfo.new(arg7 or 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), arg6):Play()
		end

		textButton.MouseEnter:Connect(function()
			local v12 = tbl2.parts[arg]
			fn59(textButton, { BackgroundTransparency = tbl2.designHover() })
			if v12 and v12.cdUntil then
				return
			end

			if not tbl2.plateless() then
				fn59(frame, { BackgroundTransparency = tbl2.plateT(v12 and v12.active, true) })
			end

			fn59(textLabel, { TextColor3 = Color3.fromRGB(228, 228, 236) })
		end)

		textButton.MouseLeave:Connect(function()
			local v12 = tbl2.parts[arg]
			fn59(textButton, { BackgroundTransparency = tbl2.designRest() })
			if v12 and v12.cdUntil then
				return
			end

			if not tbl2.plateless() then
				fn59(frame, { BackgroundTransparency = tbl2.plateT(v12 and v12.active, false) })
			end

			fn59(textLabel, { TextColor3 = tbl2.labelC(v12 and v12.active) })
		end)

		local flag18 = nil
		local flag19 = nil
		local v12 = nil
		local position = nil
		local position2 = nil
		local n9 = 0

		local function fn60()
			if flag19 then
				return
			end
			local now = os.clock()
			if now - n9 < 0.2 then
				return
			end
			n9 = now
			tbl.playSfx("click")
			local hudScale = tbl.hudScale or 1
			fn59(uiScale, { Scale = hudScale * 0.93 }, 0.06)

			task.delay(0.08, function()
				if uiScale.Parent then
					fn59(uiScale, { Scale = hudScale }, 0.16)
				end
			end)

			task.spawn(arg4)
		end

		textButton.MouseButton1Click:Connect(fn60)
		textButton.TouchTap:Connect(fn60)

		textButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				flag18 = true
				flag19 = false
				v12 = input
				position = textButton.Position
				position2 = input.Position
			end
		end)

		tbl2.parts[arg].dragConn = UserInputService.InputChanged:Connect(function(input)
			if not flag18 or tbl2.locked or not textButton.Parent then
				return
			end

			if input.UserInputType ~= Enum.UserInputType.MouseMovement and input ~= v12 then
				return
			end
			local n10 = input.Position - position2

			if not flag19 then
				if math.abs(n10.X) + math.abs(n10.Y) < 6 then
					return
				end
				flag19 = true
			end

			textButton.Position = UDim2.new(position.X.Scale, position.X.Offset + n10.X, position.Y.Scale, position.Y.Offset + n10.Y)
		end)

		tbl2.parts[arg].endConn = UserInputService.InputEnded:Connect(function(input)
			if not flag18 or input ~= v12 then
				return
			end
			flag18 = false
			v12 = nil

			if flag19 then
				local position3 = textButton.Position
				tbl.hudPos[arg] = { position3.X.Scale, position3.X.Offset, position3.Y.Scale, position3.Y.Offset }
			end

			task.delay(0.05, function()
				flag19 = false
			end)
		end)

		tbl2.guis[arg] = screenGui
		tbl.hudBtns[arg] = textButton
		return textButton, textLabel
	end

	HUDOrder = { "Shoot", "Grab", "Aimbot", "Bomb", "Throw", "WallHop" }
	HUDOrder2 = { "KillAll", "KillSheriff", "Fly", "Noclip", "Xray" }
	tbl4 = {}

	local function fn59(arg, arg2)
		for i, v6 in ipairs(arg) do
			tbl4[v6] = UDim2.new(0.5, (i - (#arg + 1) / 2) * (TILE_W + TILE_GAP), 0.25, arg2)
		end
	end

	fn59(HUDOrder, 0)
	fn59(HUDOrder2, TILE_H + TILE_GAP)

	tbl2.relayout = function()
		local hudScale = tbl.hudScale or 1

		local function fn60(arg, arg2)
			for i, v6 in ipairs(arg) do
				tbl4[v6] = UDim2.new(0.5, (i - (#arg + 1) / 2) * (TILE_W + TILE_GAP) * hudScale, 0.25, arg2 * hudScale)

				if not tbl.hudPos[v6] then
					local v7 = tbl2.parts[v6]

					if v7 and v7.btn then
						v7.btn.Position = tbl4[v6]
					end
				end
			end
		end

		fn60(HUDOrder, 0)
		fn60(HUDOrder2, TILE_H + TILE_GAP)
	end

	HUDIcon = {
		Shoot = "crosshair",
		Grab = "hand",
		Throw = "sword",
		Bomb = "bomb",
		Aimbot = "target",
		WallHop = "climb",
		KillAll = "badge",
		Fly = "plane",
		Noclip = "ghost",
		KillSheriff = "skull",
		Xray = "xray",
	}

	HUDIconSize = { Xray = 34, Bomb = 48 }
	HUDIconArt = { Xray = { 165, 85, 250 }, Bomb = { 8, 24, 170 } }

	HUDAccent = {
		Shoot = Color3.fromHex("#257AF7"),
		Grab = Color3.fromHex("#10C550"),
		Throw = Color3.fromHex("#EF4444"),
		Bomb = Color3.fromHex("#F97316"),
		Aimbot = Color3.fromHex("#2DD4BF"),
		WallHop = Color3.fromHex("#A855F7"),
		KillAll = Color3.fromHex("#DC2626"),
		Fly = Color3.fromHex("#38BDF8"),
		Noclip = Color3.fromHex("#94A3B8"),
		KillSheriff = Color3.fromHex("#DC2626"),
		Xray = Color3.fromHex("#FACC15"),
	}

	fn41 = function()
		local v6, v7 = fn53()
		if v6 then
			v:Notify({ Title = "Gun Grabbed!", Content = "Got the gun!", Duration = 1.5, Icon = "check" })
			return
		end
		local v8 = next
		local children, v9 = Workspace:GetChildren()
		local flag18 = false

		for _, v10 in v8, children, v9 do
			if v10:FindFirstChild("CoinAreas") or v10:FindFirstChild("CoinContainer") then
				flag18 = true
				break
			end
		end

		if v7 == "nochar" then
			v:Notify({
				Title = "No Character",
				Content = "Nothing to grab with right now.",
				Duration = 2,
				Icon = "x",
			})
		elseif not flag18 then
			v:Notify({
				Title = "Not In A Round",
				Content = "The round is over, so the gun can't be picked up. Wait for the next one.",
				Duration = 3,
				Icon = "clock",
			})
		elseif v7 == "nodrop" then
			v:Notify({
				Title = "No Gun Found!",
				Content = "No gun on the ground right now.",
				Duration = 1.5,
				Icon = "x",
			})
		else
			v:Notify({
				Title = "Couldn't Grab It",
				Content = "Found the gun but the pickup didn't land -- move closer and try again.",
				Duration = 2.5,
				Icon = "x",
			})
		end
	end

	tbl2.setActive = function(arg, active)
		local v6 = tbl2.parts[arg]
		if not v6 then
			return
		end
		v6.active = active
		local designNow = tbl2.designNow and tbl2.designNow()
		if designNow and designNow.active then
			pcall(designNow.active, v6, active)
			return
		end

		local function fn60(arg2, arg3)
			TweenService:Create(arg2, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), arg3):Play()
		end

		fn60(v6.stroke, { Transparency = active and 0 or 0.15 })
		fn60(v6.plate, { BackgroundTransparency = tbl2.plateT(active, false) })
		fn60(v6.plateStroke, { Transparency = active and 0.15 or 0.55 })
		fn60(v6.icon, { ImageColor3 = tbl2.glyphC(v6, active) })
		fn60(v6.label, { TextColor3 = tbl2.labelC(active) })
	end

	tbl2.DESIGN = "Default Design"
	tbl2.DESIGN_LIST = { "Round Design", "Default Design" }
	tbl2.DESIGN_RENAMED = { Ring = "Round Design", ["Base Bar"] = "Default Design", ["New Style"] = "Default Design" }

	tbl2.snapDesign = function(arg)
		if arg.base then
			return
		end
		local uiCorner = arg.btn:FindFirstChildOfClass("UICorner")

		arg.base = {
			corner = uiCorner and uiCorner.CornerRadius or UDim.new(0, 16),
			body = arg.btn.BackgroundColor3,
			strokeThk = arg.stroke.Thickness,
			plateSize = arg.plate.Size,
			platePos = arg.plate.Position,
			iconSize = arg.icon.Size,
			labelPos = arg.label.Position,
			labelSize = arg.label.Size,
		}
	end

	tbl2.stopGlide = function(arg)
		if arg.glideT then
			arg.glideT:Cancel()
			arg.glideT = nil
		end

		if arg.arcT then
			arg.arcT:Cancel()
			arg.arcT = nil
		end
	end

	tbl2.setNow = function(arg, arg2)
		if not arg then
			return
		end
		TweenService:Create(arg, TweenInfo.new(0.03, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), arg2):Play()
	end

	tbl2.designNow = function()
		return tbl2.DESIGNS and tbl2.DESIGNS[tbl2.DESIGN] or nil
	end

	tbl2.designRest = function()
		local v6 = tbl2.designNow()
		if v6 and v6.rest then
			return v6.rest
		end
		return tbl2.bgRest()
	end

	tbl2.designHover = function()
		local v6 = tbl2.designNow()
		if v6 and v6.hover then
			return v6.hover
		end
		return tbl2.bgHover()
	end

	tbl2.plateless = function()
		local v6 = tbl2.designNow()
		return v6 ~= nil and v6.plateless == true
	end

	tbl2.BAR_H = 4
	tbl2.BAR_DROP = 6
	tbl2.BAR_INSET = 13

	tbl2.buildBar = function(arg)
		if arg.track then
			return
		end
		local frame = Instance.new("Frame")
		frame.Name = "Track"
		frame.AnchorPoint = Vector2.new(0.5, 1)
		frame.Position = UDim2.new(0.5, 0, 1, -tbl2.BAR_DROP)
		frame.Size = UDim2.new(1, -tbl2.BAR_INSET * 2, 0, tbl2.BAR_H)
		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame.BackgroundTransparency = 0.86
		frame.BorderSizePixel = 0
		frame.ZIndex = 4
		frame.Parent = arg.btn
		Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
		local frame2 = Instance.new("Frame")
		frame2.Name = "Fill"
		frame2.AnchorPoint = Vector2.new(0, 0.5)
		frame2.Position = UDim2.new(0, 0, 0.5, 0)
		frame2.Size = UDim2.fromScale(0, 1)
		frame2.BackgroundColor3 = arg.accent
		frame2.BorderSizePixel = 0
		frame2.ZIndex = 5
		frame2.Parent = frame
		Instance.new("UICorner", frame2).CornerRadius = UDim.new(1, 0)
		arg.track = frame
		arg.fill = frame2
	end

	tbl2.RING_INSET = 5
	tbl2.RING_THICK = 3

	tbl2.buildRing = function(arg)
		if arg.ring then
			return
		end
		local n8 = arg.btn.Size.Y.Offset - tbl2.RING_INSET * 2 - tbl2.RING_THICK
		local frame = Instance.new("Frame")
		frame.Name = "Ring"
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.fromScale(1, 1)
		frame.ZIndex = 4
		frame.Parent = arg.btn
		local frame2 = Instance.new("Frame")
		frame2.Name = "Track"
		frame2.AnchorPoint = Vector2.new(0.5, 0.5)
		frame2.Position = UDim2.fromScale(0.5, 0.5)
		frame2.Size = UDim2.fromOffset(n8, n8)
		frame2.BackgroundTransparency = 1
		frame2.ZIndex = 4
		frame2.Parent = frame
		Instance.new("UICorner", frame2).CornerRadius = UDim.new(1, 0)
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Thickness = tbl2.RING_THICK
		uiStroke.Color = Color3.fromRGB(255, 255, 255)
		uiStroke.Transparency = 0.88
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uiStroke.Parent = frame2
		arg.arcs = {}

		for i, v6 in ipairs({ "Right", "Left" }) do
			local frame3 = Instance.new("Frame")
			frame3.Name = v6 .. "Mask"
			frame3.BackgroundTransparency = 1
			frame3.ClipsDescendants = true
			frame3.Size = UDim2.fromScale(0.5, 1)
			frame3.Position = UDim2.fromScale(v6 == "Right" and 0.5 or 0, 0)
			frame3.ZIndex = 5
			frame3.Parent = frame
			local frame4 = Instance.new("Frame")
			frame4.Name = "Arc"
			frame4.AnchorPoint = Vector2.new(0.5, 0.5)
			frame4.Position = UDim2.new(v6 == "Right" and 0 or 1, 0, 0.5, 0)
			frame4.Size = UDim2.fromOffset(n8, n8)
			frame4.BackgroundTransparency = 1
			frame4.ZIndex = 5
			frame4.Parent = frame3
			Instance.new("UICorner", frame4).CornerRadius = UDim.new(1, 0)
			local uiStroke2 = Instance.new("UIStroke")
			uiStroke2.Thickness = tbl2.RING_THICK
			uiStroke2.Color = arg.accent
			uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke2.Parent = frame4
			local uiGradient = Instance.new("UIGradient")
			local numberSequence = NumberSequence.new
			local tbl10 = {}
			local v7 = NumberSequenceKeypoint.new(0, 0)
			local v8 = NumberSequenceKeypoint.new(0.499, 0)
			local v9 = NumberSequenceKeypoint.new(0.5, 1)
			local new = NumberSequenceKeypoint.new
			tbl10[1] = v7
			tbl10[2] = v8
			tbl10[3] = v9

			do
				local values = table.pack(new(1, 1))
				table.move(values, 1, values.n, 4, tbl10)
			end

			uiGradient.Transparency = numberSequence(tbl10)
			uiGradient.Parent = uiStroke2
			arg.arcs[i] = uiGradient
		end

		arg.ringTrack = frame2
		arg.ring = frame
	end

	tbl2.setRing = function(arg, arg2)
		if not arg.arcs then
			return
		end
		tbl2.stopGlide(arg)
		local n8 = math.clamp(arg2, 0, 1) * 360
		arg.arcs[1].Rotation = math.min(n8, 180)
		arg.arcs[2].Rotation = math.clamp(n8, 180, 360)
	end

	tbl2.resetDesign = function(arg)
		tbl2.snapDesign(arg)
		local base = arg.base
		local uiCorner = arg.btn:FindFirstChildOfClass("UICorner")

		if uiCorner then
			uiCorner.CornerRadius = base.corner
		end

		arg.btn.BackgroundColor3 = base.body
		arg.btn.ClipsDescendants = false
		arg.stroke.Thickness = base.strokeThk
		local plate = arg.plate
		local platePos = base.platePos
		arg.plate.Size = base.plateSize
		plate.Position = platePos
		arg.plate.BackgroundColor3 = arg.accent
		arg.icon.Size = base.iconSize
		arg.label.Visible = true
		local label = arg.label
		local labelPos = base.labelPos
		local labelSize = base.labelSize
		arg.label.Position = labelPos
		label.Size = labelSize
		arg.footer = 0
		tbl2.setNow(arg.btn, { BackgroundTransparency = tbl2.bgRest() })
		tbl2.setNow(arg.stroke, { Color = arg.accent, Transparency = arg.active and 0 or 0.15 })
		tbl2.setNow(arg.plate, { BackgroundTransparency = tbl2.plateT(arg.active, false) })
		tbl2.setNow(arg.plateStroke, { Transparency = arg.active and 0.15 or 0.55 })
		tbl2.setNow(arg.icon, { ImageColor3 = tbl2.glyphC(arg, arg.active) })
		tbl2.setNow(arg.label, { TextColor3 = tbl2.labelC(arg.active) })

		if arg.track then
			arg.track.Visible = false
		end

		if arg.fill then
			arg.fill.Visible = false
		end

		if arg.ring then
			arg.ring.Visible = false
		end

		if arg.arcs then
			tbl2.setRing(arg, 0)
		end
	end

	tbl2.applyDesign = function(arg)
		if not arg or not arg.btn or not arg.btn.Parent then
			return
		end
		tbl2.resetDesign(arg)
		local v6 = tbl2.designNow()

		if v6 and v6.apply then
			pcall(v6.apply, arg)
		end

		tbl2.setActive(arg.name, arg.active)
	end

	tbl2.setDesign = function(arg)
		local designRenamed = tbl2.DESIGN_RENAMED and tbl2.DESIGN_RENAMED[arg] or arg

		if not tbl2.DESIGNS[designRenamed] then
			designRenamed = "Default Design"
		end

		tbl2.DESIGN = designRenamed
		tbl.hudDesign = designRenamed

		for _, v6 in next, tbl2.parts, nil do
			pcall(tbl2.applyDesign, v6)
		end
	end

	tbl2.designSet = function(arg, arg2)
		local v6 = tbl2.designNow()

		if v6 and v6.set then
			pcall(v6.set, arg, arg2)
		end
	end

	tbl2.designSlide = function(arg, arg2)
		local v6 = tbl2.designNow()

		if v6 and v6.slide then
			pcall(v6.slide, arg, arg2)
		end
	end

	tbl2.DESIGNS = {
		["Round Design"] = {
			plateless = true,
			rest = 0.12,
			hover = 0.04,
			apply = function(arg)
				local uiCorner = arg.btn:FindFirstChildOfClass("UICorner")

				if uiCorner then
					uiCorner.CornerRadius = UDim.new(1, 0)
				end

				arg.stroke.Thickness = 2
				arg.plate.Position = UDim2.new(0.5, 0, 0.5, 0)
				arg.plate.AnchorPoint = Vector2.new(0.5, 0.5)
				local n8 = tbl2.iconPx(arg.name) or 26
				arg.icon.Size = UDim2.fromOffset(n8, n8)
				tbl2.setNow(arg.btn, { BackgroundTransparency = 0.12 })
				tbl2.setNow(arg.stroke, { Color = arg.accent, Transparency = 0 })
				tbl2.setNow(arg.plate, { BackgroundTransparency = 1 })
				tbl2.setNow(arg.plateStroke, { Transparency = 1 })
				tbl2.setNow(arg.icon, { ImageColor3 = tbl2.glyphC(arg, arg.active) })
				arg.label.Visible = false
				tbl2.buildRing(arg)
				arg.ring.Visible = true
				tbl2.setRing(arg, 0)
			end,
			active = function(arg, arg2)
				tbl2.setNow(arg.stroke, { Transparency = 0 })
				tbl2.setNow(arg.icon, { ImageColor3 = tbl2.glyphC(arg, arg2) })

				if not arg.cdUntil then
					tbl2.setRing(arg, arg2 and 1 or 0)
				end
			end,
			set = function(arg, arg2)
				tbl2.setRing(arg, arg2)
			end,
			slide = function(arg, arg2)
				if not arg.arcs then
					return
				end
				tbl2.stopGlide(arg)
				arg.arcs[1].Rotation = 180
				arg.arcs[2].Rotation = 360
				arg.arcT = TweenService:Create(arg.arcs[2], TweenInfo.new(arg2 / 2, Enum.EasingStyle.Linear), { Rotation = 180 })
				arg.arcT:Play()
				arg.glideT = TweenService:Create(arg.arcs[1], TweenInfo.new(arg2 / 2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, arg2 / 2), { Rotation = 0 })
				arg.glideT:Play()
			end,
		},
		["Default Design"] = {
			plateless = true,
			rest = 0.1,
			hover = 0.03,
			apply = function(arg)
				local uiCorner = arg.btn:FindFirstChildOfClass("UICorner")

				if uiCorner then
					uiCorner.CornerRadius = UDim.new(0, 20)
				end

				arg.stroke.Thickness = 1
				local slotPlain = tbl2.iconPx(arg.name) or tbl2.SLOT_PLAIN
				arg.icon.Size = UDim2.fromOffset(slotPlain, slotPlain)
				tbl2.setNow(arg.btn, { BackgroundTransparency = 0.1 })

				tbl2.setNow(arg.stroke, {
					Color = arg.active and arg.accent or Color3.fromRGB(255, 255, 255),
					Transparency = arg.active and 0.35 or 0.88,
				})

				tbl2.setNow(arg.plate, { BackgroundTransparency = 1 })
				tbl2.setNow(arg.plateStroke, { Transparency = 1 })
				local setNow = tbl2.setNow
				local icon = arg.icon
				local tbl10 = {}
				local color2 = arg.raw and Color3.fromRGB(255, 255, 255)

				if not color2 then
					color2 = fn58(arg.accent, arg.active and 0.6 or 0.25)
				end

				tbl10.ImageColor3 = color2
				setNow(icon, tbl10)
				tbl2.buildBar(arg)
				tbl2.layout(arg, tbl2.BAR_H + tbl2.BAR_DROP)
				arg.track.Visible = true
				arg.fill.Visible = true
				arg.fill.BackgroundColor3 = arg.accent
				tbl2.stopGlide(arg)
				arg.fill.Size = UDim2.fromScale(arg.active and 1 or 0, 1)
			end,
			active = function(arg, arg2)
				tbl2.setNow(arg.stroke, { Color = arg2 and arg.accent or Color3.fromRGB(255, 255, 255), Transparency = arg2 and 0.35 or 0.88 })
				local setNow = tbl2.setNow
				local icon = arg.icon
				local tbl10 = {}
				local color2 = arg.raw and Color3.fromRGB(255, 255, 255)

				if not color2 then
					color2 = fn58(arg.accent, arg2 and 0.6 or 0.25)
				end

				tbl10.ImageColor3 = color2
				setNow(icon, tbl10)
				tbl2.setNow(arg.label, { TextColor3 = tbl2.labelC(arg2) })

				if arg.fill then
					tbl2.stopGlide(arg)
					arg.fill.Size = UDim2.fromScale(arg2 and 1 or 0, 1)
				end
			end,
			set = function(arg, arg2)
				if not arg.fill then
					return
				end
				tbl2.stopGlide(arg)
				arg.fill.Size = UDim2.fromScale(arg2, 1)
			end,
			slide = function(arg, arg2)
				if not arg.fill then
					return
				end
				tbl2.stopGlide(arg)
				arg.fill.Size = UDim2.fromScale(1, 1)
				arg.glideT = TweenService:Create(arg.fill, TweenInfo.new(arg2, Enum.EasingStyle.Linear), { Size = UDim2.fromScale(0, 1) })
				arg.glideT:Play()
			end,
		},
	}

	tbl2.startCooldown = function(arg, cdTotal, text)
		local v6 = tbl2.parts[arg]
		if not v6 or not v6.label then
			return
		end
		v6.cdUntil = os.clock() + cdTotal
		v6.cdTotal = cdTotal
		tbl2.designSlide(v6, cdTotal)
		if v6.cdThread then
			return
		end
		local match = text:match("^[^\n]+") or text

		local function fn60(arg2, arg3, arg4)
			if not arg2 then
				return
			end
			TweenService:Create(arg2, TweenInfo.new(arg4 or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), arg3):Play()
		end

		fn60(v6.stroke, { Color = COOLDOWN_GREY })
		fn60(v6.plateStroke, { Color = COOLDOWN_GREY })
		fn60(v6.plate, { BackgroundColor3 = COOLDOWN_GREY })
		fn60(v6.icon, { ImageColor3 = Color3.fromRGB(124, 124, 134) })
		fn60(v6.label, { TextColor3 = Color3.fromRGB(112, 112, 124) })

		v6.cdThread = task.spawn(function()
			while true do
				local v7 = tbl2.parts[arg]

				if not (not v7 or not v7.cdUntil) then
					local n8 = v7.cdUntil - os.clock()

					if not (n8 <= 0) then
						v7.label.Text = match .. "\n" .. string.format("%.1fs", n8)
						task.wait(0.05)
						continue
					end
				end

				break
			end

			local v7 = tbl2.parts[arg]

			if v7 then
				v7.cdUntil = nil
				v7.cdThread = nil
				tbl2.designSet(v7, 0)

				if v7.active then
					local designNow = tbl2.designNow and tbl2.designNow()

					if designNow and designNow.active then
						pcall(designNow.active, v7, true)
					end
				end

				if v7.label then
					v7.label.Text = text
				end

				fn60(v7.stroke, { Color = v7.accent })
				fn60(v7.plateStroke, { Color = v7.accent })
				fn60(v7.plate, { BackgroundColor3 = v7.accent })
				fn60(v7.icon, { ImageColor3 = tbl2.glyphC(v7, v7.active) })
				fn60(v7.label, { TextColor3 = tbl2.labelC(v7.active) })
				fn60(v7.plate, { BackgroundTransparency = tbl2.plateT(v7.active, false) })
			end
		end)
	end

	tbl2.clearCooldown = function(arg)
		local v6 = tbl2.parts[arg]

		if v6 then
			v6.cdUntil = nil
		end
	end

	tbl2.destroy = function(arg)
		local v6 = tbl2.parts[arg]

		if v6 then
			if v6.dragConn then
				v6.dragConn:Disconnect()
			end

			if v6.endConn then
				v6.endConn:Disconnect()
			end
		end

		local v7 = tbl2.guis[arg]

		if v7 then
			v7:Destroy()
			tbl2.guis[arg] = nil
		end

		tbl2.parts[arg] = nil
	end

	tbl2.destroyAll = function()
		for k in pairs(tbl2.guis) do
			tbl2.destroy(k)
		end
	end

	tbl5 = {
		enabled = false,
		conn = nil,
		smooth = 1,
		part = "UpperTorso",
		murdererOnly = true,
		wallCheck = false,
		fov = 500,
		leadFactor = 1,
		predictedPosition = function(arg)
			if not arg then
				return nil
			end
			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return arg.Position
			end
			return arg.Position + (arg.AssemblyLinearVelocity or Vector3.zero) * math.clamp((humanoidRootPart.Position - arg.Position).Magnitude / 1200 * tbl5.leadFactor, 0.01, 0.3)
		end,
		getPart = function(arg)
			if not arg then
				return nil
			end
			return arg:FindFirstChild(tbl5.part) or arg:FindFirstChild("UpperTorso") or arg:FindFirstChild("Torso") or arg:FindFirstChild("HumanoidRootPart") or arg:FindFirstChild("Head")
		end,
		alive = function(arg)
			if not arg or not arg.Character then
				return false
			end
			local humanoid = arg.Character:FindFirstChildOfClass("Humanoid")
			return humanoid ~= nil and humanoid.Health > 0
		end,
		inFov = function(arg)
			if tbl5.fov >= 500 then
				return true
			end
			local currentCamera = workspace.CurrentCamera
			local v6, v7 = currentCamera:WorldToViewportPoint(arg)
			if not v7 then
				return false
			end
			local n8 = currentCamera.ViewportSize / 2
			return (Vector2.new(v6.X, v6.Y) - n8).Magnitude <= tbl5.fov
		end,
		getTarget = function()
			local v6 = fn()

			if v6 and v6 ~= localPlayer and tbl5.alive(v6) then
				local v7 = tbl5.getPart(v6.Character)

				if v7 and tbl5.inFov(v7.Position) then
					local flag18 = not tbl5.wallCheck

					if not flag18 then
						flag18 = fn33(v6.Character, localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart"))
					end

					if flag18 then
						return v6, v7
					end
				end
			end

			if tbl5.murdererOnly then
				return nil, nil
			end
			local currentCamera = workspace.CurrentCamera
			local n8 = currentCamera.ViewportSize / 2
			local huge = math.huge
			local v7 = nil
			local v8 = nil

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= localPlayer and tbl5.alive(player) then
					local v9 = tbl5.getPart(player.Character)

					if v9 then
						local v10, v11 = currentCamera:WorldToViewportPoint(v9.Position)

						if v11 then
							local magnitude = (Vector2.new(v10.X, v10.Y) - n8).Magnitude

							if magnitude <= tbl5.fov and magnitude < huge then
								local flag18 = not tbl5.wallCheck
								local v12

								if flag18 then
									v12 = flag18
								else
									v12 = fn33(player.Character, localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart"))
								end

								if v12 then
									huge = magnitude
									v7 = player
									v8 = v9
								end
							end
						end
					end
				end
			end

			return v7, v8
		end,
	}

	tbl.hasGun = function()
		local character = localPlayer.Character
		return character ~= nil and character:FindFirstChild("Gun") ~= nil
	end

	tbl5.noGunWarned = false

	tbl5.warnNoGun = function()
		if tbl5.noGunWarned then
			return
		end
		tbl5.noGunWarned = true

		v:Notify({
			Title = "No Gun",
			Content = "Aimbot is on but you are not holding a gun - it will start aiming the moment you pick one up.",
			Duration = 4,
			Icon = "clock",
		})
	end

	tbl5.start = function()
		if tbl5.conn then
			return
		end
		tbl5.conn = RunService.RenderStepped:Connect(function()
			if not tbl5.enabled then
				return
			end

			if not tbl.hasGun() then
				tbl5.warnNoGun()
				return
			end
			tbl5.noGunWarned = false

			pcall(function()
				local v6
				v6, v6 = tbl5.getTarget()
				if not v6 then
					return
				end
				local currentCamera = workspace.CurrentCamera
				if not currentCamera then
					return
				end
				currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.new(currentCamera.CFrame.Position, tbl5.predictedPosition(v6) or v6.Position), math.clamp(tbl5.smooth, 0.01, 1))
			end)
		end)
	end

	tbl5.stop = function()
		if tbl5.conn then
			tbl5.conn:Disconnect()
			tbl5.conn = nil
		end
	end

	tbl5.refreshLabel = function()
		if tbl5.label then
			tbl5.label.Text = tbl5.enabled and "AIMBOT\nON" or "AIMBOT\nOFF"
		end

		tbl2.setActive("Aimbot", tbl5.enabled)
	end

	tbl5.set = function(enabled)
		tbl5.enabled = enabled

		if enabled then
			tbl5.start()
		else
			tbl5.stop()
		end

		tbl5.refreshLabel()

		if tbl5.toggleRef then
			pcall(function()
				tbl5.toggleRef:Set(enabled)
			end)
		end

		enabled = enabled and tbl.enableSilentAim

		if enabled then
			tbl.enableSilentAim()
		end
	end

	tbl6 = { aimOn = false, aimConn = nil, aimDisabled = {}, conns = {} }
	tbl7 = { enabled = false, conn = nil, delay = 0.18, fov = 60, last = 0 }

	local function fn60(arg)
		if not arg or not arg.Character then
			return false
		end
		local humanoid = arg.Character:FindFirstChildOfClass("Humanoid")
		return humanoid ~= nil and humanoid.Health > 0
	end

	local function fn61(arg, arg2)
		for _, v6 in ipairs(arg2) do
			pcall(function()
				v6:Enable()
			end)
		end

		for i = #arg2, 1, -1 do
			arg2[i] = nil
		end

		if not getconnections then
			return false
		end

		return (pcall(function()
			local character = localPlayer.Character
			character = character and character:FindFirstChild(arg)
			if not character then
				return
			end

			for _, v6 in ipairs(getconnections(character.Activated)) do
				v6:Disable()
				table.insert(arg2, v6)
			end
		end))
	end

	local function fn62(arg)
		for _, v6 in ipairs(arg) do
			pcall(function()
				v6:Enable()
			end)
		end

		for i = #arg, 1, -1 do
			arg[i] = nil
		end
	end

	local function fn63(arg, arg2, arg3, arg4)
		local function fn64(arg5)
			if not arg5 then
				return
			end

			table.insert(arg4, arg5.ChildAdded:Connect(function(child)
				if child.Name == arg and child:IsA("Tool") and arg3() then
					task.wait(0.1)
					fn61(arg, arg2)
				end
			end))
		end

		fn64(localPlayer.Character)

		table.insert(arg4, localPlayer.CharacterAdded:Connect(function(character)
			if not arg3() then
				return
			end
			task.wait(1)
			fn61(arg, arg2)
			fn64(character)
		end))
	end

	fn42 = function()
		if tbl6.aimConn then
			return
		end
		fn61("Gun", tbl6.aimDisabled)

		if not getconnections then
			v:Notify({
				Title = "Silent Aim",
				Content = "Your executor has no getconnections - the normal shot fires too.",
				Duration = 4,
				Icon = "x",
			})
		end

		fn63("Gun", tbl6.aimDisabled, function()
			return tbl6.aimOn
		end, tbl6.conns)

		tbl6.aimConn = localPlayer:GetMouse().Button1Down:Connect(function()
			if not tbl6.aimOn then
				return
			end
			local character = localPlayer.Character
			local gun = character and character:FindFirstChild("Gun")
			gun = gun and gun:FindFirstChild("Shoot")
			character = character and character:FindFirstChild("HumanoidRootPart")
			if not gun or not character then
				return
			end
			local v6 = fn()
			local flag18 = v6 and v6 ~= localPlayer and fn60(v6)
			local v7 = nil

			if flag18 then
				local humanoidRootPart = v6.Character:FindFirstChild("HumanoidRootPart")
				local flag19 = humanoidRootPart and (character.Position - humanoidRootPart.Position).Magnitude <= 300
				v7 = nil

				if flag19 then
					if flag14 and not fn33(v6.Character, character) then
						v:Notify({
							Title = "Wall Detected!",
							Content = "Murderer is behind a wall.",
							Duration = 2,
							Icon = "shield",
						})

						v7 = nil
					else
						v7 = tbl.aimAt(v6, humanoidRootPart)
					end
				end
			end

			v7 = v7 or tbl.mouseAimPoint()
			if not v7 then
				return
			end
			local gunRaycastAttachment = character:FindFirstChild("GunRaycastAttachment")
			gun:FireServer(gunRaycastAttachment and gunRaycastAttachment.WorldCFrame or CFrame.new(character.Position), CFrame.new(v7))
		end)
	end

	fn43 = function()
		if tbl6.aimConn then
			pcall(function()
				tbl6.aimConn:Disconnect()
			end)

			tbl6.aimConn = nil
		end

		fn62(tbl6.aimDisabled)
		tbl.dropConns(tbl6.conns)
	end

	tbl.enableSilentAim = function()
		if tbl6.aimOn then
			return
		end
		tbl6.aimOn = true
		fn42()
		tbl.setToggle(tbl.el.silentaim, true)
	end

	tbl7.start = function()
		if tbl7.conn then
			return
		end

		tbl7.conn = RunService.Heartbeat:Connect(function()
			if not tbl7.enabled then
				return
			end
			local last = tbl7.last
			if tick() - last < tbl7.delay then
				return
			end

			pcall(function()
				if fn2() ~= localPlayer then
					return
				end
				local character = localPlayer.Character
				local gun = character and character:FindFirstChild("Gun")
				gun = gun and gun:FindFirstChild("Shoot")
				if not gun then
					return
				end
				local v6 = fn()
				if not v6 or v6 == localPlayer or not fn60(v6) then
					return
				end
				local humanoidRootPart = v6.Character:FindFirstChild("HumanoidRootPart")
				local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart or not humanoidRootPart2 then
					return
				end
				local currentCamera = Workspace.CurrentCamera
				local v7, v8 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)
				if not v8 then
					return
				end
				local n8 = currentCamera.ViewportSize / 2
				if tbl7.fov < (Vector2.new(v7.X, v7.Y) - n8).Magnitude then
					return
				end

				if flag14 and not fn33(v6.Character, humanoidRootPart2) then
					return
				end

				if (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude > 300 then
					return
				end
				tbl7.last = tick()
				local gunRaycastAttachment = humanoidRootPart2:FindFirstChild("GunRaycastAttachment")
				gun:FireServer(gunRaycastAttachment and gunRaycastAttachment.WorldCFrame or CFrame.new(humanoidRootPart2.Position), CFrame.new(tbl.aimAt(v6, humanoidRootPart)))
			end)
		end)
	end

	tbl7.stop = function()
		if tbl7.conn then
			pcall(function()
				tbl7.conn:Disconnect()
			end)

			tbl7.conn = nil
		end
	end

	local function fn64()
		local character = localPlayer.Character
		if not character then
			return nil
		end
		local knife = character:FindFirstChild("Knife")
		if knife then
			return knife, character
		end
		local backpack = localPlayer:FindFirstChild("Backpack")
		backpack = backpack and backpack:FindFirstChild("Knife")
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if backpack and humanoid then
			humanoid:EquipTool(backpack)
			task.wait(0.1)
			local character2 = localPlayer.Character
			return character2 and character2:FindFirstChild("Knife"), character2
		end

		return nil
	end

	local function fn65(arg)
		if not arg or not arg.Character then
			return false
		end
		local humanoid = arg.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			return false
		end
		local v6, v7 = fn64()
		if not v6 or not v7 then
			return false
		end
		local rightHand = v7:FindFirstChild("RightHand") or v7:FindFirstChild("HumanoidRootPart")
		if not rightHand then
			return false
		end
		local v8 = fn51(arg, 600, 0.95)
		if not v8 then
			return false
		end
		local throw = v6:FindFirstChild("Throw") or v6:FindFirstChild("Events") and v6.Events:FindFirstChild("KnifeThrown")
		if not (throw and throw:IsA("RemoteEvent")) then
			return false
		end
		local handle = v6:FindFirstChild("Handle")
		throw:FireServer(handle and handle.CFrame or CFrame.new(rightHand.Position), CFrame.new(v8))

		pcall(function()
			local humanoid2 = v7:FindFirstChildOfClass("Humanoid")
			humanoid2 = humanoid2 and humanoid2:FindFirstChildOfClass("Animator")
			local throwKnife = v6:FindFirstChild("ThrowKnife", true)

			if humanoid2 and throwKnife then
				humanoid2:LoadAnimation(throwKnife):Play(0.1, 6, 1)
			end
		end)

		return true
	end

	local function fn66(arg, arg2)
		local character

		if arg2 then
			character = localPlayer.Character
			character = character and character:FindFirstChild("Knife")
		else
			character = fn64()
		end

		character = character and character:FindFirstChild("Events")
		if not character then
			return 0
		end
		local knifeStabbed = character:FindFirstChild("KnifeStabbed")
		local handleTouched = character:FindFirstChild("HandleTouched")
		if not (knifeStabbed and handleTouched) then
			return 0
		end

		pcall(function()
			knifeStabbed:FireServer()
		end)

		local n8 = 0

		for _, v6 in ipairs(arg) do
			local character2 = v6.Character
			local humanoidRootPart = character2 and (character2:FindFirstChild("HumanoidRootPart") or character2:FindFirstChild("Torso") or character2:FindFirstChildWhichIsA("BasePart"))

			if humanoidRootPart then
				pcall(function()
					handleTouched:FireServer(humanoidRootPart)
				end)

				n8 += 1
			end
		end

		return n8
	end

	local function fn67(arg)
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		local tbl10 = {}

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

				if humanoidRootPart2 and humanoid and humanoid.Health > 0 then
					local v6 = arg and humanoidRootPart
					local flag18 = true

					if v6 then
						flag18 = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude <= arg
					end

					if flag18 then
						tbl10[#tbl10 + 1] = player
					end
				end
			end
		end

		return tbl10
	end

	fn44 = function(arg)
		if not arg or arg == "" then
			v:Notify({ Title = "No target", Content = "Pick a player first.", Duration = 2, Icon = "x" })
			return
		end

		if fn() ~= localPlayer then
			v:Notify({ Title = "Not Murderer!", Content = "You don't have the knife.", Duration = 2, Icon = "x" })
			return
		end
		local v6 = Players:FindFirstChild(arg)
		if not v6 then
			v:Notify({ Title = "Gone", Content = arg .. " isn't in the server.", Duration = 2, Icon = "x" })
			return
		end
		local v7 = fn66({ v6 })

		v:Notify({
			Title = v7 > 0 and "Stabbed" or "Failed",
			Content = v7 > 0 and "Stabbed " .. arg .. "." or "Couldn't reach " .. arg .. ".",
			Duration = 2,
			Icon = v7 > 0 and "check" or "x",
		})
	end

	fn45 = function()
		if fn() ~= localPlayer then
			v:Notify({ Title = "Not Murderer!", Content = "You don't have the knife.", Duration = 2, Icon = "x" })
			return
		end
		local v6 = fn66(fn67(nil))

		v:Notify({
			Title = "Kill All",
			Content = ("Stabbed %d player%s."):format(v6, v6 == 1 and "" or "s"),
			Duration = 2,
			Icon = "check",
		})
	end

	tbl8 = {
		on = false,
		conn = nil,
		show = false,
		ball = nil,
		showConn = nil,
		NORMAL = 1.5,
		STEP = 0.1,
		mult = 1,
		radius = 1.5,
		setMult = function(mult)
			tbl8.mult = mult
			tbl8.radius = tbl8.NORMAL * (1 + (mult - 1) * tbl8.STEP)
		end,
		stop = function()
			if tbl8.conn then
				pcall(function()
					tbl8.conn:Disconnect()
				end)
			end

			tbl8.conn = nil

			if tbl8.thrownConn then
				pcall(function()
					tbl8.thrownConn:Disconnect()
				end)
			end

			tbl8.thrownConn = nil
		end,
		start = function()
			tbl8.stop()

			tbl8.conn = localPlayer:GetMouse().Button1Down:Connect(function()
				if not tbl8.on then
					return
				end

				if fn() ~= localPlayer then
					return
				end
				fn66(fn67(tbl8.radius), true)
			end)

			tbl8.thrownConn = CollectionService:GetInstanceAddedSignal("ThrowingKnife"):Connect(function(arg)
				if not tbl8.on then
					return
				end

				task.spawn(function()
					local handleLink = arg:WaitForChild("HandleLink", 3)
					handleLink = handleLink and handleLink.Value
					handleLink = handleLink and handleLink.Parent
					local character = localPlayer.Character
					if not (handleLink and character and handleLink:IsDescendantOf(character)) then
						return
					end
					local events = handleLink:FindFirstChild("Events")
					local knifeStabbed = events and events:FindFirstChild("KnifeStabbed")
					local handleTouched = events and events:FindFirstChild("HandleTouched")
					if not (knifeStabbed and handleTouched) then
						return
					end
					local tbl10 = {}

					while arg.Parent and tbl8.on do
						local position = arg:IsA("BasePart") and arg.Position
						local position2

						if position then
							position2 = position
						else
							position2 = arg:IsA("Model") and arg:GetPivot().Position
						end

						if position2 then
							for _, player in ipairs(Players:GetPlayers()) do
								if player ~= localPlayer and not tbl10[player] and player.Character then
									local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
									local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

									if humanoidRootPart and humanoid and humanoid.Health > 0 and (humanoidRootPart.Position - position2).Magnitude <= tbl8.radius then
										tbl10[player] = true

										pcall(function()
											knifeStabbed:FireServer()
										end)

										pcall(function()
											handleTouched:FireServer(humanoidRootPart)
										end)
									end
								end
							end
						end

						task.wait(0.05)
					end
				end)
			end)
		end,
		hideBall = function()
			if tbl8.showConn then
				pcall(function()
					tbl8.showConn:Disconnect()
				end)
			end

			tbl8.showConn = nil

			if tbl8.ball then
				pcall(function()
					tbl8.ball:Destroy()
				end)
			end

			tbl8.ball = nil
		end,
		showBall = function()
			tbl8.hideBall()
			local part = Instance.new("Part")
			part.Name = "OnyxHitboxSphere"
			part.Shape = Enum.PartType.Ball
			part.Anchored = true
			part.CanCollide = false
			part.CanTouch = false
			part.CanQuery = false
			part.CastShadow = false
			part.Material = Enum.Material.Neon
			part.Color = Color3.fromRGB(255, 90, 90)
			part.Transparency = 0.88
			part.Size = Vector3.one * tbl8.radius * 2
			part.Parent = Workspace.CurrentCamera
			tbl8.ball = part

			tbl8.showConn = RunService.RenderStepped:Connect(function()
				if not part.Parent then
					return
				end
				local character = localPlayer.Character
				if not character then
					return
				end
				local position = nil

				for _, v6 in ipairs(CollectionService:GetTagged("ThrowingKnife")) do
					local handleLink = v6:FindFirstChild("HandleLink")
					local value = handleLink and handleLink.Value
					local parent = value and value.Parent

					if parent and parent:IsDescendantOf(character) then
						position = v6:IsA("BasePart") and v6.Position or v6:IsA("Model") and v6:GetPivot().Position
						if not position then
							continue
						end
					else
						continue
					end

					break
				end

				if not position then
					position = character:FindFirstChild("Knife")
					position = position and position:FindFirstChild("Handle")
					position = position and position.Position
				end

				if not position then
					position = character:FindFirstChild("HumanoidRootPart")
					position = position and position.Position
				end

				if position then
					part.Size = Vector3.one * tbl8.radius * 2
					part.CFrame = CFrame.new(position)
				end
			end)
		end,
	}

	tbl9 = {
		on = false,
		conn = nil,
		disabled = {},
		conns = {},
		stop = function()
			if tbl9.conn then
				pcall(function()
					tbl9.conn:Disconnect()
				end)
			end

			tbl9.conn = nil
			fn62(tbl9.disabled)
			tbl.dropConns(tbl9.conns)
		end,
		start = function()
			if tbl9.conn then
				return
			end
			fn61("Knife", tbl9.disabled)

			if not getconnections then
				v:Notify({
					Title = "Silent Throw",
					Content = "Your executor has no getconnections - the normal throw fires too.",
					Duration = 4,
					Icon = "x",
				})
			end

			fn63("Knife", tbl9.disabled, function()
				return tbl9.on
			end, tbl9.conns)

			tbl9.conn = localPlayer:GetMouse().Button2Down:Connect(function()
				if not tbl9.on then
					return
				end

				if fn() ~= localPlayer then
					return
				end
				local v6 = fn34()
				if not v6 then
					return
				end
				local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart and flag14 and not fn33(v6.Character, humanoidRootPart) then
					v:Notify({
						Title = "Wall Detected!",
						Content = v6.Name .. " is behind a wall.",
						Duration = 2,
						Icon = "shield",
					})

					return
				end

				fn65(v6)
			end)
		end,
	}
end

local fn46

fn46 = function()
	local v6 = tbl7
	tbl6.aimOn = false
	v6.enabled = false
	fn43()
	tbl7.stop()
	tbl.dropConns(tbl6.conns)
	tbl8.on = false
	tbl8.stop()
	tbl8.show = false
	tbl8.hideBall()
	tbl9.on = false
	tbl9.stop()
end

MM2_GUN_ICON = "rbxassetid://79658449"

CURSORS = {
	Default = MM2_GUN_ICON,
	Paw = "rbxassetid://11767069582",
	Gengar = "rbxassetid://11759293285",
	Bunny = "rbxassetid://1912438810",
	["Hello Kitty"] = "rbxassetid://11351620343",
	["Kitty v2"] = "rbxassetid://11802094220",
	Heart = "rbxthumb://type=Asset&w=420&h=420&id=11722368344",
	Pentagram = "rbxassetid://51838212",
	Star = "rbxassetid://11716559277",
	["Star v2"] = "rbxassetid://11716557686",
	Osu = "rbxassetid://8390115370",
	["Power Star"] = "rbxassetid://1718840561",
	Troll = "rbxassetid://12438907427",
	Cross = "rbxthumb://type=Asset&w=420&h=420&id=14034486267",
	["Pink Star"] = "rbxthumb://type=Asset&w=420&h=420&id=11719595129",
	Kuromi = "rbxthumb://type=Asset&w=420&h=420&id=11893991373",
	["Red Heart"] = "rbxthumb://type=Asset&w=420&h=420&id=11754042886",
	["Green Heart"] = "rbxthumb://type=Asset&w=420&h=420&id=11754039821",
	["Blue Heart"] = "rbxthumb://type=Asset&w=420&h=420&id=11754037423",
	["Yellow Heart"] = "rbxthumb://type=Asset&w=420&h=420&id=11754042019",
	["Heart Cross"] = "rbxassetid://11739569678",
	["Clean Kitty"] = "rbxassetid://11718192673",
	["Pixel Cat"] = "rbxassetid://10878214990",
	["Evil Kitty"] = "rbxassetid://11734940424",
	["Vamp Face"] = "rbxassetid://11734893655",
	["Glowing Circle"] = "rbxassetid://10891594349",
	Bear = "rbxassetid://11722088774",
	["Shoot this guy"] = "rbxassetid://8680062686",
	Barbie = "rbxassetid://11754489642",
	Death = "rbxassetid://12472046162",
	Donut = "rbxassetid://11717104785",
	Cat = "rbxassetid://11722553511",
	["Blue Donut"] = "rbxassetid://11717093063",
}

local tbl10, v6, fn47, flag15, fn48, fn49

do
	local n4 = 55
	tbl10 = { style = "Default", onlyWithGun = false, size = 50, spin = false }
	local mouse = localPlayer:GetMouse()
	local v7 = nil
	v6 = nil
	local connection5 = nil
	local mouseIconEnabled = UserInputService.MouseIconEnabled

	local function fn50()
		return tbl.hasGun()
	end

	local function fn51()
		if connection5 then
			pcall(function()
				connection5:Disconnect()
			end)

			connection5 = nil
		end

		if v7 then
			pcall(function()
				v7:Destroy()
			end)

			v7 = nil
		end

		v6 = nil
		UserInputService.MouseIconEnabled = mouseIconEnabled

		pcall(function()
			mouse.Icon = fn50() and MM2_GUN_ICON or ""
		end)
	end

	fn47 = function()
		fn51()
		if tbl10.style == "Default" or not CURSORS[tbl10.style] then
			return
		end
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "OnyxCrosshair"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 10000
		screenGui.Parent = CoreGui
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = CURSORS[tbl10.style] or CURSORS.Paw
		imageLabel.Size = UDim2.fromOffset(tbl10.size, tbl10.size)
		imageLabel.ScaleType = Enum.ScaleType.Stretch
		imageLabel.Parent = screenGui
		v7 = screenGui
		v6 = imageLabel

		connection5 = RunService.RenderStepped:Connect(function(deltaTime)
			if not imageLabel.Parent then
				return
			end

			if tbl10.spin then
				imageLabel.Rotation = (imageLabel.Rotation + deltaTime * n4) % 360
			elseif imageLabel.Rotation ~= 0 then
				imageLabel.Rotation = 0
			end

			local visible = not tbl10.onlyWithGun or fn50()
			imageLabel.Visible = visible

			if visible then
				UserInputService.MouseIconEnabled = false
			else
				UserInputService.MouseIconEnabled = mouseIconEnabled
			end

			if visible then
				local mouseLocation = UserInputService:GetMouseLocation()
				imageLabel.Position = UDim2.fromOffset(mouseLocation.X, mouseLocation.Y)
			end
		end)
	end

	flag15 = false

	fn48 = function(arg)
		return function(...)
			if not flag15 then
				return
			end
			return arg(...)
		end
	end

	fn49 = function()
		tbl10.style = "Default"
		fn51()
	end
end

local tbl11
tbl11 = {}

ICON = {
	teal = Color3.fromHex("#14B8A6"),
	green = Color3.fromHex("#10B981"),
	grey = Color3.fromHex("#94A3B8"),
	purple = Color3.fromHex("#8B5CF6"),
	blue = Color3.fromHex("#3B82F6"),
	yellow = Color3.fromHex("#F59E0B"),
	red = Color3.fromHex("#F43F5E"),
	pink = Color3.fromHex("#EC4899"),
	gold = Color3.fromHex("#FFC107"),
	mono = Color3.fromHex("#E5E7EB"),
	tile = Color3.fromHex("#6E6E7B"),
}

tbl11.combat = v2:Tab({
	Title = "Combat",
	Icon = "lucide:shield",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

tbl11.crosshair = v2:Tab({
	Title = "Crosshair",
	Icon = "lucide:crosshair",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

tbl11.skins = v2:Tab({
	Title = "Skin Changer",
	Icon = "lucide:sword",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

do
	local color2 = Color3.new(1, 1, 1)
	local flag16 = false

	local function fn50()
		for _, descendant in ipairs(v2.UIElements.Main:GetDescendants()) do
			if descendant:IsA("TextLabel") and descendant.Text == "Skin Changer" then
				for _, descendant2 in ipairs(descendant.Parent.Parent:GetDescendants()) do
					if descendant2:IsA("ImageLabel") and descendant2.Name == "ImageLabel" and descendant2.ImageColor3 ~= ICON.tile then
						descendant2.ImageColor3 = color2

						descendant2:GetPropertyChangedSignal("ImageColor3"):Connect(function()
							if descendant2.ImageColor3 ~= color2 then
								descendant2.ImageColor3 = color2
							end
						end)

						flag16 = true
					end
				end

				return flag16
			end
		end

		return false
	end

	if not fn50() then
		task.spawn(function()
			for i = 1, 30 do
				RunService.RenderStepped:Wait()
				if fn50() then
					return
				end
			end
		end)
	end
end

tbl11.buttons = v2:Tab({
	Title = "Buttons",
	Icon = "lucide:gamepad-directional",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

tbl11.esp = v2:Tab({
	Title = "ESP",
	Icon = "solar:eye-bold",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

tbl11.fling = v2:Tab({
	Title = "Fling & Teleport",
	Icon = "solar:bolt-bold",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

tbl11.farm = v2:Tab({
	Title = "Autofarm",
	Icon = "solar:dollar-minimalistic-bold",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

tbl11.player = v2:Tab({
	Title = "Player",
	Icon = "solar:user-bold",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

tbl11.visuals = v2:Tab({
	Title = "Visuals",
	Icon = "lucide:sparkles",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

tbl.discordCard(tbl11.visuals)
tbl11.visuals:Section({ Title = "Sound Changer" })

tbl11.visuals:Toggle({
	Title = "Error Sound",
	Flag = "Toggle_Sound_Errors",
	Desc = "A cue when something fails or gets refused.",
	Type = "Toggle",
	Value = true,
	Callback = function(error_)
		tbl.sfxOn.error = error_
	end,
})

tbl11.visuals:Toggle({
	Title = "Gun Drop Sound",
	Flag = "Toggle_Sound_Gun_Drop",
	Desc = "A cue when the sheriff dies and the gun drops. Useful with the window closed.",
	Type = "Toggle",
	Value = true,
	Callback = function(gun)
		tbl.sfxOn.gun = gun
	end,
})

tbl11.visuals:Toggle({
	Title = "Button Click Sound",
	Flag = "Toggle_Sound_Button_Click",
	Desc = "A click when you press an on-screen button.",
	Type = "Toggle",
	Value = true,
	Callback = function(click)
		tbl.sfxOn.click = click
	end,
})

tbl11.visuals:Toggle({
	Title = "Toggle Sound",
	Flag = "Toggle_Sound_Switches",
	Desc = "A click when you flip a switch in the menu.",
	Type = "Toggle",
	Value = true,
	Callback = function(toggle)
		tbl.sfxOn.toggle = toggle

		if toggle and tbl.sfxReady and not tbl.sfxQuiet then
			tbl.playSfx("toggle")
		end
	end,
})

tbl.myRole = function()
	local remotes = ReplicatedStorage:FindFirstChild("Remotes")
	remotes = remotes and remotes:FindFirstChild("Extras")
	local getPlayerData = remotes and remotes:FindFirstChild("GetPlayerData")
	if not getPlayerData then
		return nil
	end

	local ok, result = pcall(function()
		return getPlayerData:InvokeServer()
	end)

	if not ok or type(result) ~= "table" then
		return nil
	end
	local v7 = result[localPlayer.Name]
	return v7 and v7.Role or nil
end

tbl.godMode = function()
	if tbl.godBusy then
		v:Notify({ Title = "God Mode", Content = "Already running.", Duration = 3, Icon = "clock" })
		return
	end
	local v7 = next
	local children, v8 = Workspace:GetChildren()
	local v9 = nil

	for _, v10 in v7, children, v8 do
		if v10:FindFirstChild("CoinAreas") or v10:FindFirstChild("CoinContainer") then
			v9 = v10
		end
	end

	if not v9 then
		v:Notify({
			Title = "No Map Yet",
			Content = "Wait till the round starts, then try again.",
			Duration = 5,
			Icon = "clock",
		})

		return
	end

	v4 = v9
	if not (localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")) then
		v:Notify({ Title = "God Mode", Content = "No character to reset.", Duration = 4, Icon = "x" })
		return
	end

	task.spawn(function()
		local v10 = tbl.myRole()

		if v10 == "Murderer" then
			v:Notify({
				Title = "Murderer",
				Content = "This only works for Innocent and Sheriff.",
				Duration = 6,
				Icon = "x",
			})

			return
		end

		if v10 == "Sheriff" then
			v:Popup({
				Title = "ARE YOU SURE YOU WANT TO LOSE UR GUN?",
				Icon = "shield",
				Content = "If you enable god mode you CANT pick up coins or kill someone.",
				Buttons = {
					{
						Title = "Cancel",
						Variant = "Tertiary",
						Callback = function()
						end,
					},
					{
						Title = "Yes, do it",
						Variant = "Primary",
						Callback = function()
							tbl.godRun()
						end,
					},
				},
			})

			return
		end

		tbl.godRun()
	end)
end

tbl.godRun = function()
	if tbl.godBusy then
		return
	end
	local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		v:Notify({ Title = "God Mode", Content = "No character to reset.", Duration = 4, Icon = "x" })
		return
	end
	tbl.godBusy = true

	task.spawn(function()
		v:Notify({
			Title = "God Mode",
			Content = "Resetting, back on the map in a second...",
			Duration = 3,
			Icon = "shield",
		})

		pcall(function()
			humanoid.Health = 0
		end)

		task.wait(1)
		local now = tick()
		local v7

		while true do
			v7 = fn26(localPlayer)

			if not v7 then
				task.wait(0.2)
			end

			if not (v7 or tick() - now > 10) then
				continue
			end
			break
		end

		if v7 then
			pcall(tbl.teleportHome)

			v:Notify({
				Title = "God Mode On!",
				Content = "You cannot pick up coins or the gun now.",
				Duration = 6,
				Icon = "shield",
			})
		else
			v:Notify({ Title = "God Mode", Content = "Respawn took too long - try again.", Duration = 5, Icon = "x" })
		end

		tbl.godBusy = false
	end)
end

tbl11.keybinds = v2:Tab({
	Title = "Keybinds",
	Icon = "lucide:keyboard",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

tbl11.settings = v2:Tab({
	Title = "Settings & Configs",
	Icon = "solar:settings-bold",
	IconColor = ICON.tile,
	IconShape = "Square",
	Border = true,
})

LOADUI.step(0.78, "Building tabs")
tbl.discordCard(tbl11.settings)

do
	local tbl12 = {
		Combat = ICON.tile,
		Crosshair = ICON.tile,
		["Skin Changer"] = ICON.tile,
		Buttons = ICON.tile,
		ESP = ICON.tile,
		["Fling & Teleport"] = ICON.tile,
		Autofarm = ICON.tile,
		Player = ICON.tile,
		Visuals = ICON.tile,
		Keybinds = ICON.tile,
		["Settings & Configs"] = ICON.tile,
	}

	local color2 = Color3.new(1, 1, 1)
	local tbl13 = {}

	local function fn50(arg, arg2)
		return math.abs(arg.R - arg2.R) < 0.02 and math.abs(arg.G - arg2.G) < 0.02 and math.abs(arg.B - arg2.B) < 0.02
	end

	task.spawn(function()
		for i = 1, 60 do
			local n4 = 0

			pcall(function()
				for _, descendant in ipairs(v2.UIElements.Main:GetDescendants()) do
					local parent = descendant:IsA("TextLabel") and tbl12[descendant.Text] and descendant.Parent and descendant.Parent.Parent or nil

					if parent and parent:IsA("ImageButton") then
						local descendants = parent:GetDescendants()
						local v7 = nil

						for _, descendant2 in ipairs(descendants) do
							if descendant2:IsA("ImageLabel") and fn50(descendant2.ImageColor3, tbl12[descendant.Text]) then
								v7 = descendant2
								break
							else
								v7 = nil
							end
						end

						if v7 then
							if not v7:FindFirstChildWhichIsA("UIGradient") then
								local uiGradient = Instance.new("UIGradient")
								uiGradient.Rotation = 90
								local new = ColorSequenceKeypoint.new
								local color3 = Color3.fromRGB
								uiGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), new(1, color3(115, 115, 125)) })
								uiGradient.Parent = v7
								n4 += 1
							end

							for _, descendant2 in ipairs(descendants) do
								if descendant2 ~= v7 and descendant2:IsA("ImageLabel") and descendant2.Name == "ImageLabel" and not tbl13[descendant2] then
									tbl13[descendant2] = true
									descendant2.ImageColor3 = color2

									descendant2:GetPropertyChangedSignal("ImageColor3"):Connect(function()
										if descendant2.ImageColor3 ~= color2 then
											descendant2.ImageColor3 = color2
										end
									end)

									n4 += 1
								end
							end
						end
					end
				end
			end)

			if n4 > 0 then
				return
			end
			RunService.RenderStepped:Wait()
		end
	end)
end

local fn50

fn50 = function(arg, imageColor3, imageTransparency, textColor3)
	imageTransparency = imageTransparency or 0.55

	for _, descendant in ipairs(v2.UIElements.Main:GetDescendants()) do
		if descendant:IsA("TextLabel") and descendant.Text == arg then
			local imageButton = descendant:FindFirstAncestorWhichIsA("ImageButton")

			if imageButton then
				imageButton.ImageColor3 = imageColor3
				imageButton.ImageTransparency = imageTransparency

				imageButton:GetPropertyChangedSignal("ImageColor3"):Connect(function()
					if imageButton.ImageColor3 ~= imageColor3 then
						imageButton.ImageColor3 = imageColor3
					end
				end)

				imageButton:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
					if imageButton.ImageTransparency > imageTransparency then
						imageButton.ImageTransparency = imageTransparency
					end
				end)

				if textColor3 then
					for _, descendant2 in ipairs(imageButton:GetDescendants()) do
						if descendant2:IsA("TextLabel") then
							descendant2.TextColor3 = textColor3

							descendant2:GetPropertyChangedSignal("TextColor3"):Connect(function()
								if descendant2.TextColor3 ~= textColor3 then
									descendant2.TextColor3 = textColor3
								end
							end)
						elseif descendant2:IsA("ImageLabel") and descendant2.Size ~= UDim2.new(1, 0, 1, 0) then
							descendant2.ImageColor3 = textColor3

							descendant2:GetPropertyChangedSignal("ImageColor3"):Connect(function()
								if descendant2.ImageColor3 ~= textColor3 then
									descendant2.ImageColor3 = textColor3
								end
							end)
						end
					end
				end
			end

			return
		end
	end
end

local fn51

fn51 = function(arg)
	local ok, result = pcall(function()
		return arg.ParagraphFrame.UIElements.Container
	end)

	if ok and typeof(result) == "Instance" then
		return result
	end
	return nil
end

local fn52
local tbl12 = {}

fn52 = function(imageColor3)
	for _, descendant in ipairs(v2.UIElements.Main:GetDescendants()) do
		if not tbl12[descendant] and descendant.Name == "ToggleFrame" then
			local layer = descendant:FindFirstChild("Layer")

			if layer then
				tbl12[descendant] = true
				layer.ImageColor3 = imageColor3

				if not layer:FindFirstChildWhichIsA("UIGradient") then
					local uiGradient = Instance.new("UIGradient")
					uiGradient.Rotation = 115

					uiGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 130)),
					})

					uiGradient.Parent = layer
				end

				local frame = descendant:FindFirstChild("Frame")
				frame = frame and frame:FindFirstChild("Bar")
				frame = frame and frame:FindFirstChild("Highlight")
				local glass = frame and frame:FindFirstChild("Glass")

				if glass then
					glass.ImageColor3 = imageColor3

					glass:GetPropertyChangedSignal("ImageColor3"):Connect(function()
						if glass.ImageColor3 ~= imageColor3 then
							glass.ImageColor3 = imageColor3
						end
					end)
				end
			end
		end
	end
end

tbl11.esp:Section({ Title = "ESP — See Through Walls" })

tbl11.esp:Toggle({
	Title = "ESP Outline",
	Flag = "Toggle_ESP_Outline",
	Desc = "Glowing outline on every player through walls.",
	Type = "Toggle",
	Value = false,
	Callback = function(arg)
		flag = arg

		if fn3() then
			fn4()
			fn7()
		else
			v3:RemoveGroup("players")
			fn8()
		end
	end,
})

tbl11.esp:Toggle({
	Title = "Full Body ESP",
	Flag = "Toggle_Full_Body_ESP",
	Desc = "Fills the whole body in the role colour.",
	Type = "Toggle",
	Value = false,
	Callback = function(arg)
		flag2 = arg

		if fn3() then
			fn4()
			fn7()
		else
			v3:RemoveGroup("players")
			fn8()
		end
	end,
})

tbl11.esp:Toggle({
	Title = "Display Name ESP",
	Flag = "Toggle_Display_Name_ESP",
	Desc = "Their display name above their head, in the role colour.",
	Type = "Toggle",
	Value = false,
	Callback = function(arg)
		flag3 = arg

		if fn3() then
			fn4()
			fn7()
		else
			v3:RemoveGroup("players")
			fn8()
		end
	end,
})

tbl11.esp:Toggle({
	Title = "Dropped Gun ESP",
	Flag = "Toggle_Dropped_Gun_ESP",
	Desc = "Shows the gun on the floor after the sheriff dies.",
	Type = "Toggle",
	Value = false,
	Callback = function(arg)
		flag4 = arg
		fn5()
	end,
})

tbl11.esp:Toggle({
	Title = "Trap ESP",
	Flag = "Toggle_Trap_ESP",
	Desc = "Shows traps other players hid around the map.",
	Type = "Toggle",
	Value = false,
	Callback = function(arg)
		flag5 = arg
		fn6()
	end,
})

tbl11.esp:Section({ Title = "Tracers & Distance" })

tbl11.esp:Toggle({
	Title = "Tracers",
	Flag = "Toggle_ESP_Tracers",
	Desc = "Draws a line from the bottom of your screen to every player, in their role colour.",
	Type = "Toggle",
	Value = false,
	Callback = function(lines)
		tbl.tr.lines = lines
		tbl.tr.sync()
	end,
})

tbl11.esp:Toggle({
	Title = "Distance",
	Flag = "Toggle_ESP_Distance",
	Desc = "How many studs away each player is, written under their feet.",
	Type = "Toggle",
	Value = false,
	Callback = function(dist)
		tbl.tr.dist = dist
		tbl.tr.sync()
	end,
})

tbl11.esp:Toggle({
	Title = "Off-Screen Arrows",
	Flag = "Toggle_ESP_Arrows",
	Desc = "Arrows around your crosshair pointing at the players you cannot see - including the ones behind you.",
	Type = "Toggle",
	Value = false,
	Callback = function(arrows)
		tbl.tr.arrows = arrows
		tbl.tr.sync()
	end,
})

tbl11.esp:Section({ Title = "ESP Colours" })

tbl11.esp:Colorpicker({
	Title = "Innocent",
	Flag = "Colorpicker_Innocent",
	Desc = "Outline colour for everyone else",
	Default = espColors.innocent,
	Callback = function(innocent)
		espColors.innocent = innocent
		local v7 = flag
		local v8

		if flag then
			v8 = v7
		else
			v8 = flag2
		end

		if v8 then
			fn4()
		end
	end,
})

tbl11.esp:Colorpicker({
	Title = "Sheriff",
	Flag = "Colorpicker_Sheriff",
	Desc = "Outline colour for the sheriff",
	Default = espColors.sheriff,
	Callback = function(sheriff)
		espColors.sheriff = sheriff
		local v7 = flag
		local v8

		if flag then
			v8 = v7
		else
			v8 = flag2
		end

		if v8 then
			fn4()
		end
	end,
})

tbl11.esp:Colorpicker({
	Title = "Murderer",
	Flag = "Colorpicker_Murderer",
	Desc = "Outline colour for the murderer",
	Default = espColors.murderer,
	Callback = function(murderer)
		espColors.murderer = murderer
		local v7 = flag
		local v8

		if flag then
			v8 = v7
		else
			v8 = flag2
		end

		if v8 then
			fn4()
		end
	end,
})

tbl11.esp:Colorpicker({
	Title = "Dropped Gun",
	Flag = "Colorpicker_Dropped_Gun_Blue",
	Desc = "Highlight colour for the dropped gun",
	Default = espColors.gun,
	Callback = function(gun)
		espColors.gun = gun
		fn5()
	end,
})

tbl11.esp:Colorpicker({
	Title = "Traps",
	Flag = "Colorpicker_Traps",
	Desc = "Highlight colour for traps",
	Default = espColors.trap,
	Callback = function(trap)
		espColors.trap = trap
		fn6()
	end,
})

fn52(ICON.mono)
tbl11.fling:Section({ Title = "Quick Actions" })

tbl.el.flingMurd = tbl11.fling:Button({
	Title = "Fling Murderer",
	Desc = "Yeet whoever has the knife",
	Icon = "lucide:flame",
	Callback = function()
		local v7 = fn()
		if not v7 then
			v:Notify({ Title = "Error!", Content = "No murderer this round!", Duration = 1.5, Icon = "x" })
			return
		end

		if v7 == localPlayer then
			v:Notify({ Title = "Error!", Content = "You can't fling yourself!", Duration = 1.5, Icon = "x" })
			return
		end
		fn9(v7)
	end,
})

tbl.el.flingSher = tbl11.fling:Button({
	Title = "Fling Sheriff",
	Desc = "Yeet whoever has the gun",
	Icon = "lucide:flame",
	Callback = function()
		local v7 = fn2()
		if not v7 then
			v:Notify({ Title = "Error!", Content = "No sheriff this round!", Duration = 1.5, Icon = "x" })
			return
		end

		if v7 == localPlayer then
			v:Notify({ Title = "Error!", Content = "You can't fling yourself!", Duration = 1.5, Icon = "x" })
			return
		end
		fn9(v7)
	end,
})

tbl11.fling:Button({
	Title = "Fling All",
	Desc = "Yeet everyone in the server, one after another. Press again to stop",
	Icon = "lucide:flame",
	Callback = function()
		tbl.flingAll()
	end,
})

fn50("Fling Murderer", Color3.fromHex("#FCA5A5"))
fn50("Fling Sheriff", Color3.fromHex("#93C5FD"))
fn50("Fling All", Color3.fromHex("#FDBA74"))

tbl.el.tpMurd = tbl11.fling:Button({
	Title = "Teleport to Murderer",
	Desc = "Instantly go to whoever has the knife",
	Icon = "lucide:crosshair",
	Callback = function()
		fn13(fn(), "Murderer")
	end,
})

tbl.el.tpSher = tbl11.fling:Button({
	Title = "Teleport to Sheriff",
	Desc = "Instantly go to whoever has the gun",
	Icon = "lucide:shield",
	Callback = function()
		fn13(fn2(), "Sheriff")
	end,
})

tbl11.fling:Section({ Title = "Target Player" })
local connection5

do
	local v7 = nil

	local function fn53()
		local tbl13 = {}

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				table.insert(tbl13, player.Name)
			end
		end

		return tbl13
	end

	local v8 = tbl11.fling:Dropdown({
		Title = "Target",
		Desc = "Pick a player for the buttons below",
		Multi = false,
		Value = nil,
		Values = fn53(),
		Callback = function(arg)
			v7 = arg
		end,
	})

	fn10 = function()
		return v7
	end

	local function fn54()
		pcall(function()
			v8:Refresh(fn53())
		end)

		pcall(function()
			killTargetDropdown:Refresh(fn53())
		end)
	end

	tbl.conns[#tbl.conns + 1] = Players.PlayerAdded:Connect(fn54)
	tbl.conns[#tbl.conns + 1] = Players.PlayerRemoving:Connect(fn54)

	local function fn55()
		if not v7 then
			v:Notify({ Title = "Error!", Content = "Pick a player first!", Duration = 1.5, Icon = "x" })
			return nil
		end
		local v9 = Players:FindFirstChild(v7)
		if not v9 then
			v:Notify({ Title = "Error!", Content = "Player left the game!", Duration = 1.5, Icon = "x" })
			return nil
		end

		if v9 == localPlayer then
			v:Notify({ Title = "Error!", Content = "You can't target yourself!", Duration = 1.5, Icon = "x" })
			return nil
		end
		return v9
	end

	tbl11.fling:Button({
		Title = "Fling Player",
		Desc = "Fling whoever you picked above",
		Icon = "lucide:zap",
		Color = Color3.fromHex("#d6d6d6"),
		Callback = function()
			local v9 = fn55()

			if v9 then
				fn9(v9)
			end
		end,
	})

	tbl11.fling:Button({
		Title = "Teleport",
		Desc = "Teleport to the selected player",
		Icon = "lucide:navigation",
		Color = Color3.fromHex("#d6d6d6"),
		Callback = function()
			local v9 = fn55()

			if v9 then
				fn13(v9, v9.Name)
			end
		end,
	})

	local v9 = nil

	v9 = tbl11.fling:Toggle({
		Title = "Spam Fling",
		Flag = "Toggle_Spam_Fling",
		Desc = "Keeps flinging the player picked above until you turn it off",
		Type = "Toggle",
		Value = false,
		Callback = function(arg)
			flag7 = arg

			if arg then
				if not v7 then
					v:Notify({
						Title = "Error!",
						Content = "Pick a player from the dropdown first!",
						Duration = 2,
						Icon = "x",
					})

					flag7 = false

					pcall(function()
						v9:Set(false)
					end)

					return
				end

				fn11()

				v:Notify({
					Title = "Spam Fling ON",
					Content = "Spam flinging " .. v7 .. "!",
					Duration = 2,
					Icon = "flame",
				})
			else
				fn12()

				v:Notify({
					Title = "Spam Fling OFF",
					Content = "Stopped spam flinging.",
					Duration = 2,
					Icon = "power-off",
				})
			end
		end,
	})

	tbl.GUN_ICON = "http://www.roblox.com/asset/?id=197518111"
	tbl.KNIFE_ICON = "rbxassetid://584555920"

	tbl.FLAG_ICON = {
		Toggle_Sound_Errors = "rbxassetid://83898160590116",
		Toggle_Sound_Button_Click = "rbxassetid://107150227368485",
		Toggle_Sound_Switches = "rbxassetid://85887872573050",
	}

	tbl.ROLE_ICON = {
		Toggle_Auto_Grab_Gun = "gun",
		Toggle_Silent_Aim = "gun",
		Toggle_Dropped_Gun_ESP = "gun",
		Toggle_Sound_Gun_Drop = "gun",
		Toggle_Silent_Throw = "knife",
		Toggle_Fling_Murderer_When_Done = "knife",
		Toggle_Kill_All_When_Bag_Full = "knife",
	}

	task.spawn(function()
		local tbl13 = {}

		for k, v10 in pairs(tbl.ROLE_ICON) do
			tbl13[k] = v10 == "gun" and tbl.GUN_ICON or tbl.KNIFE_ICON
		end

		for k, v10 in pairs(tbl.FLAG_ICON) do
			tbl13[k] = v10
		end

		local tbl14 = {}
		local n4 = os.clock() + 30

		while os.clock() < n4 do
			local elements = tbl.config and tbl.config.Elements

			if type(elements) ~= "table" then
				task.wait(0.5)
				continue
			else
				local flag16 = false

				for k, v10 in pairs(tbl13) do
					if not tbl14[k] then
						local v11 = elements[k]

						if v11 then
							pcall(function()
								v11:SetImage(v10, 28)
							end)

							tbl14[k] = true
						else
							flag16 = true
						end
					end
				end

				if flag16 then
					task.wait(0.5)
					continue
				end
			end

			break
		end

		for i = 1, 80 do
			if not (#tbl.gunEls > 0 and #tbl.knifeEls > 0 and tbl.el.flingSher and tbl.el.tpSher and tbl.el.flingMurd and tbl.el.tpMurd) then
				task.wait(0.25)
				continue
			end
			break
		end

		local tbl15 = {}

		for _, gunEl in ipairs(tbl.gunEls) do
			tbl15[#tbl15 + 1] = { gunEl, tbl.GUN_ICON }
		end

		for _, knifeEl in ipairs(tbl.knifeEls) do
			tbl15[#tbl15 + 1] = { knifeEl, tbl.KNIFE_ICON }
		end

		tbl15[#tbl15 + 1] = { tbl.el.flingSher, tbl.GUN_ICON }
		tbl15[#tbl15 + 1] = { tbl.el.tpSher, tbl.GUN_ICON }
		tbl15[#tbl15 + 1] = { tbl.el.flingMurd, tbl.KNIFE_ICON }
		tbl15[#tbl15 + 1] = { tbl.el.tpMurd, tbl.KNIFE_ICON }
		tbl.iconsApplied = 0

		for _, v10 in ipairs(tbl15) do
			if type(v10[1]) == "table" then
				if pcall(function()
					v10[1]:SetImage(v10[2], 28)
				end) then
					tbl.iconsApplied = tbl.iconsApplied + 1
				end
			end
		end

		for k in pairs(tbl14) do
			tbl.iconsApplied = tbl.iconsApplied + 1
		end
	end)

	fn52(ICON.mono)
	tbl11.farm:Section({ Title = "Coin Autofarm" })

	tbl11.farm:Toggle({
		Title = "Coin Autofarm",
		Flag = "Toggle_Coin_Autofarm",
		Desc = "Walks you around picking up coins.",
		Type = "Toggle",
		Value = false,
		Callback = function(arg)
			if arg then
				if flag9 then
					tbl.setToggle(tbl.el.fly, false, function()
						flag9 = false
						fn21()
					end)
				end

				fn27()
				tbl.startFarmHopWatch()
				v:Notify({ Title = "Autofarm Started!", Content = "Farming coins!", Duration = 2, Icon = "check" })
			else
				fn28()
				tbl.stopFarmHopWatch()
				v:Notify({ Title = "Autofarm Stopped!", Content = "Stopped farming.", Duration = 2, Icon = "power-off" })
			end
		end,
	})

	tbl11.farm:Slider({
		Title = "Farm Speed",
		Flag = "Slider_Farm_Speed",
		Desc = "Meters per second",
		Step = 1,
		Value = { Min = 5, Max = 25, Default = 25 },
		Callback = function(arg)
			n2 = arg >= 25 and 23 or arg
		end,
	})

	tbl11.farm:Section({ Title = "Settings" })

	tbl.perfFarmToggle = tbl11.farm:Toggle({
		Title = "Performance Mode",
		Flag = "Toggle_Farm_Perf_Master",
		Desc = "Strips textures, shadows, particles and effects for framerate. Same switch as the one on the Visuals tab.",
		Type = "Toggle",
		Value = false,
		Callback = function(arg)
			if tbl.perf then
				tbl.perf.setAll(arg)
			end
		end,
	})

	tbl.farmHopOn = true

	tbl11.farm:Toggle({
		Title = "Hop When Server Dies",
		Flag = "Toggle_Farm_Dead_Hop",
		Desc = "Hops to a fresh server when this one empties out mid-farm.",
		Type = "Toggle",
		Value = true,
		Callback = function(farmHopOn)
			tbl.farmHopOn = farmHopOn
		end,
	})

	tbl11.farm:Toggle({
		Title = "Anti-AFK",
		Flag = "Toggle_Anti_AFK",
		Desc = "Prevents you from getting AFK kicked.",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			flag13 = arg

			if arg then
				fn31()
				v:Notify({ Title = "Anti-AFK Enabled!", Content = "You can go AFK now!", Duration = 2, Icon = "shield" })
			else
				fn32()

				v:Notify({
					Title = "Anti-AFK Disabled!",
					Content = "AFK protection off.",
					Duration = 2,
					Icon = "power-off",
				})
			end
		end,
	})

	tbl11.farm:Toggle({
		Title = "Auto-Reset When Bag Full",
		Flag = "Toggle_Auto_Reset_When_Bag_Full",
		Desc = "Resets you once your coin bag is full",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			flag12 = arg

			if arg then
				fn29()
			else
				fn30()
			end
		end,
	})

	tbl11.farm:Toggle({
		Title = "Auto Claim Shells",
		Flag = "Toggle_Auto_Claim_Shells",
		Desc = "Claims the end-of-round reward popup for you",
		Type = "Toggle",
		Value = false,
		Callback = function(shellsOn)
			tbl.shellsOn = shellsOn

			if shellsOn then
				tbl.startShells()

				v:Notify({
					Title = "Auto Claim Shells On!",
					Content = "Rewards claim themselves.",
					Duration = 2,
					Icon = "check",
				})
			else
				tbl.stopShells()

				v:Notify({
					Title = "Auto Claim Shells Off!",
					Content = "Claim them yourself.",
					Duration = 2,
					Icon = "power-off",
				})
			end
		end,
	})

	tbl11.farm:Toggle({
		Title = "Fling Murderer When Done",
		Flag = "Toggle_Fling_Murderer_When_Done",
		Desc = "Yeets the murderer once your bag is full or the coins run out",
		Type = "Toggle",
		Value = false,
		Callback = function(flingWhenDone)
			tbl.flingWhenDone = flingWhenDone

			if flingWhenDone then
				tbl.flingDoneFired = false
			end
		end,
	})

	tbl11.farm:Toggle({
		Title = "Kill All When Bag Full",
		Flag = "Toggle_Kill_All_When_Bag_Full",
		Desc = "Stabs everyone once your bag fills up. Murderer only.",
		Type = "Toggle",
		Value = false,
		Callback = function(killWhenFull)
			tbl.killWhenFull = killWhenFull

			if killWhenFull then
				tbl.killFired = false
			end
		end,
	})

	flag13 = true
	fn31()
	flag12 = true
	fn29()
	tbl11.farm:Section({ Title = "Auto Open Boxes" })
	tbl.el.box = {}

	for _, boxe in ipairs(tbl.BOXES) do
		local v10 = boxe[1]
		local v11 = boxe[2]
		local v12, v13 = tbl.boxPrice(v10)

		tbl.el.box[v10] = tbl11.farm:Toggle({
			Title = "Auto Open " .. v11,
			Flag = "Toggle_Box_" .. v10:gsub("%W", "_"),
			Desc = "Waits until you get " .. (v13 and tbl.comma(v13) or "?") .. " " .. tbl.curName(v12) .. ", then auto-opens the box for you!",
			Type = "Toggle",
			Value = false,
			Callback = function(arg)
				tbl.boxOn[v10] = arg

				if arg then
					tbl.startBox(v10, v11)
				else
					tbl.stopBox(v10)
				end
			end,
		})

		local v14 = tbl.boxImage(v10)

		if v14 then
			pcall(function()
				tbl.el.box[v10]:SetImage(v14, 30)
			end)
		end

		if v10 == "Summer2026Box" then
			local elementFrame = tbl.el.box[v10] and tbl.el.box[v10].ElementFrame

			if typeof(elementFrame) == "Instance" then
				local uiGradient = elementFrame:FindFirstChildWhichIsA("UIGradient")

				if uiGradient then
					uiGradient:Destroy()
				end

				local uiGradient2 = Instance.new("UIGradient")
				uiGradient2.Color = ColorSequence.new(ICON.yellow, ICON.teal)
				uiGradient2.Parent = elementFrame
			end
		end
	end

	fn52(ICON.mono)

	tbl11.buttons:Toggle({
		Title = "Lock Buttons In Place",
		Flag = "Toggle_Lock_Buttons_In_Place",
		Desc = "Stops the on-screen buttons moving when you tap them.",
		Type = "Toggle",
		Value = false,
		Callback = function(locked)
			tbl2.locked = locked
		end,
	})

	tbl.el.designDrop = tbl11.buttons:Dropdown({
		Title = "Button Design",
		Flag = "Dropdown_Button_Design",
		Desc = "Round Design is a circle with a ring that fills as the cooldown runs. Default Design puts a gauge along the bottom.",
		Multi = false,
		Value = "Default Design",
		Values = tbl2.DESIGN_LIST,
		Callback = function(arg)
			tbl2.setDesign(tostring(type(arg) == "table" and (arg[1] or arg.Value) or arg))
		end,
	})

	tbl.el.sizeSlider = tbl11.buttons:Slider({
		Title = "Button Size",
		Flag = "Slider_Button_Size",
		Desc = "Scales the on-screen buttons. 100 is normal.",
		Step = 1,
		Value = { Min = 50, Max = 200, Default = IS_MOBILE and 70 or 100 },
		Callback = function(arg)
			local num = tonumber(arg)
			local num2

			if num then
				num2 = num
			else
				num2 = type(arg) == "table" and tonumber(arg.Value)
			end

			tbl.hudScale = (num2 or IS_MOBILE and 70 or 100) / 100

			for _, v10 in next, tbl2.parts, nil do
				if v10.scale then
					local tbl13 = { Scale = tbl.hudScale }
					TweenService:Create(v10.scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl13):Play()
				end
			end

			tbl2.relayout()
		end,
	})

	tbl11.buttons:Section({ Title = "On-Screen Buttons" })

	tbl11.buttons:Toggle({
		Title = "Shoot Murderer",
		Flag = "Toggle_Shoot_Murderer",
		Desc = "Draggable on-screen button that shoots the murderer",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("Shoot", "SHOOT\nMURDERER", tbl4.Shoot, HUDAccent.Shoot, HUDIcon.Shoot, fn35)
			else
				tbl2.destroy("Shoot")
			end
		end,
	})

	tbl11.buttons:Toggle({
		Title = "Grab Gun",
		Flag = "Toggle_Grab_Gun",
		Desc = "Grabs the gun off the floor. It only drops when the sheriff dies.",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("Grab", "GRAB\nGUN", tbl4.Grab, HUDAccent.Grab, HUDIcon.Grab, fn41)
			else
				tbl2.destroy("Grab")
			end
		end,
	})

	tbl11.buttons:Toggle({
		Title = "Throw Knife",
		Flag = "Toggle_Throw_Knife",
		Desc = "Throws your knife at the nearest player",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("Throw", "THROW\nKNIFE", tbl4.Throw, HUDAccent.Throw, HUDIcon.Throw, fn36)
			else
				tbl2.destroy("Throw")
			end
		end,
	})

	tbl11.buttons:Toggle({
		Title = "Bomb Jump",
		Flag = "Toggle_Bomb_Jump",
		Desc = "Bomb jump, with the cooldown shown on the button",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("Bomb", "BOMB\nJUMP", tbl4.Bomb, HUDAccent.Bomb, HUDIcon.Bomb, fn39)
			else
				tbl2.destroy("Bomb")
			end
		end,
	})

	tbl11.buttons:Toggle({
		Title = "Wall Hop",
		Flag = "Toggle_Wall_Hop",
		Desc = "Climbs the wall you are standing against.",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("WallHop", "WALL\nHOP", tbl4.WallHop, HUDAccent.WallHop, HUDIcon.WallHop, fn40)
			else
				tbl2.destroy("WallHop")
			end
		end,
	})

	tbl11.buttons:Toggle({
		Title = "Aimbot Button",
		Flag = "Toggle_Aimbot_Button",
		Desc = "Turns the aimbot on and off, and shows its state.",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				local Aimbot, v10 = tbl2.create("Aimbot", "AIMBOT\nOFF", tbl4.Aimbot, HUDAccent.Aimbot, HUDIcon.Aimbot, function()
					tbl5.set(not tbl5.enabled)
				end)

				tbl5.label = v10
				tbl5.refreshLabel()
			else
				tbl2.destroy("Aimbot")
				tbl5.label = nil
				tbl5.set(false)
			end
		end,
	})

	tbl.killSheriff = function()
		local v10 = fn2()

		if not v10 then
			v:Notify({
				Title = "No Sheriff",
				Content = "Nobody is holding the gun right now.",
				Duration = 2,
				Icon = "x",
			})

			return
		end

		fn44(v10.Name)
	end

	tbl11.buttons:Section({ Title = "Extra Buttons" })

	tbl11.buttons:Toggle({
		Title = "Kill All Button  (Murderer Only)",
		Flag = "Toggle_Kill_All_Button",
		Desc = "Stabs every player at once. Murderer only.",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("KillAll", "KILL ALL\nMURDER\nONLY", tbl4.KillAll, HUDAccent.KillAll, HUDIcon.KillAll, fn45)
			else
				tbl2.destroy("KillAll")
			end
		end,
	})

	tbl11.buttons:Toggle({
		Title = "Kill Sheriff Button  (Murderer Only)",
		Flag = "Toggle_Kill_Sheriff_Button",
		Desc = "Stabs whoever is holding the gun. Murderer only.",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("KillSheriff", "KILL\nSHERIFF", tbl4.KillSheriff, HUDAccent.KillSheriff, HUDIcon.KillSheriff, tbl.killSheriff)
			else
				tbl2.destroy("KillSheriff")
			end
		end,
	})

	tbl11.buttons:Toggle({
		Title = "Free X-Ray Button",
		Flag = "Toggle_Xray_Button",
		Desc = "Unlocks the X-Ray perk for free.",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("Xray", "FREE\nX-RAY", tbl4.Xray, HUDAccent.Xray, HUDIcon.Xray, function()
					tbl.setXray(not tbl.xrayOn)
					tbl2.setActive("Xray", tbl.xrayOn)
				end)

				tbl2.setActive("Xray", tbl.xrayOn)
			else
				tbl2.destroy("Xray")
			end
		end,
	})

	tbl11.buttons:Toggle({
		Title = "Fly Button",
		Flag = "Toggle_Fly_Button",
		Desc = "On-screen button that turns Fly on and off. Same fly as the Player tab.",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("Fly", "FLY", tbl4.Fly, HUDAccent.Fly, HUDIcon.Fly, function()
					flag9 = not flag9

					if flag9 then
						fn20()
					else
						fn21()
					end

					tbl2.setActive("Fly", flag9)
					tbl.setToggle(tbl.el.fly, flag9)
				end)

				tbl2.setActive("Fly", flag9)
			else
				tbl2.destroy("Fly")
			end
		end,
	})

	tbl11.buttons:Toggle({
		Title = "Noclip Button",
		Flag = "Toggle_Noclip_Button",
		Desc = "Turns Noclip on and off - walk through walls.",
		Type = "Toggle",
		Value = true,
		Callback = function(arg)
			if arg then
				tbl2.create("Noclip", "NOCLIP", tbl4.Noclip, HUDAccent.Noclip, HUDIcon.Noclip, function()
					flag8 = not flag8

					if flag8 then
						fn18()
					else
						fn19()
					end

					tbl2.setActive("Noclip", flag8)
					tbl.setToggle(tbl.el.noclip, flag8)
				end)

				tbl2.setActive("Noclip", flag8)
			else
				tbl2.destroy("Noclip")
			end
		end,
	})

	tbl.BTN_GLYPH = {
		Toggle_Shoot_Murderer = "Shoot",
		Toggle_Grab_Gun = "Grab",
		Toggle_Throw_Knife = "Throw",
		Toggle_Bomb_Jump = "Bomb",
		Toggle_Wall_Hop = "WallHop",
		Toggle_Aimbot_Button = "Aimbot",
		Toggle_Kill_All_Button = "KillAll",
		Toggle_Kill_Sheriff_Button = "KillSheriff",
		Toggle_Xray_Button = "Xray",
		Toggle_Fly_Button = "Fly",
		Toggle_Noclip_Button = "Noclip",
	}

	task.spawn(function()
		for i = 1, 40 do
			if not (tbl.config and type(tbl.config.Elements) == "table") then
				task.wait(0.25)
				continue
			end
			break
		end

		local elements = tbl.config and tbl.config.Elements
		if type(elements) ~= "table" then
			return
		end

		for k, v10 in pairs(tbl.BTN_GLYPH) do
			local v11 = elements[k]
			local v12 = HUDIcon[v10]
			local v13 = v12 and ICONS[v12] or nil

			if v11 and v13 then
				pcall(function()
					v11:SetImage(v13, 28)
				end)
			end
		end
	end)

	tbl2.create("Shoot", "SHOOT\nMURDERER", tbl4.Shoot, HUDAccent.Shoot, HUDIcon.Shoot, fn35)
	tbl2.create("Grab", "GRAB\nGUN", tbl4.Grab, HUDAccent.Grab, HUDIcon.Grab, fn41)
	tbl2.create("Throw", "THROW\nKNIFE", tbl4.Throw, HUDAccent.Throw, HUDIcon.Throw, fn36)

	local Aimbot, v10 = tbl2.create("Aimbot", "AIMBOT\nOFF", tbl4.Aimbot, HUDAccent.Aimbot, HUDIcon.Aimbot, function()
		tbl5.set(not tbl5.enabled)
	end)

	tbl5.label = v10
	tbl5.refreshLabel()
	tbl2.create("Bomb", "BOMB\nJUMP", tbl4.Bomb, HUDAccent.Bomb, HUDIcon.Bomb, fn39)
	tbl2.create("WallHop", "WALL\nHOP", tbl4.WallHop, HUDAccent.WallHop, HUDIcon.WallHop, fn40)
	tbl2.create("KillAll", "KILL ALL\nMURDER\nONLY", tbl4.KillAll, HUDAccent.KillAll, HUDIcon.KillAll, fn45)
	tbl2.create("KillSheriff", "KILL\nSHERIFF", tbl4.KillSheriff, HUDAccent.KillSheriff, HUDIcon.KillSheriff, tbl.killSheriff)

	tbl2.create("Xray", "FREE\nX-RAY", tbl4.Xray, HUDAccent.Xray, HUDIcon.Xray, function()
		tbl.setXray(not tbl.xrayOn)
		tbl2.setActive("Xray", tbl.xrayOn)
	end)

	tbl2.create("Fly", "FLY", tbl4.Fly, HUDAccent.Fly, HUDIcon.Fly, function()
		flag9 = not flag9

		if flag9 then
			fn20()
		else
			fn21()
		end

		tbl2.setActive("Fly", flag9)
		tbl.setToggle(tbl.el.fly, flag9)
	end)

	tbl2.create("Noclip", "NOCLIP", tbl4.Noclip, HUDAccent.Noclip, HUDIcon.Noclip, function()
		flag8 = not flag8

		if flag8 then
			fn18()
		else
			fn19()
		end

		tbl2.setActive("Noclip", flag8)
		tbl.setToggle(tbl.el.noclip, flag8)
	end)

	tbl2.relayout()

	task.spawn(function()
		RunService.RenderStepped:Wait()

		pcall(function()
			local main = v2.UIElements.Main
			local v11

			for k in next, tbl2.guis, nil do
				local textButton = CoreGui:FindFirstChild("Onyx" .. k .. "Button")
				textButton = textButton and textButton:FindFirstChildWhichIsA("TextButton")

				if textButton then
					local n4 = textButton.AbsolutePosition.Y + textButton.AbsoluteSize.Y

					if not v11 or n4 > v11 then
						v11 = n4
					end
				end
			end

			if not v11 then
				return
			end
			local viewportSize = Workspace.CurrentCamera.ViewportSize
			local n4 = math.min(560, viewportSize.Y - 40)
			local n5 = main.AbsolutePosition.Y + main.AbsoluteSize.Y / 2
			local n6 = math.min(v11 + 12 + n4 / 2, viewportSize.Y - n4 / 2 - 8) - n5

			if n6 > 0 then
				local position = main.Position
				main.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset + n6)
			end
		end)
	end)

	local function fn56()
		local v11 = BOMB_COOLDOWN
		if tick() - n3 < v11 then
			return
		end
		n3 = tick()

		if tbl2 then
			tbl2.startCooldown("Bomb", BOMB_COOLDOWN, "BOMB\nJUMP")
		end
	end

	local function fn57()
		for _, v11 in ipairs(tbl3) do
			pcall(function()
				v11:Disconnect()
			end)
		end

		tbl3 = {}

		local function fn58(arg)
			if not arg then
				return
			end
			local fakeBomb = arg:FindFirstChild("FakeBomb")

			if fakeBomb and fakeBomb:IsA("Tool") then
				table.insert(tbl3, fakeBomb.Activated:Connect(fn56))
			end

			table.insert(tbl3, arg.ChildAdded:Connect(function(child)
				if child.Name == "FakeBomb" and child:IsA("Tool") then
					table.insert(tbl3, child.Activated:Connect(fn56))
				end
			end))
		end

		fn58(localPlayer:FindFirstChild("Backpack"))
		fn58(localPlayer.Character)
	end

	fn57()

	connection5 = localPlayer.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid")
		task.wait(0.5)
		fn57()
	end)

	fn52(ICON.mono)

	local function fn58()
		local Players_ = game:GetService("Players")
		local ReplicatedStorage_ = game:GetService("ReplicatedStorage")
		game:GetService("InsertService")
		local localPlayer2 = Players_.LocalPlayer

		pcall(function()
			if setthreadidentity then
				setthreadidentity(2)
			end
		end)

		if _G.__MM2Viz and _G.__MM2Viz.destroy then
			pcall(_G.__MM2Viz.destroy)
		end

		local mM2Viz = { conns = {} }
		_G.__MM2Viz = mM2Viz
		local EquipService = require(ReplicatedStorage_:WaitForChild("ClientServices"):WaitForChild("EquipService"))
		local Sync = require(ReplicatedStorage_:WaitForChild("Database"):WaitForChild("Sync"))
		local ProfileData = require(ReplicatedStorage_:WaitForChild("Modules"):WaitForChild("ProfileData"))
		local weapons = Sync.Weapons
		local inventoryDataChanged = ReplicatedStorage_:WaitForChild("Remotes"):WaitForChild("Inventory"):WaitForChild("InventoryDataChanged")

		local function fn59(arg)
			local ok, result = pcall(function()
				return game:HttpGet(arg, true)
			end)

			if ok and type(result) == "string" and #result > 0 then
				return result
			end
			local request_ = syn and syn.request or request or http_request or http and http.request
			if not request_ then
				return nil, tostring(result)
			end
			local ok2, result2 = pcall(request_, { Url = arg, Method = "GET" })
			if ok2 and type(result2) == "table" and type(result2.Body) == "string" and #result2.Body > 0 then
				return result2.Body
			end
			return nil, tostring(ok2 and result2 and result2.StatusCode or result2)
		end

		local lua = nil

		if isfile and readfile and isfile("OnyxV2/weapon.lua") then
			local ok, result = pcall(readfile, "OnyxV2/weapon.lua")

			if ok and type(result) == "string" and #result > 100000 then
				lua = result
			end
		end

		local flag16 = lua ~= nil
		local v11 = nil

		if not lua then
			lua, v11 = fn59("https://raw.githubusercontent.com/kroxn/visual/refs/heads/main/weapon.lua")
		end

		if not lua then
			error("[MM2Viz] could not fetch mesh data from " .. "https://raw.githubusercontent.com/kroxn/visual/refs/heads/main/weapon.lua" .. " -- " .. tostring(v11), 0)
		end

		local chunk, v12 = loadstring(lua .. "\nreturn MESHES_FULL")

		if not chunk and flag16 then
			lua = fn59("https://raw.githubusercontent.com/kroxn/visual/refs/heads/main/weapon.lua")
			chunk = lua and loadstring(lua .. "\nreturn MESHES_FULL")
			flag16 = false
			v12 = nil
		end

		if not chunk then
			error("[MM2Viz] mesh data failed to compile -- " .. tostring(v12), 0)
		end

		if not flag16 and writefile then
			pcall(function()
				if makefolder and isfolder and not isfolder("OnyxV2") then
					makefolder("OnyxV2")
				end

				writefile("OnyxV2/weapon.lua", lua)
			end)
		end

		local v13 = chunk()

		if type(v13) ~= "table" or next(v13) == nil then
			error("[MM2Viz] fetched file produced no MESHES_FULL table (is the URL the data file?)", 0)
		end

		local tbl13 = {}

		for k, v14 in pairs(v13) do
			tbl13[k] = v14
		end

		local sweetChroma = tbl13.SweetChroma

		if sweetChroma and sweetChroma.Model and not tbl13.Sweet then
			local fn60 = nil

			fn60 = function(arg)
				local tbl14 = { Class = arg.Class, Id = arg.Id, Name = arg.Name, Props = arg.Props, Tags = arg.Tags }

				if arg.Children then
					tbl14.Children = {}

					for _, child in ipairs(arg.Children) do
						if not (child.Class == "Decal" and child.Name == "Chroma") then
							tbl14.Children[#tbl14.Children + 1] = fn60(child)
						end
					end
				end

				return tbl14
			end

			local tbl14 = {}
			local v14 = pairs
			local meta = sweetChroma.Meta or {}

			for k, v15 in v14(meta) do
				tbl14[k] = v15
			end

			tbl14.Chroma = nil
			tbl13.Sweet = { Complete = false, Meta = tbl14, Model = fn60(sweetChroma.Model) }
		end

		local tbl14 = { Godly = true, Ancient = true }

		local function fn60(arg)
			local str = tostring(arg or "")
			return str == "" or str:match("^%?+$") ~= nil
		end

		local tbl15 = {}
		local n4 = 0

		for k, v14 in pairs(tbl13) do
			local v15 = weapons[k]

			if type(v15) == "table" and (v15.ItemType == "Knife" or v15.ItemType == "Gun") and tbl14[v15.Rarity] and not fn60(v15.ItemName) then
				tbl15[k] = v14
			else
				n4 += 1
			end
		end

		local v14 = tbl15
		local n5 = 0
		local n6 = 0

		for _, v15 in pairs(v14) do
			n5 += 1

			if v15.Model then
				n6 += 1
			end
		end

		local RunService_ = game:GetService("RunService")
		local CollectionService_ = game:GetService("CollectionService")

		local function fn61(arg)
			if type(arg) == "string" then
				return (arg:gsub("^%s+", ""):gsub("%s+$", ""))
			end
			return arg
		end

		local function fn62(arg, arg2, arg3)
			for k, v15 in pairs(arg2) do
				if not (arg3 and arg3[k]) then
					if k == "MeshId" or k == "TextureId" or k == "TextureID" or k == "Texture" then
						v15 = fn61(v15)
					end

					pcall(function()
						arg[k] = v15
					end)
				end
			end
		end

		local function createPart(arg)
			local v15 = fn61(arg.MeshId or "")
			local size = arg.Size or Vector3.one
			local v16 = nil

			pcall(function()
				v16 = game:GetService("InsertService"):CreateMeshPartAsync(v15, Enum.CollisionFidelity.Box, Enum.RenderFidelity.Precise)
			end)

			if v16 then
				pcall(function()
					v16.Size = size
				end)

				return v16
			end

			local part = Instance.new("Part")
			part.Size = size
			local specialMesh = Instance.new("SpecialMesh")
			specialMesh.MeshType = Enum.MeshType.FileMesh

			pcall(function()
				specialMesh.MeshId = v15
			end)

			pcall(function()
				specialMesh.TextureId = fn61(arg.TextureID or "")
			end)

			specialMesh.Parent = part
			return part
		end

		local tbl16 = {}
		local color2 = Color3.fromRGB(255, 0, 0)
		local color3 = Color3.fromRGB(255, 255, 0)
		local color4 = Color3.fromRGB(0, 255, 0)
		local color5 = Color3.fromRGB(0, 255, 255)
		local color6 = Color3.fromRGB(0, 0, 255)
		local color7 = Color3.fromRGB
		tbl16[1] = color2
		tbl16[2] = color3
		tbl16[3] = color4
		tbl16[4] = color5
		tbl16[5] = color6

		do
			local values = table.pack(color7(255, 0, 255))
			table.move(values, 1, values.n, 6, tbl16)
		end

		local function fn63(arg)
			local n7 = #tbl16
			local n8 = arg % n7
			local n9 = math.floor(n8)
			return tbl16[n9 + 1]:Lerp(tbl16[(n9 + 1) % n7 + 1], n8 - n9)
		end

		local function fn64(arg, arg2)
			if arg2.Meta and arg2.Meta.Chroma == true then
				return true
			end
			return arg:sub(-6) == "Chroma"
		end

		local n7 = 1.8
		local texture = "rbxassetid://18363392181"

		local function fn65(arg)
			local tbl17 = {}
			local tbl18 = {}
			local tbl19 = {}
			local tbl20 = {}
			local flag17 = false

			for _, descendant in ipairs(arg:GetDescendants()) do
				local attribute = descendant:GetAttribute("MM2Chroma")

				if attribute then
					if attribute == "part" then
						tbl17[#tbl17 + 1] = descendant
						flag17 = true
					elseif attribute == "decal" and descendant:IsA("Decal") then
						pcall(function()
							descendant.Texture = texture
						end)

						tbl18[#tbl18 + 1] = descendant
						flag17 = true
					else
						flag17 = true

						if attribute == "fire" then
							tbl19[#tbl19 + 1] = descendant
						end
					end
				end
			end

			if not flag17 then
				for _, descendant in ipairs(arg:GetDescendants()) do
					if descendant:IsA("BasePart") and (descendant.Material == Enum.Material.Neon or descendant.Name:lower():find("light")) then
						tbl17[#tbl17 + 1] = descendant
					elseif descendant:IsA("Decal") and descendant.Name:lower():find("chroma") then
						tbl18[#tbl18 + 1] = descendant
					elseif descendant:IsA("Fire") then
						tbl19[#tbl19 + 1] = descendant
					end
				end

				if #tbl18 == 0 then
					tbl19[#tbl19 + 1] = arg
				end
			end

			local tbl21 = {}

			for _, v15 in ipairs(tbl19) do
				if v15:IsA("BasePart") then
					tbl21[v15] = true
				end
			end

			for _, v15 in ipairs(tbl17) do
				tbl21[v15] = nil
			end

			for _, descendant in ipairs(arg:GetDescendants()) do
				if descendant:IsA("SpecialMesh") and descendant.TextureId ~= "" and tbl21[descendant.Parent] then
					tbl20[#tbl20 + 1] = descendant
				end
			end

			if arg:IsA("Part") and tbl21[arg] then
				local specialMesh = arg:FindFirstChildWhichIsA("SpecialMesh")

				if specialMesh and specialMesh.TextureId ~= "" then
					tbl20[#tbl20 + 1] = specialMesh
				end
			end

			if #tbl17 == 0 and #tbl18 == 0 and #tbl19 == 0 and #tbl20 == 0 then
				return nil
			end

			return RunService_.Heartbeat:Connect(function()
				local now = os.clock()
				local v15 = fn63(now)

				for _, v16 in ipairs(tbl18) do
					v16.Color3 = v15
				end

				for _, v16 in ipairs(tbl20) do
					v16.VertexColor = Vector3.new(v15.R, v15.G, v15.B)
				end

				for _, v16 in ipairs(tbl19) do
					if v16:IsA("Fire") then
						v16.Color = v15
					elseif v16:IsA("BasePart") then
						v16.Color = v15
					end
				end

				local n8 = math.floor(now * n7)

				for i, v16 in ipairs(tbl17) do
					v16.Color = tbl16[(n8 + i - 1) % #tbl16 + 1]
				end
			end)
		end

		local tbl17 = {
			WeldConstraint = true,
			Weld = true,
			Motor6D = true,
			RigidConstraint = true,
			Bone = true,
			Snap = true,
			ManualWeld = true,
			Rotate = true,
			RotateP = true,
			RotateV = true,
		}

		local function fn66(arg, arg2)
			if not (arg and arg2.Tags) then
				return
			end

			for _, tag in ipairs(arg2.Tags) do
				local str = tag == "ChromaPart" and "part" or tag == "ChromaDecal" and "decal"
				local str2

				if str then
					str2 = str
				else
					str2 = tag == "ChromaFire" and "fire"
				end

				str2 = str2 or nil

				if str2 then
					pcall(function()
						arg:SetAttribute("MM2Chroma", str2)
					end)
				end
			end
		end

		local function fn67(arg)
			local class = arg.Class
			if tbl17[class] then
				return nil
			end
			local v15

			if class == "MeshPart" then
				v15 = createPart(arg.Props)
				fn62(v15, arg.Props, { MeshId = true, Size = true, RelCF = true, CanCollide = true })
			else
				local ok, result = pcall(Instance.new, class)
				if not ok or not result then
					return nil
				end
				v15 = result
				fn62(v15, arg.Props, { RelCF = true })
			end

			if arg.Name then
				pcall(function()
					v15.Name = arg.Name
				end)
			end

			fn66(v15, arg)
			return v15
		end

		local fn68 = nil

		fn68 = function(arg, parent, parent2, arg2, arg3, arg4)
			local v15 = ipairs
			local children = arg.Children or {}

			for _, child in v15(children) do
				local v16 = fn67(child)

				if v16 then
					arg2[child.Id] = v16

					if v16:IsA("BasePart") then
						v16.Anchored = false
						v16.CanCollide = false
						v16.CanQuery = false
						v16.CanTouch = false
						v16.Massless = true
						arg3[#arg3 + 1] = { inst = v16, relcf = child.Props.RelCF }
						v16.Parent = parent2
						fn68(child, v16, parent2, arg2, arg3, arg4)
					elseif v16:IsA("Attachment") then
						if child.Props.RelCF then
							pcall(function()
								v16.CFrame = child.Props.RelCF
							end)
						end

						v16.Parent = parent2
						fn68(child, v16, parent2, arg2, arg3, arg4)
					elseif v16:IsA("Beam") or v16:IsA("Trail") then
						v16.Parent = parent
						arg4[#arg4 + 1] = { inst = v16, a0 = child.Att0, a1 = child.Att1 }
						fn68(child, v16, parent2, arg2, arg3, arg4)
					else
						v16.Parent = parent
						fn68(child, v16, parent2, arg2, arg3, arg4)
					end
				else
					fn68(child, parent, parent2, arg2, arg3, arg4)
				end
			end
		end

		local function fn69(arg)
			local model = arg.Model
			if not model then
				return nil
			end
			local part

			if model.Class == "MeshPart" then
				part = createPart(model.Props)
				fn62(part, model.Props, { MeshId = true, Size = true, RelCF = true, CanCollide = true })
			else
				part = Instance.new("Part")
				fn62(part, model.Props, { RelCF = true, CanCollide = true })
			end

			if model.Name then
				pcall(function()
					part.Name = model.Name
				end)
			end

			fn66(part, model)
			part.Anchored = false
			part.CanCollide = false
			part.CanQuery = false
			part.CanTouch = false
			part.Massless = true
			local tbl18 = { [model.Id] = part }
			local tbl19 = {}
			local tbl20 = {}
			fn68(model, part, part, tbl18, tbl19, tbl20)

			for _, v15 in ipairs(tbl20) do
				if v15.a0 and tbl18[v15.a0] then
					pcall(function()
						v15.inst.Attachment0 = tbl18[v15.a0]
					end)
				end

				if v15.a1 and tbl18[v15.a1] then
					pcall(function()
						v15.inst.Attachment1 = tbl18[v15.a1]
					end)
				end
			end

			return { root = part, parts = tbl19 }
		end

		local function fn70(arg, cFrame)
			local root = arg.root

			pcall(function()
				root.CFrame = cFrame
			end)

			for _, part in ipairs(arg.parts) do
				if part.relcf then
					pcall(function()
						part.inst.CFrame = cFrame * part.relcf
					end)
				end

				local weldConstraint = Instance.new("WeldConstraint")
				weldConstraint.Part0 = part.inst
				weldConstraint.Part1 = root
				weldConstraint.Parent = part.inst
			end

			return root
		end

		local tbl18 = {
			ParticleEmitter = true,
			Fire = true,
			Smoke = true,
			Sparkles = true,
			PointLight = true,
			SpotLight = true,
			SurfaceLight = true,
		}

		local function fn71(arg)
			local v15 = nil
			local tbl19 = {}
			local tbl20 = {}
			local tbl21 = {}
			local v16 = ipairs
			local display = arg.Display or {}

			for _, v17 in v16(display) do
				if v17.Path == "(root)" then
					v15 = v17
				elseif v17.Class == "SpecialMesh" then
					tbl19[#tbl19 + 1] = v17
				elseif v17.Class == "Decal" or v17.Class == "Texture" then
					tbl20[#tbl20 + 1] = v17
				elseif tbl18[v17.Class] then
					tbl21[#tbl21 + 1] = v17
				end
			end

			if not v15 then
				return nil
			end
			local part

			if v15.Class == "MeshPart" then
				part = createPart(v15.Props)
				fn62(part, v15.Props, { MeshId = true, Size = true, CanCollide = true })
			else
				part = Instance.new("Part")
				part.Size = v15.Props.Size or Vector3.one
				fn62(part, v15.Props, { Size = true, CanCollide = true })

				for _, v17 in ipairs(tbl19) do
					local specialMesh = Instance.new("SpecialMesh")
					specialMesh.MeshType = Enum.MeshType.FileMesh
					fn62(specialMesh, v17.Props)
					specialMesh.Parent = part
				end
			end

			part.Anchored = false
			part.CanCollide = false
			part.CanQuery = false
			part.CanTouch = false
			part.Massless = true

			if v15.Name then
				pcall(function()
					part.Name = v15.Name
				end)
			end

			for _, v17 in ipairs(tbl20) do
				local decal = Instance.new("Decal")
				fn62(decal, v17.Props)

				if v17.Name then
					pcall(function()
						decal.Name = v17.Name
					end)
				end

				decal.Parent = part
			end

			for _, v17 in ipairs(tbl21) do
				local ok, result = pcall(Instance.new, v17.Class)

				if ok and result then
					fn62(result, v17.Props)

					if v17.Name then
						pcall(function()
							result.Name = v17.Name
						end)
					end

					result.Parent = part
				end
			end

			return { root = part, parts = {} }
		end

		local function fn72(arg)
			if arg.Model then
				return fn69(arg)
			end

			if arg.Display then
				return fn71(arg)
			end
			return nil
		end

		local function fn73(arg)
			if arg.Model then
				local model = arg.Model
				if model.Class == "MeshPart" then
					return fn61(model.Props.MeshId or "")
				end
				local v15 = ipairs
				local children = model.Children or {}

				for _, child in v15(children) do
					if child.Class == "SpecialMesh" then
						return fn61(child.Props.MeshId or "")
					end
				end

				return ""
			end

			local v15 = ipairs
			local display = arg.Display or {}

			for _, v16 in v15(display) do
				if v16.Path == "(root)" and v16.Class == "MeshPart" then
					return fn61(v16.Props.MeshId or "")
				end

				if v16.Class == "SpecialMesh" then
					return fn61(v16.Props.MeshId or "")
				end
			end

			return ""
		end

		local function fn74(arg)
			if not arg then
				return ""
			end

			if arg:IsA("MeshPart") then
				return fn61(arg.MeshId or "")
			end
			local specialMesh = arg:FindFirstChildWhichIsA("SpecialMesh", true)

			if specialMesh then
				specialMesh = fn61(specialMesh.MeshId or "")
			end

			return specialMesh or ""
		end

		local cframe = CFrame.identity
		local fn75 = nil

		fn75 = function(arg)
			local v15 = ipairs
			local children = arg.Children or {}

			for _, child in v15(children) do
				if child.Class == "Attachment" and child.Name == "CustomAttachment" and child.Props and child.Props.RelCF then
					return child.Props.RelCF
				end
				local v16 = fn75(child)
				if v16 then
					return v16
				end
			end

			return nil
		end

		local function fn76(arg)
			if arg.Model then
				return arg.Model.Props and arg.Model.Props.Size
			end
			local v15 = ipairs
			local display = arg.Display or {}

			for _, v16 in v15(display) do
				if v16.Path == "(root)" then
					return v16.Props and v16.Props.Size
				end
			end

			return nil
		end

		local function fn77(arg)
			if not arg then
				return nil
			end
			local tbl19 = { { arg.X, "X" }, { arg.Y, "Y" }, { arg.Z, "Z" } }

			table.sort(tbl19, function(arg2, arg3)
				return arg2[1] > arg3[1]
			end)

			return tbl19[1][2] .. tbl19[2][2] .. tbl19[3][2]
		end

		local tbl19 = {
			Gun_ZYX = CFrame.new(0.12991, -3e-05, 0.075, 1, 0, 0, 0, 0.70713, 0.70708, 0, -0.70708, 0.70713),
			Gun_ZXY = CFrame.new(0.12991, 0, 0.07501, 2e-05, -0.5, -0.86603, 1, -4e-05, 5e-05, -6e-05, -0.86603, 0.5),
			Gun_XYZ = CFrame.new(-0.22989, 0.09821, 0.1, 1e-05, 0.98481, -0.17362, -1e-05, 0.17362, 0.98481, 1, -1e-05, 1e-05),
			Knife_YXZ = CFrame.new(0, 0, 0, -0.0446, -0.00031, -0.99901, 0.03549, 0.99937, -0.00189, 0.99837, -0.03553, -0.04456),
			Knife_ZYX = CFrame.new(0.00151, -0.12701, -0.15448, -0.99867, 0.03727, 0.03568, -0.04098, -0.15276, -0.98741, -0.03135, -0.98756, 0.15409),
			Knife_ZXY = CFrame.new(0.00151, -0.12701, -0.15448, -0.99867, 0.03727, 0.03568, -0.04098, -0.15276, -0.98741, -0.03135, -0.98756, 0.15409),
		}

		local mM2VizLearned = _G.__MM2VizLearned or {}
		_G.__MM2VizLearned = mM2VizLearned
		local mM2VizOverride = _G.__MM2VizOverride or {}
		_G.__MM2VizOverride = mM2VizOverride
		local mM2VizOverrideGrip = _G.__MM2VizOverrideGrip or {}
		_G.__MM2VizOverrideGrip = mM2VizOverrideGrip

		local function fn78(arg)
			if not arg then
				return nil
			end
			return arg:FindFirstChild("CustomAttachment") or arg:FindFirstChildWhichIsA("Attachment")
		end

		local function fn79(arg)
			local v15 = fn74(arg)
			local v16 = fn78(arg)

			if v15 ~= "" and v16 then
				mM2VizLearned[v15] = v16.CFrame
			end
		end

		local function fn80(arg, arg2, arg3)
			if mM2VizOverride[arg] then
				return mM2VizOverride[arg]
			end

			if arg2.Model then
				return fn75(arg2.Model) or cframe
			end
			local v15 = fn73(arg2)
			if v15 ~= "" and mM2VizLearned[v15] then
				return mM2VizLearned[v15]
			end
			local v16 = fn77(fn76(arg2))
			return v16 and tbl19[(arg2.Meta and arg2.Meta.ItemType or arg3) .. "_" .. v16] or cframe
		end

		local function fn81(arg, arg2)
			local v15 = fn78(arg)
			return arg.CFrame * (v15 and v15.CFrame or cframe) * arg2:Inverse()
		end

		local function fn82(arg, arg2)
			if arg2:IsA("BasePart") or arg2:IsA("Decal") then
				arg[#arg + 1] = { inst = arg2, prop = "Transparency", val = arg2.Transparency }

				pcall(function()
					arg2.Transparency = 1
				end)
			elseif arg2:IsA("ParticleEmitter") or arg2:IsA("Trail") or arg2:IsA("Beam") or arg2:IsA("Fire") or arg2:IsA("Smoke") or arg2:IsA("Sparkles") then
				arg[#arg + 1] = { inst = arg2, prop = "Enabled", val = arg2.Enabled }

				pcall(function()
					arg2.Enabled = false
				end)
			end
		end

		local function fn83(arg)
			for _, v15 in ipairs(arg) do
				pcall(function()
					v15.inst[v15.prop] = v15.val
				end)
			end
		end

		local function fn84(arg)
			local tbl20 = {}

			for _, v15 in ipairs(arg) do
				local inst = v15.inst
				local prop = v15.prop

				tbl20[#tbl20 + 1] = inst:GetPropertyChangedSignal(prop):Connect(function()
					if prop == "Enabled" then
						if inst.Enabled then
							inst.Enabled = false
						end
					elseif inst.Transparency ~= 1 then
						inst.Transparency = 1
					end
				end)
			end

			return tbl20
		end

		local function fn85(arg)
			local v15 = ipairs
			local tbl20 = arg or {}

			for _, v16 in v15(tbl20) do
				pcall(function()
					v16:Disconnect()
				end)
			end
		end

		local function fn86()
			return localPlayer2.Character
		end

		local function fn87(arg)
			local v15 = fn86()
			if not v15 then
				return nil
			end
			local v16 = v15:FindFirstChild("DisplayRef" .. arg)
			return v16 and v16.Value or nil
		end

		local function fn88(arg, arg2)
			local n8 = os.clock() + (arg2 or 1)

			while os.clock() < n8 do
				local v15 = fn87(arg)
				if v15 then
					return v15
				end
				task.wait(0.05)
			end

			return fn87(arg)
		end

		local tbl20 = {}
		local tbl21 = {}
		local tbl22 = {}
		local fn89 = nil

		local function fn90(arg, arg2)
			local weaponDisplays = workspace:FindFirstChild("WeaponDisplays")
			if not weaponDisplays then
				return
			end

			for _, child in ipairs(weaponDisplays:GetChildren()) do
				if child ~= arg2 and child:GetAttribute("MM2VizSlot") == arg then
					pcall(function()
						child:Destroy()
					end)
				end
			end
		end

		local function fn91(arg)
			fn90(arg)
			local v15 = tbl20[arg]
			if not v15 then
				return
			end

			if v15.chroma then
				pcall(function()
					v15.chroma:Disconnect()
				end)
			end

			if v15.overlay then
				pcall(function()
					v15.overlay:Destroy()
				end)
			end

			fn83(v15.hidden)
			tbl20[arg] = nil
		end

		local function fn92(arg, arg2)
			if tbl20[arg] and tbl21[arg] == arg2 and arg2 ~= nil then
				return
			end
			tbl22[arg] = (tbl22[arg] or 0) + 1
			local v15 = tbl22[arg]
			fn91(arg)
			local v16 = arg2 and v14[arg2]
			if not v16 then
				tbl21[arg] = arg2
				return
			end
			tbl21[arg] = arg2
			local v17 = fn87(arg) or fn88(arg, 1.5)
			if tbl22[arg] ~= v15 then
				return
			end

			if not v17 then
				if fn89 then
					fn89("No " .. arg .. " shown — equip a normal " .. arg .. " first.", Color3.fromRGB(240, 200, 120))
				end

				return
			end

			fn79(v17)
			if fn74(v17) == fn73(v16) and fn74(v17) ~= "" then
				return
			end
			local v18 = fn80(arg2, v16, arg)
			local tbl23 = {}
			fn82(tbl23, v17)

			for _, descendant in ipairs(v17:GetDescendants()) do
				fn82(tbl23, descendant)
			end

			local v19 = fn72(v16)

			if not v19 or not v19.root or tbl22[arg] ~= v15 or not v17.Parent then
				fn83(tbl23)

				if v19 and v19.root then
					v19.root:Destroy()
				end

				return
			end

			fn70(v19, fn81(v17, v18))
			local root = v19.root
			root:SetAttribute("MM2VizOverlay", true)
			root:SetAttribute("MM2VizSlot", arg)
			root.Parent = v17.Parent or v17
			local weldConstraint = Instance.new("WeldConstraint")
			weldConstraint.Part0 = root
			weldConstraint.Part1 = v17
			weldConstraint.Parent = root
			local v20 = fn64(arg2, v16) and fn65(root) or nil
			fn90(arg, root)
			tbl20[arg] = { overlay = root, hidden = tbl23, chroma = v20 }

			if fn89 then
				fn89("Showing: " .. arg2 .. " (" .. arg .. ")", Color3.fromRGB(150, 230, 170))
			end
		end

		local tbl23 = { X = Vector3.new(1, 0, 0), Y = Vector3.new(0, 1, 0), Z = Vector3.new(0, 0, 1) }

		local function fn93(arg)
			local tbl24 = { { arg.X, "X" }, { arg.Y, "Y" }, { arg.Z, "Z" } }

			table.sort(tbl24, function(arg2, arg3)
				return arg2[1] > arg3[1]
			end)

			return tbl24[1][2], tbl24[2][2], tbl24[3][2]
		end

		local tbl24 = {
			Gun = { Vector3.new(0, 0, 1), Vector3.new(0, 1, 0), Vector3.new(-1, 0, 0) },
			Knife = { Vector3.new(0, 1, 0), Vector3.new(0, 0, 1), Vector3.new(1, 0, 0) },
		}

		local tbl25 = {
			Harvester = CFrame.Angles(0, 0, -1.5707963267948966),
			Icepiercer = CFrame.Angles(0, 0, -1.5707963267948966),
		}

		local tbl26 = { Sweet = true, SweetChroma = true }
		local tbl27 = { Harvester = 0.5, Icepiercer = 0.5 }

		local function fn94(arg, arg2, arg3, arg4)
			if arg2 and tbl26[arg2] then
				return cframe
			end
			local v15 = fn76(arg3)
			local v16 = tbl24[arg4]
			if not (v15 and v16) then
				return cframe
			end
			local v17, v18, v19 = fn93(v15)
			local tbl28 = { [v17] = v16[1], [v18] = v16[2], [v19] = v16[3] }

			if tbl23[v17]:Cross(tbl23[v18]):Dot(tbl23[v19]) < 0 then
				tbl28[v19] = -tbl28[v19]
			end

			local x = tbl28.X
			local y = tbl28.Y
			local z = tbl28.Z
			local n8 = arg.Grip.Rotation * CFrame.fromMatrix(Vector3.new(), x, y, z)
			local v20 = arg2 and tbl25[arg2]

			if v20 then
				n8 *= v20
			end

			arg2 = arg2 and tbl27[arg2]

			if arg2 then
				n8 *= CFrame.new(tbl23[v17] * arg2)
			end

			return n8
		end

		local function fn95(arg, arg2)
			local v15 = fn76(arg2)
			if not v15 then
				return cframe
			end
			local v16, v17, v18 = fn93(v15)
			local v19, v20, v21 = fn93(arg)
			local tbl28 = { [v16] = tbl23[v19], [v17] = tbl23[v20], [v18] = tbl23[v21] }

			if tbl23[v16]:Cross(tbl23[v17]):Dot(tbl23[v18]) ~= tbl23[v19]:Cross(tbl23[v20]):Dot(tbl23[v21]) then
				tbl28[v18] = -tbl28[v18]
			end

			local x = tbl28.X
			local y = tbl28.Y
			local z = tbl28.Z
			return CFrame.fromMatrix(Vector3.new(), x, y, z)
		end

		local function fn96(arg)
			if not arg then
				return nil
			end
			return arg:match("^(.-)Chroma$") or arg:match("^Chroma(.+)$")
		end

		local function fn97(arg, arg2)
			local v15 = fn96(arg)
			local meta = v15 and v14[v15] and v14[v15].Meta or arg2.Meta
			if not meta then
				return nil
			end

			if meta.ItemID then
				return ("rbxthumb://type=Asset&w=150&h=150&id=%d"):format(meta.ItemID)
			end
			return meta.Image
		end

		local obj = setmetatable({}, { __mode = "k" })

		local function fn98(arg)
			local v15 = obj[arg]
			if v15 and v15.Parent then
				return v15
			end
			local playerGui = localPlayer2:FindFirstChild("PlayerGui")
			playerGui = playerGui and playerGui:FindFirstChild("BackpackUI")
			playerGui = playerGui and playerGui:FindFirstChild("BackpackFrame")
			if not playerGui then
				return nil
			end

			for _, child in ipairs(playerGui:GetChildren()) do
				local container = child:IsA("GuiObject") and child:FindFirstChild("Container")
				local nameLabel = container and container:FindFirstChild("NameLabel")

				if nameLabel and container:FindFirstChild("ToolIcon") then
					local name = child.Name
					local text = nameLabel.Text
					child.Name = name .. " "
					task.wait()
					local text2 = nameLabel.Text
					child.Name = name
					task.wait()
					nameLabel.Text = text
					if text2 == arg.Name then
						obj[arg] = container
						return container
					end
				end
			end

			return nil
		end

		local function fn99(arg, image)
			task.spawn(function()
				local v15 = fn98(arg)
				if not v15 then
					return
				end
				local toolIcon = v15:FindFirstChild("ToolIcon")

				if toolIcon then
					toolIcon.Image = image
				end

				local nameLabel = v15:FindFirstChild("NameLabel")

				if nameLabel then
					nameLabel.Text = image == "" and arg.Name or ""
				end
			end)
		end

		local function fn100(arg, textureId)
			if not textureId or textureId == "" then
				return nil
			end
			local textureId2 = arg.TextureId
			arg.TextureId = textureId
			fn99(arg, textureId)
			return textureId2
		end

		local function fn101(arg, textureId)
			if not textureId then
				return
			end

			pcall(function()
				arg.TextureId = textureId
			end)

			fn99(arg, textureId)
		end

		local tbl28 = {
			Harvester = "rbxassetid://7808472682",
			Icepiercer = "rbxassetid://7808472682",
			Raygun = "rbxassetid://92066070356304",
			RaygunChroma = "rbxassetid://92066070356304",
			Snowcannon = "rbxassetid://136161856273464",
			SnowcannonChroma = "rbxassetid://136161856273464",
			Gingerscope = "rbxassetid://74240492893421",
		}

		local mM2VizSounds = _G.__MM2VizSounds or {}
		_G.__MM2VizSounds = mM2VizSounds

		local function fn102()
			for _, player in ipairs(Players_:GetPlayers()) do
				for _, v15 in ipairs({ player.Character, player:FindFirstChild("Backpack") }) do
					local v16 = ipairs
					v15 = v15 and v15:GetChildren() or {}

					for _, v17 in v16(v15) do
						local attribute = v17:IsA("Tool") and v17:GetAttribute("ItemID")
						local handle = attribute and v17:FindFirstChild("Handle")
						handle = handle and handle:FindFirstChild("AltSound")

						if handle and handle:IsA("Sound") and handle.SoundId ~= "" and mM2VizSounds[attribute] ~= handle.SoundId then
							mM2VizSounds[attribute] = handle.SoundId
							print(("learned shot sound -- SHOT_SOUND[%q] = %q"):format(attribute, handle.SoundId))
						end
					end
				end
			end
		end

		local function fn103(arg, arg2)
			local v15 = tbl28[arg2] or mM2VizSounds[arg2]
			local handle = v15 and arg:FindFirstChild("Handle")
			handle = handle and handle:FindFirstChild("Gunshot")
			if not (handle and handle:IsA("Sound")) then
				return nil
			end
			local soundId = handle.SoundId
			handle.SoundId = v15
			return { sound = handle, old = soundId }
		end

		local function fn104(arg)
			if arg and arg.sound then
				pcall(function()
					arg.sound.SoundId = arg.old
				end)
			end
		end

		local tbl29 = {}

		local function fn105(arg)
			if arg:IsDescendantOf(localPlayer2) then
				return true
			end
			local v15 = fn86()
			return v15 ~= nil and arg:IsDescendantOf(v15)
		end

		local function fn106(arg, arg2)
			if tbl29[arg] then
				return
			end
			local handle = arg:FindFirstChild("Handle") or arg:WaitForChild("Handle", 5)
			if not handle then
				return
			end
			local v15 = ProfileData.Weapons.Equipped[arg2]
			local v16 = v15 and v14[v15]
			if not v16 then
				return
			end
			fn79(handle)
			local v17 = fn72(v16)
			if not v17 or not v17.root then
				return
			end
			local tbl30 = {}
			fn82(tbl30, handle)

			for _, descendant in ipairs(handle:GetDescendants()) do
				fn82(tbl30, descendant)
			end

			fn70(v17, handle.CFrame * (mM2VizOverrideGrip[v15] or fn94(arg, v15, v16, arg2)))
			local root = v17.root
			root.Parent = handle
			local weldConstraint = Instance.new("WeldConstraint")
			weldConstraint.Part0 = root
			weldConstraint.Part1 = handle
			weldConstraint.Parent = root
			local v18 = fn64(v15, v16) and fn65(root) or nil
			root:SetAttribute("MM2VizOverlay", true)

			tbl29[arg] = {
				overlay = root,
				hidden = tbl30,
				chroma = v18,
				icon = fn100(arg, fn97(v15, v16)),
				skin = v15,
				guards = fn84(tbl30),
				shot = fn103(arg, v15),
			}
		end

		local function fn107(arg)
			local tbl30 = {}
			local v15 = ipairs
			local v16 = CollectionService_
			local getTagged = v16.GetTagged
			local str = arg == "Gun" and "Weapon_Gun" or "Weapon_Knife"

			for _, v17 in v15(getTagged(v16, str)) do
				if fn105(v17) then
					tbl30[#tbl30 + 1] = v17
				end
			end

			return tbl30
		end

		local function fn108(arg)
			local v15 = tbl29[arg]
			if not v15 then
				return
			end

			if v15.chroma then
				pcall(function()
					v15.chroma:Disconnect()
				end)
			end

			if v15.overlay then
				pcall(function()
					v15.overlay:Destroy()
				end)
			end

			pcall(fn101, arg, v15.icon)
			fn104(v15.shot)
			fn85(v15.guards)
			fn83(v15.hidden)
			tbl29[arg] = nil
		end

		local mM2VizBaseline = _G.__MM2VizBaseline

		if not mM2VizBaseline then
			mM2VizBaseline = {}

			for k, v15 in pairs(ProfileData.Weapons.Owned) do
				mM2VizBaseline[k] = v15
			end

			_G.__MM2VizBaseline = mM2VizBaseline
		end

		local mM2VizBaselineEq = _G.__MM2VizBaselineEq

		if not mM2VizBaselineEq then
			mM2VizBaselineEq = { Knife = ProfileData.Weapons.Equipped.Knife, Gun = ProfileData.Weapons.Equipped.Gun }
			_G.__MM2VizBaselineEq = mM2VizBaselineEq
		end

		local function spawn(arg, arg2)
			local n8 = arg2 or 1
			local owned = ProfileData.Weapons.Owned
			owned[arg] = (owned[arg] or 0) + n8

			pcall(function()
				inventoryDataChanged:Fire("Weapons", arg, owned[arg])
			end)
		end

		local function despawnAll()
			local owned = ProfileData.Weapons.Owned
			local n8 = 0

			for k in pairs(v14) do
				local v15 = mM2VizBaseline[k]

				if owned[k] ~= v15 then
					owned[k] = v15

					pcall(function()
						inventoryDataChanged:Fire("Weapons", k, owned[k] or 0)
					end)

					n8 += 1
				end
			end

			for _, v15 in ipairs({ "Knife", "Gun" }) do
				local v16 = ProfileData.Weapons.Equipped[v15]

				if v16 and owned[v16] == nil then
					local str = mM2VizBaselineEq[v15]

					if not (str and owned[str]) then
						str = nil

						for k in pairs(owned) do
							local v17 = weapons[k]
							if type(v17) == "table" and v17.ItemType == v15 then
								str = k
								break
							end
						end
					end

					if not str then
						str = v15 == "Knife" and "DefaultKnife" or "DefaultGun"
					end

					ProfileData.Weapons.Equipped[v15] = str

					pcall(function()
						EquipService.EquippedChanged:Fire(v15, str)
					end)
				end
			end

			return n8
		end

		local list = {}

		for k in pairs(v14) do
			local v15 = weapons[k]

			list[#list + 1] = {
				key = k,
				name = type(v15) == "table" and v15.ItemName or k,
				type = type(v15) == "table" and v15.ItemType or "",
				rarity = type(v15) == "table" and v15.Rarity or "",
				chroma = fn64(k, v14[k]),
			}
		end

		table.sort(list, function(arg, arg2)
			if arg.type ~= arg2.type then
				return arg.type < arg2.type
			end

			if arg.rarity ~= arg2.rarity then
				return arg.rarity < arg2.rarity
			end
			return arg.name:lower() < arg2.name:lower()
		end)

		local v15 = nil
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "MM2Spawner"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 999999

		pcall(function()
			screenGui.Parent = gethui and gethui() or game:GetService("CoreGui")
		end)

		if not screenGui.Parent then
			screenGui.Parent = localPlayer2:WaitForChild("PlayerGui")
		end

		mM2Viz.gui = screenGui
		local frame = Instance.new("Frame")
		frame.Size = UDim2.fromOffset(290, 420)
		frame.Position = UDim2.new(0, 20, 0.5, -210)
		frame.BackgroundColor3 = Color3.fromRGB(20, 20, 27)
		frame.BorderSizePixel = 0
		frame.Active = true
		frame.Draggable = true
		frame.Parent = screenGui
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
		local uiStroke = Instance.new("UIStroke", frame)
		uiStroke.Color = Color3.fromRGB(120, 90, 230)
		uiStroke.Thickness = 1.5
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(0.5, -14, 0, 26)
		textButton.Position = UDim2.fromOffset(12, 10)
		textButton.BackgroundColor3 = Color3.fromRGB(60, 95, 70)
		textButton.BorderSizePixel = 0
		textButton.Font = Enum.Font.GothamBold
		textButton.TextSize = 12
		textButton.TextColor3 = Color3.fromRGB(200, 255, 215)
		textButton.Text = "Spawn all"
		textButton.Parent = frame
		Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)
		local textButton2 = Instance.new("TextButton")
		textButton2.Size = UDim2.new(0.5, -14, 0, 26)
		textButton2.Position = UDim2.new(0.5, 2, 0, 10)
		textButton2.BackgroundColor3 = Color3.fromRGB(95, 60, 70)
		textButton2.BorderSizePixel = 0
		textButton2.Font = Enum.Font.GothamBold
		textButton2.TextSize = 12
		textButton2.TextColor3 = Color3.fromRGB(255, 205, 215)
		textButton2.Text = "Despawn all"
		textButton2.Parent = frame
		Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 6)
		local scrollingFrame = Instance.new("ScrollingFrame")
		scrollingFrame.Size = UDim2.new(1, -20, 1, -56)
		scrollingFrame.Position = UDim2.fromOffset(10, 46)
		scrollingFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 19)
		scrollingFrame.BackgroundTransparency = 0.3
		scrollingFrame.BorderSizePixel = 0
		scrollingFrame.ScrollBarThickness = 6
		scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 90, 230)
		scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		scrollingFrame.Parent = frame
		Instance.new("UICorner", scrollingFrame).CornerRadius = UDim.new(0, 6)
		local uiListLayout = Instance.new("UIListLayout")
		uiListLayout.Padding = UDim.new(0, 2)
		uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout.Parent = scrollingFrame
		local uiPadding = Instance.new("UIPadding")
		uiPadding.PaddingTop = UDim.new(0, 3)
		uiPadding.PaddingBottom = UDim.new(0, 3)
		uiPadding.PaddingLeft = UDim.new(0, 3)
		uiPadding.PaddingRight = UDim.new(0, 3)
		uiPadding.Parent = scrollingFrame

		local function fn109()
		end

		local tbl30 = { Godly = Color3.fromRGB(255, 110, 190), Ancient = Color3.fromRGB(165, 95, 245) }
		local flag17 = false
		local tbl31 = {}

		local function fn110()
			if flag17 then
				return
			end
			flag17 = true

			task.spawn(function()
				for i, v16 in ipairs(list) do
					local textButton3 = Instance.new("TextButton")
					textButton3.Size = UDim2.new(1, -6, 0, 24)
					textButton3.BackgroundColor3 = v16.type == "Knife" and Color3.fromRGB(48, 44, 70) or Color3.fromRGB(44, 56, 72)
					textButton3.BackgroundTransparency = 0.25
					textButton3.Font = Enum.Font.Gotham
					textButton3.TextSize = 12
					textButton3.TextColor3 = Color3.fromRGB(235, 235, 245)
					textButton3.TextXAlignment = Enum.TextXAlignment.Left
					textButton3.TextTruncate = Enum.TextTruncate.AtEnd
					textButton3.Text = "  " .. v16.name .. (v16.chroma and "  [Chroma]" or "") .. "   -  " .. v16.rarity .. " " .. v16.type
					textButton3.LayoutOrder = i
					textButton3.Parent = scrollingFrame
					Instance.new("UICorner", textButton3).CornerRadius = UDim.new(0, 4)
					local uiStroke2 = Instance.new("UIStroke", textButton3)
					uiStroke2.Color = tbl30[v16.rarity] or Color3.fromRGB(90, 90, 110)
					uiStroke2.Thickness = 1.4
					uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					local key = v16.key

					textButton3.MouseButton1Click:Connect(function()
						spawn(key, 1)
						fn109(key)
						local backgroundColor3 = textButton3.BackgroundColor3
						textButton3.BackgroundColor3 = Color3.fromRGB(0, 150, 100)

						task.delay(0.18, function()
							if textButton3.Parent then
								textButton3.BackgroundColor3 = backgroundColor3
							end
						end)
					end)

					tbl31[#tbl31 + 1] = { btn = textButton3, hay = (v16.key .. " " .. v16.name):lower() }

					if i % 60 == 0 then
						task.wait()
					end
				end
			end)
		end

		fn110()

		textButton.MouseButton1Click:Connect(function()
			if textButton.Text ~= "Spawn all" then
				return
			end
			textButton.Text = "..."

			task.spawn(function()
				for i, v16 in ipairs(list) do
					spawn(v16.key, 1)

					if i % 25 == 0 then
						task.wait()
					end
				end

				textButton.Text = "Spawn all"
			end)
		end)

		textButton2.MouseButton1Click:Connect(function()
			if textButton2.Text ~= "Despawn all" then
				return
			end
			textButton2.Text = "..."

			task.spawn(function()
				despawnAll()
				textButton2.Text = "Despawn all"
			end)
		end)

		fn89 = function(text, textColor3)
			if v15 then
				v15.Text = text
				v15.TextColor3 = textColor3 or Color3.fromRGB(190, 190, 205)
			end
		end

		local tbl32 = { Knife = nil, Gun = nil }

		pcall(function()
			tbl32.Knife = ProfileData.Weapons.Equipped.Knife
			tbl32.Gun = ProfileData.Weapons.Equipped.Gun
		end)

		task.spawn(function()
			for _, v16 in ipairs({ "Knife", "Gun" }) do
				local v17 = ProfileData.Weapons.Equipped[v16]

				if v17 then
					task.spawn(function()
						fn92(v16, v17)
					end)
				end
			end

			while _G.__MM2Viz == mM2Viz do
				for _, v16 in ipairs({ "Knife", "Gun" }) do
					local v17 = nil

					pcall(function()
						v17 = ProfileData.Weapons.Equipped[v16]
					end)

					if v17 ~= tbl32[v16] then
						tbl32[v16] = v17
						local v18 = v17

						task.spawn(function()
							fn92(v16, v18)
						end)

						for _, v19 in ipairs(fn107(v16)) do
							task.spawn(function()
								fn108(v19)
								fn106(v19, v16)
							end)
						end
					end
				end

				task.wait(0.1)
			end
		end)

		local connection6 = EquipService.EquippedChanged.Event:Connect(function(arg, arg2)
			if arg == "Knife" or arg == "Gun" then
				tbl32[arg] = arg2

				task.spawn(function()
					fn92(arg, arg2)
				end)
			end
		end)

		table.insert(mM2Viz.conns, connection6)

		local function fn111(arg)
			local connection7 = arg.ChildAdded:Connect(function(child)
				local name = child.Name

				if name == "DisplayRefKnife" or name == "DisplayRefGun" then
					local str = name == "DisplayRefKnife" and "Knife" or "Gun"

					task.delay(0.2, function()
						local v16 = tbl20[str] and tbl21[str]

						if v16 then
							tbl20[str] = nil
							fn92(str, v16)
						end
					end)
				end
			end)

			table.insert(mM2Viz.conns, connection7)
		end

		if fn86() then
			local v16 = fn86()
			fn111(v16)
		end

		local connection7 = localPlayer2.CharacterAdded:Connect(function(character)
			for _, v16 in ipairs({ "Knife", "Gun" }) do
				local v17 = tbl20[v16]

				if v17 and v17.overlay then
					pcall(function()
						v17.overlay:Destroy()
					end)
				end
			end

			tbl20 = {}
			fn111(character)

			task.delay(1, function()
				for _, v16 in ipairs({ "Knife", "Gun" }) do
					if tbl21[v16] then
						fn92(v16, tbl21[v16])
					end
				end
			end)
		end)

		table.insert(mM2Viz.conns, connection7)

		for _, v16 in ipairs({ "Weapon_Knife", "Weapon_Gun" }) do
			local str = v16 == "Weapon_Gun" and "Gun" or "Knife"

			for _, v17 in ipairs(CollectionService_:GetTagged(v16)) do
				if fn105(v17) then
					task.spawn(function()
						fn106(v17, str)
					end)
				end
			end

			table.insert(mM2Viz.conns, CollectionService_:GetInstanceAddedSignal(v16):Connect(function(arg)
				if fn105(arg) then
					task.spawn(function()
						fn106(arg, str)
					end)
				end
			end))

			table.insert(mM2Viz.conns, CollectionService_:GetInstanceRemovedSignal(v16):Connect(function(arg)
				fn108(arg)
			end))
		end

		local function fn112(arg)
			local knifeVisual = arg:WaitForChild("KnifeVisual", 5)
			if not knifeVisual then
				return
			end
			local v16 = nil

			for _, descendant in ipairs(knifeVisual:GetDescendants()) do
				if descendant:GetAttribute("MM2VizOverlay") then
					v16 = descendant
					break
				else
					v16 = nil
				end
			end

			if not v16 then
				return
			end
			local tbl33 = {}
			fn82(tbl33, knifeVisual)

			for _, descendant in ipairs(knifeVisual:GetDescendants()) do
				if descendant ~= v16 and not descendant:IsDescendantOf(v16) then
					fn82(tbl33, descendant)
				end
			end
		end

		table.insert(mM2Viz.conns, CollectionService_:GetInstanceAddedSignal("ThrowingKnife"):Connect(function(arg)
			task.spawn(fn112, arg)
		end))

		local tbl33 = {}

		local function fn113()
			local v16 = fn86()

			for _, v17 in ipairs(CollectionService_:GetTagged("Weapon_Knife")) do
				if v17:IsDescendantOf(localPlayer2) or v16 and v17:IsDescendantOf(v16) then
					return true
				end
			end

			return false
		end

		local function fn114(arg)
			local v16 = tbl33[arg]
			if not v16 then
				return
			end
			tbl33[arg] = nil

			if v16.chroma then
				pcall(function()
					v16.chroma:Disconnect()
				end)
			end

			fn85(v16.guards)

			if v16.overlay then
				pcall(function()
					v16.overlay:Destroy()
				end)
			end
		end

		local function fn115(parent)
			if tbl33[parent] or not fn113() then
				return
			end
			local knife = ProfileData.Weapons.Equipped.Knife
			local v16 = knife and v14[knife]
			if not v16 then
				return
			end
			tbl33[parent] = {}
			local v17 = fn72(v16)

			if not v17 or not v17.root or not parent.Parent then
				if v17 and v17.root then
					v17.root:Destroy()
				end

				tbl33[parent] = nil
				return
			end

			local tbl34 = {}
			fn82(tbl34, parent)

			for _, descendant in ipairs(parent:GetDescendants()) do
				fn82(tbl34, descendant)
			end

			fn70(v17, parent.CFrame * fn95(parent.Size, v16))
			local root = v17.root
			root.Parent = parent
			local weldConstraint = Instance.new("WeldConstraint")
			weldConstraint.Part0 = root
			weldConstraint.Part1 = parent
			weldConstraint.Parent = root
			tbl33[parent] = { overlay = root, chroma = fn64(knife, v16) and fn65(root) or nil, guards = fn84(tbl34) }

			parent.Destroying:Once(function()
				fn114(parent)
			end)
		end

		local function fn116(child)
			if child:IsA("BasePart") and child.Name == "StuckKnife" then
				task.spawn(fn115, child)
			end
		end

		for _, child in ipairs(workspace:GetChildren()) do
			fn116(child)
		end

		table.insert(mM2Viz.conns, workspace.ChildAdded:Connect(fn116))

		task.spawn(function()
			while _G.__MM2Viz == mM2Viz do
				pcall(fn102)
				task.wait(2)
			end
		end)

		mM2Viz.tune = function(arg, arg2, arg3, arg4)
			local v16 = tbl21[arg]
			local v17 = v16 and v14[v16]
			if not v17 then
				warn("nothing applied on " .. tostring(arg))
				return
			end
			local n8 = (mM2VizOverride[v16] or fn80(v16, v17, arg)) * CFrame.Angles(arg2 or 0, arg3 or 0, arg4 or 0)
			mM2VizOverride[v16] = n8
			local tbl34 = { n8:GetComponents() }

			for i, v18 in ipairs(tbl34) do
				tbl34[i] = string.format("%.5f", v18)
			end

			print(("OVERRIDE[%q] = CFrame.new(%s)"):format(v16, table.concat(tbl34, ", ")))

			task.spawn(function()
				tbl21[arg] = nil
				fn92(arg, v16)
			end)
		end

		mM2Viz.tuneGrip = function(arg, arg2, arg3, arg4)
			local v16 = nil

			for k in pairs(tbl29) do
				if (CollectionService_:HasTag(k, "Weapon_Gun") and "Gun" or "Knife") == arg then
					v16 = k
				end
			end

			local v17 = v16 and tbl29[v16]
			local v18 = v17 and v14[v17.skin]
			if not v18 then
				warn("not holding a " .. tostring(arg))
				return
			end
			local n8 = (mM2VizOverrideGrip[v17.skin] or fn94(v16, v17.skin, v18, arg)) * CFrame.Angles(arg2 or 0, arg3 or 0, arg4 or 0)
			mM2VizOverrideGrip[v17.skin] = n8
			local tbl34 = { n8:GetComponents() }

			for i, v19 in ipairs(tbl34) do
				tbl34[i] = string.format("%.5f", v19)
			end

			print(("OVERRIDE_GRIP[%q] = CFrame.new(%s)"):format(v17.skin, table.concat(tbl34, ", ")))

			task.spawn(function()
				fn108(v16)
				fn106(v16, arg)
			end)
		end

		mM2Viz.nudge = function(arg, arg2)
			local v16 = nil

			for k in pairs(tbl29) do
				if (CollectionService_:HasTag(k, "Weapon_Gun") and "Gun" or "Knife") == arg then
					v16 = k
				end
			end

			local v17 = v16 and tbl29[v16]
			if not v17 then
				warn("not holding a " .. tostring(arg))
				return
			end
			tbl27[v17.skin] = (tbl27[v17.skin] or 0) + (arg2 or 0)
			print(("GRIP_NUDGE[%q] = %.2f"):format(v17.skin, tbl27[v17.skin]))

			task.spawn(function()
				fn108(v16)
				fn106(v16, arg)
			end)
		end

		mM2Viz.spawn = spawn
		mM2Viz.despawnAll = despawnAll
		mM2Viz.list = list

		mM2Viz.icon = function(arg)
			local v16 = v14[arg]
			return v16 and fn97(arg, v16) or nil
		end

		mM2Viz.destroy = function()
			for _, conn in ipairs(mM2Viz.conns) do
				pcall(function()
					conn:Disconnect()
				end)
			end

			for k in pairs(tbl20) do
				pcall(fn91, k)
			end

			for k in pairs(tbl29) do
				pcall(fn108, k)
			end

			for k in pairs(tbl33) do
				pcall(fn114, k)
			end

			if mM2Viz.gui then
				pcall(function()
					mM2Viz.gui:Destroy()
				end)
			end
		end

		fn89(("Ready — %d weapons (%d full). Spawn + equip; works in-round too."):format(n5, n6))
		return _G.__MM2Viz
	end

	tbl11.skins:Paragraph({
		Title = "Visual Skin Changer — ONLY YOU CAN SEE THIS!",
		Desc = "Beta - expect the odd bug while holding items. Report them in our YouTube comments.",
	})

	local v11 = nil
	local weapons = nil

	tbl11.skins:Button({
		Title = "Spawn all visual skins",
		Callback = function()
			if not v11 then
				v:Notify({
					Title = "Skins",
					Content = "Still loading, try again in a second.",
					Duration = 2,
					Icon = "loader",
				})

				return
			end

			task.spawn(function()
				for _, v12 in ipairs(v11.list) do
					pcall(v11.spawn, v12.key, 1)
				end

				v:Notify({ Title = "Skins", Content = ("Spawned %d skins."):format(#v11.list), Duration = 2, Icon = "check" })
			end)
		end,
	})

	tbl11.skins:Button({
		Title = "Despawn all visual skins",
		Callback = function()
			if not v11 then
				return
			end
			pcall(v11.despawnAll)
			v:Notify({ Title = "Skins", Content = "Despawned.", Duration = 2, Icon = "check" })
		end,
	})

	local color2 = Color3.fromRGB
	fn50("Spawn all visual skins", Color3.fromHex("#D9D9E0"), 0.25, color2(24, 24, 27))
	local color3 = Color3.fromRGB
	fn50("Despawn all visual skins", Color3.fromHex("#2A2A32"), 0.25, color3(228, 228, 236))
	local v12 = tbl11.skins:Paragraph({ Title = "Skins", Desc = "Loading…" })
	local tbl13 = {}

	local function fn59()
		local v13 = fn51(v12)
		if not v13 then
			warn("[ONYX] couldn't reach the Paragraph container - skin grid skipped")
			return
		end
		local frame = Instance.new("Frame")
		frame.Name = "OnyxSkinSearch"
		frame.LayoutOrder = -1
		frame.Size = UDim2.new(1, 0, 0, 30)
		frame.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
		frame.BackgroundTransparency = 0.25
		frame.BorderSizePixel = 0
		frame.Parent = v13
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
		local textBox = Instance.new("TextBox")
		textBox.BackgroundTransparency = 1
		textBox.Size = UDim2.new(1, -18, 1, 0)
		textBox.Position = UDim2.fromOffset(9, 0)
		textBox.Font = Enum.Font.Gotham
		textBox.TextSize = 12
		textBox.TextXAlignment = Enum.TextXAlignment.Left
		textBox.TextColor3 = Color3.fromRGB(230, 230, 240)
		textBox.PlaceholderText = "Search skins..."
		textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 135)
		textBox.ClearTextOnFocus = false
		textBox.Text = ""
		textBox.Parent = frame
		local frame2 = Instance.new("Frame")
		frame2.Name = "OnyxSkinGrid"
		frame2.LayoutOrder = 0
		frame2.BackgroundTransparency = 1
		frame2.Parent = v13
		local uiGridLayout = Instance.new("UIGridLayout")
		uiGridLayout.CellSize = UDim2.fromOffset(84, 84)
		uiGridLayout.CellPadding = UDim2.fromOffset(6, 6)
		uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		uiGridLayout.Parent = frame2

		local function fn60()
			frame2.Size = UDim2.new(1, 0, 0, uiGridLayout.AbsoluteContentSize.Y)
		end

		uiGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(fn60)
		fn60()
		local clone = nil

		pcall(function()
			local playerGui = localPlayer:FindFirstChild("PlayerGui")
			if not playerGui then
				return
			end

			for _, descendant in ipairs(playerGui:GetDescendants()) do
				if descendant:IsA("Frame") and descendant.Name == "Chroma" and descendant:FindFirstChild("BG") then
					clone = descendant:Clone()
					break
				end
			end
		end)

		local tbl14 = { Godly = Color3.fromRGB(255, 110, 190), Ancient = Color3.fromRGB(165, 95, 245) }

		local function fn61(arg)
			local v14 = weapons and weapons[arg]

			if v14 then
				local image = type(v14.Image) == "string" and v14.Image or nil
				local pos

				if image then
					pos = image:find("rbxassetid") or image:find("rbxthumb")
				else
					pos = image
				end

				if pos then
					return image
				end

				if image then
					local match = image:match("[Aa]sset[Ii][Dd]=(%d+)") or image:match("[?&]id=(%d+)")
					if match then
						return "rbxthumb://type=Asset&w=150&h=150&id=" .. match
					end
				end

				if tonumber(v14.ItemID) then
					return ("rbxthumb://type=Asset&w=150&h=150&id=%s"):format(tostring(v14.ItemID))
				end
			end

			return v11.icon(arg) or ""
		end

		local tbl15 = { Ancient = 1, Godly = 2 }
		local tbl16 = {}

		for _, v14 in ipairs(v11.list) do
			tbl16[#tbl16 + 1] = v14
		end

		table.sort(tbl16, function(arg, arg2)
			local n4 = tbl15[arg.rarity] or 3
			local n5 = tbl15[arg2.rarity] or 3
			if n4 ~= n5 then
				return n4 < n5
			end
			return arg.name:lower() < arg2.name:lower()
		end)

		for i, v14 in ipairs(tbl16) do
			local textButton = Instance.new("TextButton")
			textButton.Name = v14.key
			textButton.LayoutOrder = i
			textButton.Text = ""
			textButton.AutoButtonColor = false
			textButton.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
			textButton.BackgroundTransparency = 0.25
			textButton.BorderSizePixel = 0
			textButton.Parent = frame2
			Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 10)
			local uiStroke = Instance.new("UIStroke")
			uiStroke.Thickness = 1.5
			uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke.Color = tbl14[v14.rarity] or Color3.fromRGB(255, 255, 255)
			uiStroke.Transparency = 0.55
			uiStroke.Parent = textButton
			local imageLabel = Instance.new("ImageLabel")
			imageLabel.BackgroundTransparency = 1
			imageLabel.AnchorPoint = Vector2.new(0.5, 0)
			imageLabel.Position = UDim2.new(0.5, 0, 0, 5)
			imageLabel.Size = UDim2.fromOffset(56, 56)
			imageLabel.Image = fn61(v14.key)
			imageLabel.ScaleType = Enum.ScaleType.Fit
			imageLabel.Parent = textButton
			local textLabel = Instance.new("TextLabel")
			textLabel.BackgroundTransparency = 1
			textLabel.AnchorPoint = Vector2.new(0.5, 1)
			textLabel.Position = UDim2.new(0.5, 0, 1, -4)
			textLabel.Size = UDim2.new(1, -6, 0, 18)
			textLabel.Font = Enum.Font.GothamBold
			textLabel.TextSize = 10
			textLabel.TextWrapped = true
			textLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
			textLabel.Text = v14.name
			textLabel.Parent = textButton

			if v14.chroma then
				local clone2

				if clone then
					clone2 = clone:Clone()
					clone2.Visible = true
					clone2.AnchorPoint = Vector2.new(0, 1)
					clone2.Position = UDim2.new(0, 3, 0, 61)
					clone2.Size = UDim2.fromOffset(36, 11)
					local tagName = clone2:FindFirstChild("TagName")

					if tagName and tagName:IsA("TextLabel") then
						tagName.TextSize = 9
					end
				else
					clone2 = Instance.new("TextLabel")
					clone2.BackgroundTransparency = 0.3
					clone2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
					clone2.AnchorPoint = Vector2.new(0, 1)
					clone2.Position = UDim2.new(0, 3, 0, 61)
					clone2.Size = UDim2.fromOffset(36, 11)
					clone2.Font = Enum.Font.SourceSansBold
					clone2.TextSize = 9
					clone2.TextColor3 = Color3.fromRGB(255, 255, 255)
					clone2.Text = "Chroma"
					Instance.new("UICorner", clone2).CornerRadius = UDim.new(0, 4)
				end

				clone2.Name = "ChromaTag"
				clone2.ZIndex = 5

				for _, descendant in ipairs(clone2:GetDescendants()) do
					if descendant:IsA("GuiObject") then
						descendant.ZIndex = 5
					end
				end

				clone2.Parent = textButton
			end

			textButton.MouseButton1Click:Connect(function()
				local ok = pcall(v11.spawn, v14.key, 1)

				v:Notify({
					Title = ok and "Spawned" or "Failed",
					Content = ok and v14.name .. " — equip it from your inventory." or "Couldn't spawn " .. v14.name,
					Duration = 2,
					Icon = ok and "check" or "x",
				})
			end)

			tbl13[#tbl13 + 1] = { tile = textButton, search = v14.name:lower() }
		end

		textBox:GetPropertyChangedSignal("Text"):Connect(function()
			local str = textBox.Text:lower()

			for _, v14 in ipairs(tbl13) do
				v14.tile.Visible = str == "" or v14.search:find(str, 1, true) ~= nil
			end
		end)

		v12:SetDesc(("%d skins — click one to add it, then equip it normally."):format(#v11.list))

		task.spawn(function()
			local tbl17 = {}

			for _, v14 in ipairs(tbl13) do
				local imageLabel = v14.tile:FindFirstChildWhichIsA("ImageLabel")

				if imageLabel then
					tbl17[#tbl17 + 1] = imageLabel
				end
			end

			pcall(function()
				game:GetService("ContentProvider"):PreloadAsync(tbl17)
			end)
		end)
	end

	task.spawn(function()
		local v13 = getthreadidentity and getthreadidentity() or nil
		local ok, result = pcall(fn58)

		pcall(function()
			weapons = require(game:GetService("ReplicatedStorage").Database.Sync).Weapons
		end)

		if v13 and setthreadidentity then
			pcall(setthreadidentity, v13)
		end

		if not ok or not result then
			pcall(function()
				v12:SetDesc("Couldn't load skins: " .. tostring(result):sub(1, 120))
			end)

			return
		end

		v11 = result

		pcall(function()
			if v11.gui then
				v11.gui.Enabled = false
			end
		end)

		fn59()
	end)

	tbl11.combat:Section({ Title = "Misc" })

	tbl11.combat:Toggle({
		Title = "Auto Grab Gun",
		Flag = "Toggle_Auto_Grab_Gun",
		Desc = "Picks up the dropped gun for you.",
		Type = "Toggle",
		Value = false,
		Callback = function(arg)
			if arg then
				fn38()
			else
				fn37()
			end
		end,
	})

	tbl11.combat:Toggle({
		Title = "Wall Check",
		Flag = "Toggle_Wall_Check",
		Desc = "Only act when you can actually see the target. Covers Silent Aim, Triggerbot and the on-screen buttons.",
		Type = "Toggle",
		Value = false,
		Callback = function(arg)
			flag14 = arg
		end,
	})

	tbl.gunEls = {}
	tbl.knifeEls = {}
	tbl11.combat:Section({ Title = "Sheriff — you have the gun" })

	tbl.el.silentaim = tbl11.combat:Toggle({
		Title = "Silent Aim",
		Flag = "Toggle_Silent_Aim",
		Desc = "Bends your shots to the murderer when you click. Needs the gun, and the aimbot turns it on too.",
		Type = "Toggle",
		Value = false,
		Callback = function(aimOn)
			tbl6.aimOn = aimOn

			if aimOn then
				fn42()
			else
				fn43()
			end
		end,
	})

	tbl.gunEls[#tbl.gunEls + 1] = tbl.el.silentaim

	tbl.gunEls[#tbl.gunEls + 1] = tbl11.combat:Toggle({
		Title = "Triggerbot",
		Flag = "Toggle_Triggerbot",
		Desc = "Fires by itself when the murderer crosses your crosshair. Sheriff only.",
		Type = "Toggle",
		Value = false,
		Callback = function(enabled)
			tbl7.enabled = enabled

			if enabled then
				tbl7.start()
			else
				tbl7.stop()
			end
		end,
	})

	tbl11.combat:Section({ Title = "Murderer — you have the knife" })
	local n4 = 0

	UserInputService.InputBegan:Connect(function()
		n4 = os.clock()
	end)

	local function fn60()
		return os.clock() - n4 < 1
	end

	tbl8.on = true
	tbl8.start()

	tbl.knifeEls[#tbl.knifeEls + 1] = tbl11.combat:Slider({
		Title = "Change Knife Hitbox  (OP!)",
		Flag = "Slider_Change_Knife_Hitbox",
		Desc = "Change the size of your Knife! (1 is default hitbox)",
		Step = 1,
		Value = { Min = 1, Max = 200, Default = 1 },
		Callback = function(arg)
			local num = tonumber(arg) or type(arg) == "table" and tonumber(arg.Value)

			if num then
				tbl8.setMult(num)
			end
		end,
	})

	tbl.knifeEls[#tbl.knifeEls + 1] = tbl11.combat:Toggle({
		Title = "Show Hitbox",
		Flag = "Toggle_Show_Hitbox",
		Desc = "Draws the reach as a sphere.",
		Type = "Toggle",
		Value = false,
		Callback = function(show)
			if not fn60() then
				return
			end
			tbl8.show = show

			if show then
				tbl8.showBall()
			else
				tbl8.hideBall()
			end
		end,
	})

	tbl.knifeEls[#tbl.knifeEls + 1] = tbl11.combat:Toggle({
		Title = "Silent Throw",
		Flag = "Toggle_Silent_Throw",
		Desc = "Right click throws the knife at the nearest player. Murderer only.",
		Type = "Toggle",
		Value = false,
		Callback = function(on)
			tbl9.on = on

			if on then
				tbl9.start()
			else
				tbl9.stop()
			end
		end,
	})

	killTargetDropdown = tbl11.combat:Dropdown({
		Title = "Target",
		Desc = "Pick who to stab, then use the button below.",
		Multi = false,
		Value = nil,
		Values = fn53(),
		Callback = function(arg)
			selectedKillTarget = arg
		end,
	})
end

tbl.knifeEls[#tbl.knifeEls + 1] = killTargetDropdown

tbl.knifeEls[#tbl.knifeEls + 1] = tbl11.combat:Button({
	Title = "Kill Target",
	Desc = "Instantly stabs the player picked above.",
	Callback = function()
		fn44(selectedKillTarget)
	end,
})

tbl.knifeEls[#tbl.knifeEls + 1] = tbl11.combat:Button({
	Title = "Kill All",
	Desc = "Instantly stabs every player in the server.",
	Callback = function()
		fn45()
	end,
})

fn50("Kill All", Color3.fromHex("#7F1D1D"), 0.25)
fn52(ICON.mono)
fn50("Change Knife Hitbox  (OP!)", Color3.fromHex("#7F1D1D"), 0.25)

tbl.perf = {
	LIGHTING = game:GetService("Lighting"),
	UNCAPPED = 999,
	on = {
		textures = false,
		effects = false,
		weaponfx = false,
		pets = false,
		anims = false,
		lighting = false,
		terrain = false,
		sounds = false,
		quality = false,
		fpsCounter = false,
	},
	el = {},
	stash = {
		parent = {},
		part = {},
		texid = {},
		volume = {},
		enabled = {},
		post = {},
		light = nil,
		terrain = nil,
		quality = nil,
	},
	animConns = {},
	watchConn = nil,
	playerConn = nil,
	owner = {},
}

tbl.perf.ours = function(arg)
	while arg do
		if arg.Name:sub(1, 4) == "Onyx" then
			return true
		end
		arg = arg.Parent
	end

	return false
end

tbl.perf.FX = {
	ParticleEmitter = true,
	Trail = true,
	Smoke = true,
	Fire = true,
	Sparkles = true,
	Beam = true,
	Explosion = true,
	PointLight = true,
	SpotLight = true,
	SurfaceLight = true,
}

tbl.perf.reparent = function(arg, parent)
	arg.Parent = parent
end

tbl.perf.restorePart = function(arg, arg2)
	local v7 = arg2[2]
	local v8 = arg2[3]
	arg.Material = arg2[1]
	arg.CastShadow = v7
	arg.Reflectance = v8
end

tbl.perf.CHUNK = 75
tbl.perf.sweeping = false

tbl.perf.breathe = function(arg)
	if arg % tbl.perf.CHUNK == 0 then
		task.wait()
	end
end

tbl.perf.keysOf = function(arg)
	local tbl13 = {}
	local n4 = 0

	for k in next, arg, nil do
		n4 += 1
		tbl13[n4] = k
	end

	return tbl13, n4
end

tbl.perf.readProp = function(arg, arg2)
	return arg[arg2]
end

tbl.perf.TERRAIN = {
	{ "Decoration", false },
	{ "WaterWaveSize", 0 },
	{ "WaterWaveSpeed", 0 },
	{ "WaterReflectance", 0 },
	{ "WaterTransparency", 1 },
}

tbl.perf.setProp = function(arg, arg2, arg3)
	arg[arg2] = arg3
end

tbl.perf.detach = function(arg, arg2)
	if tbl.perf.stash.parent[arg] ~= nil then
		return
	end
	local parent = arg.Parent
	if not parent then
		return
	end
	tbl.perf.stash.parent[arg] = parent
	tbl.perf.owner[arg] = arg2
	pcall(tbl.perf.reparent, arg, nil)
end

tbl.perf.stripTexture = function(arg)
	if arg:IsA("Decal") or arg:IsA("Texture") or arg:IsA("SurfaceAppearance") then
		tbl.perf.detach(arg, "textures")
	elseif arg:IsA("SpecialMesh") then
		if tbl.perf.stash.texid[arg] == nil and arg.TextureId ~= "" then
			tbl.perf.stash.texid[arg] = arg.TextureId
			pcall(tbl.perf.setProp, arg, "TextureId", "")
		end
	elseif arg:IsA("BasePart") and not arg:IsA("Terrain") then
		if tbl.perf.stash.part[arg] == nil then
			tbl.perf.stash.part[arg] = { arg.Material, arg.CastShadow, arg.Reflectance }
			arg.Material = Enum.Material.SmoothPlastic
			arg.CastShadow = false
			arg.Reflectance = 0
		end
	end
end

tbl.perf.clearEmitter = function(arg)
	arg:Clear()
end

tbl.perf.killFX = function(arg, arg2)
	if arg:IsA("ParticleEmitter") then
		if tbl.perf.stash.enabled[arg] == nil then
			tbl.perf.stash.enabled[arg] = arg.Enabled
		end

		arg.Enabled = false
		pcall(tbl.perf.clearEmitter, arg)
	end

	tbl.perf.detach(arg, arg2)
end

tbl.perf.stripEffect = function(arg)
	if tbl.perf.FX[arg.ClassName] then
		tbl.perf.killFX(arg, "effects")
	end
end

tbl.perf.stripWeaponFX = function(arg)
	for _, descendant in ipairs(arg:GetDescendants()) do
		if tbl.perf.FX[descendant.ClassName] then
			tbl.perf.killFX(descendant, "weaponfx")
		end
	end
end

tbl.perf.stripSound = function(arg)
	if arg:IsA("Sound") and tbl.perf.stash.volume[arg] == nil then
		tbl.perf.stash.volume[arg] = arg.Volume
		pcall(tbl.perf.setProp, arg, "Volume", 0)
	end
end

tbl.perf.hookAnimator = function(arg)
	if tbl.perf.animConns[arg] then
		return
	end

	pcall(function()
		for _, v7 in ipairs(arg:GetPlayingAnimationTracks()) do
			v7:Stop(0)
		end
	end)

	local ok, result = pcall(function()
		return arg.AnimationPlayed:Connect(function(arg2)
			if not tbl.perf.on.anims then
				return
			end

			pcall(function()
				arg2:Stop(0)
			end)
		end)
	end)

	if ok and result then
		tbl.perf.animConns[arg] = result
	end
end

tbl.perf.apply = function(arg)
	if tbl.perf.ours(arg) then
		return
	end

	if tbl.perf.on.textures then
		tbl.perf.stripTexture(arg)
	end

	if tbl.perf.on.effects then
		tbl.perf.stripEffect(arg)
	end

	if tbl.perf.on.sounds then
		tbl.perf.stripSound(arg)
	end

	if tbl.perf.on.anims and arg:IsA("Animator") then
		tbl.perf.hookAnimator(arg)
	end

	if tbl.perf.on.weaponfx then
		if arg:IsA("Tool") then
			tbl.perf.stripWeaponFX(arg)
		elseif tbl.perf.FX[arg.ClassName] and arg:FindFirstAncestorWhichIsA("Tool") then
			tbl.perf.killFX(arg, "weaponfx")
		end
	end

	if tbl.perf.on.pets then
		local parent = arg.Parent

		if parent and parent.Name == "PetContainer" then
			tbl.perf.detach(arg, "pets")
		end
	end
end

tbl.perf.queue = {}
tbl.perf.queueN = 0
tbl.perf.drainThread = nil
tbl.perf.qHead = 1

tbl.perf.enqueue = function(arg)
	local queueN = tbl.perf.queueN + 1
	tbl.perf.queueN = queueN
	tbl.perf.queue[queueN] = arg
end

tbl.perf.drainStep = function()
	local queue = tbl.perf.queue
	local qHead = tbl.perf.qHead
	local queueN = tbl.perf.queueN

	if queueN < qHead then
		if queueN > 0 then
			local perf = tbl.perf
			local perf2 = tbl.perf
			tbl.perf.queue = {}
			perf.queueN = 0
			perf2.qHead = 1
		end

		return
	end

	local n4 = qHead + tbl.perf.CHUNK - 1

	if not (n4 > queueN) then
		queueN = n4
	end

	for i = qHead, queueN do
		tbl.perf.safeApply(queue[i])
		queue[i] = nil
	end

	tbl.perf.qHead = queueN + 1
end

tbl.perf.stopDrain = function()
	if tbl.perf.drainThread then
		pcall(task.cancel, tbl.perf.drainThread)
		tbl.perf.drainThread = nil
	end

	local perf = tbl.perf
	local perf2 = tbl.perf
	tbl.perf.queue = {}
	perf.queueN = 0
	perf2.qHead = 1
end

tbl.perf.startDrain = function()
	tbl.perf.stopDrain()

	tbl.perf.drainThread = task.spawn(function()
		while true do
			task.wait()
			local ok, result = pcall(tbl.perf.drainStep)

			if not ok then
				warn("[ONYX] performance queue: " .. tostring(result))
			end
		end
	end)
end

tbl.perf.safeApply = function(arg)
	pcall(tbl.perf.apply, arg)
end

tbl.perf.sweepBody = function()
	local descendants = Workspace:GetDescendants()

	for i = 1, #descendants do
		tbl.perf.safeApply(descendants[i])
		tbl.perf.breathe(i)
	end

	if tbl.perf.on.weaponfx then
		local descendants2 = localPlayer:GetDescendants()

		for i = 1, #descendants2 do
			local v7 = descendants2[i]

			if v7:IsA("Tool") then
				pcall(tbl.perf.stripWeaponFX, v7)
			end

			tbl.perf.breathe(i)
		end
	end
end

tbl.perf.resweep = false

tbl.perf.sweep = function()
	if tbl.perf.sweeping then
		tbl.perf.resweep = true
		return
	end
	tbl.perf.sweeping = true

	while true do
		tbl.perf.resweep = false
		local ok, result = pcall(tbl.perf.sweepBody)

		if not ok then
			warn("[ONYX] performance sweep: " .. tostring(result))
		end

		if tbl.perf.resweep then
			continue
		end
		break
	end

	tbl.perf.sweeping = false
end

tbl.perf.PROP_STASHES = { "part", "volume", "texid", "enabled" }

tbl.perf.prune = function()
	local n4 = 0

	for _, propStashe in ipairs(tbl.perf.PROP_STASHES) do
		local v7 = tbl.perf.stash[propStashe]

		if v7 then
			local v8, v9 = tbl.perf.keysOf(v7)

			for i = 1, v9 do
				local v10 = v8[i]
				local ok, result = pcall(tbl.perf.readProp, v10, "Parent")

				if not ok or result == nil then
					v7[v10] = nil
					n4 += 1
				end

				tbl.perf.breathe(i)
			end
		end
	end

	local v7, v8 = tbl.perf.keysOf(tbl.perf.stash.parent)

	for i = 1, v8 do
		local v9 = v7[i]
		local v10 = tbl.perf.stash.parent[v9]

		if v10 ~= nil then
			local ok, result = pcall(tbl.perf.inGame, v10)

			if not ok or not result then
				tbl.perf.stash.parent[v9] = nil
				tbl.perf.owner[v9] = nil
				n4 += 1
			end
		end

		tbl.perf.breathe(i)
	end

	return n4
end

tbl.perf.inGame = function(arg)
	return arg:IsDescendantOf(game)
end

tbl.perf.PULSE = 10
tbl.perf.pulseThread = nil

tbl.perf.stopPulse = function()
	if tbl.perf.pulseThread then
		pcall(task.cancel, tbl.perf.pulseThread)
		tbl.perf.pulseThread = nil
	end

	tbl.perf.sweeping = false
end

tbl.perf.startPulse = function()
	tbl.perf.stopPulse()

	tbl.perf.pulseThread = task.spawn(function()
		while true do
			task.wait(tbl.perf.PULSE)
			local ok, result = pcall(tbl.perf.sweep)

			if not ok then
				warn("[ONYX] performance re-sweep: " .. tostring(result))
			end

			local ok2, result2 = pcall(tbl.perf.prune)

			if not ok2 then
				warn("[ONYX] performance prune: " .. tostring(result2))
			end
		end
	end)
end

tbl.perf.syncWatcher = function()
	local textures = tbl.perf.on.textures or tbl.perf.on.effects or tbl.perf.on.sounds or tbl.perf.on.anims or tbl.perf.on.weaponfx or tbl.perf.on.pets

	if textures and not tbl.perf.watchConn then
		tbl.perf.watchConn = Workspace.DescendantAdded:Connect(tbl.perf.enqueue)
		tbl.perf.startDrain()
		tbl.perf.startPulse()
	elseif not textures and tbl.perf.watchConn then
		pcall(function()
			tbl.perf.watchConn:Disconnect()
		end)

		tbl.perf.watchConn = nil
		tbl.perf.stopDrain()
		tbl.perf.stopPulse()
	end

	if tbl.perf.on.weaponfx and not tbl.perf.playerConn then
		tbl.perf.playerConn = localPlayer.DescendantAdded:Connect(tbl.perf.enqueue)
	elseif not tbl.perf.on.weaponfx and tbl.perf.playerConn then
		pcall(function()
			tbl.perf.playerConn:Disconnect()
		end)

		tbl.perf.playerConn = nil
	end
end

tbl.perf.restoreOwned = function(arg)
	local v7, v8 = tbl.perf.keysOf(tbl.perf.stash.parent)

	for i = 1, v8 do
		local v9 = v7[i]
		local v10 = tbl.perf.stash.parent[v9]

		if v10 ~= nil and tbl.perf.owner[v9] == arg then
			pcall(tbl.perf.reparent, v9, v10)
			tbl.perf.stash.parent[v9] = nil
			tbl.perf.owner[v9] = nil
		end

		tbl.perf.breathe(i)
	end
end

tbl.perf.restoreEnabled = function(arg)
	local v7, v8 = tbl.perf.keysOf(tbl.perf.stash.enabled)

	for i = 1, v8 do
		local v9 = v7[i]
		local v10 = tbl.perf.stash.enabled[v9]

		if v10 ~= nil and tbl.perf.owner[v9] == arg then
			pcall(tbl.perf.setProp, v9, "Enabled", v10)
			tbl.perf.stash.enabled[v9] = nil
		end

		tbl.perf.breathe(i)
	end
end

tbl.perf.restoreTextures = function()
	tbl.perf.restoreOwned("textures")
	local v7, v8 = tbl.perf.keysOf(tbl.perf.stash.texid)

	for i = 1, v8 do
		local v9 = v7[i]
		local v10 = tbl.perf.stash.texid[v9]

		if v10 ~= nil then
			if v9.Parent then
				pcall(tbl.perf.setProp, v9, "TextureId", v10)
			end

			tbl.perf.stash.texid[v9] = nil
		end

		tbl.perf.breathe(i)
	end

	local v9, v10 = tbl.perf.keysOf(tbl.perf.stash.part)

	for i = 1, v10 do
		local v11 = v9[i]
		local v12 = tbl.perf.stash.part[v11]

		if v12 ~= nil then
			if v11.Parent then
				pcall(tbl.perf.restorePart, v11, v12)
			end

			tbl.perf.stash.part[v11] = nil
		end

		tbl.perf.breathe(i)
	end
end

tbl.perf.features = {}

do
	local perf = tbl.perf
	local perf2 = tbl.perf
	tbl.perf.gui = nil
	perf.label = nil
	perf2.fpsConn = nil
end

tbl.perf.killCounter = function()
	if tbl.perf.fpsConn then
		pcall(function()
			tbl.perf.fpsConn:Disconnect()
		end)

		tbl.perf.fpsConn = nil
	end

	if tbl.perf.dragConn then
		pcall(function()
			tbl.perf.dragConn:Disconnect()
		end)

		tbl.perf.dragConn = nil
	end

	if tbl.perf.gui then
		pcall(function()
			tbl.perf.gui:Destroy()
		end)

		tbl.perf.gui = nil
	end

	tbl.perf.label = nil
end

tbl.perf.buildCounter = function()
	tbl.perf.killCounter()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "OnyxFPSButton"
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 9000
	screenGui.Parent = CoreGui
	local textButton = Instance.new("TextButton")
	textButton.AutoButtonColor = false
	textButton.Text = ""
	textButton.AnchorPoint = Vector2.new(0.5, 0)
	textButton.Position = tbl.perf.fpsPos or UDim2.new(0.5, 0, 0, 6)
	textButton.Size = UDim2.fromOffset(72, 26)
	textButton.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
	textButton.BackgroundTransparency = 0.25
	textButton.BorderSizePixel = 0
	textButton.Parent = screenGui
	Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 8)
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Thickness = 1
	uiStroke.Color = Color3.fromRGB(255, 255, 255)
	uiStroke.Transparency = 0.85
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke.Parent = textButton
	local textLabel = Instance.new("TextLabel")
	textLabel.BackgroundTransparency = 1
	textLabel.Size = UDim2.fromScale(1, 1)
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 13
	textLabel.Text = "-- FPS"
	textLabel.TextColor3 = Color3.fromRGB(240, 240, 246)
	textLabel.Parent = textButton
	local perf = tbl.perf
	tbl.perf.gui = screenGui
	perf.label = textLabel
	local flag16 = false
	local v7 = nil
	local v8 = nil

	textButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			local position = input.Position
			local position2 = textButton.Position
			flag16 = true
			v7 = position
			v8 = position2
		end
	end)

	textButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag16 = false
			tbl.perf.fpsPos = textButton.Position
		end
	end)

	tbl.perf.dragConn = UserInputService.InputChanged:Connect(function(input)
		if not flag16 then
			return
		end

		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		local n4 = input.Position - v7
		textButton.Position = UDim2.new(v8.X.Scale, v8.X.Offset + n4.X, v8.Y.Scale, v8.Y.Offset + n4.Y)
	end)

	local n4 = 0
	local now = os.clock()

	tbl.perf.fpsConn = RunService.RenderStepped:Connect(function()
		n4 += 1
		local now2 = os.clock()
		local n5 = now2 - now
		if n5 < 0.5 then
			return
		end
		local n6 = math.floor(n4 / n5 + 0.5)
		n4 = 0
		now = now2
		textLabel.Text = n6 .. " FPS"
		textLabel.TextColor3 = n6 >= 50 and ICON.green or n6 >= 30 and ICON.yellow or ICON.red
	end)
end

tbl.perf.batch = false

tbl.perf.set = function(arg, arg2)
	local flag16 = arg2 and true or false
	if tbl.perf.on[arg] == flag16 then
		return
	end
	local v7 = tbl.perf.features[arg]
	if not v7 then
		return
	end
	tbl.perf.on[arg] = flag16
	if tbl.perf.batch and flag16 and v7.sweeps then
		return
	end
	local ok, result = pcall(flag16 and v7.on or v7.off)

	if not ok then
		warn("[ONYX] performance '" .. arg .. "' failed: " .. tostring(result))
	end

	tbl.perf.syncWatcher()
end

tbl.perf.MASTER = {
	"fpsCounter",
	"textures",
	"effects",
	"weaponfx",
	"pets",
	"anims",
	"lighting",
	"terrain",
	"sounds",
	"quality",
}

tbl.perf.MIRRORS = { "master", "masterFarm" }
tbl.perf.settingAll = false

tbl.perf.setAll = function(arg)
	if tbl.perf.settingAll then
		return
	end
	tbl.perf.settingAll = true
	tbl.perf.sweeping = false
	tbl.perf.batch = true

	local ok, result = pcall(function()
		for _, v7 in ipairs(tbl.perf.MASTER) do
			tbl.setToggle(tbl.perf.el[v7], arg)
			tbl.perf.set(v7, arg)
		end
	end)

	for _, mirror in ipairs(tbl.perf.MIRRORS) do
		tbl.setToggle(tbl.perf.el[mirror], arg)
	end

	tbl.perf.batch = false
	tbl.perf.settingAll = false

	if not ok then
		warn("[ONYX] performance master failed: " .. tostring(result))
	end

	if arg then
		pcall(tbl.perf.sweep)
	end

	tbl.perf.syncWatcher()
end

tbl.perf.restoreAll = function()
	tbl.perf.stopPulse()
	tbl.perf.stopDrain()

	for k in next, tbl.perf.features, nil do
		tbl.perf.set(k, false)
	end

	tbl.perf.killCounter()

	if tbl.perf.capped then
		tbl.perf.capped = false

		pcall(function()
			if setfpscap then
				setfpscap(tbl.perf.UNCAPPED)
			end
		end)
	end
end

tbl.perf.el.masterFarm = tbl.perfFarmToggle
tbl11.visuals:Section({ Title = "Performance Mode" })

tbl11.visuals:Paragraph({
	Title = "Read me first",
	Desc = "All client-side and fully reversible - switch it off and the map is back. Roughly 10-30% more frames.",
})

tbl.perf.el.master = tbl11.visuals:Toggle({
	Title = "Performance Mode",
	Flag = "Toggle_Perf_Master",
	Desc = "Strips textures, shadows, particles, effects, pets, animations and sounds, and drops the graphics quality. Ugly, and fast.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(arg)
		tbl.perf.setAll(arg)
	end),
})

tbl.perf.features.fpsCounter = {
	on = function()
		tbl.perf.buildCounter()
	end,
	off = function()
		tbl.perf.killCounter()
	end,
}

tbl.perf.el.fpsCounter = tbl11.visuals:Toggle({
	Title = "FPS Counter",
	Flag = "Toggle_Perf_FPS",
	Desc = "Live framerate at the top of the screen -- drag it anywhere. Green 50+, amber 30+, red below.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(arg)
		tbl.perf.set("fpsCounter", arg)
	end),
})

tbl.perf.features.textures = {
	sweeps = true,
	on = function()
		tbl.perf.sweep()
	end,
	off = function()
		tbl.perf.restoreTextures()
	end,
}

tbl.perf.el.textures = tbl11.visuals:Toggle({
	Title = "Remove Textures",
	Flag = "Toggle_Perf_Textures",
	Desc = "Textures and decals off, every part flat, nothing casting a shadow. The biggest single win.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(arg)
		tbl.perf.set("textures", arg)
	end),
})

tbl.perf.features.effects = {
	sweeps = true,
	on = function()
		tbl.perf.sweep()
	end,
	off = function()
		tbl.perf.restoreEnabled("effects")
		tbl.perf.restoreOwned("effects")
	end,
}

tbl.perf.el.effects = tbl11.visuals:Toggle({
	Title = "Remove Particles & Effects",
	Flag = "Toggle_Perf_Effects",
	Desc = "Particles, trails, beams, smoke, fire and every dynamic light. Bragas' own ESP and crosshair stay.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(arg)
		tbl.perf.set("effects", arg)
	end),
})

tbl.perf.features.weaponfx = {
	sweeps = true,
	on = function()
		tbl.perf.sweep()
	end,
	off = function()
		tbl.perf.restoreEnabled("weaponfx")
		tbl.perf.restoreOwned("weaponfx")
	end,
}

tbl.perf.features.pets = {
	on = function()
		local petContainer = Workspace:FindFirstChild("PetContainer")

		if petContainer then
			for _, child in ipairs(petContainer:GetChildren()) do
				tbl.perf.detach(child, "pets")
			end
		end
	end,
	off = function()
		tbl.perf.restoreOwned("pets")
	end,
}

tbl.perf.features.anims = {
	sweeps = true,
	on = function()
		tbl.perf.sweep()
	end,
	off = function()
		for k, v7 in next, tbl.perf.animConns, nil do
			pcall(function()
				v7:Disconnect()
			end)

			tbl.perf.animConns[k] = nil
		end
	end,
}

tbl.perf.el.anims = tbl11.visuals:Toggle({
	Title = "Remove Animations",
	Flag = "Toggle_Perf_Anims",
	Desc = "Freezes every animation. Everyone slides around, you included. Movement still works.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(arg)
		tbl.perf.set("anims", arg)
	end),
})

tbl.perf.features.sounds = {
	sweeps = true,
	on = function()
		tbl.perf.sweep()
	end,
	off = function()
		local v7, v8 = tbl.perf.keysOf(tbl.perf.stash.volume)

		for i = 1, v8 do
			local v9 = v7[i]
			local v10 = tbl.perf.stash.volume[v9]

			if v10 ~= nil then
				if v9.Parent then
					pcall(tbl.perf.setProp, v9, "Volume", v10)
				end

				tbl.perf.stash.volume[v9] = nil
			end

			tbl.perf.breathe(i)
		end
	end,
}

tbl.perf.el.sounds = tbl11.visuals:Toggle({
	Title = "Mute All Sounds",
	Flag = "Toggle_Perf_Sounds",
	Desc = "Mutes the map. You lose footsteps, so think twice as innocent.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(arg)
		tbl.perf.set("sounds", arg)
	end),
})

tbl.perf.features.lighting = {
	on = function()
		if not tbl.perf.stash.light then
			tbl.perf.stash.light = {
				shadows = tbl.perf.LIGHTING.GlobalShadows,
				diffuse = tbl.perf.LIGHTING.EnvironmentDiffuseScale,
				spec = tbl.perf.LIGHTING.EnvironmentSpecularScale,
				soft = tbl.perf.LIGHTING.ShadowSoftness,
			}
		end

		pcall(function()
			tbl.perf.LIGHTING.GlobalShadows = false
			tbl.perf.LIGHTING.EnvironmentDiffuseScale = 0
			tbl.perf.LIGHTING.EnvironmentSpecularScale = 0
			tbl.perf.LIGHTING.ShadowSoftness = 0
		end)

		for _, child in ipairs(tbl.perf.LIGHTING:GetChildren()) do
			if child:IsA("PostEffect") then
				if tbl.perf.stash.post[child] == nil then
					tbl.perf.stash.post[child] = child.Enabled

					pcall(function()
						child.Enabled = false
					end)
				end
			elseif child:IsA("Atmosphere") then
				tbl.perf.detach(child, "lighting")
			end
		end

		for _, child in ipairs(Workspace.Terrain:GetChildren()) do
			if child:IsA("Clouds") then
				tbl.perf.detach(child, "lighting")
			end
		end
	end,
	off = function()
		local light = tbl.perf.stash.light

		if light then
			pcall(function()
				tbl.perf.LIGHTING.GlobalShadows = light.shadows
				tbl.perf.LIGHTING.EnvironmentDiffuseScale = light.diffuse
				tbl.perf.LIGHTING.EnvironmentSpecularScale = light.spec
				tbl.perf.LIGHTING.ShadowSoftness = light.soft
			end)

			tbl.perf.stash.light = nil
		end

		for k, v7 in next, tbl.perf.stash.post, nil do
			pcall(function()
				if k.Parent then
					k.Enabled = v7
				end
			end)
		end

		tbl.perf.stash.post = {}
		tbl.perf.restoreOwned("lighting")
	end,
}

tbl.perf.el.lighting = tbl11.visuals:Toggle({
	Title = "Remove Shadows & Lighting FX",
	Flag = "Toggle_Perf_Lighting",
	Desc = "Shadows, bloom, blur, sun rays, depth of field and clouds. Second biggest win after textures.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(arg)
		tbl.perf.set("lighting", arg)
	end),
})

tbl.perf.features.terrain = {
	on = function()
		local terrain = Workspace.Terrain
		tbl.perf.stash.terrain = tbl.perf.stash.terrain or {}

		for _, v7 in ipairs(tbl.perf.TERRAIN) do
			local v8 = v7[1]
			local v9 = v7[2]
			local ok, result = pcall(tbl.perf.readProp, terrain, v8)

			if ok and tbl.perf.stash.terrain[v8] == nil then
				tbl.perf.stash.terrain[v8] = result
				pcall(tbl.perf.setProp, terrain, v8, v9)
			end
		end
	end,
	off = function()
		local terrain = tbl.perf.stash.terrain
		if not terrain then
			return
		end
		local terrain2 = Workspace.Terrain

		for k, v7 in next, terrain, nil do
			pcall(tbl.perf.setProp, terrain2, k, v7)
		end

		tbl.perf.stash.terrain = nil
	end,
}

tbl.perf.el.terrain = tbl11.visuals:Toggle({
	Title = "Flat Terrain & Water",
	Flag = "Toggle_Perf_Terrain",
	Desc = "Kills grass blades and the animated water waves.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(arg)
		tbl.perf.set("terrain", arg)
	end),
})

tbl.perf.features.quality = {
	on = function()
		if tbl.perf.stash.quality == nil then
			pcall(function()
				tbl.perf.stash.quality = settings().Rendering.QualityLevel
			end)
		end

		pcall(function()
			local level01 = Enum.QualityLevel.Level01
			settings().Rendering.QualityLevel = level01
		end)

		pcall(function()
			local qualityLevel1 = Enum.SavedQualitySetting.QualityLevel1
			UserSettings():GetService("UserGameSettings").SavedQualityLevel = qualityLevel1
		end)
	end,
	off = function()
		local quality = tbl.perf.stash.quality

		if quality ~= nil then
			pcall(function()
				settings().Rendering.QualityLevel = quality
			end)

			tbl.perf.stash.quality = nil
		end

		pcall(function()
			local automatic = Enum.SavedQualitySetting.Automatic
			UserSettings():GetService("UserGameSettings").SavedQualityLevel = automatic
		end)
	end,
}

tbl.perf.el.quality = tbl11.visuals:Toggle({
	Title = "Lowest Graphics Quality",
	Flag = "Toggle_Perf_Quality",
	Desc = "Sets Roblox's own graphics slider to 1. Needs a level 8 executor.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(arg)
		tbl.perf.set("quality", arg)
	end),
})

fn52(ICON.mono)

do
	local tbl13 = { ToggleGUI = Enum.KeyCode.G }

	local tbl14 = {
		ToggleGUI = function()
			v2:Toggle()
		end,
		Shoot = function()
			fn35()
		end,
		Grab = function()
			fn41()
		end,
		Throw = function()
			fn36()
		end,
		Bomb = function()
			fn39()
		end,
		Aimbot = function()
			tbl5.set(not tbl5.enabled)
		end,
		WallHop = function()
			fn40()
		end,
		Noclip = function()
			tbl.setToggle(tbl.el.noclip, not flag8, function(arg)
				flag8 = arg

				if arg then
					fn18()
				else
					fn19()
				end
			end)
		end,
		Fly = function()
			tbl.setToggle(tbl.el.fly, not flag9, function(arg)
				flag9 = arg

				if arg then
					fn20()
				else
					fn21()
				end
			end)
		end,
		InfJump = function()
			tbl.setToggle(tbl.el.infjump, not flag10, function(arg)
				flag10 = arg

				if arg then
					fn22()
				else
					fn23()
				end
			end)
		end,
		AntiFling = function()
			tbl.setToggle(tbl.el.antifling, not flag11, function(arg)
				flag11 = arg

				if arg then
					fn24()
				else
					fn25()
				end
			end)
		end,
		Speed = function()
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
			fn16(humanoid and humanoid.WalkSpeed ~= 16 and 16 or walkSpeed)
		end,
		Jump = function()
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
			fn17(humanoid and humanoid.JumpPower ~= 50 and 50 or jumpPower)
		end,
	}

	keybindConn = UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		if input.KeyCode == Enum.KeyCode.Unknown then
			return
		end

		if UserInputService:GetFocusedTextBox() then
			return
		end

		for k, v7 in pairs(tbl13) do
			v7 = v7 and input.KeyCode == v7

			if v7 then
				local v8 = tbl14[k]

				if v8 then
					task.spawn(function()
						pcall(v8)
					end)
				end
			end
		end
	end)

	local function fn53(arg, arg2, arg3, arg4, arg5)
		arg:Keybind({
			Title = arg2,
			Desc = arg3,
			Flag = "Keybind_" .. arg4,
			Value = arg5,
			Callback = function(arg6)
				local ok, result = pcall(function()
					return Enum.KeyCode[arg6]
				end)

				if ok and result and result ~= Enum.KeyCode.Unknown then
					tbl13[arg4] = result
				else
					tbl13[arg4] = nil
				end
			end,
		})
	end

	tbl11.keybinds:Section({ Title = "Interface" })
	fn53(tbl11.keybinds, "Toggle GUI", "Show or hide the window.", "ToggleGUI", "G")
	tbl.UNBOUND = "Unbound - click to set a key. Ignore the key shown until you do."
	tbl11.keybinds:Section({ Title = "Actions" })
	fn53(tbl11.keybinds, "Shoot Murderer", tbl.UNBOUND, "Shoot", "Unknown")
	fn53(tbl11.keybinds, "Grab Gun", tbl.UNBOUND, "Grab", "Unknown")
	fn53(tbl11.keybinds, "Throw Knife", tbl.UNBOUND, "Throw", "Unknown")
	fn53(tbl11.keybinds, "Bomb Jump", tbl.UNBOUND, "Bomb", "Unknown")
	fn53(tbl11.keybinds, "Toggle Aimbot", tbl.UNBOUND, "Aimbot", "Unknown")
	tbl11.keybinds:Section({ Title = "Player" })
	fn53(tbl11.keybinds, "Toggle Noclip", tbl.UNBOUND, "Noclip", "Unknown")
	fn53(tbl11.keybinds, "Toggle Fly", tbl.UNBOUND, "Fly", "Unknown")
	fn53(tbl11.keybinds, "Toggle Infinite Jump", tbl.UNBOUND, "InfJump", "Unknown")
	fn53(tbl11.keybinds, "Toggle Anti-Fling", tbl.UNBOUND, "AntiFling", "Unknown")
	fn53(tbl11.keybinds, "Toggle Walk Speed", tbl.UNBOUND .. " Snaps between your slider speed and 16.", "Speed", "Unknown")
	fn53(tbl11.keybinds, "Toggle Jump Power", tbl.UNBOUND .. " Snaps between your slider jump and 50.", "Jump", "Unknown")
	fn53(tbl11.keybinds, "Wall Hop", "Unbound — click to set a key. Ignore the key shown until you do.", "WallHop", "Unknown")
end

tbl11.player:Section({ Title = "Speeds" })

tbl11.player:Slider({
	Title = "Walk Speed",
	Flag = "Slider_Walk_Speed",
	Desc = "How fast you walk — crank it to outrun the murderer",
	Step = 1,
	Value = { Min = 16, Max = 100, Default = 16 },
	Callback = function(arg)
		fn16(arg)
	end,
})

tbl11.player:Slider({
	Title = "Jump Power",
	Flag = "Slider_Jump_Power",
	Desc = "How high you jump",
	Step = 1,
	Value = { Min = 50, Max = 200, Default = 50 },
	Callback = function(arg)
		fn17(arg)
	end,
})

tbl11.player:Section({ Title = "Escape & Defense" })

tbl.el.antifling = tbl11.player:Toggle({
	Title = "Anti-Fling",
	Flag = "Toggle_Anti_Fling",
	Desc = "Blocks other players from flinging you. On by default.",
	Type = "Toggle",
	Value = true,
	Callback = function(arg)
		flag11 = arg

		if arg then
			fn24()
			v:Notify({ Title = "Anti-Fling ON", Content = "Fling protection on!", Duration = 2, Icon = "shield" })
		else
			fn25()

			v:Notify({
				Title = "Anti-Fling OFF",
				Content = "Fling protection off.",
				Duration = 2,
				Icon = "power-off",
			})
		end
	end,
})

tbl.el.noclip = tbl11.player:Toggle({
	Title = "Noclip",
	Flag = "Toggle_Noclip",
	Desc = "Walk through walls",
	Type = "Toggle",
	Value = false,
	Callback = function(arg)
		flag8 = arg

		if arg then
			fn18()
		else
			fn19()
		end

		if tbl2 then
			tbl2.setActive("Noclip", arg)
		end
	end,
})

tbl.el.infjump = tbl11.player:Toggle({
	Title = "Infinite Jump",
	Flag = "Toggle_Infinite_Jump",
	Desc = "Jump as many times as you want mid-air",
	Type = "Toggle",
	Value = false,
	Callback = function(arg)
		flag10 = arg

		if arg then
			fn22()
		else
			fn23()
		end
	end,
})

tbl.el.fly = tbl11.player:Toggle({
	Title = "Fly",
	Flag = "Toggle_Fly",
	Desc = "Fly around the map freely. WASD + Space / LeftShift",
	Type = "Toggle",
	Value = false,
	Callback = function(arg)
		flag9 = arg

		if arg then
			fn20()
		else
			fn21()
		end

		if tbl2 then
			tbl2.setActive("Fly", arg)
		end
	end,
})

tbl11.player:Slider({
	Title = "Fly Speed",
	Flag = "Slider_Fly_Speed",
	Desc = "How fast you fly",
	Step = 1,
	Value = { Min = 10, Max = 200, Default = 50 },
	Callback = function(arg)
		n = arg
	end,
})

tbl11.player:Section({ Title = "Beta" })

tbl11.player:Button({
	Title = "God Mode  [BETA]",
	Desc = "Nothing can kill you - but you cannot pick up coins or the gun. Needs a round in progress.",
	Callback = function()
		tbl.godMode()
	end,
})

fn50("God Mode  [BETA]", Color3.fromHex("#FDE68A"))
fn52(ICON.mono)
tbl11.crosshair:Section({ Title = "Sheriff Crosshair" })

tbl11.crosshair:Toggle({
	Title = "Spin Cursor",
	Flag = "Toggle_Spin_Cursor",
	Desc = "Slowly rotates the crosshair image.",
	Type = "Toggle",
	Value = false,
	Callback = fn48(function(spin)
		tbl10.spin = spin
	end),
})

tbl11.crosshair:Slider({
	Title = "Crosshair Size",
	Flag = "Slider_Crosshair_Size",
	Desc = "Size in pixels.",
	Step = 1,
	Value = { Min = 12, Max = 80, Default = 50 },
	Callback = fn48(function(size)
		tbl10.size = size

		if v6 then
			v6.Size = UDim2.fromOffset(size, size)
		end
	end),
})

CURSOR_ORDER = {
	"Default",
	"Hello Kitty",
	"Kitty v2",
	"Clean Kitty",
	"Evil Kitty",
	"Kuromi",
	"Pixel Cat",
	"Paw",
	"Cat",
	"Heart",
	"Red Heart",
	"Green Heart",
	"Blue Heart",
	"Yellow Heart",
	"Heart Cross",
	"Star",
	"Star v2",
	"Pink Star",
	"Power Star",
	"Cross",
	"Pentagram",
	"Gengar",
	"Bunny",
	"Vamp Face",
	"Osu",
	"Troll",
	"Glowing Circle",
	"Donut",
	"Blue Donut",
	"Death",
	"Bear",
	"Barbie",
	"Shoot this guy",
}

do
	local tbl13 = {}
	local v7 = tbl11.crosshair:Paragraph({ Title = "Crosshair", Desc = "" })

	local function fn53()
		for k, v8 in pairs(tbl13) do
			local flag16 = k == tbl10.style
			v8.stroke.Color = flag16 and ICON.pink or Color3.fromRGB(255, 255, 255)
			v8.stroke.Transparency = flag16 and 0.1 or 0.85
			v8.label.TextColor3 = flag16 and Color3.fromRGB(240, 240, 246) or Color3.fromRGB(150, 150, 160)
		end
	end

	local v8 = fn51(v7)

	if not v8 then
		warn("[ONYX] couldn't reach the Paragraph container - cursor grid skipped")
	else
		local v9 = math.ceil(#CURSOR_ORDER / 4)
		local frame = Instance.new("Frame")
		frame.Name = "OnyxCursorGrid"
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 0, v9 * 84 + (v9 - 1) * 6)
		frame.Parent = v8
		local uiGridLayout = Instance.new("UIGridLayout")
		uiGridLayout.CellSize = UDim2.fromOffset(84, 84)
		uiGridLayout.CellPadding = UDim2.fromOffset(6, 6)
		uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		uiGridLayout.Parent = frame

		local function fn54()
			frame.Size = UDim2.new(1, 0, 0, uiGridLayout.AbsoluteContentSize.Y)
		end

		uiGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(fn54)
		fn54()

		for i, v10 in ipairs(CURSOR_ORDER) do
			local textButton = Instance.new("TextButton")
			textButton.Name = v10
			textButton.LayoutOrder = i
			textButton.Text = ""
			textButton.AutoButtonColor = false
			textButton.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
			textButton.BackgroundTransparency = 0.25
			textButton.BorderSizePixel = 0
			textButton.Parent = frame
			Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 10)
			local uiStroke = Instance.new("UIStroke")
			uiStroke.Thickness = 1.5
			uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke.Parent = textButton
			local imageLabel = Instance.new("ImageLabel")
			imageLabel.BackgroundTransparency = 1
			imageLabel.AnchorPoint = Vector2.new(0.5, 0)
			imageLabel.Position = UDim2.new(0.5, 0, 0, 5)
			imageLabel.Size = UDim2.fromOffset(56, 56)
			imageLabel.Image = CURSORS[v10]
			imageLabel.ScaleType = Enum.ScaleType.Stretch
			imageLabel.Parent = textButton
			local textLabel = Instance.new("TextLabel")
			textLabel.BackgroundTransparency = 1
			textLabel.AnchorPoint = Vector2.new(0.5, 1)
			textLabel.Position = UDim2.new(0.5, 0, 1, -4)
			textLabel.Size = UDim2.new(1, -6, 0, 18)
			textLabel.Font = Enum.Font.GothamBold
			textLabel.TextSize = 10
			textLabel.TextWrapped = true
			textLabel.Text = v10
			textLabel.Parent = textButton

			textButton.MouseButton1Click:Connect(function()
				tbl10.style = v10
				fn47()
				fn53()
			end)

			tbl13[v10] = { tile = textButton, stroke = uiStroke, label = textLabel, img = imageLabel }
		end

		fn53()
	end
end

flag15 = true
fn47()
fn52(ICON.mono)
tbl11.settings:Section({ Title = "Interface" })

tbl.setOpacity = function(arg)
	local uiOpacity = math.clamp(tonumber(arg) or 60, 0, 100)
	tbl.uiOpacity = uiOpacity
	local n4 = 1 - uiOpacity / 100

	pcall(function()
		v2:SetBackgroundTransparency(n4)
	end)

	pcall(function()
		v2:SetBackgroundImageTransparency(n4 * 0.875)
	end)

	local opTok = (tbl.opTok or 0) + 1
	tbl.opTok = opTok

	task.delay(0.12, function()
		if tbl.opTok ~= opTok then
			return
		end

		pcall(function()
			local onyx = v.Themes and v.Themes.Onyx
			if not onyx then
				return
			end
			onyx.ElementBackgroundTransparency = math.min(n4 * 0.75, 0.6)
			v:SetTheme("Onyx")
		end)
	end)
end

tbl11.settings:Slider({
	Title = "UI Opacity",
	Flag = "Slider_UI_Opacity",
	Desc = "How solid the window is. 100 hides the game behind it completely, low turns it to glass.",
	Step = 1,
	Value = { Min = 0, Max = 100, Default = 60 },
	Callback = function(arg)
		tbl.setOpacity(tonumber(arg) or type(arg) == "table" and tonumber(arg.Value) or 60)
	end,
})

tbl11.settings:Section({ Title = "Server" })

tbl11.settings:Button({
	Title = "Server Hop",
	Desc = "Quickly join another server",
	Icon = "lucide:arrow-right-left",
	Callback = function()
		task.spawn(fn14)
	end,
})

tbl11.settings:Button({
	Title = "Smallest Server",
	Desc = "Join the server with the fewest players",
	Icon = "lucide:users",
	Callback = function()
		task.spawn(fn15)
	end,
})

tbl11.settings:Section({ Title = "Config" })
tbl.cfgName = ""

tbl.namedConfig = function(arg)
	local config = v2.ConfigManager:GetConfig(arg) or v2.ConfigManager:CreateConfig(arg)

	if config and tbl.config and tbl.config.Elements then
		config.Elements = tbl.config.Elements
	end

	return config
end

tbl.hudFileFor = function(arg)
	if not arg or arg == "" or arg == "autosave" then
		return tbl.hudFile
	end
	return tbl.hudDir .. "/" .. arg .. ".json"
end

tbl.hudSaveTo = function(arg)
	pcall(function()
		if writefile then
			local v7 = HttpService
			local jsonEncode = v7.JSONEncode
			local captureHud = tbl.captureHud
			writefile(tbl.hudFileFor(arg), jsonEncode(v7, captureHud()))
		end
	end)
end

tbl.hudLoadFrom = function(arg)
	pcall(function()
		local v7 = tbl.hudFileFor(arg)

		if isfile and isfile(v7) then
			local data = HttpService:JSONDecode(readfile(v7))

			if type(data) == "table" then
				tbl.hudPos = data
				tbl.applyHud()
			end
		end
	end)
end

tbl.namedList = function()
	local tbl13 = {}

	pcall(function()
		local v7 = ipairs
		local config = tbl.config and v2.ConfigManager:AllConfigs() or {}

		for _, v8 in v7(config) do
			if v8 ~= "autosave" and not tostring(v8):match("^onyx_hud") then
				tbl13[#tbl13 + 1] = v8
			end
		end
	end)

	return tbl13
end

tbl.el.cfgList = tbl11.settings:Dropdown({
	Title = "Saved Configs",
	Desc = "Pick one, then use Load or Delete",
	Multi = false,
	Value = nil,
	Values = tbl.namedList(),
	Callback = function(arg)
		tbl.cfgName = tostring(arg or "")
	end,
})

tbl.refreshCfgList = function()
	pcall(function()
		if tbl.el.cfgList and tbl.el.cfgList.Refresh then
			tbl.el.cfgList:Refresh(tbl.namedList())
		elseif tbl.el.cfgList and tbl.el.cfgList.SetValues then
			tbl.el.cfgList:SetValues(tbl.namedList())
		end
	end)
end

tbl.el.cfgInput = tbl11.settings:Input({
	Title = "Config Name",
	Desc = "Name to save under, or type an existing one to load/delete",
	Placeholder = "myconfig",
	Callback = function(arg)
		tbl.cfgName = tostring(arg or "")
	end,
})

tbl.DEFAULT_CFG = "Onyx_Default"

pcall(function()
	local config = v2.ConfigManager:GetConfig(tbl.DEFAULT_CFG) or v2.ConfigManager:CreateConfig(tbl.DEFAULT_CFG)

	if tbl.config and tbl.config.Elements then
		config.Elements = tbl.config.Elements
	end

	config:Save()
	local tbl13 = {}

	for k, v7 in next, tbl4, nil do
		tbl13[k] = { v7.X.Scale, v7.X.Offset, v7.Y.Scale, v7.Y.Offset }
	end

	if writefile then
		local v7 = HttpService
		local jsonEncode = v7.JSONEncode
		writefile(tbl.hudFileFor(tbl.DEFAULT_CFG), jsonEncode(v7, tbl13))
	end
end)

tbl.refreshCfgList()

tbl.cfgPick = function(arg)
	local str = (tbl.cfgName or ""):gsub("^%s+", ""):gsub("%s+$", "")
	if str == "" then
		v:Notify({ Title = "Config", Content = "Pick or type a name first.", Duration = 4, Icon = "x" })
		return nil
	end

	if str == "autosave" then
		v:Notify({
			Title = "Config",
			Content = "That name is reserved for the autosave.",
			Duration = 4,
			Icon = "x",
		})

		return nil
	end

	if str == tbl.DEFAULT_CFG and arg ~= "load" then
		v:Notify({
			Title = "Protected Config",
			Content = "Onyx_Default is the built-in fallback - it cannot be " .. (arg == "delete" and "deleted." or "overwritten."),
			Duration = 5,
			Icon = "shield",
		})

		return nil
	end

	return str
end

tbl.cfgApply = function(arg)
	if arg ~= tbl.DEFAULT_CFG then
		pcall(function()
			tbl.namedConfig(tbl.DEFAULT_CFG):Load()
		end)

		task.wait(0.35)
	end

	return (pcall(function()
		tbl.namedConfig(arg):Load()
	end))
end

tbl11.settings:Button({
	Title = "Load Config",
	Desc = "Applies the named config to every setting and button position.",
	Icon = "lucide:folder-open",
	Callback = function()
		local load = tbl.cfgPick("load")
		if not load then
			return
		end

		task.spawn(function()
			local v7 = tbl.cfgApply(load)
			tbl.hudLoadFrom(load)

			task.delay(1, function()
				pcall(tbl.saveNow)
			end)

			v:Notify({
				Title = v7 and "Config Loaded!" or "Config",
				Content = v7 and "Loaded " .. load or "Could not load that config.",
				Duration = 4,
				Icon = v7 and "check" or "x",
			})
		end)
	end,
})

tbl11.settings:Button({
	Title = "Save Config",
	Desc = "Writes your current settings and button positions to the name above.",
	Icon = "lucide:save",
	Callback = function()
		local save = tbl.cfgPick("save")
		if not save then
			return
		end

		local ok = pcall(function()
			tbl.namedConfig(save):Save()
		end)

		tbl.hudSaveTo(save)
		tbl.refreshCfgList()

		v:Notify({
			Title = ok and "Config Saved!" or "Config",
			Content = ok and "Saved as " .. save or "Could not save.",
			Duration = 4,
			Icon = ok and "check" or "x",
		})
	end,
})

tbl11.settings:Button({
	Title = "Delete Config",
	Desc = "Removes the named config. Leaves the autosave alone.",
	Icon = "lucide:trash",
	Callback = function()
		local delete = tbl.cfgPick("delete")
		if not delete then
			return
		end

		local ok = pcall(function()
			local config = v2.ConfigManager:GetConfig(delete)

			if config then
				config:Delete()
			else
				v2.ConfigManager:DeleteConfig(delete)
			end
		end)

		pcall(function()
			local v7 = tbl.hudFileFor(delete)

			if delfile and isfile and isfile(v7) then
				delfile(v7)
			end
		end)

		if tbl.cfgName == delete then
			tbl.cfgName = ""
		end

		tbl.refreshCfgList()

		v:Notify({
			Title = ok and "Config Deleted!" or "Config",
			Content = ok and delete .. " removed." or "Could not delete that config.",
			Duration = 4,
			Icon = ok and "check" or "x",
		})
	end,
})

tbl11.settings:Paragraph({
	Title = "Autosave Config",
	Desc = "Everything saves itself a couple of seconds after you change it and comes back next time you execute. Separate from the named configs above.",
})

tbl11.settings:Button({
	Title = "Delete Autosave Config",
	Desc = "Wipes the saved config and goes back to defaults on next execute",
	Icon = "lucide:trash-2",
	Callback = function()
		if not tbl.config then
			v:Notify({ Title = "Config", Content = "Nothing to delete.", Duration = 3, Icon = "x" })
			return
		end
		tbl.cfgWiped = true
		tbl.hudPos = {}

		local ok = pcall(function()
			tbl.config:Delete()
		end)

		pcall(function()
			if delfile and isfile and isfile(tbl.hudFile) then
				delfile(tbl.hudFile)
			end
		end)

		v:Notify({
			Title = ok and "Config Deleted!" or "Config",
			Content = ok and "Re-execute the script to come up on defaults." or "Could not delete the config file.",
			Duration = 6,
			Icon = ok and "check" or "x",
		})
	end,
})

fn50("Load Config", Color3.fromHex("#86EFAC"))
fn50("Save Config", Color3.fromHex("#FDE68A"))
fn50("Delete Config", Color3.fromHex("#FCA5A5"))
fn50("Delete Autosave Config", Color3.fromHex("#FCA5A5"))

local function onyxV2Cleanup()
	fn8()
	fn12()
	flag = false
	flag2 = false
	flag3 = false
	v3:Destroy()
	tbl.unreveal()
	flag8 = false
	flag9 = false
	flag10 = false
	flag11 = false
	fn19()
	fn21()
	fn23()
	fn25()
	fn16(16)
	fn17(50)
	fn28()
	fn30()
	fn32()
	tbl.stopShells()
	local v7 = ipairs
	local boxes = tbl.BOXES or {}

	for _, boxe in v7(boxes) do
		tbl.boxOn[boxe[1]] = false
	end

	tbl.stopFarmHopWatch()
	tbl.flingAllRunning = false
	tbl5.enabled = false
	tbl5.stop()
	fn46()
	fn37()

	pcall(function()
		if _G.__MM2Viz and _G.__MM2Viz.destroy then
			_G.__MM2Viz.destroy()
		end
	end)

	if keybindConn then
		pcall(function()
			keybindConn:Disconnect()
		end)

		keybindConn = nil
	end

	if v5 then
		pcall(function()
			v5:Disconnect()
		end)

		v5 = nil
	end

	if connection then
		pcall(function()
			connection:Disconnect()
		end)

		connection = nil
	end

	if connection2 then
		pcall(function()
			connection2:Disconnect()
		end)

		connection2 = nil
	end

	if connection4 then
		pcall(function()
			connection4:Disconnect()
		end)

		connection4 = nil
	end

	if connection3 then
		pcall(function()
			connection3:Disconnect()
		end)

		connection3 = nil
	end

	if connection5 then
		pcall(function()
			connection5:Disconnect()
		end)

		connection5 = nil
	end

	for _, v8 in ipairs(tbl3) do
		pcall(function()
			v8:Disconnect()
		end)
	end

	tbl3 = {}
	tbl2.destroyAll()
	fn49()

	pcall(function()
		if tbl.perf then
			tbl.perf.restoreAll()
		end
	end)

	pcall(function()
		if ROLEBOX then
			ROLEBOX.stop()
		end
	end)

	tbl.stopVelTracker()
	tbl.tr.stop()
	tbl.setXray(false)
	tbl.dropConns(tbl.conns)
	tbl.reclip(tbl.clipWas)
	tbl.reclip(tbl.farmClipWas)
	_G.OnyxSilentTarget = nil
end

v2:OnDestroy(function()
	tbl.farewell()
	onyxV2Cleanup()
	local tbl13 = {}

	pcall(function()
		local hui = gethui and gethui() or CoreGui

		for _, child in ipairs(hui:GetChildren()) do
			if child.Name == "WindUI" or child.Name:match("^WindUI/") then
				tbl13[#tbl13 + 1] = child
			end
		end
	end)

	task.delay(0.6, function()
		for _, v7 in ipairs(tbl13) do
			pcall(function()
				v7:Destroy()
			end)
		end
	end)

	if _G.OnyxV2 == v2 then
		_G.OnyxV2 = nil
	end

	if _G.OnyxV2Cleanup == onyxV2Cleanup then
		_G.OnyxV2Cleanup = nil
	end
end)

_G.OnyxV2Cleanup = onyxV2Cleanup
v2:Open()
tbl.pinOpenPill()
v2:SelectTab(1)

task.spawn(function()
	for i = 1, 60 do
		RunService.RenderStepped:Wait()

		if v2.CurrentTab ~= 1 then
			v2:SelectTab(1)
		end
	end
end)

tbl.captureHud = function()
	local tbl13 = {}

	for k, v7 in next, tbl.hudBtns, nil do
		if v7 and v7.Parent then
			local position = v7.Position
			tbl13[k] = { position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset }
		end
	end

	return tbl13
end

tbl.applyHud = function()
	for k, v7 in next, tbl.hudPos, nil do
		local v8 = tbl.hudBtns[k]

		if v8 and v8.Parent and type(v7) == "table" and #v7 == 4 then
			v8.Position = UDim2.new(v7[1], v7[2], v7[3], v7[4])
		end
	end
end

tbl.snapshot = function()
	if not tbl.config then
		return ""
	end

	local ok, result = pcall(function()
		return HttpService:JSONEncode({ data = tbl.config:GetData(), hud = tbl.captureHud() })
	end)

	return ok and result or ""
end

tbl.saveNow = function()
	if tbl.cfgWiped then
		return
	end

	pcall(function()
		if writefile then
			writefile(tbl.hudFile, HttpService:JSONEncode(tbl.captureHud()))
		end
	end)

	if tbl.config then
		pcall(function()
			tbl.config:Save()
		end)
	end

	tbl.cfgSnapshot = tbl.snapshot()
end

task.spawn(function()
	if not tbl.config then
		tbl.notifyReady = true
		tbl.sfxReady = true

		tbl.notifyNow({
			Title = "Config",
			Content = "ConfigManager unavailable - settings will not persist.",
			Duration = 5,
			Icon = "x",
		})

		return
	end

	pcall(function()
		return tbl.config:Load()
	end)

	tbl.applyHud()
	task.wait(1)
	tbl.cfgSnapshot = tbl.snapshot()
	tbl.notifyReady = true
	tbl.sfxReady = true

	while _G.OnyxV2 == v2 do
		task.wait(2)

		if not tbl.cfgWiped then
			local v7 = tbl.snapshot()

			if v7 ~= "" and v7 ~= tbl.cfgSnapshot then
				tbl.saveNow()
			end
		end
	end
end)

LOADUI.step(1, "Ready")
LOADUI.done()

tbl.notifyNow({
	Title = "Bragas v2",
	Content = "Loaded. G toggles the window. Invite copied - discord.gg/dCnvGNYANP",
	Duration = 10,
	Icon = "solar:planet-bold",
})

task.delay(1.5, function()
	pcall(function()
		tbl.card({
			title = "We have a Discord!",
			subtitle = "Report bugs, suggest features, ask questions",
			body = "Script not working correctly? Use the red Restore Settings button to reset all settings to their defaults.",
			actions = {
				{
					label = "Restore Settings",
					flex = 3,
					tint = Color3.fromHex("#E5484D"),
					callback = function()
						local ok = pcall(function()
							tbl.namedConfig(tbl.DEFAULT_CFG):Load()
						end)

						tbl.hudLoadFrom(tbl.DEFAULT_CFG)

						task.delay(1, function()
							pcall(tbl.saveNow)
						end)

						v:Notify({
							Title = ok and "Defaults Restored!" or "Restore Failed",
							Content = ok and "Every setting is back to how it ships." or "Could not load Onyx_Default.",
							Duration = 5,
							Icon = ok and "check" or "x",
						})
					end,
				},
				{ label = "Close", flex = 4 },
			},
		})
	end)
end)
