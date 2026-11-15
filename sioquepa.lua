
if getgenv().TFjhJhggCUo then
	print("You have already executed PinokioScripts!")
	return
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

local function func1(arg1)
	if setclipboard then
		setclipboard(arg1)
	elseif toclipboard then
		toclipboard(arg1)
	end
end

local function func2()
	return true
end

local function func7()
	return true
end

local function func9()
	return "Active (Unlocked)"
end

local function func10()
	getgenv().TFjhJhggCUo = true
	local module = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

	local tbl = {
		Title = "Murder vs Sheriff Duels",
		Author = "by PinokioScripts",
		Folder = "PinokioScriptsMvsdScript",
		Size = UDim2.fromOffset(650, 430),
		MinSize = Vector2.new(450, 250),
		MaxSize = Vector2.new(850, 560),
		Transparent = true,
		Theme = "Dark",
		Resizable = true,
		SideBarWidth = 200,
		BackgroundImageTransparency = 0.42,
		HideSearchBar = true,
		ScrollBarEnabled = false,
		User = {Enabled = true, Anonymous = true, Callback = function() end},
	}

	local Window = module:CreateWindow(tbl)

	local tbl2 = {
		Title = "Pinokio",
		CornerRadius = UDim.new(0, 16),
		StrokeThickness = 2,
		Color = ColorSequence.new(Color3.fromHex("0A1128"), Color3.fromHex("4B0082")),
		OnlyMobile = false,
		Enabled = true,
		Draggable = true,
	}

	Window:EditOpenButton(tbl2)
	local tbl3 = {}
	local func32
	local func24
	local func22

	local function func(arg1)
		if arg1 then
			table.insert(tbl3, arg1)
		end
		return arg1
	end

	local function func3()
		for _, v1 in ipairs(tbl3) do
			pcall(function()
				v1:Unlock()
			end)
		end
	end

	local function func4()
		getgenv().autoshoot_enabled = false
		getgenv().auto_throw_enabled = false
		getgenv().hitbox_expander = false
		getgenv().autoKillGun = false
		getgenv().autoKillKnife = false
		getgenv().autoShroud = false

		if func32 then
			func32()
		end

		if func24 then
			func24()
		end

		if func22 then
			func22()
		end

		for _, v1 in ipairs(tbl3) do
			pcall(function()
				v1:Set(false)
			end)
		end
	end

	local function func10_inner(arg1)
		return true
	end

	local screenGui

	getgenv().match = false
	local flag = true
	local tbl4 = {}

	task.spawn(function()
		while true do
			if LocalPlayer then
				getgenv().match = LocalPlayer:GetAttribute("Match") and true or false
			end
			task.wait(0.1)
		end
	end)

	task.spawn(function()
		while task.wait(0.1) do
			local match = LocalPlayer:GetAttribute("Match")
			local tbl = {}

			if match then
				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player:GetAttribute("Match") == match then
						local Character = player.Character
						if Character and Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0 then
							table.insert(tbl, player)
						end
					end
				end
			end

			tbl4 = tbl
		end
	end)

	task.spawn(function()
		local v3
		local connection

		while task.wait(0.1) do
			local Character = LocalPlayer.Character
			local v2
			local tbl = {LocalPlayer:FindFirstChild("Backpack")}

			if Character then
				table.insert(tbl, Character)
			end

			for _, v1 in ipairs(tbl) do
				if v1 then
					for _, child in ipairs(v1:GetChildren()) do
						if child:IsA("Tool") and child:FindFirstChild("Fire") and child:FindFirstChild("Reload") then
							v2 = child
							break
						end
					end
				end
				if v2 then
					break
				end
			end

			if v2 then
				if v2 ~= v3 then
					v3 = v2

					if connection then
						connection:Disconnect()
					end

					local Fire = v2:FindFirstChild("Fire")

					if Fire and Fire:IsA("Sound") then
						connection = Fire.Played:Connect(function()
							lastFiredTime = tick()
						end)
					end
				end
			else
				v3 = nil
				if connection then
					connection:Disconnect()
					connection = nil
				end
			end
		end
	end)

	local function func12()
		local Character = LocalPlayer.Character
		local tbl = {LocalPlayer:FindFirstChild("Backpack")}

		if Character then
			table.insert(tbl, Character)
		end

		for _, v1 in ipairs(tbl) do
			if v1 then
				for _, child in ipairs(v1:GetChildren()) do
					if child:IsA("Tool") and child:FindFirstChild("Fire") and child:FindFirstChild("Reload") then
						return child
					end
				end
			end
		end

		return nil
	end

	local function func13()
		local Character = LocalPlayer.Character
		local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")

		if not Character or not Backpack then
			return false
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if not Humanoid or Humanoid.Health <= 0 then
			return false
		end

		if getgenv().match then
			local v1 = func12()
			if v1 then
				Humanoid:EquipTool(v1)
				return true
			end
		end

		return false
	end

	local function func14()
		local Character = LocalPlayer.Character
		local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")

		if not Character or not Backpack then
			return false
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if not Humanoid or Humanoid.Health <= 0 then
			return false
		end

		if getgenv().match then
			for _, child in ipairs(Backpack:GetChildren()) do
				if child:IsA("Tool") and child:GetAttribute("EquipAnimation") == "Knife_Equip" then
					Humanoid:EquipTool(child)
					return true
				end
			end
		end

		return false
	end

	local v1 = Color3.fromRGB(255, 255, 255)

	local function func15(arg1, arg2)
		local function func(cFrame)
			local part = Instance.new("Part")
			part.Size = Vector3.new(0.1, 0.1, 0.1)
			part.Transparency = 1
			part.CanCollide = false
			part.CanQuery = false
			part.CanTouch = false
			part.Anchored = true
			part.CFrame = cFrame
			part.Parent = workspace
			return part
		end

		local v2 = func(CFrame.lookAt(arg1, arg2) * CFrame.new(0, 0, -1))
		local v3 = func(CFrame.new(arg2))
		local beam = Instance.new("Beam")
		beam.Texture = ""
		beam.TextureLength = 1
		beam.TextureMode = Enum.TextureMode.Stretch
		beam.TextureSpeed = 0
		beam.Color = ColorSequence.new(v1)
		beam.LightEmission = 1
		beam.LightInfluence = 0
		beam.Brightness = 5
		beam.Width0 = 0
		beam.Width1 = 0
		beam.Attachment0 = Instance.new("Attachment", v2)
		beam.Attachment1 = Instance.new("Attachment", v3)
		beam.Parent = v2

		local tween = TweenService:Create(
			beam,
			TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.In),
			{Width0 = 0.3, Width1 = 0.6}
		)

		local tween1 = TweenService:Create(
			beam,
			TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
			{Width0 = 0, Width1 = 0}
		)

		tween:Play()

		tween.Completed:Connect(function()
			tween1:Play()
		end)

		Debris:AddItem(v2, 0.3)
		Debris:AddItem(v3, 0.3)
	end

	local function func16(character)
		local v1 = character and character:FindFirstChild("HumanoidRootPart")

		if not v1 then
			return
		end

		return (v1.CFrame * CFrame.new(0, 0, v1.Size.Z / 2)).Position
	end

	local function func17(player)
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local v1 = func16(Character)

		if not v1 then
			return
		end

		local v2 = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
		local v3 = func12()

		if not v3 then
			return
		end

		if v2 then
			flag = false
			local Position = v2.Position
			local Muzzle = v3:FindFirstChild("Muzzle", true)
			func15(Muzzle and Muzzle.WorldPosition or v1, Position)
			ReplicatedStorage.Remotes.ShootGun:FireServer(v1, Position, v2, Position)
			local v4 = v3 and v3:FindFirstChild("Fire")

			if v4 and v4:IsA("Sound") then
				v4:Play()
			end

			task.delay(2.5, function()
				flag = true
			end)
		end
	end

	local v2 = Window:Tab({Title = "👑 Premium", Icon = "crown", Locked = false}):Section({Title = "👑 Premium Access (Unlocked)", Opened = true})

	v2:Button({
		Title = "👑 Premium Status",
		Desc = "All features are permanently unlocked.",
		Locked = false,
		Callback = function()
			module:Notify({Title = "👑 Premium Status", Content = "Unlocked", Duration = 4})
		end,
	})

	local v4 = Window:Tab({Title = "Main", Icon = "house", Locked = false})
	local v5 = v4:Section({Title = "Configuration", Opened = true})
	local flag1 = false

	v5:Toggle({
		Title = "Auto UnAnchor Character",
		Desc = "Lets you bypass the 5 second wait before the match starts",
		Icon = "check",
		Default = false,
		Flag = "AutoAunacnchorToggle",
		Callback = function(value)
			flag1 = value

			local function func(character)
				local HumanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
				local Humanoid = character:WaitForChild("Humanoid", 5)

				if not HumanoidRootPart or not Humanoid then
					return
				end

				local connection

				connection = RunService.Heartbeat:Connect(function()
					if not character.Parent or Humanoid.Health <= 0 then
						connection:Disconnect()
						return
					end
					if HumanoidRootPart.Anchored and flag1 then
						HumanoidRootPart.Anchored = false
					end
				end)
			end

			if LocalPlayer.Character then
				task.spawn(func, LocalPlayer.Character)
			end

			LocalPlayer.CharacterAdded:Connect(func)
		end,
	})

	v5:Colorpicker({
		Title = "Bullet Tracer Color",
		Desc = "Changes the color of your bullet tracer",
		Flag = "BulletTracerColorPicker",
		Default = v1,
		Locked = false,
		Callback = function(value)
			v1 = value
		end,
	})

	v4:Space()
	getgenv().autoshoot_enabled = false
	getgenv().max_distance = 300
	getgenv().autoshoot_cooldown = 2
	local v29
	local v6

	v6 = func(v4:Toggle({
		Title = "👑 Enable Autoshoot",
		Desc = "[Premium] Automatically shoots enemies for you blatantly.",
		Icon = "check",
		Default = false,
		Flag = "EnableAutoShootToggle",
		Callback = function(value)
			getgenv().autoshoot_enabled = value

			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})

			if v29 then
				task.cancel(v29)
				v29 = nil
			end

			if getgenv().autoshoot_enabled then
				local function func(arg1, arg2, arg3, arg4)
					local raycastParams = RaycastParams.new()
					raycastParams.FilterDescendantsInstances = {arg3, arg4}
					raycastParams.FilterType = Enum.RaycastFilterType.Exclude
					local v1 = workspace:Raycast(arg1, arg2 - arg1, raycastParams)

					if v1 and not v1.Instance:IsDescendantOf(arg4) then
						return false
					end

					return true
				end
				v29 = task.spawn(function()
					while getgenv().autoshoot_enabled do
						local Character = LocalPlayer.Character
						local v1 = Character and Character:FindFirstChild("HumanoidRootPart")
						local v2 = Character and Character:FindFirstChild("Humanoid")

						if getgenv().match and v1 and v2 and v2.Health > 0 then
							local v9
							local v3 = getgenv().max_distance or 1000

							for _, v4 in ipairs(tbl4) do
								local Character1 = v4.Character
								local v5 = Character1 and Character1:FindFirstChild("HumanoidRootPart")
								local v6 = Character1 and Character1:FindFirstChild("Humanoid")

								if v4 ~= LocalPlayer and v6 and v6.Health > 0 and v5 then
									local Magnitude = (v5.Position - v1.Position).Magnitude
									if Magnitude < v3 then
										local v7 = not v4.Team or v4.Team ~= LocalPlayer.Team
										local v8 = CurrentCamera.CFrame.LookVector:Dot((v5.Position - CurrentCamera.CFrame.Position).Unit) >= 0.9

										if v7 and v8 then
											v3 = Magnitude
											v9 = v4
										end
									end
								end
							end

							if v9 and flag then
								local Character2 = v9.Character
								local v10 = Character2 and Character2:FindFirstChild("HumanoidRootPart")

								if v10 and func(v1.Position, v10.Position, Character, Character2) then
									func17(v9)
								end
							end
						end

						task.wait(0.03)
					end
				end)
			end
		end,
	}))

	v4:Slider({
		Title = "Autoshoot Max Distance",
		Step = 1,
		Flag = "AutoshootMaxDistanceSlider",
		Value = {Min = 0, Max = 1000, Default = 300},
		Callback = function(value)
			getgenv().max_distance = value
		end,
	})

	v4:Slider({
		Title = "Cooldown",
		Step = 0.5,
		Flag = "AutoshootCooldownSlider",
		Value = {Min = 0.5, Max = 10, Default = 2},
		Callback = function(value)
			getgenv().autoshoot_cooldown = value
		end,
	})

	v4:Space()
	getgenv().auto_throw_enabled = false
	getgenv().throw_cooldown = 2
	local v30
	local num1 = 0

	local function func19(character)
		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

		if not Tool or not Tool:FindFirstChild("RightHandle") then
			return
		end

		local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local v1 = func16(game.Players.LocalPlayer.Character)
		local Unit = (HumanoidRootPart.Position - v1).Unit
		ReplicatedStorage.Remotes.ThrowStart:FireServer(v1, Unit)

		require(ReplicatedStorage.Modules.KnifeProjectileController)({
			Speed = Tool:GetAttribute("ThrowSpeed"),
			KnifeProjectile = Tool.RightHandle:Clone(),
			Direction = Unit,
			Origin = v1,
		}, function(arg1)
			ReplicatedStorage.Remotes.ThrowHit:FireServer(arg1 and arg1.Instance, arg1 and arg1.Position)
		end)

		num1 = tick()
	end

	local v7

	v7 = func(v4:Toggle({
		Title = "👑 Enable auto throw knife",
		Desc = "[Premium] Automatically throws your knife at enemies",
		Default = false,
		Flag = "EnableAutoThrowKnifeToggle",
		Callback = function(value)
			getgenv().auto_throw_enabled = value

			if v30 then
				task.cancel(v30)
				v30 = nil
			end

			if value then
				v30 = task.spawn(function()
					while getgenv().auto_throw_enabled do
						if tick() - num1 >= getgenv().throw_cooldown then
							local Character = game.Players.LocalPlayer.Character
							local v1 = Character and Character:FindFirstChild("HumanoidRootPart")

							if v1 then
								local Character1
								local max_distance = getgenv().max_distance

								for _, v2 in tbl4 do
									if
										v2 ~= game.Players.LocalPlayer
										and v2.Character
										and v2.Team ~= LocalPlayer.Team
									then
										local HumanoidRootPart = v2.Character:FindFirstChild("HumanoidRootPart")
										local Humanoid = v2.Character:FindFirstChild("Humanoid")

										if HumanoidRootPart and Humanoid and Humanoid.Health > 0 then
											local Magnitude = (HumanoidRootPart.Position - v1.Position).Magnitude
											local raycastParams = RaycastParams.new()
											raycastParams.FilterDescendantsInstances = {Character, v2.Character}
											raycastParams.FilterType = Enum.RaycastFilterType.Exclude
											local v3 = workspace:Raycast(v1.Position, HumanoidRootPart.Position - v1.Position, raycastParams)

											if Magnitude < max_distance and not v3 then
												max_distance = Magnitude
												Character1 = v2.Character
											end
										end
									end
								end

								if Character1 then
									func19(Character1)
								end
							end
						end
						task.wait(0.1)
					end
				end)
			end
		end,
	}))

	v4:Slider({
		Title = "Max Throw Distance",
		Value = {Min = 0, Max = 1000, Default = 300},
		Callback = function(value)
			getgenv().max_distance = value
		end,
	})

	v4:Slider({
		Title = "Cooldown",
		Value = {Min = 0.5, Max = 10, Default = 2},
		Callback = function(value)
			getgenv().throw_cooldown = value
		end,
	})

	v4:Space()
	getgenv().triggerbot_enabled = false
	getgenv().triggerbot_firing = false
	getgenv().triggerbot_cooldown = 1

	local function func20(player)
		if not player or player == LocalPlayer then
			return false
		end

		local Character = player.Character

		if not Character or Character.Parent ~= Workspace then
			return false
		end

		if player.Team and player.Team == LocalPlayer.Team then
			return false
		end

		local Humanoid = Character:FindFirstChild("Humanoid")
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

		if not (Humanoid and HumanoidRootPart and v1) then
			return false
		end

		if Humanoid.Health <= 0 then
			return false
		end

		if CollectionService:HasTag(Character, "Invulnerable") or CollectionService:HasTag(Character, "SpeedTrail") then
			return false
		end

		return true
	end

	local function func21(player)
		local Character = LocalPlayer.Character
		local v1 = Character and Character:FindFirstChild("HumanoidRootPart")
		local v2 = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

		if not (v1 and v2) then
			getgenv().triggerbot_firing = false
			return
		end

		if
			player.Character:FindFirstChild("LowerTorso")
			or player.Character:FindFirstChild("UpperTorso")
			or player.Character:FindFirstChild("Head")
		then
			func17(player)
		else
			getgenv().triggerbot_firing = false
		end
	end

	RunService.Heartbeat:Connect(function()
		if not getgenv().triggerbot_enabled or not getgenv().match or getgenv().triggerbot_firing then
			return
		end

		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local MouseLocation = UserInputService:GetMouseLocation()
		local v1 = CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = {Character}
		raycastParams.IgnoreWater = true
		local v2 = Workspace:Raycast(v1.Origin, v1.Direction * 2000, raycastParams)

		if not v2 then
			return
		end

		local Model = v2.Instance:FindFirstAncestorOfClass("Model")

		if not Model then
			return
		end

		local PlayerFromCharacter = Players:GetPlayerFromCharacter(Model)

		if PlayerFromCharacter and func20(PlayerFromCharacter) then
			getgenv().triggerbot_firing = true
			func21(PlayerFromCharacter)

			task.delay(getgenv().triggerbot_cooldown, function()
				getgenv().triggerbot_firing = false
			end)
		end
	end)

	v4:Toggle({
		Title = "Trigger Bot",
		Desc = "Automatically shoots when your mouse hovers over an enemy",
		Icon = "check",
		Default = false,
		Flag = "TriggerBotToggle",
		Callback = function(value)
			getgenv().triggerbot_enabled = value
			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})
		end,
	})

	v4:Slider({
		Title = "Trigger Bot Cooldown",
		Step = 0.1,
		Flag = "TriggerBotCooldownSlider",
		Value = {Min = 0, Max = 3, Default = 1},
		Callback = function(value)
			getgenv().triggerbot_cooldown = value
		end,
	})

	v4:Space()
	getgenv().hitbox_expander = false
	getgenv().hitbox_size = 13
	getgenv().hitbox_color = Color3.fromRGB(255, 0, 0)

	function func22()
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				local HumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
				if HumanoidRootPart then
					HumanoidRootPart.Size = Vector3.new(2, 2, 1)
					HumanoidRootPart.CanCollide = false
					local hit_box = HumanoidRootPart:FindFirstChild("hit_box")

					if hit_box then
						hit_box:Destroy()
					end
				end
			end
		end
	end

	local v8

	v8 = func(v4:Toggle({
		Title = "👑 Enable Hitbox Expander",
		Desc = "[Premium] Adds expanded hitbox to all enemies",
		Icon = "check",
		Default = false,
		Flag = "HitboxEnableToggle",
		Callback = function(value)
			getgenv().hitbox_expander = value

			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})

			if not getgenv().hitbox_expander then
				func22()
				return
			end

			task.spawn(function()
				while getgenv().hitbox_expander and task.wait(0.1) do
					for _, player in pairs(Players:GetPlayers()) do
						if player ~= LocalPlayer and player.Character then
							local HumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
							if HumanoidRootPart then
								if player.Team ~= LocalPlayer.Team then
									HumanoidRootPart.Size = Vector3.new(getgenv().hitbox_size, getgenv().hitbox_size, getgenv().hitbox_size)
									HumanoidRootPart.CanCollide = true
									local hit_box = HumanoidRootPart:FindFirstChild("hit_box")

									if not hit_box then
										local boxHandleAdornment = Instance.new("BoxHandleAdornment")
										boxHandleAdornment.Name = "hit_box"
										boxHandleAdornment.Adornee = HumanoidRootPart
										boxHandleAdornment.AlwaysOnTop = true
										boxHandleAdornment.ZIndex = 10
										boxHandleAdornment.Size = HumanoidRootPart.Size
										boxHandleAdornment.Color3 = getgenv().hitbox_color
										boxHandleAdornment.Transparency = 0.8
										boxHandleAdornment.Parent = HumanoidRootPart
									else
										hit_box.Size = HumanoidRootPart.Size
									end
								else
									HumanoidRootPart.Size = Vector3.new(2, 2, 1)
									HumanoidRootPart.CanCollide = false
									local hit_box1 = HumanoidRootPart:FindFirstChild("hit_box")

									if hit_box1 then
										hit_box1:Destroy()
									end
								end
							end
						end
					end
				end
				func22()
			end)
		end,
	}))

	v4:Slider({
		Title = "Hitbox Size",
		Step = 1,
		Flag = "HitboxSizeSlider",
		Value = {Min = 5, Max = 100, Default = 13},
		Callback = function(value)
			getgenv().hitbox_size = value
		end,
	})

	v4:Colorpicker({
		Title = "Hitbox Color",
		Default = Color3.fromRGB(255, 0, 0),
		Transparency = 0,
		Locked = false,
		Flag = "HitboxColorPicker",
		Callback = function(value)
			getgenv().hitbox_color = value
		end,
	})

	v4:Space()
	getgenv().original_cooldowns = {}

	v4:Toggle({
		Title = "Remove Gun Cooldown",
		Desc = "You may need to re-equip your weapon for changes to apply",
		Icon = "check",
		Default = false,
		Flag = "RemoveGunCooldownToggle",
		Callback = function(value)
			getgenv().remove_gun_cooldown = value

			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})

			if value then
				getgenv().original_cooldowns = {}
				task.spawn(function()
					while getgenv().remove_gun_cooldown do
						task.wait(0.1)
						local tbl = {}

						for _, v1 in ipairs({LocalPlayer:FindFirstChild("Backpack"), LocalPlayer.Character}) do
							if v1 then
								for _, child in ipairs(v1:GetChildren()) do
									if child:IsA("Tool") and child:FindFirstChild("Fire") then
										table.insert(tbl, child)
									end
								end
							end
						end

						for _, v2 in ipairs(tbl) do
							if getgenv().original_cooldowns[v2] == nil then
								getgenv().original_cooldowns[v2] = v2:GetAttribute("Cooldown")
							end
							if v2:GetAttribute("Cooldown") ~= 0 then
								v2:SetAttribute("Cooldown", 0)
							end
						end
					end
				end)
			else
				for k, original_cooldown in pairs(getgenv().original_cooldowns) do
					if k and k.Parent then
						k:SetAttribute("Cooldown", original_cooldown)
					end
				end
				getgenv().original_cooldowns = {}
			end
		end,
	})

	local v9 = Window:Tab({Title = "Esp Highlights", Icon = "eye", Locked = false})
	getgenv().esp_team_color = Color3.fromRGB(0, 255, 0)
	getgenv().esp_enemy_color = Color3.fromRGB(255, 0, 0)
	getgenv().esp_charms_highlighter = false
	local v10 = CoreGui:FindFirstChild("Highlights") or Instance.new("Folder")
	v10.Name = "CharmsESP"
	v10.Parent = CoreGui

	v9:Toggle({
		Title = "Enable Charms Highlighter",
		Desc = "Highlights players full body",
		Icon = "check",
		Default = false,
		Flag = "EspCharmsToggle",
		Callback = function(value)
			getgenv().esp_charms_highlighter = value

			if not getgenv().esp_charms_highlighter then
				module:Notify({
					Title = "Disabled Feature!!",
					Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
					Duration = 3,
				})

				for _, child in ipairs(v10:GetChildren()) do
					child:Destroy()
				end

				return
			end

			module:Notify({
				Title = "Activated Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})

			task.spawn(function()
				while getgenv().esp_charms_highlighter do
					task.wait(0.1)
					local v1 = tbl4

					for _, v2 in v1 do
						if not getgenv().esp_charms_highlighter then
							break
						end
						if v2 ~= LocalPlayer and v2.Character then
							local v3 = v10:FindFirstChild(v2.Name)

							if not v3 then
								local highlight = Instance.new("Highlight")
								v3 = highlight
								highlight.Name = v2.Name
								highlight.FillTransparency = 0.6
								highlight.OutlineTransparency = 0.4
								highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
								highlight.Parent = v10
							end

							local v4 = v2.Team == LocalPlayer.Team and getgenv().esp_team_color or getgenv().esp_enemy_color
							v3.FillColor = v4
							v3.OutlineColor = v4
							v3.Adornee = v2.Character
						end
					end
				end
			end)
		end,
	})

	getgenv().esp_skeleton = false
	local v11 = CoreGui:FindFirstChild("Skeletons") or Instance.new("Folder")
	v11.Name = "Skeletons"
	v11.Parent = CoreGui

	v9:Toggle({
		Title = "Enable Skeletal Highlighter",
		Desc = "Highlights players skeleton",
		Icon = "check",
		Default = false,
		Flag = "EspSkeletonToggle",
		Callback = function(value)
			getgenv().esp_skeleton = value

			if not value then
				for _, child in ipairs(v11:GetChildren()) do
					child:Destroy()
				end

				module:Notify({
					Title = "Disabled Feature!!",
					Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
					Duration = 3,
				})

				return
			end

			module:Notify({
				Title = "Activated Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})

			task.spawn(function()
				local tbl = {
					{"Head", "UpperTorso"},
					{"UpperTorso", "LowerTorso"},
					{"UpperTorso", "LeftUpperArm"},
					{"LeftUpperArm", "LeftLowerArm"},
					{"LeftLowerArm", "LeftHand"},
					{"UpperTorso", "RightUpperArm"},
					{"RightUpperArm", "RightLowerArm"},
					{"RightLowerArm", "RightHand"},
					{"LowerTorso", "LeftUpperLeg"},
					{"LeftUpperLeg", "LeftLowerLeg"},
					{"LeftLowerLeg", "LeftFoot"},
					{"LowerTorso", "RightUpperLeg"},
					{"RightUpperLeg", "RightLowerLeg"},
					{"RightLowerLeg", "RightFoot"},
				}

				while getgenv().esp_skeleton do
					task.wait(0.1)

					for _, v1 in tbl4 do
						local Character = v1.Character
						local v2 = v11:FindFirstChild(v1.Name)

						if
							Character
							and Character:FindFirstChild("HumanoidRootPart")
							and Character:FindFirstChild("Humanoid")
							and Character.Humanoid.Health > 0
						then
							if not v2 then
								local folder = Instance.new("Folder")
								v2 = folder
								folder.Name = v1.Name
								folder.Parent = v11
							end

							local v3 = v1.Team == LocalPlayer.Team and getgenv().esp_team_color or getgenv().esp_enemy_color

							for i, v4 in ipairs(tbl) do
								local v5 = Character:FindFirstChild(v4[1])
								local v6 = Character:FindFirstChild(v4[2])

								if v5 and v6 then
									local v7 = v2:FindFirstChild(tostring(i))

									if not v7 then
										local lineHandleAdornment = Instance.new("LineHandleAdornment")
										lineHandleAdornment.Thickness = 2
										lineHandleAdornment.ZIndex = 10
										lineHandleAdornment.AlwaysOnTop = true
										v7 = lineHandleAdornment
									end

									v7.Name = tostring(i)
									v7.Color3 = v3
									v7.Adornee = v5
									v7.CFrame = CFrame.new(Vector3.zero, v5.CFrame:PointToObjectSpace(v6.Position))
									v7.Length = (v5.Position - v6.Position).Magnitude
									v7.Parent = v2
								end
							end
						elseif v2 then
							v2:Destroy()
						end
					end

					for _, child in ipairs(v11:GetChildren()) do
						if not Players:FindFirstChild(child.Name) then
							child:Destroy()
						end
					end
				end

				for _, child1 in ipairs(v11:GetChildren()) do
					child1:Destroy()
				end
			end)
		end,
	})

	getgenv().esp_tracers = false
	local v12 = CoreGui:FindFirstChild("Tracers") or Instance.new("Folder")
	v12.Name = "Tracers"
	v12.Parent = CoreGui
	local v31

	v9:Toggle({
		Title = "Enable Tracers Highlighter",
		Desc = "Draws lines from your character to others smoothly.",
		Icon = "check",
		Default = false,
		Flag = "EspTracersToggle",
		Callback = function(value)
			getgenv().esp_tracers = value

			if v31 then
				v31:Disconnect()
				v31 = nil
			end

			if not value then
				for _, child in ipairs(v12:GetChildren()) do
					child:Destroy()
				end

				module:Notify({
					Title = "Disabled Feature!!",
					Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
					Duration = 3,
				})

				return
			end

			module:Notify({
				Title = "Activated Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})

			v31 = RunService.RenderStepped:Connect(function()
				if not getgenv().esp_tracers then
					if v31 then
						v31:Disconnect()
						v31 = nil
					end

					for _, child in ipairs(v12:GetChildren()) do
						child:Destroy()
					end

					return
				end

				local Character = LocalPlayer.Character
				local v1 = Character and Character:FindFirstChild("HumanoidRootPart")

				if v1 then
					for _, v2 in ipairs(tbl4) do
						if v2 ~= LocalPlayer and v2.Parent then
							local Character1 = v2.Character
							local v3 = v12:FindFirstChild(v2.Name)

							if
								Character1
								and Character1:FindFirstChild("HumanoidRootPart")
								and Character1:FindFirstChild("Humanoid")
								and Character1.Humanoid.Health > 0
							then
								if not v3 then
									local lineHandleAdornment = Instance.new("LineHandleAdornment")
									v3 = lineHandleAdornment
									lineHandleAdornment.Name = v2.Name
									lineHandleAdornment.Thickness = 1.5
									lineHandleAdornment.ZIndex = 10
									lineHandleAdornment.AlwaysOnTop = true
									lineHandleAdornment.Parent = v12
								end

								local HumanoidRootPart = Character1.HumanoidRootPart
								v3.Color3 = v2.Team == LocalPlayer.Team and getgenv().esp_team_color or getgenv().esp_enemy_color
								v3.Adornee = workspace.Terrain
								v3.CFrame = CFrame.lookAt(v1.Position, HumanoidRootPart.Position)
								v3.Length = (v1.Position - HumanoidRootPart.Position).Magnitude
							elseif v3 then
								v3:Destroy()
							end
						end
					end
				else
					for _, child1 in ipairs(v12:GetChildren()) do
						child1:Destroy()
					end
				end

				for _, child2 in ipairs(v12:GetChildren()) do
					if not Players:FindFirstChild(child2.Name) then
						child2:Destroy()
					end
				end
			end)
		end,
	})

	v9:Colorpicker({
		Title = "Team Color Highlight",
		Desc = "Esp color for teammates",
		Default = Color3.fromRGB(0, 255, 0),
		Transparency = 0,
		Locked = false,
		Flag = "EspTeamColorPicker",
		Callback = function(value)
			getgenv().esp_team_color = value
		end,
	})

	v9:Colorpicker({
		Title = "Enemy Color Highlight",
		Desc = "Esp color for enemies",
		Default = Color3.fromRGB(255, 0, 0),
		Transparency = 0,
		Locked = false,
		Flag = "EspEnemyColorPicker",
		Callback = function(value)
			getgenv().esp_enemy_color = value
		end,
	})

	local v13 = Window:Tab({Title = "Kill All", Icon = "skull", Locked = false})
	getgenv().autoKillGun = false

	func(v13:Button({
		Title = "👑 [GUN] Kill all players once",
		Desc = "[Premium] Kills all players in your server once",
		Locked = false,
		Callback = function()
			if getgenv().match and LocalPlayer:GetAttribute("Match") then
				func13()

				module:Notify({
					Title = "Killing all players!",
					Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
					Duration = 3,
				})

				for _, v1 in tbl4 do
					if
						v1.Team ~= LocalPlayer.Team
						and v1.Character
						and v1.Character:FindFirstChild("HumanoidRootPart")
					then
						local HumanoidRootPart = v1.Character.HumanoidRootPart
						local v2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

						if v2 then
							ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ShootGun"):FireServer(v2.Position, HumanoidRootPart.Position, HumanoidRootPart, HumanoidRootPart.Position)
						end
					end
					task.wait(0.1)
				end
			end
		end,
	}))

	local v14

	v14 = func(v13:Toggle({
		Title = "👑 [GUN] Auto kill all players",
		Desc = "[Premium] Kills everyone constantly in your server with gun",
		Value = false,
		Flag = "AutoKillGunToggle",
		Callback = function(value)
			getgenv().autoKillGun = value

			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})
		end,
	}))

	task.spawn(function()
		while true do
			if getgenv().autoKillGun and LocalPlayer:GetAttribute("Match") then
				func13()
				for _, v1 in tbl4 do
					if
						v1.Team ~= LocalPlayer.Team
						and v1.Character
						and v1.Character:FindFirstChild("HumanoidRootPart")
					then
						local HumanoidRootPart = v1.Character.HumanoidRootPart
						local v2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

						if v2 then
							ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ShootGun"):FireServer(v2.Position, HumanoidRootPart.Position, HumanoidRootPart, HumanoidRootPart.Position)
						end
					end
				end
			end
			task.wait(0.1)
		end
	end)

	getgenv().autoKillKnife = false

	func(v13:Button({
		Title = "👑 [KNIFE] Kill all players once",
		Desc = "[Premium] Kills all players in your server once",
		Locked = false,
		Callback = function()
			if getgenv().match and LocalPlayer:GetAttribute("Match") then
				func14()

				module:Notify({
					Title = "Killing all players!",
					Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
					Duration = 3,
				})

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player.Character then
						local Humanoid = player.Character:FindFirstChild("Humanoid")
						local HumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

						if Humanoid and Humanoid.Health > 0 and HumanoidRootPart then
							ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ThrowHit"):FireServer(HumanoidRootPart, HumanoidRootPart.Position)
						end
					end
					task.wait(0.1)
				end
			end
		end,
	}))

	local v15

	v15 = func(v13:Toggle({
		Title = "👑 [KNIFE] Auto kill all players",
		Desc = "[Premium] Kills everyone constantly in your server with knife",
		Value = false,
		Flag = "AutoKillKnifeToggle",
		Callback = function(value)
			getgenv().autoKillKnife = value

			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})
		end,
	}))

	task.spawn(function()
		while true do
			if getgenv().autoKillKnife and LocalPlayer:GetAttribute("Match") then
				func14()
				for _, v1 in tbl4 do
					if v1 ~= LocalPlayer and v1.Character then
						local Humanoid = v1.Character:FindFirstChild("Humanoid")
						local HumanoidRootPart = v1.Character:FindFirstChild("HumanoidRootPart")

						if Humanoid and Humanoid.Health > 0 and HumanoidRootPart then
							ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ThrowHit"):FireServer(HumanoidRootPart, HumanoidRootPart.Position)
						end
					end
				end
			end
			task.wait(0.1)
		end
	end)

	local v16 = Window:Tab({Title = "Abilitys", Icon = "zap", Locked = false})
	getgenv().autoShroud = false
	getgenv().lowExecutorsShroud = false
	getgenv().shroudRate = 1

	local ok, result = pcall(function()
		return require(game:GetService("ReplicatedStorage").Ability.AbilityConfig)
	end)

	local ActivateShroud = ReplicatedStorage.Ability:WaitForChild("ActivateShroud")
	local v17 = not ok

	local tbl5 = {
		SprintCooldown = not v17 and result.SprintCooldown or 15,
		DashCooldown = not v17 and result.DashCooldown or 6,
		ShroudCooldown = not v17 and result.ShroudCooldown or 7,
		SoulReapCombatDelay = not v17 and result.SoulReapCombatDelay or 0.35,
	}

	local function func23(player)
		local Character = Players.LocalPlayer.Character
		if player and player.Character and Character then
			local HumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
			local HumanoidRootPart1 = Character:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart and HumanoidRootPart1 then
				if getgenv().lowExecutorsShroud then
					local Position = HumanoidRootPart1.Position
					ActivateShroud:FireServer(Position, (HumanoidRootPart.Position - Position).Unit)
				else
					local ok, result = pcall(function()
						return require(ReplicatedStorage.Modules.CharacterRayOrigin)
					end)

					local ok1, result1 = pcall(function()
						return require(ReplicatedStorage.Ability.ShroudProjectileController)
					end)

					if ok and ok1 then
						local v1 = result(Character)
						local Unit = (HumanoidRootPart.Position - v1).Unit
						ActivateShroud:FireServer(v1, Unit)
						result1(v1, Unit)
					else
						getgenv().lowExecutorsShroud = true
						local Position1 = HumanoidRootPart1.Position
						ActivateShroud:FireServer(Position1, (HumanoidRootPart.Position - Position1).Unit)
					end
				end
			end
		end
	end

	local v18

	v18 = func(v16:Toggle({
		Title = "👑 Auto Shroud All",
		Desc = "[Premium] Automatically blinds all enemies in match",
		Value = false,
		Flag = "AutoShroudAllToggle",
		Callback = function(value)
			getgenv().autoShroud = value
		end,
	}))

	v16:Toggle({
		Title = "Low Executor Mode",
		Desc = "Supports all executors, may not notice shroud box/sound but blinds enemy and saves FPS",
		Value = false,
		Callback = function(value)
			getgenv().lowExecutorsShroud = value
		end,
	})

	v16:Slider({
		Title = "Amount of Shrouds per Enemy",
		Desc = "Adjust firing rate per enemy, a high number increases fps for entire game",
		Step = 0.1,
		Value = {Min = 1, Max = 10000, Default = 1},
		Callback = function(value)
			getgenv().shroudRate = value
		end,
	})

	task.spawn(function()
		while true do
			if getgenv().autoShroud then
				for _, v1 in tbl4 do
					func23(v1)
				end
				task.wait(1 / getgenv().shroudRate)
			else
				task.wait(0.5)
			end
		end
	end)

	v16:Space()

	v16:Toggle({
		Title = "Remove Sprint Cooldown",
		Locked = false,
		Value = false,
		Callback = function(value)
			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})
			if not v17 then
				result.SprintCooldown = value and 0 or tbl5.SprintCooldown
			end
		end,
	})

	v16:Toggle({
		Title = "Remove Dash Cooldown",
		Locked = false,
		Value = false,
		Callback = function(value)
			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})
			if not v17 then
				result.DashCooldown = value and 0 or tbl5.DashCooldown
			end
		end,
	})

	v16:Toggle({
		Title = "Remove Shroud Cooldown",
		Locked = false,
		Value = false,
		Callback = function(value)
			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})
			if not v17 then
				result.ShroudCooldown = value and 0 or tbl5.ShroudCooldown
			end
		end,
	})

	v16:Toggle({
		Title = "Remove Soul Reap Combat Delay",
		Locked = false,
		Value = false,
		Callback = function(value)
			module:Notify({
				Title = value and "Activated Feature!!" or "Disabled Feature!!",
				Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
				Duration = 3,
			})
			if not v17 then
				result.SoulReapCombatDelay = value and 0 or tbl5.SoulReapCombatDelay
			end
		end,
	})

	v16:Space()

	v16:Slider({
		Title = "Sprint Time",
		Step = 0.5,
		Locked = false,
		Value = {Min = 0.5, Max = 10, Default = not v17 and result.SprintTime or 0},
		Callback = function(value)
			if not v17 then
				result.SprintTime = value
			end
		end,
	})

	v16:Slider({
		Title = "Sprint Boost",
		Step = 0.1,
		Locked = false,
		Value = {Min = 0, Max = 5, Default = not v17 and result.SprintBoost or 0},
		Callback = function(value)
			if not v17 then
				result.SprintBoost = value
			end
		end,
	})

	v16:Slider({
		Title = "Soul Reap Time",
		Step = 0.5,
		Locked = false,
		Value = {Min = 0.5, Max = 10, Default = not v17 and result.SoulReapTime or 0},
		Callback = function(value)
			if not v17 then
				result.SoulReapTime = value
			end
		end,
	})

	v16:Slider({
		Title = "Soul Reap Speed Boost",
		Step = 0.1,
		Locked = false,
		Value = {Min = 0.1, Max = 10, Default = not v17 and result.SoulReapSpeedBoost or 0},
		Callback = function(value)
			if not v17 then
				result.SoulReapSpeedBoost = value
			end
		end,
	})

	v16:Slider({
		Title = "Propeller Jump Boost",
		Step = 0.1,
		Locked = false,
		Value = {Min = 0.1, Max = 5, Default = not v17 and result.PropellerJumpBoost or 0},
		Callback = function(value)
			if not v17 then
				result.PropellerJumpBoost = value
			end
		end,
	})

	v16:Slider({
		Title = "Shroud Time",
		Step = 0.5,
		Locked = false,
		Value = {Min = 0.5, Max = 10, Default = not v17 and result.ShroudTime or 0},
		Callback = function(value)
			if not v17 then
				result.ShroudTime = value
			end
		end,
	})

	v16:Slider({
		Title = "Shroud Projectile Speed",
		Step = 2.5,
		Locked = false,
		Value = {Min = 2.5, Max = 100, Default = not v17 and result.ShroudProjectileSpeed or 0},
		Callback = function(value)
			if not v17 then
				result.ShroudProjectileSpeed = value
			end
		end,
	})

	v16:Slider({
		Title = "Shroud Projectile Range",
		Step = 5,
		Locked = false,
		Value = {Min = 5, Max = 1000, Default = not v17 and result.ShroudProjectileRange or 0},
		Callback = function(value)
			if not v17 then
				result.ShroudProjectileRange = value
			end
		end,
	})

	local v19 = Window:Tab({Title = "Teleport", Icon = "map-pin", Locked = false})
	local Lobby = workspace:WaitForChild("Lobby")
	local tbl6 = {DuelRing_1v1 = 1, DuelRing_2v2 = 2, DuelRing_3v3 = 3, DuelRing_4v4 = 4}
	local flag2 = false
	local v32
	local num2 = 0

	function func24()
		flag2 = false
		v32 = nil
	end

	local function func25(arg1)
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if Humanoid and HumanoidRootPart and arg1 and arg1.PrimaryPart then
			local Position = arg1.PrimaryPart.Position

			if (HumanoidRootPart.Position - Position).Magnitude <= 6 then
				getgenv().noclip = false

				for _, descendant in ipairs(Character:GetDescendants()) do
					if descendant:IsA("BasePart") then
						descendant.CanCollide = true
					end
				end

				return
			end

			Humanoid.WalkSpeed = 35
			Humanoid:MoveTo(Position)

			if os.clock() - num2 >= 2 then
				Humanoid.Jump = true
				num2 = os.clock()
			end

			getgenv().noclip = true

			for _, descendant1 in ipairs(Character:GetDescendants()) do
				if descendant1:IsA("BasePart") then
					descendant1.CanCollide = false
				end
			end
		end
	end

	local v20

	v20 = func(v19:Toggle({
		Title = "👑 Enable auto walk to duel pads",
		Desc = "[Premium] Automatically walks to an available duel pad accurately",
		Default = false,
		Flag = "AutoWalkDuelPadToggle",
		Callback = function(value)
			flag2 = value
		end,
	}))

	v19:Space()

	task.spawn(function()
		while true do
			if not LocalPlayer:GetAttribute("Match") and flag2 then
				local Character = LocalPlayer.Character
				local v1 = Character and Character:FindFirstChild("HumanoidRootPart")

				if v32 and v1 then
					local num = 1

					for k, v2 in pairs(tbl6) do
						if Lobby:FindFirstChild("DuelRingsGroup") and Lobby.DuelRingsGroup:FindFirstChild(k) then
							if Lobby.DuelRingsGroup[k]:FindFirstChild(v32.Name) then
								num = v2
								break
							end
						end
					end

					if num == 1 then
						local flag = false

						for _, player in ipairs(Players:GetPlayers()) do
							if player ~= LocalPlayer and player.Character then
								local HumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
								if HumanoidRootPart and (v1.Position - HumanoidRootPart.Position).Magnitude <= 8 then
									flag = true
									break
								end
							end
						end

						if not flag then
							v32 = nil
						end
					end
				end

				if v32 and v1 then
					local flag1 = false

					for _, child in ipairs(Lobby:GetChildren()) do
						if child.Name == "DuelRingsGroup" then
							for k1, v3 in pairs(tbl6) do
								local v4 = child:FindFirstChild(k1)
								if v4 and v4:FindFirstChild(v32.Name) then
									local num1 = 0
									local v5 = v3 * 2
									local flag3 = false

									for _, child1 in ipairs(v4:GetChildren()) do
										if child1:IsA("Model") and child1.Name == "DuelPad" then
											local v6 = child1:GetAttribute("CharacterCount") or 0
											num1 = num1 + v6

											if child1 == v32 and v6 < v3 then
												flag3 = true
											end
										end
									end

									if num1 == v5 - 1 and flag3 or num1 == v5 then
										flag1 = true
									end

									break
								end
							end
						end
						if flag1 then
							break
						end
					end

					if not flag1 then
						v32 = nil
					end
				end

				if not v32 then
					local flag4 = false
					for _, child2 in ipairs(Lobby:GetChildren()) do
						if child2.Name == "DuelRingsGroup" then
							for k2, v7 in pairs(tbl6) do
								local v8 = child2:FindFirstChild(k2)

								if v8 then
									local tbl = {}
									local num2 = 0
									local v9 = v7 * 2

									for _, child3 in ipairs(v8:GetChildren()) do
										if child3:IsA("Model") and child3.Name == "DuelPad" then
											local v10 = child3:GetAttribute("CharacterCount") or 0
											num2 = num2 + v10
											table.insert(tbl, {model = child3, count = v10})
										end
									end

									if num2 == v9 - 1 then
										for _, v11 in ipairs(tbl) do
											if v11.count < v7 then
												local flag5 = true

												if v7 == 1 then
													flag5 = false
													for _, player1 in ipairs(Players:GetPlayers()) do
														if player1 ~= LocalPlayer and player1.Character then
															local HumanoidRootPart1 = player1.Character:FindFirstChild("HumanoidRootPart")
															if
																HumanoidRootPart1
																and v11.model.PrimaryPart
																and (HumanoidRootPart1.Position - v11.model.PrimaryPart.Position).Magnitude <= 8
															then
																flag5 = true
																break
															end
														end
													end
												end

												if flag5 then
													func25(v11.model)

													if
														v1
														and v11.model.PrimaryPart
														and (v1.Position - v11.model.PrimaryPart.Position).Magnitude <= 6
													then
														v32 = v11.model
													end

													flag4 = true
													task.wait(0.5)
													break
												end
											end
										end
									end
								end

								if flag4 then
									break
								end
							end
						end
						if flag4 then
							break
						end
					end
				end
			else
				v32 = nil
			end
			task.wait(0.2)
		end
	end)

	if Lobby and Lobby:FindFirstChild("DuelRingsGroup") then
		for k in pairs(tbl6) do
			local v21 = Lobby.DuelRingsGroup:FindFirstChild(k)
			if v21 then
				local num3 = 1
				for _, child in ipairs(v21:GetChildren()) do
					if child:IsA("Model") and child.Name == "DuelPad" then
						v19:Button({
							Title = "Walk to " .. k .. " " .. (num3 % 2 == 1 and "Right" or "Left"),
							Locked = false,
							Callback = function()
								module:Notify({
									Title = "Walking to position!",
									Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
									Duration = 3,
								})
								func25(child)
							end,
						})
						num3 = num3 + 1
					end
				end
			end
		end
	end

	local v22 = Window:Tab({Title = "FOV Shooting", Icon = "crosshair", Locked = false})
	local flag3 = false
	local flag4 = false
	local flag5 = false
	local num4 = 100
	local num5 = 1
	local num6 = 0
	local drawing
	local v33
	local v23
	local v24;

	(function()
		if drawing then
			drawing:Remove()
		end

		drawing = Drawing.new("Circle")
		local drawingRef = drawing
		drawingRef.Thickness = 2
		drawingRef.NumSides = 64
		drawingRef.Radius = num4
		drawingRef.Color = Color3.fromRGB(255, 255, 255)
		drawingRef.Transparency = 1
		drawingRef.Visible = false
		drawingRef.Filled = false
	end)()

	local function func26()
		if drawing and (flag5 or (flag3 or flag4)) then
			local MouseLocation = UserInputService:GetMouseLocation()
			local drawingRef = drawing
			drawingRef.Position = Vector2.new(MouseLocation.X, MouseLocation.Y)
			drawingRef.Radius = num4
			drawingRef.Visible = true
		elseif drawing then
			drawing.Visible = false
		end
	end

	local function func27(arg1)
		local v1, v2 = CurrentCamera:WorldToViewportPoint(arg1)

		if not v2 then
			return false
		end

		local MouseLocation = UserInputService:GetMouseLocation()
		return math.sqrt((v1.X - MouseLocation.X) ^ 2 + (v1.Y - MouseLocation.Y) ^ 2) <= num4
	end

	local function func28(arg1, arg2, arg3)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, arg3}
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		local v1 = Workspace:Raycast(arg1, arg2 - arg1, raycastParams)

		if v1 and not v1.Instance:IsDescendantOf(arg3) then
			return false
		end

		return true
	end

	local function func29(player)
		if not player or player == LocalPlayer then
			return false
		end

		local Character = player.Character

		if not Character or Character.Parent ~= Workspace then
			return false
		end

		if player.Team and player.Team == LocalPlayer.Team then
			return false
		end

		local Humanoid = Character:FindFirstChild("Humanoid")
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

		if not (Humanoid and HumanoidRootPart and v1) or Humanoid.Health <= 0 then
			return false
		end

		if CollectionService:HasTag(Character, "Invulnerable") or CollectionService:HasTag(Character, "SpeedTrail") then
			return false
		end

		return true
	end

	local function func30(player)
		local Character = LocalPlayer.Character
		local v1 = Character and Character:FindFirstChild("HumanoidRootPart")
		local v2 = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

		if not (v1 and v2) then
			return false
		end

		if not func28(v1.Position, v2.Position, player.Character) then
			return false
		end

		if not func27(v2.Position) then
			return false
		end

		local v3 = tick()

		if v3 - num6 < num5 then
			return false
		end

		if
			player.Character:FindFirstChild("LowerTorso")
			or player.Character:FindFirstChild("UpperTorso")
			or player.Character:FindFirstChild("Head")
		then
			func17(player)
			num6 = v3
			return true
		end

		return false
	end

	RunService.Heartbeat:Connect(function()
		func26()

		if not flag3 or not LocalPlayer.Character then
			return
		end

		for _, player in pairs(Players:GetPlayers()) do
			if func29(player) and func30(player) then
				break
			end
		end
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end
		if flag4 and input.UserInputType == Enum.UserInputType.MouseButton1 then
			if tick() - num6 < num5 or not LocalPlayer.Character then
				return
			end
			for _, player in pairs(Players:GetPlayers()) do
				if func29(player) and func30(player) then
					break
				end
			end
		end
	end)

	local function func31()
		if v33 then
			task.cancel(v33)
		end
		v33 = task.spawn(function()
			while flag4 do
				task.wait()
				local v1 = Workspace:FindFirstChild(LocalPlayer.Name)

				if v1 then
					local GunController = v1:FindFirstChild("GunController")
					if GunController then
						GunController.Parent = nil
					end
				end
			end
		end)
	end

	function func32()
		flag3 = false
		flag4 = false

		if v33 then
			task.cancel(v33)
			v33 = nil
		end
	end

	v22:Toggle({
		Title = "Enable FOV Circle",
		Desc = "Show FOV circle around your mouse",
		Default = false,
		Flag = "EnableFovCircle",
		Callback = function(value)
			flag5 = value
		end,
	})

	v23 = func(v22:Toggle({
		Title = "👑 Autoshoot FOV",
		Desc = "[Premium] Automatically shoots enemies in your FOV circle",
		Default = false,
		Flag = "EnableAutoshootFov",
		Callback = function(value)
			flag3 = value
		end,
	}))

	v24 = func(v22:Toggle({
		Title = "👑 FOV Manual Shoot",
		Desc = "[Premium] Click to shoot enemies in FOV circle",
		Default = false,
		Flag = "EnableManualShootToggle",
		Callback = function(value)
			flag4 = value

			if value then
				func31()
			else
				if v33 then
					task.cancel(v33)
					v33 = nil
				end
			end
		end,
	}))

	v22:Slider({
		Title = "FOV Circle Size",
		Step = 5,
		Flag = "FovCircleSizeSlider",
		Value = {Min = 35, Max = 300, Default = 100},
		Callback = function(value)
			num4 = value
		end,
	})

	v22:Slider({
		Title = "FOV Autoshoot Cooldown",
		Step = 0.1,
		Flag = "FovAutoshootCooldownSlider",
		Value = {Min = 0, Max = 5, Default = 2},
		Callback = function(value)
			num5 = value
		end,
	})

	local v25 = Window:Tab({Title = "Misc", Icon = "folder", Locked = false})
	getgenv().original_speed = 16
	getgenv().speed_enabled = false
	getgenv().current_speed = 16
	getgenv().remove_gun_cooldown = false

	v25:Toggle({
		Title = "Auto Spin",
		Desc = "Auto spins for you when not in match",
		Default = false,
		Callback = function(value)
			getgenv().autoSpin = value
			task.spawn(function()
				while getgenv().autoSpin do
					if not LocalPlayer:GetAttribute("Match") then
						require(game:GetService("ReplicatedStorage").Dailies.SpinnerService).Spin()
					end
					task.wait(0.1)
				end
			end)
		end,
	})

	v25:Toggle({
		Title = "Noclip",
		Desc = "Allows you to walk through walls",
		Default = false,
		Callback = function(value)
			getgenv().noclip = value
			if value then
				module:Notify({
					Title = "Activated Feature!!",
					Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
					Duration = 3,
				})

				local connection

				connection = RunService.Stepped:Connect(function()
					if not getgenv().noclip then
						connection:Disconnect()
						return
					end

					local Character = LocalPlayer.Character

					if Character then
						for _, descendant in ipairs(Character:GetDescendants()) do
							if descendant:IsA("BasePart") then
								descendant.CanCollide = false
							end
						end
					end
				end)
			else
				module:Notify({
					Title = "Disabled Feature!!",
					Content = "Enjoying PinokioScripts? Join our discord server for even better stuff!",
					Duration = 3,
				})
			end
		end,
	})

	v25:Toggle({
		Title = "Enable Speed Changer",
		Desc = "Changes your walk speed",
		Icon = "check",
		Default = false,
		Flag = "SpeedChangerToggle",
		Callback = function(value)
			getgenv().speed_enabled = value
			if value then
				task.spawn(function()
					while getgenv().speed_enabled do
						local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")

						if v1 and v1.WalkSpeed ~= getgenv().current_speed then
							v1.WalkSpeed = getgenv().current_speed
						end

						task.wait(0.1)
					end
				end)
			else
				local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
				if v1 then
					v1.WalkSpeed = getgenv().original_speed
				end
			end
		end,
	})

	v25:Slider({
		Title = "Walk Speed",
		Step = 1,
		Value = {Min = 16, Max = 200, Default = 16},
		Flag = "SpeedChangerSlider",
		Callback = function(value)
			getgenv().current_speed = value
			if getgenv().speed_enabled then
				local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
				if v1 then
					v1.WalkSpeed = value
				end
			end
		end,
	})

	LocalPlayer.CharacterAdded:Connect(function(character)
		task.wait(0.2)
		if getgenv().speed_enabled then
			character:WaitForChild("Humanoid").WalkSpeed = getgenv().current_speed
		end
	end)

	local v26 = Window:Tab({Title = "Settings", Icon = "settings", Locked = false})

	v26:Button({
		Title = "Join Our Discord",
		Desc = "Copy Discord invite link to clipboard",
		Callback = function()
			if setclipboard then
				setclipboard("https://discord.gg/t6rhaAZvhG")
			elseif toclipboard then
				toclipboard("https://discord.gg/t6rhaAZvhG")
			end
			module:Notify({
				Title = "Discord Copied!",
				Content = "Discord link successfully copied to clipboard!",
				Duration = 3,
			})
		end,
	})

	v26:Space()
	local tbl7 = {}

	for k1 in pairs(module.Themes) do
		table.insert(tbl7, k1)
	end

	table.sort(tbl7)

	v26:Dropdown({
		Title = "Themes",
		Desc = "Select a theme",
		Flag = "SelectedTheme",
		Values = tbl7,
		Value = "Dark",
		Callback = function(value)
			module:SetTheme(value)
		end,
	})

	v26:Keybind({
		Title = "Keybind",
		Desc = "Keybind to open ui",
		Value = "LeftControl",
		Flag = "KeybindOpenWindow",
		Callback = function(value)
			Window:SetToggleKey(Enum.KeyCode[value])
		end,
	})

	v26:Space()
	local ConfigManager = Window.ConfigManager
	local str = "default"

	local v27 = v26:Input({
		Title = "Config Name",
		Value = "default",
		Callback = function(value)
			str = value
		end,
	})

	local v28 = v26:Dropdown({
		Title = "All Configs",
		Values = ConfigManager:AllConfigs(),
		Callback = function(value)
			str = value
			v27:Set(value)
		end,
	})

	v26:Button({
		Title = "Save Config",
		Callback = function()
			if ConfigManager:CreateConfig(str):Save() then
				v28:Refresh(ConfigManager:AllConfigs())
			end
		end,
	})

	v26:Button({
		Title = "Load Config",
		Callback = function()
			ConfigManager:CreateConfig(str):Load()
		end,
	})

	v26:Button({
		Title = "Delete Config",
		Callback = function()
			ConfigManager:CreateConfig(str):Delete()
			v28:Refresh(ConfigManager:AllConfigs())
		end,
	})

	module:Notify({Title = "Welcome to PinokioScripts MVSD", Duration = 15})
end

func10()
