do
	local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local Debris = game:GetService("Debris")
	local WORD = "NEXVYRHUB"
	local FONT = Enum.Font.Garamond
	local FX_LEVEL = 1
	local T = {
		beams = 0.00,
		compass = 0.00,
		divider = 0.20,
		letters = 0.35,
		step = 0.065,
		outro = 3.00,
	}
	local COL_GOLD = Color3.fromRGB(201, 169, 110)
	local COL_GOLD_L = Color3.fromRGB(246, 226, 178)
	local COL_DIM = Color3.fromRGB(58, 50, 40)
	local COL_BLACK = Color3.fromRGB(0, 0, 0)
	local function new(class, props, parent)
		local o = Instance.new(class)
		for k, v in pairs(props) do
			o[k] = v
		end

		o.Parent = parent
		return o
	end

	local running = setmetatable({}, { __mode = "k" })
	local function tw(inst, dur, props, style, dir)
		local rec = running[inst]
		if not rec then
			rec = {};
			running[inst] = rec
		end

		for k in pairs(props) do
			local old = rec[k]
			if old then
				old:Cancel()
			end
		end

		local t = TweenService:Create(inst, TweenInfo.new(dur, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
		for k in pairs(props) do
			rec[k] = t
		end

		t:Play()
		return t
	end

	local function setp(inst, props)
		local rec = running[inst]
		for k, v in pairs(props) do
			if rec and rec[k] then
				rec[k]:Cancel();
				rec[k] = nil
			end

			inst[k] = v
		end
	end

	local function rnd(a, b)
		return a + math.random() * (b - a)
	end

	local function kp(t, v)
		return NumberSequenceKeypoint.new(t, v)
	end

	local QUINT = Enum.EasingStyle.Quint
	local EXPO = Enum.EasingStyle.Exponential
	local BACK = Enum.EasingStyle.Back
	local SINE = Enum.EasingStyle.Sine
	local INOUT = Enum.EasingDirection.InOut
	local IN = Enum.EasingDirection.In
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	local prev = playerGui:FindFirstChild("NexvyrIntro")
	if prev then
		prev:Destroy()
	end

	local gui = new("ScreenGui", {
		Name = "NexvyrIntro",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 999,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	}, playerGui)
	local bgFrame = new("Frame", {
		Name = "bg",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = COL_BLACK,
		BorderSizePixel = 0,
		ZIndex = 0,
	}, gui)
	local world = new("CanvasGroup", {
		Name = "world",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 1,
	}, gui)
	local stage = new("Frame", {
		Name = "stage",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 3,
	}, gui)
	new("UIAspectRatioConstraint", {
		AspectRatio = 2,
		AspectType = Enum.AspectType.FitWithinMaxSize,
		DominantAxis = Enum.DominantAxis.Width,
	}, stage)
	local stageScale = new("UIScale", { Scale = 1 }, stage)
	local fx = new("Frame", {
		Name = "fx",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 20,
	}, stage)
	local flash = new("Frame", {
		Name = "flash",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = COL_GOLD_L,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 50,
	}, gui)
	local bgFill = new("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0,
		ZIndex = 1,
	}, world)
	new("UIGradient", {
		Color = ColorSequence.new(Color3.fromRGB(10, 9, 8), Color3.fromRGB(26, 19, 10)),
		Rotation = 90,
	}, bgFill)
	local beams = {}
	for i = 1, 5 do
		local b = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.fromScale(0.5 + (i - 3) * 0.14, -0.1),
			Size = UDim2.fromScale(0.07, 1.4),
			BackgroundColor3 = COL_GOLD,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 2,
		}, world)
		new("UIGradient", {
			Transparency = NumberSequence.new({ kp(0, 0.2), kp(0.6, 0.7), kp(1, 1) }),
			Rotation = 90
		}, b)

		beams[i] = { f = b, ph = i * 1.3, base = (i - 3) * 6 }
	end

	local function vignette(ax, ay, sx, sy, rot)
		local v = new("Frame", {
			AnchorPoint = Vector2.new(ax, ay),
			Position = UDim2.fromScale(ax, ay),
			Size = UDim2.fromScale(sx, sy),
			BackgroundColor3 = COL_BLACK,
			BorderSizePixel = 0,
			ZIndex = 5,
		}, world)
		new("UIGradient", { Transparency = NumberSequence.new(0.05, 1), Rotation = rot }, v)
	end

	vignette(0, 0, 0.22, 1, 0)
	vignette(1, 0, 0.22, 1, 180)
	vignette(0, 0, 1, 0.2, 90)
	vignette(0, 1, 1, 0.2, 270)
	local dustData = {}
	for i = 1, 18 do
		local sz = math.random(2, 4)
		local f = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Rotation = 45,
			Size = UDim2.fromOffset(sz, sz),
			BackgroundColor3 = (i % 3 == 0) and COL_GOLD_L or COL_GOLD,
			BackgroundTransparency = 0.6,
			BorderSizePixel = 0,
			ZIndex = 3,
		}, world)
		dustData[i] = {
			f = f,
			x = math.random(),
			y = math.random(),
			sp = rnd(0.02, 0.07),
			ph = rnd(0, 6.28)
		}
	end

	local function doFlash(power, dur, color)
		setp(flash, { BackgroundColor3 = color or COL_GOLD_L, BackgroundTransparency = power })
		tw(flash, dur or 0.3, { BackgroundTransparency = 1 })
	end

	local function dustBurst(sx, sy, count, color, dist)
		for _ = 1, count do
			local ang = rnd(-math.pi * 0.95, -math.pi * 0.05)
			local d = dist * rnd(0.4, 1.2)
			local sz = math.random(2, 4)
			local dur = rnd(0.5, 0.9)
			local f = new("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(sx, 0, sy, 0),
				Size = UDim2.fromOffset(sz, sz),
				Rotation = 45,
				BackgroundColor3 = color,
				BorderSizePixel = 0,
				ZIndex = 8,
			}, fx)
			tw(f, dur, {
				Position = UDim2.new(sx, math.cos(ang) * d, sy, math.sin(ang) * d),
				BackgroundTransparency = 1
			}, QUINT)

			Debris:AddItem(f, dur + 0.05)
		end
	end

	local function ringPulse(sx, sy, toScale, dur, color)
		local r = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(sx, sy),
			Size = UDim2.fromScale(0.05, 0.05),
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 7,
		}, fx)
		new("UICorner", { CornerRadius = UDim.new(1, 0) }, r)
		local st = new("UIStroke", { Thickness = 1.5, Color = color or COL_GOLD_L }, r)
		tw(r, dur, { Size = UDim2.fromScale(toScale, toScale) }, EXPO)
		tw(st, dur, { Transparency = 1 })
		Debris:AddItem(r, dur + 0.05)
	end

	local function flare(sy, dur)
		local f = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, sy),
			Size = UDim2.new(0, 0, 0, 2),
			BackgroundColor3 = COL_GOLD_L,
			BorderSizePixel = 0,
			ZIndex = 9,
		}, fx)
		new("UIGradient", { Transparency = NumberSequence.new({ kp(0, 1), kp(0.5, 0), kp(1, 1) }) }, f)
		tw(f, dur, { Size = UDim2.new(1.1, 0, 0, 2) }, EXPO)
		task.delay(dur * 0.35, function()
			tw(f, dur * 0.65, { BackgroundTransparency = 1 })
		end)

		Debris:AddItem(f, dur + 0.1)
	end

	local function pillar(sx)
		local p = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(sx, 0.5),
			Size = UDim2.new(0, 2, 0, 0),
			BackgroundColor3 = COL_GOLD_L,
			BorderSizePixel = 0,
			ZIndex = 8,
		}, fx)
		new("UIGradient", {
			Transparency = NumberSequence.new({ kp(0, 1), kp(0.5, 0.1), kp(1, 1) }),
			Rotation = 90
		}, p)

		tw(p, 0.25, { Size = UDim2.new(0, 2, 0.34, 0) }, QUINT)
		task.delay(0.2, function()
			tw(p, 0.45, { BackgroundTransparency = 1, Size = UDim2.new(0, 1, 0.34, 0) })
		end)

		Debris:AddItem(p, 0.8)
	end

	local function rays(sx, sy, count, len, color)
		for k = 1, count do
			local ang = (k / count) * 360 + rnd(-6, 6)
			local pivot = new("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(sx, sy),
				Size = UDim2.fromOffset(0, 0),
				BackgroundTransparency = 1,
				Rotation = ang,
				ZIndex = 8,
			}, fx)
			local r = new("Frame", {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.fromOffset(0, 0),
				Size = UDim2.fromOffset(0, 2),
				BackgroundColor3 = color or COL_GOLD_L,
				BorderSizePixel = 0,
			}, pivot)
			new("UIGradient", { Transparency = NumberSequence.new({ kp(0, 0.2), kp(1, 1) }) }, r)
			local dur = rnd(0.45, 0.7)
			tw(r, dur, { Size = UDim2.fromOffset(len * rnd(0.7, 1.1), 2), BackgroundTransparency = 1 }, QUINT)
			Debris:AddItem(pivot, dur + 0.05)
		end
	end

	local function sparkle(sx, sy, size, color)
		local rot = rnd(0, 45)
		local s = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(sx, sy),
			Size = UDim2.fromOffset(size, size),
			BackgroundTransparency = 1,
			Rotation = rot,
			ZIndex = 9,
		}, fx)
		local sc = new("UIScale", { Scale = 0 }, s)
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = color,
			BorderSizePixel = 0,
		}, s)
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(0, 1, 1, 0),
			BackgroundColor3 = color,
			BorderSizePixel = 0,
		}, s)
		tw(sc, 0.35, { Scale = 1 }, BACK)
		tw(s, 1.0, { Rotation = rot + 70 }, SINE)
		task.delay(0.4, function()
			tw(sc, 0.5, { Scale = 0 }, QUINT, IN)
		end)

		Debris:AddItem(s, 1.1)
	end

	local function streak()
		local x, y = rnd(0.05, 0.6), rnd(0.05, 0.55)
		local f = new("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.fromScale(x, y),
			Size = UDim2.fromOffset(90, 1),
			Rotation = 25,
			BackgroundColor3 = COL_GOLD_L,
			BorderSizePixel = 0,
			ZIndex = 4,
		}, world)
		new("UIGradient", { Transparency = NumberSequence.new({ kp(0, 1), kp(1, 0) }) }, f)
		local dur = rnd(0.7, 1.1)
		tw(f, dur, { Position = UDim2.fromScale(x + 0.25, y + 0.12), BackgroundTransparency = 1 }, QUINT)
		Debris:AddItem(f, dur + 0.05)
	end

	local function shake(power, dur)
		task.spawn(function()
			local t = os.clock()
			while os.clock() - t < dur do
				local k = 1 - (os.clock() - t) / dur
				stage.Position = UDim2.new(0.5, rnd(-power, power) * k, 0.5, rnd(-power, power) * k)
				task.wait()
			end

			stage.Position = UDim2.fromScale(0.5, 0.5)
		end)
	end

	local function makeDivider(parent, pos, width, z)
		local d = {}
		d.root = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = pos,
			Size = UDim2.new(width, 0, 0, 14),
			BackgroundTransparency = 1,
			ZIndex = z,
		}, parent)
		d.line = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(0, 0, 0, 1),
			BackgroundColor3 = COL_GOLD,
			BorderSizePixel = 0,
			ZIndex = z,
		}, d.root)
		new("UIGradient", {
			Transparency = NumberSequence.new({ kp(0, 1), kp(0.15, 0.25), kp(0.5, 0), kp(0.85, 0.25), kp(1, 1) }),
		}, d.line)
		local dia = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(8, 8),
			Rotation = 45,
			BackgroundColor3 = COL_GOLD_L,
			BorderSizePixel = 0,
			ZIndex = z + 1,
		}, d.root)
		d.scales = { new("UIScale", { Scale = 0 }, dia) }
		for _, ox in ipairs({ -18, 18 }) do
			local s = new("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, ox, 0.5, 0),
				Size = UDim2.fromOffset(4, 4),
				Rotation = 45,
				BackgroundColor3 = COL_GOLD,
				BorderSizePixel = 0,
				ZIndex = z + 1,
			}, d.root)
			d.scales[#d.scales + 1] = new("UIScale", { Scale = 0 }, s)
		end

		function d.open(dur)
			tw(d.line, dur or 0.6, { Size = UDim2.new(1, 0, 0, 1) }, EXPO)
			for k, s in ipairs(d.scales) do
				task.delay(0.1 + k * 0.06, function()
					tw(s, 0.4, { Scale = 1 }, BACK)
				end)
			end
		end

		function d.close(dur)
			tw(d.line, dur or 0.3, { Size = UDim2.new(0, 0, 0, 1) }, QUINT, IN)
			for _, s in ipairs(d.scales) do
				tw(s, 0.25, { Scale = 0 })
			end
		end

		return d
	end

	local holder = new("Frame", {
		Name = "compass",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1.6, 1.6),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		ZIndex = 2,
	}, stage)
	local glowA = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1.25, 1.25),
		BackgroundColor3 = Color3.fromRGB(90, 62, 22),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, holder)
	new("UICorner", { CornerRadius = UDim.new(1, 0) }, glowA)
	local compassCG = new("CanvasGroup", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, GroupTransparency = 1, }, holder)
	local function ringIn(parent, size, thick, transp)
		local f = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(size, size),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, parent)
		new("UICorner", { CornerRadius = UDim.new(1, 0) }, f)
		new("UIStroke", { Thickness = thick, Color = COL_GOLD, Transparency = transp }, f)
	end

	ringIn(compassCG, 0.99, 1.5, 0.3)
	ringIn(compassCG, 0.90, 1, 0.55)
	ringIn(compassCG, 0.66, 1, 0.7)
	for k = 0, 23 do
		local a = k / 24 * math.pi * 2
		local major = (k % 2 == 0)
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5 + math.cos(a) * 0.472, 0.5 + math.sin(a) * 0.472),
			Size = UDim2.fromOffset(major and 2 or 1, major and 8 or 4),
			Rotation = math.deg(a) + 90,
			BackgroundColor3 = COL_GOLD,
			BackgroundTransparency = major and 0.3 or 0.6,
			BorderSizePixel = 0,
		}, compassCG)
	end

	for k = 0, 7 do
		local a = k / 8 * math.pi * 2
		local len = (k % 2 == 0) and 0.50 or 0.38
		local spike = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5 + math.cos(a) * len / 2, 0.5 + math.sin(a) * len / 2),
			Size = UDim2.new(0, 2, len, 0),
			Rotation = math.deg(a) + 90,
			BackgroundColor3 = COL_GOLD,
			BorderSizePixel = 0,
		}, compassCG)
		new("UIGradient", { Transparency = NumberSequence.new(0.1, 1), Rotation = 90 }, spike)
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5 + math.cos(a) * len, 0.5 + math.sin(a) * len),
			Size = UDim2.fromOffset(7, 7),
			Rotation = 45,
			BackgroundColor3 = COL_GOLD_L,
			BorderSizePixel = 0,
		}, compassCG)
	end

	local inner = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.78, 0.78),
		BackgroundTransparency = 1,
	}, compassCG)
	ringIn(inner, 1, 1, 0.6)
	for k = 0, 11 do
		local a = k / 12 * math.pi * 2
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5 + math.cos(a) * 0.5, 0.5 + math.sin(a) * 0.5),
			Size = UDim2.fromOffset(k % 3 == 0 and 6 or 4, k % 3 == 0 and 6 or 4),
			Rotation = 45,
			BackgroundColor3 = COL_GOLD,
			BackgroundTransparency = k % 3 == 0 and 0.1 or 0.5,
			BorderSizePixel = 0,
		}, inner)
	end

	local divTop = makeDivider(stage, UDim2.fromScale(0.5, 0.36), 0.5, 5)
	local divBot = makeDivider(stage, UDim2.fromScale(0.5, 0.64), 0.5, 5)
	local progTrack = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.9),
		Size = UDim2.new(0.16, 0, 0, 1),
		BackgroundColor3 = COL_DIM,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 5,
	}, stage)
	local progFill = new("Frame", {
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = COL_GOLD_L,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
	}, progTrack)
	new("UIGradient", { Transparency = NumberSequence.new({ kp(0, 0.6), kp(1, 0) }) }, progFill)
	local TITLE_W_START = 0.40
	local TITLE_W_END = 0.66
	local container = new("Frame", {
		Name = "Title",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(TITLE_W_START, 0.15),
		BackgroundTransparency = 1,
		ZIndex = 6,
	}, stage)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 0),
	}, container)
	local letters = {}
	local n = #WORD
	for i = 1, n do
		local ch = WORD:sub(i, i)
		local slot = new("Frame", {
			LayoutOrder = i,
			Size = UDim2.new(1 / n, 0, 1, 0),
			BackgroundTransparency = 1,
			ZIndex = 6,
		}, container)
		local box = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.62, 0.9),
			BackgroundTransparency = 1,
			Rotation = (i % 2 == 0) and 12 or -12,
		}, slot)
		local sc = new("UIScale", { Scale = 1.8 }, box)
		local shadow = new("TextLabel", {
			Position = UDim2.fromScale(0.03, 0.045),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Font = FONT,
			Text = ch,
			TextScaled = true,
			TextColor3 = COL_BLACK,
			TextTransparency = 1,
			ZIndex = 1,
		}, box)
		local main = new("TextLabel", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Font = FONT,
			Text = ch,
			TextScaled = true,
			TextColor3 = Color3.new(1, 1, 1),
			TextTransparency = 1,
			ZIndex = 2,
		}, box)
		new("UIGradient", {
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 242, 245)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(214, 192, 150)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 120, 72)),
			}),
			Rotation = 90,
		}, main)
		local shine = new("TextLabel", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Font = FONT,
			Text = ch,
			TextScaled = true,
			TextColor3 = Color3.new(1, 1, 1),
			TextTransparency = 0,
			ZIndex = 3,
		}, box)
		local shineGrad = new("UIGradient", {
			Transparency = NumberSequence.new({ kp(0, 1), kp(0.4, 1), kp(0.5, 0.05), kp(0.6, 1), kp(1, 1) }),
			Rotation = 25,
			Offset = Vector2.new(-1, 0),
		}, shine)
		letters[i] = {
			box = box,
			scale = sc,
			main = main,
			shadow = shadow,
			shine = shine,
			shineGrad = shineGrad
		}
	end

	local function letterX(k)
		return 0.5 + ( ( (k - 0.5) / n) - 0.5) * TITLE_W_END
	end

	local function shineSweep()
		for i = 1, n do
			local L = letters[i]
			task.delay( (i - 1) * 0.05, function()
				setp(L.shineGrad, { Offset = Vector2.new(-1, 0) })
				tw(L.shineGrad, 0.55, { Offset = Vector2.new(1, 0) }, SINE, INOUT)
			end)
		end
	end

	local alive = true
	local floatOn = false
	local kick = 0
	local bgConn = RunService.RenderStepped:Connect(function(dt)
		local t = os.clock()
		kick = kick * math.exp(-2.5 * dt)
		compassCG.Rotation = (t * 4 + kick) % 360
		inner.Rotation = (-t * 7 - kick * 0.6) % 360
		for _, d in ipairs(dustData) do
			d.y = d.y - d.sp * dt
			if d.y < -0.05 then
				d.y = 1.05;
				d.x = math.random()
			end

			d.f.Position = UDim2.fromScale(d.x + math.sin(t * 0.6 + d.ph) * 0.01, d.y)
			d.f.BackgroundTransparency = 0.5 + 0.4 * math.sin(t * 1.6 + d.ph)
		end

		for _, b in ipairs(beams) do
			b.f.Rotation = b.base + math.sin(t * 0.35 + b.ph) * 4
		end

		if floatOn then
			for i = 1, n do
				letters[i].box.Position = UDim2.fromScale(0.5, 0.5 + math.sin(t * 1.7 + i * 0.55) * 0.035)
			end

			glowA.BackgroundTransparency = 0.94 + math.sin(t * 1.4) * 0.02
		end
	end)

	task.spawn(function()
		while alive do
			task.wait(rnd(0.25, 0.5))
			if FX_LEVEL > 0 and floatOn and alive then
				sparkle(rnd(0.17, 0.83), rnd(0.42, 0.58), math.random(7, 11), COL_GOLD_L)
			end
		end
	end)

	task.spawn(function()
		while alive do
			task.wait(rnd(2.5, 5))
			if FX_LEVEL > 0 and floatOn and alive then
				streak()
			end
		end
	end)

	task.spawn(function()
		while alive do
			task.wait(3.6)
			if floatOn and alive then
				shineSweep()
			end
		end
	end)

	local events = {}
	local function at(t, fn)
		events[#events + 1] = { t = t, fn = fn }
	end

	local t0 = os.clock()
	local function now()
		return os.clock() - t0
	end

	at(T.beams, function()
		for _, b in ipairs(beams) do
			tw(b.f, 1.6, { BackgroundTransparency = 0.93 })
		end
	end)

	at(T.compass, function()
		tw(compassCG, 0.9, { GroupTransparency = 0 })
		tw(holder, 1.6, { Size = UDim2.fromScale(0.96, 0.96) }, EXPO)
		tw(glowA, 1.2, { BackgroundTransparency = 0.95 })
		ringPulse(0.5, 0.5, 1.0, 1.0, COL_GOLD)
	end)

	at(T.divider, function()
		divTop.open(0.8)
		divBot.open(0.8)
		flare(0.5, 0.9)
	end)

	at(T.letters, function()
		tw(container, 1.5, { Size = UDim2.fromScale(TITLE_W_END, 0.15) }, EXPO)
	end)

	for i = 1, n do
		local L = letters[i]
		at(T.letters + (i - 1) * T.step, function()
			tw(L.scale, 0.7, { Scale = 1 }, EXPO)
			tw(L.box, 0.7, { Rotation = 0 }, EXPO)
			tw(L.main, 0.3, { TextTransparency = 0 })
			tw(L.shadow, 0.4, { TextTransparency = 0.6 })
			dustBurst(letterX(i), 0.52, 3, COL_GOLD_L, 45)
			pillar(letterX(i))
		end)
	end

	at(T.letters + n * T.step + 0.35, function()
		doFlash(0.9, 0.6, COL_GOLD)
		ringPulse(0.5, 0.5, 1.5, 0.9, COL_GOLD_L)
		task.delay(0.12, function()
			ringPulse(0.5, 0.5, 1.1, 0.8, COL_GOLD)
		end)

		flare(0.5, 0.7)
		rays(0.5, 0.5, 10, 120, COL_GOLD_L)
		kick = kick + 30
		shake(5, 0.3)
		setp(stageScale, { Scale = 1.035 })
		tw(stageScale, 0.7, { Scale = 1 }, EXPO)
		shineSweep()
		floatOn = true
	end)

	at(0.3, function()
		tw(progTrack, 0.5, { BackgroundTransparency = 0.6 })
		tw(progFill, T.outro - 0.3, { Size = UDim2.new(1, 0, 1, 0) }, Enum.EasingStyle.Linear)
	end)

	table.sort(events, function(a, b)
		return a.t < b.t
	end)

	local function waitUntil(tt)
		while now() < tt do
			task.wait()
		end
	end

	local function outro()
		alive = false
		floatOn = false
		local d = 0.7
		tw(compassCG, d, { GroupTransparency = 1 })
		tw(holder, d + 0.3, { Size = UDim2.fromScale(1.4, 1.4) }, QUINT)
		tw(glowA, d, { BackgroundTransparency = 1 })
		for _, L in ipairs(letters) do
			tw(L.main, d, { TextTransparency = 1 })
			tw(L.shadow, d, { TextTransparency = 1 })
			tw(L.shine, d, { TextTransparency = 1 })
		end

		divTop.close(d)
		divBot.close(d)
		tw(progTrack, d, { BackgroundTransparency = 1 })
		tw(progFill, d, { BackgroundTransparency = 1 })
		tw(world, d, { GroupTransparency = 1 })
		tw(bgFrame, d, { BackgroundTransparency = 1 })
		tw(flash, d, { BackgroundTransparency = 1 })
		task.wait(d + 0.1)
		bgConn:Disconnect()
		gui:Destroy()
	end

	for _, e in ipairs(events) do
		waitUntil(e.t)
		local ok, err = pcall(e.fn)
		if not ok then
			warn("[NexvyrIntro] " .. tostring(err))
		end
	end

	waitUntil(T.outro)
	outro()
end


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer
while not player do
	task.wait()
	player = Players.LocalPlayer
end


local camera = workspace.CurrentCamera
local fovVisiblePreference = false
local fovRadius = 120
local autoShootEnabled = false
local autoShootAgresivoEnabled = false
local autoShootTargetPart = "Cabeza"
local silentAimManualEnabled = false
local silentAimFovEnabled = false
local silentAimTargetPart = "Cabeza"
local teamCheckEnabled = true
local espEnabled = false
local espColor = Color3.fromRGB(255, 182, 193)
local espSettings = { Glow = true, Box = false, Name = false }
local KillAllEnabled = false
local hitboxEnabled = false
local hitboxInvisible = false
local hitboxSize = 3.5
local hitboxColor = Color3.fromRGB(255, 0, 0)
local fakeNameEnabled = false
local InvisibilityActive = false
local animacionActualActiva = nil
local misAnimacionesOriginales = nil
local UIElements = {}
local Persist = {
	Items = {},
	Order = {},
	Loading = false,
	Ready = false,
	Data = nil,
	Base = 0,
	Start = os.clock()
}


Persist.Folder = "NexvyrHub_Configs_WindUI"
Persist.File = Persist.Folder .. "/autoload.json"
pcall(function()
	if isfolder and makefolder and not isfolder(Persist.Folder) then
		makefolder(Persist.Folder)
	end

	if isfile and readfile and isfile(Persist.File) then
		local decoded = HttpService:JSONDecode(readfile(Persist.File))
		if type(decoded) == "table" then
			Persist.Data = decoded
		end
	end
end)


Persist.Base = tonumber(Persist.Data and Persist.Data.TotalSeconds) or 0
Persist.Start = os.clock()


function Persist.Total()
	return Persist.Base + (os.clock() - Persist.Start)
end


function Persist.Save()
	if not Persist.Ready or Persist.Loading or not writefile then
		return
	end

	local values = {}
	for key, item in pairs(Persist.Items) do
		local okGet, value = pcall(item.Get)
		if okGet and value ~= nil then
			values[key] = value
		end
	end

	local okEncode, encoded = pcall(function()
		return HttpService:JSONEncode({ TotalSeconds = Persist.Total(), Values = values })
	end)

	if okEncode then
		pcall(writefile, Persist.File, encoded)
	end
end


local function persist(key, get, set)
	if not Persist.Items[key] then
		Persist.Order[#Persist.Order + 1] = key
	end

	Persist.Items[key] = { Get = get, Set = set }
end


local function persistToggle(key, element, get)
	persist(key, get, function(v)
		if type(v) == "boolean" and element then
			element:Set(v)
		end
	end)
end


local function persistSlider(key, element, get)
	persist(key, get, function(v)
		if type(v) == "number" and element then
			element:Set(v)
		end
	end)
end


local function persistDropdown(key, element, get, apply)
	persist(key, get, function(v)
		if v == nil then
			return
		end

		if apply then
			apply(v)
		end

		if element then
			element:Select(v)
		end
	end)
end


local function persistColor(key, element, get, apply)
	persist(key, function()
		local c = get()
		return { R = c.R, G = c.G, B = c.B }
	end, function(v)
		if type(v) ~= "table" then
			return
		end

		local c = Color3.new(v.R or 1, v.G or 1, v.B or 1)
		apply(c)
		if element then
			element:Update(c)
		end
	end)
end


local nexvyrUpdateTargetFeatures
local nexvyrRefreshTargetMonitor
local nexvyrSetAimTarget
local nexvyrStartAutoShootWorker
local nexvyrStartSilentAimWorker
local nexvyrStartEquipWorker
local nexvyrStartESPWorker
local nexvyrStartHitboxWorker
local nexvyrStartAnimationWorker
local nexvyrStartFOVWorker
local equipGunEnabled = false
local nexvyrSetInvisibleWorker
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NexvyrHub_Overlays"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999
screenGui.Parent = player:WaitForChild("PlayerGui")
local espFolder = Instance.new("Folder")
espFolder.Name = "NexvyrESPFolder"
espFolder.Parent = screenGui
local WindUI
local _version = "1.6.66"
local uiFileName = "WindUI_Cache_v" .. _version .. ".txt"
local timeFileName = "WindUI_Cache_v" .. _version .. "_Time.txt"
local ok, result = pcall(function()
	local cacheValido = false
	if isfile and isfile(timeFileName) and readfile then
		local savedTime = tonumber(readfile(timeFileName))
		if savedTime and (os.time() - savedTime) < 2592000 then
			cacheValido = true
		end
	end

	if cacheValido and isfile and isfile(uiFileName) then
		local code = readfile(uiFileName)
		local fn = loadstring(code)
		if fn then
			return fn()
		else
			if delfile then
				pcall(delfile, uiFileName)
				pcall(delfile, timeFileName)
			end
		end
	end

	local codigoUi = game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. _version .. "/main.lua")
	if writefile then
		writefile(uiFileName, codigoUi)
		writefile(timeFileName, tostring(os.time()))
	end

	return loadstring(codigoUi)()
end)


if ok and result and type(result) == "table" then
	WindUI = result
else
	warn("Error al cargar WindUI: " .. tostring(result))
	return
end


pcall(function()
	WindUI:AddTheme({
		Name = "Crimson",
		Accent = Color3.fromHex("#DC143C"),
		Dialog = Color3.fromHex("#1a0a0e"),
		Outline = Color3.fromHex("#DC143C"),
		Text = Color3.fromHex("#FFFFFF"),
		Placeholder = Color3.fromHex("#8a6a70"),
		Background = Color3.fromHex("#120709"),
		Button = Color3.fromHex("#8B0A1E"),
		Icon = Color3.fromHex("#ff8fa3"),
	})
end)


pcall(function()
	WindUI:SetTheme("Crimson")
end)


local Window = WindUI:CreateWindow({
	Theme = "Crimson",
	Title = "NEXVYRHUB | DUELS <font color='#FFD700'>[v3.2] </font>",
	Author = "By 7.dui🇲🇽",
	Folder = "Nexvyr_WindUI",
	Acrylic = false,
	Transparent = false,
	NewElements = true,
	HideSearchBar = false,
	ToggleKey = Enum.KeyCode.F15,
	Background = "rbxthumb://type=Asset&id=140316387608545&w=420&h=420",
	BackgroundImageTransparency = 0.8,
	OpenButton = {
		Title = "Open HUB",
		Icon = "rbxthumb://type=Asset&id=118232139384203&w=420&h=420",
		IconSize = 9,
		CornerRadius = UDim.new(1),
		StrokeThickness = 2,
		Enabled = true,
		Draggable = true,
		Scale = 0.9,
		Color = ColorSequence.new(Color3.fromHex("#DC143C"), Color3.fromHex("#8B0A1E"))
	}, Topbar = { Height = 44, ButtonsType = "Default" } })


local NovedadSection = Window:Section({ Title = "Novedad", Opened = true })
local ExtrasScriptsSection = Window:Section({ Title = "Extras scripts", Opened = true })
local PrincipalesSection = Window:Section({ Title = "Combate principal", Opened = true })
local FarmeoSection = Window:Section({ Title = "Zona de farmeo", Opened = true })
local ConfigSection = Window:Section({ Title = "Configuraciones", Opened = true })
local Tabs = {
	Informaciones = NovedadSection:Tab({ Title = "informaciónes", Icon = "solar:info-circle-bold" }),
	ExtrasScripts = ExtrasScriptsSection:Tab({ Title = "Extras scripts", Icon = "solar:code-square-bold" }),
	Graficos = ExtrasScriptsSection:Tab({ Title = "Gráficos", Icon = "solar:palette-bold" }),
	Botones = ExtrasScriptsSection:Tab({ Title = "Botones", Icon = "solar:gamepad-bold" }),
	Inicio = PrincipalesSection:Tab({ Title = "Inició", Icon = "solar:home-2-bold" }),
	Aim = PrincipalesSection:Tab({ Title = "Aimbot", Icon = "solar:target-bold" }),
	Vis = PrincipalesSection:Tab({ Title = "Visual", Icon = "solar:eye-bold" }),
	KillAll = PrincipalesSection:Tab({ Title = "Kill All", Icon = "solar:danger-triangle-bold" }),
	Invisible = PrincipalesSection:Tab({ Title = "Invisible", Icon = "solar:ghost-bold" }),
	Tramposo = PrincipalesSection:Tab({ Title = "Tramposo", Icon = "solar:bolt-bold" }),
	Farm = FarmeoSection:Tab({ Title = "Farmear evento", Icon = "solar:gift-bold" }),
	RachaFarm = FarmeoSection:Tab({ Title = "Farmear racha", Icon = "solar:flame-bold" }),
	Animaciones = ConfigSection:Tab({ Title = "Animaciones", Icon = "solar:smile-circle-bold" }),
	Sonidos = ConfigSection:Tab({ Title = "Sonidos", Icon = "solar:speaker-bold" }),
	Music = ConfigSection:Tab({ Title = "Música", Icon = "solar:music-note-2-bold" }),
	Items = ConfigSection:Tab({ Title = "Items", Icon = "solar:crown-star-bold" }),
	Identidad = ConfigSection:Tab({ Title = "Identidad", Icon = "solar:user-id-bold" })
}


do
	local GREEN = "#3DDC57"
	local YELLOW = "#FFD700"
	local WHITE = "#FFFFFF"
	local PINK = "#FF8FD0"
	local lines = {
		{ "+Autoload", GREEN },
		{ "+Nuevos visuales", GREEN },
		{ "+nueva API script protección", GREEN },
		{ "+Notificaciones en tiempo real", GREEN },
		{ "+Kill All [Beta v2]", YELLOW },
	}
	local rendered = {}
	for _, line in ipairs(lines) do
		rendered[#rendered + 1] = string.format("<font color='%s'>%s</font>", line[2], line[1])
	end

	rendered[#rendered + 1] = ""
	rendered[#rendered + 1] = string.format("<font color='%s'>No se preocupen cuando aparezca una notificación de kriph, es totalmente normal y forma parte de </font><font color='%s'>Open HUB</font>", WHITE, PINK)
	Tabs.Informaciones:Section({ Title = "Nuevas cosas agregadas", Icon = "solar:info-circle-bold" })
	local para = Tabs.Informaciones:Paragraph({ Title = table.concat(rendered, "\n"), })
	pcall(function()
		for _, d in ipairs(para.ElementFrame:GetDescendants()) do
			if d:IsA("TextLabel") then
				d.RichText = true
			end
		end
	end)

	pcall(function()
		Tabs.Informaciones:Select()
	end)
end


do
	local Stats = game:GetService("Stats")
	local PING_REFRESH_SECONDS = 2
	local PING_ICON = "solar:wi-fi-router-bold"
	local levels = {
		{ Max = 80, Color = "#30ff6a" },
		{ Max = 150, Color = "#ffd23f" },
		{ Max = 250, Color = "#ff9f1c" },
		{ Max = math.huge, Color = "#ff3b3b" },
	}
	local pingTag
	local currentLevel
	local function readPing()
		local value
		pcall(function()
			local network = Stats:FindFirstChild("Network")
			local items = network and network:FindFirstChild("ServerStatsItem")
			local item = items and items:FindFirstChild("Data Ping")
			if item then
				value = item:GetValue()
			end
		end)

		if type(value) ~= "number" then
			pcall(function()
				value = player:GetNetworkPing() * 1000
			end)
		end

		if type(value) ~= "number" then
			return nil
		end

		return math.max(0, math.floor(value + 0.5))
	end

	local function levelFor(ms)
		for index, level in ipairs(levels) do
			if ms <= level.Max then
				return index
			end
		end

		return #levels
	end

	local function applyPing(levelIndex, text)
		local level = levels[levelIndex]
		if not pingTag then
			local okTag, tag = pcall(function()
				return Window:Tag({ Title = text, Icon = PING_ICON, Color = Color3.fromHex(level.Color), })
			end)

			if okTag then
				pingTag = tag
			end

			currentLevel = levelIndex
			return
		end

		pcall(function()
			pingTag:SetTitle(text)
		end)

		if currentLevel ~= levelIndex then
			currentLevel = levelIndex
			pcall(function()
				pingTag:SetColor(Color3.fromHex(level.Color))
			end)
		end
	end

	task.spawn(function()
		while true do
			local ms = readPing()
			if ms then
				applyPing(levelFor(ms), tostring(ms) .. " ms")
			end

			task.wait(PING_REFRESH_SECONDS)
		end
	end)
end


local isEnemy, estaEnLobby, IsInMatchStrict
local esEnemigoValido, esCuchillo, esPistola, obtenerPistola


do
	local playerGui = player:WaitForChild("PlayerGui")
	local dmvsInvalidateRedirectSelection
	local dmvsClearTargetParts
	local function dmvsDisconnectConnectionList(list)
		if not list then
			return
		end

		for i = #list, 1, -1 do
			local connection = list[i]
			list[i] = nil
			if connection and connection.Connected then
				connection:Disconnect()
			end
		end
	end

	local dmvsIsInfectionMode
	local function dmvsIsTargetAlive(target)
		local character = target
		if typeof(target) == "Instance" and target:IsA("Player") then
			character = target.Character
		end

		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			return false
		end

		if dmvsIsInfectionMode and dmvsIsInfectionMode() then
			return character:GetAttribute("InfectionDowned") ~= true
		end

		return humanoid.Health >= 99
	end

	local function dmvsGetInGameScoreboard()
		local gui = player:FindFirstChild("PlayerGui")
		local main = gui and gui:FindFirstChild("Main")
		local frame = main and main:FindFirstChild("MainGameFrame")
		return frame and frame:FindFirstChild("IngameScore") or nil
	end

	local dmvsTeamResolverState = {
		Snapshot = {},
		Scoreboard = nil,
		InGame = false,
		LocalGame = nil,
		LastRefresh = 0,
		RefreshInterval = 2,
		Dirty = true,
		WatchConnections = {}
	}

	local function dmvsInvalidateScoreboard()
		dmvsTeamResolverState.Dirty = true
	end

	local function dmvsWatchScoreboard(score)
		local state = dmvsTeamResolverState
		if state.Scoreboard == score then
			return
		end

		dmvsDisconnectConnectionList(state.WatchConnections)
		state.Scoreboard = score
		if not score then
			return
		end

		local watchTeams
		watchTeams = function()
			dmvsInvalidateScoreboard()
			dmvsDisconnectConnectionList(state.WatchConnections)
			state.WatchConnections[#state.WatchConnections + 1] = score.ChildAdded:Connect(watchTeams)
			state.WatchConnections[#state.WatchConnections + 1] = score.ChildRemoved:Connect(watchTeams)
			for _, name in ipairs({ "TeamRed", "TeamBlue" }) do
				local folder = score:FindFirstChild(name)
				if folder then
					state.WatchConnections[#state.WatchConnections + 1] = folder.ChildAdded:Connect(dmvsInvalidateScoreboard)
					state.WatchConnections[#state.WatchConnections + 1] = folder.ChildRemoved:Connect(dmvsInvalidateScoreboard)
				end
			end
		end

		watchTeams()
	end

	local function dmvsRefreshScoreboardTeams(force)
		local state = dmvsTeamResolverState
		local now = os.clock()
		local localGame = player:GetAttribute("Game")
		if not force and not state.Dirty and now - state.LastRefresh < state.RefreshInterval and state.LocalGame == localGame and (not state.Scoreboard or state.Scoreboard.Parent) then
			return state.Snapshot
		end

		state.LastRefresh = now
		state.LocalGame = localGame
		local snapshot = {}
		local score = dmvsGetInGameScoreboard()
		if score ~= state.Scoreboard then
			dmvsWatchScoreboard(score)
		end

		for _, teamName in ipairs({ "TeamRed", "TeamBlue" }) do
			local teamFolder = score and score:FindFirstChild(teamName)
			if teamFolder then
				local team = teamName == "TeamRed" and "Red" or "Blue"
				for _, entry in ipairs(teamFolder:GetChildren()) do
					if entry:IsA("GuiObject") then
						snapshot[string.lower(entry.Name)] = team
					end
				end
			end
		end

		state.Snapshot = snapshot
		state.Dirty = false
		state.InGame = score ~= nil and snapshot[string.lower(player.Name)] ~= nil
		return snapshot
	end

	local dmvsInfectionRoleAttributes = { "InfectionInfected", "IsInfected", "Infected", "IsZombie", "Zombie" }
	local dmvsInfectionModeAttributes = { "GameMode", "MatchMode", "Mode" }
	local dmvsInfectionState = {
		Active = false,
		GuiActive = false,
		Roles = {},
		LocalRole = nil,
		LastRefresh = -math.huge,
		RefreshInterval = 0.4,
		RoleTeams = {},
		Inferred = {},
		Targets = {},
		Converted = {},
		ConvertedAt = {},
		Pending = {},
		LateJoiners = {},
		LastLocalGame = nil,
		LastMatchId = nil,
		HasMatchContext = false,
		RoundEnded = false
	}

	local function dmvsInfectionReadMarker(holder)
		if not holder then
			return nil
		end

		if holder:GetAttribute("InfectionPatientZero") == true then
			return true
		end

		local sawSurvivor = false
		for _, name in ipairs(dmvsInfectionRoleAttributes) do
			local value = holder:GetAttribute(name)
			if typeof(value) == "boolean" then
				if value then
					return true
				end

				sawSurvivor = true
			elseif typeof(value) == "string" then
				local normalized = value:lower()
				if normalized == "infected" or normalized == "infection" or normalized == "zombie" or normalized == "true" then
					return true
				end

				if normalized == "survivor" or normalized == "human" or normalized == "false" then
					sawSurvivor = true
				end
			end
		end

		if sawSurvivor then
			return false
		end

		return nil
	end

	local function dmvsInfectionHasPatientZero(other)
		if other:GetAttribute("InfectionPatientZero") == true then
			return true
		end

		local character = other.Character
		if not character then
			return false
		end

		if character:GetAttribute("InfectionPatientZero") == true then
			return true
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		return humanoid ~= nil and humanoid:GetAttribute("InfectionPatientZero") == true
	end

	local function dmvsInfectionAttribute(playerInstance)
		if not playerInstance then
			return nil
		end

		local character = playerInstance.Character
		local characterStatus = dmvsInfectionReadMarker(character)
		local playerStatus = dmvsInfectionReadMarker(playerInstance)
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local humanoidStatus = dmvsInfectionReadMarker(humanoid)
		if characterStatus == true or playerStatus == true or humanoidStatus == true then
			return true
		end

		if characterStatus == false or playerStatus == false or humanoidStatus == false then
			return false
		end

		return nil
	end

	local function dmvsReadInfectionRoster(teams)
		local frame = playerGui:FindFirstChild("Main")
		frame = frame and frame:FindFirstChild("MainGameFrame")
		if not frame then
			return
		end

		local playerFrame = frame:FindFirstChild("PlayersFrame")
		local regularFrame = frame:FindFirstChild("IngameScore")
		local playerNames = {}
		local displayCandidates = {}
		local ambiguousDisplays = {}
		for _, other in ipairs(Players:GetPlayers()) do
			playerNames[other.Name:lower()] = other
			playerNames[tostring(other.UserId)] = other
			local displayKey = other.DisplayName:lower()
			if displayCandidates[displayKey] then
				ambiguousDisplays[displayKey] = true
			end

			displayCandidates[displayKey] = other
		end

		for displayKey, other in pairs(displayCandidates) do
			if not ambiguousDisplays[displayKey] and not playerNames[displayKey] then
				playerNames[displayKey] = other
			end
		end

		local function collect(group, team)
			if not group then
				return
			end

			for _, entry in ipairs(group:GetChildren()) do
				if entry:IsA("GuiObject") then
					local other = playerNames[entry.Name:lower():gsub("^@", "")]
					if not other then
						local entryUserId = entry:GetAttribute("UserId")
						if entryUserId then
							other = playerNames[tostring(entryUserId)]
						end
					end

					if not other then
						for _, sub in ipairs(entry:GetDescendants()) do
							if sub:IsA("TextLabel") and (sub.Name == "PlayerName" or sub.Name == "TextLabel") then
								other = playerNames[sub.Text:lower():gsub("^@", "")]
								if other then
									break
								end
							end
						end
					end

					if other then
						teams[other] = team
					end
				end
			end
		end

		if regularFrame then
			collect(regularFrame:FindFirstChild("TeamRed"), "Red")
			collect(regularFrame:FindFirstChild("TeamBlue"), "Blue")
		end

		if playerFrame then
			collect(playerFrame:FindFirstChild("TeamRedFrame"), "Red")
			collect(playerFrame:FindFirstChild("TeamBlueFrame"), "Blue")
		end
	end

	local function dmvsReadInfectionGui()
		local main = playerGui:FindFirstChild("Main")
		local frame = main and main:FindFirstChild("FFATopFrame")
		local list = frame and frame:FindFirstChild("PlrList")
		local label1 = frame and frame:FindFirstChild("Label1")
		local label2 = frame and frame:FindFirstChild("Label2")
		if not (frame and frame:IsA("GuiObject") and frame.Visible and list and list:IsA("Frame") and list.Visible and label2 and label2:IsA("TextLabel") and label2.Text == "Infection") then
			return false, {}, nil
		end

		local roles = {}
		for _, row in ipairs(list:GetChildren()) do
			if row:IsA("Frame") and row.Name:match("^Player%d+$") and row.Visible then
				local headshot = row:FindFirstChild("Headshot")
				local status = row:FindFirstChild("Kills")
				if headshot and headshot:IsA("ImageLabel") and status and status:IsA("TextLabel") then
					local role = status.Text
					if role == "Zombie" or role == "Survivor" then
						local userId = tonumber(headshot.Image:match("[?&]id=(%d+)"))
						local other = userId and Players:GetPlayerByUserId(userId)
						if other then
							roles[other] = role
						end
					end
				end
			end
		end

		local localRole = roles[player]
		if label1 and label1:IsA("TextLabel") then
			local headline = label1.Text
			if headline:find("You're INFECTED!", 1, true) == 1 then
				localRole = "Zombie"
			elseif headline:find("Survive!", 1, true) == 1 then
				localRole = "Survivor"
			end
		end

		return true, roles, localRole
	end

	local function dmvsClearInfectionRound(ended)
		local state = dmvsInfectionState
		table.clear(state.Converted)
		table.clear(state.ConvertedAt)
		table.clear(state.Pending)
		table.clear(state.LateJoiners)
		table.clear(state.Inferred)
		table.clear(state.Targets)
		table.clear(state.RoleTeams)
		table.clear(state.Roles)
		state.LocalRole = nil
		state.GuiActive = false
		state.Active = false
		state.RoundEnded = ended == true
		state.LastRefresh = -math.huge
		if dmvsInvalidateRedirectSelection then
			dmvsInvalidateRedirectSelection()
		end
	end

	local function dmvsRefreshInfectionState(force)
		local state = dmvsInfectionState
		local now = os.clock()
		local localGame = player:GetAttribute("Game")
		local matchId = player:GetAttribute("MatchId")
		if state.HasMatchContext and (localGame ~= state.LastLocalGame or matchId ~= state.LastMatchId) then
			dmvsClearInfectionRound(false)
		end

		state.HasMatchContext = true
		state.LastLocalGame = localGame
		state.LastMatchId = matchId
		if not force and now - state.LastRefresh < (state.GuiActive and 0.15 or state.RefreshInterval) then
			return state
		end

		state.LastRefresh = now
		local guiActive, guiRoles, guiLocalRole = dmvsReadInfectionGui()
		local regularRoster = dmvsRefreshScoreboardTeams(false)
		local foundPatientZero = false
		local ownCharacter = player.Character
		local myRoot = ownCharacter and ownCharacter:FindFirstChild("HumanoidRootPart")
		local allPlayers = Players:GetPlayers()
		for _, other in ipairs(allPlayers) do
			if dmvsInfectionHasPatientZero(other) then
				local compatible = other == player
				if not compatible then
					compatible = true
					local otherGame = other:GetAttribute("Game")
					local otherMatch = other:GetAttribute("MatchId")
					if localGame ~= nil and localGame ~= "" and otherGame ~= nil and otherGame ~= "" and localGame ~= otherGame then
						compatible = false
					end

					if (localGame == nil or localGame == "") and otherGame ~= nil and otherGame ~= "" then
						compatible = false
					end

					if matchId ~= nil and matchId ~= "" and otherMatch ~= nil and otherMatch ~= "" and matchId ~= otherMatch then
						compatible = false
					end

					local theirCharacter = other.Character
					local theirRoot = theirCharacter and theirCharacter:FindFirstChild("HumanoidRootPart")
					if myRoot and theirRoot and (myRoot.Position - theirRoot.Position).Magnitude > 1200 then
						compatible = false
					end
				end

				if compatible then
					foundPatientZero = true
					break
				end
			end
		end

		local modeAttribute
		for _, name in ipairs(dmvsInfectionModeAttributes) do
			local value = player:GetAttribute(name)
			if typeof(value) == "string" and value ~= "" then
				modeAttribute = value:lower()
				break
			end
		end

		if not modeAttribute then
			for _, name in ipairs(dmvsInfectionModeAttributes) do
				local value = workspace:GetAttribute(name)
				if typeof(value) == "string" and value ~= "" then
					modeAttribute = value:lower()
					break
				end
			end
		end

		local active = not state.RoundEnded and (guiActive or (not dmvsTeamResolverState.InGame and (modeAttribute == "infection" or (not modeAttribute and (foundPatientZero or (state.Active and not state.GuiActive))))))
		if not active then
			state.GuiActive = false
			state.LocalRole = nil
			table.clear(state.Roles)
			if modeAttribute and modeAttribute ~= "infection" and next(state.LateJoiners) ~= nil then
				table.clear(state.LateJoiners)
			end

			if state.Active or next(state.Targets) ~= nil then
				if modeAttribute and modeAttribute ~= "infection" then
					dmvsClearInfectionRound(false)
				else
					state.Active = false
					table.clear(state.Targets)
					table.clear(state.Inferred)
					table.clear(state.RoleTeams)
					if dmvsInvalidateRedirectSelection then
						dmvsInvalidateRedirectSelection()
					end
				end
			end

			return state
		end

		state.Active = true
		local teams = {}
		dmvsReadInfectionRoster(teams)
		state.RoleTeams = teams
		local infectedTeam
		local ambiguousTeam = false
		local markers = {}
		for _, other in ipairs(allPlayers) do
			local marker = dmvsInfectionAttribute(other)
			markers[other] = marker
			if marker == true or state.Converted[other] == true then
				local team = teams[other]
				if team then
					if infectedTeam and infectedTeam ~= team then
						ambiguousTeam = true
					end

					infectedTeam = team
				end
			end
		end

		local inferred = {}
		if infectedTeam and not ambiguousTeam then
			for other, team in pairs(teams) do
				if team == infectedTeam and markers[other] ~= false then
					inferred[other] = true
				end
			end
		end

		state.Inferred = inferred
		local function createTargets()
			local targets = {}
			for _, other in ipairs(allPlayers) do
				if markers[other] == true or state.Converted[other] == true or (markers[other] ~= false and inferred[other] == true) then
					targets[other] = true
				end
			end

			return targets
		end

		local targets = createTargets()
		local infectedRoots = {}
		for infectedPlayer in pairs(targets) do
			local infectedCharacter = infectedPlayer.Character
			local infectedRoot = infectedCharacter and infectedCharacter:FindFirstChild("HumanoidRootPart")
			if infectedRoot and infectedRoot:IsA("BasePart") then
				infectedRoots[#infectedRoots + 1] = infectedRoot
			end
		end

		for _, other in ipairs(allPlayers) do
			if other ~= player and state.LateJoiners[other] and markers[other] == nil and not targets[other] and other.Character then
				local rosterTeam = teams[other] or regularRoster[other.Name:lower()]
				local otherGame = other:GetAttribute("Game")
				local otherMatch = other:GetAttribute("MatchId")
				local sameGame = localGame ~= nil and localGame ~= "" and otherGame == localGame
				local sameMatch = matchId ~= nil and matchId ~= "" and otherMatch == matchId
				local differentGame = localGame ~= nil and localGame ~= "" and otherGame ~= nil and otherGame ~= "" and otherGame ~= localGame
				local differentMatch = matchId ~= nil and matchId ~= "" and otherMatch ~= nil and otherMatch ~= "" and otherMatch ~= matchId
				if not differentGame and not differentMatch then
					local sharesInfectedTeam = false
					for infectedPlayer in pairs(targets) do
						local infectedRobloxTeam = infectedPlayer.Team
						if infectedRobloxTeam and other.Team == infectedRobloxTeam and (markers[infectedPlayer] == true or state.Converted[infectedPlayer] == true or inferred[infectedPlayer] == true) then
							sharesInfectedTeam = true
							break
						end
					end

					local nearInfected = false
					if not rosterTeam and not sameGame and not sameMatch and not sharesInfectedTeam then
						local characterRoot = other.Character:FindFirstChild("HumanoidRootPart")
						if characterRoot and characterRoot:IsA("BasePart") then
							local position = characterRoot.Position
							for _, infectedRoot in ipairs(infectedRoots) do
								if (infectedRoot.Position - position).Magnitude <= 300 then
									nearInfected = true
									break
								end
							end
						end
					end

					local participates = rosterTeam ~= nil or sameGame or sameMatch or sharesInfectedTeam or nearInfected
					if participates and (not infectedTeam or ambiguousTeam or not rosterTeam or rosterTeam == infectedTeam) then
						targets[other] = true
					end
				end
			end
		end

		local pending = state.Pending
		local changed = true
		while changed do
			changed = false
			for index = #pending, 1, -1 do
				local entry = pending[index]
				if now - entry.Time > 10 or entry.Killer.Parent ~= Players or entry.Victim.Parent ~= Players then
					table.remove(pending, index)
				elseif targets[entry.Killer] and not targets[entry.Victim] and (not state.ConvertedAt[entry.Killer] or state.ConvertedAt[entry.Killer] <= entry.Time) then
					state.Converted[entry.Victim] = true
					state.ConvertedAt[entry.Victim] = entry.Time
					targets[entry.Victim] = true
					table.remove(pending, index)
					changed = true
				elseif targets[entry.Killer] then
					table.remove(pending, index)
				end
			end
		end

		local previous = state.Targets
		local targetChanged = false
		for other in pairs(previous) do
			if not targets[other] then
				targetChanged = true;
				break
			end
		end

		if not targetChanged then
			for other in pairs(targets) do
				if not previous[other] then
					targetChanged = true;
					break
				end
			end
		end

		state.Targets = targets
		local roles = guiRoles
		for _, other in ipairs(allPlayers) do
			if roles[other] == nil then
				if markers[other] == true or targets[other] then
					roles[other] = "Zombie"
				elseif markers[other] == false then
					roles[other] = "Survivor"
				end
			end
		end

		local localRole = guiLocalRole or roles[player]
		local rolesChanged = state.GuiActive ~= guiActive or state.LocalRole ~= localRole
		if not rolesChanged then
			for other, role in pairs(state.Roles) do
				if roles[other] ~= role then
					rolesChanged = true;
					break
				end
			end
		end

		if not rolesChanged then
			for other, role in pairs(roles) do
				if state.Roles[other] ~= role then
					rolesChanged = true;
					break
				end
			end
		end

		state.GuiActive = guiActive
		state.Roles = roles
		state.LocalRole = localRole
		if (targetChanged or rolesChanged) and dmvsInvalidateRedirectSelection then
			dmvsInvalidateRedirectSelection()
		end

		return state
	end

	dmvsIsInfectionMode = function()
		return dmvsRefreshInfectionState(false).Active
	end

	local function dmvsIsInfectionEnemyTarget(targetPlayer)
		if not targetPlayer or targetPlayer == player then
			return false
		end

		local state = dmvsRefreshInfectionState(false)
		local targetRole = state.Roles[targetPlayer]
		return state.Active and state.LocalRole ~= nil and targetRole ~= nil and state.LocalRole ~= targetRole
	end

	local function dmvsInfectionMatchAllowed(targetPlayer, allowMissingCharacter)
		if not targetPlayer or targetPlayer == player or not targetPlayer.Parent or (not allowMissingCharacter and not targetPlayer.Character) then
			return false
		end

		local myGame = player:GetAttribute("Game")
		local targetGame = targetPlayer:GetAttribute("Game")
		if myGame ~= nil and myGame ~= "" and targetGame ~= nil and targetGame ~= "" and myGame ~= targetGame then
			return false
		end

		if (myGame == nil or myGame == "") and targetGame ~= nil and targetGame ~= "" then
			return false
		end

		local myMatch = player:GetAttribute("MatchId")
		local targetMatch = targetPlayer:GetAttribute("MatchId")
		if myMatch ~= nil and myMatch ~= "" and targetMatch ~= nil and targetMatch ~= "" and myMatch ~= targetMatch then
			return false
		end

		local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		local otherRoot = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
		if myRoot and otherRoot and (myRoot.Position - otherRoot.Position).Magnitude > 1200 then
			return false
		end

		return true
	end

	local function dmvsInfectionMarkDirty()
		dmvsInfectionState.LastRefresh = -math.huge
	end

	local function dmvsInfectionOnKill(killer, victim)
		if typeof(killer) ~= "Instance" or not killer:IsA("Player") or typeof(victim) ~= "Instance" or not victim:IsA("Player") or killer == victim or not dmvsIsInfectionMode() or (killer ~= player and not dmvsInfectionMatchAllowed(killer, true)) or (victim ~= player and not dmvsInfectionMatchAllowed(victim, true)) then
			return
		end

		local state = dmvsRefreshInfectionState(false)
		if state.Targets[victim] then
			return
		end

		if state.Targets[killer] then
			state.Converted[victim] = true
			state.ConvertedAt[victim] = os.clock()
			state.LastRefresh = -math.huge
			dmvsRefreshInfectionState(true)
		else
			if #state.Pending >= 96 then
				table.remove(state.Pending, 1)
			end

			state.Pending[#state.Pending + 1] = { Killer = killer, Victim = victim, Time = os.clock() }
			state.LastRefresh = -math.huge
		end
	end

	local dmvsIsInSameGame
	dmvsIsInSameGame = function(targetPlayer)
		if not targetPlayer or targetPlayer == player or not targetPlayer.Parent then
			return false
		end

		if dmvsIsInfectionMode() then
			return dmvsInfectionMatchAllowed(targetPlayer) and dmvsIsInfectionEnemyTarget(targetPlayer)
		end

		local roster = dmvsRefreshScoreboardTeams(false)
		if not dmvsTeamResolverState.InGame or not roster[string.lower(targetPlayer.Name)] then
			return false
		end

		local myGame = player:GetAttribute("Game")
		local targetGame = targetPlayer:GetAttribute("Game")
		if myGame ~= nil and myGame ~= "" and targetGame ~= nil and targetGame ~= "" then
			if myGame ~= targetGame then
				return false
			end
		elseif (myGame == nil or myGame == "") and targetGame ~= nil and targetGame ~= "" then
			return false
		end

		local myMatch = player:GetAttribute("MatchId")
		local targetMatch = targetPlayer:GetAttribute("MatchId")
		if myMatch ~= nil and myMatch ~= "" and targetMatch ~= nil and targetMatch ~= "" and myMatch ~= targetMatch then
			return false
		end

		return true
	end

	local function dmvsResolvePlayerTeam(targetPlayer)
		if not targetPlayer then
			return nil
		end

		local snapshot = dmvsRefreshScoreboardTeams(false)
		local byName = snapshot[string.lower(targetPlayer.Name)]
		if not byName and targetPlayer.DisplayName then
			byName = snapshot[string.lower(targetPlayer.DisplayName)]
		end

		if byName then
			return byName
		end

		local attr = targetPlayer:GetAttribute("Team") or targetPlayer:GetAttribute("team")
		if attr ~= nil and tostring(attr) ~= "" then
			return tostring(attr)
		end

		if targetPlayer.Team then
			return targetPlayer.Team.Name
		end

		local teamColor = targetPlayer.TeamColor
		if teamColor and teamColor.Name ~= "White" and teamColor.Name ~= "Medium stone grey" then
			return "Color:" .. teamColor.Name
		end

		return nil
	end

	local function dmvsPlayersAreEnemies(firstPlayer, secondPlayer)
		if not firstPlayer or not secondPlayer or firstPlayer == secondPlayer then
			return false
		end

		local infection = dmvsRefreshInfectionState(false)
		if infection.Active then
			local firstRole = firstPlayer == player and infection.LocalRole or infection.Roles[firstPlayer]
			local secondRole = secondPlayer == player and infection.LocalRole or infection.Roles[secondPlayer]
			return firstRole ~= nil and secondRole ~= nil and firstRole ~= secondRole
		end

		local firstTeam = dmvsResolvePlayerTeam(firstPlayer)
		local secondTeam = dmvsResolvePlayerTeam(secondPlayer)
		if firstTeam ~= nil and secondTeam ~= nil then
			return firstTeam ~= secondTeam
		end

		return true
	end

	local function updateMyTeam()
		dmvsInvalidateScoreboard()
		if dmvsInvalidateRedirectSelection then
			dmvsInvalidateRedirectSelection()
		end
	end

	local function updateEnemy()
		dmvsInvalidateScoreboard()
		dmvsInfectionMarkDirty()
		if dmvsInvalidateRedirectSelection then
			dmvsInvalidateRedirectSelection()
		end
	end

	local dmvsTeamPlayerConnections = {}
	local dmvsInfectionCharacterConnections = {}
	local function disconnectPlayerTeamEvents(p)
		dmvsDisconnectConnectionList(dmvsInfectionCharacterConnections[p])
		dmvsInfectionCharacterConnections[p] = nil
		local connections = dmvsTeamPlayerConnections[p]
		if connections then
			dmvsDisconnectConnectionList(connections)
			dmvsTeamPlayerConnections[p] = nil
		end
	end

	local function dmvsWatchInfectionCharacter(p, character)
		dmvsDisconnectConnectionList(dmvsInfectionCharacterConnections[p])
		dmvsInfectionCharacterConnections[p] = nil
		if not character then
			return
		end

		local connections = {}
		dmvsInfectionCharacterConnections[p] = connections
		local function changed(name)
			if name == "InfectionPatientZero" or name == "InfectionInfected" or name == "IsInfected" or name == "Infected" or name == "IsZombie" or name == "Zombie" then
				dmvsInfectionMarkDirty()
				updateEnemy()
			end
		end

		connections[#connections + 1] = character.AttributeChanged:Connect(changed)
		local function bindHumanoid(humanoid)
			if humanoid and humanoid:IsA("Humanoid") then
				connections[#connections + 1] = humanoid.AttributeChanged:Connect(changed)
			end
		end

		bindHumanoid(character:FindFirstChildOfClass("Humanoid"))
		connections[#connections + 1] = character.ChildAdded:Connect(function(child)
			if child:IsA("Humanoid") then
				bindHumanoid(child)
				dmvsInfectionMarkDirty()
			end
		end)
	end

	local function setupPlayerEvents(p)
		if not p or p == player or not p.Parent then
			return
		end

		disconnectPlayerTeamEvents(p)
		dmvsTeamPlayerConnections[p] = {
			p:GetPropertyChangedSignal("Team"):Connect(updateEnemy),
			p:GetPropertyChangedSignal("TeamColor"):Connect(updateEnemy),
			p:GetAttributeChangedSignal("Team"):Connect(updateEnemy),
			p:GetAttributeChangedSignal("team"):Connect(updateEnemy),
			p:GetAttributeChangedSignal("Game"):Connect(updateEnemy),
			p:GetAttributeChangedSignal("MatchId"):Connect(updateEnemy),
			p.AttributeChanged:Connect(function(name)
				if name == "InfectionPatientZero" or name == "InfectionInfected" or name == "IsInfected" or name == "Infected" or name == "IsZombie" or name == "Zombie" then
					dmvsInfectionMarkDirty()
					updateEnemy()
				end
			end),
			p.CharacterAdded:Connect(function(character)
				dmvsWatchInfectionCharacter(p, character)
				dmvsInfectionMarkDirty()
				updateEnemy()
			end),
			p.CharacterRemoving:Connect(function(character)
				dmvsWatchInfectionCharacter(p, nil)
				dmvsInfectionMarkDirty()
				if dmvsClearTargetParts then
					dmvsClearTargetParts(character)
				end
			end)
		}

		dmvsWatchInfectionCharacter(p, p.Character)
		updateEnemy()
	end

	local nexvyrTargetConnections = {}
	local nexvyrTargetMonitorActive = false
	local nexvyrTargetMonitorSession = 0
	local function nexvyrMonitorConnection(connection)
		nexvyrTargetConnections[#nexvyrTargetConnections + 1] = connection
		return connection
	end

	local function nexvyrStartTargetMonitor()
		if nexvyrTargetMonitorActive then
			return
		end

		nexvyrTargetMonitorActive = true
		nexvyrTargetMonitorSession += 1
		local session = nexvyrTargetMonitorSession
		local function localChanged()
			updateMyTeam();
			dmvsInfectionMarkDirty()
		end

		for _, name in ipairs({ "Team", "TeamColor" }) do
			nexvyrMonitorConnection(player:GetPropertyChangedSignal(name):Connect(localChanged))
		end

		for _, name in ipairs({ "Team", "team", "Game", "MatchId", "GameMode", "MatchMode", "Mode" }) do
			nexvyrMonitorConnection(player:GetAttributeChangedSignal(name):Connect(localChanged))
		end

		nexvyrMonitorConnection(player.AttributeChanged:Connect(function(name)
			if name == "InfectionPatientZero" or name == "InfectionInfected" or name == "IsInfected" or name == "Infected" or name == "IsZombie" or name == "Zombie" then
				dmvsInfectionMarkDirty()
			end
		end))

		nexvyrMonitorConnection(player.CharacterAdded:Connect(dmvsInfectionMarkDirty))
		nexvyrMonitorConnection(playerGui.DescendantAdded:Connect(function(instance)
			if instance.Name == "IngameScore" or instance.Name == "TeamRed" or instance.Name == "TeamBlue" then
				dmvsInvalidateScoreboard();
				dmvsInfectionMarkDirty()
			end
		end))

		nexvyrMonitorConnection(playerGui.DescendantRemoving:Connect(function(instance)
			if instance == dmvsTeamResolverState.Scoreboard or instance.Name == "IngameScore" or instance.Name == "TeamRed" or instance.Name == "TeamBlue" then
				dmvsInvalidateScoreboard();
				dmvsInfectionMarkDirty()
			end
		end))

		for _, other in ipairs(Players:GetPlayers()) do
			if other ~= player then
				setupPlayerEvents(other)
			end
		end

		nexvyrMonitorConnection(Players.PlayerAdded:Connect(function(other)
			dmvsInfectionState.LateJoiners[other] = true
			setupPlayerEvents(other)
			dmvsInfectionMarkDirty()
		end))

		nexvyrMonitorConnection(Players.PlayerRemoving:Connect(function(other)
			disconnectPlayerTeamEvents(other)
			for i = #dmvsInfectionState.Pending, 1, -1 do
				local entry = dmvsInfectionState.Pending[i]
				if entry.Killer == other or entry.Victim == other then
					table.remove(dmvsInfectionState.Pending, i)
				end
			end

			for _, bucket in ipairs({ "Converted", "ConvertedAt", "LateJoiners", "Inferred", "Targets", "RoleTeams" }) do
				dmvsInfectionState[bucket][other] = nil
			end

			updateEnemy()
		end))

		dmvsInvalidateScoreboard()
		dmvsInfectionMarkDirty()
		task.spawn(function()
			local registered = {}
			local listeners = {
				["RE/Combat/Killed"] = dmvsInfectionOnKill,
				["RE/Match/PlayerRespawned"] = dmvsInfectionMarkDirty,
				["RE/Match/StartRoundGui"] = function()
					dmvsClearInfectionRound(false)
				end,
				["RE/Match/MatchResults"] = function()
					if dmvsInfectionState.Active then
						dmvsClearInfectionRound(true)
					end
				end
			}

			while nexvyrTargetMonitorActive and session == nexvyrTargetMonitorSession do
				local packages = ReplicatedStorage:FindFirstChild("Packages")
				local networking = packages and packages:FindFirstChild("Networking")
				local finished = true
				for name, callback in pairs(listeners) do
					if not registered[name] then
						local remote = networking and networking:FindFirstChild(name)
						if remote and remote:IsA("RemoteEvent") then
							nexvyrMonitorConnection(remote.OnClientEvent:Connect(callback))
							registered[name] = true
						else
							finished = false
						end
					end
				end

				if finished then
					break
				end

				task.wait(2)
			end
		end)
	end

	local function nexvyrStopTargetMonitor()
		if not nexvyrTargetMonitorActive then
			return
		end

		nexvyrTargetMonitorActive = false
		nexvyrTargetMonitorSession += 1
		dmvsDisconnectConnectionList(nexvyrTargetConnections)
		for other in pairs(dmvsTeamPlayerConnections) do
			disconnectPlayerTeamEvents(other)
		end

		dmvsDisconnectConnectionList(dmvsTeamResolverState.WatchConnections)
		dmvsTeamResolverState.Scoreboard = nil
		dmvsTeamResolverState.Snapshot = {}
		dmvsTeamResolverState.InGame = false
		dmvsTeamResolverState.Dirty = true
		dmvsClearInfectionRound(false)
	end

	nexvyrRefreshTargetMonitor = function()
		if autoShootEnabled or autoShootAgresivoEnabled or silentAimManualEnabled or silentAimFovEnabled or equipGunEnabled or (espEnabled and (espSettings.Glow or espSettings.Box or espSettings.Name)) or hitboxEnabled or KillAllEnabled then
			nexvyrStartTargetMonitor()
		else
			nexvyrStopTargetMonitor()
		end
	end

	isEnemy = function(targetPlayer)
		if not dmvsIsInSameGame(targetPlayer) or not targetPlayer.Character then
			return false
		end

		if not dmvsIsTargetAlive(targetPlayer) then
			return false
		end

		return dmvsPlayersAreEnemies(player, targetPlayer)
	end

	esEnemigoValido = function(other)
		if not isEnemy(other) then
			return false
		end

		local character = other.Character
		return character ~= nil and not character:FindFirstChildOfClass("ForceField") and dmvsIsTargetAlive(other)
	end

	local SAFE_ZONES = {
		{ Center = Vector3.new(-320.50, 280.82, 16.00), Radius = 500 },
		{ Center = Vector3.new(1564.14, -155.45, 40.04), Radius = 300 }
	}

	estaEnLobby = function()
		local character = player.Character
		if not character then
			return true
		end

		if character:FindFirstChildOfClass("ForceField") then
			return true
		end

		if player.Team then
			local name = player.Team.Name:lower()
			if name:find("lobby") or name:find("spectat") or name:find("espectador") or name:find("menu") or name:find("dead") then
				return true
			end
		end

		local root = character:FindFirstChild("HumanoidRootPart")
		if root then
			for _, zone in ipairs(SAFE_ZONES) do
				if (root.Position - zone.Center).Magnitude <= zone.Radius then
					return true
				end
			end
		end

		return false
	end

	IsInMatchStrict = function()
		if estaEnLobby() then
			return false
		end

		dmvsRefreshScoreboardTeams(false)
		return dmvsTeamResolverState.InGame or dmvsIsInfectionMode()
	end

	esCuchillo = function(tool)
		if not tool or not tool:IsA("Tool") then
			return false
		end

		if tool:FindFirstChild("Slash") or tool:FindFirstChild("SlashStart") then
			return true
		end

		local name = tool.Name:lower()
		return name:find("knife", 1, true) ~= nil or name:find("cuchillo", 1, true) ~= nil or name:find("dagger", 1, true) ~= nil
	end

	esPistola = function(tool)
		if not tool or not tool:IsA("Tool") then
			return false
		end

		local beam = tool:FindFirstChild("showBeam")
		return beam ~= nil and beam:IsA("RemoteEvent")
	end

	obtenerPistola = function()
		local character = player.Character
		if character then
			for _, tool in ipairs(character:GetChildren()) do
				if esPistola(tool) then
					return tool
				end
			end
		end

		local backpack = player:FindFirstChildOfClass("Backpack")
		if backpack then
			for _, tool in ipairs(backpack:GetChildren()) do
				if esPistola(tool) then
					return tool
				end
			end
		end

		return nil
	end
end


local function estaRecargando(arma)
	if not arma or not arma:IsA("Tool") then
		return false
	end

	for _, name in ipairs({ "Reloading", "IsReloading", "reloading", "isReloading", "Reload", "reload" }) do
		local v = arma:GetAttribute(name)
		if v == true or v == "true" then
			return true
		end
	end

	for _, child in ipairs(arma:GetChildren()) do
		if child:IsA("BoolValue") and child.Value == true then
			local n = string.lower(child.Name)
			if string.find(n, "reload") or string.find(n, "recarg") then
				return true
			end
		end
	end

	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
			local animId = track.Animation and track.Animation.AnimationId or ""
			if string.find(string.lower(animId), "reload") then
				return true
			end
		end
	end

	for _, s in ipairs(arma:GetDescendants()) do
		if s:IsA("Sound") and s.Playing then
			local n = string.lower(s.Name)
			if string.find(n, "reload") or string.find(n, "recarg") then
				return true
			end
		end
	end

	return false
end


local ConnectionManager = {}
ConnectionManager.__index = ConnectionManager


function ConnectionManager.new()
	return setmetatable({ Items = {} }, ConnectionManager)
end


function ConnectionManager:Add(task)
	self.Items[#self.Items + 1] = task;
	return task
end


function ConnectionManager:Cleanup()
	for i = #self.Items, 1, -1 do
		local item = self.Items[i]
		self.Items[i] = nil
		local t = typeof(item)
		if t == "RBXScriptConnection" then
			pcall(function()
				item:Disconnect()
			end)
		elseif t == "Instance" then
			pcall(function()
				item:Destroy()
			end)
		elseif t == "function" then
			pcall(item)
		end
	end
end


local function limpiarHitboxes()
	for _, targetPlayer in ipairs(Players:GetPlayers()) do
		local character = targetPlayer.Character
		if character then
			local hitbox = character:FindFirstChild("GhostHitbox")
			if hitbox then
				hitbox:Destroy()
			end
		end
	end
end


do
	local nexvyrHitboxWorkerRunning = false
	nexvyrStartHitboxWorker = function()
		if nexvyrHitboxWorkerRunning or not hitboxEnabled then
			return
		end

		nexvyrHitboxWorkerRunning = true
		task.spawn(function()
			while hitboxEnabled do
				task.wait(0.2)
				if not hitboxEnabled then
					break
				end

				if not IsInMatchStrict() then
					limpiarHitboxes()
					continue
				end

				local tamanoObjetivo = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
				local transObjetivo = hitboxInvisible and 1 or 0.6
				for _, targetPlayer in ipairs(Players:GetPlayers()) do
					if targetPlayer ~= player and isEnemy(targetPlayer) then
						local character = targetPlayer.Character
						if character then
							local rootPart = character:FindFirstChild("HumanoidRootPart")
							local humanoid = character:FindFirstChildOfClass("Humanoid")
							if rootPart and humanoid and humanoid.Health > 0 then
								local hitbox = character:FindFirstChild("GhostHitbox")
								if not hitbox then
									hitbox = Instance.new("Part")
									hitbox.Name = "GhostHitbox"
									hitbox.Size = tamanoObjetivo
									hitbox.Transparency = transObjetivo
									hitbox.Color = hitboxColor
									hitbox.CanCollide = false
									hitbox.Massless = true
									hitbox.CanQuery = true
									hitbox.CFrame = rootPart.CFrame
									hitbox.Parent = character
									local weld = Instance.new("WeldConstraint")
									weld.Part0 = rootPart
									weld.Part1 = hitbox
									weld.Parent = hitbox
								else
									if hitbox.Size ~= tamanoObjetivo then
										hitbox.Size = tamanoObjetivo
									end

									if hitbox.Transparency ~= transObjetivo then
										hitbox.Transparency = transObjetivo
									end

									if hitbox.Color ~= hitboxColor then
										hitbox.Color = hitboxColor
									end

									if not hitbox.CanQuery then
										hitbox.CanQuery = true
									end
								end
							else
								local hitbox = character:FindFirstChild("GhostHitbox")
								if hitbox then
									hitbox:Destroy()
								end
							end
						end
					else
						local char = targetPlayer.Character
						if char then
							local hb = char:FindFirstChild("GhostHitbox")
							if hb then
								hb:Destroy()
							end
						end
					end
				end
			end

			nexvyrHitboxWorkerRunning = false
			if not hitboxEnabled then
				limpiarHitboxes()
			end
		end)
	end
end


local PadZoneConfig = {
	["Right Platforms"] = {
		["1v1"] = { ZoneName = "PadZone1", MainPad = "Pad1", AltPad = "Pad2" },
		["2v2"] = { ZoneName = "PadZone2", MainPad = "Pad1", AltPad = "Pad2" },
		["3v3"] = { ZoneName = "PadZone3", MainPad = "Pad1", AltPad = "Pad2" },
		["4v4"] = { ZoneName = "PadZone4", MainPad = "Pad1", AltPad = "Pad2" }
	}, ["Left Platforms"] = {
	["1v1"] = { ZoneName = "PadZone5", MainPad = "Pad1", AltPad = "Pad2" },
	["2v2"] = { ZoneName = "PadZone6", MainPad = "Pad1", AltPad = "Pad2" },
	["3v3"] = { ZoneName = "PadZone7", MainPad = "Pad1", AltPad = "Pad2" },
	["4v4"] = { ZoneName = "PadZone8", MainPad = "Pad1", AltPad = "Pad2" }
} }


AutoTeleportMainAlt = {}
AutoTeleportMainAlt.__index = AutoTeleportMainAlt


function AutoTeleportMainAlt.new()
	return setmetatable({
		Running = false,
		Connections = ConnectionManager.new(),
		Acc = 0,
		TickInterval = 0.5,
		ActiveRole = nil,
		DuelType = "1v1",
		PlatformRow = "Right Platforms",
		LastTeleport = 0,
		LastVote = 0,
		LastCancel = 0,
		TeleportCooldown = 0.5,
		VoteCooldown = 1,
		CancelCooldown = 1,
		VotedMap = nil,
		HighlightedPad = nil,
		PadColors = {},
	}, AutoTeleportMainAlt)
end


function AutoTeleportMainAlt:GetActiveRole()
	if self.ActiveRole == "Main" then
		return "Main"
	end

	if self.ActiveRole == "Alt" then
		return "Alt"
	end

	return nil
end


function AutoTeleportMainAlt:GetRoot()
	local char = player.Character
	if not char then
		return nil
	end

	local root = char:FindFirstChild("HumanoidRootPart")
	if root and root:IsA("BasePart") then
		return root
	end

	return nil
end


function AutoTeleportMainAlt:GetHumanoid()
	local char = player.Character
	return char and char:FindFirstChildOfClass("Humanoid") or nil
end


function AutoTeleportMainAlt:Attr(name)
	local v = player:GetAttribute(name)
	if typeof(v) == "string" and v ~= "" then
		return v
	end

	return nil
end


function AutoTeleportMainAlt:Snapshot()
	local gameAttr = self:Attr("Game")
	local mapAttr = self:Attr("Map")
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local alive = hum ~= nil and hum.Health > 0 and root ~= nil
	return {
		Game = gameAttr,
		Map = mapAttr,
		InGame = gameAttr ~= nil,
		InMap = gameAttr ~= nil and mapAttr ~= nil,
		Alive = alive
	}
end


function AutoTeleportMainAlt:IsOnMatch()
	local s = self:Snapshot()
	return s and s.InGame == true and s.InMap ~= true and s.Alive
end


function AutoTeleportMainAlt:ResolvePad(role)
	local rowConfig = PadZoneConfig[self.PlatformRow] or PadZoneConfig["Right Platforms"]
	local cfg = rowConfig[self.DuelType] or rowConfig["1v1"]
	local padZones = workspace:FindFirstChild("PadZones")
	if not padZones then
		return nil
	end

	local zone = padZones:FindFirstChild(cfg.ZoneName)
	if not zone then
		return nil
	end

	local padName = (role == "Alt") and cfg.AltPad or cfg.MainPad
	local holder = zone:FindFirstChild(padName)
	if not holder then
		return nil
	end

	local pad = holder:FindFirstChild("Pad")
	if pad and pad:IsA("BasePart") then
		return pad
	end

	return nil
end


function AutoTeleportMainAlt:IsOnPad(pad)
	if not pad then
		return false
	end

	local root = self:GetRoot()
	if not root then
		return false
	end

	local rel = pad.CFrame:PointToObjectSpace(root.Position)
	local half = pad.Size / 2
	return math.abs(rel.X) <= half.X + 0.5 and math.abs(rel.Z) <= half.Z + 0.5 and rel.Y >= - (half.Y + 6) and rel.Y <= half.Y + 14
end


function AutoTeleportMainAlt:MarkPad(pad, isAlt)
	if not pad then
		self:UnmarkPad();
		return
	end

	if self.HighlightedPad == pad then
		return
	end

	self:UnmarkPad()
	self.HighlightedPad = pad
	self.PadColors[pad] = { Color = pad.Color, Transparency = pad.Transparency }
	pcall(function()
		pad.Color = isAlt and Color3.fromRGB(255, 182, 193) or Color3.fromRGB(140, 100, 200)
		pad.Transparency = 0.5
	end)
end


function AutoTeleportMainAlt:UnmarkPad()
	if self.HighlightedPad and self.PadColors[self.HighlightedPad] then
		local pad = self.HighlightedPad
		local saved = self.PadColors[pad]
		pcall(function()
			if pad.Parent then
				pad.Color = saved.Color
				pad.Transparency = saved.Transparency
			end
		end)
	end

	self.HighlightedPad = nil
end


function AutoTeleportMainAlt:FindVoteRemote()
	local pkgs = ReplicatedStorage:FindFirstChild("Packages")
	local net = pkgs and pkgs:FindFirstChild("Networking")
	local r = net and net:FindFirstChild("RF/Voting/Vote")
	if r and r:IsA("RemoteFunction") then
		return r
	end

	return nil
end


function AutoTeleportMainAlt:FindVisibleMapVote()
	local pg = player:FindFirstChild("PlayerGui")
	local main = pg and pg:FindFirstChild("Main")
	local mv = main and main:FindFirstChild("MapVoting")
	local holder = mv and mv:FindFirstChild("VotingHolder")
	if not holder then
		return nil
	end

	for _, b in ipairs(holder:GetChildren()) do
		if b:IsA("ImageButton") and b.Visible and b.Name ~= "" then
			return b.Name
		end
	end

	return nil
end


function AutoTeleportMainAlt:VoteMap()
	local s = self:Snapshot()
	if not self:IsOnMatch() then
		return
	end

	if self.VotedMap == s.Game then
		return
	end

	local now = os.clock()
	if now - (self.LastVote or 0) < self.VoteCooldown then
		return
	end

	self.LastVote = now
	local target = self:FindVisibleMapVote()
	local rf = self:FindVoteRemote()
	if not (target and rf) then
		return
	end

	self.VotedMap = s.Game
	pcall(function()
		rf:InvokeServer(target)
	end)
end


function AutoTeleportMainAlt:FindSetStateRemote()
	local pkgs = ReplicatedStorage:FindFirstChild("Packages")
	local net = pkgs and pkgs:FindFirstChild("Networking")
	local r = net and net:FindFirstChild("RE/Match/SetStatePlr")
	if r and r:IsA("RemoteEvent") then
		return r
	end

	return nil
end


function AutoTeleportMainAlt:CancelQueue()
	local now = os.clock()
	if now - (self.LastCancel or 0) < self.CancelCooldown then
		return
	end

	local ev = self:FindSetStateRemote()
	if not ev then
		return
	end

	self.LastCancel = now
	pcall(function()
		ev:FireServer("REMOVE")
	end)
end


function AutoTeleportMainAlt:HideGameFrame()
	local pg = player:FindFirstChild("PlayerGui")
	local main = pg and pg:FindFirstChild("Main")
	local mgf = main and main:FindFirstChild("MainGameFrame")
	if mgf and mgf:IsA("GuiObject") then
		pcall(function()
			mgf.Visible = false
		end)
	end
end


function AutoTeleportMainAlt:HoldCenter()
	local hum = self:GetHumanoid()
	local root = self:GetRoot()
	if hum and root then
		pcall(function()
			hum:MoveTo(root.Position)
		end)
	end
end


function AutoTeleportMainAlt:Teleport(pad)
	if not pad then
		return
	end

	local root = self:GetRoot()
	local hum = self:GetHumanoid()
	if not (root and hum) then
		return
	end

	pcall(function()
		root.AssemblyAngularVelocity = Vector3.zero
		root.AssemblyLinearVelocity = Vector3.zero
		self:CancelQueue()
		self:HideGameFrame()
		hum:MoveTo(pad.Position)
	end)
end


function AutoTeleportMainAlt:Process()
	if not self.Running then
		return
	end

	local s = self:Snapshot()
	if s.InGame then
		self:UnmarkPad();
		self:HoldCenter();
		self:VoteMap();
		return
	end

	local role = self:GetActiveRole()
	if not role then
		self:UnmarkPad();
		return
	end

	local pad = self:ResolvePad(role)
	self:MarkPad(pad, role == "Alt")
	if not pad then
		return
	end

	if self:IsOnPad(pad) then
		return
	end

	local now = os.clock()
	if now - (self.LastTeleport or 0) < self.TeleportCooldown then
		return
	end

	self.LastTeleport = now
	self:Teleport(pad)
end


function AutoTeleportMainAlt:Kick()
	if self.Running then
		self:Process()
	end
end


function AutoTeleportMainAlt:Start()
	if self.Running then
		return
	end

	self.Running = true
	self.Acc = 0;
	self.LastTeleport = 0;
	self.LastVote = 0;
	self.LastCancel = 0
	self.Connections:Add(player:GetAttributeChangedSignal("Game"):Connect(function()
		task.defer(function()
			if self.Running then
				self:Process()
			end
		end)
	end))

	self.Connections:Add(player:GetAttributeChangedSignal("Map"):Connect(function()
		task.defer(function()
			if self.Running then
				self:Process()
			end
		end)
	end))

	self.Connections:Add(player:GetAttributeChangedSignal("Team"):Connect(function()
		task.defer(function()
			if self.Running then
				self:Process()
			end
		end)
	end))

	self.Connections:Add(RunService.Heartbeat:Connect(function(dt)
		if not self.Running then
			return
		end

		self.Acc = self.Acc + dt
		if self.Acc >= self.TickInterval then
			self.Acc = 0;
			self:Process()
		end
	end))

	self:Process()
end


function AutoTeleportMainAlt:Stop()
	if not self.Running then
		return
	end

	self.Running = false
	self.Connections:Cleanup()
	self.Connections = ConnectionManager.new()
	self:UnmarkPad()
	self.VotedMap = nil
end


AutoTeleportMainAltInstance = AutoTeleportMainAlt.new()


local function IsRoundTimerActive()
	local gui = player:FindFirstChild("PlayerGui")
	if not gui then
		return false
	end

	local main = gui:FindFirstChild("Main") or gui
	local gameFrame = main:FindFirstChild("MainGameFrame")
	if not gameFrame or not gameFrame.Visible then
		return false
	end

	local score = gameFrame:FindFirstChild("IngameScore")
	local timer = score and score:FindFirstChild("Timer")
	if not timer then
		return false
	end

	if not (timer:IsA("TextLabel") or timer:IsA("TextButton") or timer:IsA("TextBox")) then
		return false
	end

	local txt = tostring(timer.Text or ""):gsub("%s", "")
	if txt == "" then
		return false
	end

	if string.find(txt, "-") then
		return false
	end

	if txt == "0:00" or txt == "00:00" or txt == "0:0" then
		return false
	end

	return txt:match("^%d+:%d%d$") ~= nil
end


do
	local KILLALL_MOVE_SPEED = 39.9
	local KILLALL_APPROACH_DISTANCE = 1.2
	local KILLALL_APPROACH_TOLERANCE = 0.6
	local KILLALL_SWING_INTERVAL = 0.5
	local KILLALL_SAFE_GROUND_THRESHOLD = 3
	local KILLALL_STICK_MAX_TIME = 2.5
	local KILLALL_STICK_MAX_DISTANCE = 20
	local KILLALL_VOID_PROTECTION = 15
	local KILLALL_HEALTH_STALL_TIME = 1.5
	local KILLALL_TARGET_GRACE_TIME = 1.2
	local KILLALL_PITCH_DEGREES = 90
	local KILLALL_HEIGHT_OFFSET = 2.5
	local KILLALL_HIDE_DEPTH = 6
	local KILLALL_HIDE_DURATION = 0.5
	local KILLALL_KNIFE_RANGE_Y = 7.5
	local KILLALL_JITTER_AMPLITUDE = 0.3
	local KILLALL_JITTER_SWITCH_MIN = 0.08
	local KILLALL_JITTER_SWITCH_MAX = 0.16
	local KILLALL_JITTER_LERP_SPEED = 25
	local KILLALL_UNDERGROUND_DEPTH = 6
	local KILLALL_UNDERGROUND_TOLERANCE = 1.5
	local KILLALL_TRIGGER_RADIUS = 6.0
	local KILLALL_TRIGGER_TIMEOUT = 0.6
	local KILLALL_FLOOR_REFRESH = 0.25
	local KILLALL_VALIDATION_TOLERANCE = 1.0
	local KILLALL_VALIDATION_FRAMES = 3
	local KILLALL_PREDICT_TIME = 0.06
	local KILLALL_STICK_LERP_SPEED = 40
	local KILLALL_BOB_SPEED = 20
	local KILLALL_BOB_UP = 2.5
	local KILLALL_BOB_DOWN = 1.5
	local KillAll = {}
	KillAll.__index = KillAll
	function KillAll.new()
		return setmetatable({
			running = false,
			connections = ConnectionManager.new(),
			savedCollisions = {},
			swingAccumulator = 0,
			safePosition = nil,
			sticking = false,
			stickingStartTime = 0,
			lastEnemyHealth = nil,
			lastHealthChangeTime = 0,
			lastTargetSeenTime = 0,
			currentTarget = nil,
			lockedTargetPlayer = nil,
			lastStickTarget = nil,
			lastStickTargetHum = nil,
			hiding = false,
			hidingUntil = 0,
			targetFloor = nil,
			targetFloorY = nil,
			lastFloorTarget = nil,
			floorCheckTime = 0,
			triggerStart = nil,
			inKnifeRangeNow = false,
			forceDescent = false,
			jitterSide = 1,
			jitterCurrent = 0,
			jitterNextSwitch = 0,
			lastSetCFrame = nil,
			validFrames = 0,
			killActivated = false,
			bobTime = 0,
		}, KillAll)
	end

	function KillAll:DisableCollisions()
		local char = player.Character
		if not char then
			return
		end

		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				if self.savedCollisions[part] == nil then
					self.savedCollisions[part] = part.CanCollide
				end

				part.CanCollide = false
			end
		end
	end

	function KillAll:RestoreCollisions()
		for part, value in pairs(self.savedCollisions) do
			if part.Parent then
				pcall(function()
					part.CanCollide = value
				end)
			end
		end

		table.clear(self.savedCollisions)
	end

	function KillAll:GetRoot(p)
		local char = p and p.Character
		if not char then
			return nil
		end

		local root = char:FindFirstChild("HumanoidRootPart")
		if root and root:IsA("BasePart") then
			return root
		end

		return nil
	end

	function KillAll:GetHumanoid(p)
		local char = p and p.Character
		return char and char:FindFirstChildOfClass("Humanoid") or nil
	end

	function KillAll:GetFloorY(targetRoot)
		local hum = targetRoot.Parent and targetRoot.Parent:FindFirstChildOfClass("Humanoid")
		local hip = hum and tonumber(hum.HipHeight) or 2
		return targetRoot.Position.Y - hip - targetRoot.Size.Y / 2
	end

	function KillAll:GetPlatformFloorY(targetRoot)
		if not targetRoot then
			return nil
		end

		local now = os.clock()
		if self.lastFloorTarget == targetRoot and self.targetFloorY and (now - (self.floorCheckTime or 0)) < KILLALL_FLOOR_REFRESH then
			return self.targetFloorY
		end

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = { player.Character, targetRoot.Parent }
		local origin = targetRoot.Position + Vector3.new(0, 3, 0)
		local result = workspace:Raycast(origin, Vector3.new(0, -500, 0), params)
		self.floorCheckTime = now
		if result then
			self.targetFloorY = result.Position.Y
			self.lastFloorTarget = targetRoot
			return self.targetFloorY
		end

		self.targetFloorY = self:GetFloorY(targetRoot)
		self.lastFloorTarget = targetRoot
		return self.targetFloorY
	end

	function KillAll:IsInKnifeRange(myRoot, targetRoot)
		if not myRoot or not targetRoot then
			return false
		end

		local delta = targetRoot.Position - myRoot.Position
		local horizontal = Vector3.new(delta.X, 0, delta.Z).Magnitude
		local vertical = math.abs(delta.Y)
		return horizontal <= (KILLALL_APPROACH_DISTANCE + KILLALL_APPROACH_TOLERANCE) and vertical <= KILLALL_KNIFE_RANGE_Y
	end

	function KillAll:IsLockedTargetValid()
		local lp = self.lockedTargetPlayer
		if not lp then
			return false
		end

		if not lp.Parent then
			return false
		end

		if not esEnemigoValido(lp) then
			return false
		end

		local char = lp.Character
		if not char then
			return false
		end

		local root = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not root or not hum then
			return false
		end

		if hum.Health <= 0 then
			return false
		end

		return root
	end

	function KillAll:GetClosestEnemy()
		local myRoot = self:GetRoot(player)
		if not myRoot then
			return nil
		end

		local lockedRoot = self:IsLockedTargetValid()
		if lockedRoot then
			return lockedRoot
		end

		self.lockedTargetPlayer = nil
		self.currentTarget = nil
		local best, bestDist, bestPlayer = nil, nil, nil
		for _, other in ipairs(Players:GetPlayers()) do
			if other ~= player and esEnemigoValido(other) then
				local hum = self:GetHumanoid(other)
				local root = self:GetRoot(other)
				if root and hum and hum.Health > 0 then
					local dist = (root.Position - myRoot.Position).Magnitude
					if not bestDist or dist < bestDist then
						best, bestDist, bestPlayer = root, dist, other
					end
				end
			end
		end

		if bestPlayer then
			self.lockedTargetPlayer = bestPlayer
		end

		return best
	end

	function KillAll:IsInMatch()
		return IsRoundTimerActive()
	end

	function KillAll:ResetState()
		self.sticking = false
		self.stickingStartTime = 0
		self.lastEnemyHealth = nil
		self.lastHealthChangeTime = 0
		self.targetFloor = nil
		self.inKnifeRangeNow = false
		self.forceDescent = false
		self.jitterSide = 1
		self.jitterCurrent = 0
		self.jitterNextSwitch = 0
		self.lastSetCFrame = nil
		self.validFrames = 0
		self.killActivated = false
		self.triggerStart = nil
		self.bobTime = 0
		self:RestoreCollisions()
		local hum = self:GetHumanoid(player)
		if hum and hum.PlatformStand then
			pcall(function()
				hum.PlatformStand = false
			end)
		end
	end

	function KillAll:ReturnToSafePosition(myRoot)
		if not self.safePosition or not myRoot then
			return
		end

		local currentY = myRoot.Position.Y
		if currentY < (self.safePosition.Y - KILLALL_SAFE_GROUND_THRESHOLD) then
			pcall(function()
				myRoot.CFrame = CFrame.new(self.safePosition)
				myRoot.AssemblyLinearVelocity = Vector3.zero
				myRoot.AssemblyAngularVelocity = Vector3.zero
			end)
		end
	end

	function KillAll:ForceReturnToSafe(myRoot)
		if not self.safePosition or not myRoot then
			return
		end

		pcall(function()
			myRoot.CFrame = CFrame.new(self.safePosition)
			myRoot.AssemblyLinearVelocity = Vector3.zero
			myRoot.AssemblyAngularVelocity = Vector3.zero
		end)
	end

	function KillAll:IsFallingIntoVoid(myRoot)
		if not self.safePosition or not myRoot then
			return false
		end

		local limit = self.safePosition.Y - KILLALL_VOID_PROTECTION
		if self.targetFloorY and self.lastFloorTarget and self.lastFloorTarget.Parent then
			limit = math.min(limit, self.targetFloorY - KILLALL_UNDERGROUND_DEPTH - KILLALL_VOID_PROTECTION)
		end

		return myRoot.Position.Y < limit
	end

	function KillAll:HideBelowMap()
		local myRoot = self:GetRoot(player)
		if not myRoot then
			return
		end

		local baseY = self.safePosition and self.safePosition.Y or myRoot.Position.Y
		local hideY = baseY - KILLALL_HIDE_DEPTH
		local currentX, currentZ = myRoot.Position.X, myRoot.Position.Z
		pcall(function()
			myRoot.CFrame = CFrame.new(currentX, hideY, currentZ)
			myRoot.AssemblyLinearVelocity = Vector3.zero
			myRoot.AssemblyAngularVelocity = Vector3.zero
		end)

		self.hiding = true
		self.hidingUntil = os.clock() + KILLALL_HIDE_DURATION
	end

	function KillAll:IsKnife(tool)
		if not (tool and tool:IsA("Tool")) then
			return false
		end

		if tool:FindFirstChild("fire") or tool:FindFirstChild("showBeam") then
			return false
		end

		return tool:FindFirstChild("Slash") ~= nil or tool:FindFirstChild("SlashStart") ~= nil
	end

	function KillAll:FindKnife()
		local char = player.Character
		if char then
			for _, child in ipairs(char:GetChildren()) do
				if self:IsKnife(child) then
					return child, true
				end
			end
		end

		local backpack = player:FindFirstChildOfClass("Backpack")
		if backpack then
			for _, child in ipairs(backpack:GetChildren()) do
				if self:IsKnife(child) then
					return child, false
				end
			end
		end

		return nil, false
	end

	function KillAll:SwingKnife(dt)
		self.swingAccumulator = self.swingAccumulator + dt
		if self.swingAccumulator < KILLALL_SWING_INTERVAL then
			return
		end

		self.swingAccumulator = 0
		local tool, equipped = self:FindKnife()
		if not tool then
			return
		end

		if not equipped then
			local hum = self:GetHumanoid(player)
			if not hum then
				return
			end

			pcall(function()
				hum:EquipTool(tool)
			end)

			if tool.Parent ~= player.Character then
				return
			end
		end

		pcall(function()
			tool:Activate()
		end)
	end

	function KillAll:UpdateJitter(dt)
		local now = os.clock()
		if now >= self.jitterNextSwitch then
			self.jitterSide = (math.random() < 0.5) and 1 or -1
			self.jitterNextSwitch = now + KILLALL_JITTER_SWITCH_MIN + math.random() * (KILLALL_JITTER_SWITCH_MAX - KILLALL_JITTER_SWITCH_MIN)
		end

		local targetOffset = self.jitterSide * KILLALL_JITTER_AMPLITUDE
		self.jitterCurrent = self.jitterCurrent + (targetOffset - self.jitterCurrent) * math.clamp(dt * KILLALL_JITTER_LERP_SPEED, 0, 1)
	end

	function KillAll:CheckServerValidation(myRoot)
		if self.killActivated then
			return true
		end

		if not self.lastSetCFrame then
			return false
		end

		local desiredPos = self.lastSetCFrame.Position
		local actualPos = myRoot.Position
		local diff = (actualPos - desiredPos).Magnitude
		if diff <= KILLALL_VALIDATION_TOLERANCE then
			self.validFrames = self.validFrames + 1
			if self.validFrames >= KILLALL_VALIDATION_FRAMES then
				self.killActivated = true
				self.swingAccumulator = KILLALL_SWING_INTERVAL
				return true
			end
		else
			self.validFrames = 0
		end

		return false
	end

	function KillAll:ForceUnderground(myRoot, targetRoot)
		if not myRoot or not targetRoot then
			return
		end

		local floorY = self:GetPlatformFloorY(targetRoot)
		if not floorY then
			return
		end

		local targetY = floorY - KILLALL_UNDERGROUND_DEPTH
		if myRoot.Position.Y > targetY + KILLALL_UNDERGROUND_TOLERANCE then
			pcall(function()
				myRoot.CFrame = CFrame.new(myRoot.Position.X, targetY, myRoot.Position.Z)
				myRoot.AssemblyLinearVelocity = Vector3.zero
				myRoot.AssemblyAngularVelocity = Vector3.zero
			end)
		end
	end

	function KillAll:ApproachTarget(myRoot, targetRoot, dt)
		dt = dt or 0
		local myPos = myRoot.Position
		local targetPos = targetRoot.Position
		local deltaXZ = Vector3.new(targetPos.X - myPos.X, 0, targetPos.Z - myPos.Z)
		local hDist = deltaXZ.Magnitude
		if hDist <= KILLALL_TRIGGER_RADIUS then
			if not self.sticking then
				local nowT = os.clock()
				if not self.triggerStart then
					self.triggerStart = nowT
				end

				local lookTarget = Vector3.new(targetPos.X, myPos.Y, targetPos.Z)
				local targetCF = CFrame.lookAt(myPos, lookTarget)
				self.lastSetCFrame = targetCF
				pcall(function()
					myRoot.CFrame = targetCF
					myRoot.AssemblyLinearVelocity = Vector3.zero
					myRoot.AssemblyAngularVelocity = Vector3.zero
				end)

				local validated = self:CheckServerValidation(myRoot)
				if validated or (nowT - self.triggerStart) >= KILLALL_TRIGGER_TIMEOUT then
					self.killActivated = true
					self.swingAccumulator = KILLALL_SWING_INTERVAL
					self.triggerStart = nil
					self.sticking = true
					self.stickingStartTime = os.clock()
					self.lastStickTarget = targetRoot
					self.targetFloor = nil
					self.forceDescent = true
					self.bobTime = 0
					local hum = self:GetHumanoid(targetRoot.Parent)
					self.lastEnemyHealth = hum and hum.Health or nil
					self.lastHealthChangeTime = os.clock()
					self.lastStickTargetHum = hum
					self.jitterCurrent = 0
				end
			end

			return
		end

		self.lastSetCFrame = nil
		self.validFrames = 0
		self.triggerStart = nil
		local dir = deltaXZ.Unit
		local perp = Vector3.new(-dir.Z, 0, dir.X)
		self:UpdateJitter(dt)
		local step = KILLALL_MOVE_SPEED * dt
		local travel = math.min(step, math.max(0, hDist - KILLALL_TRIGGER_RADIUS))
		local maxJitterByDistance = math.sqrt(math.max(0, travel * (2 * hDist - travel))) * 0.85
		local jitterFactor = math.clamp( (hDist - KILLALL_TRIGGER_RADIUS) / 8, 0, 1)
		local desiredJitter = self.jitterCurrent * jitterFactor
		local actualJitter = math.clamp(desiredJitter, -maxJitterByDistance, maxJitterByDistance)
		local baseX = myPos.X + dir.X * travel
		local baseZ = myPos.Z + dir.Z * travel
		local newX = baseX + perp.X * actualJitter
		local newZ = baseZ + perp.Z * actualJitter
		local floorY = self:GetPlatformFloorY(targetRoot)
		local newY
		if floorY then
			newY = floorY - KILLALL_UNDERGROUND_DEPTH
		else
			newY = myPos.Y
		end

		local newPos = Vector3.new(newX, newY, newZ)
		local lookTarget = Vector3.new(targetPos.X, newPos.Y, targetPos.Z)
		local newCFrame = CFrame.lookAt(newPos, lookTarget)
		pcall(function()
			myRoot.CFrame = newCFrame
			myRoot.AssemblyLinearVelocity = Vector3.zero
			myRoot.AssemblyAngularVelocity = Vector3.zero
		end)
	end

	function KillAll:CanStickToTarget(myRoot, targetRoot)
		if not targetRoot or not targetRoot.Parent then
			return false
		end

		local targetPlayer = Players:GetPlayerFromCharacter(targetRoot.Parent)
		if not targetPlayer or not esEnemigoValido(targetPlayer) then
			return false
		end

		local targetHum = targetRoot.Parent:FindFirstChildOfClass("Humanoid")
		if not targetHum or targetHum.Health <= 0 then
			return false
		end

		local distHorizontal = (Vector3.new(myRoot.Position.X, 0, myRoot.Position.Z) - Vector3.new(targetRoot.Position.X, 0, targetRoot.Position.Z)).Magnitude
		if distHorizontal > KILLALL_STICK_MAX_DISTANCE then
			return false
		end

		return true
	end

	function KillAll:StickToTarget(myRoot, targetRoot, dt)
		dt = dt or 0.016
		local targetPos = targetRoot.Position
		local targetHum = targetRoot.Parent and targetRoot.Parent:FindFirstChildOfClass("Humanoid")
		local onGround = targetHum and targetHum.FloorMaterial ~= Enum.Material.Air
		if targetRoot ~= self.lastStickTarget then
			self.lastStickTarget = targetRoot
			self.targetFloor = nil
		end

		if onGround or not self.targetFloor then
			self.targetFloor = self:GetFloorY(targetRoot)
		end

		local myPos = myRoot.Position
		local vel = targetRoot.AssemblyLinearVelocity
		local predX = targetPos.X + vel.X * KILLALL_PREDICT_TIME
		local predZ = targetPos.Z + vel.Z * KILLALL_PREDICT_TIME
		local look = targetRoot.CFrame.LookVector
		local back = Vector3.new(-look.X, 0, -look.Z)
		if back.Magnitude < 0.05 then
			back = Vector3.new(0, 0, 1)
		else
			back = back.Unit
		end

		local x = predX + back.X * KILLALL_APPROACH_DISTANCE
		local z = predZ + back.Z * KILLALL_APPROACH_DISTANCE
		local inRange = self:IsInKnifeRange(myRoot, targetRoot)
		local baseY = self.targetFloor - KILLALL_HEIGHT_OFFSET
		local y
		if inRange and not self.forceDescent then
			self.bobTime = (self.bobTime or 0) + dt
			local wave = math.sin(self.bobTime * KILLALL_BOB_SPEED)
			local bob = wave >= 0 and wave * KILLALL_BOB_UP or wave * KILLALL_BOB_DOWN
			y = baseY + bob
		else
			y = baseY
			if inRange then
				self.forceDescent = false
			end
		end

		local alpha = math.clamp(dt * KILLALL_STICK_LERP_SPEED, 0, 1)
		local newPos = myPos:Lerp(Vector3.new(x, y, z), alpha)
		pcall(function()
			myRoot.CFrame = CFrame.new(newPos) * CFrame.Angles(math.rad(KILLALL_PITCH_DEGREES), 0, 0)
			myRoot.AssemblyLinearVelocity = Vector3.zero
			myRoot.AssemblyAngularVelocity = Vector3.zero
		end)
	end

	function KillAll:CheckEnemyHealth(targetRoot)
		local targetHum = targetRoot.Parent and targetRoot.Parent:FindFirstChildOfClass("Humanoid")
		if not targetHum then
			return false
		end

		local currentHealth = targetHum.Health
		if self.lastEnemyHealth == nil then
			self.lastEnemyHealth = currentHealth
			self.lastHealthChangeTime = os.clock()
			return false
		end

		if currentHealth < self.lastEnemyHealth then
			self.lastEnemyHealth = currentHealth
			self.lastHealthChangeTime = os.clock()
			return false
		end

		if (os.clock() - self.lastHealthChangeTime) >= KILLALL_HEALTH_STALL_TIME then
			return true
		end

		return false
	end

	function KillAll:Update(dt)
		if not self:IsInMatch() then
			self:ResetState()
			self.currentTarget = nil
			self.lockedTargetPlayer = nil
			self.lastStickTarget = nil
			self.lastFloorTarget = nil
			self.targetFloorY = nil
			return
		end

		local myRoot = self:GetRoot(player)
		if not myRoot then
			self:ResetState()
			self.currentTarget = nil
			self.lockedTargetPlayer = nil
			return
		end

		if self.lastStickTargetHum then
			local hum = self.lastStickTargetHum
			if not hum.Parent or hum.Health <= 0 then
				self:HideBelowMap()
				self.inKnifeRangeNow = false
				self.forceDescent = false
				self.lastStickTargetHum = nil
				self.lastStickTarget = nil
				self.sticking = false
				self.stickingStartTime = 0
				self.lastEnemyHealth = nil
				self.lastHealthChangeTime = 0
				self.targetFloor = nil
				self.killActivated = false
				self.validFrames = 0
				self.lastSetCFrame = nil
				self.triggerStart = nil
				self.bobTime = 0
				return
			end
		end

		if self.hiding then
			if os.clock() >= self.hidingUntil then
				self.hiding = false
			else
				pcall(function()
					myRoot.AssemblyLinearVelocity = Vector3.zero
					myRoot.AssemblyAngularVelocity = Vector3.zero
				end)

				return
			end
		end

		if self:IsFallingIntoVoid(myRoot) then
			self:ForceReturnToSafe(myRoot)
			self:ResetState()
			self.currentTarget = nil
			self.lockedTargetPlayer = nil
			self.lastStickTarget = nil
			self.lastFloorTarget = nil
			self.targetFloorY = nil
			local hum = self:GetHumanoid(player)
			if hum then
				pcall(function()
					hum.PlatformStand = false
				end)
			end

			return
		end

		local target = self:GetClosestEnemy()
		if target then
			self.currentTarget = target
			self.lastTargetSeenTime = os.clock()
		end

		if not target then
			local justLostTarget = (os.clock() - (self.lastTargetSeenTime or 0)) < KILLALL_TARGET_GRACE_TIME
			local isUnderground = self.safePosition and myRoot.Position.Y < (self.safePosition.Y - 2)
			if justLostTarget and isUnderground then
				pcall(function()
					myRoot.AssemblyLinearVelocity = Vector3.zero
					myRoot.AssemblyAngularVelocity = Vector3.zero
				end)

				return
			end

			self:ReturnToSafePosition(myRoot)
			self:ResetState()
			self.currentTarget = nil
			self.lockedTargetPlayer = nil
			self.lastStickTarget = nil
			self.lastFloorTarget = nil
			self.targetFloorY = nil
			if self.safePosition then
				local hum = self:GetHumanoid(player)
				if hum then
					pcall(function()
						hum.PlatformStand = false
					end)
				end
			end

			return
		end

		self:DisableCollisions()
		if self.lastStickTarget then
			local inRange = self:IsInKnifeRange(myRoot, self.lastStickTarget)
			if inRange and not self.inKnifeRangeNow then
				self.swingAccumulator = KILLALL_SWING_INTERVAL
				self.inKnifeRangeNow = true
			elseif not inRange then
				self.inKnifeRangeNow = false
			end
		end

		self:SwingKnife(dt or 0)
		local hum = self:GetHumanoid(player)
		if hum and not hum.PlatformStand then
			pcall(function()
				hum.PlatformStand = true
			end)
		end

		if self.safePosition and myRoot.Position.Y >= (self.safePosition.Y - KILLALL_SAFE_GROUND_THRESHOLD) then
			self.safePosition = Vector3.new(myRoot.Position.X, self.safePosition.Y, myRoot.Position.Z)
		end

		if not self.sticking then
			self:ForceUnderground(myRoot, target)
		end

		if self.sticking then
			local lostTarget = (target ~= self.lastStickTarget)
			local timedOut = (os.clock() - self.stickingStartTime) > KILLALL_STICK_MAX_TIME
			local cannotStick = not self:CanStickToTarget(myRoot, target)
			local cannotKill = self:CheckEnemyHealth(target)
			if lostTarget or timedOut or cannotStick or cannotKill then
				self.sticking = false
				self.stickingStartTime = 0
				self.lastEnemyHealth = nil
				self.lastHealthChangeTime = 0
				self.targetFloor = nil
				self.inKnifeRangeNow = false
				self.forceDescent = false
				self.killActivated = false
				self.validFrames = 0
				self.lastSetCFrame = nil
				self.triggerStart = nil
				self.bobTime = 0
				if lostTarget then
					self.lastStickTarget = nil
				end
			else
				self:StickToTarget(myRoot, target, dt or 0)
				return
			end
		end

		self:ApproachTarget(myRoot, target, dt or 0)
	end

	function KillAll:Start()
		if self.running then
			return
		end

		self.running = true
		self.swingAccumulator = 0
		self.sticking = false
		self.stickingStartTime = 0
		self.lastEnemyHealth = nil
		self.lastHealthChangeTime = 0
		self.lastTargetSeenTime = 0
		self.currentTarget = nil
		self.lockedTargetPlayer = nil
		self.lastStickTarget = nil
		self.lastStickTargetHum = nil
		self.hiding = false
		self.hidingUntil = 0
		self.targetFloor = nil
		self.targetFloorY = nil
		self.lastFloorTarget = nil
		self.floorCheckTime = 0
		self.triggerStart = nil
		self.inKnifeRangeNow = false
		self.forceDescent = false
		self.jitterSide = 1
		self.jitterCurrent = 0
		self.jitterNextSwitch = 0
		self.lastSetCFrame = nil
		self.validFrames = 0
		self.killActivated = false
		self.bobTime = 0
		local myRoot = self:GetRoot(player)
		if myRoot then
			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = { player.Character }
			local origin = myRoot.Position + Vector3.new(0, 5, 0)
			local result = workspace:Raycast(origin, Vector3.new(0, -500, 0), params)
			if result then
				self.safePosition = Vector3.new(myRoot.Position.X, result.Position.Y + 3, myRoot.Position.Z)
			else
				self.safePosition = myRoot.Position
			end
		else
			self.safePosition = nil
		end

		self.connections:Add(RunService.Heartbeat:Connect(function(dt)
			if not self.running then
				return
			end

			self:Update(dt)
		end))

		self.connections:Add(player.CharacterAdded:Connect(function()
			table.clear(self.savedCollisions)
			self.sticking = false
			self.safePosition = nil
			self.stickingStartTime = 0
			self.lastEnemyHealth = nil
			self.lastHealthChangeTime = 0
			self.lastTargetSeenTime = 0
			self.currentTarget = nil
			self.lockedTargetPlayer = nil
			self.lastStickTarget = nil
			self.lastStickTargetHum = nil
			self.hiding = false
			self.hidingUntil = 0
			self.targetFloor = nil
			self.targetFloorY = nil
			self.lastFloorTarget = nil
			self.floorCheckTime = 0
			self.triggerStart = nil
			self.inKnifeRangeNow = false
			self.forceDescent = false
			self.jitterSide = 1
			self.jitterCurrent = 0
			self.jitterNextSwitch = 0
			self.lastSetCFrame = nil
			self.validFrames = 0
			self.killActivated = false
			self.bobTime = 0
		end))
	end

	function KillAll:Stop()
		if not self.running then
			return
		end

		local myRoot = self:GetRoot(player)
		if myRoot and self.safePosition then
			pcall(function()
				myRoot.CFrame = CFrame.new(self.safePosition)
				myRoot.AssemblyLinearVelocity = Vector3.zero
				myRoot.AssemblyAngularVelocity = Vector3.zero
			end)
		end

		self.running = false
		self.connections:Cleanup()
		self.connections = ConnectionManager.new()
		self:ResetState()
		self.currentTarget = nil
		self.lockedTargetPlayer = nil
		self.lastStickTarget = nil
		self.lastStickTargetHum = nil
		self.hiding = false
		self.hidingUntil = 0
		self.inKnifeRangeNow = false
		self.forceDescent = false
		self.killActivated = false
		self.targetFloorY = nil
		self.lastFloorTarget = nil
	end

	KillAllInstance = KillAll.new()
end


Tabs.ExtrasScripts:Section({ Title = "Scripts Extras", Icon = "solar:code-bold" })



task.wait()


do
	local DISCORD_LINK = "https://discord.gg/xw3Rr2W7v"
	local IMAGE_ID = 114452675067716
	local THUMB_SIZE = 110
	local ContentProvider = game:GetService("ContentProvider")
	local function new(class, props, parent)
		local o = Instance.new(class)
		for k, v in pairs(props) do
			o[k] = v
		end

		o.Parent = parent
		return o
	end

	local function formatUseTime(total)
		total = math.max(0, math.floor(total))
		local h = math.floor(total / 3600)
		local m = math.floor( (total % 3600) / 60)
		local s = total % 60
		return string.format("%dh %02dm %02ds", h, m, s)
	end

	local executorName = "Desconocido"
	pcall(function()
		local identify = identifyexecutor or getexecutorname
		if identify then
			local name, version = identify()
			if name then
				executorName = tostring(name) .. (version and (" " .. tostring(version)) or "")
			end
		end
	end)

	local profilePara = Tabs.Inicio:Paragraph({
		Title = player.DisplayName,
		Desc = "@" .. player.Name,
		Thumbnail = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150",
		ThumbnailSize = 70,
	})
	task.spawn(function()
		task.wait(0.4)
		local host
		for _, h in ipairs({
				profilePara and profilePara.ElementFrame,
				profilePara and profilePara.Frame,
				profilePara and profilePara.UIElements and profilePara.UIElements.Main,
				profilePara and profilePara.UIElements and profilePara.UIElements.Container,
			}) do
			if typeof(h) == "Instance" and h:IsA("GuiObject") then
				host = h
				break
			end
		end

		local parent = host and host.Parent
		if not parent then
			return
		end

		local card = new("Frame", {
			Name = "NexvyrPerfil",
			Size = UDim2.new(1, 0, 0, 88),
			BackgroundColor3 = Color3.fromRGB(26, 12, 16),
			BackgroundTransparency = 0.25,
			BorderSizePixel = 0,
			LayoutOrder = -1000,
		}, parent)
		new("UICorner", { CornerRadius = UDim.new(0, 14) }, card)
		new("UIStroke", { Color = Color3.fromHex("#DC143C"), Transparency = 0.65, Thickness = 1 }, card)
		local avatar = new("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 14, 0.5, 0),
			Size = UDim2.fromOffset(64, 64),
			BackgroundColor3 = Color3.fromRGB(20, 20, 24),
			BorderSizePixel = 0,
			Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150",
			ScaleType = Enum.ScaleType.Crop,
		}, card)
		new("UICorner", { CornerRadius = UDim.new(1, 0) }, avatar)
		new("UIStroke", { Color = Color3.fromHex("#DC143C"), Thickness = 2 }, avatar)
		new("TextLabel", {
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 92, 0.5, 1),
			Size = UDim2.new(1, -106, 0, 26),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			Text = player.DisplayName,
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 18,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, card)
		new("TextLabel", {
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.new(0, 92, 0.5, 3),
			Size = UDim2.new(1, -106, 0, 22),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			Text = "@" .. player.Name,
			TextColor3 = Color3.fromRGB(255, 143, 163),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, card)
		host.Visible = false
	end)

	local timePara = Tabs.Inicio:Paragraph({
		Title = "Tiempo usando el script",
		Desc = formatUseTime(Persist.Total()),
		Icon = "solar:clock-circle-bold",
	})
	Tabs.Inicio:Paragraph({ Title = "Ejecutor", Desc = executorName, Icon = "solar:settings-bold", })
	task.spawn(function()
		while true do
			task.wait(1)
			pcall(function()
				timePara:SetDesc(formatUseTime(Persist.Total()))
			end)
		end
	end)

	Tabs.Inicio:Space()
	Tabs.Inicio:Divider()
	Tabs.Inicio:Space()
	local candidates = {
		"rbxthumb://type=Asset&id=" .. IMAGE_ID .. "&w=420&h=420",
		"rbxassetid://" .. IMAGE_ID,
		"https://www.roblox.com/asset/?id=" .. IMAGE_ID,
	}
	local para = Tabs.Inicio:Paragraph({
		Title = "Únete al discord copiando el link",
		Thumbnail = candidates[1],
		ThumbnailSize = THUMB_SIZE,
	})
	local function resolveImage()
		for _, url in ipairs(candidates) do
			local probe = Instance.new("ImageLabel")
			probe.Image = url
			pcall(function()
				ContentProvider:PreloadAsync({ probe })
			end)

			local loaded = false
			pcall(function()
				loaded = probe.IsLoaded
			end)

			probe:Destroy()
			if loaded then
				return url
			end
		end

		local okObj, objs = pcall(function()
			return game:GetObjects("rbxassetid://" .. IMAGE_ID)
		end)

		if okObj and type(objs) == "table" and objs[1] then
			local o = objs[1]
			local tex
			if o:IsA("Decal") or o:IsA("Texture") then
				tex = o.Texture
			elseif o:IsA("ImageLabel") or o:IsA("ImageButton") then
				tex = o.Image
			end

			pcall(function()
				o:Destroy()
			end)

			if tex and tex ~= "" then
				return tex
			end
		end

		return candidates[1]
	end

	local function findHost()
		local list = {
			para and para.ElementFrame,
			para and para.Frame,
			para and para.UIElements and para.UIElements.Main,
			para and para.UIElements and para.UIElements.Container,
		}
		for _, h in ipairs(list) do
			if typeof(h) == "Instance" and h:IsA("GuiObject") then
				return h
			end
		end

		return nil
	end

	task.spawn(function()
		task.wait(0.4)
		local url = resolveImage()
		local host = findHost()
		if host then
			local best
			for _, d in ipairs(host:GetDescendants()) do
				if d:IsA("ImageLabel") then
					if string.find(d.Image, tostring(IMAGE_ID), 1, true) then
						best = d;
						break
					end

					best = best or d
				end
			end

			if best then
				best.Image = url
				best.ScaleType = Enum.ScaleType.Crop
				best.BackgroundTransparency = 1
				best.ImageTransparency = 0
				best.Visible = true
				if not best:FindFirstChildOfClass("UICorner") then
					new("UICorner", { CornerRadius = UDim.new(0, 14) }, best)
				end

				return
			end
		end

		local parent = host and host.Parent
		if parent then
			local box = new("Frame", {
				Name = "NexvyrInicioImagen",
				Size = UDim2.new(1, 0, 0, THUMB_SIZE),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				LayoutOrder = host.LayoutOrder - 1,
			}, parent)
			local img = new("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(THUMB_SIZE, THUMB_SIZE),
				BackgroundColor3 = Color3.fromRGB(20, 20, 24),
				BorderSizePixel = 0,
				Image = url,
				ScaleType = Enum.ScaleType.Crop,
			}, box)
			new("UICorner", { CornerRadius = UDim.new(0, 14) }, img)
			new("UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.8, Thickness = 1.5 }, img)
		end
	end)

	Tabs.Inicio:Button({
		Title = "Copiar link",
		Icon = "solar:copy-bold",
		Variant = "Primary",
		Callback = function()
			local copiar = setclipboard or toclipboard or (syn and syn.write_clipboard)
			if copiar then
				local ok = pcall(copiar, DISCORD_LINK)
				WindUI:Notify({
					Title = ok and "¡Link copiado!" or "Error",
					Content = ok and "Pégalo en tu navegador para unirte al Discord." or "No se pudo copiar el link.",
					Icon = ok and "solar:check-circle-bold" or "solar:close-circle-bold",
					Duration = 4,
				})
			else
				WindUI:Notify({
					Title = "No compatible",
					Content = "Tu executor no permite copiar al portapapeles.",
					Icon = "solar:close-circle-bold",
					Duration = 4,
				})
			end
		end
	})
end


Tabs.Aim:Section({ Title = "Auto Shoot", Icon = "solar:target-bold" })
UIElements.TogAutoShoot = Tabs.Aim:Toggle({
	Title = "Auto Shoot (Normal - Cabeza/Torso)",
	Callback = function(Value)
		autoShootEnabled = Value
		if not Value and not autoShootEnabled and not autoShootAgresivoEnabled and nexvyrSetAimTarget then
			nexvyrSetAimTarget("Auto", nil)
		end

		if nexvyrUpdateTargetFeatures then
			nexvyrUpdateTargetFeatures()
		end
	end
})


UIElements.TogAutoShootAgr = Tabs.Aim:Toggle({
	Title = "Auto Shoot (Agresivo - Hitbox Completa)",
	Callback = function(Value)
		autoShootAgresivoEnabled = Value
		if not Value and not autoShootEnabled and not autoShootAgresivoEnabled and nexvyrSetAimTarget then
			nexvyrSetAimTarget("Auto", nil)
		end

		if nexvyrUpdateTargetFeatures then
			nexvyrUpdateTargetFeatures()
		end
	end
})


UIElements.DropAutoShootPart = Tabs.Aim:Dropdown({
	Title = "Target: Parte del cuerpo",
	Values = { "Cabeza", "Torso", "Cuerpo Completo" },
	Value = "Cabeza",
	Callback = function(Value)
		autoShootTargetPart = Value
	end
})


UIElements.TogEquipGun = Tabs.Aim:Toggle({
	Title = "Equipar pistola",
	Value = false,
	Callback = function(Value)
		equipGunEnabled = Value
		if nexvyrUpdateTargetFeatures then
			nexvyrUpdateTargetFeatures()
		end
	end
})


do
	local nexvyrEquipWorkerRunning = false
	nexvyrStartEquipWorker = function()
		if nexvyrEquipWorkerRunning or not equipGunEnabled then
			return
		end

		nexvyrEquipWorkerRunning = true
		task.spawn(function()
			local gunRayParams = RaycastParams.new()
			gunRayParams.FilterType = Enum.RaycastFilterType.Exclude
			while equipGunEnabled do
				task.wait(0.1)
				if not equipGunEnabled then
					break
				end

				if not IsInMatchStrict() then
					continue
				end

				local char = player.Character
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				if not char or not hum then
					continue
				end

				if hum.Health <= 0 then
					continue
				end

				local hrp = char:FindFirstChild("HumanoidRootPart")
				local head = char:FindFirstChild("Head")
				if not hrp then
					continue
				end

				local originPos = head and head.Position or hrp.Position
				local hayEnemigoVisible = false
				for _, p in ipairs(Players:GetPlayers()) do
					if p ~= player and esEnemigoValido(p) then
						local pChar = p.Character
						if pChar then
							local targetPart = pChar:FindFirstChild("Head") or pChar:FindFirstChild("UpperTorso") or pChar:FindFirstChild("Torso") or pChar:FindFirstChild("HumanoidRootPart")
							if targetPart and targetPart:IsA("BasePart") then
								gunRayParams.FilterDescendantsInstances = { char, pChar }
								local result = workspace:Raycast(originPos, targetPart.Position - originPos, gunRayParams)
								if not result and IsInMatchStrict() then
									hayEnemigoVisible = true
									break
								end
							end
						end
					end
				end

				if not hayEnemigoVisible then
					continue
				end

				local pistola = obtenerPistola()
				if not pistola then
					continue
				end

				char = player.Character
				hum = char and char:FindFirstChildOfClass("Humanoid")
				if not char or not hum then
					continue
				end

				pistola = obtenerPistola()
				if not pistola then
					continue
				end

				if pistola.Parent ~= char then
					pcall(function()
						hum:EquipTool(pistola)
					end)
				end

				task.wait(0.35)
				if not equipGunEnabled then
					break
				end

				char = player.Character
				hum = char and char:FindFirstChildOfClass("Humanoid")
				if char and hum then
					pcall(function()
						hum:UnequipTools()
					end)
				end

				task.wait(1.9)
			end

			nexvyrEquipWorkerRunning = false
		end)
	end
end


Tabs.Aim:Space()
Tabs.Aim:Divider()
Tabs.Aim:Space()
Tabs.Aim:Section({ Title = "Silent Aim + Fov", Icon = "solar:radar-bold" })
UIElements.TogSilentAimManual = Tabs.Aim:Toggle({
	Title = "Silent Aim",
	Callback = function(Value)
		silentAimManualEnabled = Value
		if not Value and not silentAimManualEnabled and not silentAimFovEnabled and nexvyrSetAimTarget then
			nexvyrSetAimTarget("Silent", nil)
		end

		if nexvyrUpdateTargetFeatures then
			nexvyrUpdateTargetFeatures()
		end
	end
})


UIElements.DropSilentAimPart = Tabs.Aim:Dropdown({
	Title = "Target: Parte del cuerpo",
	Values = { "Cabeza", "Torso", "Cuerpo Completo" },
	Value = "Cabeza",
	Callback = function(Value)
		silentAimTargetPart = Value
	end
})


UIElements.TogSilentAimFOV = Tabs.Aim:Toggle({
	Title = "Silent Aim (Con FOV)",
	Callback = function(Value)
		silentAimFovEnabled = Value
		if not Value and not silentAimManualEnabled and not silentAimFovEnabled and nexvyrSetAimTarget then
			nexvyrSetAimTarget("Silent", nil)
		end

		if nexvyrUpdateTargetFeatures then
			nexvyrUpdateTargetFeatures()
		end
	end
})


UIElements.TogShowFOV = Tabs.Aim:Toggle({
	Title = "Mostrar Círculo FOV",
	Callback = function(Value)
		fovVisiblePreference = Value
		if nexvyrStartFOVWorker then
			nexvyrStartFOVWorker()
		end
	end
})


UIElements.SliFOVSize = Tabs.Aim:Slider({
	Title = "Tamaño del FOV",
	Step = 1,
	Value = { Min = 10, Max = 800, Default = 120 },
	Callback = function(v)
		fovRadius = v
	end
})


persistDropdown("DropAutoShootPart", UIElements.DropAutoShootPart, function()
	return autoShootTargetPart
end, function(v)
	autoShootTargetPart = v
end)


persistDropdown("DropSilentAimPart", UIElements.DropSilentAimPart, function()
	return silentAimTargetPart
end, function(v)
	silentAimTargetPart = v
end)


persistSlider("SliFOVSize", UIElements.SliFOVSize, function()
	return fovRadius
end)


persistToggle("TogAutoShoot", UIElements.TogAutoShoot, function()
	return autoShootEnabled
end)


persistToggle("TogAutoShootAgr", UIElements.TogAutoShootAgr, function()
	return autoShootAgresivoEnabled
end)


persistToggle("TogEquipGun", UIElements.TogEquipGun, function()
	return equipGunEnabled
end)


persistToggle("TogSilentAimManual", UIElements.TogSilentAimManual, function()
	return silentAimManualEnabled
end)


persistToggle("TogSilentAimFOV", UIElements.TogSilentAimFOV, function()
	return silentAimFovEnabled
end)


persistToggle("TogShowFOV", UIElements.TogShowFOV, function()
	return fovVisiblePreference
end)


do
	getgenv().NexvyrTargetPart = nil
	local oldNexvyrHook = getgenv().__NexvyrDeferredNamecall
	if oldNexvyrHook then
		oldNexvyrHook.Enabled = false
	end

	local nexvyrMouse = player:GetMouse()
	local nexvyrAimTargets = { Auto = nil, Silent = nil }
	local nexvyrAutoFireUntil = 0
	local priorNexvyrAimCleanup = getgenv().__NexvyrDmvsAimCleanup
	if type(priorNexvyrAimCleanup) == "function" then
		pcall(priorNexvyrAimCleanup)
	end

	getgenv().__NexvyrDmvsAimCleanup = nil
	local nexvyrHooks = { Enabled = false, Metatable = nil, IndexHook = nil, NamecallHook = nil }
	local nexvyrIsMadium = false
	do
		local identify = type(getexecutorname) == "function" and getexecutorname or identifyexecutor
		if type(identify) == "function" then
			local ok, name = pcall(identify)
			nexvyrIsMadium = ok and tostring(name):lower():find("madium", 1, true) ~= nil or false
		end
	end

	local nexvyrDirectCalls = {}
	pcall(function()
		nexvyrDirectCalls.Raycast = workspace.Raycast
	end)

	pcall(function()
		nexvyrDirectCalls.FindPartOnRay = workspace.FindPartOnRay
	end)

	pcall(function()
		nexvyrDirectCalls.FindPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList
	end)

	pcall(function()
		nexvyrDirectCalls.FindPartOnRayWithWhitelist = workspace.FindPartOnRayWithWhitelist
	end)

	local function nexvyrAimActive()
		return autoShootEnabled or autoShootAgresivoEnabled or silentAimManualEnabled or silentAimFovEnabled
	end

	local function nexvyrValidTarget(target)
		if typeof(target) ~= "Instance" or not target:IsA("BasePart") or not target.Parent then
			return false
		end

		local character = target:FindFirstAncestorOfClass("Model")
		local hum = character and character:FindFirstChildOfClass("Humanoid")
		return hum ~= nil and hum.Health > 0
	end

	local function nexvyrSelectedAimTarget()
		local now = os.clock()
		local autoActive = autoShootEnabled or autoShootAgresivoEnabled
		if autoActive and now <= nexvyrAutoFireUntil and nexvyrValidTarget(nexvyrAimTargets.Auto) then
			return nexvyrAimTargets.Auto
		end

		if (silentAimManualEnabled or silentAimFovEnabled) and nexvyrValidTarget(nexvyrAimTargets.Silent) then
			return nexvyrAimTargets.Silent
		end

		if autoActive and nexvyrValidTarget(nexvyrAimTargets.Auto) then
			return nexvyrAimTargets.Auto
		end

		return nil
	end

	nexvyrSetAimTarget = function(source, target)
		if source ~= "Auto" and source ~= "Silent" then
			return
		end

		nexvyrAimTargets[source] = nexvyrValidTarget(target) and target or nil
		getgenv().NexvyrTargetPart = nexvyrSelectedAimTarget()
	end

	local function nexvyrGetAimPoint()
		if not nexvyrHooks.Enabled or not nexvyrAimActive() or estaEnLobby() then
			return nil
		end

		local char = player.Character
		if not char then
			return nil
		end

		local equipped = char:FindFirstChildOfClass("Tool")
		if not (esPistola(equipped) or (autoShootAgresivoEnabled and equipped and not esCuchillo(equipped))) then
			return nil
		end

		local target = nexvyrSelectedAimTarget()
		if not target then
			return nil
		end

		return target.Position, target
	end

	local function nexvyrLikelyWeaponOrigin(origin)
		if typeof(origin) ~= "Vector3" then
			return false
		end

		local currentCamera = workspace.CurrentCamera
		if currentCamera and (origin - currentCamera.CFrame.Position).Magnitude <= 3 then
			return true
		end

		local character = player.Character
		if not character then
			return false
		end

		local tool = character:FindFirstChildOfClass("Tool")
		local handle = tool and tool:FindFirstChild("Handle")
		if handle and handle:IsA("BasePart") and (origin - handle.Position).Magnitude <= 18 then
			return true
		end

		local head = character:FindFirstChild("Head")
		return head and (origin - head.Position).Magnitude <= 8 or false
	end

	local function nexvyrShotOrigin()
		local cam = workspace.CurrentCamera
		local cameraOrigin = cam and cam.CFrame.Position
		local char = player.Character
		local head = char and char:FindFirstChild("Head")
		if cameraOrigin and head and (cameraOrigin - head.Position).Magnitude <= 1.75 then
			return cameraOrigin
		end

		local tool = char and char:FindFirstChildOfClass("Tool")
		local handle = tool and tool:FindFirstChild("Handle")
		if handle and handle:IsA("BasePart") then
			return handle.Position
		end

		if head then
			return head.Position
		end

		return cameraOrigin
	end

	local function nexvyrRestoreHooks()
		nexvyrHooks.Enabled = false
		local mt = nexvyrHooks.Metatable
		if not mt or type(setreadonly) ~= "function" then
			return
		end

		local ok = pcall(setreadonly, mt, false)
		if not ok then
			return
		end

		pcall(function()
			if mt.__index == nexvyrHooks.IndexHook then
				mt.__index = nexvyrHooks.OriginalIndex
			end

			if nexvyrHooks.NamecallHook and mt.__namecall == nexvyrHooks.NamecallHook then
				mt.__namecall = nexvyrHooks.OriginalNamecall
			end
		end)

		pcall(setreadonly, mt, nexvyrHooks.WasReadonly)
		if mt.__index ~= nexvyrHooks.IndexHook and (not nexvyrHooks.NamecallHook or mt.__namecall ~= nexvyrHooks.NamecallHook) then
			nexvyrHooks.Metatable = nil
			nexvyrHooks.IndexHook = nil
			nexvyrHooks.NamecallHook = nil
		end
	end

	getgenv().__NexvyrDmvsAimCleanup = nexvyrRestoreHooks
	local function nexvyrInstallHooks()
		if nexvyrHooks.Metatable then
			local mt = nexvyrHooks.Metatable
			local active = mt.__index == nexvyrHooks.IndexHook
			nexvyrHooks.Enabled = active
			return active
		end

		if type(getrawmetatable) ~= "function" or type(setreadonly) ~= "function" then
			warn("Nexvyr: este executor no permite instalar la redireccion del mouse.")
			return false
		end

		local ok, mt = pcall(getrawmetatable, nexvyrIsMadium and game or nexvyrMouse)
		if not ok or not mt then
			return false
		end

		local originalIndex, originalNamecall = mt.__index, mt.__namecall
		if type(originalIndex) ~= "function" and type(originalIndex) ~= "table" then
			return false
		end

		local wasReadonly = true
		if type(isreadonly) == "function" then
			local success, readonly = pcall(isreadonly, mt)
			if success and type(readonly) == "boolean" then
				wasReadonly = readonly
			end
		end

		local function originalLookup(self, key)
			if type(originalIndex) == "function" then
				return originalIndex(self, key)
			end

			return originalIndex[key]
		end

		local indexHook = function(self, key)
			if nexvyrHooks.Enabled and self == nexvyrMouse and (key == "Hit" or key == "Target" or key == "UnitRay" or (nexvyrIsMadium and key == "TargetSurface")) and (nexvyrIsMadium or type(checkcaller) ~= "function" or not checkcaller()) then
				local ok, point, target = pcall(nexvyrGetAimPoint)
				if ok and point and target then
					if key == "Target" then
						return target
					end

					if key == "TargetSurface" then
						return Enum.NormalId.Front
					end

					if key == "Hit" then
						if nexvyrIsMadium then
							return CFrame.new(point)
						end

						local origin = nexvyrShotOrigin()
						local direction = origin and point - origin
						if direction and direction.Magnitude > 0.001 then
							return CFrame.lookAt(point, point + direction.Unit)
						end

						return CFrame.new(point)
					end

					local originalRay = originalLookup(self, key)
					local origin = typeof(originalRay) == "Ray" and originalRay.Origin or nil
					if not origin then
						local cam = workspace.CurrentCamera
						origin = cam and cam.CFrame.Position or nexvyrShotOrigin()
					end

					local direction = origin and point - origin
					if direction and direction.Magnitude > 0.001 then
						return Ray.new(origin, direction.Unit)
					end
				end
			end

			return originalLookup(self, key)
		end

		local namecallHook
		if not nexvyrIsMadium and type(originalNamecall) == "function" and type(getnamecallmethod) == "function" and type(checkcaller) == "function" then
			namecallHook = function(self, ...)
				if not nexvyrHooks.Enabled or checkcaller() then
					return originalNamecall(self, ...)
				end

				if self == workspace and not nexvyrHooks.ResolvingRay then
					local method = getnamecallmethod()
					local direct = method and nexvyrDirectCalls[method]
					if direct then
						local args = table.pack(...)
						local origin, length
						if method == "Raycast" then
							if typeof(args[1]) == "Vector3" and typeof(args[2]) == "Vector3" then
								origin, length = args[1], args[2].Magnitude
							end
						elseif typeof(args[1]) == "Ray" then
							origin, length = args[1].Origin, args[1].Direction.Magnitude
						end

						if origin and length and length >= 50 and nexvyrLikelyWeaponOrigin(origin) then
							nexvyrHooks.ResolvingRay = true
							local success, point = pcall(nexvyrGetAimPoint)
							nexvyrHooks.ResolvingRay = false
							if success and point then
								local toward = point - origin
								if toward.Magnitude > 0.001 then
									if method == "Raycast" then
										args[2] = toward.Unit * length
									else
										args[1] = Ray.new(origin, toward.Unit * length)
									end
								end
							end
						end

						return direct(self, table.unpack(args, 1, args.n))
					end
				end

				return originalNamecall(self, ...)
			end
		end

		if not pcall(setreadonly, mt, false) then
			return false
		end

		local installed = pcall(function()
			mt.__index = indexHook
			if namecallHook then
				mt.__namecall = namecallHook
			end
		end)

		if not installed then
			pcall(function()
				if mt.__index == indexHook then
					mt.__index = originalIndex
				end

				if namecallHook and mt.__namecall == namecallHook then
					mt.__namecall = originalNamecall
				end
			end)

			pcall(setreadonly, mt, wasReadonly)
			return false
		end

		pcall(setreadonly, mt, wasReadonly)
		nexvyrHooks.Metatable = mt
		nexvyrHooks.OriginalIndex = originalIndex
		nexvyrHooks.OriginalNamecall = originalNamecall
		nexvyrHooks.IndexHook = indexHook
		nexvyrHooks.NamecallHook = namecallHook
		nexvyrHooks.WasReadonly = wasReadonly
		nexvyrHooks.Enabled = true
		return true
	end

	local function nexvyrUpdateHook()
		if nexvyrAimActive() then
			nexvyrInstallHooks()
		else
			nexvyrAimTargets.Auto = nil
			nexvyrAimTargets.Silent = nil
			nexvyrAutoFireUntil = 0
			getgenv().NexvyrTargetPart = nil
			nexvyrRestoreHooks()
		end
	end

	local nexvyrUpdateTargetWorkers
	nexvyrUpdateTargetFeatures = function()
		nexvyrRefreshTargetMonitor()
		nexvyrUpdateHook()
		if nexvyrUpdateTargetWorkers then
			nexvyrUpdateTargetWorkers()
		end
	end

	local nexvyrAutoShootWorkerRunning = false
	nexvyrStartAutoShootWorker = function()
		if nexvyrAutoShootWorkerRunning or not (autoShootEnabled or autoShootAgresivoEnabled) then
			return
		end

		nexvyrAutoShootWorkerRunning = true
		task.spawn(function()
			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			while autoShootEnabled or autoShootAgresivoEnabled do
				task.wait(0.1)
				if not (autoShootEnabled or autoShootAgresivoEnabled) then
					break
				end

				if not nexvyrHooks.Enabled then
					continue
				end

				if not estaEnLobby() then
					local char = player.Character
					if not char or not char:FindFirstChild("HumanoidRootPart") then
						continue
					end

					local arma = char:FindFirstChildOfClass("Tool")
					if not arma or not arma:FindFirstChild("Handle") then
						nexvyrSetAimTarget("Auto", nil)
						continue
					end

					if autoShootAgresivoEnabled then
						if esCuchillo(arma) then
							nexvyrSetAimTarget("Auto", nil)
							continue
						end
					elseif not esPistola(arma) then
						nexvyrSetAimTarget("Auto", nil)
						continue
					end

					local closestTargetPart = nil
					local shortestDistance = math.huge
					local myPos = char.HumanoidRootPart.Position
					local head = char:FindFirstChild("Head")
					local headPos = head and head.Position or myPos
					if autoShootAgresivoEnabled then
						for _, p in pairs(Players:GetPlayers()) do
							if p ~= player and isEnemy(p) and p.Character then
								local enemyHum = p.Character:FindFirstChild("Humanoid")
								if enemyHum and enemyHum.Health > 0 then
									params.FilterDescendantsInstances = { char, p.Character }
									local function ProcesarParte(part)
										local dist = (part.Position - myPos).Magnitude
										if dist < shortestDistance then
											local size = part.Size
											local offsets = {
												Vector3.new(0, 0, 0),
												Vector3.new(0, size.Y / 2.1, 0),
												Vector3.new(0, -size.Y / 2.1, 0)
											}

											local isVisible = false
											for _, offset in ipairs(offsets) do
												if not workspace:Raycast(headPos, (part.CFrame * offset) - headPos, params) then
													isVisible = true
													break
												end
											end

											if isVisible then
												shortestDistance = dist
												closestTargetPart = part
											end
										end
									end

									for _, part in ipairs(p.Character:GetChildren()) do
										if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
											ProcesarParte(part)
										end
									end
								end
							end
						end
					else
						local playersToCheck = {}
						for _, other in ipairs(Players:GetPlayers()) do
							if other ~= player and isEnemy(other) and other.Character then
								local enemyCharacter = other.Character
								local humanoid = enemyCharacter:FindFirstChildOfClass("Humanoid")
								if humanoid and humanoid.Health > 0 then
									local root = enemyCharacter:FindFirstChild("HumanoidRootPart")
									playersToCheck[#playersToCheck + 1] = {
										Character = enemyCharacter,
										Distance = root and (root.Position - myPos).Magnitude or math.huge
									}
								end
							end
						end

						table.sort(playersToCheck, function(a, b)
							return a.Distance < b.Distance
						end)

						local raycastsRemaining = 192
						local function checkPart(part)
							if not part or not part:IsA("BasePart") then
								return
							end

							local dist = (part.Position - myPos).Magnitude
							if dist >= shortestDistance then
								return
							end

							local halfHeight = part.Size.Y / 2.1
							local cframe = part.CFrame
							local function visible(point)
								if raycastsRemaining <= 0 then
									return false
								end

								raycastsRemaining -= 1
								return not workspace:Raycast(headPos, point - headPos, params)
							end

							if visible(part.Position) or visible(cframe * Vector3.new(0, halfHeight, 0)) or visible(cframe * Vector3.new(0, -halfHeight, 0)) then
								shortestDistance = dist
								closestTargetPart = part
							end
						end

						for _, candidate in ipairs(playersToCheck) do
							if raycastsRemaining <= 0 then
								break
							end

							local enemyCharacter = candidate.Character
							if enemyCharacter.Parent then
								params.FilterDescendantsInstances = { char, enemyCharacter }
								if autoShootTargetPart == "Cuerpo Completo" then
									for _, part in ipairs(enemyCharacter:GetChildren()) do
										if raycastsRemaining <= 0 then
											break
										end

										if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
											checkPart(part)
										end
									end
								elseif autoShootTargetPart == "Cabeza" then
									checkPart(enemyCharacter:FindFirstChild("Head"))
								elseif autoShootTargetPart == "Torso" then
									for _, partName in ipairs({ "UpperTorso", "Torso", "HumanoidRootPart" }) do
										if raycastsRemaining <= 0 then
											break
										end

										checkPart(enemyCharacter:FindFirstChild(partName))
									end
								end
							end
						end
					end

					if closestTargetPart then
						nexvyrAutoFireUntil = os.clock() + 0.35
						nexvyrSetAimTarget("Auto", closestTargetPart)
						pcall(function()
							arma:Activate()
							task.delay(0.05, function()
								if arma.Parent == char then
									arma:Deactivate()
								end
							end)
						end)

						task.wait(0.2)
					else
						nexvyrSetAimTarget("Auto", nil)
					end
				end
			end

			nexvyrSetAimTarget("Auto", nil)
			nexvyrAutoShootWorkerRunning = false
		end)
	end

	local nexvyrSilentWorkerRunning = false
	nexvyrStartSilentAimWorker = function()
		if nexvyrSilentWorkerRunning or not (silentAimManualEnabled or silentAimFovEnabled) then
			return
		end

		nexvyrSilentWorkerRunning = true
		task.spawn(function()
			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			while silentAimManualEnabled or silentAimFovEnabled do
				task.wait(0.1)
				if not (silentAimManualEnabled or silentAimFovEnabled) then
					break
				end

				if not estaEnLobby() then
					local char = player.Character
					if not char or not char:FindFirstChild("HumanoidRootPart") then
						continue
					end

					local closestTargetPart = nil
					local shortestDistToCenter = math.huge
					local shortestDistanceFisica = math.huge
					local myPos = char.HumanoidRootPart.Position
					local headPos = char:FindFirstChild("Head") and char.Head.Position or myPos
					for _, p in pairs(Players:GetPlayers()) do
						if p ~= player and isEnemy(p) and p.Character then
							local enemyHum = p.Character:FindFirstChild("Humanoid")
							if enemyHum and enemyHum.Health > 0 then
								local partesAEscanear = {}
								if silentAimTargetPart == "Cabeza" then
									local head = p.Character:FindFirstChild("Head")
									if head then
										table.insert(partesAEscanear, head)
									end
								elseif silentAimTargetPart == "Torso" then
									local partesClave = { "UpperTorso", "Torso", "HumanoidRootPart" }
									for _, partName in ipairs(partesClave) do
										local part = p.Character:FindFirstChild(partName)
										if part and part:IsA("BasePart") then
											table.insert(partesAEscanear, part)
										end
									end
								elseif silentAimTargetPart == "Cuerpo Completo" then
									for _, part in ipairs(p.Character:GetChildren()) do
										if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
											table.insert(partesAEscanear, part)
										end
									end
								end

								params.FilterDescendantsInstances = { char, p.Character }
								for _, part in ipairs(partesAEscanear) do
									local distFisica = (part.Position - myPos).Magnitude
									local currentCamera = workspace.CurrentCamera
									if not currentCamera then
										continue
									end

									local pos2D, onScreen = currentCamera:WorldToViewportPoint(part.Position)
									local distToCenter = (Vector2.new(pos2D.X, pos2D.Y) - currentCamera.ViewportSize / 2).Magnitude
									local pasaFiltro = false
									if silentAimFovEnabled then
										if onScreen and distToCenter <= fovRadius and distToCenter < shortestDistToCenter then
											pasaFiltro = true
										end
									elseif silentAimManualEnabled then
										if distFisica < shortestDistanceFisica then
											pasaFiltro = true
										end
									end

									if pasaFiltro then
										local raycastResult = workspace:Raycast(headPos, part.Position - headPos, params)
										if not raycastResult then
											if silentAimFovEnabled then
												shortestDistToCenter = distToCenter;
												closestTargetPart = part
											else
												shortestDistanceFisica = distFisica;
												closestTargetPart = part
											end
										end
									end
								end
							end
						end
					end

					if closestTargetPart then
						nexvyrSetAimTarget("Silent", closestTargetPart)
					else
						nexvyrSetAimTarget("Silent", nil)
					end
				end
			end

			nexvyrSetAimTarget("Silent", nil)
			nexvyrSilentWorkerRunning = false
		end)
	end

	nexvyrUpdateTargetWorkers = function()
		if autoShootEnabled or autoShootAgresivoEnabled then
			nexvyrStartAutoShootWorker()
		end

		if silentAimManualEnabled or silentAimFovEnabled then
			nexvyrStartSilentAimWorker()
		end

		if equipGunEnabled then
			nexvyrStartEquipWorker()
		end
	end
end


Tabs.KillAll:Section({ Title = "Kill All", Icon = "solar:danger-triangle-bold" })
UIElements.TogKillAll = Tabs.KillAll:Toggle({
	Title = "Kill All",
	Value = false,
	Callback = function(Value)
		KillAllEnabled = Value
		if nexvyrRefreshTargetMonitor then
			nexvyrRefreshTargetMonitor()
		end

		if Value then
			KillAllInstance:Start()
		else
			KillAllInstance:Stop()
		end
	end
})


Tabs.KillAll:Space()
Tabs.KillAll:Divider()
Tabs.KillAll:Space()
Tabs.KillAll:Section({ Title = "Hitbox Expander", Icon = "solar:box-bold" })
UIElements.TogHitbox = Tabs.KillAll:Toggle({
	Title = "Activar Hitbox",
	Value = false,
	Callback = function(Value)
		hitboxEnabled = Value
		if nexvyrRefreshTargetMonitor then
			nexvyrRefreshTargetMonitor()
		end

		if Value then
			nexvyrStartHitboxWorker()
		else
			limpiarHitboxes()
		end
	end
})


UIElements.TogHitboxInvisible = Tabs.KillAll:Toggle({
	Title = "Hitbox Invisible",
	Value = false,
	Callback = function(Value)
		hitboxInvisible = Value
	end
})


UIElements.SliHitboxSize = Tabs.KillAll:Slider({
	Title = "Tamaño de la Hitbox",
	Step = 0.5,
	Value = { Min = 1.0, Max = 28.0, Default = 3.5 },
	Callback = function(v)
		hitboxSize = v
	end
})


UIElements.ColHitbox = Tabs.KillAll:Colorpicker({
	Title = "Color de la Hitbox",
	Default = Color3.fromRGB(255, 0, 0),
	Callback = function(c)
		hitboxColor = c
	end
})


persistSlider("SliHitboxSize", UIElements.SliHitboxSize, function()
	return hitboxSize
end)


persistColor("ColHitbox", UIElements.ColHitbox, function()
	return hitboxColor
end, function(c)
	hitboxColor = c
end)


persistToggle("TogHitboxInvisible", UIElements.TogHitboxInvisible, function()
	return hitboxInvisible
end)


persistToggle("TogHitbox", UIElements.TogHitbox, function()
	return hitboxEnabled
end)


persistToggle("TogKillAll", UIElements.TogKillAll, function()
	return KillAllEnabled
end)


Tabs.Invisible:Section({ Title = "Invisible", Icon = "solar:ghost-bold" })


local function AplicarInvisibilidadTransparencia(state)
	if player.Character then
		for _, v in pairs(player.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				if state and v.Transparency == 0 then
					v:SetAttribute("NexvyrOrigTrans", 0)
					v.Transparency = 0.5
				elseif not state and v:GetAttribute("NexvyrOrigTrans") ~= nil then
					v.Transparency = v:GetAttribute("NexvyrOrigTrans")
					v:SetAttribute("NexvyrOrigTrans", nil)
				end
			end
		end
	end
end


UIElements.TogInvisible = Tabs.Invisible:Toggle({
	Title = "Invisible",
	Value = false,
	Callback = function(Value)
		InvisibilityActive = Value
		AplicarInvisibilidadTransparencia(Value)
		if nexvyrSetInvisibleWorker then
			nexvyrSetInvisibleWorker(Value)
		end
	end
})


persistToggle("TogInvisible", UIElements.TogInvisible, function()
	return InvisibilityActive
end)


do
	local nexvyrInvisibleConnection
	nexvyrSetInvisibleWorker = function(state)
		if nexvyrInvisibleConnection then
			nexvyrInvisibleConnection:Disconnect()
			nexvyrInvisibleConnection = nil
		end

		if not state then
			return
		end

		nexvyrInvisibleConnection = RunService.Heartbeat:Connect(function()
			if not InvisibilityActive then
				return
			end

			local Char = player.Character
			if Char then
				local Root = Char:FindFirstChild("HumanoidRootPart")
				local Hum = Char:FindFirstChildOfClass("Humanoid")
				if Root and Hum and Hum.Health > 0 then
					if Root.Position.Y > 200 then
						return
					end

					local oldCF = Root.CFrame
					local oldCamOffset = Hum.CameraOffset
					local invisCF = oldCF * CFrame.new(0, -40, 0)
					Root.CFrame = invisCF
					Hum.CameraOffset = invisCF:ToObjectSpace(CFrame.new(oldCF.Position)).Position
					RunService.RenderStepped:Wait()
					if Root.Parent and Hum.Parent then
						Root.CFrame = oldCF
						Hum.CameraOffset = oldCamOffset
					end
				end
			end
		end)
	end
end


player.CharacterAdded:Connect(function(character)
	if InvisibilityActive then
		task.wait(0.5)
		AplicarInvisibilidadTransparencia(true)
	end
end)


Tabs.Tramposo:Section({ Title = "Tramposo", Icon = "solar:bolt-bold" })
local SPEED = 28.7
local JUMP_POWER = 45


do
	local remote = ReplicatedStorage:WaitForChild("MovementState", 3)
	local function notify(kind, on)
		if remote then
			remote:FireServer(kind, on)
		end
	end

	local SMOOTH = 14
	local FLY_SPEED = 50
	local flyConn
	local flyVel = Vector3.zero
	local flyControls
	local speedConn, jumpConn, requestConn
	local smoothDir = Vector3.zero
	local jumping = false
	local vy = 0
	local function getChar()
		local c = player.Character
		if not c then
			return
		end

		return c:FindFirstChildOfClass("Humanoid"), c:FindFirstChild("HumanoidRootPart")
	end

	local function SetSpeed(state)
		if speedConn then
			speedConn:Disconnect()
			speedConn = nil
		end

		smoothDir = Vector3.zero
		if not state then
			return
		end

		speedConn = RunService.Stepped:Connect(function(_, dt)
			local hum, root = getChar()
			if not hum or not root or hum.Health <= 0 then
				return
			end

			local alpha = 1 - math.exp(-SMOOTH * dt)
			smoothDir = smoothDir:Lerp(hum.MoveDirection, alpha)
			if smoothDir.Magnitude > 0.01 then
				local extra = math.max(SPEED - hum.WalkSpeed, 0)
				root.CFrame = root.CFrame + smoothDir * extra * dt
			end
		end)
	end

	local function SetInfJump(state)
		if jumpConn then
			jumpConn:Disconnect()
			jumpConn = nil
		end

		if requestConn then
			requestConn:Disconnect()
			requestConn = nil
		end

		jumping = false
		vy = 0
		if not state then
			return
		end

		requestConn = UserInputService.JumpRequest:Connect(function()
			jumping = true
		end)

		jumpConn = RunService.Stepped:Connect(function(_, dt)
			local hum, root = getChar()
			if not hum or not root or hum.Health <= 0 then
				return
			end

			local held = UserInputService:IsKeyDown(Enum.KeyCode.Space) or hum.Jump
			if jumping and not held then
				jumping = false
			end

			local target = jumping and JUMP_POWER or 0
			vy = vy + (target - vy) * (1 - math.exp(-SMOOTH * dt))
			if vy > 0.5 then
				root.CFrame = root.CFrame + Vector3.new(0, vy * dt, 0)
				local v = root.AssemblyLinearVelocity
				if v.Y < 0 then
					root.AssemblyLinearVelocity = Vector3.new(v.X, 0, v.Z)
				end
			end
		end)
	end

	local function flyMoveVector()
		if flyControls == nil then
			flyControls = false
			pcall(function()
				local ps = player:FindFirstChild("PlayerScripts") or player:WaitForChild("PlayerScripts", 2)
				local pm = ps and (ps:FindFirstChild("PlayerModule") or ps:WaitForChild("PlayerModule", 2))
				if pm then
					flyControls = require(pm):GetControls()
				end
			end)
		end

		if flyControls then
			local ok, v = pcall(function()
				return flyControls:GetMoveVector()
			end)

			if ok and typeof(v) == "Vector3" then
				return v
			end
		end

		local function k(code)
			return UserInputService:IsKeyDown(code) and 1 or 0
		end

		return Vector3.new(k(Enum.KeyCode.D) - k(Enum.KeyCode.A), 0, k(Enum.KeyCode.S) - k(Enum.KeyCode.W))
	end

	local FLY_PITCH_DEAD = math.rad(15)
	local FLY_LEAN = 35
	local FLY_ROLL = 25
	local flyPos, flyRoot
	local flyAutoRotate
	local function SetFly(state)
		if flyConn then
			flyConn:Disconnect()
			flyConn = nil
		end

		flyVel = Vector3.zero
		flyPos, flyRoot = nil, nil
		local hum0 = getChar()
		if hum0 then
			pcall(function()
				hum0.PlatformStand = false
				if flyAutoRotate ~= nil then
					hum0.AutoRotate = flyAutoRotate
				end
			end)
		end

		flyAutoRotate = nil
		if not state then
			return
		end

		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		flyConn = RunService.Heartbeat:Connect(function(dt)
			local hum, root = getChar()
			local cam = workspace.CurrentCamera
			if not hum or not root or not cam or hum.Health <= 0 then
				return
			end

			if flyAutoRotate == nil then
				flyAutoRotate = hum.AutoRotate
			end

			hum.PlatformStand = false
			hum.AutoRotate = false
			hum:ChangeState(Enum.HumanoidStateType.Freefall)
			if root ~= flyRoot or not flyPos or (root.Position - flyPos).Magnitude > 10 then
				flyRoot = root
				flyPos = root.Position
				flyVel = Vector3.zero
			end

			local mv = flyMoveVector()
			local cf = cam.CFrame
			local look = cf.LookVector
			local pitch = math.asin(math.clamp(look.Y, -1, 1))
			local adj = 0
			if pitch > FLY_PITCH_DEAD then
				adj = pitch - FLY_PITCH_DEAD
			elseif pitch < -FLY_PITCH_DEAD then
				adj = pitch + FLY_PITCH_DEAD
			end

			local span = math.pi / 2 - FLY_PITCH_DEAD
			adj = (span > 0) and (adj * (math.pi / 2) / span) or pitch
			local flat = Vector3.new(look.X, 0, look.Z)
			if flat.Magnitude < 0.01 then
				flat = Vector3.new(cf.UpVector.X, 0, cf.UpVector.Z)
			end

			flat = flat.Unit
			local forward = flat * math.cos(adj) + Vector3.new(0, math.sin(adj), 0)
			local right = Vector3.new(cf.RightVector.X, 0, cf.RightVector.Z)
			if right.Magnitude > 0.01 then
				right = right.Unit
			end

			local dir = right * mv.X + forward * -mv.Z
			local up = (UserInputService:IsKeyDown(Enum.KeyCode.Space) or hum.Jump) and 1 or 0
			local down = (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.Q)) and 1 or 0
			dir = dir + Vector3.new(0, up - down, 0)
			local target = Vector3.zero
			if dir.Magnitude > 0.01 then
				target = dir.Unit * FLY_SPEED
			end

			flyVel = flyVel:Lerp(target, 1 - math.exp(-SMOOTH * dt))
			local newPos = flyPos + flyVel * dt
			if flyVel.Y < 0 then
				rayParams.FilterDescendantsInstances = { root.Parent }
				local feet = hum.HipHeight + root.Size.Y / 2
				local hit = workspace:Raycast(newPos, Vector3.new(0, - (feet + 0.5), 0), rayParams)
				if hit then
					newPos = Vector3.new(newPos.X, math.max(newPos.Y, hit.Position.Y + feet), newPos.Z)
					flyVel = Vector3.new(flyVel.X, 0, flyVel.Z)
				end
			end

			flyPos = newPos
			local yawRot = CFrame.lookAt(Vector3.zero, flat).Rotation
			local lv = yawRot:VectorToObjectSpace(flyVel)
			local ref = math.max(FLY_SPEED, 1)
			local fwdAmt = math.clamp(-lv.Z / ref, -1, 1)
			local sideAmt = math.clamp(lv.X / ref, -1, 1)
			local camTilt = math.clamp(pitch, -math.rad(80), math.rad(80))
			local bodyPitch = math.clamp(camTilt - math.rad(FLY_LEAN * fwdAmt), -math.rad(110), math.rad(70))
			local roll = math.rad(-FLY_ROLL * sideAmt)
			local goalRot = yawRot * CFrame.Angles(bodyPitch, 0, roll)
			local rot = root.CFrame.Rotation:Lerp(goalRot, 1 - math.exp(-14 * dt))
			root.CFrame = CFrame.new(flyPos) * rot
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end)
	end

	UIElements.TogSpeed = Tabs.Tramposo:Toggle({
		Title = "Speed",
		Value = false,
		Callback = function(state)
			SetSpeed(state)
			notify("Speed", state)
		end
	})

	UIElements.SliSpeed = Tabs.Tramposo:Slider({
		Title = "Ajuste Speed",
		Step = 1,
		Value = { Min = 1, Max = 100, Default = 29 },
		Callback = function(v)
			SPEED = v
		end
	})

	UIElements.TogInfJump = Tabs.Tramposo:Toggle({
		Title = "Salto Inf",
		Value = false,
		Callback = function(state)
			SetInfJump(state)
			notify("Jump", state)
		end
	})

	UIElements.SliJumpPower = Tabs.Tramposo:Slider({
		Title = "Ajuste Salto",
		Step = 1,
		Value = { Min = 1, Max = 100, Default = 45 },
		Callback = function(v)
			JUMP_POWER = v
		end
	})

	UIElements.TogFly = Tabs.Tramposo:Toggle({
		Title = "Volar",
		Value = false,
		Callback = function(state)
			SetFly(state)
		end
	})

	UIElements.SliFly = Tabs.Tramposo:Slider({
		Title = "Velocidad de volar",
		Step = 1,
		Value = { Min = 1, Max = 150, Default = 50 },
		Callback = function(v)
			FLY_SPEED = v
		end
	})

	persistSlider("SliSpeed", UIElements.SliSpeed, function()
		return SPEED
	end)

	persistSlider("SliJumpPower", UIElements.SliJumpPower, function()
		return JUMP_POWER
	end)

	persistSlider("SliFly", UIElements.SliFly, function()
		return FLY_SPEED
	end)

	persistToggle("TogSpeed", UIElements.TogSpeed, function()
		return speedConn ~= nil
	end)

	persistToggle("TogInfJump", UIElements.TogInfJump, function()
		return jumpConn ~= nil
	end)

	persistToggle("TogFly", UIElements.TogFly, function()
		return flyConn ~= nil
	end)
end


Tabs.RachaFarm:Section({ Title = "Auto Teleport Main/Alt", Icon = "solar:map-arrow-square-bold" })
local autoTPMainToggle, autoTPAltToggle
autoTPMainToggle = Tabs.RachaFarm:Toggle({
	Title = "Auto Teleport (Main)",
	Value = false,
	Callback = function(value)
		if value then
			AutoTeleportMainAltInstance.ActiveRole = "Main"
			if autoTPAltToggle then
				pcall(function()
					autoTPAltToggle:Set(false)
				end)
			end

			AutoTeleportMainAltInstance:Stop()
			AutoTeleportMainAltInstance:Start()
		else
			if AutoTeleportMainAltInstance.ActiveRole == "Main" then
				AutoTeleportMainAltInstance.ActiveRole = nil
				AutoTeleportMainAltInstance:Stop()
			end
		end
	end
})


autoTPAltToggle = Tabs.RachaFarm:Toggle({
	Title = "Auto Teleport (Alt)",
	Value = false,
	Callback = function(value)
		if value then
			AutoTeleportMainAltInstance.ActiveRole = "Alt"
			if autoTPMainToggle then
				pcall(function()
					autoTPMainToggle:Set(false)
				end)
			end

			AutoTeleportMainAltInstance:Stop()
			AutoTeleportMainAltInstance:Start()
		else
			if AutoTeleportMainAltInstance.ActiveRole == "Alt" then
				AutoTeleportMainAltInstance.ActiveRole = nil
				AutoTeleportMainAltInstance:Stop()
			end
		end
	end
})


UIElements.DropDuelType = Tabs.RachaFarm:Dropdown({
	Title = "Tipo de Duelo",
	Values = { "1v1", "2v2", "3v3", "4v4" },
	Value = "1v1",
	Callback = function(value)
		if PadZoneConfig["Right Platforms"][value] then
			AutoTeleportMainAltInstance.DuelType = value
		else
			AutoTeleportMainAltInstance.DuelType = "1v1"
		end

		AutoTeleportMainAltInstance:Kick()
	end
})


UIElements.DropPlatformRow = Tabs.RachaFarm:Dropdown({
	Title = "Fila de Plataformas",
	Values = { "Right Platforms", "Left Platforms" },
	Value = "Right Platforms",
	Callback = function(value)
		if PadZoneConfig[value] then
			AutoTeleportMainAltInstance.PlatformRow = value
		else
			AutoTeleportMainAltInstance.PlatformRow = "Right Platforms"
		end

		AutoTeleportMainAltInstance:Kick()
	end
})


persistDropdown("DropDuelType", UIElements.DropDuelType, function()
	return AutoTeleportMainAltInstance.DuelType
end, function(v)
	if PadZoneConfig["Right Platforms"][v] then
		AutoTeleportMainAltInstance.DuelType = v
	end
end)


persistDropdown("DropPlatformRow", UIElements.DropPlatformRow, function()
	return AutoTeleportMainAltInstance.PlatformRow
end, function(v)
	if PadZoneConfig[v] then
		AutoTeleportMainAltInstance.PlatformRow = v
	end
end)


persistToggle("TogAutoTPMain", autoTPMainToggle, function()
	return AutoTeleportMainAltInstance.ActiveRole == "Main"
end)


persistToggle("TogAutoTPAlt", autoTPAltToggle, function()
	return AutoTeleportMainAltInstance.ActiveRole == "Alt"
end)


do
	Tabs.Vis:Section({ Title = "Configuración de ESP", Icon = "solar:eye-bold" })
	local activeESPs = {}
	local MAX_ESP_DISTANCE = 1500
	local function espAnyActive()
		return espEnabled and (espSettings.Glow or espSettings.Box or espSettings.Name)
	end

	local function cleanESP(targetPlayer)
		local current = activeESPs[targetPlayer]
		if not current then
			return
		end

		if current.Highlight then
			current.Highlight:Destroy()
		end

		if current.Box then
			current.Box:Destroy()
		end

		if current.NameGui then
			current.NameGui:Destroy()
		end

		activeESPs[targetPlayer] = nil
	end

	local function cleanAllESPs()
		for other in pairs(activeESPs) do
			cleanESP(other)
		end
	end

	local function refreshESP()
		if nexvyrRefreshTargetMonitor then
			nexvyrRefreshTargetMonitor()
		end

		if espAnyActive() then
			nexvyrStartESPWorker()
		else
			cleanAllESPs()
		end
	end

	UIElements.TogEsp = Tabs.Vis:Toggle({
		Title = "ESP Jugadores",
		Callback = function(s)
			espEnabled = s
			refreshESP()
		end
	})

	UIElements.ColEsp = Tabs.Vis:Colorpicker({
		Title = "Color del ESP",
		Default = Color3.fromRGB(255, 182, 193),
		Callback = function(c)
			espColor = c
		end
	})

	UIElements.TogEspBox = Tabs.Vis:Toggle({
		Title = "Espiar con caja",
		Value = false,
		Callback = function(s)
			espSettings.Box = s
			refreshESP()
		end
	})

	UIElements.TogEspName = Tabs.Vis:Toggle({
		Title = "Espiar de nombre",
		Value = false,
		Callback = function(s)
			espSettings.Name = s
			refreshESP()
		end
	})

	Tabs.Vis:Space()
	Tabs.Vis:Divider()
	Tabs.Vis:Space()
	Tabs.Vis:Section({ Title = "Filtros de ESP", Icon = "solar:filter-bold" })
	UIElements.TogEspGl = Tabs.Vis:Toggle({
		Title = "Mostrar Resplandor",
		Value = true,
		Callback = function(s)
			espSettings.Glow = s
			refreshESP()
		end
	})

	local nexvyrESPWorkerRunning = false
	nexvyrStartESPWorker = function()
		if nexvyrESPWorkerRunning or not espAnyActive() then
			return
		end

		nexvyrESPWorkerRunning = true
		task.spawn(function()
			local removingConnection = Players.PlayerRemoving:Connect(cleanESP)
			while espAnyActive() do
				task.wait(0.2)
				if not espAnyActive() then
					break
				end

				if IsInMatchStrict() then
					local own = player.Character
					local head = own and own:FindFirstChild("Head")
					local pos = head and head.Position
					for _, other in ipairs(Players:GetPlayers()) do
						if other ~= player then
							local character = other.Character
							local enemyHead = character and character:FindFirstChild("Head")
							if enemyHead and isEnemy(other) and (not pos or (enemyHead.Position - pos).Magnitude <= MAX_ESP_DISTANCE) then
								local entry = activeESPs[other]
								if entry and entry.Char ~= character then
									cleanESP(other)
									entry = nil
								end

								if not entry then
									entry = { Char = character }
									activeESPs[other] = entry
								end

								if espSettings.Glow then
									if entry.Highlight and entry.Highlight.Parent ~= espFolder then
										entry.Highlight:Destroy()
										entry.Highlight = nil
									end

									if not entry.Highlight then
										local glow = Instance.new("Highlight")
										glow.Name = other.Name .. "_Glow"
										glow.FillTransparency = 1
										glow.OutlineTransparency = 0
										glow.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
										glow.Adornee = character
										glow.Parent = espFolder
										entry.Highlight = glow
									end

									local current = entry.Highlight
									if current.Enabled ~= true then
										current.Enabled = true
									end

									if current.OutlineColor ~= espColor then
										current.OutlineColor = espColor
									end
								elseif entry.Highlight then
									entry.Highlight:Destroy()
									entry.Highlight = nil
								end

								if espSettings.Box then
									if entry.Box and (entry.Box.Parent ~= espFolder or entry.Box.Adornee ~= character) then
										entry.Box:Destroy()
										entry.Box = nil
									end

									if not entry.Box then
										local box = Instance.new("SelectionBox")
										box.Name = other.Name .. "_Box"
										box.Adornee = character
										box.LineThickness = 0.05
										box.SurfaceTransparency = 1
										box.Color3 = espColor
										box.SurfaceColor3 = espColor
										box.Parent = espFolder
										entry.Box = box
									end

									if entry.Box.Color3 ~= espColor then
										entry.Box.Color3 = espColor
										entry.Box.SurfaceColor3 = espColor
									end
								elseif entry.Box then
									entry.Box:Destroy()
									entry.Box = nil
								end

								if espSettings.Name then
									if entry.NameGui and (entry.NameGui.Parent ~= espFolder or entry.NameGui.Adornee ~= enemyHead) then
										entry.NameGui:Destroy()
										entry.NameGui = nil
										entry.NameLabel = nil
									end

									if not entry.NameGui then
										local billboard = Instance.new("BillboardGui")
										billboard.Name = other.Name .. "_Name"
										billboard.Adornee = enemyHead
										billboard.AlwaysOnTop = true
										billboard.Size = UDim2.fromOffset(200, 24)
										billboard.StudsOffset = Vector3.new(0, 2.6, 0)
										billboard.MaxDistance = MAX_ESP_DISTANCE
										billboard.Parent = espFolder
										local label = Instance.new("TextLabel")
										label.Name = "Label"
										label.BackgroundTransparency = 1
										label.Size = UDim2.fromScale(1, 1)
										label.Font = Enum.Font.GothamBold
										label.TextSize = 14
										label.TextColor3 = espColor
										label.TextStrokeTransparency = 0.3
										label.TextStrokeColor3 = Color3.new(0, 0, 0)
										label.Text = other.DisplayName
										label.Parent = billboard
										entry.NameGui = billboard
										entry.NameLabel = label
									end

									if entry.NameLabel then
										if entry.NameLabel.Text ~= other.DisplayName then
											entry.NameLabel.Text = other.DisplayName
										end

										if entry.NameLabel.TextColor3 ~= espColor then
											entry.NameLabel.TextColor3 = espColor
										end
									end
								elseif entry.NameGui then
									entry.NameGui:Destroy()
									entry.NameGui = nil
									entry.NameLabel = nil
								end
							else
								cleanESP(other)
							end
						end
					end
				else
					cleanAllESPs()
				end
			end

			removingConnection:Disconnect()
			cleanAllESPs()
			nexvyrESPWorkerRunning = false
		end)
	end

	persistColor("ColEsp", UIElements.ColEsp, function()
		return espColor
	end, function(c)
		espColor = c
	end)

	persistToggle("TogEspGl", UIElements.TogEspGl, function()
		return espSettings.Glow
	end)

	persistToggle("TogEspBox", UIElements.TogEspBox, function()
		return espSettings.Box
	end)

	persistToggle("TogEspName", UIElements.TogEspName, function()
		return espSettings.Name
	end)

	persistToggle("TogEsp", UIElements.TogEsp, function()
		return espEnabled
	end)

	local FOVCircle
	local nexvyrFOVConnection
	nexvyrStartFOVWorker = function()
		if not fovVisiblePreference then
			if nexvyrFOVConnection then
				nexvyrFOVConnection:Disconnect();
				nexvyrFOVConnection = nil
			end

			if FOVCircle then
				FOVCircle.Visible = false
			end

			return
		end

		if not FOVCircle and Drawing then
			FOVCircle = Drawing.new("Circle")
			FOVCircle.Filled = false
			FOVCircle.Thickness = 1
			FOVCircle.Visible = false
		end

		if not FOVCircle or nexvyrFOVConnection then
			return
		end

		nexvyrFOVConnection = RunService.RenderStepped:Connect(function()
			if not fovVisiblePreference then
				return
			end

			local currentCamera = workspace.CurrentCamera
			if not currentCamera then
				return
			end

			FOVCircle.Position = currentCamera.ViewportSize / 2
			FOVCircle.Radius = fovRadius
			FOVCircle.Color = silentAimFovEnabled and getgenv().NexvyrTargetPart and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
			FOVCircle.Visible = true
		end)
	end

	Tabs.Farm:Section({ Title = "Farmeo de Evento", Icon = "solar:gift-bold" })
	getgenv().AutoEventFarm = false
	local nexvyrFarmSession = 0
	local Networking = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("Networking")
	local RemoteFarm = Networking and Networking:FindFirstChild("RE/Events/CollectEventSpawnable")
	UIElements.TogAutoFarmEvent = Tabs.Farm:Toggle({
		Title = "Auto Farmear Evento",
		Callback = function(s)
			getgenv().AutoEventFarm = s
			nexvyrFarmSession += 1
			local session = nexvyrFarmSession
			if s then
				task.spawn(function()
					while getgenv().AutoEventFarm and session == nexvyrFarmSession do
						pcall(function()
							if RemoteFarm then
								RemoteFarm:FireServer()
							else
								Networking = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("Networking")
								RemoteFarm = Networking and Networking:FindFirstChild("RE/Events/CollectEventSpawnable")
							end
						end)

						local char = player.Character
						local hrp = char and char:FindFirstChild("HumanoidRootPart")
						if hrp then
							local container = workspace:FindFirstChild("SpawnablesClient")
							if container then
								for _, obj in ipairs(container:GetChildren()) do
									if not getgenv().AutoEventFarm or session ~= nexvyrFarmSession then
										break
									end

									local touchPart = obj:FindFirstChild("Touch")
									if touchPart then
										pcall(function()
											firetouchinterest(hrp, touchPart, 0)
											firetouchinterest(hrp, touchPart, 1)
										end)
									end
								end
							end
						end

						task.wait(0.05)
					end
				end)
			end
		end
	})

	persistToggle("TogAutoFarmEvent", UIElements.TogAutoFarmEvent, function()
		return getgenv().AutoEventFarm == true
	end)
end


do
	local animationData = {
		["Old School"] = {
			Walk = 10921244891,
			Run = 10921240218,
			Jump = 10921242013,
			Fall = 10921241244,
			SwimIdle = 10921244018,
			Swim = 10921243048,
			Idle = 10921230744,
			Idle2 = 10921232093,
			Climb = 10921229866
		}, ["Adidas Sports"] = {
		Walk = 18537392113,
		Run = 18537384940,
		Jump = 18537380791,
		Fall = 18537367238,
		SwimIdle = 18537387180,
		Swim = 18537389531,
		Idle = 18537376492,
		Idle2 = 18537371272,
		Climb = 18537363391
	}, ["Adidas Community"] = {
		Walk = 122150855457006,
		Run = 82598234841035,
		Jump = 75290611992385,
		Fall = 98600215928904,
		SwimIdle = 109346520324160,
		Swim = 133308483266208,
		Idle = 122257458498464,
		Idle2 = 102357151005774,
		Climb = 88763136693023
	}, ["Adidas Aura"] = {
		Walk = 83842218823011,
		Run = 118320322718866,
		Jump = 109996626521204,
		Fall = 95603166884636,
		SwimIdle = 94922130551805,
		Swim = 134530128383903,
		Idle = 110211186840347,
		Idle2 = 114191137265065,
		Climb = 97824616490448
	}, ["Wicked Popular"] = {
		Walk = 92072849924640,
		Run = 72301599441680,
		Jump = 104325245285198,
		Fall = 121152442762481,
		Idle = 118832222982049,
		Idle2 = 76049494037641,
		SwimIdle = 113199415118199,
		Swim = 99384245425157,
		Climb = 131326830509784
	}, ["Elder"] = {
		Walk = 10921111375,
		Run = 10921104374,
		Jump = 10921107367,
		Fall = 10921105765,
		SwimIdle = 10921110146,
		Swim = 10921108971,
		Idle = 10921101664,
		Idle2 = 10921102574,
		Climb = 10921100400
	}, ["Zombie"] = {
		Walk = 10921355261,
		Run = 616163682,
		Jump = 10921351278,
		Fall = 10921350320,
		SwimIdle = 10921353442,
		Swim = 10921352344,
		Idle = 10921344533,
		Idle2 = 10921345304,
		Climb = 10921343576
	}, ["Mage"] = {
		Walk = 10921152678,
		Run = 10921148209,
		Jump = 10921149743,
		Fall = 10921148939,
		SwimIdle = 10921151661,
		Swim = 10921150788,
		Idle = 10921144709,
		Idle2 = 10921145797,
		Climb = 10921143404
	}, ["Catwalk Glam"] = {
		Walk = 109168724482748,
		Run = 81024476153754,
		Jump = 116936326516985,
		Fall = 92294537340807,
		SwimIdle = 98854111361360,
		Swim = 134591743181628,
		Idle = 133806214992291,
		Idle2 = 94970088341563,
		Climb = 119377220967554
	}, ["Astronaut"] = {
		Walk = 10921046031,
		Run = 10921039308,
		Jump = 10921042494,
		Fall = 10921040576,
		SwimIdle = 10921045006,
		Swim = 10921044000,
		Idle = 10921034824,
		Idle2 = 10921036806,
		Climb = 10921032124
	}, ['Wicked "Dancing Through Life"'] = {
		Walk = 73718308412641,
		Run = 135515454877967,
		Jump = 78508480717326,
		Fall = 78147885297412,
		SwimIdle = 129183123083281,
		Swim = 110657013921774,
		Idle = 92849173543269,
		Idle2 = 132238900951109,
		Climb = 129447497744818
	}, ["Werewolf"] = {
		Walk = 10921342074,
		Run = 10921336997,
		Fall = 10921337907,
		SwimIdle = 10921341319,
		Swim = 10921340419,
		Idle = 10921330408,
		Idle2 = 10921333667,
		Climb = 10921329322
	}, ["Superhero"] = {
		Walk = 10921298616,
		Run = 10921291831,
		Jump = 10921294559,
		Fall = 10921293273,
		SwimIdle = 10921297391,
		Swim = 10921295495,
		Idle = 10921288909,
		Idle2 = 10921290167,
		Climb = 10921286911
	}, ["Toy"] = {
		Walk = 10921312010,
		Run = 10921306285,
		Jump = 10921308158,
		Fall = 10921307241,
		SwimIdle = 10921310341,
		Swim = 10921309319,
		Idle = 10921301576,
		Climb = 10921300839
	}, ["No Boundaries"] = {
		Walk = 18747074203,
		Run = 18747070484,
		Jump = 18747069148,
		Fall = 18747062535,
		SwimIdle = 18747071682,
		Swim = 18747073181,
		Idle = 18747067405,
		Idle2 = 18747063918,
		Climb = 18747060903
	}, ["NFL"] = {
		Walk = 110358958299415,
		Run = 117333533048078,
		Jump = 119846112151352,
		Fall = 129773241321032,
		SwimIdle = 79090109939093,
		Swim = 132697394189921,
		Idle = 92080889861410,
		Idle2 = 74451233229259,
		Climb = 134630013742019
	}, ["Amazon Unboxed"] = {
		Walk = 90478085024465,
		Run = 134824450619865,
		Jump = 121454505477205,
		Fall = 94788218468396,
		SwimIdle = 129126268464847,
		Swim = 105962919001086,
		Idle = 98281136301627,
		Climb = 121145883950231
	}, ["Vampire"] = {
		Walk = 10921326949,
		Run = 10921320299,
		Jump = 10921322186,
		Fall = 10921321317,
		SwimIdle = 10921325443,
		Swim = 10921324408,
		Idle = 10921315373,
		Climb = 10921314188
	}, ["Ninja"] = {
		Walk = 656121766,
		Run = 656118852,
		Jump = 656117878,
		Fall = 656115606,
		SwimIdle = 656121397,
		Swim = 656119721,
		Idle = 656117400,
		Idle2 = 656118341,
		Climb = 656114359
	}, ["Robot"] = {
		Walk = 616095330,
		Run = 616091570,
		Jump = 616090535,
		Fall = 616087089,
		SwimIdle = 616094091,
		Swim = 616092998,
		Idle = 616088211,
		Idle2 = 616089559,
		Climb = 616086039
	}, ["Levitation"] = {
		Walk = 616013216,
		Run = 616010382,
		Jump = 616008936,
		Fall = 616005863,
		SwimIdle = 616012453,
		Swim = 616011509,
		Idle = 616006778,
		Idle2 = 616008087,
		Climb = 616003713
	}, ["Stylish"] = {
		Walk = 616146177,
		Run = 616140816,
		Jump = 616139451,
		Fall = 616134815,
		SwimIdle = 616144772,
		Swim = 616143378,
		Idle = 616136790,
		Idle2 = 616138447,
		Climb = 616133594
	}, ["Bubbly"] = {
		Walk = 910034870,
		Run = 910025107,
		Jump = 910016857,
		Fall = 910001910,
		SwimIdle = 910030921,
		Swim = 910028158,
		Idle = 910004836,
		Idle2 = 910009958,
		Climb = 909997997
	}, ["Cartoon"] = {
		Walk = 742640026,
		Run = 742638842,
		Jump = 742637942,
		Fall = 742637151,
		SwimIdle = 742639812,
		Swim = 742639220,
		Idle = 742637544,
		Idle2 = 742638445,
		Climb = 742636889
	} }

	local function clearAllAnimations()
		local char = player.Character
		if not char then
			return
		end

		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum then
			return
		end

		for _, track in pairs(hum:GetPlayingAnimationTracks()) do
			track:Stop(0)
			track:Destroy()
		end

		local animator = hum:FindFirstChildOfClass("Animator")
		if animator then
			for _, track in pairs(animator:GetPlayingAnimationTracks()) do
				track:Stop(0)
				track:Destroy()
			end
		end

		task.wait(0.1)
	end

	local function applyCustomAnims(customData)
		if not customData then
			return
		end

		local char = player.Character
		if not char then
			return
		end

		clearAllAnimations()
		local animate = char:FindFirstChild("Animate")
		if not animate then
			return
		end

		if not misAnimacionesOriginales then
			local function getAnim(folderName, animName)
				local folder = animate:FindFirstChild(folderName)
				if folder then
					local anim = folder:FindFirstChild(animName)
					if anim and anim:IsA("Animation") then
						local idStr = anim.AnimationId:match("%d+")
						if idStr then
							return tonumber(idStr)
						end
					end
				end

				return nil
			end

			misAnimacionesOriginales = {
				Idle = getAnim("idle", "Animation1") or 507766666,
				Idle2 = getAnim("idle", "Animation2") or 507766951,
				Walk = getAnim("walk", "WalkAnim") or 507777826,
				Run = getAnim("run", "RunAnim") or 507767714,
				Jump = getAnim("jump", "JumpAnim") or 507765000,
				Climb = getAnim("climb", "ClimbAnim") or 507765644,
				Fall = getAnim("fall", "FallAnim") or 507767968,
				Swim = getAnim("swim", "Swim") or 507784897,
				SwimIdle = getAnim("swimidle", "SwimIdle") or 507785072
			}
		end

		animate.Disabled = true
		task.wait(0.1)
		local function updateAnimation(folderName, animName, animId)
			if not animId then
				return
			end

			local folder = animate:FindFirstChild(folderName)
			if folder then
				local anim = folder:FindFirstChild(animName)
				if anim and anim:IsA("Animation") then
					anim.AnimationId = "rbxassetid://" .. tostring(animId)
				end
			end
		end

		updateAnimation("idle", "Animation1", customData.Idle)
		updateAnimation("idle", "Animation2", customData.Idle2 or customData.Idle)
		updateAnimation("walk", "WalkAnim", customData.Walk)
		updateAnimation("run", "RunAnim", customData.Run)
		updateAnimation("jump", "JumpAnim", customData.Jump)
		updateAnimation("climb", "ClimbAnim", customData.Climb)
		updateAnimation("fall", "FallAnim", customData.Fall)
		updateAnimation("swim", "Swim", customData.Swim)
		updateAnimation("swimidle", "SwimIdle", customData.SwimIdle or customData.Swim)
		task.wait(0.1)
		animate.Disabled = false
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum:ChangeState(Enum.HumanoidStateType.Landed)
			task.wait(0.05)
			hum:ChangeState(Enum.HumanoidStateType.Running)
		end
	end

	local nexvyrAnimationWorkerRunning = false
	nexvyrStartAnimationWorker = function()
		if nexvyrAnimationWorkerRunning or not animacionActualActiva then
			return
		end

		nexvyrAnimationWorkerRunning = true
		task.spawn(function()
			while animacionActualActiva do
				task.wait(0.2)
				if not animacionActualActiva then
					break
				end

				local char = player.Character
				if not char then
					continue
				end

				local hum = char:FindFirstChildOfClass("Humanoid")
				if not hum then
					continue
				end

				if hum.Health <= 0 then
					continue
				end

				if hum.MoveDirection.Magnitude >= 0.1 then
					continue
				end

				local animate = char:FindFirstChild("Animate")
				if not animate then
					continue
				end

				local walkIds = {}
				local walkFolder = animate:FindFirstChild("walk")
				local runFolder = animate:FindFirstChild("run")
				if walkFolder then
					for _, anim in ipairs(walkFolder:GetChildren()) do
						if anim:IsA("Animation") then
							table.insert(walkIds, anim.AnimationId)
						end
					end
				end

				if runFolder then
					for _, anim in ipairs(runFolder:GetChildren()) do
						if anim:IsA("Animation") then
							table.insert(walkIds, anim.AnimationId)
						end
					end
				end

				if #walkIds == 0 then
					continue
				end

				local animator = hum:FindFirstChildOfClass("Animator")
				if animator then
					for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
						if track.Animation and table.find(walkIds, track.Animation.AnimationId) then
							track:Stop(0)
						end
					end
				end
			end

			nexvyrAnimationWorkerRunning = false
		end)
	end

	player.CharacterAdded:Connect(function()
		if animacionActualActiva then
			task.spawn(function()
				task.wait(0.8)
				applyCustomAnims(animacionActualActiva)
			end)
		end
	end)

	local animList = { "Ninguno" }
	for name, _ in pairs(animationData) do
		table.insert(animList, name)
	end

	table.sort(animList)
	Tabs.Animaciones:Section({ Title = "Paquetes Completos", Icon = "solar:folder-with-files-bold" })
	local selectedBundleCompleto = "Ninguno"
	Tabs.Animaciones:Dropdown({
		Title = "Elegir Paquete",
		Values = animList,
		Value = "Ninguno",
		Callback = function(Value)
			selectedBundleCompleto = Value
		end
	})

	Tabs.Animaciones:Button({
		Title = "Aplicar Paquete Completo",
		Callback = function()
			if selectedBundleCompleto == "Ninguno" then
				return
			end

			task.spawn(function()
				animacionActualActiva = animationData[selectedBundleCompleto]
				nexvyrStartAnimationWorker()
				applyCustomAnims(animacionActualActiva)
			end)
		end
	})

	Tabs.Animaciones:Button({
		Title = "Restaurar Default",
		Callback = function()
			task.spawn(function()
				local defaultAnims = misAnimacionesOriginales or {
					Idle = 507766666,
					Idle2 = 507766951,
					Walk = 507777826,
					Run = 507767714,
					Jump = 507765000,
					Climb = 507765644,
					Fall = 507767968,
					Swim = 507784897,
					SwimIdle = 507785072
				}

				animacionActualActiva = nil
				applyCustomAnims(defaultAnims)
			end)
		end
	})

	Tabs.Animaciones:Space()
	Tabs.Animaciones:Divider()
	Tabs.Animaciones:Space()
	Tabs.Animaciones:Section({ Title = "Mezclador de Animaciones", Icon = "solar:layers-bold" })
	local mixParts = {
		Idle = "Ninguno",
		Walk = "Ninguno",
		Run = "Ninguno",
		Jump = "Ninguno",
		Fall = "Ninguno",
		Climb = "Ninguno"
	}

	Tabs.Animaciones:Dropdown({
		Title = "Reposo",
		Values = animList,
		Value = "Ninguno",
		Callback = function(Value)
			mixParts.Idle = Value
		end
	})

	Tabs.Animaciones:Dropdown({
		Title = "Caminar",
		Values = animList,
		Value = "Ninguno",
		Callback = function(Value)
			mixParts.Walk = Value
		end
	})

	Tabs.Animaciones:Dropdown({
		Title = "Correr",
		Values = animList,
		Value = "Ninguno",
		Callback = function(Value)
			mixParts.Run = Value
		end
	})

	Tabs.Animaciones:Dropdown({
		Title = "Saltar",
		Values = animList,
		Value = "Ninguno",
		Callback = function(Value)
			mixParts.Jump = Value
		end
	})

	Tabs.Animaciones:Dropdown({
		Title = "Caer",
		Values = animList,
		Value = "Ninguno",
		Callback = function(Value)
			mixParts.Fall = Value
		end
	})

	Tabs.Animaciones:Dropdown({
		Title = "Escalar",
		Values = animList,
		Value = "Ninguno",
		Callback = function(Value)
			mixParts.Climb = Value
		end
	})

	Tabs.Animaciones:Button({
		Title = "Combinar y Aplicar",
		Callback = function()
			task.spawn(function()
				local customMix = {}
				if mixParts.Idle ~= "Ninguno" then
					customMix.Idle = animationData[mixParts.Idle].Idle
					customMix.Idle2 = animationData[mixParts.Idle].Idle2
				end

				if mixParts.Walk ~= "Ninguno" then
					customMix.Walk = animationData[mixParts.Walk].Walk
				end

				if mixParts.Run ~= "Ninguno" then
					customMix.Run = animationData[mixParts.Run].Run
				end

				if mixParts.Jump ~= "Ninguno" then
					customMix.Jump = animationData[mixParts.Jump].Jump
				end

				if mixParts.Fall ~= "Ninguno" then
					customMix.Fall = animationData[mixParts.Fall].Fall
				end

				if mixParts.Climb ~= "Ninguno" then
					customMix.Climb = animationData[mixParts.Climb].Climb
				end

				local hasValues = false
				for _, v in pairs(customMix) do
					if v then
						hasValues = true
						break
					end
				end

				if hasValues then
					animacionActualActiva = customMix
					nexvyrStartAnimationWorker()
					applyCustomAnims(animacionActualActiva)
				end
			end)
		end
	})
end


local KillSoundVolume = 1
local KillSoundPlayer = Instance.new("Sound")
KillSoundPlayer.Name = "NexvyrKillSound"
KillSoundPlayer.Volume = 1
KillSoundPlayer.Looped = false
KillSoundPlayer.Parent = SoundService
local ShootSoundPlayer = Instance.new("Sound")
ShootSoundPlayer.Name = "NexvyrShootSound"
ShootSoundPlayer.Volume = 1
ShootSoundPlayer.Looped = false
ShootSoundPlayer.Parent = SoundService
local ReloadSoundPlayer = Instance.new("Sound")
ReloadSoundPlayer.Name = "NexvyrReloadSound"
ReloadSoundPlayer.Volume = 1
ReloadSoundPlayer.Looped = false
ReloadSoundPlayer.Parent = SoundService


do
	local ContentProvider = game:GetService("ContentProvider")
	local function dmvsDisconnectConnectionList(list)
		if not list then
			return
		end

		for i = #list, 1, -1 do
			local connection = list[i]
			list[i] = nil
			if connection and connection.Connected then
				connection:Disconnect()
			end
		end
	end

	local KillSoundEnabled = false
	local RecargaDisparoEnabled = false
	local SelectedKillSound = "Onichaaan"
	local KillSounds = {
		{ Name = "Onichaaan", Id = "114361503583259" },
		{ Name = "Omagaaa", Id = "4496966777" },
		{ Name = "korummm", Id = "119896940405402" },
		{ Name = "FAAAH XD", Id = "92076037937225" },
		{ Name = "Campana meme", Id = "107378927201728" },
		{ Name = "Enrique", Id = "100688006999379" },
		{ Name = "Magia de anime", Id = "109296938403067" },
		{ Name = "Risa anime", Id = "93739527256723" },
		{ Name = "Gemido", Id = "94981264286350" },
		{ Name = "Magic 2", Id = "100507897550384" },
		{ Name = "OwO", Id = "71942674274967" },
		{ Name = "SEMPAI >.<", Id = "115498703521334" },
		{ Name = "Ahhh:3", Id = "83559496188823" },
		{ Name = "ñyaa >//~//<", Id = "78798011197804" },
		{ Name = "Headshot", Id = "130456049552264" },
	}
	local ShootReloadOptions = {
		["Revolver + Recarga"] = { Shoot = "680140087", Reload = "138084889" },
		["Magia de Anime"] = { Shoot = "109296938403067", Reload = nil },
		["Láser + Recarga láser"] = { Shoot = "4400449399", Reload = "129456040607483" },
	}
	local SelectedShootReload = "Revolver + Recarga"
	local SHOOT_SOUND_MAX_DURATION = 1.5
	local shootSoundToken = 0
	local lastShootSoundTime = 0
	local SHOOT_SOUND_MIN_INTERVAL = 0.05
	local function PlayShootSound()
		if not RecargaDisparoEnabled then
			return
		end

		local cfg = ShootReloadOptions[SelectedShootReload]
		if not cfg or not cfg.Shoot then
			return
		end

		local now = tick()
		if now - lastShootSoundTime < SHOOT_SOUND_MIN_INTERVAL then
			return
		end

		lastShootSoundTime = now
		shootSoundToken = shootSoundToken + 1
		local myToken = shootSoundToken
		ShootSoundPlayer:Stop()
		ShootSoundPlayer.SoundId = "rbxassetid://" .. cfg.Shoot
		ShootSoundPlayer.Volume = KillSoundVolume
		ShootSoundPlayer:Play()
		task.delay(SHOOT_SOUND_MAX_DURATION, function()
			if shootSoundToken == myToken and ShootSoundPlayer.Playing then
				ShootSoundPlayer:Stop()
			end
		end)
	end

	local function PlayReloadSound()
		if not RecargaDisparoEnabled then
			return
		end

		local cfg = ShootReloadOptions[SelectedShootReload]
		if not cfg or not cfg.Reload then
			return
		end

		ReloadSoundPlayer:Stop()
		ReloadSoundPlayer.SoundId = "rbxassetid://" .. cfg.Reload
		ReloadSoundPlayer.Volume = KillSoundVolume
		ReloadSoundPlayer:Play()
	end

	local nexvyrShootConnections = {}
	local nexvyrFireWatched = setmetatable({}, { __mode = "k" })
	local nexvyrToolWatched = setmetatable({}, { __mode = "k" })
	local nexvyrShootRootWatched = setmetatable({}, { __mode = "k" })
	local function nexvyrTrackShoot(connection)
		nexvyrShootConnections[#nexvyrShootConnections + 1] = connection
		return connection
	end

	local function nexvyrStopShootWatchers()
		dmvsDisconnectConnectionList(nexvyrShootConnections)
		table.clear(nexvyrFireWatched)
		table.clear(nexvyrToolWatched)
		table.clear(nexvyrShootRootWatched)
	end

	local nexvyrStartReloadWorker
	local FIRE_SOUND_KEYWORDS = {
		"fire",
		"shoot",
		"shot",
		"gun",
		"burst",
		"shotgun",
		"gunshot",
		"muzzle",
		"rifle",
		"pistol",
		"shooting",
		"firing"
	}

	local function isFireSound(s)
		if not s:IsA("Sound") then
			return false
		end

		local n = string.lower(s.Name)
		for _, kw in ipairs(FIRE_SOUND_KEYWORDS) do
			if string.find(n, kw, 1, true) then
				return true
			end
		end

		return false
	end

	local function HookFireSound(s)
		if not s:IsA("Sound") then
			return
		end

		if not isFireSound(s) then
			return
		end

		if not RecargaDisparoEnabled or nexvyrFireWatched[s] then
			return
		end

		nexvyrFireWatched[s] = true
		nexvyrTrackShoot(s.Played:Connect(function()
			if not RecargaDisparoEnabled then
				return
			end

			local char = player.Character
			if not char then
				return
			end

			if s:IsDescendantOf(char) or s:IsDescendantOf(player:FindFirstChildOfClass("Backpack") or char) then
				PlayShootSound()
			end
		end))
	end

	local function HookShootOnTool(tool)
		if not tool or not tool:IsA("Tool") then
			return
		end

		for _, d in ipairs(tool:GetDescendants()) do
			HookFireSound(d)
		end

		if not nexvyrToolWatched[tool] and RecargaDisparoEnabled then
			nexvyrToolWatched[tool] = true
			nexvyrTrackShoot(tool.DescendantAdded:Connect(HookFireSound))
		end
	end

	local function HookShootOnRoot(root)
		if not root then
			return
		end

		for _, child in ipairs(root:GetChildren()) do
			if child:IsA("Tool") then
				HookShootOnTool(child)
			end
		end

		nexvyrTrackShoot(root.ChildAdded:Connect(function(child)
			if child:IsA("Tool") then
				HookShootOnTool(child)
			end
		end))
	end

	local nexvyrReloadRunning = false
	nexvyrStartReloadWorker = function()
		if nexvyrReloadRunning or not RecargaDisparoEnabled then
			return
		end

		nexvyrReloadRunning = true
		task.spawn(function()
			local lastReloadState = false
			while RecargaDisparoEnabled do
				task.wait(0.05)
				if not RecargaDisparoEnabled then
					break
				end

				local char = player.Character
				if not char then
					lastReloadState = false
					continue
				end

				local arma = char:FindFirstChildOfClass("Tool")
				if not arma or esCuchillo(arma) then
					lastReloadState = false
					continue
				end

				local recargando = estaRecargando(arma)
				if recargando and not lastReloadState then
					PlayReloadSound()
				end

				lastReloadState = recargando
			end

			nexvyrReloadRunning = false
		end)
	end

	local function GetKillSoundIdByName(soundName)
		for _, s in ipairs(KillSounds) do
			if s.Name == soundName then
				return s.Id
			end
		end

		return KillSounds[1].Id
	end

	local function PreloadKillSound()
		task.spawn(function()
			pcall(function()
				local id = "rbxassetid://" .. GetKillSoundIdByName(SelectedKillSound)
				if KillSoundPlayer.SoundId ~= id then
					KillSoundPlayer.SoundId = id
				end

				ContentProvider:PreloadAsync({ KillSoundPlayer })
			end)
		end)
	end

	local function PlayKillSound()
		if not KillSoundEnabled then
			return
		end

		local id = "rbxassetid://" .. GetKillSoundIdByName(SelectedKillSound)
		KillSoundPlayer:Stop()
		if KillSoundPlayer.SoundId ~= id then
			KillSoundPlayer.SoundId = id
		end

		KillSoundPlayer.Volume = KillSoundVolume
		KillSoundPlayer.TimePosition = 0
		KillSoundPlayer:Play()
	end

	local lastKillSoundTime = 0
	local lastPrimaryKillTime = 0
	local KILL_SOUND_COOLDOWN = 0.08
	local KILL_SOUND_PRIMARY_COOLDOWN = 0.3
	local KILL_SOUND_FALLBACK_WINDOW = 4
	local function TryPlayKillSound(primary)
		if not KillSoundEnabled then
			return
		end

		local now = tick()
		if primary then
			if now - lastKillSoundTime < KILL_SOUND_PRIMARY_COOLDOWN then
				return
			end

			lastPrimaryKillTime = now
		else
			if now - lastKillSoundTime < KILL_SOUND_COOLDOWN then
				return
			end

			if now - lastPrimaryKillTime < KILL_SOUND_FALLBACK_WINDOW then
				return
			end
		end

		lastKillSoundTime = now
		PlayKillSound()
	end

	local nexvyrKillConnections = {}
	local nexvyrKillWatchedStats = setmetatable({}, { __mode = "k" })
	local nexvyrKillWatchedCharacters = setmetatable({}, { __mode = "k" })
	local nexvyrKillWatchedPlayers = setmetatable({}, { __mode = "k" })
	local nexvyrKillWatchedContainers = setmetatable({}, { __mode = "k" })
	local nexvyrKillRemoteSession = 0
	local function nexvyrTrackKill(connection)
		nexvyrKillConnections[#nexvyrKillConnections + 1] = connection
		return connection
	end

	local KILL_STAT_NAMES = {
		kos = true,
		kills = true,
		kill = true,
		ko = true,
		killed = true,
		eliminations = true,
		kills_count = true
	}

	local function HookStatValue(stat)
		if not stat then
			return
		end

		if not (stat:IsA("IntValue") or stat:IsA("NumberValue")) then
			return
		end

		if not KILL_STAT_NAMES[string.lower(stat.Name)] then
			return
		end

		if not KillSoundEnabled or nexvyrKillWatchedStats[stat] then
			return
		end

		nexvyrKillWatchedStats[stat] = true
		local lastVal = stat.Value
		nexvyrTrackKill(stat:GetPropertyChangedSignal("Value"):Connect(function()
			if stat.Value > lastVal then
				TryPlayKillSound()
			end

			lastVal = stat.Value
		end))
	end

	local function HookLeaderstatsContainer(container)
		if not container or not KillSoundEnabled or nexvyrKillWatchedContainers[container] then
			return
		end

		nexvyrKillWatchedContainers[container] = true
		for _, stat in ipairs(container:GetChildren()) do
			HookStatValue(stat)
		end

		nexvyrTrackKill(container.ChildAdded:Connect(HookStatValue))
	end

	local KILL_ATTR_NAMES = { "KOs", "Kills", "kos", "kills", "KO", "killed", "Eliminations" }
	local function nexvyrWatchLocalKillStats()
		for _, attrName in ipairs(KILL_ATTR_NAMES) do
			local lastVal = tonumber(player:GetAttribute(attrName))
			nexvyrTrackKill(player:GetAttributeChangedSignal(attrName):Connect(function()
				local newVal = tonumber(player:GetAttribute(attrName))
				if newVal ~= nil and lastVal ~= nil and newVal > lastVal then
					TryPlayKillSound()
				end

				lastVal = newVal
			end))
		end

		for _, name in ipairs({ "leaderstats", "Stats", "stats", "PlayerStats" }) do
			HookLeaderstatsContainer(player:FindFirstChild(name))
		end

		nexvyrTrackKill(player.ChildAdded:Connect(function(child)
			if child.Name == "leaderstats" or child.Name == "Stats" or child.Name == "stats" or child.Name == "PlayerStats" then
				HookLeaderstatsContainer(child)
			end
		end))
	end

	local function HookKillOnCharacter(other, character)
		if not KillSoundEnabled or nexvyrKillWatchedCharacters[character] then
			return
		end

		nexvyrKillWatchedCharacters[character] = true
		local waitConnection
		local function attachHumanoid(humanoid)
			if not KillSoundEnabled or not humanoid or not humanoid:IsA("Humanoid") then
				return
			end

			if waitConnection then
				waitConnection:Disconnect();
				waitConnection = nil
			end

			nexvyrTrackKill(humanoid.Died:Connect(function()
				if not KillSoundEnabled then
					return
				end

				local tag = humanoid:FindFirstChild("creator")
				if tag and tag.Value == player then
					TryPlayKillSound()
				end
			end))
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			attachHumanoid(humanoid)
		else
			waitConnection = nexvyrTrackKill(character.ChildAdded:Connect(attachHumanoid))
		end
	end

	local function HookKillPlayer(other)
		if other == player or not KillSoundEnabled or nexvyrKillWatchedPlayers[other] then
			return
		end

		nexvyrKillWatchedPlayers[other] = true
		if other.Character then
			HookKillOnCharacter(other, other.Character)
		end

		nexvyrTrackKill(other.CharacterAdded:Connect(function(character)
			HookKillOnCharacter(other, character)
		end))
	end

	local function nexvyrHookKilledRemote()
		nexvyrKillRemoteSession += 1
		local session = nexvyrKillRemoteSession
		task.spawn(function()
			local tries = 0
			while KillSoundEnabled and session == nexvyrKillRemoteSession and tries < 30 do
				local packages = ReplicatedStorage:FindFirstChild("Packages")
				local networking = packages and packages:FindFirstChild("Networking")
				local remote = networking and networking:FindFirstChild("RE/Combat/Killed")
				if remote and remote:IsA("RemoteEvent") then
					nexvyrTrackKill(remote.OnClientEvent:Connect(function(killer)
						if killer == player then
							TryPlayKillSound(true)
						end
					end))

					return
				end

				tries += 1
				task.wait(1)
			end
		end)
	end

	local function nexvyrStartKillWatchers()
		if not KillSoundEnabled then
			return
		end

		nexvyrHookKilledRemote()
		nexvyrWatchLocalKillStats()
		for _, other in ipairs(Players:GetPlayers()) do
			HookKillPlayer(other)
		end

		nexvyrTrackKill(Players.PlayerAdded:Connect(HookKillPlayer))
	end

	local function nexvyrStopKillWatchers()
		nexvyrKillRemoteSession += 1
		dmvsDisconnectConnectionList(nexvyrKillConnections)
		table.clear(nexvyrKillWatchedStats)
		table.clear(nexvyrKillWatchedCharacters)
		table.clear(nexvyrKillWatchedPlayers)
		table.clear(nexvyrKillWatchedContainers)
	end

	local OriginalGunVolumes = {}
	local HookedGunSounds = setmetatable({}, { __mode = "k" })
	local function MuteOwnSound(s)
		if not RecargaDisparoEnabled or not s:IsA("Sound") then
			return
		end

		if s.Name == "NexvyrKillSound" or s.Name == "WindUI_MusicPlayer" or s.Name == "NexvyrShootSound" or s.Name == "NexvyrReloadSound" then
			return
		end

		if OriginalGunVolumes[s] == nil and s.Volume > 0 then
			OriginalGunVolumes[s] = s.Volume
		end

		if RecargaDisparoEnabled then
			s.Volume = 0
		end

		if not HookedGunSounds[s] then
			HookedGunSounds[s] = true
			nexvyrTrackShoot(s:GetPropertyChangedSignal("Volume"):Connect(function()
				if RecargaDisparoEnabled and s.Volume ~= 0 then
					OriginalGunVolumes[s] = s.Volume
					s.Volume = 0
				end
			end))

			nexvyrTrackShoot(s.Played:Connect(function()
				if RecargaDisparoEnabled then
					s.Volume = 0
				end
			end))
		end
	end

	local function HookOwnRoot(root)
		if not root then
			return
		end

		for _, d in ipairs(root:GetDescendants()) do
			MuteOwnSound(d)
		end

		nexvyrTrackShoot(root.DescendantAdded:Connect(MuteOwnSound))
	end

	local function ApplyMuteState(state)
		if state then
			for s in pairs(OriginalGunVolumes) do
				if s.Parent then
					s.Volume = 0
				end
			end

			if player.Character then
				for _, d in ipairs(player.Character:GetDescendants()) do
					MuteOwnSound(d)
				end
			end

			local backpack = player:FindFirstChildOfClass("Backpack")
			if backpack then
				for _, d in ipairs(backpack:GetDescendants()) do
					MuteOwnSound(d)
				end
			end
		else
			for s, v in pairs(OriginalGunVolumes) do
				if s.Parent then
					s.Volume = v
				end
			end
		end
	end

	local function nexvyrStartShootWatchers()
		if not RecargaDisparoEnabled then
			return
		end

		local function attach(root)
			if not root or not RecargaDisparoEnabled or nexvyrShootRootWatched[root] then
				return
			end

			nexvyrShootRootWatched[root] = true
			HookOwnRoot(root)
			HookShootOnRoot(root)
		end

		attach(player.Character)
		attach(player:FindFirstChildOfClass("Backpack"))
		nexvyrTrackShoot(player.CharacterAdded:Connect(function(character)
			if not RecargaDisparoEnabled then
				return
			end

			attach(character)
			local backpack = player:FindFirstChildOfClass("Backpack")
			if backpack then
				attach(backpack)
			end
		end))

		nexvyrTrackShoot(player.ChildAdded:Connect(function(child)
			if child:IsA("Backpack") then
				attach(child)
			end
		end))

		nexvyrStartReloadWorker()
	end

	Tabs.Sonidos:Section({ Title = "Sonido de Muerte", Icon = "solar:speaker-bold" })
	UIElements.TogKillSound = Tabs.Sonidos:Toggle({
		Title = "Sonido de Kill",
		Value = false,
		Callback = function(v)
			if KillSoundEnabled == v then
				return
			end

			KillSoundEnabled = v
			if v then
				PreloadKillSound()
				nexvyrStartKillWatchers()
			else
				nexvyrStopKillWatchers()
				KillSoundPlayer:Stop()
			end
		end
	})

	local KillSoundDropdownValues = {}
	for _, s in ipairs(KillSounds) do
		table.insert(KillSoundDropdownValues, s.Name)
	end

	UIElements.DropKillSound = Tabs.Sonidos:Dropdown({
		Title = "Sonido de muerte",
		Values = KillSoundDropdownValues,
		Value = "Onichaaan",
		Callback = function(selected)
			SelectedKillSound = selected
			if KillSoundEnabled then
				PreloadKillSound()
			end
		end
	})

	Tabs.Sonidos:Section({ Title = "Disparo y Recarga", Icon = "solar:target-bold" })
	UIElements.TogShootReload = Tabs.Sonidos:Toggle({
		Title = "Recarga + disparo",
		Value = false,
		Callback = function(v)
			if RecargaDisparoEnabled == v then
				return
			end

			RecargaDisparoEnabled = v
			if v then
				nexvyrStartShootWatchers()
				ApplyMuteState(true)
			else
				nexvyrStopShootWatchers()
				ShootSoundPlayer:Stop()
				ReloadSoundPlayer:Stop()
				ApplyMuteState(false)
				table.clear(OriginalGunVolumes)
				table.clear(HookedGunSounds)
			end
		end
	})

	UIElements.DropShootSound = Tabs.Sonidos:Dropdown({
		Title = "Sonido de disparo",
		Values = { "Revolver + Recarga", "Magia de Anime", "Láser + Recarga láser" },
		Value = "Revolver + Recarga",
		Callback = function(selected)
			SelectedShootReload = selected
		end
	})

	UIElements.SliKillSoundVolume = Tabs.Sonidos:Slider({
		Title = "Volumen",
		Step = 0.1,
		Value = { Min = 1, Max = 3, Default = 1 },
		Callback = function(v)
			KillSoundVolume = v
			KillSoundPlayer.Volume = v
			ShootSoundPlayer.Volume = v
			ReloadSoundPlayer.Volume = v
		end
	})

	persistDropdown("DropKillSound", UIElements.DropKillSound, function()
		return SelectedKillSound
	end, function(v)
		SelectedKillSound = v
	end)

	persistDropdown("DropShootSound", UIElements.DropShootSound, function()
		return SelectedShootReload
	end, function(v)
		SelectedShootReload = v
	end)

	persistSlider("SliKillSoundVolume", UIElements.SliKillSoundVolume, function()
		return KillSoundVolume
	end)

	persistToggle("TogKillSound", UIElements.TogKillSound, function()
		return KillSoundEnabled
	end)

	persistToggle("TogShootReload", UIElements.TogShootReload, function()
		return RecargaDisparoEnabled
	end)
end


do
	local MusicPlayer = Instance.new("Sound")
	MusicPlayer.Name = "WindUI_MusicPlayer"
	MusicPlayer.Looped = false
	MusicPlayer.Volume = 0.5
	MusicPlayer.Parent = SoundService
	local SongList = {
		{ Name = "Canción 1", Id = "84944985070181" },
		{ Name = "Canción 2", Id = "87570666848900" },
		{ Name = "Canción 3", Id = "82746224492420" },
		{ Name = "Canción 4", Id = "71393805905055" },
		{ Name = "Canción 5", Id = "75688616622595" },
		{ Name = "Canción 6", Id = "135609653444873" },
		{ Name = "Canción 7", Id = "93699644879957" },
		{ Name = "Canción 8", Id = "110398343528156" },
		{ Name = "Canción 9", Id = "138863509657081" },
		{ Name = "Canción 10", Id = "115440201770223" },
		{ Name = "Canción 11", Id = "128048502331483" },
		{ Name = "Canción 12", Id = "135321902579514" },
		{ Name = "Canción 13", Id = "131465489873214" },
	}
	local CurrentIndex = 1
	local ShuffleOn = false
	local NowPlayingParagraph
	local function UpdateNowPlaying()
		local song = SongList[CurrentIndex]
		if song and NowPlayingParagraph then
			NowPlayingParagraph:SetDesc( ("%s • ID: %s • %s"):format(song.Name, song.Id, MusicPlayer.Playing and "Reproduciendo" or "Pausado"))
		end
	end

	local function LoadSong(index)
		if not SongList[index] then
			return
		end

		CurrentIndex = index
		MusicPlayer:Stop()
		MusicPlayer.SoundId = "rbxassetid://" .. SongList[index].Id
		MusicPlayer:Play()
		UpdateNowPlaying()
	end

	local function PlaySong()
		if MusicPlayer.SoundId == "" then
			LoadSong(CurrentIndex)
		elseif not MusicPlayer.Playing then
			MusicPlayer:Resume()
		end

		UpdateNowPlaying()
	end

	local function PauseSong()
		if MusicPlayer.Playing then
			MusicPlayer:Pause()
		end

		UpdateNowPlaying()
	end

	local function StopSong()
		MusicPlayer:Stop()
		MusicPlayer.SoundId = ""
		UpdateNowPlaying()
	end

	local function NextSong()
		local nextIndex
		if ShuffleOn then
			nextIndex = math.random(1, #SongList)
		else
			nextIndex = CurrentIndex + 1
			if nextIndex > #SongList then
				nextIndex = 1
			end
		end

		LoadSong(nextIndex)
	end

	local function PrevSong()
		local prevIndex
		if ShuffleOn then
			prevIndex = math.random(1, #SongList)
		else
			prevIndex = CurrentIndex - 1
			if prevIndex < 1 then
				prevIndex = #SongList
			end
		end

		LoadSong(prevIndex)
	end

	MusicPlayer.Ended:Connect(function()
		NextSong()
	end)

	Tabs.Music:Section({ Title = "Ahora suena", Icon = "solar:music-note-bold" })
	NowPlayingParagraph = Tabs.Music:Paragraph({ Title = "Sin canción seleccionada", Icon = "solar:music-note-2-bold" })
	Tabs.Music:Section({ Title = "Controles", Icon = "solar:tuning-2-bold" })
	Tabs.Music:Button({
		Title = "Anterior",
		Icon = "solar:skip-previous-bold",
		Variant = "Secondary",
		Callback = function()
			PrevSong()
		end
	})

	Tabs.Music:Button({
		Title = "Siguiente",
		Icon = "solar:skip-next-bold",
		Variant = "Secondary",
		Callback = function()
			NextSong()
		end
	})

	Tabs.Music:Button({
		Title = "Reproducir",
		Icon = "solar:play-circle-bold",
		Variant = "Primary",
		Callback = function()
			PlaySong()
		end
	})

	Tabs.Music:Button({
		Title = "Pausar",
		Icon = "solar:pause-circle-bold",
		Variant = "Secondary",
		Callback = function()
			PauseSong()
		end
	})

	Tabs.Music:Button({
		Title = "Detener",
		Icon = "solar:close-circle-bold",
		Variant = "Danger",
		Callback = function()
			StopSong()
		end
	})
end


local KorbloxEnabled = false
local HeadlessEnabled = false
local applyKorblox, removeKorblox, setHeadless


do
	local KORBLOX_ASSETS = {
		["Right Leg"] = {
			id = "rbxassetid://139607718",
			targetBodyPart = "RightUpperLeg",
			partsToHide = { "RightUpperLeg", "RightLowerLeg", "RightFoot" },
			scale = Vector3.new(1.0, 1.0, 1.0),
			audio = "rbxassetid://135315310485417",
			offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0),
		} }
	local korbloxSavedTransparency = {}
	local function attachKorbloxMesh(itemName, config)
		local character = player.Character
		if not character then
			return false
		end

		local targetPart = character:WaitForChild(config.targetBodyPart, 2)
		if not targetPart then
			return false
		end

		local oldAsset = character:FindFirstChild("Korblox_" .. itemName:gsub("%s+", ""))
		if oldAsset then
			oldAsset:Destroy()
		end

		for _, partName in ipairs(config.partsToHide) do
			local limb = character:FindFirstChild(partName)
			if limb and limb:IsA("BasePart") then
				if korbloxSavedTransparency[partName] == nil then
					korbloxSavedTransparency[partName] = limb.Transparency
				end

				limb.Transparency = 1
			end
		end

		local success, objects = pcall(function()
			return game:GetObjects(config.id)
		end)

		if not success or not objects or #objects == 0 then
			return false
		end

		local assetModel = objects[1]
		assetModel.Name = "Korblox_" .. itemName:gsub("%s+", "")
		local mainMesh = assetModel:IsA("BasePart") and assetModel or assetModel:FindFirstChildWhichIsA("BasePart", true)
		if not mainMesh then
			return false
		end

		mainMesh.Size = mainMesh.Size * config.scale
		mainMesh.CanCollide = false
		mainMesh.CFrame = targetPart.CFrame * config.offset
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = targetPart
		weld.Part1 = mainMesh
		weld.Parent = mainMesh
		assetModel.Parent = character
		if config.audio then
			local sound = Instance.new("Sound")
			sound.SoundId = config.audio
			sound.Volume = 0.5
			sound.Parent = mainMesh
			sound:Play()
			game:GetService("Debris"):AddItem(sound, 3)
		end

		return true
	end

	function applyKorblox()
		if not KorbloxEnabled then
			return
		end

		local config = KORBLOX_ASSETS["Right Leg"]
		local ok = attachKorbloxMesh("Right Leg", config)
		if not ok then
			task.wait(0.2)
			attachKorbloxMesh("Right Leg", config)
		end
	end

	function removeKorblox()
		local character = player.Character
		if not character then
			return
		end

		local assetName = "Korblox_RightLeg"
		local asset = character:FindFirstChild(assetName)
		if asset then
			pcall(function()
				asset:Destroy()
			end)
		end

		for partName, orig in pairs(korbloxSavedTransparency) do
			local limb = character:FindFirstChild(partName)
			if limb and limb:IsA("BasePart") then
				pcall(function()
					limb.Transparency = orig
				end)
			end
		end

		korbloxSavedTransparency = {}
	end

	local HEADLESS_ASSET_ID = 134082579
	local insertedHeadlessAccessory = nil
	local function setHeadlessTransparency(enabled)
		local character = player.Character
		if not character then
			return
		end

		local head = character:FindFirstChild("Head")
		if head then
			head.Transparency = enabled and 1 or 0
			local faceDecal = head:FindFirstChildOfClass("Decal")
			if faceDecal then
				faceDecal.Transparency = enabled and 1 or 0
			end
		end
	end

	function setHeadless(enabled)
		local character = player.Character
		if not character then
			return
		end

		if enabled then
			character:WaitForChild("Head", 2)
			setHeadlessTransparency(true)
			if insertedHeadlessAccessory and insertedHeadlessAccessory.Parent ~= character then
				insertedHeadlessAccessory = nil
			end

			if insertedHeadlessAccessory then
				return
			end

			local success, result = pcall(function()
				return game:GetObjects("rbxassetid://" .. tostring(HEADLESS_ASSET_ID))
			end)

			if success and result and #result > 0 then
				local rootModel = result[1]
				local model = nil
				if rootModel:IsA("Accessory") then
					model = rootModel
				else
					for _, descendant in ipairs(rootModel:GetDescendants()) do
						if descendant:IsA("Accessory") then
							model = descendant
							break
						end
					end

					model = model or (rootModel:IsA("Model") and rootModel or nil)
				end

				if model then
					if model:IsA("Accessory") then
						local humanoid = character:FindFirstChildOfClass("Humanoid")
						local addSuccess = humanoid and pcall(function()
							humanoid:AddAccessory(model)
						end)

						if not addSuccess then
							model.Parent = character
						end
					else
						model.Parent = character
					end

					insertedHeadlessAccessory = model
				end
			else
				warn("[Headless] Failed to load headless asset: " .. tostring(result))
			end
		else
			setHeadlessTransparency(false)
			if insertedHeadlessAccessory then
				insertedHeadlessAccessory:Destroy()
				insertedHeadlessAccessory = nil
			end
		end
	end

	player.CharacterAdded:Connect(function(character)
		korbloxSavedTransparency = {}
		insertedHeadlessAccessory = nil
		if KorbloxEnabled then
			task.spawn(function()
				task.wait(0.1)
				applyKorblox()
			end)
		end

		if HeadlessEnabled then
			task.spawn(function()
				task.wait(0.1)
				setHeadless(true)
			end)
		end
	end)

	Tabs.Items:Section({ Title = "Items", Icon = "solar:crown-star-bold" })
	UIElements.TogHeadless = Tabs.Items:Toggle({
		Title = "Aplicar Headless",
		Value = false,
		Callback = function(v)
			HeadlessEnabled = v
			if v then
				setHeadless(true)
			else
				setHeadless(false)
			end
		end
	})

	UIElements.TogKorblox = Tabs.Items:Toggle({
		Title = "Aplicar Korblox",
		Value = false,
		Callback = function(v)
			KorbloxEnabled = v
			if v then
				applyKorblox()
			else
				removeKorblox()
			end
		end
	})

	persistToggle("TogHeadless", UIElements.TogHeadless, function()
		return HeadlessEnabled
	end)

	persistToggle("TogKorblox", UIElements.TogKorblox, function()
		return KorbloxEnabled
	end)
end


Tabs.Identidad:Section({ Title = "identidad falsa", Icon = "solar:user-id-bold" })
local updateSystem


do
	local function safeReplace(str, find, replace)
		local safeFind = find:gsub("[%-%^%$%(%)%%%.%[%]%*%+%?]", "%%%1")
		local safeRep = replace:gsub("%%", "%%%%")
		return (str:gsub(safeFind, safeRep))
	end

	local originalData = {}
	local visualConnections = {}
	local watchedTexts = setmetatable({}, { __mode = "k" })
	local replacePairs = {}
	local fakeNames = {}
	local fakeCounter = 0
	local humanoidOriginals = setmetatable({}, { __mode = "k" })
	local isActive = false
	local TEXT_CLASSES = { TextLabel = true, TextBox = true, TextButton = true }
	local scanId = 0
	local function isTextObject(v)
		return TEXT_CLASSES[v.ClassName] == true
	end

	local function isOwnRoot(inst)
		local name = inst.Name
		return string.find(name, "WindUI", 1, true) ~= nil or string.find(name, "Nexvyr", 1, true) ~= nil
	end

	local function isOwnGui(v)
		local parentGui = v:FindFirstAncestorWhichIsA("ScreenGui")
		if parentGui and (string.find(parentGui.Name, "WindUI") or string.find(parentGui.Name, "Nexvyr")) then
			return true
		end

		return false
	end

	local function assignFake(p)
		if not fakeNames[p] then
			fakeCounter += 1
			fakeNames[p] = "OpenHUB-" .. fakeCounter
		end

		return fakeNames[p]
	end

	local function fakeFor(p)
		if #Players:GetPlayers() <= 1 then
			return "#OpenHUB"
		end

		return assignFake(p)
	end

	local function rebuildPairs()
		table.clear(replacePairs)
		local list = Players:GetPlayers()
		if #list > 1 then
			assignFake(player)
		end

		for _, p in ipairs(list) do
			local fake = fakeFor(p)
			if p.Name ~= "" then
				replacePairs[#replacePairs + 1] = { find = p.Name, fake = fake }
			end

			if p.DisplayName ~= "" and p.DisplayName ~= p.Name then
				replacePairs[#replacePairs + 1] = { find = p.DisplayName, fake = fake }
			end
		end

		table.sort(replacePairs, function(a, b)
			return #a.find > #b.find
		end)

		for i, pair in ipairs(replacePairs) do
			pair.token = "\1" .. tostring(i) .. "\2"
		end
	end

	local function applyReplace(text)
		local out = text
		for _, pair in ipairs(replacePairs) do
			out = safeReplace(out, pair.find, pair.token)
		end

		for _, pair in ipairs(replacePairs) do
			out = safeReplace(out, pair.token, pair.fake)
		end

		return out
	end

	local function processText(v, trusted)
		if not isTextObject(v) then
			return
		end

		if not trusted and isOwnGui(v) then
			return
		end

		local data = originalData[v]
		if not data then
			local txt = v.Text
			if not txt or txt == "" then
				return
			end

			local hasName = false
			for _, pair in ipairs(replacePairs) do
				if string.find(txt, pair.find, 1, true) then
					hasName = true
					break
				end
			end

			if not hasName then
				return
			end

			data = { Text = txt, Applied = nil }
			originalData[v] = data
		end

		if isActive then
			local newText = applyReplace(data.Text)
			data.Applied = newText
			if v.Text ~= newText then
				v.Text = newText
			end
		else
			if v.Text ~= data.Text then
				v.Text = data.Text
			end

			originalData[v] = nil
		end
	end

	local function watch(v)
		if watchedTexts[v] or not isTextObject(v) then
			return
		end

		watchedTexts[v] = true
		table.insert(visualConnections, v:GetPropertyChangedSignal("Text"):Connect(function()
			if not isActive then
				return
			end

			local data = originalData[v]
			if data and v.Text == data.Applied then
				return
			end

			originalData[v] = nil
			processText(v)
		end))
	end

	local function fullScan()
		scanId += 1
		local myScan = scanId
		for v in pairs(originalData) do
			if v.Parent then
				processText(v)
			else
				originalData[v] = nil
			end
		end

		local roots = {}
		local pGui = player:FindFirstChild("PlayerGui")
		if pGui then
			for _, child in ipairs(pGui:GetChildren()) do
				if not isOwnRoot(child) then
					roots[#roots + 1] = child
				end
			end
		end

		local okCore, coreGui = pcall(function()
			return game:GetService("CoreGui")
		end)

		if okCore and coreGui then
			local okKids, kids = pcall(function()
				return coreGui:GetChildren()
			end)

			if okKids then
				for _, child in ipairs(kids) do
					if not isOwnRoot(child) then
						roots[#roots + 1] = child
					end
				end
			end
		end

		for _, p in ipairs(Players:GetPlayers()) do
			if p.Character then
				roots[#roots + 1] = p.Character
			end
		end

		local sliceStart = os.clock()
		for _, root in ipairs(roots) do
			local okDesc, descendants = pcall(function()
				return root:GetDescendants()
			end)

			if okDesc then
				for i = 1, #descendants do
					local v = descendants[i]
					if TEXT_CLASSES[v.ClassName] then
						processText(v, true)
						watch(v)
					end

					if os.clock() - sliceStart > 0.006 then
						task.wait()
						if not isActive or myScan ~= scanId then
							return
						end

						sliceStart = os.clock()
					end
				end
			end
		end
	end

	local function quickRefresh()
		scanId += 1
		local myScan = scanId
		local list = {}
		for v in pairs(watchedTexts) do
			list[#list + 1] = v
		end

		local sliceStart = os.clock()
		for i = 1, #list do
			local v = list[i]
			if v.Parent then
				processText(v, true)
			else
				originalData[v] = nil
			end

			if os.clock() - sliceStart > 0.006 then
				task.wait()
				if not isActive or myScan ~= scanId then
					return
				end

				sliceStart = os.clock()
			end
		end
	end

	local function onAdded(obj)
		if not isActive then
			return
		end

		if isTextObject(obj) then
			task.spawn(function()
				if not isActive then
					return
				end

				if isOwnGui(obj) then
					return
				end

				processText(obj, true)
				watch(obj)
			end)
		end
	end

	local function applyHumanoidNames()
		for _, p in ipairs(Players:GetPlayers()) do
			local char = p.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if hum then
				if humanoidOriginals[hum] == nil then
					humanoidOriginals[hum] = hum.DisplayName
				end

				local fake = fakeFor(p)
				if hum.DisplayName ~= fake then
					hum.DisplayName = fake
				end
			end
		end
	end

	local function restoreHumanoidNames()
		for hum, name in pairs(humanoidOriginals) do
			if hum.Parent then
				pcall(function()
					hum.DisplayName = name
				end)
			end
		end

		table.clear(humanoidOriginals)
	end

	local function connectWatchers()
		local pGui = player:FindFirstChild("PlayerGui")
		if pGui then
			table.insert(visualConnections, pGui.DescendantAdded:Connect(onAdded))
		end

		pcall(function()
			local coreGui = game:GetService("CoreGui")
			table.insert(visualConnections, coreGui.DescendantAdded:Connect(onAdded))
		end)

		local function hookCharacter(p)
			table.insert(visualConnections, p.CharacterAdded:Connect(function(char)
				if not isActive then
					return
				end

				local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
				if not hum or not isActive then
					return
				end

				if humanoidOriginals[hum] == nil then
					humanoidOriginals[hum] = hum.DisplayName
				end

				local fake = fakeFor(p)
				if hum.DisplayName ~= fake then
					hum.DisplayName = fake
				end
			end))
		end

		for _, p in ipairs(Players:GetPlayers()) do
			hookCharacter(p)
		end

		local function playersChanged()
			if not isActive then
				return
			end

			rebuildPairs()
			pcall(applyHumanoidNames)
			task.spawn(quickRefresh)
			task.delay(0.5, function()
				if isActive then
					task.spawn(fullScan)
				end
			end)
		end

		table.insert(visualConnections, Players.PlayerAdded:Connect(function(p)
			hookCharacter(p)
			playersChanged()
		end))

		table.insert(visualConnections, Players.PlayerRemoving:Connect(function()
			task.defer(playersChanged)
		end))
	end

	local function startHumanoidLoop()
		task.spawn(function()
			while isActive do
				pcall(applyHumanoidNames)
				task.wait(0.3)
			end
		end)
	end

	function updateSystem()
		if fakeNameEnabled then
			if not isActive then
				isActive = true
				table.clear(fakeNames)
				fakeCounter = 0
				rebuildPairs()
				connectWatchers()
				startHumanoidLoop()
			else
				rebuildPairs()
			end

			task.spawn(fullScan)
		elseif isActive then
			isActive = false
			for _, conn in ipairs(visualConnections) do
				conn:Disconnect()
			end

			visualConnections = {}
			table.clear(watchedTexts)
			for v, data in pairs(originalData) do
				if v and v.Parent and v.Text ~= data.Text then
					pcall(function()
						v.Text = data.Text
					end)
				end
			end

			originalData = {}
			restoreHumanoidNames()
			table.clear(replacePairs)
			table.clear(fakeNames)
			fakeCounter = 0
		end
	end

	UIElements.TogFakeName = Tabs.Identidad:Toggle({
		Title = "Activar Nombre Falso",
		Value = false,
		Callback = function(s)
			fakeNameEnabled = s
			updateSystem()
		end
	})

	persistToggle("TogFakeName", UIElements.TogFakeName, function()
		return fakeNameEnabled
	end)

	player.CharacterAdded:Connect(function()
		if fakeNameEnabled then
			task.wait(1)
			updateSystem()
		end
	end)
end


do
	Tabs.Graficos:Section({ Title = "Presets de Iluminación", Icon = "solar:palette-bold" })
	local gfxActive = {}
	local nocheSangrientaEffects = {}
	local atardecerEffects = {}
	local sinVidaEffects = {}
	local nocheSangrientaSkyFolder = nil
	local function SaveLightingOriginal(tag)
		local Lighting = game:GetService("Lighting")
		if Lighting:GetAttribute("OrigSaved_" .. tag) then
			return
		end

		Lighting:SetAttribute("Orig_Ambient_" .. tag, Lighting.Ambient)
		Lighting:SetAttribute("Orig_OutdoorAmbient_" .. tag, Lighting.OutdoorAmbient)
		Lighting:SetAttribute("Orig_Brightness_" .. tag, Lighting.Brightness)
		Lighting:SetAttribute("Orig_ClockTime_" .. tag, Lighting.ClockTime)
		Lighting:SetAttribute("Orig_FogColor_" .. tag, Lighting.FogColor)
		Lighting:SetAttribute("Orig_FogEnd_" .. tag, Lighting.FogEnd)
		Lighting:SetAttribute("Orig_FogStart_" .. tag, Lighting.FogStart)
		Lighting:SetAttribute("Orig_ColorShift_Top_" .. tag, Lighting.ColorShift_Top)
		Lighting:SetAttribute("Orig_ColorShift_Bottom_" .. tag, Lighting.ColorShift_Bottom)
		Lighting:SetAttribute("Orig_ExposureCompensation_" .. tag, Lighting.ExposureCompensation)
		Lighting:SetAttribute("Orig_GlobalShadows_" .. tag, Lighting.GlobalShadows)
		Lighting:SetAttribute("Orig_EnvironmentDiffuseScale_" .. tag, Lighting.EnvironmentDiffuseScale)
		Lighting:SetAttribute("Orig_EnvironmentSpecularScale_" .. tag, Lighting.EnvironmentSpecularScale)
		Lighting:SetAttribute("OrigSaved_" .. tag, true)
	end

	local function RestoreLighting(tag)
		local Lighting = game:GetService("Lighting")
		if not Lighting:GetAttribute("OrigSaved_" .. tag) then
			return
		end

		Lighting.Ambient = Lighting:GetAttribute("Orig_Ambient_" .. tag)
		Lighting.OutdoorAmbient = Lighting:GetAttribute("Orig_OutdoorAmbient_" .. tag)
		Lighting.Brightness = Lighting:GetAttribute("Orig_Brightness_" .. tag)
		Lighting.ClockTime = Lighting:GetAttribute("Orig_ClockTime_" .. tag)
		Lighting.FogColor = Lighting:GetAttribute("Orig_FogColor_" .. tag)
		Lighting.FogEnd = Lighting:GetAttribute("Orig_FogEnd_" .. tag)
		Lighting.FogStart = Lighting:GetAttribute("Orig_FogStart_" .. tag)
		Lighting.ColorShift_Top = Lighting:GetAttribute("Orig_ColorShift_Top_" .. tag)
		Lighting.ColorShift_Bottom = Lighting:GetAttribute("Orig_ColorShift_Bottom_" .. tag)
		Lighting.ExposureCompensation = Lighting:GetAttribute("Orig_ExposureCompensation_" .. tag)
		Lighting.GlobalShadows = Lighting:GetAttribute("Orig_GlobalShadows_" .. tag)
		Lighting.EnvironmentDiffuseScale = Lighting:GetAttribute("Orig_EnvironmentDiffuseScale_" .. tag)
		Lighting.EnvironmentSpecularScale = Lighting:GetAttribute("Orig_EnvironmentSpecularScale_" .. tag)
		Lighting:SetAttribute("OrigSaved_" .. tag, nil)
	end

	local function ClearEffects(list)
		for _, v in ipairs(list) do
			pcall(function()
				v:Destroy()
			end)
		end

		table.clear(list)
	end

	local function ApplyNocheSangrienta(state)
		local Lighting = game:GetService("Lighting")
		if state then
			SaveLightingOriginal("NS")
			ClearEffects(nocheSangrientaEffects)
			if nocheSangrientaSkyFolder then
				nocheSangrientaSkyFolder:Destroy()
			end

			nocheSangrientaSkyFolder = Instance.new("Folder")
			nocheSangrientaSkyFolder.Name = "NS_SkyX"
			nocheSangrientaSkyFolder.Parent = workspace
			local function makeBeam(angle)
				local beam = Instance.new("Part")
				beam.Anchored = true
				beam.CanCollide = false
				beam.CanQuery = false
				beam.Material = Enum.Material.Neon
				beam.Color = Color3.fromRGB(255, 55, 55)
				beam.Transparency = 0.1
				beam.Size = Vector3.new(2600, 26, 26)
				beam.CFrame = CFrame.new(0, 3200, -2200) * CFrame.Angles(0, 0, math.rad(angle))
				beam.Parent = nocheSangrientaSkyFolder
				table.insert(nocheSangrientaEffects, beam)
			end

			makeBeam(45)
			makeBeam(-45)
			local glowPart = Instance.new("Part")
			glowPart.Anchored = true
			glowPart.CanCollide = false
			glowPart.CanQuery = false
			glowPart.Material = Enum.Material.Neon
			glowPart.Color = Color3.fromRGB(255, 110, 110)
			glowPart.Transparency = 0.65
			glowPart.Shape = Enum.PartType.Ball
			glowPart.Size = Vector3.new(420, 420, 420)
			glowPart.CFrame = CFrame.new(0, 3200, -2200)
			glowPart.Parent = nocheSangrientaSkyFolder
			table.insert(nocheSangrientaEffects, glowPart)
			local light1 = Instance.new("PointLight")
			light1.Color = Color3.fromRGB(255, 80, 80)
			light1.Range = 300
			light1.Brightness = 3
			light1.Parent = glowPart
			table.insert(nocheSangrientaEffects, light1)
			local sky = Instance.new("Sky")
			sky.Name = "NS_Sky"
			sky.StarCount = 9000
			sky.MoonAngularSize = 30
			sky.SunAngularSize = 0
			sky.CelestialBodiesShown = true
			sky.Parent = Lighting
			table.insert(nocheSangrientaEffects, sky)
			local cc = Instance.new("ColorCorrectionEffect")
			cc.Name = "NS_CC"
			cc.Brightness = 0.05
			cc.Contrast = 0.32
			cc.Saturation = -0.15
			cc.TintColor = Color3.fromRGB(255, 130, 130)
			cc.Parent = Lighting
			table.insert(nocheSangrientaEffects, cc)
			local bloom = Instance.new("BloomEffect")
			bloom.Name = "NS_Bloom"
			bloom.Intensity = 1
			bloom.Size = 90
			bloom.Threshold = 0.45
			bloom.Parent = Lighting
			table.insert(nocheSangrientaEffects, bloom)
			local blur = Instance.new("BlurEffect")
			blur.Name = "NS_Blur"
			blur.Size = 3
			blur.Parent = Lighting
			table.insert(nocheSangrientaEffects, blur)
			local atmo = Instance.new("Atmosphere")
			atmo.Name = "NS_Atmo"
			atmo.Density = 0.42
			atmo.Offset = 0
			atmo.Color = Color3.fromRGB(60, 12, 12)
			atmo.Decay = Color3.fromRGB(80, 20, 20)
			atmo.Glare = 0.5
			atmo.Haze = 1.6
			atmo.Parent = Lighting
			table.insert(nocheSangrientaEffects, atmo)
			Lighting.ClockTime = 0
			Lighting.Brightness = 1.2
			Lighting.Ambient = Color3.fromRGB(130, 110, 110)
			Lighting.OutdoorAmbient = Color3.fromRGB(180, 140, 140)
			Lighting.FogColor = Color3.fromRGB(22, 5, 5)
			Lighting.FogEnd = 1200
			Lighting.FogStart = 150
			Lighting.ColorShift_Top = Color3.fromRGB(125, 25, 25)
			Lighting.ColorShift_Bottom = Color3.fromRGB(65, 8, 8)
			Lighting.ExposureCompensation = -0.2
			Lighting.GlobalShadows = true
			Lighting.EnvironmentDiffuseScale = 0.5
			Lighting.EnvironmentSpecularScale = 0.5
		else
			ClearEffects(nocheSangrientaEffects)
			if nocheSangrientaSkyFolder then
				nocheSangrientaSkyFolder:Destroy()
				nocheSangrientaSkyFolder = nil
			end

			RestoreLighting("NS")
		end
	end

	local function ApplyAtardecer(state)
		local Lighting = game:GetService("Lighting")
		if state then
			SaveLightingOriginal("AF")
			ClearEffects(atardecerEffects)
			local cc = Instance.new("ColorCorrectionEffect")
			cc.Name = "AF_CC"
			cc.Brightness = 0.05
			cc.Contrast = 0.14
			cc.Saturation = 0.22
			cc.TintColor = Color3.fromRGB(255, 205, 165)
			cc.Parent = Lighting
			table.insert(atardecerEffects, cc)
			local bloom = Instance.new("BloomEffect")
			bloom.Name = "AF_Bloom"
			bloom.Intensity = 0.32
			bloom.Size = 40
			bloom.Threshold = 0.92
			bloom.Parent = Lighting
			table.insert(atardecerEffects, bloom)
			local rays = Instance.new("SunRaysEffect")
			rays.Name = "AF_Rays"
			rays.Intensity = 0.15
			rays.Spread = 0.9
			rays.Parent = Lighting
			table.insert(atardecerEffects, rays)
			local sky = Instance.new("Sky")
			sky.Name = "AF_Sky"
			sky.SunAngularSize = 18
			sky.MoonAngularSize = 0
			sky.StarCount = 2000
			sky.Parent = Lighting
			table.insert(atardecerEffects, sky)
			local atmo = Instance.new("Atmosphere")
			atmo.Name = "AF_Atmo"
			atmo.Density = 0.36
			atmo.Offset = 0.1
			atmo.Color = Color3.fromRGB(255, 185, 135)
			atmo.Decay = Color3.fromRGB(255, 125, 85)
			atmo.Glare = 0.2
			atmo.Haze = 1.2
			atmo.Parent = Lighting
			table.insert(atardecerEffects, atmo)
			Lighting.ClockTime = 6.3
			Lighting.Brightness = 2.4
			Lighting.Ambient = Color3.fromRGB(85, 62, 55)
			Lighting.OutdoorAmbient = Color3.fromRGB(125, 92, 80)
			Lighting.FogColor = Color3.fromRGB(240, 185, 145)
			Lighting.FogEnd = 2500
			Lighting.FogStart = 200
			Lighting.ColorShift_Top = Color3.fromRGB(255, 185, 105)
			Lighting.ColorShift_Bottom = Color3.fromRGB(205, 105, 85)
			Lighting.ExposureCompensation = 0.08
			Lighting.GlobalShadows = true
			Lighting.EnvironmentDiffuseScale = 0.8
			Lighting.EnvironmentSpecularScale = 0.6
		else
			ClearEffects(atardecerEffects)
			RestoreLighting("AF")
		end
	end

	local function ApplySinVida(state)
		local Lighting = game:GetService("Lighting")
		if state then
			SaveLightingOriginal("SV")
			ClearEffects(sinVidaEffects)
			local cc = Instance.new("ColorCorrectionEffect")
			cc.Name = "SV_CC"
			cc.Brightness = 0.05
			cc.Contrast = 0.22
			cc.Saturation = -1
			cc.TintColor = Color3.fromRGB(222, 226, 232)
			cc.Parent = Lighting
			table.insert(sinVidaEffects, cc)
			local bloom = Instance.new("BloomEffect")
			bloom.Name = "SV_Bloom"
			bloom.Intensity = 1.25
			bloom.Size = 75
			bloom.Threshold = 0.38
			bloom.Parent = Lighting
			table.insert(sinVidaEffects, bloom)
			local sky = Instance.new("Sky")
			sky.Name = "SV_Sky"
			sky.StarCount = 0
			sky.SunAngularSize = 0
			sky.MoonAngularSize = 0
			sky.CelestialBodiesShown = false
			sky.Parent = Lighting
			table.insert(sinVidaEffects, sky)
			local atmo = Instance.new("Atmosphere")
			atmo.Name = "SV_Atmo"
			atmo.Density = 0.3
			atmo.Offset = 0.1
			atmo.Color = Color3.fromRGB(180, 185, 190)
			atmo.Decay = Color3.fromRGB(140, 145, 150)
			atmo.Glare = 0
			atmo.Haze = 1.0
			atmo.Parent = Lighting
			table.insert(sinVidaEffects, atmo)
			Lighting.ClockTime = 14
			Lighting.Brightness = 2.2
			Lighting.Ambient = Color3.fromRGB(92, 96, 100)
			Lighting.OutdoorAmbient = Color3.fromRGB(132, 136, 140)
			Lighting.FogColor = Color3.fromRGB(172, 176, 180)
			Lighting.FogEnd = 3000
			Lighting.FogStart = 200
			Lighting.ColorShift_Top = Color3.fromRGB(152, 156, 160)
			Lighting.ColorShift_Bottom = Color3.fromRGB(122, 126, 130)
			Lighting.ExposureCompensation = 0
			Lighting.GlobalShadows = true
			Lighting.EnvironmentDiffuseScale = 0.6
			Lighting.EnvironmentSpecularScale = 0.3
		else
			ClearEffects(sinVidaEffects)
			RestoreLighting("SV")
		end
	end

	local elFinalEffects = {}
	local elFinalClouds = nil
	local elFinalQuality = nil
	local elFinalTech = nil
	local function ApplyElFinal(state)
		local Lighting = game:GetService("Lighting")
		local terrain = workspace:FindFirstChildOfClass("Terrain")
		if state then
			SaveLightingOriginal("EF")
			if Lighting:GetAttribute("Orig_ShadowSoftness_EF") == nil then
				pcall(function()
					Lighting:SetAttribute("Orig_ShadowSoftness_EF", Lighting.ShadowSoftness)
				end)
			end

			ClearEffects(elFinalEffects)
			local function add(inst)
				inst.Parent = Lighting
				table.insert(elFinalEffects, inst)
				return inst
			end

			local cc = Instance.new("ColorCorrectionEffect")
			cc.Name = "EF_CC"
			cc.Brightness = -0.01
			cc.Contrast = 0.4
			cc.Saturation = 0.14
			cc.TintColor = Color3.fromRGB(255, 238, 220)
			add(cc)
			local bloom = Instance.new("BloomEffect")
			bloom.Name = "EF_Bloom"
			bloom.Intensity = 0.55
			bloom.Size = 28
			bloom.Threshold = 0.9
			add(bloom)
			local rays = Instance.new("SunRaysEffect")
			rays.Name = "EF_Rays"
			rays.Intensity = 0.3
			rays.Spread = 1
			add(rays)
			local sky = Instance.new("Sky")
			sky.Name = "EF_Sky"
			sky.SunAngularSize = 24
			sky.MoonAngularSize = 11
			sky.StarCount = 3000
			sky.CelestialBodiesShown = true
			add(sky)
			local atmo = Instance.new("Atmosphere")
			atmo.Name = "EF_Atmo"
			atmo.Density = 0.32
			atmo.Offset = 0.2
			atmo.Color = Color3.fromRGB(198, 172, 150)
			atmo.Decay = Color3.fromRGB(92, 70, 80)
			atmo.Glare = 0.7
			atmo.Haze = 1.9
			add(atmo)
			if terrain then
				local clouds = terrain:FindFirstChildOfClass("Clouds")
				if clouds then
					elFinalClouds = {
						obj = clouds,
						Enabled = clouds.Enabled,
						Cover = clouds.Cover,
						Density = clouds.Density,
						Color = clouds.Color
					}
				else
					clouds = Instance.new("Clouds")
					clouds.Parent = terrain
					elFinalClouds = { created = clouds }
				end

				clouds.Enabled = true
				clouds.Cover = 0.78
				clouds.Density = 0.72
				clouds.Color = Color3.fromRGB(70, 62, 72)
			end

			Lighting.ClockTime = 17.3
			Lighting.Brightness = 3.4
			Lighting.Ambient = Color3.fromRGB(38, 42, 62)
			Lighting.OutdoorAmbient = Color3.fromRGB(78, 82, 108)
			Lighting.ColorShift_Top = Color3.fromRGB(255, 196, 120)
			Lighting.ColorShift_Bottom = Color3.fromRGB(30, 34, 56)
			Lighting.ExposureCompensation = 0.15
			Lighting.FogColor = Color3.fromRGB(52, 48, 60)
			Lighting.FogStart = 250
			Lighting.FogEnd = 2600
			Lighting.GlobalShadows = true
			Lighting.EnvironmentDiffuseScale = 0.9
			Lighting.EnvironmentSpecularScale = 1
			pcall(function()
				Lighting.ShadowSoftness = 0.03
			end)

			pcall(function()
				if gethiddenproperty and sethiddenproperty then
					if elFinalTech == nil then
						elFinalTech = gethiddenproperty(Lighting, "Technology")
					end

					sethiddenproperty(Lighting, "Technology", Enum.Technology.Future)
				end
			end)

			pcall(function()
				local r = settings().Rendering
				if elFinalQuality == nil then
					elFinalQuality = r.QualityLevel
				end

				r.QualityLevel = Enum.QualityLevel.Level21
			end)
		else
			ClearEffects(elFinalEffects)
			if elFinalClouds then
				pcall(function()
					if elFinalClouds.created then
						elFinalClouds.created:Destroy()
					elseif elFinalClouds.obj then
						local o = elFinalClouds.obj
						o.Enabled = elFinalClouds.Enabled
						o.Cover = elFinalClouds.Cover
						o.Density = elFinalClouds.Density
						o.Color = elFinalClouds.Color
					end
				end)

				elFinalClouds = nil
			end

			RestoreLighting("EF")
			local softness = Lighting:GetAttribute("Orig_ShadowSoftness_EF")
			if softness ~= nil then
				pcall(function()
					Lighting.ShadowSoftness = softness
				end)

				Lighting:SetAttribute("Orig_ShadowSoftness_EF", nil)
			end

			if elFinalTech ~= nil then
				pcall(function()
					if sethiddenproperty then
						sethiddenproperty(Lighting, "Technology", elFinalTech)
					end
				end)

				elFinalTech = nil
			end

			if elFinalQuality ~= nil then
				pcall(function()
					settings().Rendering.QualityLevel = elFinalQuality
				end)

				elFinalQuality = nil
			end
		end
	end

	local skypeEffects = {}
	local skypeStash = {}
	local skypeClouds = nil
	local skypeWater = nil
	local skypeQuality = nil
	local skypeTech = nil
	local function ApplySkype(state)
		local Lighting = game:GetService("Lighting")
		local terrain = workspace:FindFirstChildOfClass("Terrain")
		if state then
			SaveLightingOriginal("SK")
			if Lighting:GetAttribute("Orig_ShadowSoftness_SK") == nil then
				pcall(function()
					Lighting:SetAttribute("Orig_ShadowSoftness_SK", Lighting.ShadowSoftness)
				end)
			end

			ClearEffects(skypeEffects)
			table.clear(skypeStash)
			for _, child in ipairs(Lighting:GetChildren()) do
				if child:IsA("Sky") or child:IsA("Atmosphere") then
					table.insert(skypeStash, child)
				end
			end

			for _, inst in ipairs(skypeStash) do
				pcall(function()
					inst.Parent = nil
				end)
			end

			local function add(inst)
				inst.Parent = Lighting
				table.insert(skypeEffects, inst)
				return inst
			end

			local sky = Instance.new("Sky")
			sky.Name = "SK_Sky"
			sky.SunAngularSize = 21
			sky.MoonAngularSize = 11
			sky.StarCount = 3000
			sky.CelestialBodiesShown = true
			add(sky)
			local atmo = Instance.new("Atmosphere")
			atmo.Name = "SK_Atmo"
			atmo.Density = 0.34
			atmo.Offset = 0.25
			atmo.Color = Color3.fromRGB(170, 197, 232)
			atmo.Decay = Color3.fromRGB(255, 196, 148)
			atmo.Glare = 0.45
			atmo.Haze = 1.8
			add(atmo)
			local cc = Instance.new("ColorCorrectionEffect")
			cc.Name = "SK_CC"
			cc.Brightness = 0
			cc.Contrast = 0.2
			cc.Saturation = 0.28
			cc.TintColor = Color3.fromRGB(255, 249, 242)
			add(cc)
			local bloom = Instance.new("BloomEffect")
			bloom.Name = "SK_Bloom"
			bloom.Intensity = 0.45
			bloom.Size = 36
			bloom.Threshold = 0.95
			add(bloom)
			local rays = Instance.new("SunRaysEffect")
			rays.Name = "SK_Rays"
			rays.Intensity = 0.2
			rays.Spread = 0.85
			add(rays)
			local dof = Instance.new("DepthOfFieldEffect")
			dof.Name = "SK_DOF"
			dof.FarIntensity = 0.12
			dof.NearIntensity = 0
			dof.FocusDistance = 120
			dof.InFocusRadius = 90
			add(dof)
			if terrain then
				local clouds = terrain:FindFirstChildOfClass("Clouds")
				if clouds then
					skypeClouds = {
						obj = clouds,
						Enabled = clouds.Enabled,
						Cover = clouds.Cover,
						Density = clouds.Density,
						Color = clouds.Color
					}
				else
					clouds = Instance.new("Clouds")
					clouds.Parent = terrain
					skypeClouds = { created = clouds }
				end

				clouds.Enabled = true
				clouds.Cover = 0.6
				clouds.Density = 0.65
				clouds.Color = Color3.fromRGB(255, 255, 255)
				if not skypeWater then
					skypeWater = {
						WaterColor = terrain.WaterColor,
						WaterReflectance = terrain.WaterReflectance,
						WaterTransparency = terrain.WaterTransparency,
						WaterWaveSize = terrain.WaterWaveSize,
						WaterWaveSpeed = terrain.WaterWaveSpeed,
					}
				end

				pcall(function()
					terrain.WaterColor = Color3.fromRGB(28, 128, 158)
					terrain.WaterReflectance = 0.9
					terrain.WaterTransparency = 0.85
					terrain.WaterWaveSize = 0.35
					terrain.WaterWaveSpeed = 14
				end)
			end

			Lighting.ClockTime = 16.2
			Lighting.Brightness = 3
			Lighting.Ambient = Color3.fromRGB(70, 76, 98)
			Lighting.OutdoorAmbient = Color3.fromRGB(112, 122, 148)
			Lighting.ColorShift_Top = Color3.fromRGB(255, 236, 205)
			Lighting.ColorShift_Bottom = Color3.fromRGB(60, 70, 100)
			Lighting.ExposureCompensation = 0.2
			Lighting.FogColor = Color3.fromRGB(190, 205, 226)
			Lighting.FogStart = 400
			Lighting.FogEnd = 4500
			Lighting.GlobalShadows = true
			Lighting.EnvironmentDiffuseScale = 1
			Lighting.EnvironmentSpecularScale = 1
			pcall(function()
				Lighting.ShadowSoftness = 0.12
			end)

			pcall(function()
				if gethiddenproperty and sethiddenproperty then
					if skypeTech == nil then
						skypeTech = gethiddenproperty(Lighting, "Technology")
					end

					sethiddenproperty(Lighting, "Technology", Enum.Technology.Future)
				end
			end)

			pcall(function()
				local r = settings().Rendering
				if skypeQuality == nil then
					skypeQuality = r.QualityLevel
				end

				r.QualityLevel = Enum.QualityLevel.Level21
			end)
		else
			ClearEffects(skypeEffects)
			for _, inst in ipairs(skypeStash) do
				pcall(function()
					inst.Parent = Lighting
				end)
			end

			table.clear(skypeStash)
			if skypeClouds then
				pcall(function()
					if skypeClouds.created then
						skypeClouds.created:Destroy()
					elseif skypeClouds.obj then
						local o = skypeClouds.obj
						o.Enabled = skypeClouds.Enabled
						o.Cover = skypeClouds.Cover
						o.Density = skypeClouds.Density
						o.Color = skypeClouds.Color
					end
				end)

				skypeClouds = nil
			end

			if skypeWater and terrain then
				pcall(function()
					for k, v in pairs(skypeWater) do
						terrain[k] = v
					end
				end)

				skypeWater = nil
			end

			RestoreLighting("SK")
			local softness = Lighting:GetAttribute("Orig_ShadowSoftness_SK")
			if softness ~= nil then
				pcall(function()
					Lighting.ShadowSoftness = softness
				end)

				Lighting:SetAttribute("Orig_ShadowSoftness_SK", nil)
			end

			if skypeTech ~= nil then
				pcall(function()
					if sethiddenproperty then
						sethiddenproperty(Lighting, "Technology", skypeTech)
					end
				end)

				skypeTech = nil
			end

			if skypeQuality ~= nil then
				pcall(function()
					settings().Rendering.QualityLevel = skypeQuality
				end)

				skypeQuality = nil
			end
		end
	end

	local nocheTog, atardecerTog, sinVidaTog, finalTog, skypeTog
	nocheTog = Tabs.Graficos:Toggle({
		Title = "Noche Sangrienta",
		Value = false,
		Callback = function(state)
			gfxActive.Noche = state
			if state then
				if atardecerTog then
					pcall(function()
						atardecerTog:Set(false)
					end)
				end

				if sinVidaTog then
					pcall(function()
						sinVidaTog:Set(false)
					end)
				end

				if finalTog then
					pcall(function()
						finalTog:Set(false)
					end)
				end

				if skypeTog then
					pcall(function()
						skypeTog:Set(false)
					end)
				end
			end

			ApplyNocheSangrienta(state)
		end
	})

	atardecerTog = Tabs.Graficos:Toggle({
		Title = "Atardecer Fantástico",
		Value = false,
		Callback = function(state)
			gfxActive.Atardecer = state
			if state then
				if nocheTog then
					pcall(function()
						nocheTog:Set(false)
					end)
				end

				if sinVidaTog then
					pcall(function()
						sinVidaTog:Set(false)
					end)
				end

				if finalTog then
					pcall(function()
						finalTog:Set(false)
					end)
				end

				if skypeTog then
					pcall(function()
						skypeTog:Set(false)
					end)
				end
			end

			ApplyAtardecer(state)
		end
	})

	sinVidaTog = Tabs.Graficos:Toggle({
		Title = "Sin Vida",
		Value = false,
		Callback = function(state)
			gfxActive.SinVida = state
			if state then
				if nocheTog then
					pcall(function()
						nocheTog:Set(false)
					end)
				end

				if atardecerTog then
					pcall(function()
						atardecerTog:Set(false)
					end)
				end

				if finalTog then
					pcall(function()
						finalTog:Set(false)
					end)
				end

				if skypeTog then
					pcall(function()
						skypeTog:Set(false)
					end)
				end
			end

			ApplySinVida(state)
		end
	})

	finalTog = Tabs.Graficos:Toggle({
		Title = "El final",
		Value = false,
		Callback = function(state)
			gfxActive.Final = state
			if state then
				if nocheTog then
					pcall(function()
						nocheTog:Set(false)
					end)
				end

				if atardecerTog then
					pcall(function()
						atardecerTog:Set(false)
					end)
				end

				if sinVidaTog then
					pcall(function()
						sinVidaTog:Set(false)
					end)
				end

				if skypeTog then
					pcall(function()
						skypeTog:Set(false)
					end)
				end
			end

			ApplyElFinal(state)
		end
	})

	skypeTog = Tabs.Graficos:Toggle({
		Title = "skype",
		Value = false,
		Callback = function(state)
			gfxActive.Skype = state
			if state then
				if nocheTog then
					pcall(function()
						nocheTog:Set(false)
					end)
				end

				if atardecerTog then
					pcall(function()
						atardecerTog:Set(false)
					end)
				end

				if sinVidaTog then
					pcall(function()
						sinVidaTog:Set(false)
					end)
				end

				if finalTog then
					pcall(function()
						finalTog:Set(false)
					end)
				end
			end

			ApplySkype(state)
		end
	})

	persistToggle("GfxNoche", nocheTog, function()
		return gfxActive.Noche == true
	end)

	persistToggle("GfxAtardecer", atardecerTog, function()
		return gfxActive.Atardecer == true
	end)

	persistToggle("GfxSinVida", sinVidaTog, function()
		return gfxActive.SinVida == true
	end)

	persistToggle("GfxFinal", finalTog, function()
		return gfxActive.Final == true
	end)

	persistToggle("GfxSkype", skypeTog, function()
		return gfxActive.Skype == true
	end)
end


do
	local TweenService = game:GetService("TweenService")
	local emoteSpamEnabled = false
	local emoteSpamSelected = nil
	local emoteSpamRunning = false
	local EMOTE_SPAM_INTERVAL = 0.2
	local function listarEmotes()
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if not hum then
			return {}
		end

		local ok, desc = pcall(function()
			return hum:GetAppliedDescription()
		end)

		if not ok or not desc then
			return {}
		end

		local names, seen = {}, {}
		local okEq, equipped = pcall(function()
			return desc:GetEquippedEmotes()
		end)

		if okEq and equipped then
			table.sort(equipped, function(a, b)
				return a.Slot < b.Slot
			end)

			for _, e in ipairs(equipped) do
				if not seen[e.Name] then
					seen[e.Name] = true;
					names[#names + 1] = e.Name
				end
			end
		end

		local okAll, all = pcall(function()
			return desc:GetEmotes()
		end)

		if okAll and all then
			local rest = {}
			for name in pairs(all) do
				if not seen[name] then
					rest[#rest + 1] = name
				end
			end

			table.sort(rest)
			for _, n in ipairs(rest) do
				names[#names + 1] = n
			end
		end

		return names
	end

	local function detenerEmote()
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if not hum then
			return
		end

		local animator = hum:FindFirstChildOfClass("Animator")
		local animate = char:FindFirstChild("Animate")
		local base = {}
		if animate then
			for _, d in ipairs(animate:GetDescendants()) do
				if d:IsA("Animation") then
					base[d.AnimationId] = true
				end
			end
		end

		local function addTool(tool)
			for _, d in ipairs(tool:GetDescendants()) do
				if d:IsA("Animation") then
					base[d.AnimationId] = true
				end
			end
		end

		for _, child in ipairs(char:GetChildren()) do
			if child:IsA("Tool") then
				addTool(child)
			end
		end

		local backpack = player:FindFirstChildOfClass("Backpack")
		if backpack then
			for _, child in ipairs(backpack:GetChildren()) do
				if child:IsA("Tool") then
					addTool(child)
				end
			end
		end

		if animator then
			for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
				local anim = track.Animation
				if not (anim and base[anim.AnimationId]) then
					pcall(function()
						track:Stop(0.1)
					end)
				end
			end
		end

		if animate and not animacionActualActiva then
			task.spawn(function()
				pcall(function()
					animate.Disabled = true
					task.wait()
					animate.Disabled = false
				end)
			end)
		end
	end

	local function iniciarEmoteSpam()
		if emoteSpamRunning or not emoteSpamEnabled then
			return
		end

		emoteSpamRunning = true
		task.spawn(function()
			while emoteSpamEnabled do
				local char = player.Character
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				local sel = emoteSpamSelected
				if hum and hum.Health > 0 and sel then
					pcall(function()
						hum:PlayEmote(sel.Name)
					end)
				end

				task.wait(EMOTE_SPAM_INTERVAL)
			end

			emoteSpamRunning = false
		end)
	end

	local function setEmoteSpam(state)
		emoteSpamEnabled = state
		if state then
			iniciarEmoteSpam()
		else
			detenerEmote()
		end
	end

	local BTN_SIZE = 56
	local GREEN = Color3.fromRGB(144, 238, 144)
	local ICON_OFF = Color3.fromRGB(235, 235, 245)
	local BG_OFF = Color3.fromRGB(18, 18, 26)
	local BG_ON = Color3.fromRGB(20, 40, 30)
	local TI = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local floatGui = Instance.new("ScreenGui")
	floatGui.Name = "NexvyrHub_FloatingButtons"
	floatGui.ResetOnSpawn = false
	floatGui.IgnoreGuiInset = true
	floatGui.DisplayOrder = 1000
	floatGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	floatGui.Enabled = false
	floatGui.Parent = player:WaitForChild("PlayerGui")
	local function tween(obj, props, info)
		TweenService:Create(obj, info or TI, props):Play()
	end

	local function viewport()
		local vp = floatGui.AbsoluteSize
		if vp.X < 10 then
			local cam = workspace.CurrentCamera
			vp = cam and cam.ViewportSize or Vector2.new(800, 600)
		end

		return vp
	end

	local function clampPos(x, y)
		local vp = viewport()
		return math.clamp(x, 0, math.max(0, vp.X - BTN_SIZE)), math.clamp(y, 0, math.max(0, vp.Y - BTN_SIZE))
	end

	local function makeIconKit(holder, paints)
		local function F(x, y, w, h, round, noPaint)
			local f = Instance.new("Frame")
			f.BorderSizePixel = 0
			f.BackgroundColor3 = ICON_OFF
			f.Position = UDim2.fromOffset(x, y)
			f.Size = UDim2.fromOffset(w, h)
			if round then
				local c = Instance.new("UICorner")
				c.CornerRadius = round == true and UDim.new(1, 0) or UDim.new(0, round)
				c.Parent = f
			end

			f.Parent = holder
			if not noPaint then
				paints[#paints + 1] = { f, "BackgroundColor3" }
			end

			return f
		end

		local function R(x, y, w, h, thick)
			local f = Instance.new("Frame")
			f.BorderSizePixel = 0
			f.BackgroundTransparency = 1
			f.Position = UDim2.fromOffset(x, y)
			f.Size = UDim2.fromOffset(w, h)
			local c = Instance.new("UICorner")
			c.CornerRadius = UDim.new(1, 0)
			c.Parent = f
			local s = Instance.new("UIStroke")
			s.Color = ICON_OFF
			s.Thickness = thick
			s.Parent = f
			f.Parent = holder
			paints[#paints + 1] = { s, "Color" }
			return f
		end

		return F, R
	end

	local Icons = {
		ESP = function(F, R)
			R(0, 6, 30, 18, 2.2)
			F(11, 11, 8, 8, true)
		end,
		AutoShoot = function(F, R)
			R(5, 5, 20, 20, 2)
			F(14, 0, 2, 8)
			F(14, 22, 2, 8)
			F(0, 14, 8, 2)
			F(22, 14, 8, 2)
			F(13.5, 13.5, 3, 3, true)
		end,
		SilentAim = function(F, R)
			R(1, 1, 28, 28, 2)
			R(8, 8, 14, 14, 2)
			F(12.5, 12.5, 5, 5, true)
			local l = F(0, 0, 2.4, 16)
			l.AnchorPoint = Vector2.new(0.5, 0.5)
			l.Position = UDim2.fromOffset(22, 8)
			l.Rotation = 45
		end,
		Invisible = function(F, R)
			F(5, 3, 20, 20, true)
			F(5, 13, 20, 9)
			F(5, 18, 6.6, 6.6, true)
			F(11.7, 18, 6.6, 6.6, true)
			F(18.4, 18, 6.6, 6.6, true)
			local e1 = F(10, 10, 3, 5, true, true)
			local e2 = F(17, 10, 3, 5, true, true)
			e1.BackgroundColor3 = BG_OFF
			e2.BackgroundColor3 = BG_OFF
		end,
		Emote = function(F, R)
			F(10, 1, 10, 10, true)
			F(5, 14, 20, 15, 7)
		end,
	}
	local defs = {
		{
			Name = "ESP",
			Ui = "TogEsp",
			Get = function()
				return espEnabled
			end
		}, {
		Name = "AutoShoot",
		Ui = "TogAutoShootAgr",
		Get = function()
			return autoShootAgresivoEnabled
		end
	}, {
		Name = "SilentAim",
		Ui = "TogSilentAimManual",
		Get = function()
			return silentAimManualEnabled
		end
	}, {
		Name = "Invisible",
		Ui = "TogInvisible",
		Get = function()
			return InvisibilityActive
		end
	}, }

	local buttons = {}
	local function createButton(def, index, parent)
		local btn = Instance.new("TextButton")
		btn.Name = def.Name
		btn.Text = ""
		btn.AutoButtonColor = false
		btn.Active = true
		btn.BorderSizePixel = 0
		btn.BackgroundColor3 = BG_OFF
		btn.BackgroundTransparency = 0.12
		btn.Size = UDim2.fromOffset(BTN_SIZE, BTN_SIZE)
		btn.Parent = parent or floatGui
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 16)
		corner.Parent = btn
		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.new(1, 1, 1)
		stroke.Transparency = 0.75
		stroke.Thickness = 1.5
		stroke.Parent = btn
		local scale = Instance.new("UIScale")
		scale.Scale = 1
		scale.Parent = btn
		local holder = Instance.new("Frame")
		holder.BackgroundTransparency = 1
		holder.AnchorPoint = Vector2.new(0.5, 0.5)
		holder.Position = UDim2.fromScale(0.5, 0.5)
		holder.Size = UDim2.fromOffset(30, 30)
		holder.Parent = btn
		local paints = {}
		local onColor = def.OnColor or GREEN
		local offColor = def.OffColor or ICON_OFF
		local bgOn = def.BgOn or BG_ON
		local F, R = makeIconKit(holder, paints)
		Icons[def.Name](F, R)
		local function homePos()
			local vp = viewport()
			return clampPos(vp.X - BTN_SIZE - 16, vp.Y * 0.28 + (index - 1) * (BTN_SIZE + 10))
		end

		local function goHome()
			local x, y = homePos()
			btn.Position = UDim2.fromOffset(x, y)
		end

		goHome()
		local isOn = nil
		local function setVisual(on, instant)
			if isOn == on then
				return
			end

			local first = isOn == nil
			isOn = on
			local info = (instant or first) and TweenInfo.new(0) or TI
			tween(btn, { BackgroundColor3 = on and bgOn or BG_OFF, BackgroundTransparency = on and 0.05 or 0.12 }, info)
			tween(stroke, {
				Color = on and onColor or Color3.new(1, 1, 1),
				Transparency = on and 0 or 0.75,
				Thickness = on and 2.5 or 1.5
			}, info)

			for _, p in ipairs(paints) do
				tween(p[1], { [p[2]] = on and onColor or offColor }, info)
			end

			if not instant and not first then
				tween(scale, { Scale = 1.14 }, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
				task.delay(0.1, function()
					tween(scale, { Scale = 1 }, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
				end)
			end
		end

		local dragging, moved = false, false
		local dragInput, startMouse, startPos
		btn.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			dragging, moved = true, false
			dragInput = input
			startMouse = Vector2.new(input.Position.X, input.Position.Y)
			startPos = Vector2.new(btn.Position.X.Offset, btn.Position.Y.Offset)
			tween(scale, { Scale = 0.9 }, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
		end)

		UserInputService.InputChanged:Connect(function(input)
			if not dragging then
				return
			end

			if input ~= dragInput and input.UserInputType ~= Enum.UserInputType.MouseMovement then
				return
			end

			local delta = Vector2.new(input.Position.X, input.Position.Y) - startMouse
			if not moved and delta.Magnitude > 7 then
				moved = true
				tween(scale, { Scale = 1.08 }, TweenInfo.new(0.12))
			end

			if moved then
				local x, y = clampPos(startPos.X + delta.X, startPos.Y + delta.Y)
				btn.Position = UDim2.fromOffset(x, y)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if not dragging or input ~= dragInput then
				return
			end

			dragging = false
			tween(scale, { Scale = 1 }, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
			if not moved then
				if def.OnClick then
					def.OnClick()
				else
					local newState = not def.Get()
					local el = UIElements[def.Ui]
					if el then
						pcall(function()
							el:Set(newState)
						end)
					end
				end

				setVisual(def.Get() == true)
			end
		end)

		return {
			Sync = function()
				setVisual(def.Get() == true)
			end,
			Reclamp = function()
				local x, y = clampPos(btn.Position.X.Offset, btn.Position.Y.Offset)
				btn.Position = UDim2.fromOffset(x, y)
			end,
			Home = goHome,
			SetVisible = function(v)
				btn.Visible = v
			end,
		}
	end

	for i, def in ipairs(defs) do
		buttons[#buttons + 1] = createButton(def, i)
	end

	local emoteGui = Instance.new("ScreenGui")
	emoteGui.Name = "NexvyrHub_EmoteButton"
	emoteGui.ResetOnSpawn = false
	emoteGui.IgnoreGuiInset = true
	emoteGui.DisplayOrder = 1000
	emoteGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	emoteGui.Enabled = false
	emoteGui.Parent = player:WaitForChild("PlayerGui")
	local emoteButton = createButton({
		Name = "Emote",
		Get = function()
			return emoteSpamEnabled
		end,
		OnClick = function()
			setEmoteSpam(not emoteSpamEnabled)
		end,
		OnColor = Color3.fromRGB(255, 70, 70),
		OffColor = Color3.fromRGB(130, 130, 140),
		BgOn = Color3.fromRGB(45, 18, 22),
	}, 5, emoteGui)
	floatGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		for _, b in ipairs(buttons) do
			b.Reclamp()
		end

		emoteButton.Reclamp()
	end)

	task.spawn(function()
		while true do
			task.wait(0.2)
			if floatGui.Enabled then
				for _, b in ipairs(buttons) do
					b.Sync()
				end
			end

			if emoteGui.Enabled then
				emoteButton.Sync()
			end
		end
	end)

	Tabs.Botones:Section({ Title = "Botones flotantes", Icon = "solar:gamepad-bold" })
	UIElements.TogFloatButtons = Tabs.Botones:Toggle({
		Title = "Mostrar botones flotantes",
		Value = false,
		Callback = function(v)
			floatGui.Enabled = v
			if v then
				for _, b in ipairs(buttons) do
					b.Sync()
				end
			end
		end
	})

	local floatLabels = {
		ESP = "ESP",
		AutoShoot = "Auto Shoot",
		SilentAim = "Silent Aim",
		Invisible = "Invisible"
	}

	local floatSelected = { "Todos" }
	local function normalizeFloatSelection(list)
		local result = {}
		if type(list) == "string" then
			result[1] = list
		elseif type(list) == "table" then
			for _, entry in ipairs(list) do
				if type(entry) == "string" then
					result[#result + 1] = entry
				elseif type(entry) == "table" and type(entry.Title) == "string" then
					result[#result + 1] = entry.Title
				end
			end
		end

		return result
	end

	local function applyFloatSelection(list)
		local normalized = normalizeFloatSelection(list)
		floatSelected = normalized
		local set = {}
		for _, name in ipairs(normalized) do
			set[name] = true
		end

		local all = set["Todos"] == true
		for i, def in ipairs(defs) do
			local label = floatLabels[def.Name]
			if buttons[i] then
				buttons[i].SetVisible(all or set[label] == true)
			end
		end
	end

	UIElements.DropFloatButtons = Tabs.Botones:Dropdown({
		Title = "Botones a mostrar",
		Values = { "Todos", "ESP", "Auto Shoot", "Silent Aim", "Invisible" },
		Value = { "Todos" },
		Multi = true,
		AllowNone = true,
		Callback = function(Value)
			applyFloatSelection(Value)
		end
	})

	Tabs.Botones:Button({
		Title = "Restablecer posiciones",
		Icon = "solar:refresh-bold",
		Variant = "Secondary",
		Callback = function()
			for _, b in ipairs(buttons) do
				b.Home()
			end

			emoteButton.Home()
		end
	})

	Tabs.Botones:Space()
	Tabs.Botones:Divider()
	Tabs.Botones:Space()
	Tabs.Botones:Section({ Title = "Spam de emote", Icon = "solar:smile-circle-bold" })
	UIElements.TogEmoteSpam = Tabs.Botones:Toggle({
		Title = "Spam de emote (botón flotante)",
		Value = false,
		Callback = function(v)
			emoteGui.Enabled = v
			if v then
				emoteButton.Sync()
			else
				setEmoteSpam(false)
			end
		end
	})

	local emoteDropdown = Tabs.Botones:Dropdown({
		Title = "Mis emotes equipados",
		Values = { "Ninguno" },
		Value = "Ninguno",
		Callback = function(Value)
			if Value ~= "Ninguno" then
				emoteSpamSelected = { Kind = "equipped", Name = Value }
			end
		end
	})

	local function refrescarEmotes()
		local list = listarEmotes()
		if #list == 0 then
			list = { "Ninguno" }
		end

		pcall(function()
			emoteDropdown:Refresh(list)
		end)

		if list[1] ~= "Ninguno" and not emoteSpamSelected then
			emoteSpamSelected = { Kind = "equipped", Name = list[1] }
		end
	end

	Tabs.Botones:Button({
		Title = "Actualizar emotes",
		Icon = "solar:refresh-bold",
		Variant = "Secondary",
		Callback = refrescarEmotes
	})

	task.spawn(function()
		task.wait(1.5)
		refrescarEmotes()
	end)

	persist("DropFloatButtons", function()
		return floatSelected
	end, function(v)
		applyFloatSelection(v)
		if UIElements.DropFloatButtons then
			UIElements.DropFloatButtons:Select(normalizeFloatSelection(v))
		end
	end)

	persist("EmoteSelected", function()
		return emoteSpamSelected and emoteSpamSelected.Name or nil
	end, function(v)
		if type(v) == "string" and v ~= "" and v ~= "Ninguno" then
			emoteSpamSelected = { Kind = "equipped", Name = v }
			task.spawn(function()
				task.wait(1.4)
				pcall(function()
					emoteDropdown:Select(v)
				end)
			end)
		end
	end)

	persistToggle("TogFloatButtons", UIElements.TogFloatButtons, function()
		return floatGui.Enabled
	end)

	persistToggle("TogEmoteSpam", UIElements.TogEmoteSpam, function()
		return emoteGui.Enabled
	end)
end


do
	local WINDOW_KEY = Enum.KeyCode.LeftControl
	local windowOpen = true
	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		if input.KeyCode ~= WINDOW_KEY then
			return
		end

		if UserInputService:GetFocusedTextBox() then
			return
		end

		if pcall(function()
				Window:Toggle()
			end) then
			return
		end

		windowOpen = not windowOpen
		pcall(function()
			if windowOpen then
				Window:Open()
			else
				Window:Close()
			end
		end)
	end)
end


do
	task.spawn(function()
		task.wait(0.3)
		local data = Persist.Data
		Persist.Loading = true
		if type(data) == "table" and type(data.Values) == "table" then
			local applied = 0
			for _, key in ipairs(Persist.Order) do
				local item = Persist.Items[key]
				local value = data.Values[key]
				if item and value ~= nil then
					pcall(item.Set, value)
					applied += 1
					if applied % 6 == 0 then
						RunService.Heartbeat:Wait()
					end
				end
			end
		end

		Persist.Loading = false
		Persist.Ready = true
		Persist.Save()
		task.spawn(function()
			while true do
				task.wait(5)
				Persist.Save()
			end
		end)

		Players.PlayerRemoving:Connect(function(p)
			if p == player then
				Persist.Save()
			end
		end)
	end)
end
