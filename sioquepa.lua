-- Тһіѕ Filе Ԝaѕ Dеоbfusсаtеԁ By lua-x
-- https://lua-x.online

-- [ lua-x ] loader: this script fetches https://github.com/Footagesus/WindUI/releases/download/1.6.66/main.lua at run time
task.spawn(function()
	repeat
		task.wait(0.2)
	until game:IsLoaded()

	local v1 = cloneref(game:GetService("Players"))
	local v2 = cloneref(game:GetService("ReplicatedStorage"))
	local v3 = cloneref(game:GetService("UserInputService"))
	local v4 = cloneref(game:GetService("RunService"))
	local v5 = cloneref(game:GetService("TweenService"))
	local v6 = cloneref(game:GetService("Stats"))
	local v7 = cloneref(game:GetService("Debris"))
	local v8 = cloneref(game:GetService("CoreGui"))
	local v9 = cloneref(game:GetService("HttpService"))
	local v10 = cloneref(game:GetService("Workspace"))
	local LocalPlayer = v1.LocalPlayer

	if not LocalPlayer then
		v1:GetPropertyChangedSignal("LocalPlayer"):Wait()
		LocalPlayer = v1.LocalPlayer
	end

	local function func()
		local ok, result = pcall(function()
			return gethui()
		end)
		return ok and result or v8
	end

	local tbl = {}

	local function func1(parent, arg2)
		local uIStroke = Instance.new("UIStroke")
		uIStroke.Thickness = arg2 or 2
		uIStroke.Color = Color3.fromRGB(255, 255, 255)
		uIStroke.Transparency = 0.1
		uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uIStroke.Parent = parent
		local uIGradient = Instance.new("UIGradient")

		uIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 60, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 60, 255)),
		})

		uIGradient.Rotation = 0
		uIGradient.Parent = uIStroke
		local connection

		connection = v4.RenderStepped:Connect(function(deltaTime)
			if not uIStroke.Parent then
				if connection then
					connection:Disconnect()
				end
				return
			end
			uIGradient.Rotation = (uIGradient.Rotation + deltaTime * 95) % 360
		end)

		table.insert(tbl, connection)
		return uIStroke, uIGradient
	end

	local function func2()
		-- key system removido, siempre válido
		return true
	end

	local function func3()
		local str = tostring(LocalPlayer.UserId)
		local tbl = {}

		pcall(function()
			if isfile and isfile("Aeris/key_session.json") then
				local v1 = v9:JSONDecode(readfile("Aeris/key_session.json"))
				if type(v1) == "table" then
					tbl = v1
				end
			end
		end)

		local v1 = tbl
		v1[str] = {key = "bLidikBol", timestamp = os.time()}

		pcall(function()
			if isfolder and makefolder and not isfolder("Aeris") then
				makefolder("Aeris")
			end
			if writefile then
				writefile("Aeris/key_session.json", v9:JSONEncode(v1 or {}))
			end
		end)
	end

	local function func4()
		pcall(function()
			local Aeris_SplashScreen = func():FindFirstChild("Aeris_SplashScreen")
			if Aeris_SplashScreen then
				Aeris_SplashScreen:Destroy()
			end
		end)

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "Aeris_SplashScreen"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 999999
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.Parent = func()
		local frame = Instance.new("Frame")
		frame.Name = "WhiteOverlay"
		frame.Size = UDim2.fromScale(1, 1)
		frame.Position = UDim2.fromScale(0, 0)
		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.ZIndex = 10
		frame.Parent = screenGui
		local frame1 = Instance.new("Frame")
		frame1.Name = "TopShadow"
		frame1.Size = UDim2.new(1, 0, 0, 120)
		frame1.Position = UDim2.fromScale(0, 0)
		frame1.BackgroundColor3 = Color3.fromRGB(165, 120, 230)
		frame1.BackgroundTransparency = 1
		frame1.BorderSizePixel = 0
		frame1.ZIndex = 11
		frame1.Parent = frame
		local uIGradient = Instance.new("UIGradient")
		uIGradient.Rotation = 90
		uIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1)})
		uIGradient.Parent = frame1
		local frame2 = Instance.new("Frame")
		frame2.Size = UDim2.fromOffset(320, 280)
		frame2.Position = UDim2.fromScale(0.5, 0.5)
		frame2.AnchorPoint = Vector2.new(0.5, 0.5)
		frame2.BackgroundTransparency = 1
		frame2.ZIndex = 12
		frame2.Parent = frame
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = "AerisLogo"
		imageLabel.Size = UDim2.fromOffset(150, 150)
		imageLabel.Position = UDim2.new(0.5, 0, 0, 80)
		imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = "rbxassetid://94398897297532"
		imageLabel.ImageTransparency = 1
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.ZIndex = 13
		imageLabel.Parent = frame2
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = "Title"
		textLabel.Size = UDim2.new(1, 0, 0, 48)
		textLabel.Position = UDim2.new(0.5, 0, 0, 195)
		textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = "Aeris."
		textLabel.Font = Enum.Font.GothamBlack
		textLabel.TextSize = 42
		textLabel.TextColor3 = Color3.fromRGB(120, 40, 210)
		textLabel.TextTransparency = 1
		textLabel.ZIndex = 13
		textLabel.Parent = frame2
		local textLabel1 = Instance.new("TextLabel")
		textLabel1.Name = "Subtitle"
		textLabel1.Size = UDim2.new(1, 0, 0, 30)
		textLabel1.Position = UDim2.new(0.5, 0, 0, 235)
		textLabel1.AnchorPoint = Vector2.new(0.5, 0.5)
		textLabel1.BackgroundTransparency = 1
		textLabel1.Text = "All for you"
		textLabel1.Font = Enum.Font.GothamBold
		textLabel1.TextSize = 22
		textLabel1.TextColor3 = Color3.fromRGB(60, 20, 110)
		textLabel1.TextTransparency = 1
		textLabel1.ZIndex = 13
		textLabel1.Parent = frame2
		local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		v5:Create(frame, tweenInfo, {BackgroundTransparency = 0}):Play()
		v5:Create(frame1, tweenInfo, {BackgroundTransparency = 0.15}):Play()
		v5:Create(imageLabel, tweenInfo, {ImageTransparency = 0, Size = UDim2.fromOffset(175, 175)}):Play()
		v5:Create(textLabel, tweenInfo, {TextTransparency = 0}):Play()
		v5:Create(textLabel1, tweenInfo, {TextTransparency = 0}):Play()
		task.wait(3.6)
		local tweenInfo1 = TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		local v1 = v5:Create(frame, tweenInfo1, {BackgroundTransparency = 1})
		v5:Create(frame1, tweenInfo1, {BackgroundTransparency = 1}):Play()
		v5:Create(imageLabel, tweenInfo1, {ImageTransparency = 1, Size = UDim2.fromOffset(145, 145)}):Play()
		v5:Create(textLabel, tweenInfo1, {TextTransparency = 1}):Play()
		v5:Create(textLabel1, tweenInfo1, {TextTransparency = 1}):Play()
		v1:Play()
		v1.Completed:Wait()
		screenGui:Destroy()
	end

	local function func5()
		local flag = false

		pcall(function()
			local Aeris_KeySystem = func():FindFirstChild("Aeris_KeySystem")
			if Aeris_KeySystem then
				Aeris_KeySystem:Destroy()
			end
		end)

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "Aeris_KeySystem"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 999998
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.Parent = func()
		local frame = Instance.new("Frame")
		frame.Name = "MainFrame"
		frame.Size = UDim2.fromOffset(0, 0)
		frame.Position = UDim2.fromScale(0.5, 0.5)
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.BackgroundColor3 = Color3.fromRGB(35, 18, 58)
		frame.BackgroundTransparency = 1
		frame.ClipsDescendants = true
		frame.Active = true
		frame.Draggable = true
		frame.Parent = screenGui
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
		local uIGradient = Instance.new("UIGradient")

		uIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(165, 110, 245)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 235, 255)),
		})

		uIGradient.Rotation = 45
		uIGradient.Parent = frame
		func1(frame, 2.5)
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, -30, 0, 36)
		textLabel.Position = UDim2.fromOffset(15, 16)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = "AERIS | KEY VERIFICATION"
		textLabel.Font = Enum.Font.GothamBlack
		textLabel.TextSize = 20
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextStrokeTransparency = 0.6
		textLabel.TextStrokeColor3 = Color3.fromRGB(90, 30, 160)
		textLabel.Parent = frame
		local textLabel1 = Instance.new("TextLabel")
		textLabel1.Size = UDim2.new(1, -40, 0, 38)
		textLabel1.Position = UDim2.fromOffset(20, 52)
		textLabel1.BackgroundTransparency = 1
		textLabel1.Text = "Warning: Your key resets every 24 hours and must be entered on each account."
		textLabel1.Font = Enum.Font.GothamMedium
		textLabel1.TextSize = 13
		textLabel1.TextWrapped = true
		textLabel1.TextColor3 = Color3.fromRGB(245, 230, 255)
		textLabel1.TextStrokeTransparency = 0.75
		textLabel1.Parent = frame
		local textBox = Instance.new("TextBox")
		textBox.Size = UDim2.new(1, -50, 0, 44)
		textBox.Position = UDim2.fromOffset(25, 102)
		textBox.BackgroundColor3 = Color3.fromRGB(80, 40, 130)
		textBox.BackgroundTransparency = 0.45
		textBox.Text = ""
		textBox.PlaceholderText = "Enter your key here (case & space sensitive)..."
		textBox.PlaceholderColor3 = Color3.fromRGB(220, 200, 240)
		textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		textBox.Font = Enum.Font.GothamBold
		textBox.TextSize = 14
		textBox.ClearTextOnFocus = false
		textBox.Parent = frame
		Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 10)
		func1(textBox, 1.6)
		local textLabel2 = Instance.new("TextLabel")
		textLabel2.Size = UDim2.new(1, -50, 0, 22)
		textLabel2.Position = UDim2.fromOffset(25, 152)
		textLabel2.BackgroundTransparency = 1
		textLabel2.Text = ""
		textLabel2.Font = Enum.Font.GothamBold
		textLabel2.TextSize = 13
		textLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel2.Parent = frame
		local textButton = Instance.new("TextButton")
		textButton.Name = "VerifyButton"
		textButton.Size = UDim2.new(0.44, 0, 0, 44)
		textButton.Position = UDim2.new(0.05, 0, 0, 182)
		textButton.BackgroundColor3 = Color3.fromRGB(130, 60, 220)
		textButton.BackgroundTransparency = 0.5
		textButton.Text = "Verify"
		textButton.Font = Enum.Font.GothamBold
		textButton.TextSize = 15
		textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		textButton.AutoButtonColor = true
		textButton.Parent = frame
		Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 10)
		func1(textButton, 1.8)
		local textButton1 = Instance.new("TextButton")
		textButton1.Name = "GetKeyButton"
		textButton1.Size = UDim2.new(0.44, 0, 0, 44)
		textButton1.Position = UDim2.new(0.51, 0, 0, 182)
		textButton1.BackgroundColor3 = Color3.fromRGB(130, 60, 220)
		textButton1.BackgroundTransparency = 0.5
		textButton1.Text = "Get Key"
		textButton1.Font = Enum.Font.GothamBold
		textButton1.TextSize = 15
		textButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
		textButton1.AutoButtonColor = true
		textButton1.Parent = frame
		Instance.new("UICorner", textButton1).CornerRadius = UDim.new(0, 10)
		func1(textButton1, 1.8)

		v5:Create(
			frame,
			TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{Size = UDim2.fromOffset(440, 248), BackgroundTransparency = 0.25}
		):Play()

		textButton1.MouseButton1Click:Connect(function()
			pcall(function()
				setclipboard("https://discord.gg/t6rhaAZvhG")
			end)

			textLabel2.TextColor3 = Color3.fromRGB(235, 210, 255)
			textLabel2.Text = "Copied key link! (https://discord.gg/t6rhaAZvhG)"
		end)

		textButton.MouseButton1Click:Connect(function()
			if textBox.Text == "bLidikBol" then
				textLabel2.TextColor3 = Color3.fromRGB(180, 255, 200)
				textLabel2.Text = "Key verified! Loading Aeris..."
				func3()

				local v1 = v5:Create(
					frame,
					TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In),
					{Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}
				)

				v1:Play()
				v1.Completed:Wait()
				screenGui:Destroy()
				flag = true
			else
				textLabel2.TextColor3 = Color3.fromRGB(255, 120, 140)
				textLabel2.Text = "Invalid key! Check spaces and uppercase/lowercase letters."
			end
		end)

		repeat
			task.wait(0.1)
		until flag
	end

	if not func2() then
		func5()
	end

	func4()

	task.spawn(function()
		while task.wait(60) do
			if not func2() then
				pcall(function()
					LocalPlayer:Kick("[Aeris] Your 24-hour key session has expired. Please re-inject and enter your key again.")
				end)
				break
			end
		end
	end)

	local module = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/1.6.66/main.lua"))()

	pcall(function()
		module:AddTheme({
			Name = "Aeris Purple",
			Accent = Color3.fromRGB(170, 85, 255),
			Background = Color3.fromRGB(24, 14, 38),
			Outline = Color3.fromRGB(235, 215, 255),
			Text = Color3.fromRGB(255, 255, 255),
			Button = Color3.fromRGB(52, 28, 82),
			Icon = Color3.fromRGB(200, 140, 255),
		})
	end)

	local tbl1 = {
		Title = "AERIS HUB | AERIS",
		Icon = "rbxassetid://94398897297532",
		Author = "Aeris. All for you",
		Folder = "AERIS_WINDUI",
		Size = UDim2.fromOffset(600, 480),
		Theme = "Aeris Purple",
		Transparent = true,
		HasOutline = true,
	}

	local Window = module:CreateWindow(tbl1)

	pcall(function()
		Window:EditOpenButton({Enabled = false})
	end)

	task.spawn(function()
		task.wait(0.5)
		pcall(function()
			for _, child in pairs(func():GetChildren()) do
				if child:IsA("ScreenGui") and child.Name ~= "Aeris_WindUI_Toggle" then
					for _, descendant in pairs(child:GetDescendants()) do
						if descendant:IsA("UIStroke") and descendant.Thickness >= 1 then
							local v1 = descendant:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient", descendant)

							v1.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 60, 255)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 60, 255)),
							})

							task.spawn(function()
								while descendant.Parent do
									v1.Rotation = (v1.Rotation + 2) % 360
									task.wait(0.03)
								end
							end)
						end
					end
				end
			end
		end)
	end)

	pcall(function()
		local Aeris_WindUI_Toggle = func():FindFirstChild("Aeris_WindUI_Toggle")
		if Aeris_WindUI_Toggle then
			Aeris_WindUI_Toggle:Destroy()
		end
	end)

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "Aeris_WindUI_Toggle"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.Parent = func()
	local textButton = Instance.new("TextButton")
	textButton.Name = "MenuToggle"
	textButton.Size = UDim2.fromOffset(56, 56)
	textButton.Position = UDim2.new(0, 15, 0.5, -28)
	textButton.BackgroundColor3 = Color3.fromRGB(235, 220, 255)
	textButton.BackgroundTransparency = 0.15
	textButton.Text = ""
	textButton.AutoButtonColor = true
	textButton.ZIndex = 100
	textButton.Parent = screenGui
	Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 14)
	func1(textButton, 2.2)
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "LogoIcon"
	imageLabel.Size = UDim2.fromScale(0.76, 0.76)
	imageLabel.Position = UDim2.fromScale(0.5, 0.5)
	imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Image = "rbxassetid://94398897297532"
	imageLabel.ScaleType = Enum.ScaleType.Fit
	imageLabel.ZIndex = 101
	imageLabel.Parent = textButton
	local flag = true
	local flag1 = false
	local v18
	local Position
	local Position1
	local flag2 = false

	textButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag2 = false
			flag1, Position = true, input.Position
			Position1 = textButton.Position
		end
	end)

	textButton.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			v18 = input
		end
	end)

	textButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag1 = false
			if not flag2 then
				flag = not flag
				pcall(function()
					if flag then
						Window:Open()
					else
						Window:Close()
					end
				end)
			end
		end
	end)

	v3.InputChanged:Connect(function(input)
		if input == v18 and flag1 then
			local v1 = input.Position - Position

			if math.abs(v1.X) > 4 or math.abs(v1.Y) > 4 then
				flag2 = true
			end

			textButton.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v1.X, Position1.Y.Scale, Position1.Y.Offset + v1.Y)
		end
	end)

	getgenv().Aeris_WindUI_ToggleButton = textButton

	function Window:AddTab(arg2)
		local v1 = self:Tab({Title = arg2.Title, Icon = arg2.Icon})

		function v1:AddSection(arg2, arg3)
			pcall(function()
				self:Section({Title = arg2, Icon = arg3})
			end)
			return {
				AddToggle = function(arg1, _, arg3)
					return arg1 and v1:Toggle({Title = arg3.Title, Desc = arg3.Description, Value = arg3.Default, Callback = arg3.Callback})
				end,
				AddDropdown = function(_, _, arg3)
					return v1:Dropdown({
						Title = arg3.Title,
						Desc = arg3.Description,
						Values = arg3.Values,
						Value = arg3.Default,
						Multi = arg3.Multi,
						Callback = arg3.Callback,
					})
				end,
				AddSlider = function(_, _, arg3)
					return v1:Slider({
						Title = arg3.Title,
						Desc = arg3.Description,
						Value = {Min = arg3.Min, Max = arg3.Max, Default = arg3.Default},
						Rounding = arg3.Rounding,
						Callback = arg3.Callback,
					})
				end,
				AddInput = function(_, _, arg3)
					return v1:Input({
						Title = arg3.Title,
						Desc = arg3.Description,
						Placeholder = arg3.Placeholder,
						Value = arg3.Default,
						Callback = arg3.Callback,
					})
				end,
				AddKeybind = function(_, _, arg3)
					return v1:Keybind({
						Title = arg3.Title,
						Desc = arg3.Description,
						Value = arg3.Default,
						Callback = arg3.Callback,
						ChangedCallback = arg3.ChangedCallback,
					})
				end,
			}
		end

		return v1
	end

	local Tabs = {
		Rage = Window:AddTab({Title = "Autoparry", Icon = "sword"}),
		Spam = Window:AddTab({Title = "Spam", Icon = "skull"}),
		Detection = Window:AddTab({Title = "Detection", Icon = "eye"}),
		Visuals = Window:AddTab({Title = "Visuals", Icon = "monitor"}),
		Misc = Window:AddTab({Title = "Misc", Icon = "settings"}),
		Dash = Window:AddTab({Title = "Dash", Icon = "zap"}),
		Discord = Window:AddTab({Title = "Discord", Icon = "message-circle"}),
		Settings = Window:AddTab({Title = "Settings", Icon = "sliders"}),
	}

	getgenv().Aeris_DashEnabled = getgenv().Aeris_DashEnabled ~= false
	getgenv().Aeris_DashPower = getgenv().Aeris_DashPower or 45
	getgenv().Aeris_DashVertical = getgenv().Aeris_DashVertical or 0
	getgenv().Aeris_DashKey = getgenv().Aeris_DashKey or Enum.KeyCode.Q
	getgenv().Aeris_DashCooldown = getgenv().Aeris_DashCooldown or 0.25
	getgenv().Aeris_dashLast = getgenv().Aeris_dashLast or 0

	getgenv().Aeris_DoDash = function()
		if tick() - getgenv().Aeris_dashLast < getgenv().Aeris_DashCooldown then
			return
		end

		getgenv().Aeris_dashLast = tick()
		local Character = LocalPlayer.Character
		local v1 = Character and Character:FindFirstChild("HumanoidRootPart")
		local CurrentCamera = v10.CurrentCamera

		if not v1 or not CurrentCamera then
			return
		end

		local vector3 = Vector3.new(CurrentCamera.CFrame.LookVector.X, 0, CurrentCamera.CFrame.LookVector.Z)

		if vector3.Magnitude < 0.01 then
			return
		end

		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
		bodyVelocity.Velocity = vector3.Unit * getgenv().Aeris_DashPower + Vector3.new(0, getgenv().Aeris_DashVertical, 0)
		bodyVelocity.P = 20000
		bodyVelocity.Parent = v1
		v7:AddItem(bodyVelocity, 0.15)
	end

	v3.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and getgenv().Aeris_DashEnabled and input.KeyCode == getgenv().Aeris_DashKey then
			getgenv().Aeris_DoDash()
		end
	end)

	local dashSettingsSection = Tabs.Dash:AddSection("Dash Settings", "zap")

	dashSettingsSection:AddToggle("AerisDashEnabled", {
		Title = "Dash Enabled",
		Description = "Enable dash hotkey",
		Default = true,
		Callback = function(value)
			getgenv().Aeris_DashEnabled = value
		end,
	})

	dashSettingsSection:AddSlider("AerisDashPower", {
		Title = "Dash Power",
		Description = "Movement strength",
		Default = 45,
		Min = 10,
		Max = 200,
		Rounding = 0,
		Callback = function(value)
			getgenv().Aeris_DashPower = value
		end,
	})

	dashSettingsSection:AddSlider("AerisDashVertical", {
		Title = "Dash Height",
		Description = "Vertical force",
		Default = 0,
		Min = 0,
		Max = 100,
		Rounding = 0,
		Callback = function(value)
			getgenv().Aeris_DashVertical = value
		end,
	})

	dashSettingsSection:AddSlider("AerisDashCooldown", {
		Title = "Dash Cooldown",
		Description = "Delay between dashes",
		Default = 0.25,
		Min = 0,
		Max = 2,
		Rounding = 2,
		Callback = function(value)
			getgenv().Aeris_DashCooldown = value
		end,
	})

	dashSettingsSection:AddDropdown("AerisDashKey", {
		Title = "Dash Key",
		Values = {"Q", "E", "F", "LeftShift", "C", "V", "X"},
		Default = "Q",
		Multi = false,
		Callback = function(value)
			getgenv().Aeris_DashKey = Enum.KeyCode[value] or Enum.KeyCode.Q
		end,
	})

	Tabs.Discord:AddSection("Aeris Community", "message-circle")
	Tabs.Discord:Paragraph({Title = "Aeris.", Desc = "All for you — Unified WindUI Interface"})
	Tabs.Discord:Paragraph({Title = "Discord Invite", Desc = "https://discord.gg/t6rhaAZvhG"})

	Tabs.Discord:Button({
		Title = "Copy Discord Invite",
		Icon = "copy",
		Callback = function()
			pcall(function()
				setclipboard("https://discord.gg/t6rhaAZvhG")
			end)
			module:Notify({Title = "Discord", Content = "Invite link copied to clipboard!", Duration = 3})
		end,
	})

	if not LocalPlayer.Character then
		LocalPlayer.CharacterAdded:Wait()
	end

	local v11 = v10:FindFirstChild("Alive") or v10:WaitForChild("Alive")
	local Runtime = v10.Runtime

	local function func6()
		local TouchEnabled = v3.TouchEnabled
		local MouseEnabled = v3.MouseEnabled
		local KeyboardEnabled = v3.KeyboardEnabled

		if TouchEnabled and not KeyboardEnabled then
			return true
		end

		if TouchEnabled and not MouseEnabled then
			return true
		end

		return false
	end

	local tbl2 = {
		__autoparry_enabled = false,
		__triggerbot_enabled = false,
		__manual_spam_enabled = false,
		__auto_spam_enabled = false,
		__play_animation = false,
		__accuracy = 50,
		__divisor_multiplier = 1.1,
		__parried = false,
		__training_parried = false,
		__spam_threshold = 1.5,
		__parries = 0,
	}

	tbl2.__parry_key = nil
	tbl2.__grab_animation = nil
	tbl2.__tornado_time = tick()
	tbl2.__first_parry_done = false
	tbl2.__connections = {}
	tbl2.__reverted_remotes = {}
	tbl2.__spam_accumulator = 0
	tbl2.__spam_rate = 340
	tbl2.__infinity_active = false
	tbl2.__deathslash_active = false
	tbl2.__timehole_active = false
	tbl2.__slashesoffury_active = false
	tbl2.__slashesoffury_count = 0
	tbl2.__is_mobile = func6()
	tbl2.__mobile_guis = {}
	tbl2.__randomized_accuracy_enabled = false
	tbl2.__speed_display_enabled = false
	tbl2.__auto_jump_enabled = false
	tbl2.__ball_speed = 0
	tbl2.__peak_ball_speed = 0
	tbl2.__headless_enabled = false
	tbl2.__korblox_enabled = false
	tbl2.__thunder_dash_enabled = false
	tbl2.__ball_velocity_gui = nil
	tbl2.__ball_velocity_enabled = false
	tbl2.__peak_velocity = 0
	tbl2.__last_ball_id = nil
	tbl2.__ping_label = nil

	local tbl3 = {
		__properties = tbl2,
		__config = {
			__curve_names = {"Camera", "Random", "Accelerated", "Backwards", "Slow", "High", "Normal", "Speed", "Down"},
			__detections = {
				__infinity = false,
				__deathslash = false,
				__timehole = false,
				__slashesoffury = false,
				__phantom = false,
			},
		},
		__triggerbot = {
			__enabled = false,
			__is_parrying = false,
			__parries = 0,
			__max_parries = 10000,
			__parry_delay = 0.05,
		},
	}

	local tbl4 = {
		"Camera",
		"Random",
		"Accelerated",
		"Backwards",
		"Slow",
		"High",
		"Normal",
		"Speed",
		"Down",
		"Left",
		"Right",
	}

	local str = "Camera"
	local str1 = "Camera"

	local function func7()
		tbl3.__properties.__divisor_multiplier = 0.7 + (tbl3.__properties.__accuracy - 1) * 0.00909090909090909
	end

	local function func8()
		if not tbl3.__properties.__randomized_accuracy_enabled then
			return
		end

		local ValueString = v6.Network.ServerStatsItem["Data Ping"]:GetValueString()
		local v1 = tonumber(ValueString:match("%d+")) or 0
		local num

		if v1 >= 90 then
			num = 4
		elseif v1 <= 50 then
			num = math.random(70, 100)
		else
			num = tbl3.__properties.__accuracy
		end

		if num then
			tbl3.__properties.__accuracy = num
			func7()
		end
	end

	task.spawn(function()
		while task.wait(1) do
			if tbl3.__properties.__randomized_accuracy_enabled then
				func8()
			end
		end
	end)

	local v12 = cloneref(game:GetService("ReplicatedStorage"))
	local v13 = cloneref(game:GetService("Workspace"))
	local v16
	local flag3 = false

	for _, v14 in getgc(true) do
		if type(v14) == "function" and debug.info(v14, "s"):find("PRY", 1, true) then
			for _, v15 in debug.getupvalues(v14) do
				if type(v15) == "function" then
					v16 = v15
					flag3 = true
					break
				end
			end
			if v16 then
				break
			end
		end
	end

	if not flag3 then
		module:Notify({Title = "Aeris Hub", Content = "Token not found! Re-inject and try again.", Duration = 5})
		return
	end

	function _tokenize(arg1)
		local str = tostring(math.floor(v13:GetServerTimeNow() * 100))
		local v1 = v16(arg1, "TIME")
		local v2 = #str
		local v3 = table.create(v2)

		for i = 1, #str do
			local char = string.char
			local bxor = bit32.bxor
			local v4 = (string.byte(str, i) + i) % 256
			local byte = string.byte
			local v5 = #v1
			v3[i] = char(bxor(v4, byte(v1, (i - 1) % v5 + 1)))
		end

		return table.concat(v3)
	end

	local tbl5 = {}
	local tbl6 = {}
	local v19
	local v20
	local func9

	func9, _is_valid = function(arg1)
		if not arg1 then
			return
		end

		if tbl5[arg1] then
			return
		end

		if tbl6[getrawmetatable(arg1)] then
			return
		end

		tbl6[getrawmetatable(arg1)] = true
		local v1 = getrawmetatable(arg1)
		setreadonly(v1, false)
		local __index = v1.__index

		function v1.__index(arg1, arg2)
			if arg2 == "FireServer" and arg1:IsA("RemoteEvent") or arg2 == "InvokeServer" and arg1:IsA("RemoteFunction") then
				return function(arg3, ...)
					local tbl = {...}

					if _is_valid(tbl) then
						if not tbl5[arg1] then
							tbl5[arg1] = tbl
							v19 = arg1
							v20 = tbl
						end
					end

					return __index(arg1, arg2)(arg3, unpack(tbl))
				end
			end
			return __index(arg1, arg2)
		end

		setreadonly(v1, true)
	end, function(arg1)
		if not arg1 or #arg1 < 8 then
			return false
		end
		return true
	end

	_hook = func9

	for _, descendant in pairs(v12:GetDescendants()) do
		if descendant:IsA("RemoteEvent") or descendant:IsA("RemoteFunction") then
			_hook(descendant)
		end
	end

	task.wait(5)

	task.spawn(function()
		local num = 0

		while not v19 and num < 30 do
			task.wait(1)
			num = num + 1
		end

		if v19 then
			module:Notify({Title = "Aeris Hub", Content = "Anti-cheat Bypassed ✓", Duration = 3})
		else
			module:Notify({Title = "Aeris Hub", Content = "Remote not found! Please parry once manually.", Duration = 5})
		end
	end)

	local function func10(arg1)
		if not v19 or not v20 then
			return false
		end

		local CurrentCamera = v10.CurrentCamera
		local tbl

		if tbl3.__properties.__is_mobile then
			local ViewportSize = CurrentCamera.ViewportSize
			tbl = {math.floor(ViewportSize.X / 2), math.floor(ViewportSize.Y / 2)}
		else
			local ok, result = pcall(function()
				return v3:GetMouseLocation()
			end)
			if ok and result then
				tbl = {math.floor(result.X), math.floor(result.Y)}
			else
				local ViewportSize1 = CurrentCamera.ViewportSize
				tbl = {math.floor(ViewportSize1.X / 2), math.floor(ViewportSize1.Y / 2)}
			end
		end

		local tbl1 = {}

		if v11 then
			for _, child in pairs(v11:GetChildren()) do
				if child.PrimaryPart then
					local ok1, result1 = pcall(function()
						return CurrentCamera:WorldToScreenPoint(child.PrimaryPart.Position)
					end)
					if ok1 then
						tbl1[child.Name] = result1
					end
				end
			end
		end

		local tbl2 = {}
		tbl2[8], tbl2[6], tbl2[2], tbl2[7], tbl2[1], tbl2[3], tbl2[5], tbl2[4] = false, tbl1, v20[2], tbl, v20[1], _tokenize(v20[2]), arg1 or CurrentCamera.CFrame, 0.5

		pcall(function()
			if v19:IsA("RemoteEvent") then
				v19:FireServer(unpack(tbl2))
			elseif v19:IsA("RemoteFunction") then
				v19:InvokeServer(unpack(tbl2))
			end
		end)

		return true
	end

	tbl3.animation = {}
	local SwordAPI = v2:WaitForChild("Shared"):WaitForChild("SwordAPI")
	local num = 0
	local flag4 = false
	local v21
	local tbl7 = {}

	local function func11(arg1)
		if not arg1 or arg1 == "" then
			return SwordAPI.Collection.Default:FindFirstChild("GrabParry")
		end

		if tbl7[arg1] then
			return tbl7[arg1]
		end

		local ok, result = pcall(function()
			return v2.Shared.ReplicatedInstances.Swords.GetSword:Invoke(arg1)
		end)

		if not ok or not result or type(result) ~= "table" or not result.AnimationType then
			tbl7[arg1] = SwordAPI.Collection.Default:FindFirstChild("GrabParry")
			return tbl7[arg1]
		end

		for _, child in pairs(SwordAPI.Collection:GetChildren()) do
			if child.Name == result.AnimationType then
				local v1 = child:FindFirstChild("GrabParry") or child:FindFirstChild("Grab")
				if v1 then
					tbl7[arg1] = v1
					return v1
				end
			end
		end

		tbl7[arg1] = SwordAPI.Collection.Default:FindFirstChild("GrabParry")
		return tbl7[arg1]
	end

	function tbl3.animation.play_grab_parry()
		if not tbl3.__properties.__play_animation then
			return
		end

		if not (os.clock() - num >= 0.19999999999999996 or flag4) then
			return
		end

		num = os.clock()
		flag4 = false
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if not Humanoid then
			return
		end

		local v1

		if getgenv().skinChanger then
			v1 = getgenv().swordAnimations ~= "" and getgenv().swordAnimations or getgenv().swordModel ~= "" and getgenv().swordModel or Character:GetAttribute("CurrentlyEquippedSword")
		else
			v1 = Character:GetAttribute("CurrentlyEquippedSword")
		end

		local v2 = func11(v1)

		if not v2 then
			return
		end

		for _, track in pairs(Humanoid.Animator:GetPlayingAnimationTracks()) do
			if track.Name == "GrabParry" or track.Name == "Grab" then
				track.TimePosition = 0
				if track then
					pcall(function()
						track:Stop(track:GetAttribute("StopFadeTime") or 0.1)
					end)
				end
			elseif track.Name == "SuccessParry" or track.Name == "Success" then
				if track then
					pcall(function()
						track:Stop(track:GetAttribute("StopFadeTime") or 0.1)
					end)
				end
			end
		end

		v21 = Humanoid.Animator:LoadAnimation(v2)
		local v3 = v21

		if v3 then
			pcall(function()
				v3:Play(
					v3:GetAttribute("PlayFadeTime") or 0,
					v3:GetAttribute("PlayWeight") or 1,
					v3:GetAttribute("PlaySpeed") or 1
				)
			end)
		end
	end

	pcall(function()
		v2.Remotes.ParrySuccessAll.OnClientEvent:Connect(function()
			flag4 = true
			local Character = LocalPlayer.Character

			if not Character then
				return
			end

			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if not Humanoid then
				return
			end

			for _, track in pairs(Humanoid.Animator:GetPlayingAnimationTracks()) do
				if track.Name == "GrabParry" or track.Name == "Grab" then
					if track then
						pcall(function()
							track:Stop(track:GetAttribute("StopFadeTime") or 0.1)
						end)
					end
				end
			end
		end)
	end)

	tbl3.ball = {}

	function tbl3.ball.get()
		local Balls = v10:FindFirstChild("Balls")

		if not Balls then
			return nil
		end

		for _, child in pairs(Balls:GetChildren()) do
			if child:GetAttribute("realBall") then
				child.CanCollide = false
				return child
			end
		end

		return nil
	end

	function tbl3.ball.get_all()
		local tbl = {}
		local Balls = v10:FindFirstChild("Balls")

		if not Balls then
			return tbl
		end

		for _, child in pairs(Balls:GetChildren()) do
			if child:GetAttribute("realBall") then
				child.CanCollide = false
				table.insert(tbl, child)
			end
		end

		return tbl
	end

	tbl3.player = {}
	local v22
	local num1 = 0

	function tbl3.player.get_closest()
		local v1 = tick()

		if v1 - num1 < 0.1 then
			return v22
		end

		num1 = v1
		local huge = math.huge
		local v3

		if not v11 then
			return nil
		end

		for _, child in pairs(v11:GetChildren()) do
			if child ~= LocalPlayer.Character and child.PrimaryPart then
				local v2 = LocalPlayer:DistanceFromCharacter(child.PrimaryPart.Position)
				if v2 < huge then
					v3 = child
					huge = v2
				end
			end
		end

		v22 = v3
		return v3
	end

	tbl3.curve = {}

	function tbl3.curve.get_cframe()
		local CurrentCamera = v10.CurrentCamera
		local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local v2 = v1 and v1.Position or CurrentCamera.CFrame.Position
		local PrimaryPart
		local huge = math.huge
		local v4 = not tbl3.__properties.__is_mobile and v3:GetMouseLocation() or nil

		if v11 then
			for _, child in pairs(v11:GetChildren()) do
				if child ~= LocalPlayer.Character and child.PrimaryPart then
					local v5, v6 = CurrentCamera:WorldToScreenPoint(child.PrimaryPart.Position)
					if v6 then
						local Magnitude

						if v4 then
							Magnitude = (Vector2.new(v5.X, v5.Y) - v4).Magnitude
						else
							local new = Vector2.new
							local X = CurrentCamera.ViewportSize.X
							local ViewportSize = CurrentCamera.ViewportSize
							local v7 = new(X / 2, ViewportSize.Y / 2)
							Magnitude = (Vector2.new(v5.X, v5.Y) - v7).Magnitude
						end

						if Magnitude < huge then
							PrimaryPart = child.PrimaryPart
							huge = Magnitude
						end
					end
				end
			end
		end

		local v8 = PrimaryPart and PrimaryPart.Position or v2 + CurrentCamera.CFrame.LookVector * 100
		local v9 = str
		local CFrame1

		if v9 == "Camera" then
			CFrame1 = CurrentCamera.CFrame
		elseif v9 == "Random" then
			local num = 0
			local Unit = (v8 - v2).Unit
			local vector3

			repeat
				vector3 = Vector3.new(math.random(-4000, 4000), math.random(-4000, 4000), math.random(-4000, 4000))
				local v12 = Unit:Dot((v8 + vector3 - v2).Unit)
				num = num + 1
			until v12 < 0.95 or num > 10

			local v13 = v8 + vector3
			CFrame1 = CFrame.new(v2, v13)
		elseif v9 == "Accelerated" then
			CFrame1 = CFrame.new(v2, v8 + Vector3.new(0, 5, 0))
		elseif v9 == "Backwards" then
			local v14 = v2 + (v2 - v8).Unit * 10000 + Vector3.new(0, 1000, 0)
			CFrame1 = CFrame.new(CurrentCamera.CFrame.Position, v14)
		elseif v9 == "Slow" then
			CFrame1 = CFrame.new(v2, v8 + Vector3.new(0, -9000000000000000000, 0))
		elseif v9 == "High" then
			CFrame1 = CFrame.new(v2, v8 + Vector3.new(0, 9000000000000000000, 0))
		elseif v9 == "Normal" then
			CFrame1 = CFrame.new(v2, v2 + (v1 and v1.CFrame.LookVector or CurrentCamera.CFrame.LookVector))
		elseif v9 == "Speed" then
			CFrame1 = CFrame.new(CurrentCamera.CFrame.Position, CurrentCamera.CFrame.Position + CurrentCamera.CFrame.UpVector * 5)
		elseif v9 == "Down" then
			CFrame1 = CFrame.new(
				CurrentCamera.CFrame.Position,
				CurrentCamera.CFrame.Position + CurrentCamera.CFrame.UpVector * -9000000000
			)
		elseif v9 == "Left" then
			CFrame1 = CFrame.new(
				CurrentCamera.CFrame.Position,
				CurrentCamera.CFrame.Position - CurrentCamera.CFrame.RightVector * 9000000000
			)
		elseif v9 == "Right" then
			CFrame1 = CFrame.new(
				CurrentCamera.CFrame.Position,
				CurrentCamera.CFrame.Position + CurrentCamera.CFrame.RightVector * 9000000000
			)
		else
			CFrame1 = CurrentCamera.CFrame
		end

		return CFrame1
	end

	tbl3.parry = {}

	function tbl3.parry.execute()
		if tbl3.__properties.__parries > 10000 or not LocalPlayer.Character then
			return
		end

		func10(tbl3.curve.get_cframe())

		if tbl3.__properties.__parries > 10000 then
			return
		end

		tbl3.__properties.__parries = tbl3.__properties.__parries + 1

		task.delay(0.5, function()
			if tbl3.__properties.__parries > 0 then
				tbl3.__properties.__parries = tbl3.__properties.__parries - 1
			end
		end)
	end

	function tbl3.parry.keypress()
		if tbl3.__properties.__parries > 10000 or not LocalPlayer.Character then
			return
		end

		func10(tbl3.curve.get_cframe())

		if tbl3.__properties.__parries > 10000 then
			return
		end

		tbl3.__properties.__parries = tbl3.__properties.__parries + 1

		task.delay(0.5, function()
			if tbl3.__properties.__parries > 0 then
				tbl3.__properties.__parries = tbl3.__properties.__parries - 1
			end
		end)
	end

	function tbl3.parry.execute_action()
		tbl3.animation.play_grab_parry()
		tbl3.parry.execute()
	end

	local function func12()
		tbl3.parry.keypress()
		if getgenv().AutoSpamAnimationFix then
			tbl3.animation.play_grab_parry()
		end
	end

	tbl3.detection = {
		__ball_properties = {__aerodynamic_time = tick(), __last_warping = tick(), __lerp_radians = 0, __curving = tick()},
	}

	function tbl3.detection.is_curved()
		local __ball_properties = tbl3.detection.__ball_properties
		local v1 = tbl3.ball.get()

		if not v1 then
			return false
		end

		local zoomies = v1:FindFirstChild("zoomies")

		if not zoomies then
			return false
		end

		local VectorVelocity = zoomies.VectorVelocity
		local Magnitude = VectorVelocity.Magnitude

		if Magnitude < 1 then
			return false
		end

		local Unit = VectorVelocity.Unit
		local Character = LocalPlayer.Character

		if not Character or not Character.PrimaryPart then
			return false
		end

		local Position = Character.PrimaryPart.Position
		local v2 = (Position - v1.Position).Unit:Dot(Unit)
		local Value = v6.Network.ServerStatsItem["Data Ping"]:GetValue()
		local Position1 = v1.Position
		local v3 = Value / 1000
		local Magnitude1 = (Position - Position1).Magnitude
		local v4 = Magnitude1 / Magnitude - v3
		local v5 = math.clamp(0.55 - v3 * 0.75, -1, 0.45)
		local v7 = math.min(Magnitude / 100, 45)
		local v8 = 15 - math.min(Magnitude1 / 1000, 15) + v7
		local v9 = math.clamp(v2, -1, 1)
		local v10 = math.asin(v9)
		local __lerp_radians = __ball_properties.__lerp_radians
		__ball_properties.__lerp_radians = __lerp_radians + (v10 - __lerp_radians) * 0.85

		if __ball_properties.__lerp_radians < 0.016 then
			__ball_properties.__last_warping = tick()
		end

		if Magnitude1 < v8 * 0.85 then
			return false
		end

		if tick() - __ball_properties.__last_warping < v4 / 1.4 then
			return true
		end

		if tick() - __ball_properties.__curving < v4 / 1.1 then
			return true
		end

		return v2 < v5
	end

	v2.Remotes.DeathBall.OnClientEvent:Connect(function(_, arg2)
		tbl3.__properties.__deathslash_active = arg2 or false
	end)

	v2.Remotes.InfinityBall.OnClientEvent:Connect(function(_, arg2)
		tbl3.__properties.__infinity_active = arg2 or false
	end)

	v2.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(...)
		local v1 = ({...})[1]
		if v1 == LocalPlayer or v1 == LocalPlayer.Name or v1 and v1.Name == LocalPlayer.Name then
			tbl3.__properties.__timehole_active = true
		end
	end)

	v2.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
		tbl3.__properties.__timehole_active = false
	end)

	local num2 = 36
	local num3 = 0.05

	v2.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryActivate"].OnClientEvent:Connect(function(...)
		local v1 = ({...})[1]
		if v1 == LocalPlayer or v1 == LocalPlayer.Name or v1 and v1.Name == LocalPlayer.Name then
			tbl3.__properties.__slashesoffury_active = true
			tbl3.__properties.__slashesoffury_count = 0
		end
	end)

	v2.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function()
		tbl3.__properties.__slashesoffury_active = false
		tbl3.__properties.__slashesoffury_count = 0
	end)

	v2.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryParry"].OnClientEvent:Connect(function()
		tbl3.__properties.__slashesoffury_count = tbl3.__properties.__slashesoffury_count + 1
	end)

	v2.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryCatch"].OnClientEvent:Connect(function()
		task.spawn(function()
			while tbl3.__properties.__slashesoffury_active and tbl3.__properties.__slashesoffury_count < num2 do
				if tbl3.__config.__detections.__slashesoffury then
					tbl3.parry.execute()
					task.wait(num3)
				else
					break
				end
			end
		end)
	end)

	Runtime.ChildAdded:Connect(function(child)
		if tbl3.__config.__detections.__phantom then
			if child.Name == "maxTransmission" or child.Name == "transmissionpart" then
				local WeldConstraint = child:FindFirstChildWhichIsA("WeldConstraint")
				if WeldConstraint then
					local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
					if v1 and WeldConstraint.Part1 == v1.HumanoidRootPart then
						local v3 = tbl3.ball.get()
						WeldConstraint:Destroy()

						if v3 then
							local connection

							connection = v4.RenderStepped:Connect(function()
								local highlighted = v3:GetAttribute("highlighted")
								if highlighted == true then
									v2.Remotes.AbilityButtonPress:Fire()
									tbl3.__properties.__parried = true

									task.delay(1, function()
										tbl3.__properties.__parried = false
									end)
								elseif highlighted == false then
									connection:Disconnect()
								end
							end)

							task.delay(3, function()
								if connection and connection.Connected then
									connection:Disconnect()
								end
							end)
						end
					end
				end
			end
		end
	end)

	v2.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, arg2)
		if arg2.Parent and arg2.Parent ~= LocalPlayer.Character then
			if not v11 or arg2.Parent.Parent ~= v11 then
				return
			end
		end

		local v1 = tbl3.player.get_closest()
		local v2 = tbl3.ball.get()

		if not v2 or not v1 then
			return
		end

		local Magnitude = (LocalPlayer.Character.PrimaryPart.Position - v1.PrimaryPart.Position).Magnitude
		local Magnitude1 = (LocalPlayer.Character.PrimaryPart.Position - v2.Position).Magnitude
		local v3 = (LocalPlayer.Character.PrimaryPart.Position - v2.Position).Unit:Dot(v2.AssemblyLinearVelocity.Unit)
		local v4 = tbl3.detection.is_curved()

		if Magnitude < 15 and Magnitude1 < 15 and v3 > -0.25 then
			if v4 then
				tbl3.parry.execute_action()
			end
		end

		if tbl3.__properties.__grab_animation then
			tbl3.__properties.__grab_animation:Stop()
		end
	end)

	v2.Remotes.ParrySuccess.OnClientEvent:Connect(function()
		if not v11 or LocalPlayer.Character.Parent ~= v11 then
			return
		end
		if tbl3.__properties.__grab_animation then
			tbl3.__properties.__grab_animation:Stop()
		end
	end)

	v2.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, arg2)
		local PrimaryPart = LocalPlayer.Character.PrimaryPart
		local v1 = tbl3.ball.get()

		if not v1 then
			return
		end

		local zoomies = v1:FindFirstChild("zoomies")

		if not zoomies then
			return
		end

		local Magnitude = zoomies.VectorVelocity.Magnitude
		local Magnitude1 = (LocalPlayer.Character.PrimaryPart.Position - v1.Position).Magnitude
		local Value = v6.Network.ServerStatsItem["Data Ping"]:GetValue()
		local v2 = math.min(Magnitude / 100, 40)
		local v3 = Magnitude1 / Magnitude - Value / 1000
		local v4 = Magnitude > 1
		local v5 = 15 - math.min(Magnitude1 / 1000, 15) + v2

		if v4 and v3 > Value / 10 then
			v5 = math.max(v5 - 15, 15)
		end

		if arg2 ~= PrimaryPart and Magnitude1 > v5 then
			tbl3.detection.__ball_properties.__curving = tick()
		end
	end)

	local tbl8 = {}

	function tbl8:Enable()
		if tbl3.__properties.__thunder_dash_enabled then
			return
		end

		tbl3.__properties.__thunder_dash_enabled = true
		local Abilities = v2:WaitForChild("Shared"):WaitForChild("Abilities")

		local function func(arg1)
			local ok, result = pcall(require, arg1)
			if ok and result then
				if result.cooldown ~= nil then
					result.cooldown = 0
				end
				if result.cooldownReductionPerUpgrade ~= nil then
					result.cooldownReductionPerUpgrade = 0
				end
			end
		end

		for _, child in ipairs(Abilities:GetChildren()) do
			func(child)
		end

		Abilities.ChildAdded:Connect(func)
	end

	function tbl8:Disable()
		tbl3.__properties.__thunder_dash_enabled = false
	end

	tbl3.triggerbot = {}
	local flag5 = false

	function tbl3.triggerbot.trigger(_)
		if flag5 then
			return
		end

		if tbl3.__triggerbot.__is_parrying then
			return
		end

		if tbl3.__triggerbot.__parries > tbl3.__triggerbot.__max_parries then
			return
		end

		if
			LocalPlayer.Character
			and LocalPlayer.Character.PrimaryPart
			and LocalPlayer.Character.PrimaryPart:FindFirstChild("SingularityCape")
		then
			return
		end

		flag5 = true
		tbl3.__triggerbot.__is_parrying = true
		tbl3.__triggerbot.__parries = tbl3.__triggerbot.__parries + 1
		tbl3.parry.execute()

		if tbl3.__properties.__play_animation then
			tbl3.animation.play_grab_parry()
		end

		task.delay(0.2, function()
			flag5 = false
			if tbl3.__triggerbot.__parries > 0 then
				tbl3.__triggerbot.__parries = tbl3.__triggerbot.__parries - 1
			end
		end)

		task.spawn(function()
			local v1 = tick()

			repeat
				v4.Heartbeat:Wait()
			until tick() - v1 >= 0.15 or not tbl3.__triggerbot.__is_parrying

			tbl3.__triggerbot.__is_parrying = false
		end)
	end

	function tbl3.triggerbot.loop()
		if not tbl3.__triggerbot.__enabled then
			return
		end

		if
			LocalPlayer.Character
			and LocalPlayer.Character.PrimaryPart
			and LocalPlayer.Character.PrimaryPart:FindFirstChild("SingularityCape")
		then
			return
		end

		local Balls = v10:FindFirstChild("Balls")

		if not Balls then
			return
		end

		for _, child in pairs(Balls:GetChildren()) do
			if child:IsA("BasePart") and child:GetAttribute("target") == LocalPlayer.Name then
				tbl3.triggerbot.trigger(child)
				break
			end
		end
	end

	function tbl3.triggerbot.enable(__enabled)
		tbl3.__triggerbot.__enabled = __enabled
		if __enabled then
			if not tbl3.__properties.__connections.__triggerbot then
				tbl3.__properties.__connections.__triggerbot = v4.Heartbeat:Connect(tbl3.triggerbot.loop)
			end
		else
			if tbl3.__properties.__connections.__triggerbot then
				tbl3.__properties.__connections.__triggerbot:Disconnect()
				tbl3.__properties.__connections.__triggerbot = nil
			end

			tbl3.__triggerbot.__is_parrying = false
			tbl3.__triggerbot.__parries = 0
			flag5 = false
		end
	end

	tbl3.manual_spam = {}
	local v23
	local flag6 = false
	local num4 = 0
	local num5 = 0
	local flag7 = true

	function tbl3.manual_spam.start()
		tbl3.manual_spam.stop()
		tbl3.__properties.__manual_spam_enabled = true
		local parry = tbl3.parry
		flag6 = true
		local keypress = parry.keypress
		local execute = tbl3.parry.execute
		local play_grab_parry = tbl3.animation.play_grab_parry

		v23 = coroutine.create(function()
			local num = 0
			while tbl3.__properties.__manual_spam_enabled do
				local v1 = os.clock()

				if v1 - num >= 0.015 then
					num = v1
					if getgenv().ManualSpamMode == "Keypress" then
						keypress()
					else
						execute()
						if getgenv().ManualSpamAnimationFix then
							play_grab_parry()
						end
					end
				end

				coroutine.yield()
			end
		end)

		task.spawn(function()
			while tbl3.__properties.__manual_spam_enabled and v23 and coroutine.status(v23) ~= "dead" do
				coroutine.resume(v23)
				task.wait()
			end
		end)
	end

	function tbl3.manual_spam.stop()
		tbl3.__properties.__manual_spam_enabled = false
		flag6 = false
		v23 = nil
	end

	v4.Heartbeat:Connect(function(deltaTime)
		num5 = num5 + deltaTime

		if num5 >= 0.1 then
			num4 = 0
			num5 = 0
		end

		if flag6 and v19 then
			pcall(function()
				func10(tbl3.curve.get_cframe())
				num4 = num4 + 1
			end)
			if flag7 then
				tbl3.animation.play_grab_parry()
			end
		end
	end)

	tbl3.auto_spam = {}

	function tbl3.auto_spam:get_entity_properties()
		tbl3.player.get_closest()

		if not v22 or not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart or not v22.PrimaryPart then
			return false
		end

		return {
			Velocity = v22.PrimaryPart.AssemblyLinearVelocity,
			Direction = (LocalPlayer.Character.PrimaryPart.Position - v22.PrimaryPart.Position).Unit,
			Distance = (LocalPlayer.Character.PrimaryPart.Position - v22.PrimaryPart.Position).Magnitude,
		}
	end

	function tbl3.auto_spam:get_ball_properties()
		local v1 = tbl3.ball.get()

		if not v1 or not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then
			return false
		end

		local AssemblyLinearVelocity = v1.AssemblyLinearVelocity
		local Unit = (LocalPlayer.Character.PrimaryPart.Position - v1.Position).Unit

		return {
			Velocity = AssemblyLinearVelocity,
			Direction = Unit,
			Distance = (LocalPlayer.Character.PrimaryPart.Position - v1.Position).Magnitude,
			Dot = AssemblyLinearVelocity.Magnitude > 0 and Unit:Dot(AssemblyLinearVelocity.Unit) or 0,
		}
	end

	function tbl3.auto_spam.spam_service(arg1)
		local v1 = tbl3.ball.get()
		local v2 = tbl3.player.get_closest()

		if
			not v1
			or not v2
			or not v2.PrimaryPart
			or not LocalPlayer.Character
			or not LocalPlayer.Character.PrimaryPart
		then
			return 0
		end

-- https://lua-x.online
		local AssemblyLinearVelocity = v1.AssemblyLinearVelocity
		local Magnitude = AssemblyLinearVelocity.Magnitude
		local Unit = (LocalPlayer.Character.PrimaryPart.Position - v1.Position).Unit
		local v3 = Magnitude > 0 and Unit:Dot(AssemblyLinearVelocity.Unit) or 0
		local v4 = LocalPlayer:DistanceFromCharacter(v2.PrimaryPart.Position)
		local Ping = arg1.Ping
		local v5 = math.min(Magnitude / 6, 255)
		local Entity_Properties = arg1.Entity_Properties
		local v6 = Ping + v5

		if Entity_Properties.Distance > v6 or arg1.Ball_Properties.Distance > v6 or v4 > v6 then
			return 0
		end

		local v7 = 5 - math.min(Magnitude / 5, 5)
		return v6 - math.clamp(v3, -1, 0) * v7
	end

	function tbl3.auto_spam.start()
		if tbl3.__properties.__connections.__auto_spam then
			tbl3.__properties.__connections.__auto_spam:Disconnect()
		end

		tbl3.__properties.__auto_spam_enabled = true

		tbl3.__properties.__connections.__auto_spam = v4.PreSimulation:Connect(function()
			if not tbl3.__properties.__auto_spam_enabled then
				return
			end

			local v1 = tbl3.ball.get()

			if not v1 or tbl3.__properties.__slashesoffury_active then
				return
			end

			local zoomies = v1:FindFirstChild("zoomies")

			if not zoomies then
				return
			end

			tbl3.player.get_closest()
			local v2 = tbl3.auto_spam:get_ball_properties()
			local v3 = tbl3.auto_spam:get_entity_properties()

			if not v2 or not v3 or not v22 or not v22.PrimaryPart then
				return
			end

			local Value = v6.Network.ServerStatsItem["Data Ping"]:GetValue()
			local v4 = math.clamp(Value / 10, 1, 16)
			local v5 = tbl3.auto_spam.spam_service({Ball_Properties = v2, Entity_Properties = v3, Ping = v4})
			local v7 = LocalPlayer:DistanceFromCharacter(v22.PrimaryPart.Position)
			local Unit = (LocalPlayer.Character.PrimaryPart.Position - v1.Position).Unit
			local v8 = zoomies.VectorVelocity.Magnitude > 0 and zoomies.VectorVelocity.Unit or Vector3.zero

			if v8.Magnitude > 0 then
				Unit:Dot(v8)
			end

			local v9 = LocalPlayer:DistanceFromCharacter(v1.Position)
			local target = v1:GetAttribute("target")

			if not target or v7 > v5 or v9 > v5 then
				return
			end

			if LocalPlayer.Character:GetAttribute("Pulsed") then
				return
			end

			if target == LocalPlayer.Name and v7 > 30 and v9 > 30 then
				return
			end

			if v9 <= v5 and tbl3.__properties.__parries > tbl3.__properties.__spam_threshold then
				if getgenv().AutoSpamMode == "Keypress" then
					if func12 then
						func12()
					end
				else
					tbl3.parry.execute()
					if getgenv().AutoSpamAnimationFix and func12 then
						func12()
					end
				end
			end
		end)
	end

	function tbl3.auto_spam.stop()
		tbl3.__properties.__auto_spam_enabled = false
		if tbl3.__properties.__connections.__auto_spam then
			tbl3.__properties.__connections.__auto_spam:Disconnect()
			tbl3.__properties.__connections.__auto_spam = nil
		end
	end

	tbl3.autoparry = {}

	function tbl3.autoparry.start()
		if tbl3.__properties.__connections.__autoparry then
			tbl3.__properties.__connections.__autoparry:Disconnect()
		end
		tbl3.__properties.__connections.__autoparry = v4.PreSimulation:Connect(function()
			if
				not tbl3.__properties.__autoparry_enabled
				or not LocalPlayer.Character
				or not LocalPlayer.Character.PrimaryPart
			then
				return
			end

			local v1 = tbl3.ball.get_all()
			local v3 = tbl3.ball.get()
			local v5

			if v10:FindFirstChild("TrainingBalls") then
				for _, child in pairs(v10.TrainingBalls:GetChildren()) do
					if child:GetAttribute("realBall") then
						v5 = child
						break
					end
				end
			end

			for _, v7 in pairs(v1) do
				if tbl3.__triggerbot.__enabled then
					return
				end

				if getgenv().BallVelocityAbove800 then
					return
				end

				if v7 then
					local zoomies = v7:FindFirstChild("zoomies")
					if zoomies then
						v7:GetAttributeChangedSignal("target"):Once(function()
							tbl3.__properties.__parried = false
						end)
						if not tbl3.__properties.__parried then
							local target = v7:GetAttribute("target")
							local VectorVelocity = zoomies.VectorVelocity
							local Magnitude = (LocalPlayer.Character.PrimaryPart.Position - v7.Position).Magnitude
							local v8 = v6.Network.ServerStatsItem["Data Ping"]:GetValue() / 10
							local v9 = math.clamp(v8 / 10, 5, 17)
							local Magnitude1 = VectorVelocity.Magnitude
							local v11 = (2.4 + math.min(math.max(Magnitude1 - 9.5, 0), 650) * 0.002) * tbl3.__properties.__divisor_multiplier
							local v12 = v9 + math.max(Magnitude1 / v11, 9.5)
							local v13 = tbl3.detection.is_curved()

							if v7:FindFirstChild("AeroDynamicSlashVFX") then
								v7.AeroDynamicSlashVFX:Destroy()
								tbl3.__properties.__tornado_time = tick()
							end

							if Runtime:FindFirstChild("Tornado") then
								if tick() - tbl3.__properties.__tornado_time < (Runtime.Tornado:GetAttribute("TornadoTime") or 1) + 0.314159 then
									continue
								end
							end

							if not (v3 and v3:GetAttribute("target") == LocalPlayer.Name and v13) then
								if not v7:FindFirstChild("ComboCounter") then
									if not LocalPlayer.Character.PrimaryPart:FindFirstChild("SingularityCape") then
										if not (tbl3.__config.__detections.__infinity and tbl3.__properties.__infinity_active) then
											if not (tbl3.__config.__detections.__deathslash and tbl3.__properties.__deathslash_active) then
												if not (tbl3.__config.__detections.__timehole and tbl3.__properties.__timehole_active) then
													if not (tbl3.__config.__detections.__slashesoffury and tbl3.__properties.__slashesoffury_active) then
														if target == LocalPlayer.Name and Magnitude <= v12 then
															if getgenv().AutoAbility then
																local UIGradient = LocalPlayer.PlayerGui.Hotbar.Ability.UIGradient
																if UIGradient and UIGradient.Offset.Y == 0.5 then
																	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Abilities") then
																		local Abilities = LocalPlayer.Character.Abilities
																		if
																			Abilities:FindFirstChild("Raging Deflection") and Abilities["Raging Deflection"].Enabled
																			or Abilities:FindFirstChild("Rapture") and Abilities.Rapture.Enabled
																			or Abilities:FindFirstChild("Calming Deflection") and Abilities["Calming Deflection"].Enabled
																			or Abilities:FindFirstChild("Aerodynamic Slash") and Abilities["Aerodynamic Slash"].Enabled
																			or Abilities:FindFirstChild("Fracture") and Abilities.Fracture.Enabled
																			or Abilities:FindFirstChild("Death Slash") and Abilities["Death Slash"].Enabled
																		then
																			tbl3.__properties.__parried = true
																			v2.Remotes.AbilityButtonPress:Fire()
																			task.wait(2.432)
																			v2:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																			continue
																		end
																	end
																end
															end
														end

														if target == LocalPlayer.Name and Magnitude <= v12 then
															if getgenv().AutoParryMode == "Keypress" then
																tbl3.parry.keypress()
															else
																tbl3.parry.execute_action()
															end
															tbl3.__properties.__parried = true
														end

														local v14 = tick()

														repeat
															v4.Stepped:Wait()
														until tick() - v14 >= 1 or not tbl3.__properties.__parried

														tbl3.__properties.__parried = false
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end

			if v5 then
				local zoomies1 = v5:FindFirstChild("zoomies")
				if zoomies1 then
					v5:GetAttributeChangedSignal("target"):Once(function()
						tbl3.__properties.__training_parried = false
					end)
					if not tbl3.__properties.__training_parried then
						local target1 = v5:GetAttribute("target")
						local VectorVelocity1 = zoomies1.VectorVelocity
						local v15 = LocalPlayer:DistanceFromCharacter(v5.Position)
						local Magnitude2 = VectorVelocity1.Magnitude
						local v16 = v6.Network.ServerStatsItem["Data Ping"]:GetValue() / 10
						local v17 = math.clamp(v16 / 10, 5, 17)
						local v18 = Magnitude2 / ((2.4 + math.min(math.max(Magnitude2 - 9.5, 0), 650) * 0.002) * tbl3.__properties.__divisor_multiplier)
						local v19 = v17 + math.max(v18, 9.5)

						if target1 == LocalPlayer.Name and v15 <= v19 then
							if getgenv().AutoParryMode == "Keypress" then
								tbl3.parry.keypress()
							else
								tbl3.parry.execute_action()
							end

							tbl3.__properties.__training_parried = true
							local v20 = tick()

							repeat
								v4.Stepped:Wait()
							until tick() - v20 >= 1 or not tbl3.__properties.__training_parried

							tbl3.__properties.__training_parried = false
						end
					end
				end
			end
		end)
	end

	function tbl3.autoparry.stop()
		if tbl3.__properties.__connections.__autoparry then
			tbl3.__properties.__connections.__autoparry:Disconnect()
			tbl3.__properties.__connections.__autoparry = nil
		end
	end

	getgenv().AutoParryMode = getgenv().AutoParryMode or "Remote"
	getgenv().ManualSpamMode = getgenv().ManualSpamMode or "Remote"
	getgenv().AutoSpamMode = getgenv().AutoSpamMode or "Remote"
	getgenv().AutoSpamAnimationFix = getgenv().AutoSpamAnimationFix ~= false
	getgenv().AutoSpamNotify = getgenv().AutoSpamNotify or false
	getgenv().ManualSpamAnimationFix = true
	local tbl9 = {}
	flag7 = true

	function tbl9.Korblox(arg1)
		if not arg1 then
			return
		end

		local RightLeg = arg1:FindFirstChild("Right Leg")

		if not RightLeg then
			return
		end

		if not RightLeg:FindFirstChild("KorbloxMesh") then
			for _, v1 in RightLeg:GetChildren() do
				if v1:IsA("SpecialMesh") then
					v1:Destroy()
				end
			end

			local specialMesh = Instance.new("SpecialMesh")
			specialMesh.Name = "KorbloxMesh"
			specialMesh.MeshId = "rbxassetid://902942096"
			specialMesh.TextureId = "rbxassetid://902843398"
			specialMesh.Offset = Vector3.new(0, 0.7, 0)
			specialMesh.Parent = RightLeg
		end
	end

	function tbl9.Restore_Leg(arg1)
		if not arg1 then
			return
		end

		local RightLeg = arg1:FindFirstChild("Right Leg")

		if not RightLeg then
			return
		end

		for _, v1 in RightLeg:GetChildren() do
			if v1:IsA("SpecialMesh") then
				v1:Destroy()
			end
		end
	end

	function tbl9.Headless(character)
		if not character then
			return
		end

		local Head = character:FindFirstChild("Head")

		if not Head then
			return
		end

		Head.Transparency = 1

		for _, v1 in Head:GetChildren() do
			if v1:IsA("Decal") or v1.Name == "face" then
				v1.Transparency = 1
			elseif v1:IsA("SpecialMesh") or v1:IsA("DataModelMesh") then
				if not v1:GetAttribute("OriginalScale") then
					v1:SetAttribute("OriginalScale", v1.Scale)
					v1.Scale = Vector3.new(0, 0, 0)
				end
			end
		end
	end

	function tbl9.Restore_Head(character)
		if not character then
			return
		end

		local Head = character:FindFirstChild("Head")

		if not Head then
			return
		end

		Head.Transparency = 0

		for _, v1 in Head:GetChildren() do
			if v1:IsA("Decal") or v1.Name == "face" then
				v1.Transparency = 0
			elseif v1:IsA("SpecialMesh") or v1:IsA("DataModelMesh") then
				local originalScale = v1:GetAttribute("OriginalScale")
				if originalScale then
					v1.Scale = originalScale
					v1:SetAttribute("OriginalScale", nil)
				end
			end
		end
	end

	LocalPlayer.CharacterAdded:Connect(function(character)
		task.wait(0.5)

		if tbl3.__properties.__headless_enabled then
			tbl9.Headless(character)
		end

		if tbl3.__properties.__korblox_enabled then
			tbl9.Korblox(character)
		end
	end)

	local tbl12

	local function func13()
		if tbl12 then
			tbl12.gui:Destroy()
		end

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "AerisMobileUIButton"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.DisplayOrder = 9999
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(0, 55, 0, 55)
		textButton.Position = UDim2.new(0.95, -27, 0.05, 0)
		textButton.BackgroundColor3 = Color3.fromRGB(45, 20, 75)
		textButton.BackgroundTransparency = 0.3
		textButton.AnchorPoint = Vector2.new(0.5, 0.5)
		textButton.Draggable = true
		textButton.AutoButtonColor = true
		textButton.ZIndex = 10000
		Instance.new("UICorner", textButton).CornerRadius = UDim.new(1, 0)
		func1(textButton, 2)
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = "UI"
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 24
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.ZIndex = 10001
		textLabel.Parent = textButton

		textButton.MouseButton1Click:Connect(function()
			Window:Minimize(not Window.Minimized)
		end)

		textButton.Parent = screenGui
		screenGui.Parent = v8
		tbl12 = {gui = screenGui, button = textButton}
		return tbl12
	end

	local function func14(text, arg2)
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "Aeris_" .. text .. "_Mobile"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(0, 140, 0, 50)
		textButton.Position = UDim2.new(0.5, -70, arg2, 0)
		textButton.BackgroundTransparency = 1
		textButton.AnchorPoint = Vector2.new(0.5, 0)
		textButton.Draggable = true
		textButton.AutoButtonColor = false
		textButton.ZIndex = 2
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.BackgroundColor3 = Color3.fromRGB(45, 22, 75)
		frame.BackgroundTransparency = 0.25
		frame.Parent = textButton
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
		func1(frame, 1.5)
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = text
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 16
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.ZIndex = 3
		textLabel.Parent = textButton
		textButton.Parent = screenGui
		screenGui.Parent = v8
		return {gui = screenGui, button = textButton, text = textLabel, bg = frame}
	end

	local function func15()
		local tbl = {}

		pcall(function()
			if isfile and isfile("Aeris/auto_config.json") then
				local v1 = v9:JSONDecode(readfile("Aeris/auto_config.json"))
				if type(v1) == "table" then
					tbl = v1
				end
			end
		end)

		local v1 = tbl["Skin.LastEquippedSword"]
		return type(v1) == "string" and v1 or ""
	end

	getgenv().saveLastEquippedSword = function(arg1)
		if type(arg1) ~= "string" or arg1 == "" then
			return
		end

		local tbl = {}

		pcall(function()
			if isfile and isfile("Aeris/auto_config.json") then
				local v1 = v9:JSONDecode(readfile("Aeris/auto_config.json"))
				if type(v1) == "table" then
					tbl = v1
				end
			end
		end)

		local v1 = tbl
		v1["Skin.LastEquippedSword"] = arg1

		pcall(function()
			if isfolder and makefolder and not isfolder("Aeris") then
				makefolder("Aeris")
			end
			if writefile then
				writefile("Aeris/auto_config.json", v9:JSONEncode(v1 or {}))
			end
		end)
	end

	local v17 = func15()
	getgenv().skinChanger = getgenv().skinChanger or v17 ~= ""
	getgenv().swordModel = type(getgenv().swordModel) == "string" and getgenv().swordModel ~= "" and getgenv().swordModel or v17
	getgenv().swordAnimations = type(getgenv().swordAnimations) == "string" and getgenv().swordAnimations ~= "" and getgenv().swordAnimations or v17
	getgenv().swordFX = type(getgenv().swordFX) == "string" and getgenv().swordFX ~= "" and getgenv().swordFX or v17

	task.spawn(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Swords = ReplicatedStorage:WaitForChild("Shared", 9000000000):WaitForChild("ReplicatedInstances", 9000000000):WaitForChild("Swords", 9000000000)
		local module = require(Swords)
		local v1

		task.spawn(function()
			while task.wait(0.25) and not v1 do
				local ok, result = pcall(getconnections, ReplicatedStorage.Remotes.FireSwordInfo.OnClientEvent)
				if ok and result then
					for _, v2 in ipairs(result) do
						if v2.Function and islclosure and islclosure(v2.Function) then
							local ok1, result1 = pcall(getupvalues, v2.Function)
							if ok1 and #result1 == 1 and type(result1[1]) == "table" then
								v1 = result1[1]
								break
							end
						end
					end
				end
			end
		end)

		local function func(arg1)
			local ok, result = pcall(function()
				return module:GetSword(arg1)
			end)
			return ok and result and result.SlashName or "SlashEffect"
		end

		local function func1()
			local v1 = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
			if v1 ~= "" then
				getgenv().slashName = func(v1)
			else
				getgenv().slashName = "SlashEffect"
			end
		end

		func1()

		local function func2()
			if not getgenv().skinChanger or not LocalPlayer.Character then
				return
			end

			pcall(function()
				local v1 = rawget(module, "EquipSwordTo")
				if type(v1) == "function" then
					local v2 = getupvalues(v1)
					local num = 1
					local v3 = #v2

					if v3 == v3 then
						if not (1 > v3) then
							while true do
								if type(v2[num]) == "boolean" then
									setupvalue(v1, num, false)
								else
									num = num + 1
									if not (num > v3) then
										continue
									end
								end
								break
							end
						end
					end
				end
			end)

			pcall(function()
				module:EquipSwordTo(LocalPlayer.Character, getgenv().swordModel)
			end)

			task.spawn(function()
				local num = 0

				while not v1 and num < 20 do
					task.wait(0.5)
					num = num + 1
				end

				if not v1 then
					return
				end

				pcall(function()
					if v1.SetSword then
						v1:SetSword(getgenv().swordAnimations ~= "" and getgenv().swordAnimations or getgenv().swordModel)
					end
				end)

				pcall(function()
					local v2 = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel

					if ReplicatedStorage.Remotes:FindFirstChild("FireSwordInfo") then
						ReplicatedStorage.Remotes.FireSwordInfo:FireServer(v2)
					end

					if v1.currentSword ~= nil then
						pcall(function()
							v1.currentSword = v2
						end)
					end

					if v1.SwordFX ~= nil then
						pcall(function()
							v1.SwordFX = v2
						end)
					end
				end)
			end)
		end

		local tbl = {}

		task.spawn(function()
			local tbl1 = {"ParrySuccessAll", "ParryAttempt", "ParrySuccess", "PlaySound", "PlayVisuals"}
			while task.wait(1) do
				for _, v1 in ipairs(tbl1) do
					local v2 = ReplicatedStorage.Remotes:FindFirstChild(v1)
					if v2 and v2:IsA("RemoteEvent") then
						local ok, result = pcall(getconnections, v2.OnClientEvent)
						if ok and type(result) == "table" then
							for _, v3 in ipairs(result) do
								local Function = v3.Function
								if Function and not tbl[Function] then
									tbl[Function] = true
									v3:Disable()

									local function func(...)
										local tbl = {...}
										local flag = false

										for _, v1 in ipairs(tbl) do
											if tostring(v1) == LocalPlayer.Name or typeof(v1) == "Instance" and (v1 == LocalPlayer.Character or v1 == LocalPlayer) then
												flag = true
												break
											end
										end

										if flag and getgenv().skinChanger then
											local v2 = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
											func1()
											local flag1 = false
											local flag2 = false

											for i, v3 in ipairs(tbl) do
												if type(v3) == "string" then
													if
														v2 ~= ""
														and not flag2
														and (v3:match("Slash") or v3 == "Default" or v3:match("Effect"))
													then
														tbl[i] = getgenv().slashName
														flag2 = true
													elseif v2 ~= "" and not flag1 then
														local flag3 = false

														pcall(function()
															if ReplicatedStorage.Shared.ReplicatedInstances.Swords:FindFirstChild(v3) then
																flag3 = true
															end
														end)

														local v4 = flag3

														if not v4 then
															local currentlyEquippedSword = LocalPlayer:GetAttribute("CurrentlyEquippedSword")
															v4 = v3 == currentlyEquippedSword
														end

														if v4 then
															tbl[i] = v2
															flag1 = true
														end
													end
												end
											end

											if v2 ~= "" and not flag2 and type(tbl[1]) == "string" then
												tbl[1] = getgenv().slashName
											end

											if v2 ~= "" and not flag1 and type(tbl[3]) == "string" then
												tbl[3] = v2
											end
										end

										if setthreadidentity then
											pcall(setthreadidentity, 2)
										end

										pcall(Function, unpack(tbl))
									end

									tbl[func] = true
									v2.OnClientEvent:Connect(func)
								end
							end
						end
					end
				end
			end
		end)

		getgenv().updateSword = function()
			func1()

			if getgenv().skinChanger and getgenv().swordModel ~= "" and getgenv().saveLastEquippedSword then
				getgenv().saveLastEquippedSword(getgenv().swordModel)
			end

			func2()
		end

		task.spawn(function()
			while task.wait(1) do
				if getgenv().skinChanger and getgenv().swordModel ~= "" then
					local Character = LocalPlayer.Character
					if Character then
						if LocalPlayer:GetAttribute("CurrentlyEquippedSword") ~= getgenv().swordModel then
							func2()
						end

						if not Character:FindFirstChild(getgenv().swordModel) then
							func2()
						end

						for _, child in pairs(Character:GetChildren()) do
							if child:IsA("Model") and child.Name ~= getgenv().swordModel then
								child:Destroy()
							end
							task.wait()
						end
					end
				end
			end
		end)

		LocalPlayer.CharacterAdded:Connect(function()
			if getgenv().skinChanger then
				getgenv().skinChanger = false

				if getgenv().setSkinChangerToggleUI then
					getgenv().setSkinChangerToggleUI(false)
				end

				task.wait(2)
				getgenv().skinChanger = true

				if getgenv().setSkinChangerToggleUI then
					getgenv().setSkinChangerToggleUI(true)
				end

				task.wait(0.5)

				pcall(function()
					getgenv().updateSword()
				end)
			end
		end)
	end)

	getgenv().skinChanger = false
	getgenv().skinChangerEnabled = false
	getgenv().swordModel = ""
	getgenv().swordAnimations = ""
	getgenv().swordFX = ""
	getgenv().slashName = "SlashEffect"

	local tbl10 = {
		autoParryKeyCode = Enum.KeyCode.LeftShift,
		autoSpamKeyCode = Enum.KeyCode.V,
		manualSpamKeyCode = Enum.KeyCode.E,
		trigKeyCode = Enum.KeyCode.R,
		autoJumpKeyCode = Enum.KeyCode.J,
	}

	local autoParrySection = Tabs.Rage:AddSection("Auto Parry", "shield")

	autoParrySection:AddToggle("AerisAutoParryToggle", {
		Title = "Auto Parry",
		Description = "Automatically parries incoming balls",
		Default = false,
		Callback = function(value)
			tbl3.__properties.__autoparry_enabled = value
			tbl3.__properties.__play_animation = value

			if value then
				tbl3.autoparry.start()
			else
				tbl3.autoparry.stop()
			end

			if getgenv().AutoParryNotify then
				module:Notify({Title = "Auto Parry", Content = value and "ON" or "OFF", Duration = 2})
			end
		end,
	})

	autoParrySection:AddDropdown("AerisParryMode", {
		Title = "Parry Mode",
		Values = {"Remote", "Keypress"},
		Default = "Remote",
		Multi = false,
		Callback = function(value)
			getgenv().AutoParryMode = value
		end,
	})

	autoParrySection:AddDropdown("AerisModeCurve", {
		Title = "Curve Mode",
		Values = tbl4,
		Default = "Camera",
		Multi = false,
		Callback = function(value)
			str = value
			str1 = value
		end,
	})

	autoParrySection:AddToggle("AerisRandomCurveMode", {
		Title = "Random Curve",
		Default = false,
		Callback = function(value)
			if value then
				if not tbl3.__properties.__connections.__random_curve then
					tbl3.__properties.__connections.__random_curve = v4.PreSimulation:Connect(function()
						str = tbl4[math.random(1, #tbl4)]
					end)
				end
			else
				if tbl3.__properties.__connections.__random_curve then
					tbl3.__properties.__connections.__random_curve:Disconnect()
					tbl3.__properties.__connections.__random_curve = nil
				end
				str = str1
			end
		end,
	})

	autoParrySection:AddSlider("AerisParryAccuracy", {
		Title = "Accuracy",
		Default = 50,
		Min = 1,
		Max = 100,
		Rounding = 1,
		Callback = function(value)
			tbl3.__properties.__accuracy = value
			func7()
		end,
	})

	autoParrySection:AddToggle("AerisRandomizeAccuracy", {
		Title = "Randomize Accuracy",
		Default = false,
		Callback = function(value)
			tbl3.__properties.__randomized_accuracy_enabled = value
			if value then
				func8()
			end
		end,
	})

	autoParrySection:AddToggle("AerisCooldownProtection", {
		Title = "Cooldown Protection",
		Default = false,
		Callback = function(value)
			getgenv().CooldownProtection = value
		end,
	})

	autoParrySection:AddToggle("AerisAutoAbility", {
		Title = "Auto Ability",
		Default = false,
		Callback = function(value)
			getgenv().AutoAbility = value
		end,
	})

	autoParrySection:AddToggle("AerisAutoParryNotify", {
		Title = "Notify",
		Default = false,
		Callback = function(value)
			getgenv().AutoParryNotify = value
		end,
	})

	local autoCurveHotkeySection = Tabs.Rage:AddSection("AutoCurve Hotkey", "keyboard")

	autoCurveHotkeySection:AddToggle("AerisAutoCurveHotkey", {
		Title = "AutoCurve Hotkey",
		Default = false,
		Callback = function(value)
			getgenv().AutoCurveHotkeyEnabled = value
		end,
	})

	autoCurveHotkeySection:AddToggle("AerisAutoCurveHotkeyNotify", {
		Title = "Notify",
		Default = false,
		Callback = function(value)
			getgenv().AutoCurveHotkeyNotify = value
		end,
	})

	local triggerbotSection = Tabs.Rage:AddSection("Triggerbot", "target")

	triggerbotSection:AddToggle("AerisTriggerbotToggle", {
		Title = "Triggerbot",
		Description = "Parries instantly when targeted",
		Default = false,
		Callback = function(value)
			if tbl3.__properties.__is_mobile then
				if value then
					if not tbl3.__properties.__mobile_guis.triggerbot then
						local v1 = func14("Trigger", 0.65)
						tbl3.__properties.__mobile_guis.triggerbot = v1
						local num = 0
						local flag = false

						v1.button.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.Touch then
								num = tick()
								flag = false
							end
						end)

						v1.button.InputChanged:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.Touch and tick() - num > 0.1 then
								flag = true
							end
						end)

						v1.button.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.Touch and not flag then
								tbl3.__properties.__triggerbot_enabled = not tbl3.__properties.__triggerbot_enabled
								tbl3.triggerbot.enable(tbl3.__properties.__triggerbot_enabled)
								v1.text.Text = tbl3.__properties.__triggerbot_enabled and "ON" or "Trigger"
								v1.text.TextColor3 = tbl3.__properties.__triggerbot_enabled and Color3.fromRGB(200, 130, 255) or Color3.fromRGB(255, 255, 255)

								if getgenv().TriggerbotNotify then
									module:Notify({
										Title = "Triggerbot",
										Content = tbl3.__properties.__triggerbot_enabled and "ON" or "OFF",
										Duration = 2,
									})
								end
							end
						end)
					end
				else
					tbl3.__properties.__triggerbot_enabled = false
					tbl3.triggerbot.enable(false)
					local triggerbot = tbl3.__properties.__mobile_guis.triggerbot

					if triggerbot and triggerbot.gui then
						triggerbot.gui:Destroy()
					end

					tbl3.__properties.__mobile_guis.triggerbot = nil
				end
			else
				tbl3.__properties.__triggerbot_enabled = value
				tbl3.triggerbot.enable(value)

				if getgenv().TriggerbotNotify then
					module:Notify({Title = "Triggerbot", Content = value and "ON" or "OFF", Duration = 2})
				end
			end
		end,
	})

	triggerbotSection:AddToggle("AerisTriggerbotNotify", {
		Title = "Notify",
		Description = "Show notifications for Triggerbot",
		Default = false,
		Callback = function(value)
			getgenv().TriggerbotNotify = value
		end,
	})

	local autoSpamSection = Tabs.Spam:AddSection("Auto Spam", "zap")

	autoSpamSection:AddToggle("AerisAutoSpamToggle", {
		Title = "Auto Spam",
		Description = "Automatically spams parries in close range",
		Default = false,
		Callback = function(value)
			tbl3.__properties.__auto_spam_enabled = value

			if value then
				tbl3.auto_spam.start()
			else
				tbl3.auto_spam.stop()
			end

			if getgenv().AutoSpamNotify then
				module:Notify({Title = "Auto Spam", Content = value and "ON" or "OFF", Duration = 2})
			end
		end,
	})

	autoSpamSection:AddDropdown("AerisAutoSpamMode", {
		Title = "Spam Mode",
		Values = {"Remote", "Keypress"},
		Default = "Remote",
		Multi = false,
		Callback = function(value)
			getgenv().AutoSpamMode = value
		end,
	})

	autoSpamSection:AddToggle("AerisAutoSpamAnimationFix", {
		Title = "Animation Fix",
		Default = true,
		Callback = function(value)
			getgenv().AutoSpamAnimationFix = value
		end,
	})

	autoSpamSection:AddToggle("AerisAutoSpamNotify", {
		Title = "Notify",
		Default = false,
		Callback = function(value)
			getgenv().AutoSpamNotify = value
		end,
	})

	autoSpamSection:AddSlider("AerisAutoSpamRate", {
		Title = "Spam Rate",
		Default = 240,
		Min = 60,
		Max = 5000,
		Rounding = 0,
		Callback = function(value)
			tbl3.__properties.__spam_rate = value
		end,
	})

	local manualSpamSection = Tabs.Spam:AddSection("Manual Spam", "skull")

	manualSpamSection:AddToggle("AerisManualSpamToggle", {
		Title = "Manual Spam",
		Description = "High-frequency parry spam",
		Default = false,
		Callback = function(value)
			if tbl3.__properties.__is_mobile then
				if value then
					if not tbl3.__properties.__mobile_guis.manual_spam then
						local v1 = func14("Spam", 0.8)
						tbl3.__properties.__mobile_guis.manual_spam = v1
						local num = 0
						local flag = false

						v1.button.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.Touch then
								num = tick()
								flag = false
							end
						end)

						v1.button.InputChanged:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.Touch and tick() - num > 0.1 then
								flag = true
							end
						end)

						v1.button.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.Touch and not flag then
								tbl3.__properties.__manual_spam_enabled = not tbl3.__properties.__manual_spam_enabled

								if tbl3.__properties.__manual_spam_enabled then
									tbl3.manual_spam.start()
									v1.text.Text = "ON"
									v1.text.TextColor3 = Color3.fromRGB(200, 130, 255)
								else
									tbl3.manual_spam.stop()
									v1.text.Text = "Spam"
									v1.text.TextColor3 = Color3.fromRGB(255, 255, 255)
								end

								if getgenv().ManualSpamNotify then
									module:Notify({
										Title = "Manual Spam",
										Content = tbl3.__properties.__manual_spam_enabled and "ON" or "OFF",
										Duration = 2,
									})
								end
							end
						end)
					end
				else
					tbl3.__properties.__manual_spam_enabled = false
					tbl3.manual_spam.stop()
					local manual_spam = tbl3.__properties.__mobile_guis.manual_spam

					if manual_spam and manual_spam.gui then
						manual_spam.gui:Destroy()
					end

					tbl3.__properties.__mobile_guis.manual_spam = nil
				end
			else
				tbl3.__properties.__manual_spam_enabled = value
				flag6 = value

				if value then
					tbl3.manual_spam.start()
				else
					tbl3.manual_spam.stop()
				end

				if getgenv().ManualSpamNotify then
					module:Notify({Title = "Manual Spam", Content = value and "ON" or "OFF", Duration = 2})
				end
			end
		end,
	})

	manualSpamSection:AddToggle("AerisManualSpamNotify", {
		Title = "Notify",
		Description = "Show notifications for manual spam",
		Default = false,
		Callback = function(value)
			getgenv().ManualSpamNotify = value
		end,
	})

	manualSpamSection:AddDropdown("AerisManualSpamMode", {
		Title = "Mode",
		Description = "Select spam method",
		Values = {"Remote", "Keypress"},
		Default = "Remote",
		Multi = false,
		Callback = function(value)
			getgenv().ManualSpamMode = value
		end,
	})

	manualSpamSection:AddToggle("AerisManualSpamAnimationFix", {
		Title = "Animation Fix",
		Description = "Fix animation during spam",
		Default = true,
		Callback = function(value)
			getgenv().ManualSpamAnimationFix = value
			flag7 = value
		end,
	})

	local infinityDetectionSection = Tabs.Detection:AddSection("Infinity Detection", "infinity")

	infinityDetectionSection:AddToggle("AerisInfinityDetection", {
		Title = "Infinity Detection",
		Default = false,
		Callback = function(value)
			tbl3.__config.__detections.__infinity = value
		end,
	})

	infinityDetectionSection:AddToggle("AerisInfinityNotify", {
		Title = "Notify",
		Default = false,
		Callback = function(value)
			getgenv().InfinityNotify = value
		end,
	})

	Tabs.Detection:AddSection("Death Slash Detection", "skull"):AddToggle("AerisDeathSlashDetection", {
		Title = "Death Slash Detection",
		Default = false,
		Callback = function(value)
			tbl3.__config.__detections.__deathslash = value
		end,
	})

	Tabs.Detection:AddSection("Time Hole Detection", "clock"):AddToggle("AerisTimeHoleDetection", {
		Title = "Time Hole Detection",
		Default = false,
		Callback = function(value)
			tbl3.__config.__detections.__timehole = value
		end,
	})

	local slashesOfFuryDetectionSection = Tabs.Detection:AddSection("Slashes Of Fury Detection", "swords")

	slashesOfFuryDetectionSection:AddToggle("AerisSlashesOfFuryDetection", {
		Title = "Slashes Of Fury Detection",
		Default = false,
		Callback = function(value)
			tbl3.__config.__detections.__slashesoffury = value
		end,
	})

	slashesOfFuryDetectionSection:AddSlider("AerisParryDelay", {
		Title = "Parry Delay",
		Default = 0.05,
		Min = 0.05,
		Max = 0.25,
		Rounding = 2,
		Callback = function(value)
			num3 = value
		end,
	})

	slashesOfFuryDetectionSection:AddSlider("AerisMaxParryCount", {
		Title = "Max Parry Count",
		Default = 35,
		Min = 1,
		Max = 35,
		Rounding = 0,
		Callback = function(value)
			num2 = value
		end,
	})

	Tabs.Detection:AddSection("Anti-Phantom", "ghost"):AddToggle("AerisAntiPhantom", {
		Title = "Anti-Phantom",
		Default = false,
		Callback = function(value)
			tbl3.__config.__detections.__phantom = value
		end,
	})

	local ballStatsSection = Tabs.Visuals:AddSection("Ball Stats", "gauge")

	function tbl3.create_ball_velocity_gui()
		if tbl3.__properties.__ball_velocity_gui then
			tbl3.__properties.__ball_velocity_gui.gui:Destroy()
		end

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "AerisBallVelocityGUI"
		screenGui.ResetOnSpawn = false
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.DisplayOrder = 999
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 220, 0, 80)
		frame.Position = UDim2.new(0, 10, 0.82, 0)
		frame.BackgroundColor3 = Color3.fromRGB(40, 20, 68)
		frame.BackgroundTransparency = 0.35
		frame.BorderSizePixel = 0
		frame.Active = true
		frame.Selectable = true
		frame.Draggable = true
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
		func1(frame, 2)
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 0, 20)
		textLabel.Position = UDim2.new(0, 0, 0, 5)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = "Aeris | Ball Status"
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 14
		textLabel.Parent = frame
		local textLabel1 = Instance.new("TextLabel")
		textLabel1.Size = UDim2.new(1, -10, 0, 25)
		textLabel1.Position = UDim2.new(0, 5, 0, 25)
		textLabel1.BackgroundTransparency = 1
		textLabel1.Text = "Current: 0"
		textLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel1.Font = Enum.Font.GothamBold
		textLabel1.TextSize = 16
		textLabel1.TextXAlignment = Enum.TextXAlignment.Left
		textLabel1.Parent = frame
		local textLabel2 = Instance.new("TextLabel")
		textLabel2.Size = UDim2.new(1, -10, 0, 25)
		textLabel2.Position = UDim2.new(0, 5, 0, 50)
		textLabel2.BackgroundTransparency = 1
		textLabel2.Text = "Peak: 0"
		textLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel2.Font = Enum.Font.GothamBold
		textLabel2.TextSize = 16
		textLabel2.TextXAlignment = Enum.TextXAlignment.Left
		textLabel2.Parent = frame
		frame.Parent = screenGui
		screenGui.Parent = v8
		tbl3.__properties.__ball_velocity_gui = {gui = screenGui, frame = frame, currentSpeedLabel = textLabel1, peakSpeedLabel = textLabel2}
	end

	function tbl3.update_ball_velocity()
		if not tbl3.__properties.__ball_velocity_enabled or not tbl3.__properties.__ball_velocity_gui then
			return
		end

		local v1 = tbl3.ball.get()

		if not v1 then
			tbl3.__properties.__ball_velocity_gui.currentSpeedLabel.Text = "Current: 0"
			return
		end

		local FullName = v1:GetFullName()

		if FullName ~= tbl3.__properties.__last_ball_id then
			tbl3.__properties.__peak_velocity = 0
			tbl3.__properties.__last_ball_id = FullName
		end

		local zoomies = v1:FindFirstChild("zoomies")

		if not zoomies then
			tbl3.__properties.__ball_velocity_gui.currentSpeedLabel.Text = "Current: 0"
			return
		end

		local Magnitude = zoomies.VectorVelocity.Magnitude

		if Magnitude > tbl3.__properties.__peak_velocity then
			tbl3.__properties.__peak_velocity = Magnitude
		end

		local v2 = Color3.fromRGB(210, 160, 255)

		if Magnitude > 2000 then
			v2 = Color3.fromRGB(255, 80, 120)
		elseif Magnitude > 1500 then
			v2 = Color3.fromRGB(255, 165, 0)
		end

		local v3 = Color3.fromRGB(210, 160, 255)

		if tbl3.__properties.__peak_velocity > 2000 then
			v3 = Color3.fromRGB(255, 80, 120)
		elseif tbl3.__properties.__peak_velocity > 1500 then
			v3 = Color3.fromRGB(255, 165, 0)
		end

		tbl3.__properties.__ball_velocity_gui.currentSpeedLabel.RichText = true

		tbl3.__properties.__ball_velocity_gui.currentSpeedLabel.Text = string.format(
			"Current: <font color='#%02x%02x%02x'>%.1f</font>",
			math.floor(v2.R * 255),
			math.floor(v2.G * 255),
			math.floor(v2.B * 255),
			Magnitude
		)

		tbl3.__properties.__ball_velocity_gui.peakSpeedLabel.RichText = true

		tbl3.__properties.__ball_velocity_gui.peakSpeedLabel.Text = string.format(
			"Peak: <font color='#%02x%02x%02x'>%.1f</font>",
			math.floor(v3.R * 255),
			math.floor(v3.G * 255),
			math.floor(v3.B * 255),
			tbl3.__properties.__peak_velocity
		)
	end

	ballStatsSection:AddToggle("AerisBallVelocity", {
		Title = "Show Ball Velocity",
		Description = "Display ball velocity stats",
		Default = false,
		Callback = function(value)
			tbl3.__properties.__ball_velocity_enabled = value
			if value then
				tbl3.create_ball_velocity_gui()

				if not tbl3.__properties.__connections.__ball_velocity then
					tbl3.__properties.__connections.__ball_velocity = v4.RenderStepped:Connect(tbl3.update_ball_velocity)
				end

				module:Notify({Title = "Ball Stats", Content = "Activated", Duration = 2})
			else
				if tbl3.__properties.__ball_velocity_gui then
					tbl3.__properties.__ball_velocity_gui.gui:Destroy()
					tbl3.__properties.__ball_velocity_gui = nil
				end

				if tbl3.__properties.__connections.__ball_velocity then
					tbl3.__properties.__connections.__ball_velocity:Disconnect()
					tbl3.__properties.__connections.__ball_velocity = nil
				end

				tbl3.__properties.__peak_velocity = 0
				tbl3.__properties.__last_ball_id = nil
				module:Notify({Title = "Ball Stats", Content = "Deactivated", Duration = 2})
			end
		end,
	})

	local screenGui1 = Instance.new("ScreenGui", v8)
	screenGui1.Name = "AerisRealPing"
	screenGui1.ResetOnSpawn = false
	screenGui1.IgnoreGuiInset = true
	screenGui1.DisplayOrder = 999
	screenGui1.Enabled = false
	local frame = Instance.new("Frame", screenGui1)
	frame.Size = UDim2.new(0, 110, 0, 35)
	frame.Position = UDim2.new(0, 15, 0.88, 0)
	frame.BackgroundColor3 = Color3.fromRGB(40, 20, 68)
	frame.BackgroundTransparency = 0.3
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Draggable = true
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
	func1(frame, 1.5)
	local textLabel = Instance.new("TextLabel", frame)
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.Text = "Ping: 0ms"
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.BackgroundTransparency = 1
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 14
	textLabel.TextXAlignment = Enum.TextXAlignment.Center

	ballStatsSection:AddToggle("AerisShowPing", {
		Title = "Show Real Ping",
		Description = "Shows your current ping",
		Default = false,
		Callback = function(value)
			screenGui1.Enabled = value
			if value then
				module:Notify({Title = "Real Ping", Content = "Activated", Duration = 2})
				task.spawn(function()
					while screenGui1.Enabled do
						task.wait(0.5)
						if screenGui1.Enabled and textLabel then
							local Value = v6.Network.ServerStatsItem["Data Ping"]:GetValue()
							local v1 = Color3.fromRGB(190, 140, 255)

							if Value > 150 then
								v1 = Color3.fromRGB(255, 165, 0)
							elseif Value > 300 then
								v1 = Color3.fromRGB(255, 0, 0)
							end

							textLabel.Text = string.format(
								"Ping: <font color='#%02x%02x%02x'>%dms</font>",
								math.floor(v1.R * 255),
								math.floor(v1.G * 255),
								math.floor(v1.B * 255),
								Value
							)

							textLabel.RichText = true
						end
					end
				end)
			else
				module:Notify({Title = "Real Ping", Content = "Deactivated", Duration = 2})
			end
		end,
	})

	local flag8 = false
	local flag9 = false

	Tabs.Misc:AddSection("Auto Jump", "arrow-up"):AddToggle("AerisAutoJump", {
		Title = "Auto Jump",
		Description = "Automatically jumps when grounded",
		Default = false,
		Callback = function(value)
			local v1 = not value
			flag8 = value

			if v1 then
				flag9 = false
			end

			module:Notify({Title = "Auto Jump", Content = value and "Enabled" or "Disabled", Duration = 2})
		end,
	})

	v4.Heartbeat:Connect(function()
		if flag8 then
			local Character = LocalPlayer.Character
			local v1 = Character and Character:FindFirstChildOfClass("Humanoid")

			if v1 then
				local v2 = v1.FloorMaterial ~= Enum.Material.Air

				if v2 and not flag9 then
					v1:ChangeState(Enum.HumanoidStateType.Jumping)
				end

				flag9 = v2
			end
		else
			flag9 = false
		end
	end)

	local Section = Tabs.Misc:AddSection("Headless & Korblox", "user")

	Section:AddToggle("AerisHeadlessToggle", {
		Title = "Headless",
		Description = "Makes your character headless",
		Default = false,
		Callback = function(value)
			tbl3.__properties.__headless_enabled = value
			local Character = LocalPlayer.Character

			if Character then
				if value then
					tbl9.Headless(Character)
				else
					tbl9.Restore_Head(Character)
				end
			end

			module:Notify({Title = "Headless", Content = value and "Enabled" or "Disabled", Duration = 2})
		end,
	})

	Section:AddToggle("AerisKorbloxToggle", {
		Title = "Korblox",
		Description = "Gives you Korblox leg",
		Default = false,
		Callback = function(value)
			tbl3.__properties.__korblox_enabled = value
			local Character = LocalPlayer.Character

			if Character then
				if value then
					tbl9.Korblox(Character)
				else
					tbl9.Restore_Leg(Character)
				end
			end

			module:Notify({Title = "Korblox", Content = value and "Enabled" or "Disabled", Duration = 2})
		end,
	})

	Tabs.Misc:AddSection("Thunder Dash", "zap"):AddToggle("AerisThunderDashToggle", {
		Title = "Thunder Dash",
		Description = "Removes all ability cooldowns (Infinite Thunder Dash)",
		Default = false,
		Callback = function(value)
			if value then
				tbl8:Enable()
				module:Notify({Title = "Thunder Dash", Content = "Enabled - Infinite Abilities!", Duration = 3})
			else
				tbl8:Disable()
				module:Notify({Title = "Thunder Dash", Content = "Disabled", Duration = 2})
			end
		end,
	})

	local skinChangerSection = Tabs.Misc:AddSection("Skin Changer", "sword")

	local aerisSkinChangerToggle = skinChangerSection:AddToggle("AerisSkinChanger", {
		Title = "Skin Changer",
		Description = "Changes your sword skin",
		Default = false,
		Callback = function(value)
			getgenv().skinChanger = value
			getgenv().skinChangerEnabled = value

			if value and getgenv().swordModel ~= "" then
				if getgenv().updateSword then
					pcall(getgenv().updateSword)
				end
				module:Notify({Title = "Skin Changer", Content = "Enabled", Duration = 2})
			elseif not value then
				module:Notify({Title = "Skin Changer", Content = "Disabled", Duration = 2})
			end
		end,
	})

	getgenv().setSkinChangerToggleUI = function(skinChangerEnabled)
		if aerisSkinChangerToggle and aerisSkinChangerToggle.Value ~= skinChangerEnabled then
			aerisSkinChangerToggle:SetValue(skinChangerEnabled)
			getgenv().skinChanger = skinChangerEnabled
			getgenv().skinChangerEnabled = skinChangerEnabled
		end
	end

	skinChangerSection:AddInput("AerisSwordName", {
		Title = "Sword Name",
		Placeholder = "Enter sword name (e.g. DualPrince)...",
		Default = "",
		Callback = function(value)
			getgenv().swordModel = value
			getgenv().swordAnimations = value
			getgenv().swordFX = value

			if getgenv().skinChanger and value ~= "" and getgenv().updateSword then
				pcall(getgenv().updateSword)
			end

			if getgenv().saveLastEquippedSword then
				pcall(getgenv().saveLastEquippedSword, value)
			end
		end,
	})

	skinChangerSection:AddToggle("AerisSaveLastSword", {
		Title = "Save Last Equipped Sword",
		Description = "Auto-loads your last sword on inject",
		Default = true,
		Callback = function(value)
			getgenv().autoLoadLastSword = value
		end,
	})

	local noRenderSection = Tabs.Misc:AddSection("No Render", "eye-off")
	local tbl11 = {}

	noRenderSection:AddToggle("AerisNoRender", {
		Title = "No Render",
		Default = false,
		Callback = function(value)
			local EffectScripts = LocalPlayer.PlayerScripts:FindFirstChild("EffectScripts")

			if EffectScripts then
				local ClientFX = EffectScripts:FindFirstChild("ClientFX")
				if ClientFX then
					ClientFX.Disabled = value
				end
			end

			if value then
				tbl11["No Render"] = v10.Runtime.ChildAdded:Connect(function(child)
					v7:AddItem(child, 0)
				end)
			elseif tbl11["No Render"] then
				tbl11["No Render"]:Disconnect()
				tbl11["No Render"] = nil
			end
		end,
	})

	local keybindsSection = Tabs.Settings:AddSection("Keybinds", "keyboard")

	keybindsSection:AddKeybind("AerisAutoParryKeybind", {
		Title = "Auto Parry Key",
		Description = "Toggle Auto Parry",
		Default = "LeftShift",
		Callback = function() end,
		ChangedCallback = function(arg1)
			local str = tostring(arg1)
			if str and str ~= "" then
				local v1 = str:match("Enum%.KeyCode%.(.+)") or str
				local v2 = Enum.KeyCode[v1]

				if v2 then
					tbl10.autoParryKeyCode = v2
					module:Notify({Title = "Auto Parry Key", Content = v1, Duration = 2})
				end
			end
		end,
	})

	keybindsSection:AddKeybind("AerisAutoSpamKeybind", {
		Title = "Auto Spam Key",
		Description = "Toggle Auto Spam",
		Default = "V",
		Callback = function() end,
		ChangedCallback = function(arg1)
			local str = tostring(arg1)
			if str and str ~= "" then
				local v1 = str:match("Enum%.KeyCode%.(.+)") or str
				local v2 = Enum.KeyCode[v1]

				if v2 then
					tbl10.autoSpamKeyCode = v2
					module:Notify({Title = "Auto Spam Key", Content = v1, Duration = 2})
				end
			end
		end,
	})

	keybindsSection:AddKeybind("AerisManualSpamKeybind", {
		Title = "Manual Spam Key",
		Description = "Toggle Manual Spam",
		Default = "E",
		Callback = function() end,
		ChangedCallback = function(arg1)
			local str = tostring(arg1)
			if str and str ~= "" then
				local v1 = str:match("Enum%.KeyCode%.(.+)") or str
				local v2 = Enum.KeyCode[v1]

				if v2 then
					tbl10.manualSpamKeyCode = v2
					module:Notify({Title = "Manual Spam Key", Content = v1, Duration = 2})
				end
			end
		end,
	})

	keybindsSection:AddKeybind("AerisTriggerKeybind", {
		Title = "Trigger Key",
		Description = "Toggle Triggerbot",
		Default = "R",
		Callback = function() end,
		ChangedCallback = function(arg1)
			local str = tostring(arg1)
			if str and str ~= "" then
				local v1 = str:match("Enum%.KeyCode%.(.+)") or str
				local v2 = Enum.KeyCode[v1]

				if v2 then
					tbl10.trigKeyCode = v2
					module:Notify({Title = "Trigger Key", Content = v1, Duration = 2})
				end
			end
		end,
	})

	keybindsSection:AddKeybind("AerisAutoJumpKeybind", {
		Title = "Auto Jump Key",
		Description = "Toggle Auto Jump",
		Default = "J",
		Callback = function() end,
		ChangedCallback = function(arg1)
			local str = tostring(arg1)
			if str and str ~= "" then
				local v1 = str:match("Enum%.KeyCode%.(.+)") or str
				local v2 = Enum.KeyCode[v1]

				if v2 then
					tbl10.autoJumpKeyCode = v2
					module:Notify({Title = "Auto Jump Key", Content = v1, Duration = 2})
				end
			end
		end,
	})

	v3.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end

		local tbl = {}
		local KeyCode = input.KeyCode
		tbl[Enum.KeyCode.One] = "Camera"
		tbl[Enum.KeyCode.Two] = "Random"
		tbl[Enum.KeyCode.Three] = "Accelerated"
		tbl[Enum.KeyCode.Four] = "Backwards"
		tbl[Enum.KeyCode.Five] = "Slow"
		tbl[Enum.KeyCode.Six] = "High"
		tbl[Enum.KeyCode.Seven] = "Normal"
		tbl[Enum.KeyCode.Eight] = "Speed"
		tbl[Enum.KeyCode.Nine] = "Down"

		if tbl[KeyCode] then
			str = tbl[KeyCode]
			str1 = tbl[KeyCode]

			if getgenv().AutoCurveHotkeyNotify then
				module:Notify({Title = "Curve Mode", Content = tbl[KeyCode], Duration = 1})
			end
		end

		if KeyCode == tbl10.autoSpamKeyCode then
			tbl3.__properties.__auto_spam_enabled = not tbl3.__properties.__auto_spam_enabled

			if tbl3.__properties.__auto_spam_enabled then
				tbl3.auto_spam.start()
			else
				tbl3.auto_spam.stop()
			end

			if getgenv().AutoSpamNotify then
				module:Notify({
					Title = "Auto Spam",
					Content = tbl3.__properties.__auto_spam_enabled and "ON" or "OFF",
					Duration = 1,
				})
			end
		end

		if KeyCode == tbl10.manualSpamKeyCode then
			tbl3.__properties.__manual_spam_enabled = not tbl3.__properties.__manual_spam_enabled
			flag6 = tbl3.__properties.__manual_spam_enabled

			if flag6 then
				tbl3.manual_spam.start()
			else
				tbl3.manual_spam.stop()
			end

			if getgenv().ManualSpamNotify then
				module:Notify({Title = "Manual Spam", Content = flag6 and "ON" or "OFF", Duration = 1})
			end
		end

		if KeyCode == tbl10.trigKeyCode then
			local v1 = not tbl3.__properties.__triggerbot_enabled
			tbl3.__properties.__triggerbot_enabled = v1
			tbl3.triggerbot.enable(v1)

			if getgenv().TriggerbotNotify then
				module:Notify({Title = "Triggerbot", Content = v1 and "ON" or "OFF", Duration = 1})
			end
		end

		if KeyCode == tbl10.autoParryKeyCode then
			tbl3.__properties.__autoparry_enabled = not tbl3.__properties.__autoparry_enabled
			tbl3.__properties.__play_animation = tbl3.__properties.__autoparry_enabled

			if tbl3.__properties.__autoparry_enabled then
				tbl3.autoparry.start()
			else
				tbl3.autoparry.stop()
			end

			if getgenv().AutoParryNotify then
				module:Notify({
					Title = "Auto Parry",
					Content = tbl3.__properties.__autoparry_enabled and "ON" or "OFF",
					Duration = 1,
				})
			end
		end

		if KeyCode == tbl10.autoJumpKeyCode then
			flag8 = not flag8

			if not flag8 then
				flag9 = false
			end

			module:Notify({Title = "Auto Jump", Content = flag8 and "ON" or "OFF", Duration = 1})
		end
	end)

	if tbl3.__properties.__is_mobile then
		task.spawn(function()
			task.wait(2)
			func13()
		end)
	end

	module:Notify({Title = "Aeris Hub", Content = "Loaded successfully! Block once manually first.", Duration = 8})
	print("Aeris Hub Loaded!")
end)

-- https://lua-x.online
