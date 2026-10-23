--[[
    ═══════════════════════════════════════════════════════════
    Developer: VELOR$ (fixed by Bragao)
]]

(function()

-- ============================================================
-- 1. CORE SERVICES AND VARIABLES
-- ============================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- ============================================================
-- 2. FULL ESP LIBRARY (belfor) - v28.16
-- ============================================================
if getgenv().Library and getgenv().Library.Unload then
    pcall(getgenv().Library.Unload, getgenv().Library)
end

local GetService = setmetatable({}, {
    __index = function(_, Name)
        return game:GetService(Name);
    end;
})

local Workspace, Players, RunService, HttpService = GetService["Workspace"], GetService["Players"], GetService["RunService"], GetService["HttpService"];
local LocalPlayer, Camera = Players.LocalPlayer, Workspace.CurrentCamera;
local WorldToViewportPoint, FindFirstChildOfClass, FindFirstChild = Camera.WorldToViewportPoint, game.FindFirstChildOfClass, game.FindFirstChild;

local NewVector3, NewVector2, Dim, Dim2, DimOffset = Vector3.new, Vector2.new, UDim.new, UDim2.new, UDim2.fromOffset;
local NumSeq = NumberSequence.new;
local NumKey = NumberSequenceKeypoint.new;

local Format, Spawn, Clear, Floor, Clamp, Abs, Tan, Rad, Huge, Remove = string.format, task.spawn, table.clear, math.floor, math.clamp, math.abs, math.tan, math.rad, math.huge, table.remove;
local Frame, ZeroVector3, CameraPosition, CachedFocalLength, ViewPortY, Updates = 1 / 60, NewVector3(0,0,0), NewVector3(0,0,0), 0, 0, 0;

local function CameraCache()
    ViewPortY = Camera.ViewportSize.Y;
    CachedFocalLength = ViewPortY / (2 * Tan(Rad(Camera.FieldOfView) * 0.5));
end

CameraCache();
Camera:GetPropertyChangedSignal("FieldOfView"):Connect(CameraCache);
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(CameraCache);

getgenv().Library = {
    ['Directory'] = 'Esp',
    ['Cache'] = {},
    ['Holder'] = nil,
    ['Threads'] = {},
    ['Connections'] = {},

    ['Table'] = {
        ['Enabled'] = true,
        ['ShowLocalPlayer'] = false,
        ['Distance'] = 7520,
        ['RefreshRate'] = 60,
        ['Font'] = 'TahomaBold',
        ['FontSize'] = 12,
        ['FontType'] = 'none',

        ['Boxes'] = {
            ['Enabled'] = true,
            ['DynamicBoxes'] = true,
            ['Type'] = "2D",
            ['Rotation'] = 90,
            ['Bounding Box'] = {
                ['Enabled'] = true,
                ['IncludeAcsessories'] = false,
                ['BoxX'] = 0,
                ['BoxY'] = 0,
            },
            ['Box Glow'] = {
                ['Enabled'] = true,
                ['Top'] = Color3.fromRGB(0, 255, 255),
                ['Bot'] = Color3.fromRGB(0, 255, 255),
                ['Transparency'] = {0.75, 0.75},
            },
            ['Gradients'] = {
                ['Top'] = Color3.fromRGB(255, 255, 255),
                ['Bot'] = Color3.fromRGB(0, 255, 255),
            },
            ['Filled'] = {
                ['Enabled'] = true,
                ['Top'] = Color3.fromRGB(255, 255, 255),
                ['Bot'] = Color3.fromRGB(0, 255, 255),
                ['Transparency'] = {1, 0.65},
            },
        },

        ['Bars'] = {
            ['Health Bar'] = {
                ['Enabled'] = true,
                ['Top'] = Color3.fromRGB(0, 255, 0),
                ['Mid'] = Color3.fromRGB(255, 170, 0),
                ['Bot'] = Color3.fromRGB(255, 0, 0),
            },
            ['Armor Bar'] = {
                ['Enabled'] = false,
                ['Top'] = Color3.fromRGB(255, 255, 255),
                ['Mid'] = Color3.fromRGB(220, 220, 220),
                ['Bot'] = Color3.fromRGB(180, 180, 180),
            },
        },

        ['Texts'] = {
            ['Name'] = {
                ['Enabled'] = true,
                ['Color'] = Color3.fromRGB(255, 255, 255),
            },
            ['Distance'] = {
                ['Enabled'] = true,
                ['Color'] = Color3.fromRGB(255, 255, 255),
            },
            ['Weapon'] = {
                ['Enabled'] = true,
                ['Color'] = Color3.fromRGB(255, 255, 255),
            },
        },

        ['Flags'] = {
            ['Walking'] = {
                ['Enabled'] = true,
                ['Color'] = Color3.fromRGB(255, 0, 0),
                ['Text'] = "Walking",
            },
            ['Jumping'] = {
                ['Enabled'] = true,
                ['Color'] = Color3.fromRGB(144, 238, 144),
                ['Text'] = "Jumping",
            },
            ['Swimming'] = {
                ['Enabled'] = true,
                ['Color'] = Color3.fromRGB(0, 255, 255),
                ['Text'] = "Swimming",
            },
        },

        ['Tracers'] = {
            ['Enabled'] = false,
            ['Color'] = Color3.fromRGB(255, 255, 255),
            ['Transparency'] = 0.5,
        },
    }
}

local Table = Library['Table'];

-- Fonts registration
local Fonts = {};
do
    local function FontsRegister(Name, Weight, Style, Asset)
        if not isfile(Asset.Id) then
            writefile(Asset.Id, Asset.Font)
        end
        if isfile(Name .. ".font") then
            delfile(Name .. ".font")
        end
        local Info = {
            name = Name,
            faces = {
                {
                    name = "Normal",
                    weight = Weight,
                    style = Style,
                    assetId = getcustomasset(Asset.Id),
                },
            },
        }
        writefile(Name .. ".font", HttpService:JSONEncode(Info))
        return getcustomasset(Name .. ".font")
    end;

    Fonts.Tahoma = FontsRegister("Tahoma", 400, "Normal", {
        Id = "Tahoma.ttf",
        Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/fs-tahoma-8px.ttf"),
    })
    Fonts.XPTahoma = FontsRegister("XPTahoma", 400, "Normal", {
        Id = "Tahoma8PTBOLD.ttf",
        Font = game:HttpGet("https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/TAHOMA-8PT-BOLD-WINDOWS-XP.TTF"),
    })
    Fonts.SmallestPixel = FontsRegister("SmallestPixel", 400, "Normal", {
        Id = "smallest_pixel-7.ttf",
        Font = game:HttpGet("https://raw.githubusercontent.com/sametexe001/luas/main/smallest_pixel-7.ttf")
    })
    Fonts.ProggyTiny = FontsRegister("ProggyTiny", 400, "Normal", {
        Id = "ProggyTinyyyy.ttf",
        Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/ProggyTiny.ttf")
    })
    Fonts.ProggyClean = FontsRegister("ProggyClean", 400, "Normal", {
        Id = "ProggyClean.ttf",
        Font = game:HttpGet("https://github.com/i77lhm/storage/raw/main/fonts/ProggyClean.ttf"),
    })
    
    Library.ProggyTiny = Font.new(Fonts.ProggyClean, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    Library.TahomaBold = Font.new(Fonts.XPTahoma, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    Library.ProggyClean = Font.new(Fonts.ProggyClean, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    Library.Tahoma = Font.new(Fonts.Tahoma, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    Library.SmallestPixel = Font.new(Fonts.SmallestPixel, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
end

Library.__index = Library;

function Library:CreateObjects(Name, Prop)
    local New = Instance.new(Name);
    for Property, Value in Prop or {} do
        New[Property] = Value;
    end;
    return New;
end

function Library:CreateThreads(Name, Signal, Callback)
    local Connection = Signal:Connect(Callback);
    self.Threads[Name] = Connection;
    return Connection;
end

Library.Holder = Library:CreateObjects("ScreenGui", {
    Name = "\n",
    Parent = gethui(),
    ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
    ResetOnSpawn = false,
    DisplayOrder = 10000,
    IgnoreGuiInset = true,
})

-- ======================== FULL ESP (InitEsp) ========================
function Library:InitEsp(Data)
    local Objects = Data.Objects

    do
        Objects["TargetHolder"] = self:CreateObjects("Frame", {
            Parent = self.Holder,
            Visible = false,
            BackgroundTransparency = 1,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(0, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["TopHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["TargetHolder"],
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = true,
            BackgroundTransparency = 1,
            AnchorPoint = NewVector2(0, 1),
            Position = Dim2(0, -2, 0, -5),
            Size = Dim2(1, 4, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["BottomHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["TargetHolder"],
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = true,
            BackgroundTransparency = 1,
            Position = Dim2(0, -2, 1, 3),
            Size = Dim2(1, 4, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["LeftHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["TargetHolder"],
            AutomaticSize = Enum.AutomaticSize.X,
            Visible = true,
            BackgroundTransparency = 1,
            AnchorPoint = NewVector2(1, 0),
            Position = Dim2(0, -5, 0, -2),
            Size = Dim2(0, 0, 1, 4),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["RightHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["TargetHolder"],
            AutomaticSize = Enum.AutomaticSize.X,
            Visible = true,
            BackgroundTransparency = 1,
            Position = Dim2(1, 5, 0, -2),
            Size = Dim2(0, 0, 1, 4),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })
    end

    do
        Objects["TopTextHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["TopHolder"],
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = true,
            BackgroundTransparency = 1,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(1, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["BottomTextHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["BottomHolder"],
            LayoutOrder = 2,
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = true,
            BackgroundTransparency = 1,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(1, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["LeftTextHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["LeftHolder"],
            AutomaticSize = Enum.AutomaticSize.XY,
            Visible = true,
            BackgroundTransparency = 1,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(1, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["RightTextHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["RightHolder"],
            LayoutOrder = 2,
            AutomaticSize = Enum.AutomaticSize.XY,
            Visible = true,
            BackgroundTransparency = 1,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(0, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })
    end

    do
        Objects["LeftBarHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["LeftHolder"],
            AutomaticSize = Enum.AutomaticSize.X,
            Visible = false,
            BackgroundTransparency = 1,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(0, 0, 1, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["BottomBarHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["BottomHolder"],
            LayoutOrder = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = false,
            BackgroundTransparency = 1,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(1, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })
    end

    do
        self:CreateObjects("UIListLayout", {
            Parent = Objects["TopTextHolder"],
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = Dim(0, 1),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        self:CreateObjects("UIListLayout", {
            Parent = Objects["BottomTextHolder"],
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = Dim(0, -1),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        self:CreateObjects("UIListLayout", {
            Parent = Objects["LeftTextHolder"],
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = Dim(0, 0),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        self:CreateObjects("UIListLayout", {
            Parent = Objects["RightTextHolder"],
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = Dim(0, 0),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        self:CreateObjects("UIListLayout", {
            Parent = Objects["LeftBarHolder"],
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = Dim(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        self:CreateObjects("UIListLayout", {
            Parent = Objects["BottomBarHolder"],
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = Dim(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        self:CreateObjects("UIListLayout", {
            Parent = Objects["TopHolder"],
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = Dim(0, 1),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        self:CreateObjects("UIListLayout", {
            Parent = Objects["BottomHolder"],
            Padding = Dim(0, 1),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        self:CreateObjects("UIListLayout", {
            Parent = Objects["LeftHolder"],
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = Dim(0, 1),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        self:CreateObjects("UIListLayout", {
            Parent = Objects["RightHolder"],
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = Dim(0, 1),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })
    end

    do
        self:CreateObjects("UIPadding", {
            Parent = Objects["TopTextHolder"],
            PaddingBottom = Dim(0, 0),
        })

        self:CreateObjects("UIPadding", {
            Parent = Objects["BottomTextHolder"],
            PaddingTop = Dim(0, -1)
        })

        self:CreateObjects("UIPadding", {
            Parent = Objects["LeftTextHolder"],
            PaddingTop = Dim(0, -3),
        })

        self:CreateObjects("UIPadding", {
            Parent = Objects["RightTextHolder"],
            PaddingTop = Dim(0, -3),
        })

        self:CreateObjects("UIPadding", {
            Parent = Objects["LeftBarHolder"],
            PaddingRight = Dim(0, 0),
        })

        self:CreateObjects("UIPadding", {
            Parent = Objects["BottomBarHolder"],
            PaddingTop = Dim(0, 2),
        })

        self:CreateObjects("UIPadding", {
            Parent = Objects["LeftHolder"],
            PaddingRight = Dim(0, 1),
        })
    end

    do
        Objects["BoxGlow"] = self:CreateObjects("ImageLabel", {
            Parent = Objects["TargetHolder"],
            Image = "rbxassetid://110204605000367",
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(NewVector2(21, 21), NewVector2(79, 79)),
            AutomaticSize = Enum.AutomaticSize.XY,
            ImageTransparency = 0.65,
            ResampleMode = Enum.ResamplerMode.Pixelated,
            Visible = true,
            BackgroundTransparency = 1,
            Position = Dim2(0, -21, 0, -21),
            Size = Dim2(0, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["BoxGlowGradient"] = self:CreateObjects("UIGradient", {
            Parent = Objects["BoxGlow"],
            Rotation = 90,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
            }),
            Transparency = NumSeq({NumKey(0, 0), NumKey(1, 0)}),
        })

        self:CreateObjects("UIPadding", {
            Parent = Objects["BoxGlow"],
            PaddingTop = Dim(0, 21),
            PaddingBottom = Dim(0, 20),
            PaddingLeft = Dim(0, 21),
            PaddingRight = Dim(0, 20),
        })

        Objects["BoxOutlineHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["BoxGlow"],
            Visible = false,
            BackgroundTransparency = 1,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(0, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["BoxOutline"] = self:CreateObjects("UIStroke", {
            Parent = Objects["BoxOutlineHolder"],
            Thickness = 3,
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["BoxOutlineGradient"] = self:CreateObjects("UIGradient", {
            Parent = Objects["BoxOutline"],
            Rotation = 90,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
            }),
            Transparency = NumSeq({NumKey(0, 0), NumKey(1, 0)}),
        })

        Objects["BoxInlineHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["BoxGlow"],
            Visible = false,
            BackgroundTransparency = 1,
            Position = Dim2(0, -1, 0, -1),
            Size = Dim2(0, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["BoxInline"] = self:CreateObjects("UIStroke", {
            Parent = Objects["BoxInlineHolder"],
            Color = Color3.fromRGB(255, 255, 255),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["BoxInlineGradient"] = self:CreateObjects("UIGradient", {
            Parent = Objects["BoxInline"],
            Rotation = 90,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
            }),
            Transparency = NumSeq({NumKey(0, 0), NumKey(1, 0)}),
        })

        Objects["BoxFill"] = self:CreateObjects("Frame", {
            Parent = Objects["BoxGlow"],
            Visible = false,
            BackgroundTransparency = 0,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(0, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["BoxFillGradient"] = self:CreateObjects("UIGradient", {
            Parent = Objects["BoxFill"],
            Rotation = 90,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
            }),
            Transparency = NumSeq({NumKey(0, 1), NumKey(1, 1)}),
        })

        Objects["CornerHolder"] = self:CreateObjects("Frame", {
            Parent = Objects["BoxGlow"],
            Visible = false,
            BackgroundTransparency = 1,
            Position = Dim2(0, -1, 0, -1),
            Size = Dim2(0, 0, 0, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        for i = 1, 8 do
            Objects["Line_" .. i] = self:CreateObjects("Frame", {
                Parent = Objects["CornerHolder"],
                Visible = false,
                BackgroundTransparency = 0,
                Position = Dim2(0, 0, 0, 0),
                Size = Dim2(0, 0, 0, 0),
                BorderSizePixel = 0,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            })
            self:CreateObjects("UIStroke", {
                Parent = Objects["Line_" .. i],
                Thickness = 1,
                LineJoinMode = Enum.LineJoinMode.Miter,
            })
        end
    end

    do
        Objects["HealthBarOutline"] = self:CreateObjects("Frame", {
            Parent = Objects["LeftBarHolder"],
            ZIndex = 5,
            LayoutOrder = 0,
            Visible = false,
            BackgroundTransparency = 0,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(0, 1, 1, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            ClipsDescendants = false,
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["HealthBarOutline"],
            Thickness = 1,
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["HealthBar"] = self:CreateObjects("Frame", {
            Parent = Objects["HealthBarOutline"],
            ZIndex = 6,
            AnchorPoint = NewVector2(0, 1),
            Position = Dim2(0, 0, 1, 0),
            Size = Dim2(1, 0, 1, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            ClipsDescendants = true,
        })

        Objects["HealthBarGradient"] = self:CreateObjects("UIGradient", {
            Parent = Objects["HealthBar"],
            Rotation = 90,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Table['Bars']['Health Bar']['Top']),
                ColorSequenceKeypoint.new(0.5, Table['Bars']['Health Bar']['Mid']),
                ColorSequenceKeypoint.new(1, Table['Bars']['Health Bar']['Bot']),
            }),
            Transparency = NumSeq({NumKey(0, 0), NumKey(1, 0)}),
        })

        Objects["HealthBarText"] = self:CreateObjects("TextLabel", {
            Parent = Objects["HealthBarOutline"],
            FontFace = Library.SmallestPixel,
            TextSize = 9,
            ZIndex = 10,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Text = "",
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            AnchorPoint = NewVector2(0.5, 0.5),
            Position = Dim2(0.5, 0, 1, 0),
            BorderSizePixel = 0,
            Visible = false,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = Dim2(0, 0, 0, 0),
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["HealthBarText"],
            Color = Color3.fromRGB(0, 0, 0),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["ArmorBarOutline"] = self:CreateObjects("Frame", {
            Parent = Objects["BottomBarHolder"],
            ZIndex = 5,
            LayoutOrder = 0,
            Visible = false,
            BackgroundTransparency = 0,
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(1, 0, 0, 1),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            ClipsDescendants = true,
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["ArmorBarOutline"],
            Thickness = 1,
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["ArmorBar"] = self:CreateObjects("Frame", {
            Parent = Objects["ArmorBarOutline"],
            ZIndex = 6,
            AnchorPoint = NewVector2(0, 0),
            Position = Dim2(0, 0, 0, 0),
            Size = Dim2(1, 0, 1, 0),
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        })

        Objects["ArmorBarGradient"] = self:CreateObjects("UIGradient", {
            Parent = Objects["ArmorBar"],
            Rotation = 0,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Table['Bars']['Armor Bar']['Top']),
                ColorSequenceKeypoint.new(0.5, Table['Bars']['Armor Bar']['Mid']),
                ColorSequenceKeypoint.new(1, Table['Bars']['Armor Bar']['Bot']),
            }),
            Transparency = NumSeq({NumKey(0, 0), NumKey(1, 0)}),
        })

        Objects["ArmorBarText"] = self:CreateObjects("TextLabel", {
            Parent = Objects["ArmorBar"],
            FontFace = Library.SmallestPixel,
            TextSize = 9,
            ZIndex = 10,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Text = "",
            TextXAlignment = Enum.TextXAlignment.Center,
            AnchorPoint = NewVector2(0.5, 0.5),
            Position = Dim2(0.5, 0, 0.5, 0),
            BorderSizePixel = 0,
            Visible = false,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = Dim2(0, 0, 0, 0),
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["ArmorBarText"],
            Color = Color3.fromRGB(0, 0, 0),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })
    end

    do
        Objects["TargetName"] = self:CreateObjects("TextLabel", {
            Parent = Objects["TopTextHolder"],
            FontFace = Library.TahomaBold,
            TextSize = 12,
            LayoutOrder = 2,
            TextColor3 = Table['Texts']['Name']['Color'],
            Text = "",
            TextXAlignment = Enum.TextXAlignment.Center,
            BorderSizePixel = 0,
            Visible = false,
            BackgroundTransparency = 1,
            ZIndex = 5,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = Dim2(0, 0, 0, 0),
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["TargetName"],
            Color = Color3.fromRGB(0, 0, 0),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["Distance"] = self:CreateObjects("TextLabel", {
            Parent = Objects["BottomTextHolder"],
            FontFace = Library.SmallestPixel,
            TextSize = 9,
            LayoutOrder = 2,
            TextColor3 = Table['Texts']['Distance']['Color'],
            Text = "",
            TextXAlignment = Enum.TextXAlignment.Center,
            BorderSizePixel = 0,
            Visible = false,
            BackgroundTransparency = 1,
            ZIndex = 5,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = Dim2(0, 0, 0, 0),
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["Distance"],
            Color = Color3.fromRGB(0, 0, 0),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["WalkFlag"] = self:CreateObjects("TextLabel", {
            Parent = Objects["RightTextHolder"],
            FontFace = Library.SmallestPixel,
            TextSize = 9,
            LayoutOrder = 1,
            TextColor3 = Table['Flags']['Walking']['Color'],
            Text = Table['Flags']['Walking']['Text'],
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            Visible = false,
            BackgroundTransparency = 1,
            ZIndex = 5,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = Dim2(0, 0, 0, 0),
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["WalkFlag"],
            Color = Color3.fromRGB(0, 0, 0),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["JumpFlag"] = self:CreateObjects("TextLabel", {
            Parent = Objects["RightTextHolder"],
            FontFace = Library.SmallestPixel,
            TextSize = 9,
            LayoutOrder = 2,
            TextColor3 = Table['Flags']['Jumping']['Color'],
            Text = Table['Flags']['Jumping']['Text'],
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            Visible = false,
            BackgroundTransparency = 1,
            ZIndex = 5,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = Dim2(0, 0, 0, 0),
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["JumpFlag"],
            Color = Color3.fromRGB(0, 0, 0),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["SwimmingFlag"] = self:CreateObjects("TextLabel", {
            Parent = Objects["RightTextHolder"],
            FontFace = Library.SmallestPixel,
            TextSize = 9,
            LayoutOrder = 4,
            TextColor3 = Table['Flags']['Swimming']['Color'],
            Text = Table['Flags']['Swimming']['Text'],
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            Visible = false,
            BackgroundTransparency = 1,
            ZIndex = 5,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = Dim2(0, 0, 0, 0),
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["SwimmingFlag"],
            Color = Color3.fromRGB(0, 0, 0),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        Objects["Weapon"] = self:CreateObjects("TextLabel", {
            Parent = Objects["BottomTextHolder"],
            FontFace = Library.SmallestPixel,
            TextSize = 9,
            LayoutOrder = 3,
            TextColor3 = Table['Texts']['Weapon']['Color'],
            Text = "none",
            TextXAlignment = Enum.TextXAlignment.Center,
            BorderSizePixel = 0,
            Visible = false,
            BackgroundTransparency = 1,
            ZIndex = 5,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = Dim2(0, 0, 0, 0),
        })

        self:CreateObjects("UIStroke", {
            Parent = Objects["Weapon"],
            Color = Color3.fromRGB(0, 0, 0),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })
    end
end

local CornerLayout = {
    {Dim2(0, -1, 0, -1), Dim2(0.3, 0, 0, 1), NewVector2(0, 0), 0},
    {Dim2(0, -1, 0, -1), Dim2(0, 1, 0.3, 0), NewVector2(0, 0), 180},
    {Dim2(1, 1, 0, -1), Dim2(0.3, 0, 0, 1), NewVector2(1, 0), 0},
    {Dim2(1, 1, 0, -1), Dim2(0, 1, 0.3, 0), NewVector2(1, 0), 180},
    {Dim2(0, -1, 1, 1), Dim2(0.3, 0, 0, 1), NewVector2(0, 1), 0},
    {Dim2(0, -1, 1, 1), Dim2(0, 1, 0.3, 0), NewVector2(0, 1), -180},
    {Dim2(1, 1, 1, 1), Dim2(0.3, 0, 0, 1), NewVector2(1, 1), 0},
    {Dim2(1, 1, 1, 1), Dim2(0, 1, 0.3, 0), NewVector2(1, 1), -180},
}

function Library:CalculateBox(Data)
    local RootPart = Data['RootPart']
    if not RootPart then
        return nil, nil, nil, nil, false;
    end;
    local RootScreen, OnScreen = WorldToViewportPoint(Camera, RootPart.Position)
    if not OnScreen then
        return nil, nil, nil, nil, false;
    end;
    local BoundingBox = Table['Boxes']['Bounding Box'];
    if Table['Boxes']['DynamicBoxes'] then
        local Children = Data['Children'];
        if not Children then
            return nil, nil, nil, nil, false;
        end;
        local IncludeAccessories = Data['IncludeAccessories'];
        local ScrMinX, ScrMinY = Huge, Huge;
        local ScrMaxX, ScrMaxY = -Huge, -Huge;
        local HasValidParts = false;
        for _, Part in Children do
            if Part:IsA('BasePart') and Part.Transparency ~= 1 and Part ~= RootPart then
                local Parent = Part.Parent
                if Parent == nil then continue end
                if not IncludeAccessories and Parent:IsA('Accessory') then continue end;
                local PartScreen, PartOnScreen = WorldToViewportPoint(Camera, Part.Position);
                if not PartOnScreen or PartScreen.Z <= 0 then continue end;
                HasValidParts = true;
                local Cf = Part.CFrame;
                local Sz = Part.Size;
                local HX, HY, HZ = Sz.X * 0.5, Sz.Y * 0.5, Sz.Z * 0.5;
                local RX, UY, LZ = Cf.RightVector, Cf.UpVector, Cf.LookVector;
                local DepthScale = CachedFocalLength / PartScreen.Z;
                local Ex = (Abs(RX.X * HX) + Abs(UY.X * HY) + Abs(LZ.X * HZ)) * DepthScale;
                local Ey = (Abs(RX.Y * HX) + Abs(UY.Y * HY) + Abs(LZ.Y * HZ)) * DepthScale;
                local PMinX, PMaxX = PartScreen.X - Ex, PartScreen.X + Ex;
                local PMinY, PMaxY = PartScreen.Y - Ey, PartScreen.Y + Ey;
                if PMinX < ScrMinX then ScrMinX = PMinX; end
                if PMaxX > ScrMaxX then ScrMaxX = PMaxX; end
                if PMinY < ScrMinY then ScrMinY = PMinY; end
                if PMaxY > ScrMaxY then ScrMaxY = PMaxY; end
            end;
        end;
        if not HasValidParts then
            return nil, nil, nil, nil, false;
        end;
        local PadX = BoundingBox['BoxX'];
        local PadY = BoundingBox['BoxY'];
        local W = (ScrMaxX - ScrMinX) + PadX;
        local H = (ScrMaxY - ScrMinY) + PadY;
        return W, H, ScrMinX - (PadX * 0.5), ScrMinY - (PadY * 0.5), true;
    else
        local Scale = (RootPart.Size.Y * ViewPortY) / (RootScreen.Z * 2);
        local W, H = 3 * Scale, 4.5 * Scale;
        return W, H, RootScreen.X - (W * 0.5), RootScreen.Y - (H * 0.5), OnScreen;
    end
end

function Library:AddTarget(Player)
    if Player == LocalPlayer and not Table['ShowLocalPlayer'] then
        return
    end;
    if self.Cache[Player] then
        return
    end;
    local Data = {
        ['Player'] = Player,
        ['Objects'] = {},
        ['Conns'] = {},
        ['Character'] = nil,
        ['RootPart'] = nil,
        ['Humanoid'] = nil,
        ['Children'] = nil,
        ['Health'] = 0,
        ['MaxHealth'] = 100,
        ['Armor'] = 100,
        ['MaxArmor'] = 100,
        ['CurrentTool'] = nil,
        ['Alive'] = false,
        ['LastW'] = nil,
        ['LastH'] = nil,
        ['LastX'] = nil,
        ['LastY'] = nil,
        ['WalkActive'] = false,
        ['JumpActive'] = false,
        ['FallingActive'] = false,
        ['SwimmingActive'] = false,
        ['IncludeAccessories'] = Table['Boxes']['Bounding Box']['IncludeAcsessories'],
        ['LastGlowTop'] = nil,
        ['LastGlowBot'] = nil,
        ['LastGlowT1'] = nil,
        ['LastGlowT2'] = nil,
        ['LastGradTop'] = nil,
        ['LastGradBot'] = nil,
        ['LastFillTop'] = nil,
        ['LastFillBot'] = nil,
        ['LastFillT1'] = nil,
        ['LastFillT2'] = nil,
        ['LastDist'] = nil,
        ['LastDistColor'] = nil,
        ['LastDisplayName'] = nil,
        ['LastNameColor'] = nil,
        ['LastHealthTop'] = nil,
        ['LastHealthMid'] = nil,
        ['LastHealthBot'] = nil,
        ['LastHealthFloor'] = nil,
        ['LastRatio'] = nil,
        ['LastArmorTop'] = nil,
        ['LastArmorMid'] = nil,
        ['LastArmorBot'] = nil,
        ['LastArmorFloor'] = nil,
        ['LastArmorRatio'] = nil,
        ['LastWeapon'] = nil,
        ['LastWeaponColor'] = nil,
    }
    self:InitEsp(Data);
    self['Cache'][Player] = Data;

    local HealthHandler = {};
    do
        function HealthHandler.BindHealth(Humanoid)
            if Data['Conns']['Health'] then Data['Conns']['Health']:Disconnect() end
            if Data['Conns']['Died'] then Data['Conns']['Died']:Disconnect() end
            Data['Humanoid'] = Humanoid
            Data['Health'] = Humanoid.Health
            Data['MaxHealth'] = Humanoid.MaxHealth
            Data['Alive'] = Humanoid.Health > 0
            Data['Conns']['Health'] = Humanoid.HealthChanged:Connect(function(NewHealth)
                Data['Alive'] = NewHealth > 0
                Data['Health'] = NewHealth
            end)
            Data['Conns']['Died'] = Humanoid.Died:Connect(function()
                Data['Alive'] = false
            end)
        end
        Data['BindHealth'] = HealthHandler.BindHealth;
    end

    local ToolHandler = {};
    do
        function ToolHandler.BindTool(Character)
            if Data['Conns']['ToolAdded'] then Data['Conns']['ToolAdded']:Disconnect() end
            if Data['Conns']['ToolRemoved'] then Data['Conns']['ToolRemoved']:Disconnect() end
            if Data['Children'] then
                for _, Child in Data['Children'] do
                    if Child:IsA('Tool') then
                        Data['CurrentTool'] = Child.Name
                        break
                    end
                end
            end
            Data['Conns']['ToolAdded'] = Character.ChildAdded:Connect(function(Child)
                if Child:IsA('Tool') then
                    Data['CurrentTool'] = Child.Name
                end
            end)
            Data['Conns']['ToolRemoved'] = Character.ChildRemoved:Connect(function(Child)
                if Child:IsA('Tool') then
                    Data['CurrentTool'] = nil
                end
            end)
        end
        Data['BindTool'] = ToolHandler.BindTool
    end

    local ChildHandler = {};
    do
        function ChildHandler.BindChildren(Character)
            if Data['Conns']['ChildAdded'] then Data['Conns']['ChildAdded']:Disconnect(); end;
            if Data['Conns']['ChildRemoved'] then Data['Conns']['ChildRemoved']:Disconnect(); end;
            local Children = Character:GetChildren();
            Data['Children'] = Children;
            Data['Conns']['ChildAdded'] = Character.ChildAdded:Connect(function(Child)
                Children[#Children + 1] = Child;
            end)
            Data['Conns']['ChildRemoved'] = Character.ChildRemoved:Connect(function(Child)
                for I = #Children, 1, -1 do
                    if Children[I] == Child then
                        Remove(Children, I);
                        break;
                    end;
                end
            end)
            Data['BindTool'](Character);
        end
        Data['BindChildren'] = ChildHandler.BindChildren;
    end

    local FlagsHandler = {};
    do
        function FlagsHandler.BindFlags(Humanoid)
            if Data['Conns']['MoveDir'] then Data['Conns']['MoveDir']:Disconnect(); end;
            if Data['Conns']['StateChange'] then Data['Conns']['StateChange']:Disconnect(); end;
            local Objects = Data['Objects']
            Data['JumpActive'] = false;
            Data['WalkActive'] = false;
            Data['FallingActive'] = false;
            Data['SwimmingActive'] = false;
            Objects['WalkFlag'].Visible = false;
            Objects['JumpFlag'].Visible = false;
            Objects['SwimmingFlag'].Visible = false;
            Data['Conns']['MoveDir'] = Humanoid:GetPropertyChangedSignal('MoveDirection'):Connect(function()
                local Walking = Humanoid.MoveDirection ~= ZeroVector3;
                if Walking and not Data['WalkActive'] then
                    Data['WalkActive'] = true;
                    if Data['JumpActive'] then
                        Objects['WalkFlag'].LayoutOrder = 2;
                    else
                        Objects['WalkFlag'].LayoutOrder = 1;
                        Objects['JumpFlag'].LayoutOrder = 2;
                    end
                    Objects['WalkFlag'].Visible = Table['Flags']['Walking']['Enabled']
                elseif not Walking and Data['WalkActive'] then
                    Data['WalkActive'] = false;
                    Objects['WalkFlag'].Visible = false;
                    if Data['JumpActive'] then
                        Objects['JumpFlag'].LayoutOrder = 1;
                    end
                end
            end)
            Data['Conns']['StateChange'] = Humanoid.StateChanged:Connect(function(_, NewState)
                if NewState == Enum.HumanoidStateType.Freefall and not Data['JumpActive'] then
                    Data['JumpActive'] = true;
                    if Data['WalkActive'] then
                        Objects['JumpFlag'].LayoutOrder = 2;
                    else
                        Objects['JumpFlag'].LayoutOrder = 1;
                        Objects['WalkFlag'].LayoutOrder = 2;
                    end
                    Objects['JumpFlag'].Visible = Table['Flags']['Jumping']['Enabled']
                elseif NewState ~= Enum.HumanoidStateType.Jumping and Data['JumpActive'] then
                    Data['JumpActive'] = false;
                    Objects['JumpFlag'].Visible = false;
                    if Data['WalkActive'] then
                        Objects['WalkFlag'].LayoutOrder = 1;
                    end
                end
                if NewState == Enum.HumanoidStateType.Swimming and not Data['SwimmingActive'] then
                    Data['SwimmingActive'] = true;
                    Objects['SwimmingFlag'].Visible = Table['Flags']['Swimming']['Enabled']
                elseif NewState ~= Enum.HumanoidStateType.Swimming and Data['SwimmingActive'] then
                    Data['SwimmingActive'] = false;
                    Objects['SwimmingFlag'].Visible = false;
                end
            end)
        end
        Data['BindFlags'] = FlagsHandler.BindFlags;
    end

    local CharacterHandler = {};
    do
        function CharacterHandler.OnCharacter(Character)
            Data['Character'] = Character;
            Data['RootPart'] = nil;
            Data['Humanoid'] = nil;
            Data['Children'] = nil;
            Data['Alive'] = false;
            Data['WalkActive'] = false;
            Data['JumpActive'] = false;
            Data['FallingActive'] = false;
            Data['SwimmingActive'] = false;
            if not Character or not Character.Parent then
                return;
            end;
            local RootPart = FindFirstChild(Character, "HumanoidRootPart");
            if not RootPart then
                RootPart = Character:WaitForChild('HumanoidRootPart', 10);
            end
            local Humanoid = FindFirstChildOfClass(Character, 'Humanoid');
            if not Humanoid then
                Humanoid = Character:WaitForChild('Humanoid', 10);
            end;
            if not RootPart or not Humanoid then
                return;
            end;
            if not Character.Parent then
                return;
            end;
            Data['RootPart'] = RootPart;
            Data['Humanoid'] = Humanoid;
            Data['BindChildren'](Character);
            Data['BindHealth'](Humanoid);
            Data['BindFlags'](Humanoid);
        end
        Data['Conns']['CharAdded'] = Player.CharacterAdded:Connect(function(Character)
            task.defer(CharacterHandler.OnCharacter, Character)
        end)
        if Player.Character and Player.Character.Parent then
            task.defer(CharacterHandler.OnCharacter, Player.Character)
        end
    end
end

function Library:RemoveTarget(Player)
    local Data = self['Cache'][Player];
    if not Data then
        return;
    end;
    for _, Connections in Data['Conns'] do
        Connections:Disconnect()
    end;
    Clear(Data['Conns']);
    if Data['Objects']['TargetHolder'] then
        Data['Objects']['TargetHolder']:Destroy();
    end;
    Clear(Data['Objects']);
    self['Cache'][Player] = nil;
end

function Library:Update(Player, Data)
    local Objects = Data['Objects']
    if not Data['RootPart'] then
        if Objects['TargetHolder'].Visible then
            Objects['TargetHolder'].Visible = false
        end
        return
    end
    if not Data['Alive'] then
        if Objects['TargetHolder'].Visible then
            Objects['TargetHolder'].Visible = false
        end
        return
    end
    local RootPos = Data['RootPart'].Position
    local Distance = Floor((CameraPosition - RootPos).Magnitude)
    if Distance > Table['Distance'] then
        if Objects['TargetHolder'].Visible then
            Objects['TargetHolder'].Visible = false
        end
        return
    end
    local W, H, X, Y, OnScreen = self:CalculateBox(Data)
    if not OnScreen or not W then
        if Objects['TargetHolder'].Visible then
            Objects['TargetHolder'].Visible = false
        end
        return
    end
    W = Floor(W)
    H = Floor(H)
    X = Floor(X)
    Y = Floor(Y)
    if not Objects['TargetHolder'].Visible then
        Objects['TargetHolder'].Visible = true
    end
    local DirtySizes = Data['LastW'] ~= W or Data['LastH'] ~= H
    local DirtyPosition = Data['LastX'] ~= X or Data['LastY'] ~= Y
    if DirtyPosition then
        Objects['TargetHolder'].Position = DimOffset(X, Y)
        Data['LastX'] = X
        Data['LastY'] = Y
    end
    if DirtySizes then
        Objects['TargetHolder'].Size = DimOffset(W, H)
        Objects['BoxGlow'].Size = DimOffset(W, H)
        Objects['BoxOutlineHolder'].Size = DimOffset(W, H)
        Objects['BoxInlineHolder'].Size = DimOffset(W + 2, H + 2)
        Objects['BoxFill'].Size = DimOffset(W, H)
        Objects['CornerHolder'].Size = DimOffset(W + 2, H + 2)
        Data['LastW'] = W
        Data['LastH'] = H
    end
    local BoxesCfg = Table['Boxes']
    local TextsCfg = Table['Texts']
    if BoxesCfg['Enabled'] then
        if BoxesCfg['Box Glow']['Enabled'] then
            if Objects['BoxGlow'].ImageTransparency ~= 0 then
                Objects['BoxGlow'].ImageTransparency = 0
            end
            local GlowTop = BoxesCfg['Box Glow']['Top']
            local GlowBot = BoxesCfg['Box Glow']['Bot']
            if Data['LastGlowTop'] ~= GlowTop or Data['LastGlowBot'] ~= GlowBot then
                Objects['BoxGlowGradient'].Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, GlowTop),
                    ColorSequenceKeypoint.new(1, GlowBot),
                })
                Data['LastGlowTop'] = GlowTop
                Data['LastGlowBot'] = GlowBot
            end
            local T1 = BoxesCfg['Box Glow']['Transparency'][1]
            local T2 = BoxesCfg['Box Glow']['Transparency'][2]
            if Data['LastGlowT1'] ~= T1 or Data['LastGlowT2'] ~= T2 then
                Objects['BoxGlowGradient'].Transparency = NumSeq({NumKey(0, T1), NumKey(1, T2)})
                Data['LastGlowT1'] = T1
                Data['LastGlowT2'] = T2
            end
        else
            if Objects['BoxGlow'].ImageTransparency ~= 1 then
                Objects['BoxGlow'].ImageTransparency = 1
            end
        end
        local BoxType = BoxesCfg['Type']
        if BoxType == "Corner" then
            if Objects['BoxOutlineHolder'].Visible then
                Objects['BoxOutlineHolder'].Visible = false
            end
            if Objects['BoxInlineHolder'].Visible then
                Objects['BoxInlineHolder'].Visible = false
            end
            if Objects['BoxFill'].Visible then
                Objects['BoxFill'].Visible = false
            end
            if not Objects['CornerHolder'].Visible then
                Objects['CornerHolder'].Visible = true
            end
            local GradTop = BoxesCfg['Gradients']['Top']
            local GradBot = BoxesCfg['Gradients']['Bot']
            for i = 1, 8 do
                local Line = Objects['Line_' .. i]
                local Stroke = Line:FindFirstChildOfClass('UIStroke')
                local LayoutEntry = CornerLayout[i]
                local LPos, LSize, LAnchor, LRot = LayoutEntry[1], LayoutEntry[2], LayoutEntry[3], LayoutEntry[4]
                Line.Position = LPos
                Line.Size = LSize
                Line.AnchorPoint = LAnchor
                Line.Rotation = LRot
                Line.BackgroundColor3 = GradTop
                Line.BackgroundTransparency = 0
                if Stroke then
                    Stroke.Color = GradTop
                end
                Line.Visible = true
            end
        else
            if Objects['CornerHolder'].Visible then
                Objects['CornerHolder'].Visible = false
            end
            for i = 1, 8 do
                if Objects['Line_' .. i].Visible then
                    Objects['Line_' .. i].Visible = false
                end
            end
            if not Objects['BoxOutlineHolder'].Visible then
                Objects['BoxOutlineHolder'].Visible = true
            end
            if not Objects['BoxInlineHolder'].Visible then
                Objects['BoxInlineHolder'].Visible = true
            end
            local GradTop = BoxesCfg['Gradients']['Top']
            local GradBot = BoxesCfg['Gradients']['Bot']
            if Data['LastGradTop'] ~= GradTop or Data['LastGradBot'] ~= GradBot then
                Objects['BoxInlineGradient'].Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, GradTop),
                    ColorSequenceKeypoint.new(1, GradBot),
                })
                Data['LastGradTop'] = GradTop
                Data['LastGradBot'] = GradBot
            end
            if BoxesCfg['Filled']['Enabled'] then
                if not Objects['BoxFill'].Visible then
                    Objects['BoxFill'].Visible = true
                end
                local FillTop = BoxesCfg['Filled']['Top']
                local FillBot = BoxesCfg['Filled']['Bot']
                local FillT1 = BoxesCfg['Filled']['Transparency'][1]
                local FillT2 = BoxesCfg['Filled']['Transparency'][2]
                if Data['LastFillTop'] ~= FillTop or Data['LastFillBot'] ~= FillBot then
                    Objects['BoxFillGradient'].Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, FillTop),
                        ColorSequenceKeypoint.new(1, FillBot),
                    })
                    Data['LastFillTop'] = FillTop
                    Data['LastFillBot'] = FillBot
                end
                if Data['LastFillT1'] ~= FillT1 or Data['LastFillT2'] ~= FillT2 then
                    Objects['BoxFillGradient'].Transparency = NumSeq({NumKey(0, FillT1), NumKey(1, FillT2)})
                    Data['LastFillT1'] = FillT1
                    Data['LastFillT2'] = FillT2
                end
            else
                if Objects['BoxFill'].Visible then
                    Objects['BoxFill'].Visible = false
                end
            end
        end
    else
        if Objects['BoxGlow'].ImageTransparency ~= 1 then
            Objects['BoxGlow'].ImageTransparency = 1
        end
        if Objects['BoxOutlineHolder'].Visible then
            Objects['BoxOutlineHolder'].Visible = false
        end
        if Objects['BoxInlineHolder'].Visible then
            Objects['BoxInlineHolder'].Visible = false
        end
        if Objects['BoxFill'].Visible then
            Objects['BoxFill'].Visible = false
        end
        if Objects['CornerHolder'].Visible then
            Objects['CornerHolder'].Visible = false
        end
        for i = 1, 8 do
            if Objects['Line_' .. i].Visible then
                Objects['Line_' .. i].Visible = false
            end
        end
    end
    if TextsCfg['Name']['Enabled'] then
        if not Objects['TargetName'].Visible then
            Objects['TargetName'].Visible = true
        end
        local DisplayName = Player.DisplayName
        if Data['LastDisplayName'] ~= DisplayName then
            Objects['TargetName'].Text = DisplayName
            Data['LastDisplayName'] = DisplayName
        end
        local NameColor = TextsCfg['Name']['Color']
        if Data['LastNameColor'] ~= NameColor then
            Objects['TargetName'].TextColor3 = NameColor
            Data['LastNameColor'] = NameColor
        end
    else
        if Objects['TargetName'].Visible then
            Objects['TargetName'].Visible = false
        end
    end
    if TextsCfg['Distance']['Enabled'] then
        if not Objects['Distance'].Visible then
            Objects['Distance'].Visible = true
        end
        if Data['LastDist'] ~= Distance then
            Objects['Distance'].Text = Format('%dst', Distance)
            Data['LastDist'] = Distance
        end
        local DistColor = TextsCfg['Distance']['Color']
        if Data['LastDistColor'] ~= DistColor then
            Objects['Distance'].TextColor3 = DistColor
            Data['LastDistColor'] = DistColor
        end
    else
        if Objects['Distance'].Visible then
            Objects['Distance'].Visible = false
        end
    end
    local HealthCfg = Table['Bars']['Health Bar']
    local ArmorCfg = Table['Bars']['Armor Bar']
    if HealthCfg['Enabled'] then
        local Health = Data['Health'] or 0
        local MaxHealth = Data['MaxHealth'] or 100
        local Ratio = Clamp(Health / MaxHealth, 0, 1)
        if not Objects['LeftBarHolder'].Visible then
            Objects['LeftBarHolder'].Visible = true
        end
        if not Objects['HealthBarOutline'].Visible then
            Objects['HealthBarOutline'].Visible = true
        end
        if Data['LastRatio'] ~= Ratio then
            Objects['HealthBar'].Size = Dim2(1, 0, Ratio, 0)
            Data['LastRatio'] = Ratio
        end
        local GradTop = HealthCfg['Top']
        local GradMid = HealthCfg['Mid']
        local GradBot = HealthCfg['Bot']
        if Data['LastHealthTop'] ~= GradTop or Data['LastHealthMid'] ~= GradMid or Data['LastHealthBot'] ~= GradBot then
            Objects['HealthBarGradient'].Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, GradTop),
                ColorSequenceKeypoint.new(0.5, GradMid),
                ColorSequenceKeypoint.new(1, GradBot),
            })
            Data['LastHealthTop'] = GradTop
            Data['LastHealthMid'] = GradMid
            Data['LastHealthBot'] = GradBot
        end
        if HealthCfg['Enabled'] then
            if not Objects['HealthBarText'].Visible then
                Objects['HealthBarText'].Visible = true
            end
            local FlooredHealth = Floor(Health)
            if Data['LastHealthFloor'] ~= FlooredHealth then
                Objects['HealthBarText'].Text = Format('%d', FlooredHealth)
                Objects['HealthBarText'].Position = Dim2(1, -10, 1 - Ratio, 1)
                Data['LastHealthFloor'] = FlooredHealth
            end
        else
            if Objects['HealthBarText'].Visible then
                Objects['HealthBarText'].Visible = false
            end
        end
    else
        if Objects['HealthBarOutline'].Visible then
            Objects['HealthBarOutline'].Visible = false
        end
        if Objects['HealthBarText'].Visible then
            Objects['HealthBarText'].Visible = false
        end
        if not ArmorCfg['Enabled'] then
            if Objects['LeftBarHolder'].Visible then
                Objects['LeftBarHolder'].Visible = false
            end
        end
    end
    if ArmorCfg['Enabled'] then
        local Ratio = Clamp(Data['Armor'] / Data['MaxArmor'], 0, 1)
        if not Objects['BottomBarHolder'].Visible then
            Objects['BottomBarHolder'].Visible = true
        end
        if not Objects['ArmorBarOutline'].Visible then
            Objects['ArmorBarOutline'].Visible = true
        end
        if Data['LastArmorRatio'] ~= Ratio then
            Objects['ArmorBar'].Size = Dim2(Ratio, 0, 1, 0)
            Data['LastArmorRatio'] = Ratio
        end
        local GradTop = ArmorCfg['Top']
        local GradMid = ArmorCfg['Mid']
        local GradBot = ArmorCfg['Bot']
        if Data['LastArmorTop'] ~= GradTop or Data['LastArmorMid'] ~= GradMid or Data['LastArmorBot'] ~= GradBot then
            Objects['ArmorBarGradient'].Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, GradTop),
                ColorSequenceKeypoint.new(0.5, GradMid),
                ColorSequenceKeypoint.new(1, GradBot),
            })
            Data['LastArmorTop'] = GradTop
            Data['LastArmorMid'] = GradMid
            Data['LastArmorBot'] = GradBot
        end
        if Ratio < 1 then
            if not Objects['ArmorBarText'].Visible then
                Objects['ArmorBarText'].Visible = true
            end
            local FlooredArmor = Floor(Data['Armor'])
            if Data['LastArmorFloor'] ~= FlooredArmor then
                Objects['ArmorBarText'].Text = Format('%d', FlooredArmor)
                Data['LastArmorFloor'] = FlooredArmor
            end
        else
            if Objects['ArmorBarText'].Visible then
                Objects['ArmorBarText'].Visible = false
            end
        end
    else
        if Objects['BottomBarHolder'].Visible then
            Objects['BottomBarHolder'].Visible = false
        end
        if Objects['ArmorBarOutline'].Visible then
            Objects['ArmorBarOutline'].Visible = false
        end
        if Objects['ArmorBarText'].Visible then
            Objects['ArmorBarText'].Visible = false
        end
    end
    local WeaponCfg = TextsCfg['Weapon']
    if WeaponCfg['Enabled'] then
        if not Objects['Weapon'].Visible then
            Objects['Weapon'].Visible = true
        end
        local CurrentTool = Data['CurrentTool'] or 'none'
        if Data['LastWeapon'] ~= CurrentTool then
            Objects['Weapon'].Text = CurrentTool
            Data['LastWeapon'] = CurrentTool
        end
        local WeaponColor = WeaponCfg['Color']
        if Data['LastWeaponColor'] ~= WeaponColor then
            Objects['Weapon'].TextColor3 = WeaponColor
            Data['LastWeaponColor'] = WeaponColor
        end
    else
        if Objects['Weapon'].Visible then
            Objects['Weapon'].Visible = false
        end
    end

    -- ESP Tracers
    if Table['Tracers']['Enabled'] then
        local rootPart = Data['RootPart']
        if rootPart then
            local rootPos = rootPart.Position
            local screenPos, onScreen = WorldToViewportPoint(Camera, rootPos)
            if onScreen then
                local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local startPos = Vector2.new(screenPos.X, screenPos.Y)
                if Drawing then
                    local line = Drawing.new("Line")
                    line.From = startPos
                    line.To = center
                    line.Color = Table['Tracers']['Color']
                    line.Transparency = Table['Tracers']['Transparency']
                    line.Thickness = 1.5
                    line.Visible = true
                    task.delay(0.05, function()
                        line:Remove()
                    end)
                end
            end
        end
    end
end

do
    Library:CreateThreads('Renderer', RunService.RenderStepped, function()
        if not Table['Enabled'] then
            for _, Data in Library['Cache'] do
                if Data['Objects']['TargetHolder'].Visible then
                    Data['Objects']['TargetHolder'].Visible = false
                end;
            end;
            return
        end;
        local Now = os.clock();
        if Now - Updates < Frame then
            return;
        end;
        Updates = Now;
        CameraPosition = Camera.CFrame.Position;
        for Player, Data in Library['Cache'] do
            Library:Update(Player, Data)
        end
    end)
end

do
    for _, Player in Players:GetPlayers() do
        Library:AddTarget(Player)
    end
    Library:CreateThreads('PlayerAdded', Players.PlayerAdded, function(Player)
        Library:AddTarget(Player)
    end)
    Library:CreateThreads('PlayerRemoving', Players.PlayerRemoving, function(Player)
        Library:RemoveTarget(Player)
    end)
end

do
    function Library:Unload()
        for Player in self['Cache'] do
            self:RemoveTarget(Player);
        end;
        for _, Conn in self['Connections'] do
            Conn:Disconnect();
        end;
        Clear(self['Connections']);
        for _, Conn in self['Threads'] do
            Conn:Disconnect();
        end;
        Clear(self['Threads']);
        if self['Holder'] then
            self['Holder']:Destroy();
            self['Holder'] = nil;
        end;
        Clear(self['Cache']);
    end
end

local ESPLib = getgenv().Library

-- ============================================================
-- 3. SETTINGS (Settings)
-- ============================================================
local Settings = {
    esp = false,
    espBox = true,
    espName = true,
    espDistance = true,
    espTracer = true,
    espHealth = true,
    showRoles = true,
    showLocalPlayer = false,
    silent = false,
    autoGrab = false,
    fly = false,
    noclip = false,
    speed = 16,
    jumpPower = 50,
    auraEnabled = false,
    auraColor = Color3.fromRGB(180, 100, 255),
    auraType = "angel",
    spin = false,
    infJump = false,
    showWatermark = true,
    showHotkeys = true,
    autoFarm = false,
    farmMode = "Underground",
    tweenSpeed = 25,
    autoReset = true,
    avoidMurder = true,
    coinLimit = 40,
    undergroundOffset = 4,
    maxDistance = 600,
    bombJumpDelay = 0.3,
    fakeHeadless = false,
    fakeKorblox = false,
    aimPart = "HumanoidRootPart",
    silentPredictionMode = "Auto",
    silentPredictionMs = 100,
    wallbang = false,
    realisticShaders = false,
    autoEZ = false,
    bhopEnabled = false,
    bhopSpeed = 35,
    bhopMultiplier = 1.2,
    antiFling = false,
    forceShoot = false,
    bulletTracer = false,
    bulletTracerColor = Color3.fromRGB(180, 230, 255),
    selfChamsOutline = false,
    tpToolEnabled = false,
    tpToolActive = false,
}

local Keybinds = {
    silent = "E",
    autoGrab = "G",
    fly = "F",
    noclip = "N",
    spin = "Z",
    infJump = "X",
    killAll = "K",
    grabGun = "Y",
    autoShoot = "R",
    bombJump = "B",
    teleportMurderer = "M",
    teleportSheriff = "J",
    forceShoot = "T",
}

-- ============================================================
-- 4. ROLES (Role Flags)
-- ============================================================
local Roles = {}
local function UpdateRoles()
    local getData = ReplicatedStorage:FindFirstChild("Remotes", true)
    if getData then
        getData = getData:FindFirstChild("Gameplay", true)
        if getData then
            getData = getData:FindFirstChild("GetCurrentPlayerData", true)
        end
    end
    if getData then
        local success, result = pcall(function()
            return getData:InvokeServer()
        end)
        if success and type(result) == "table" then
            for playerName, info in pairs(result) do
                if type(info) == "table" and info.Role then
                    local player = Players:FindFirstChild(playerName)
                    if player then
                        Roles[player] = tostring(info.Role)
                    end
                end
            end
        end
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local role = Roles[player] or "Innocent"
        if player.Character then
            if player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife") then
                role = "Murderer"
            elseif player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") then
                role = "Sheriff"
            end
        end
        Roles[player] = role
    end
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            UpdateRoles()
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        UpdateRoles()
    end)
end)

task.spawn(function()
    while true do
        UpdateRoles()
        task.wait(1.5)
    end
end)

local function ExtendESP()
    local Library = getgenv().Library
    if not Library then return end

    local originalUpdate = Library.Update
    Library.Update = function(self, Player, Data)
        originalUpdate(self, Player, Data)
        local Objects = Data.Objects
        if not Objects["RoleLabel"] then
            Objects["RoleLabel"] = self:CreateObjects("TextLabel", {
                Parent = Objects["TopTextHolder"],
                FontFace = Library.TahomaBold,
                TextSize = 11,
                LayoutOrder = 1,
                TextColor3 = Color3.fromRGB(255,255,255),
                Text = "",
                TextXAlignment = Enum.TextXAlignment.Center,
                BorderSizePixel = 0,
                Visible = false,
                BackgroundTransparency = 1,
                ZIndex = 5,
                AutomaticSize = Enum.AutomaticSize.XY,
                Size = Dim2(0,0,0,0),
            })
            self:CreateObjects("UIStroke", {
                Parent = Objects["RoleLabel"],
                Color = Color3.fromRGB(0,0,0),
                LineJoinMode = Enum.LineJoinMode.Miter,
            })
        end
        if not Settings.showRoles then
            Objects["RoleLabel"].Visible = false
            return
        end
        local role = Roles[Player] or "Unknown"
        local color = role == "Murderer" and Color3.fromRGB(255,50,50) or
                      role == "Sheriff" and Color3.fromRGB(50,100,255) or
                      role == "Hero" and Color3.fromRGB(255,215,0) or
                      Color3.fromRGB(50,255,50)
        Objects["RoleLabel"].Text = "[" .. role .. "]"
        Objects["RoleLabel"].TextColor3 = color
        Objects["RoleLabel"].Visible = true
    end

    for player, data in pairs(Library.Cache) do
        if not data.Objects["RoleLabel"] then
            data.Objects["RoleLabel"] = Library:CreateObjects("TextLabel", {
                Parent = data.Objects["TopTextHolder"],
                FontFace = Library.TahomaBold,
                TextSize = 11,
                LayoutOrder = 1,
                TextColor3 = Color3.fromRGB(255,255,255),
                Text = "",
                TextXAlignment = Enum.TextXAlignment.Center,
                BorderSizePixel = 0,
                Visible = false,
                BackgroundTransparency = 1,
                ZIndex = 5,
                AutomaticSize = Enum.AutomaticSize.XY,
                Size = Dim2(0,0,0,0),
            })
            Library:CreateObjects("UIStroke", {
                Parent = data.Objects["RoleLabel"],
                Color = Color3.fromRGB(0,0,0),
                LineJoinMode = Enum.LineJoinMode.Miter,
            })
        end
    end
end

-- ============================================================
-- 5. AURA
-- ============================================================
local AuraParticles = {}
local AuraCache = {}
local AURA_IDS = {
    angel = "97658130917593",
    starlight = "134645216613107",
    heavenly = "139300897520961",
    ribbon = "132069507632161",
    sakura = "81755778619404",
    wind = "80694081850877",
    flow = "119913533725648",
    star = "73754563740680",
    wings = "90816193741219",
}
local AURA_ORDER = {"angel", "starlight", "heavenly", "ribbon", "sakura", "wind", "flow", "star", "wings"}

local function ClearAura()
    for _, p in ipairs(AuraParticles) do pcall(function() p:Destroy() end) end
    AuraParticles = {}
end

local function LoadAura(name)
    if AuraCache[name] then return AuraCache[name] end
    local id = AURA_IDS[name]
    if not id then return nil end
    local success, result = pcall(game.GetObjects, game, "rbxassetid://" .. id)
    if success and result and result[1] then
        AuraCache[name] = result[1]
        return result[1]
    end
    return nil
end

local function ColorAura(model, color)
    local seq = ColorSequence.new(color)
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("PointLight") then
            descendant.Color = color
        elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") or descendant:IsA("Trail") then
            descendant.Color = seq
        end
    end
end

local function ApplyAura()
    ClearAura()
    if not Settings.auraEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local model = LoadAura(Settings.auraType)
    if model then
        ColorAura(model, Settings.auraColor)
        local cloned = model:Clone()
        for _, part in ipairs(cloned:GetChildren()) do
            local target = char:FindFirstChild(part.Name)
            if target and target:IsA("BasePart") then
                for _, child in ipairs(part:GetChildren()) do
                    child.Parent = target
                    table.insert(AuraParticles, child)
                end
            end
        end
        cloned:Destroy()
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.2)
    if Settings.auraEnabled then ApplyAura() end
end)

-- ============================================================
-- 6. SILENT AIM WITH WALLBANG, RESOLVER, TRACER
-- ============================================================
local VelocityHistory = {}
local PingHistory = {}
local EstimatedPing = 0.05

task.spawn(function()
    while true do
        local currentPing = 0.05
        pcall(function()
            currentPing = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
        end)
        table.insert(PingHistory, 1, currentPing)
        while #PingHistory > 10 do table.remove(PingHistory) end
        local sum = 0
        for _, v in ipairs(PingHistory) do sum = sum + v end
        EstimatedPing = #PingHistory > 0 and (sum / #PingHistory) or 0.05
        task.wait(0.05)
    end
end)

RunService.Heartbeat:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        if not VelocityHistory[player] then
            VelocityHistory[player] = {}
        end
        table.insert(VelocityHistory[player], 1, root.AssemblyLinearVelocity)
        while #VelocityHistory[player] > 5 do
            table.remove(VelocityHistory[player])
        end
    end
end)

local function GetFilteredVelocity(player, rawVelocity)
    if not Settings.wallbang then return rawVelocity end
    local history = VelocityHistory[player]
    if not history or #history == 0 then return rawVelocity end
    local sum = Vector3.zero
    for _, vel in ipairs(history) do
        sum = sum + vel
    end
    return sum / #history
end

local function GetResolvedPosition(target)
    if not target or not target.Character then return nil end
    local char = target.Character
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum or hum.Health <= 0 then return nil end

    local currentPos = root.Position
    local velocity = GetFilteredVelocity(target, root.AssemblyLinearVelocity)

    local baseDelay = 0.062
    local pingDelay = 0
    if Settings.silentPredictionMode == "Auto" then
        pingDelay = EstimatedPing
    else
        pingDelay = Settings.silentPredictionMs / 1000
    end
    pingDelay = math.min(pingDelay, 0.070)
    local totalDelay = baseDelay + pingDelay

    local bulletSpeed = 1500
    local dist = (Camera.CFrame.Position - currentPos).Magnitude
    local travelTime = dist / bulletSpeed
    totalDelay = totalDelay + travelTime

    local horizontalMultiplier = 1.84
    local verticalMultiplier = 1.72
    local horizontalVel = Vector3.new(velocity.X, 0, velocity.Z) * horizontalMultiplier
    local verticalVelY = velocity.Y * verticalMultiplier

    local predictedHorizontal = currentPos + (horizontalVel * totalDelay)
    local predictedY = currentPos.Y + (verticalVelY * totalDelay)

    local state = hum:GetState()
    if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then
        predictedY = predictedY - (0.5 * 196.2 * totalDelay * totalDelay)
    elseif state == Enum.HumanoidStateType.Swimming then
        predictedY = predictedY + 0.5
    end

    local animTrack = hum:FindFirstChild("Animator") and hum.Animator:FindFirstChild("AnimationTrack")
    if animTrack and animTrack.IsPlaying then
        predictedY = predictedY + 0.15
    end

    return Vector3.new(predictedHorizontal.X, predictedY, predictedHorizontal.Z)
end

local function GetMurderer()
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        if char:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife") then
            return player
        end
    end
    return nil
end

local function GetPredictedPosition(target)
    if Settings.wallbang then
        return GetResolvedPosition(target)
    else
        local char = target.Character
        local root = char and char:FindFirstChild(Settings.aimPart) or char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return nil end
        local vel = root.AssemblyLinearVelocity
        local predictionMs
        if Settings.silentPredictionMode == "Auto" then
            local ping = Stats.Network.ServerStatsItem.DataPing:GetValue() or 0
            predictionMs = ping
        else
            predictionMs = Settings.silentPredictionMs
        end
        local timeSec = predictionMs / 1000
        return root.Position + vel * timeSec
    end
end

local function EquipGun(character)
    if character:FindFirstChild("Gun") then return true end
    local gun = LocalPlayer.Backpack:FindFirstChild("Gun")
    local hum = character:FindFirstChildOfClass("Humanoid")
    if gun and hum then
        hum:EquipTool(gun)
        return true
    end
    return false
end

local Tracers = {}
local function CreateTracer(origin, target)
    if not Settings.bulletTracer then return end
    local distance = (target - origin).Magnitude
    if distance > 500 then return end

    local ray = Instance.new("Part")
    ray.Name = "BulletTracer"
    ray.Size = Vector3.new(0.2, 0.2, distance)
    ray.CFrame = CFrame.lookAt(origin, target) * CFrame.new(0, 0, -distance/2)
    ray.Anchored = true
    ray.CanCollide = false
    ray.Material = Enum.Material.Neon
    ray.Color = Settings.bulletTracerColor
    ray.Transparency = 0.2
    ray.Parent = Workspace

    local att = Instance.new("Attachment", ray)
    local beam = Instance.new("Beam", ray)
    beam.Attachment0 = att
    beam.Attachment1 = att
    beam.Texture = "rbxassetid://6327798571"
    beam.Width0 = 3
    beam.Width1 = 3
    beam.Color = ColorSequence.new(Settings.bulletTracerColor)
    beam.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.5, 0.3),
        NumberSequenceKeypoint.new(1, 0.1),
    })

    local startTime = tick()
    table.insert(Tracers, {ray = ray, start = startTime})

    task.spawn(function()
        while ray and ray.Parent and (tick() - startTime) < 2 do
            local alpha = 1 - (tick() - startTime) / 2
            ray.Transparency = 0.2 + (1 - alpha) * 0.8
            beam.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.1 * alpha),
                NumberSequenceKeypoint.new(0.5, 0.3 * alpha),
                NumberSequenceKeypoint.new(1, 0.1 * alpha),
            })
            task.wait()
        end
        if ray and ray.Parent then ray:Destroy() end
    end)
end

task.spawn(function()
    while true do
        task.wait(5)
        for i = #Tracers, 1, -1 do
            local t = Tracers[i]
            if not t.ray or not t.ray.Parent or (tick() - t.start) > 2.5 then
                if t.ray and t.ray.Parent then t.ray:Destroy() end
                table.remove(Tracers, i)
            end
        end
    end
end)

local function Fire(gun, origin, targetPosition)
    if Settings.bulletTracer then
        task.spawn(function()
            CreateTracer(origin, targetPosition)
        end)
    end

    local shootRemote = gun:FindFirstChild("Shoot") or (gun:FindFirstChild("Events") and gun.Events:FindFirstChild("Shoot"))
    if shootRemote then
        if Settings.wallbang then
            local lookAt = CFrame.lookAt(origin, targetPosition)
            pcall(function()
                shootRemote:FireServer(CFrame.new(origin), CFrame.new(targetPosition))
            end)
            pcall(function()
                shootRemote:FireServer(lookAt)
            end)
            pcall(function()
                shootRemote:FireServer(origin, targetPosition)
            end)
        else
            shootRemote:FireServer(CFrame.new(origin), CFrame.new(targetPosition))
        end
        return
    end

    local knifeLocal = gun:FindFirstChild("KnifeLocal")
    local createBeam = knifeLocal and knifeLocal:FindFirstChild("CreateBeam")
    if createBeam then
        createBeam:InvokeServer(1, targetPosition, "AH2")
        return
    end

    local remoteEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
    if remoteEvent then
        local gameplay = remoteEvent:FindFirstChild("Gameplay")
        if gameplay then
            local shoot = gameplay:FindFirstChild("Shoot") or gameplay:FindFirstChild("Fire")
            if shoot then
                shoot:FireServer(origin, targetPosition)
                return
            end
        end
    end
end

local function AttemptShoot(force)
    local char = LocalPlayer.Character
    if not char then return end
    local murderer = GetMurderer()
    if not murderer then return end
    local targetPart = murderer.Character and murderer.Character:FindFirstChild(Settings.aimPart) or murderer.Character:FindFirstChild("HumanoidRootPart")
    if not targetPart then return end

    task.spawn(function()
        if not EquipGun(char) then
            if force then
                local gun = LocalPlayer.Backpack:FindFirstChild("Gun")
                if gun then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then hum:EquipTool(gun) end
                end
            end
            return
        end
        local gun = char:FindFirstChild("Gun")
        local rightHand = char:FindFirstChild("RightHand")
        if not gun or not rightHand then return end
        local predicted = GetPredictedPosition(murderer) or targetPart.Position
        Fire(gun, rightHand.Position, predicted)
    end)
end

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    local key = input.KeyCode.Name
    local char = LocalPlayer.Character

    if key == Keybinds.silent and Settings.silent then
        if char and char:FindFirstChild("Gun") then
            AttemptShoot(false)
        end
    end

    if key == Keybinds.forceShoot then
        Settings.forceShoot = not Settings.forceShoot
        if Settings.forceShoot then
            AttemptShoot(true)
        end
    end
end)

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Gun") and Settings.silent then
            AttemptShoot(false)
        end
    end
end)

-- ============================================================
-- 7. REALISTIC SHADERS
-- ============================================================
local shaderObjects = {}

local function ApplyRealisticShaders()
    for _, obj in ipairs(shaderObjects) do
        pcall(function() obj:Destroy() end)
    end
    shaderObjects = {}

    if not Settings.realisticShaders then
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
        Lighting.ShadowSoftness = 0
        Lighting.Technology = Enum.Technology.Legacy
        Lighting.ClockTime = 14
        Lighting.GeographicLatitude = 0
        Lighting.ExposureCompensation = 0
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.FogColor = Color3.fromRGB(127, 127, 127)
        pcall(function()
            Lighting.EnvironmentSpecularScale = 0
            Lighting.EnvironmentDiffuseScale = 1
        end)

        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("BloomEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") or effect:IsA("DepthOfFieldEffect") then
                if effect.Name == "WizardShader" then
                    effect:Destroy()
                end
            end
        end
        return
    end

    Lighting.Brightness = 0.6
    Lighting.Ambient = Color3.fromRGB(30, 30, 40)
    Lighting.OutdoorAmbient = Color3.fromRGB(40, 45, 55)
    Lighting.ShadowSoftness = 0.7
    Lighting.Technology = Enum.Technology.ShadowMap
    Lighting.ClockTime = 1
    Lighting.GeographicLatitude = 55
    Lighting.ExposureCompensation = -0.2
    Lighting.FogStart = 30
    Lighting.FogEnd = 250
    Lighting.FogColor = Color3.fromRGB(10, 10, 15)

    pcall(function()
        Lighting.EnvironmentSpecularScale = 2.5
        Lighting.EnvironmentDiffuseScale = 1.8
    end)

    local bloom = Instance.new("BloomEffect")
    bloom.Name = "WizardShader"
    bloom.Parent = Lighting
    bloom.Enabled = true
    bloom.Intensity = 0.8
    bloom.Size = 5
    bloom.Threshold = 0.6
    table.insert(shaderObjects, bloom)

    local sunRays = Instance.new("SunRaysEffect")
    sunRays.Name = "WizardShader"
    sunRays.Parent = Lighting
    sunRays.Enabled = true
    sunRays.Intensity = 0.4
    sunRays.Spread = 0.2
    table.insert(shaderObjects, sunRays)

    local dof = Instance.new("DepthOfFieldEffect")
    dof.Name = "WizardShader"
    dof.Parent = Lighting
    dof.Enabled = true
    dof.FarIntensity = 0.4
    dof.NearIntensity = 0.1
    dof.FocusDistance = 40
    dof.InFocusRadius = 25
    table.insert(shaderObjects, dof)

    local cc = Instance.new("ColorCorrectionEffect")
    cc.Name = "WizardShader"
    cc.Parent = Lighting
    cc.Enabled = true
    cc.Contrast = 0.15
    cc.Brightness = 0.0
    cc.Saturation = 0.3
    cc.TintColor = Color3.fromRGB(200, 180, 160)
    table.insert(shaderObjects, cc)
end

-- ============================================================
-- 8. AUTO EZ
-- ============================================================
local GRIDDY_EMOTE_ID = 106715239721951

local function PlayGriddyEmote()
    if not Settings.autoEZ then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    local success, err = pcall(function()
        hum:LoadAnimation(GRIDDY_EMOTE_ID)
    end)
    if not success then
        local emoteRemote = ReplicatedStorage:FindFirstChild("EmoteRemote", true)
        if emoteRemote then
            pcall(function()
                emoteRemote:FireServer(GRIDDY_EMOTE_ID)
            end)
        end
    end
end

local function SetupAutoEZ()
    local function onPlayerDied(player)
        if player == LocalPlayer then return end
        if Roles[player] == "Murderer" then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Gun") then
                PlayGriddyEmote()
            end
        end
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            player.CharacterAdded:Connect(function(char)
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.Died:Connect(function()
                        onPlayerDied(player)
                    end)
                end
            end)
        end
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Died:Connect(function()
                    if Roles[player] == "Murderer" then
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("Gun") then
                            PlayGriddyEmote()
                        end
                    end
                end)
            end
        end)
    end)
end

task.spawn(SetupAutoEZ)

-- ============================================================
-- 9. BHOP (fixed)
-- ============================================================
local bhopState = {
    enabled = false,
    connection = nil,
    bodyVelocity = nil,
    lastJump = 0,
}

local function stopBHop()
    bhopState.enabled = false
    if bhopState.connection then
        bhopState.connection:Disconnect()
        bhopState.connection = nil
    end
    if bhopState.bodyVelocity then
        pcall(function() bhopState.bodyVelocity:Destroy() end)
        bhopState.bodyVelocity = nil
    end
end

local function startBHop()
    if bhopState.enabled then return end
    bhopState.enabled = true
    bhopState.lastJump = 0

    bhopState.connection = RunService.Heartbeat:Connect(function()
        if not bhopState.enabled then
            stopBHop()
            return
        end

        local char = LocalPlayer.Character
        if not char then
            return
        end

        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then
            return
        end
        if hum.Health <= 0 then
            return
        end

        local moveDir = hum.MoveDirection
        local isMoving = moveDir.Magnitude > 0.1

        if not bhopState.bodyVelocity or not bhopState.bodyVelocity.Parent then
            if bhopState.bodyVelocity then
                pcall(function() bhopState.bodyVelocity:Destroy() end)
            end
            bhopState.bodyVelocity = Instance.new("BodyVelocity")
            bhopState.bodyVelocity.MaxForce = Vector3.new(1e6, 0, 1e6)
            bhopState.bodyVelocity.Parent = hrp
        end

        if isMoving then
            local horizontal = Vector3.new(moveDir.X, 0, moveDir.Z).Unit
            local speed = Settings.bhopSpeed * Settings.bhopMultiplier
            bhopState.bodyVelocity.Velocity = horizontal * speed
        else
            bhopState.bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end

        local state = hum:GetState()
        local onGround = (state == Enum.HumanoidStateType.Running or
                          state == Enum.HumanoidStateType.Landed or
                          state == Enum.HumanoidStateType.RunningNoPhysics)
        if isMoving and onGround and tick() - bhopState.lastJump > 0.15 then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            bhopState.lastJump = tick()
        end
    end)

    print("BHOP enabled")
end

local function toggleBHop(value)
    Settings.bhopEnabled = value
    if value then
        startBHop()
    else
        stopBHop()
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    if Settings.bhopEnabled then
        stopBHop()
        task.wait(0.3)
        startBHop()
    end
end)

-- ============================================================
-- 10. FLY
-- ============================================================
local flyBodyVelocity = nil
local flyConnection = nil

local function ToggleFly(state)
    Settings.fly = (state == nil) and not Settings.fly or state

    if Settings.fly then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = true
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                if not flyBodyVelocity then
                    flyBodyVelocity = Instance.new("BodyVelocity")
                    flyBodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 10000
                    flyBodyVelocity.Parent = root
                end
            end
        end

        if not flyConnection then
            flyConnection = RunService.Heartbeat:Connect(function()
                if not Settings.fly then
                    return
                end
                local char = LocalPlayer.Character
                if not char then
                    return
                end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then
                    return
                end
                if not flyBodyVelocity or not flyBodyVelocity.Parent then
                    if flyBodyVelocity then
                        flyBodyVelocity:Destroy()
                    end
                    flyBodyVelocity = Instance.new("BodyVelocity")
                    flyBodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 10000
                    flyBodyVelocity.Parent = root
                end

                local moveDir = Vector3.new(0, 0, 0)
                if UIS:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(0, 0, -1)
                end
                if UIS:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir + Vector3.new(0, 0, 1)
                end
                if UIS:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir + Vector3.new(-1, 0, 0)
                end
                if UIS:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(1, 0, 0)
                end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + Vector3.new(0, 1, 0)
                end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDir = moveDir + Vector3.new(0, -1, 0)
                end

                local cam = Workspace.CurrentCamera
                if cam and flyBodyVelocity then
                    local worldDir = cam.CFrame:VectorToWorldSpace(moveDir)
                    flyBodyVelocity.Velocity = worldDir * 50
                end
            end)
        end
    else
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = false
            end
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    if Settings.fly then
        ToggleFly(false)
        task.wait(0.1)
        ToggleFly(true)
    end
end)

-- ============================================================
-- 11. ANTI-FLING
-- ============================================================
local antiFlingConnection = nil

local function SetupAntiFling()
    if antiFlingConnection then
        antiFlingConnection:Disconnect()
        antiFlingConnection = nil
    end

    if not Settings.antiFling then
        return
    end

    local function disableCollision(character)
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    antiFlingConnection = RunService.Stepped:Connect(function()
        if not Settings.antiFling then
            antiFlingConnection:Disconnect()
            antiFlingConnection = nil
            return
        end

        local char = LocalPlayer.Character
        if not char then return end

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                disableCollision(player.Character)
            end
        end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            if hrp.AssemblyLinearVelocity.Magnitude > 150 then
                hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
            if hrp.AssemblyAngularVelocity.Magnitude > 150 then
                hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end
    end)
end

-- ============================================================
-- 12. SELF CHAMS (Outline only)
-- ============================================================
local selfChamsHighlight = nil

local function ApplySelfChams()
    if selfChamsHighlight then
        selfChamsHighlight:Destroy()
        selfChamsHighlight = nil
    end

    local char = LocalPlayer.Character
    if not char then
        return
    end

    if Settings.selfChamsOutline then
        selfChamsHighlight = Instance.new("Highlight")
        selfChamsHighlight.Parent = char
        selfChamsHighlight.FillColor = Color3.new(0, 0, 0)
        selfChamsHighlight.FillTransparency = 1
        selfChamsHighlight.OutlineColor = Color3.fromRGB(0, 200, 255)
        selfChamsHighlight.OutlineTransparency = 0
        selfChamsHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.2)
    ApplySelfChams()
end)

-- ============================================================
-- 13. TP TOOL
-- ============================================================
local tpTool = nil

local function CreateTPTool()
    if tpTool then
        tpTool:Destroy()
        tpTool = nil
    end
    if not Settings.tpToolEnabled then
        return
    end

    tpTool = Instance.new("Tool")
    tpTool.Name = "TP Tool"
    tpTool.RequiresHandle = false
    tpTool.Parent = LocalPlayer.Backpack

    tpTool.Equipped:Connect(function()
        Settings.tpToolActive = true
    end)
    tpTool.Unequipped:Connect(function()
        Settings.tpToolActive = false
    end)
end

local function ToggleTPTool(state)
    Settings.tpToolEnabled = state
    if state then
        CreateTPTool()
    else
        if tpTool then
            tpTool:Destroy()
            tpTool = nil
        end
    end
end

Mouse.Button1Down:Connect(function()
    if Settings.tpToolActive and tpTool and tpTool.Parent == LocalPlayer.Character then
        local target = Mouse.Target
        if target and target:IsA("BasePart") then
            local pos = target.Position + Vector3.new(0, 2, 0)
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(pos)
                end
            end
        end
    end
end)

-- ============================================================
-- 14. UTILITY FUNCTIONS
-- ============================================================
local function GrabGun()
    task.spawn(function()
        if not LocalPlayer.Character then return end
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                obj.CFrame = root.CFrame
                break
            end
        end
    end)
end

local function KillAll()
    task.spawn(function()
        local char = LocalPlayer.Character
        if not char then return end
        local knife = char:FindFirstChild("Knife")
        if not knife then
            knife = LocalPlayer.Backpack:FindFirstChild("Knife")
            if knife then knife.Parent = char end
        end
        if not knife then return end
        local handle = knife:FindFirstChild("Handle")
        if not handle then return end
        local events = knife:FindFirstChild("Events")
        if not events then return end
        local handleTouched = events:FindFirstChild("HandleTouched")
        if not handleTouched then return end
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local torso = player.Character:FindFirstChild("UpperTorso") or player.Character:FindFirstChild("Torso")
                if torso then handleTouched:FireServer(torso) end
            end
        end
    end)
end

local spinAngle = 0
local function UpdateSpin()
    if not Settings.spin then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    spinAngle = spinAngle + 0.05
    root.CFrame = root.CFrame * CFrame.Angles(0, spinAngle, 0)
end

RunService.Heartbeat:Connect(UpdateSpin)

UIS.JumpRequest:Connect(function()
    if Settings.infJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

RunService.Stepped:Connect(function()
    if not Settings.noclip then return end
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not Settings.autoGrab then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" and obj:IsA("BasePart") then
            obj.CFrame = root.CFrame
            break
        end
    end
end)

local bombJumpCooldown = false
local function PerformBombJump()
    if bombJumpCooldown then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    bombJumpCooldown = true
    hum:ChangeState(Enum.HumanoidStateType.Jumping)
    task.wait(Settings.bombJumpDelay or 0.3)
    if hum and hum.Parent then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
    task.wait(0.5)
    bombJumpCooldown = false
end

local function TeleportToPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    localRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 2, 2)
end

local function TeleportToMurderer()
    local murderer = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and (char:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")) then
                murderer = player
                break
            end
        end
    end
    if murderer then
        TeleportToPlayer(murderer)
    else
        warn("Murderer not found")
    end
end

local function TeleportToSheriff()
    local sheriff = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and (char:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")) then
                sheriff = player
                break
            end
        end
    end
    if sheriff then
        TeleportToPlayer(sheriff)
    else
        warn("Sheriff not found")
    end
end

-- ============================================================
-- 15. FAKE HEADLESS / KORBLOX
-- ============================================================
local originalTransparency = {}
local function ApplyFakeHeadless()
    local char = LocalPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if head then
        head.Transparency = Settings.fakeHeadless and 1 or (originalTransparency[head] or 0)
        for _, v in pairs(head:GetChildren()) do
            if v:IsA("Decal") then
                v.Transparency = Settings.fakeHeadless and 1 or 0
            end
        end
    end
end

local function ApplyFakeKorblox()
    local char = LocalPlayer.Character
    if not char then return end
    local rightLowerLeg = char:FindFirstChild("RightLowerLeg")
    local rightUpperLeg = char:FindFirstChild("RightUpperLeg")
    local rightFoot = char:FindFirstChild("RightFoot")
    
    if Settings.fakeKorblox then
        if rightLowerLeg then
            rightLowerLeg.MeshId = "902942093"
            rightLowerLeg.Transparency = 1
        end
        if rightUpperLeg then
            rightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
            rightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
        end
        if rightFoot then
            rightFoot.MeshId = "902942089"
            rightFoot.Transparency = 1
        end
    else
        if rightLowerLeg then
            rightLowerLeg.MeshId = ""
            rightLowerLeg.Transparency = originalTransparency[rightLowerLeg] or 0
        end
        if rightUpperLeg then
            rightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=903064014"
            rightUpperLeg.TextureID = ""
        end
        if rightFoot then
            rightFoot.MeshId = ""
            rightFoot.Transparency = originalTransparency[rightFoot] or 0
        end
    end
end

local function UpdateFakeAppearance()
    ApplyFakeHeadless()
    ApplyFakeKorblox()
end

-- ============================================================
-- 16. RESPAWN HANDLER
-- ============================================================
local function OnCharacterAdded(character)
    local hum = character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.PlatformStand = false
        hum.WalkSpeed = Settings.speed
        hum.JumpPower = Settings.jumpPower
    end
    if Settings.fly then ToggleFly(true) end
    if Settings.auraEnabled then ApplyAura() end
    if Settings.fakeHeadless or Settings.fakeKorblox then
        task.wait(0.2)
        UpdateFakeAppearance()
    end
    if Settings.antiFling then
        task.wait(0.3)
        SetupAntiFling()
    end
    if Settings.bhopEnabled then
        stopBHop()
        task.wait(0.3)
        startBHop()
    end
    ApplySelfChams()
    if Settings.tpToolEnabled then
        CreateTPTool()
    end
end

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)
if LocalPlayer.Character then OnCharacterAdded(LocalPlayer.Character) end

-- ============================================================
-- 17. AUTO FARM
-- ============================================================
local FarmState = {
    isFarming = false,
    isActivelyFlying = false,
    currentTargetCoin = nil,
    ignoredCoins = {},
    currentTween = nil,
}

local function getTorso(char)
    if not char then return nil end
    return char:FindFirstChild("Torso") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart")
end

local function getCurrentCoins()
    local ok, res = pcall(function()
        local gui = LocalPlayer.PlayerGui:FindFirstChild("MainGUI")
        if not gui then return 0 end
        local gameGui = gui:FindFirstChild("Game")
        if not gameGui then return 0 end
        local coinBags = gameGui:FindFirstChild("CoinBags")
        if not coinBags then return 0 end
        local container = coinBags:FindFirstChild("Container")
        if not container then return 0 end
        local coin = container:FindFirstChild("Coin")
        if not coin then return 0 end
        local currencyFrame = coin:FindFirstChild("CurrencyFrame")
        if not currencyFrame then return 0 end
        local icon = currencyFrame:FindFirstChild("Icon")
        if not icon then return 0 end
        local coinsText = icon:FindFirstChild("Coins")
        if not coinsText then return 0 end
        return coinsText.Text
    end)
    return ok and (tonumber(res) or 0) or 0
end

local function isRoundOver()
    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not pGui then return false end
    local victoryGui = pGui:FindFirstChild("Victory")
    if victoryGui then
        for _, child in pairs(victoryGui:GetChildren()) do
            if child:IsA("GuiObject") and child.Visible then return true end
        end
    end
    return false
end

local function isBagFull()
    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
    if pGui then
        local mainGui = pGui:FindFirstChild("MainGUI")
        if mainGui and mainGui:FindFirstChild("Lobby") and mainGui.Lobby:FindFirstChild("Dock") then
            local coinBags = mainGui.Lobby.Dock:FindFirstChild("CoinBags")
            if coinBags then
                local notification = coinBags:FindFirstChild("FullBagNotification")
                if notification and notification.Visible then return true end
            end
        end
    end
    return false
end

local function hasNearbyMurderer()
    if not Settings.avoidMurder then return false end
    
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local otherHRP = player.Character:FindFirstChild("HumanoidRootPart")
            local backpack = player:FindFirstChild("Backpack")
            
            if otherHRP and (otherHRP.Position - hrp.Position).Magnitude <= 10 then
                if player.Character:FindFirstChild("Knife") then
                    return true
                end
                if backpack and backpack:FindFirstChild("Knife") then
                    return true
                end
            end
        end
    end
    return false
end

local function getNearestCoin(torso)
    local container = nil
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "CoinContainer" then
            container = obj
            break
        end
    end
    if not container then return nil end

    local nearestCoin = nil
    local minDist = math.huge
    for _, coin in pairs(container:GetChildren()) do
        if coin.Name == "Coin_Server" and coin:IsA("BasePart") and not FarmState.ignoredCoins[coin] then
            local dist = (torso.Position - coin.Position).Magnitude
            if dist < minDist and dist <= Settings.maxDistance then
                minDist = dist
                nearestCoin = coin
            end
        end
    end
    return nearestCoin
end

local function applyFlightPhysics(char)
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return CFrame.Angles(0,0,0) end

    local bv = hrp:FindFirstChild("FarmBV")
    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.Name = "FarmBV"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp
    end

    local bg = hrp:FindFirstChild("FarmBG")
    if not bg then
        bg = Instance.new("BodyGyro")
        bg.Name = "FarmBG"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.P = 50000
        bg.Parent = hrp
        
        local _, rotY, _ = hrp.CFrame:ToOrientation()
        bg.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, rotY, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    end
    return bg.CFrame.Rotation 
end

local function removeFarmPhysics()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        if hrp:FindFirstChild("FarmBV") then hrp.FarmBV:Destroy() end
        if hrp:FindFirstChild("FarmBG") then hrp.FarmBG:Destroy() end
        if hrp.Anchored then hrp.Anchored = false end 
    end
end

local function setupFarmNoclip()
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end
    
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end
end

local function flyToPoint(targetPos, targetCoin, hrp, torso, lockedRotation)
    local dist = (torso.Position - targetPos).Magnitude
    local tweenInfo = TweenInfo.new(dist / Settings.tweenSpeed, Enum.EasingStyle.Linear)
    local targetCFrame = CFrame.new(targetPos) * lockedRotation
    
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    FarmState.currentTween = tween
    local reached = false
    tween:Play()
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not FarmState.isFarming or not targetCoin or not targetCoin:IsDescendantOf(workspace) then 
            tween:Cancel()
            if connection then connection:Disconnect() end
            return
        end
        
        local currentDist = (torso.Position - targetPos).Magnitude
        
        if firetouchinterest then
            pcall(function()
                firetouchinterest(torso, targetCoin, 0)
                firetouchinterest(torso, targetCoin, 1)
            end)
        end
        
        if currentDist <= 1.5 then 
            reached = true
            tween:Cancel()
            if connection then connection:Disconnect() end
        end
    end)
    
    while connection and connection.Connected do
        RunService.Heartbeat:Wait()
    end
    return reached
end

local function tweenToCoin(coin)
    if not coin or not coin.Parent or not coin:FindFirstChild("TouchInterest") then 
        return false 
    end
    
    local char = LocalPlayer.Character
    if not char then return false end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return false end
    
    local target = coin.Position + Vector3.new(0, 2, 0)
    
    if (hrp.Position - target).Magnitude < 5 then 
        return true 
    end
    
    if FarmState.currentTween then 
        pcall(function() FarmState.currentTween:Cancel() end) 
    end
    
    FarmState.currentTween = TweenService:Create(hrp,
        TweenInfo.new(
            (hrp.Position - target).Magnitude / Settings.tweenSpeed,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {CFrame = CFrame.new(target)}
    )
    
    hum.Sit = true
    FarmState.currentTween:Play()
    
    local done = false
    local c
    c = FarmState.currentTween.Completed:Connect(function() 
        done = true
        if c then c:Disconnect() end
    end)
    
    local t0 = tick()
    while not done and FarmState.isFarming do
        task.wait(0.1)
        
        if not coin or not coin.Parent or not coin:FindFirstChild("TouchInterest") then
            if FarmState.currentTween then 
                pcall(function() FarmState.currentTween:Cancel() end) 
            end
            hum.Sit = false
            return false
        end
        
        if tick() - t0 > 30 then
            if FarmState.currentTween then 
                pcall(function() FarmState.currentTween:Cancel() end) 
            end
            hum.Sit = false
            return false
        end
    end
    
    hum.Sit = false
    return done
end

local function collectCoin(coin)
    if not coin or not coin.Parent then return end
    
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    pcall(function()
        firetouchinterest(hrp, coin, 0)
        task.wait(0.05)
        firetouchinterest(hrp, coin, 1)
    end)
end

local function startFarming()
    if FarmState.isFarming then return end
    FarmState.isFarming = true
    
    table.clear(FarmState.ignoredCoins)

    task.spawn(function()
        while FarmState.isFarming do
            task.wait()
            
            local success, err = pcall(function()
                if hasNearbyMurderer() then
                    FarmState.isActivelyFlying = false
                    FarmState.currentTargetCoin = nil
                    removeFarmPhysics()
                    
                    local char = LocalPlayer.Character
                    if char then
                        local hum = char:FindFirstChild("Humanoid")
                        if hum then hum.Sit = false end
                    end
                    
                    task.wait(1)
                    return
                end

                local char = LocalPlayer.Character
                if not char then return end
                
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local torso = getTorso(char)
                local humanoid = char:FindFirstChild("Humanoid")
                
                if not hrp or not torso or not humanoid or humanoid.Health <= 0 then
                    FarmState.isActivelyFlying = false
                    FarmState.currentTargetCoin = nil
                    removeFarmPhysics()
                    task.wait(1)
                    return
                end

                if isRoundOver() or isBagFull() then
                    FarmState.isActivelyFlying = false
                    FarmState.currentTargetCoin = nil
                    removeFarmPhysics()
                    if humanoid then humanoid.Sit = false end
                    task.wait(1)
                    return
                end

                if Settings.autoReset then
                    local coins = getCurrentCoins()
                    if coins >= Settings.coinLimit then
                        humanoid.Health = 0
                        task.wait(5)
                        return
                    end
                end
                
                local targetCoin = getNearestCoin(torso)
                if not targetCoin or not targetCoin:IsDescendantOf(workspace) then
                    FarmState.isActivelyFlying = false
                    FarmState.currentTargetCoin = nil
                    removeFarmPhysics()
                    if humanoid then humanoid.Sit = false end
                    task.wait(0.5)
                    return
                end

                FarmState.isActivelyFlying = true
                FarmState.currentTargetCoin = targetCoin
                
                local reachedTarget = false

                if Settings.farmMode == "Underground" then
                    setupFarmNoclip()
                    local lockedRotation = applyFlightPhysics(char)
                    local targetPos = targetCoin.Position - Vector3.new(0, Settings.undergroundOffset, 0)
                    reachedTarget = flyToPoint(targetPos, targetCoin, hrp, torso, lockedRotation)
                    
                elseif Settings.farmMode == "Sit" then
                    reachedTarget = tweenToCoin(targetCoin)
                    if reachedTarget and FarmState.isFarming and humanoid.Health > 0 then
                        collectCoin(targetCoin)
                    end
                end
                
                if reachedTarget and FarmState.isFarming and humanoid.Health > 0 then
                    FarmState.ignoredCoins[targetCoin] = true
                    task.delay(5, function() 
                        FarmState.ignoredCoins[targetCoin] = nil 
                    end)
                    task.wait(0.2)
                end
                
                FarmState.currentTargetCoin = nil 
            end)
            
            if not success then
                FarmState.isActivelyFlying = false
                FarmState.currentTargetCoin = nil
                removeFarmPhysics()
                task.wait(1)
            end
        end
    end)
end

function stopFarming()
    FarmState.isFarming = false
    FarmState.isActivelyFlying = false
    FarmState.currentTargetCoin = nil
    
    if FarmState.currentTween then
        pcall(function() FarmState.currentTween:Cancel() end)
        FarmState.currentTween = nil
    end
    
    removeFarmPhysics()
    
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
            humanoid.Sit = false
        end
    end
end

RunService.Stepped:Connect(function()
    if not FarmState.isFarming or not FarmState.isActivelyFlying or Settings.farmMode ~= "Underground" then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end
    
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end
end)

-- ============================================================
-- 18. GLOBAL KEYBINDS
-- ============================================================
UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    local key = input.KeyCode.Name

    if key == Keybinds.autoGrab then
        Settings.autoGrab = not Settings.autoGrab
    end
    if key == Keybinds.fly then
        ToggleFly()
    end
    if key == Keybinds.noclip then
        Settings.noclip = not Settings.noclip
    end
    if key == Keybinds.spin then
        Settings.spin = not Settings.spin
    end
    if key == Keybinds.infJump then
        Settings.infJump = not Settings.infJump
    end
    if key == Keybinds.killAll then
        KillAll()
    end
    if key == Keybinds.grabGun then
        GrabGun()
    end
    if key == Keybinds.autoShoot then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Gun") then AttemptShoot(false) end
    end
    if key == Keybinds.bombJump then
        PerformBombJump()
    end
    if key == Keybinds.teleportMurderer then
        TeleportToMurderer()
    end
    if key == Keybinds.teleportSheriff then
        TeleportToSheriff()
    end
    if key == Keybinds.forceShoot then
        Settings.forceShoot = not Settings.forceShoot
        if Settings.forceShoot then
            AttemptShoot(true)
        end
    end
end)

-- ============================================================
-- 19. GUI (moved to separate function to reduce local variable count in main)
-- ============================================================
local function CreateGUI()
    local ACCENT = Color3.fromRGB(180, 100, 255)
    local ACCENT_DARK = Color3.fromRGB(100, 40, 180)
    local ACCENT_LIGHT = Color3.fromRGB(210, 160, 255)
    local LOGO_ASSET_ID = "rbxassetid://132533655213092"

    local GuiParent
    pcall(function() GuiParent = gethui() end)
    if not GuiParent then pcall(function() GuiParent = game:GetService("CoreGui") end) end
    if not GuiParent then GuiParent = LocalPlayer:WaitForChild("PlayerGui") end

    for _, v in pairs(GuiParent:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:match("^WizardHub_") then v:Destroy() end
    end

    local ScreenGui = Instance.new("ScreenGui", GuiParent)
    ScreenGui.Name = "WizardHub_" .. tostring(math.random(1000,9999))
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function()
        if syn and syn.protect_gui then syn.protect_gui(ScreenGui)
        elseif protectgui then protectgui(ScreenGui) end
    end)

    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "MainMenu"
    Main.Size = UDim2.fromOffset(780, 500)
    Main.Position = UDim2.new(0.5, -390, 0.5, -250)
    Main.BackgroundColor3 = Color3.fromRGB(5,5,5)
    Main.BorderSizePixel = 0
    Main.Visible = true
    Main.Active = true
    Main.BackgroundTransparency = 0.1
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)
    local MS = Instance.new("UIStroke", Main)
    MS.Color = ACCENT_DARK
    MS.Transparency = 0.3

    local dragging, dragStart, startPos
    Main.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = Main.Position
        end
    end)
    Main.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 256, 1, 0)
    Sidebar.BackgroundColor3 = Color3.new(0,0,0)
    Sidebar.BackgroundTransparency = 0.4
    Sidebar.BorderSizePixel = 0
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,16)

    local LogoBox = Instance.new("Frame", Sidebar)
    LogoBox.Size = UDim2.new(1,0,0,80)
    LogoBox.BackgroundTransparency = 1

    local LogoIconBg = Instance.new("ImageLabel", LogoBox)
    LogoIconBg.Size = UDim2.fromOffset(40,40)
    LogoIconBg.Position = UDim2.fromOffset(24,20)
    LogoIconBg.BackgroundTransparency = 0
    LogoIconBg.Image = LOGO_ASSET_ID
    LogoIconBg.ImageColor3 = Color3.fromRGB(255,255,255)
    LogoIconBg.BorderSizePixel = 0
    Instance.new("UICorner", LogoIconBg).CornerRadius = UDim.new(0,12)
    Instance.new("UIStroke", LogoIconBg).Color = ACCENT_LIGHT

    local LogoText = Instance.new("TextLabel", LogoBox)
    LogoText.Size = UDim2.new(1,-80,0,24)
    LogoText.Position = UDim2.fromOffset(76,20)
    LogoText.BackgroundTransparency = 1
    LogoText.Text = "WIZARD HUB"
    LogoText.Font = Enum.Font.GothamBlack
    LogoText.TextSize = 20
    LogoText.TextColor3 = Color3.new(1,1,1)
    LogoText.TextXAlignment = Enum.TextXAlignment.Left

    local LogoSub = Instance.new("TextLabel", LogoBox)
    LogoSub.Size = UDim2.new(1,-80,0,14)
    LogoSub.Position = UDim2.fromOffset(76,46)
    LogoSub.BackgroundTransparency = 1
    LogoSub.Text = "by VELOR$"
    LogoSub.Font = Enum.Font.GothamBold
    LogoSub.TextSize = 8
    LogoSub.TextColor3 = ACCENT_LIGHT
    LogoSub.TextXAlignment = Enum.TextXAlignment.Left
    LogoSub.TextTransparency = 0.15

    local LogoDiv = Instance.new("Frame", LogoBox)
    LogoDiv.Size = UDim2.new(1,0,0,1)
    LogoDiv.Position = UDim2.new(0,0,1,0)
    LogoDiv.BackgroundColor3 = ACCENT
    LogoDiv.BackgroundTransparency = 0.5
    LogoDiv.BorderSizePixel = 0

    local TabHold = Instance.new("Frame", Sidebar)
    TabHold.Size = UDim2.new(1,0,1,-160)
    TabHold.Position = UDim2.fromOffset(0,81)
    TabHold.BackgroundTransparency = 1
    local tLayout = Instance.new("UIListLayout", TabHold)
    tLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tLayout.Padding = UDim.new(0,4)
    local tPadding = Instance.new("UIPadding", TabHold)
    tPadding.PaddingTop = UDim.new(0,16)

    local ProfileBox = Instance.new("Frame", Sidebar)
    ProfileBox.Size = UDim2.new(1,0,0,80)
    ProfileBox.Position = UDim2.new(0,0,1,-80)
    ProfileBox.BackgroundColor3 = Color3.fromRGB(8,5,6)
    ProfileBox.BorderSizePixel = 0
    Instance.new("UICorner", ProfileBox).CornerRadius = UDim.new(0,16)
    local ProfDiv = Instance.new("Frame", ProfileBox)
    ProfDiv.Size = UDim2.new(1,0,0,1)
    ProfDiv.BackgroundColor3 = ACCENT
    ProfDiv.BackgroundTransparency = 0.5
    ProfDiv.BorderSizePixel = 0

    local Avatar = Instance.new("ImageLabel", ProfileBox)
    Avatar.Size = UDim2.fromOffset(40,40)
    Avatar.Position = UDim2.fromOffset(16,20)
    Avatar.BackgroundColor3 = ACCENT_DARK
    Avatar.BorderSizePixel = 0
    Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150"
    Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1,0)
    Instance.new("UIStroke", Avatar).Color = ACCENT_LIGHT

    local PName = Instance.new("TextLabel", ProfileBox)
    PName.Size = UDim2.new(1,-70,0,20)
    PName.Position = UDim2.fromOffset(68,18)
    PName.BackgroundTransparency = 1
    PName.Text = LocalPlayer.Name
    PName.Font = Enum.Font.GothamBold
    PName.TextSize = 14
    PName.TextColor3 = Color3.new(1,1,1)
    PName.TextXAlignment = Enum.TextXAlignment.Left

    local PStatus = Instance.new("TextLabel", ProfileBox)
    PStatus.Size = UDim2.new(1,-70,0,16)
    PStatus.Position = UDim2.fromOffset(68,42)
    PStatus.BackgroundTransparency = 1
    PStatus.Text = "🟢  Premium Access"
    PStatus.Font = Enum.Font.GothamMedium
    PStatus.TextSize = 10
    PStatus.TextColor3 = ACCENT_LIGHT
    PStatus.TextXAlignment = Enum.TextXAlignment.Left

    local ContentBg = Instance.new("Frame", Main)
    ContentBg.Size = UDim2.new(1,-256,1,0)
    ContentBg.Position = UDim2.fromOffset(256,0)
    ContentBg.BackgroundTransparency = 1

    local Topbar = Instance.new("Frame", ContentBg)
    Topbar.Size = UDim2.new(1,0,0,80)
    Topbar.BackgroundColor3 = Color3.new(0,0,0)
    Topbar.BackgroundTransparency = 0.6
    Topbar.BorderSizePixel = 0
    local TopDiv = Instance.new("Frame", Topbar)
    TopDiv.Size = UDim2.new(1,0,0,1)
    TopDiv.Position = UDim2.new(0,0,1,-1)
    TopDiv.BackgroundColor3 = ACCENT
    TopDiv.BackgroundTransparency = 0.5
    TopDiv.BorderSizePixel = 0

    local TopIconBg = Instance.new("ImageLabel", Topbar)
    TopIconBg.Size = UDim2.fromOffset(40,40)
    TopIconBg.Position = UDim2.fromOffset(32,20)
    TopIconBg.BackgroundColor3 = ACCENT_DARK
    TopIconBg.BorderSizePixel = 0
    Instance.new("UICorner", TopIconBg).CornerRadius = UDim.new(0,12)
    Instance.new("UIStroke", TopIconBg).Color = ACCENT_LIGHT
    TopIconBg.Image = LOGO_ASSET_ID
    TopIconBg.ImageColor3 = Color3.fromRGB(255,255,255)

    local TopTitle = Instance.new("TextLabel", Topbar)
    TopTitle.Size = UDim2.new(1,-200,1,0)
    TopTitle.Position = UDim2.fromOffset(84,0)
    TopTitle.BackgroundTransparency = 1
    TopTitle.Text = "combat"
    TopTitle.Font = Enum.Font.GothamBold
    TopTitle.TextSize = 20
    TopTitle.TextColor3 = Color3.new(1,1,1)
    TopTitle.TextXAlignment = Enum.TextXAlignment.Left

    local SessionBadge = Instance.new("Frame", Topbar)
    SessionBadge.Size = UDim2.fromOffset(140,30)
    SessionBadge.Position = UDim2.new(1,-152,0.5,-15)
    SessionBadge.BackgroundColor3 = Color3.new(0,0,0)
    SessionBadge.BackgroundTransparency = 0.4
    SessionBadge.BorderSizePixel = 0
    Instance.new("UICorner", SessionBadge).CornerRadius = UDim.new(0,8)
    Instance.new("UIStroke", SessionBadge).Color = ACCENT_DARK

    local SBLabel = Instance.new("TextLabel", SessionBadge)
    SBLabel.Size = UDim2.fromScale(1,1)
    SBLabel.BackgroundTransparency = 1
    SBLabel.Text = "✅  Session Active"
    SBLabel.Font = Enum.Font.GothamMedium
    SBLabel.TextSize = 10
    SBLabel.TextColor3 = ACCENT_LIGHT

    local PageHost = Instance.new("Frame", ContentBg)
    PageHost.Size = UDim2.new(1,-64,1,-112)
    PageHost.Position = UDim2.fromOffset(32,96)
    PageHost.BackgroundTransparency = 1

    local activeBtn, activePage = nil, nil

    local function SelectTab(btn, page, name, iconId)
        if activeBtn then
            TweenService:Create(activeBtn, TweenInfo.new(0.18), {BackgroundTransparency = 1}):Play()
            local t = activeBtn:FindFirstChild("Title")
            if t then TweenService:Create(t, TweenInfo.new(0.18), {TextColor3 = Color3.fromRGB(156,163,175)}):Play() end
            local i = activeBtn:FindFirstChild("Ico")
            if i then TweenService:Create(i, TweenInfo.new(0.18), {ImageColor3 = Color3.fromRGB(156,163,175)}):Play() end
        end
        if activePage then activePage.Visible = false end
        TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundTransparency = 0.82}):Play()
        local t = btn:FindFirstChild("Title")
        if t then TweenService:Create(t, TweenInfo.new(0.18), {TextColor3 = ACCENT}):Play() end
        local i = btn:FindFirstChild("Ico")
        if i then TweenService:Create(i, TweenInfo.new(0.18), {ImageColor3 = ACCENT}):Play() end
        page.Visible = true
        page.Position = UDim2.new(0,0,0,10)
        TweenService:Create(page, TweenInfo.new(0.3), {Position = UDim2.new(0,0,0,0)}):Play()
        TopTitle.Text = name
        TopIconBg.Image = iconId
        activeBtn = btn
        activePage = page
    end

    local function CreateTab(iconId, name)
        local btn = Instance.new("TextButton", TabHold)
        btn.Size = UDim2.new(1,-32,0,48)
        btn.BackgroundColor3 = ACCENT
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)
        local bStroke = Instance.new("UIStroke", btn)
        bStroke.Color = Color3.fromRGB(255,255,255)
        bStroke.Transparency = 0.96

        local icoLbl = Instance.new("ImageLabel", btn)
        icoLbl.Name = "Ico"
        icoLbl.Size = UDim2.fromOffset(20,20)
        icoLbl.Position = UDim2.fromOffset(14,14)
        icoLbl.BackgroundTransparency = 1
        icoLbl.ImageColor3 = Color3.fromRGB(156,163,175)
        icoLbl.Image = iconId

        local tLbl = Instance.new("TextLabel", btn)
        tLbl.Name = "Title"
        tLbl.Size = UDim2.new(1,-50,1,0)
        tLbl.Position = UDim2.fromOffset(44,0)
        tLbl.BackgroundTransparency = 1
        tLbl.Text = name
        tLbl.Font = Enum.Font.GothamMedium
        tLbl.TextSize = 14
        tLbl.TextColor3 = Color3.fromRGB(156,163,175)
        tLbl.TextXAlignment = Enum.TextXAlignment.Left

        local page = Instance.new("ScrollingFrame", PageHost)
        page.Size = UDim2.fromScale(1,1)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 4
        page.ScrollBarImageColor3 = ACCENT
        page.ScrollBarImageTransparency = 0.3
        page.CanvasSize = UDim2.fromOffset(0,600)
        page.Visible = false
        page.ScrollingEnabled = true
        page.Selectable = true
        page.Active = true
        local lay = Instance.new("UIListLayout", page)
        lay.Padding = UDim.new(0,12)
        local pad = Instance.new("UIPadding", page)
        pad.PaddingTop = UDim.new(0,8)
        pad.PaddingBottom = UDim.new(0,8)
        lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0,0,0,lay.AbsoluteContentSize.Y + 20)
        end)

        btn.MouseButton1Click:Connect(function() SelectTab(btn, page, name, iconId) end)
        btn.MouseEnter:Connect(function()
            if btn ~= activeBtn then
                TweenService:Create(tLbl, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(229,231,235)}):Play()
                TweenService:Create(icoLbl, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(229,231,235)}):Play()
                TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.95}):Play()
            end
        end)
        btn.MouseLeave:Connect(function()
            if btn ~= activeBtn then
                TweenService:Create(tLbl, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(156,163,175)}):Play()
                TweenService:Create(icoLbl, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(156,163,175)}):Play()
                TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
            end
        end)
        return page, btn
    end

    local layoutOrderCounter = 0
    local function nextOrder()
        layoutOrderCounter = layoutOrderCounter + 1
        return layoutOrderCounter
    end

    local function ShowKeybindPrompt(currentKey, callback)
        local prompt = Instance.new("Frame", ScreenGui)
        prompt.Size = UDim2.fromOffset(300, 120)
        prompt.Position = UDim2.new(0.5, -150, 0.5, -60)
        prompt.BackgroundColor3 = Color3.fromRGB(20,20,25)
        prompt.BorderSizePixel = 0
        prompt.ZIndex = 999
        Instance.new("UICorner", prompt).CornerRadius = UDim.new(0,8)
        local stroke = Instance.new("UIStroke", prompt)
        stroke.Color = ACCENT
        stroke.Thickness = 2

        local label = Instance.new("TextLabel", prompt)
        label.Size = UDim2.new(1,0,0,30)
        label.Position = UDim2.new(0,0,0,10)
        label.BackgroundTransparency = 1
        label.Text = "Press any key..."
        label.TextColor3 = Color3.new(1,1,1)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 14

        local keyLbl = Instance.new("TextLabel", prompt)
        keyLbl.Size = UDim2.new(1,0,0,30)
        keyLbl.Position = UDim2.new(0,0,0,45)
        keyLbl.BackgroundTransparency = 1
        keyLbl.Text = "Current: " .. currentKey
        keyLbl.TextColor3 = ACCENT_LIGHT
        keyLbl.Font = Enum.Font.GothamMedium
        keyLbl.TextSize = 12

        local btnCancel = Instance.new("TextButton", prompt)
        btnCancel.Size = UDim2.new(0.4,0,0,30)
        btnCancel.Position = UDim2.new(0.05,0,1,-40)
        btnCancel.BackgroundColor3 = Color3.fromRGB(40,40,50)
        btnCancel.BorderSizePixel = 0
        btnCancel.Text = "Cancel"
        btnCancel.TextColor3 = Color3.new(1,1,1)
        btnCancel.Font = Enum.Font.GothamMedium
        btnCancel.TextSize = 12
        Instance.new("UICorner", btnCancel).CornerRadius = UDim.new(0,6)

        local btnClear = Instance.new("TextButton", prompt)
        btnClear.Size = UDim2.new(0.4,0,0,30)
        btnClear.Position = UDim2.new(0.55,0,1,-40)
        btnClear.BackgroundColor3 = Color3.fromRGB(40,40,50)
        btnClear.BorderSizePixel = 0
        btnClear.Text = "Clear"
        btnClear.TextColor3 = Color3.new(1,1,1)
        btnClear.Font = Enum.Font.GothamMedium
        btnClear.TextSize = 12
        Instance.new("UICorner", btnClear).CornerRadius = UDim.new(0,6)

        local conn = nil
        local function Cleanup()
            if conn then conn:Disconnect() end
            prompt:Destroy()
        end

        conn = UIS.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.KeyCode ~= Enum.KeyCode.Unknown then
                local keyName = input.KeyCode.Name
                if keyName ~= "LeftControl" then
                    callback(keyName)
                    Cleanup()
                end
            end
        end)

        btnCancel.MouseButton1Click:Connect(Cleanup)
        btnClear.MouseButton1Click:Connect(function()
            callback("")
            Cleanup()
        end)

        local function onOutsideClick(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local pos = input.Position
                local absPos = prompt.AbsolutePosition
                local absSize = prompt.AbsoluteSize
                if not (pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
                        pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y) then
                    Cleanup()
                end
            end
        end
        UIS.InputBegan:Connect(onOutsideClick)
    end

    -- GUI Functions
    local GUI = {}

    function GUI.AddHeader(parent, text)
        local h = Instance.new("TextLabel", parent)
        h.Size = UDim2.new(1,0,0,24)
        h.BackgroundTransparency = 1
        h.LayoutOrder = nextOrder()
        h.Text = text
        h.Font = Enum.Font.GothamBold
        h.TextSize = 11
        h.TextColor3 = ACCENT_LIGHT
        h.TextXAlignment = Enum.TextXAlignment.Left
    end

    function GUI.AddToggle(parent, iconId, text, getter, setter)
        local r = Instance.new("Frame", parent)
        r.BackgroundColor3 = Color3.fromRGB(255,255,255)
        r.BackgroundTransparency = 0.94
        r.BorderSizePixel = 0
        r.Size = UDim2.new(1,0,0,40)
        r.LayoutOrder = nextOrder()
        Instance.new("UICorner", r).CornerRadius = UDim.new(0,8)
        local rs = Instance.new("UIStroke", r)
        rs.Color = Color3.fromRGB(255,255,255)
        rs.Transparency = 0.94

        local eLbl = Instance.new("ImageLabel", r)
        eLbl.Size = UDim2.fromOffset(18,18)
        eLbl.Position = UDim2.fromOffset(14,11)
        eLbl.BackgroundTransparency = 1
        eLbl.ImageColor3 = Color3.fromRGB(229,231,235)
        eLbl.Image = iconId

        local l = Instance.new("TextLabel", r)
        l.Size = UDim2.new(1,-100,1,0)
        l.Position = UDim2.fromOffset(36,0)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.fromRGB(229,231,235)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 13
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.TextWrapped = true

        local tBg = Instance.new("TextButton", r)
        tBg.Size = UDim2.fromOffset(36,20)
        tBg.Position = UDim2.new(1,-46,0.5,-10)
        tBg.BackgroundColor3 = Color3.fromRGB(75,85,99)
        tBg.Text = ""
        tBg.BorderSizePixel = 0
        Instance.new("UICorner", tBg).CornerRadius = UDim.new(1,0)
        local knob = Instance.new("Frame", tBg)
        knob.Size = UDim2.fromOffset(15,15)
        knob.Position = UDim2.fromOffset(2,2)
        knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
        knob.BorderSizePixel = 0
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

        local function upd()
            local s = getter()
            TweenService:Create(tBg, TweenInfo.new(0.18), {BackgroundColor3 = s and ACCENT or Color3.fromRGB(75,85,99)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.18), {Position = s and UDim2.fromOffset(19,2) or UDim2.fromOffset(2,2)}):Play()
        end
        upd()
        tBg.MouseButton1Click:Connect(function()
            setter(not getter())
            upd()
        end)
        r.MouseEnter:Connect(function() TweenService:Create(r, TweenInfo.new(0.1), {BackgroundTransparency = 0.89}):Play() end)
        r.MouseLeave:Connect(function() TweenService:Create(r, TweenInfo.new(0.1), {BackgroundTransparency = 0.94}):Play() end)
    end

    function GUI.AddButton(parent, iconId, text, callback)
        local r = Instance.new("TextButton", parent)
        r.BackgroundColor3 = Color3.fromRGB(30,20,25)
        r.BorderSizePixel = 0
        r.Size = UDim2.new(1,0,0,40)
        r.LayoutOrder = nextOrder()
        Instance.new("UICorner", r).CornerRadius = UDim.new(0,8)
        local eLbl = Instance.new("ImageLabel", r)
        eLbl.Size = UDim2.fromOffset(18,18)
        eLbl.Position = UDim2.fromOffset(14,11)
        eLbl.BackgroundTransparency = 1
        eLbl.ImageColor3 = Color3.fromRGB(229,231,235)
        eLbl.Image = iconId
        local l = Instance.new("TextLabel", r)
        l.Size = UDim2.new(1,-50,1,0)
        l.Position = UDim2.fromOffset(36,0)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.fromRGB(229,231,235)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 13
        l.TextXAlignment = Enum.TextXAlignment.Left
        r.MouseButton1Click:Connect(callback)
    end

    function GUI.AddSlider(parent, iconId, text, getter, setter, mn, mx)
        local r = Instance.new("Frame", parent)
        r.BackgroundColor3 = Color3.fromRGB(255,255,255)
        r.BackgroundTransparency = 0.94
        r.BorderSizePixel = 0
        r.Size = UDim2.new(1,0,0,68)
        r.LayoutOrder = nextOrder()
        Instance.new("UICorner", r).CornerRadius = UDim.new(0,8)
        local rs = Instance.new("UIStroke", r)
        rs.Color = Color3.fromRGB(255,255,255)
        rs.Transparency = 0.94

        local eLbl = Instance.new("ImageLabel", r)
        eLbl.Size = UDim2.fromOffset(18,18)
        eLbl.Position = UDim2.fromOffset(14,12)
        eLbl.BackgroundTransparency = 1
        eLbl.ImageColor3 = Color3.fromRGB(229,231,235)
        eLbl.Image = iconId

        local l = Instance.new("TextLabel", r)
        l.Size = UDim2.new(0.6,0,0,24)
        l.Position = UDim2.fromOffset(36,6)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.fromRGB(229,231,235)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 12
        l.TextXAlignment = Enum.TextXAlignment.Left

        local vL = Instance.new("TextLabel", r)
        vL.Size = UDim2.new(0.35,0,0,24)
        vL.Position = UDim2.new(0.65,-12,0,6)
        vL.BackgroundTransparency = 1
        vL.Text = tostring(getter())
        vL.TextColor3 = ACCENT
        vL.Font = Enum.Font.GothamBold
        vL.TextSize = 13
        vL.TextXAlignment = Enum.TextXAlignment.Right

        local sBg = Instance.new("Frame", r)
        sBg.Size = UDim2.new(1,-24,0,5)
        sBg.Position = UDim2.fromOffset(12,46)
        sBg.BackgroundColor3 = Color3.fromRGB(45,55,70)
        sBg.BorderSizePixel = 0
        Instance.new("UICorner", sBg).CornerRadius = UDim.new(1,0)

        local fill = Instance.new("Frame", sBg)
        fill.Size = UDim2.fromScale(math.clamp((getter()-mn)/(mx-mn),0,1), 1)
        fill.BackgroundColor3 = ACCENT
        fill.BorderSizePixel = 0
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)

        local hitBtn = Instance.new("TextButton", sBg)
        hitBtn.Size = UDim2.new(1,0,1,16)
        hitBtn.Position = UDim2.fromOffset(0,-8)
        hitBtn.BackgroundTransparency = 1
        hitBtn.Text = ""

        local draggingSlider = false
        hitBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSlider = true
            end
        end)
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSlider = false
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                local pct = math.clamp((input.Position.X - sBg.AbsolutePosition.X) / sBg.AbsoluteSize.X, 0, 1)
                fill.Size = UDim2.fromScale(pct, 1)
                local val = math.floor(mn + (mx - mn) * pct)
                vL.Text = tostring(val)
                setter(val)
            end
        end)
    end

    function GUI.AddDropdown(parent, iconId, text, options, getter, setter)
        local r = Instance.new("Frame", parent)
        r.BackgroundColor3 = Color3.fromRGB(255,255,255)
        r.BackgroundTransparency = 0.94
        r.BorderSizePixel = 0
        r.Size = UDim2.new(1,0,0,40)
        r.LayoutOrder = nextOrder()
        Instance.new("UICorner", r).CornerRadius = UDim.new(0,8)
        local rs = Instance.new("UIStroke", r)
        rs.Color = Color3.fromRGB(255,255,255)
        rs.Transparency = 0.94

        local eLbl = Instance.new("ImageLabel", r)
        eLbl.Size = UDim2.fromOffset(18,18)
        eLbl.Position = UDim2.fromOffset(14,11)
        eLbl.BackgroundTransparency = 1
        eLbl.ImageColor3 = Color3.fromRGB(229,231,235)
        eLbl.Image = iconId

        local l = Instance.new("TextLabel", r)
        l.Size = UDim2.new(0.6,0,0,40)
        l.Position = UDim2.fromOffset(36,0)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.fromRGB(229,231,235)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 13
        l.TextXAlignment = Enum.TextXAlignment.Left

        local dropBtn = Instance.new("TextButton", r)
        dropBtn.Size = UDim2.new(0.35,0,0,30)
        dropBtn.Position = UDim2.new(0.65,0,0.5,-15)
        dropBtn.BackgroundColor3 = Color3.fromRGB(45,55,70)
        dropBtn.BorderSizePixel = 0
        dropBtn.Text = getter()
        dropBtn.TextColor3 = Color3.fromRGB(255,255,255)
        dropBtn.Font = Enum.Font.GothamMedium
        dropBtn.TextSize = 12
        Instance.new("UICorner", dropBtn).CornerRadius = UDim.new(0,6)

        local menu = Instance.new("Frame", r)
        menu.Size = UDim2.new(0.35,0,0,0)
        menu.Position = UDim2.new(0.65,0,0.5,-15)
        menu.BackgroundColor3 = Color3.fromRGB(30,30,40)
        menu.BorderSizePixel = 0
        menu.Visible = false
        menu.ZIndex = 10
        Instance.new("UICorner", menu).CornerRadius = UDim.new(0,6)
        local menuLayout = Instance.new("UIListLayout", menu)
        menuLayout.Padding = UDim.new(0,2)

        local function UpdateMenu()
            for _, child in pairs(menu:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            for _, opt in ipairs(options) do
                local btn = Instance.new("TextButton", menu)
                btn.Size = UDim2.new(1,0,0,25)
                btn.BackgroundTransparency = 1
                btn.Text = opt
                btn.TextColor3 = Color3.fromRGB(200,200,200)
                btn.Font = Enum.Font.GothamMedium
                btn.TextSize = 12
                btn.MouseButton1Click:Connect(function()
                    setter(opt)
                    dropBtn.Text = opt
                    menu.Visible = false
                    menu.Size = UDim2.new(0.35,0,0,0)
                end)
                btn.MouseEnter:Connect(function()
                    btn.BackgroundColor3 = Color3.fromRGB(60,60,80)
                    btn.BackgroundTransparency = 0
                end)
                btn.MouseLeave:Connect(function()
                    btn.BackgroundTransparency = 1
                end)
            end
            menu.Size = UDim2.new(0.35,0,0, #options * 25 + 8)
        end
        UpdateMenu()

        dropBtn.MouseButton1Click:Connect(function()
            menu.Visible = not menu.Visible
            if menu.Visible then UpdateMenu() end
        end)
    end

    function GUI.AddToggleWithBind(parent, iconId, text, getter, setter, bindKey, bindSetter)
        local r = Instance.new("Frame", parent)
        r.BackgroundColor3 = Color3.fromRGB(255,255,255)
        r.BackgroundTransparency = 0.94
        r.BorderSizePixel = 0
        r.Size = UDim2.new(1,0,0,40)
        r.LayoutOrder = nextOrder()
        Instance.new("UICorner", r).CornerRadius = UDim.new(0,8)
        local rs = Instance.new("UIStroke", r)
        rs.Color = Color3.fromRGB(255,255,255)
        rs.Transparency = 0.94

        local eLbl = Instance.new("ImageLabel", r)
        eLbl.Size = UDim2.fromOffset(18,18)
        eLbl.Position = UDim2.fromOffset(14,11)
        eLbl.BackgroundTransparency = 1
        eLbl.ImageColor3 = Color3.fromRGB(229,231,235)
        eLbl.Image = iconId

        local l = Instance.new("TextLabel", r)
        l.Size = UDim2.new(1,-140,1,0)
        l.Position = UDim2.fromOffset(36,0)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.fromRGB(229,231,235)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 13
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.TextWrapped = true

        local bindLabel = Instance.new("TextButton", r)
        bindLabel.Size = UDim2.fromOffset(40,20)
        bindLabel.Position = UDim2.new(1, -50, 0.5, -10)
        bindLabel.BackgroundTransparency = 1
        bindLabel.Text = "[" .. bindKey() .. "]"
        bindLabel.TextColor3 = ACCENT_LIGHT
        bindLabel.Font = Enum.Font.GothamBold
        bindLabel.TextSize = 10
        bindLabel.TextXAlignment = Enum.TextXAlignment.Right
        bindLabel.MouseButton2Click:Connect(function()
            ShowKeybindPrompt(bindKey(), function(newKey)
                bindSetter(newKey)
                bindLabel.Text = "[" .. newKey .. "]"
            end)
        end)

        local tBg = Instance.new("TextButton", r)
        tBg.Size = UDim2.fromOffset(36,20)
        tBg.Position = UDim2.new(1, -92, 0.5, -10)
        tBg.BackgroundColor3 = Color3.fromRGB(75,85,99)
        tBg.Text = ""
        tBg.BorderSizePixel = 0
        Instance.new("UICorner", tBg).CornerRadius = UDim.new(1,0)
        local knob = Instance.new("Frame", tBg)
        knob.Size = UDim2.fromOffset(15,15)
        knob.Position = UDim2.fromOffset(2,2)
        knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
        knob.BorderSizePixel = 0
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

        local function upd()
            local s = getter()
            TweenService:Create(tBg, TweenInfo.new(0.18), {BackgroundColor3 = s and ACCENT or Color3.fromRGB(75,85,99)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.18), {Position = s and UDim2.fromOffset(19,2) or UDim2.fromOffset(2,2)}):Play()
        end
        upd()
        tBg.MouseButton1Click:Connect(function()
            setter(not getter())
            upd()
        end)

        r.MouseEnter:Connect(function() TweenService:Create(r, TweenInfo.new(0.1), {BackgroundTransparency = 0.89}):Play() end)
        r.MouseLeave:Connect(function() TweenService:Create(r, TweenInfo.new(0.1), {BackgroundTransparency = 0.94}):Play() end)
    end

    function GUI.AddButtonWithBind(parent, iconId, text, callback, bindKey, bindSetter)
        local r = Instance.new("TextButton", parent)
        r.BackgroundColor3 = Color3.fromRGB(30,20,25)
        r.BorderSizePixel = 0
        r.Size = UDim2.new(1,0,0,40)
        r.LayoutOrder = nextOrder()
        Instance.new("UICorner", r).CornerRadius = UDim.new(0,8)
        local eLbl = Instance.new("ImageLabel", r)
        eLbl.Size = UDim2.fromOffset(18,18)
        eLbl.Position = UDim2.fromOffset(14,11)
        eLbl.BackgroundTransparency = 1
        eLbl.ImageColor3 = Color3.fromRGB(229,231,235)
        eLbl.Image = iconId
        local l = Instance.new("TextLabel", r)
        l.Size = UDim2.new(1,-90,1,0)
        l.Position = UDim2.fromOffset(36,0)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.fromRGB(229,231,235)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 13
        l.TextXAlignment = Enum.TextXAlignment.Left

        local bindLabel = Instance.new("TextButton", r)
        bindLabel.Size = UDim2.fromOffset(40,20)
        bindLabel.Position = UDim2.new(1, -12, 0.5, -10)
        bindLabel.BackgroundTransparency = 1
        bindLabel.Text = "[" .. bindKey() .. "]"
        bindLabel.TextColor3 = ACCENT_LIGHT
        bindLabel.Font = Enum.Font.GothamBold
        bindLabel.TextSize = 10
        bindLabel.TextXAlignment = Enum.TextXAlignment.Right
        bindLabel.MouseButton2Click:Connect(function()
            ShowKeybindPrompt(bindKey(), function(newKey)
                bindSetter(newKey)
                bindLabel.Text = "[" .. newKey .. "]"
            end)
        end)

        r.MouseButton1Click:Connect(callback)
    end

    -- Aura Functions
    local function CycleAuraType()
        local idx = table.find(AURA_ORDER, Settings.auraType) or 1
        idx = idx % #AURA_ORDER + 1
        Settings.auraType = AURA_ORDER[idx]
        if Settings.auraEnabled then ApplyAura() end
    end

    local function CycleAuraColor()
        local colors = {
            Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255),
            Color3.fromRGB(255,255,0), Color3.fromRGB(255,0,255), Color3.fromRGB(0,255,255),
            Color3.fromRGB(255,128,0), Color3.fromRGB(128,0,255)
        }
        local idx = 1
        for i, c in ipairs(colors) do
            if c == Settings.auraColor then idx = i; break end
        end
        idx = idx % #colors + 1
        Settings.auraColor = colors[idx]
        if Settings.auraEnabled then ApplyAura() end
    end

    -- Tab Creation
    local pCombat, bCombat = CreateTab("rbxassetid://10709818534", "combat")
    local pVisuals, bVisuals = CreateTab("rbxassetid://10723346959", "visuals")
    local pPlayer, bPlayer = CreateTab("rbxassetid://10747382750", "player")
    local pFarm, bFarm = CreateTab("rbxassetid://10734883356", "auto farm")
    local pHUD, bHUD = CreateTab("rbxassetid://10734950309", "hud")

    -- COMBAT TAB
    GUI.AddHeader(pCombat, "  aimbot & kill")
    GUI.AddToggleWithBind(pCombat, "rbxassetid://10734977012", "silent aim (sheriff)",
        function() return Settings.silent end,
        function(v) Settings.silent = v end,
        function() return Keybinds.silent end,
        function(k) Keybinds.silent = k end
    )
    GUI.AddToggleWithBind(pCombat, "rbxassetid://10734977012", "force shoot (T)",
        function() return Settings.forceShoot end,
        function(v) Settings.forceShoot = v end,
        function() return Keybinds.forceShoot end,
        function(k) Keybinds.forceShoot = k end
    )
    GUI.AddDropdown(pCombat, "rbxassetid://10734976528", "aim part",
        {"HumanoidRootPart", "Head"},
        function() return Settings.aimPart end,
        function(v) Settings.aimPart = v end
    )
    GUI.AddDropdown(pCombat, "rbxassetid://10734976528", "prediction mode",
        {"Auto (ping)", "Manual"},
        function() return Settings.silentPredictionMode end,
        function(v) Settings.silentPredictionMode = v end
    )
    GUI.AddSlider(pCombat, "rbxassetid://10734941018", "prediction ms (manual)",
        function() return Settings.silentPredictionMs end,
        function(v) Settings.silentPredictionMs = v end,
        0, 500
    )
    GUI.AddToggle(pCombat, "rbxassetid://10734976528", "wallbang",
        function() return Settings.wallbang end,
        function(v) Settings.wallbang = v end
    )
    GUI.AddToggle(pCombat, "rbxassetid://10734976528", "bullet tracer",
        function() return Settings.bulletTracer end,
        function(v) Settings.bulletTracer = v end
    )
    GUI.AddButtonWithBind(pCombat, "rbxassetid://10709789810", "grab gun", GrabGun,
        function() return Keybinds.grabGun end,
        function(k) Keybinds.grabGun = k end
    )
    GUI.AddToggleWithBind(pCombat, "rbxassetid://10734975692", "auto grab",
        function() return Settings.autoGrab end,
        function(v) Settings.autoGrab = v end,
        function() return Keybinds.autoGrab end,
        function(k) Keybinds.autoGrab = k end
    )
    GUI.AddButtonWithBind(pCombat, "rbxassetid://10734962068", "kill all", KillAll,
        function() return Keybinds.killAll end,
        function(k) Keybinds.killAll = k end
    )
    GUI.AddButtonWithBind(pCombat, "rbxassetid://10734975550", "auto shoot", function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Gun") then AttemptShoot(false) end
    end,
        function() return Keybinds.autoShoot end,
        function(k) Keybinds.autoShoot = k end
    )

    GUI.AddHeader(pCombat, "  auto ez")
    GUI.AddToggle(pCombat, "rbxassetid://10734976528", "auto ez (griddy on kill)",
        function() return Settings.autoEZ end,
        function(v) Settings.autoEZ = v end
    )

    GUI.AddHeader(pCombat, "  bomb jump")
    GUI.AddToggleWithBind(pCombat, "rbxassetid://10734907361", "bomb jump (double jump)",
        function() return true end,
        function(v) end,
        function() return Keybinds.bombJump end,
        function(k) Keybinds.bombJump = k end
    )

    GUI.AddHeader(pCombat, "  teleport")
    GUI.AddButtonWithBind(pCombat, "rbxassetid://10734962068", "teleport to murderer", TeleportToMurderer,
        function() return Keybinds.teleportMurderer end,
        function(k) Keybinds.teleportMurderer = k end
    )
    GUI.AddButtonWithBind(pCombat, "rbxassetid://10734976528", "teleport to sheriff", TeleportToSheriff,
        function() return Keybinds.teleportSheriff end,
        function(k) Keybinds.teleportSheriff = k end
    )

    -- VISUALS TAB
    GUI.AddHeader(pVisuals, "  esp")
    GUI.AddToggle(pVisuals, "rbxassetid://10734976528", "esp",
        function() return Settings.esp end,
        function(v)
            Settings.esp = v
            if ESPLib and ESPLib.Table then ESPLib.Table.Enabled = v end
        end
    )
    GUI.AddToggle(pVisuals, "rbxassetid://10734910430", "boxes",
        function() return Settings.espBox end,
        function(v)
            Settings.espBox = v
            if ESPLib and ESPLib.Table and ESPLib.Table.Boxes then ESPLib.Table.Boxes.Enabled = v end
        end
    )
    GUI.AddToggle(pVisuals, "rbxassetid://10734976528", "names",
        function() return Settings.espName end,
        function(v)
            Settings.espName = v
            if ESPLib and ESPLib.Table and ESPLib.Table.Texts and ESPLib.Table.Texts.Name then
                ESPLib.Table.Texts.Name.Enabled = v
            end
        end
    )
    GUI.AddToggle(pVisuals, "rbxassetid://10734941018", "distance",
        function() return Settings.espDistance end,
        function(v)
            Settings.espDistance = v
            if ESPLib and ESPLib.Table and ESPLib.Table.Texts and ESPLib.Table.Texts.Distance then
                ESPLib.Table.Texts.Distance.Enabled = v
            end
        end
    )
    GUI.AddToggle(pVisuals, "rbxassetid://10734945538", "tracers (ESP lines)",
        function() return Settings.espTracer end,
        function(v)
            Settings.espTracer = v
            if ESPLib and ESPLib.Table and ESPLib.Table.Tracers then
                ESPLib.Table.Tracers.Enabled = v
            end
        end
    )
    GUI.AddToggle(pVisuals, "rbxassetid://10723406885", "health bar",
        function() return Settings.espHealth end,
        function(v)
            Settings.espHealth = v
            if ESPLib and ESPLib.Table and ESPLib.Table.Bars and ESPLib.Table.Bars.HealthBar then
                ESPLib.Table.Bars.HealthBar.Enabled = v
            end
        end
    )
    GUI.AddToggle(pVisuals, "rbxassetid://10734976528", "show local player",
        function() return Settings.showLocalPlayer end,
        function(v)
            Settings.showLocalPlayer = v
            if ESPLib and ESPLib.Table then
                ESPLib.Table.ShowLocalPlayer = v
                if v then
                    ESPLib:AddTarget(LocalPlayer)
                else
                    ESPLib:RemoveTarget(LocalPlayer)
                end
            end
        end
    )

    GUI.AddHeader(pVisuals, "  show roles")
    GUI.AddToggle(pVisuals, "rbxassetid://10734976528", "show role flags",
        function() return Settings.showRoles end,
        function(v)
            Settings.showRoles = v
            for _, data in pairs(getgenv().Library.Cache) do
                if data.Objects and data.Objects.RoleLabel then
                    data.Objects.RoleLabel.Visible = v
                end
            end
        end
    )

    GUI.AddHeader(pVisuals, "  aura")
    GUI.AddToggle(pVisuals, "rbxassetid://10723406885", "aura",
        function() return Settings.auraEnabled end,
        function(v)
            Settings.auraEnabled = v
            ApplyAura()
        end
    )
    GUI.AddButton(pVisuals, "rbxassetid://10723396000", "aura type", CycleAuraType)
    GUI.AddButton(pVisuals, "rbxassetid://10734910430", "aura color", CycleAuraColor)

    GUI.AddHeader(pVisuals, "  self chams")
    GUI.AddToggle(pVisuals, "rbxassetid://10723406885", "outline (highlight)",
        function() return Settings.selfChamsOutline end,
        function(v)
            Settings.selfChamsOutline = v
            ApplySelfChams()
        end
    )

    GUI.AddHeader(pVisuals, "  fake cosmetics")
    GUI.AddToggle(pVisuals, "rbxassetid://10723406885", "fake headless",
        function() return Settings.fakeHeadless end,
        function(v)
            Settings.fakeHeadless = v
            if LocalPlayer.Character then UpdateFakeAppearance() end
        end
    )
    GUI.AddToggle(pVisuals, "rbxassetid://10734910430", "fake korblox",
        function() return Settings.fakeKorblox end,
        function(v)
            Settings.fakeKorblox = v
            if LocalPlayer.Character then UpdateFakeAppearance() end
        end
    )

    GUI.AddHeader(pVisuals, "  shaders")
    GUI.AddToggle(pVisuals, "rbxassetid://10734976528", "realistic shaders",
        function() return Settings.realisticShaders end,
        function(v)
            Settings.realisticShaders = v
            ApplyRealisticShaders()
        end
    )

    -- PLAYER TAB
    GUI.AddHeader(pPlayer, "  movement")
    GUI.AddToggleWithBind(pPlayer, "rbxassetid://10723354521", "fly",
        function() return Settings.fly end,
        function(v) ToggleFly(v) end,
        function() return Keybinds.fly end,
        function(k) Keybinds.fly = k end
    )
    GUI.AddToggleWithBind(pPlayer, "rbxassetid://10709782497", "noclip",
        function() return Settings.noclip end,
        function(v) Settings.noclip = v end,
        function() return Keybinds.noclip end,
        function(k) Keybinds.noclip = k end
    )
    GUI.AddToggleWithBind(pPlayer, "rbxassetid://10734907361", "spin",
        function() return Settings.spin end,
        function(v) Settings.spin = v end,
        function() return Keybinds.spin end,
        function(k) Keybinds.spin = k end
    )
    GUI.AddToggleWithBind(pPlayer, "rbxassetid://10734934585", "inf jump",
        function() return Settings.infJump end,
        function(v) Settings.infJump = v end,
        function() return Keybinds.infJump end,
        function(k) Keybinds.infJump = k end
    )
    GUI.AddSlider(pPlayer, "rbxassetid://10723354521", "speed",
        function() return Settings.speed end,
        function(v)
            Settings.speed = v
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = v end
            end
        end, 0, 100
    )
    GUI.AddSlider(pPlayer, "rbxassetid://10709778216", "jump power",
        function() return Settings.jumpPower end,
        function(v)
            Settings.jumpPower = v
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.JumpPower = v end
            end
        end, 0, 200
    )

    GUI.AddHeader(pPlayer, "  bhop")
    GUI.AddToggle(pPlayer, "rbxassetid://10734976528", "bhop enabled",
        function() return Settings.bhopEnabled end,
        function(v)
            toggleBHop(v)
        end
    )
    GUI.AddSlider(pPlayer, "rbxassetid://10734941018", "bhop speed",
        function() return Settings.bhopSpeed end,
        function(v)
            Settings.bhopSpeed = v
            if Settings.bhopEnabled then
                stopBHop()
                task.wait(0.1)
                startBHop()
            end
        end,
        10, 100
    )
    GUI.AddSlider(pPlayer, "rbxassetid://10734941018", "bhop multiplier",
        function() return Settings.bhopMultiplier end,
        function(v)
            Settings.bhopMultiplier = v
        end,
        1.0, 2.0
    )

    GUI.AddHeader(pPlayer, "  anti-fling")
    GUI.AddToggle(pPlayer, "rbxassetid://10734976528", "anti-fling",
        function() return Settings.antiFling end,
        function(v)
            Settings.antiFling = v
            SetupAntiFling()
        end
    )

    GUI.AddHeader(pPlayer, "  tp tool")
    GUI.AddToggle(pPlayer, "rbxassetid://10734976528", "tp tool (click to teleport)",
        function() return Settings.tpToolEnabled end,
        function(v)
            ToggleTPTool(v)
        end
    )

    -- AUTO FARM TAB
    GUI.AddHeader(pFarm, "  farm settings")
    GUI.AddToggle(pFarm, "rbxassetid://10734883356", "auto farm",
        function() return Settings.autoFarm end,
        function(v)
            Settings.autoFarm = v
            if v then startFarming() else stopFarming() end
        end
    )
    GUI.AddToggle(pFarm, "rbxassetid://10734976528", "auto reset",
        function() return Settings.autoReset end,
        function(v) Settings.autoReset = v end
    )
    GUI.AddToggle(pFarm, "rbxassetid://10734962068", "avoid murderer",
        function() return Settings.avoidMurder end,
        function(v) Settings.avoidMurder = v end
    )
    GUI.AddSlider(pFarm, "rbxassetid://10709796216", "tween speed",
        function() return Settings.tweenSpeed end,
        function(v) Settings.tweenSpeed = v end,
        10, 100
    )
    GUI.AddSlider(pFarm, "rbxassetid://10709796216", "underground offset",
        function() return Settings.undergroundOffset end,
        function(v) Settings.undergroundOffset = v end,
        1, 10
    )
    GUI.AddSlider(pFarm, "rbxassetid://10709796216", "coin limit",
        function() return Settings.coinLimit end,
        function(v) Settings.coinLimit = v end,
        10, 100
    )
    GUI.AddSlider(pFarm, "rbxassetid://10709796216", "max distance",
        function() return Settings.maxDistance end,
        function(v) Settings.maxDistance = v end,
        100, 1000
    )

    -- HUD TAB
    GUI.AddHeader(pHUD, "  display")
    GUI.AddToggle(pHUD, "rbxassetid://10723407389", "watermark",
        function() return Settings.showWatermark end,
        function(v) Settings.showWatermark = v end
    )
    GUI.AddToggle(pHUD, "rbxassetid://10734976528", "hotkeys",
        function() return Settings.showHotkeys end,
        function(v) Settings.showHotkeys = v end
    )

    SelectTab(bCombat, pCombat, "combat", "rbxassetid://10709818534")

    -- Watermark and Hotkeys
    local Watermark = Instance.new("TextLabel", ScreenGui)
    Watermark.Size = UDim2.fromOffset(200, 30)
    Watermark.Position = UDim2.new(0.02, 0, 0.02, 0)
    Watermark.BackgroundTransparency = 1
    Watermark.Text = "Wizard Hub | VELOR$"
    Watermark.TextColor3 = Color3.fromRGB(255,255,255)
    Watermark.Font = Enum.Font.GothamBold
    Watermark.TextSize = 14
    Watermark.TextXAlignment = Enum.TextXAlignment.Left
    Watermark.TextStrokeTransparency = 0.5
    Watermark.ZIndex = 999

    local HotkeysFrame = Instance.new("Frame", ScreenGui)
    HotkeysFrame.Size = UDim2.fromOffset(180, 100)
    HotkeysFrame.Position = UDim2.new(0.02, 0, 0.07, 0)
    HotkeysFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    HotkeysFrame.BackgroundTransparency = 0.7
    HotkeysFrame.BorderSizePixel = 0
    HotkeysFrame.Visible = true
    Instance.new("UICorner", HotkeysFrame).CornerRadius = UDim.new(0,6)
    local hotkeyList = Instance.new("UIListLayout", HotkeysFrame)
    hotkeyList.Padding = UDim.new(0,2)
    hotkeyList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    local padH = Instance.new("UIPadding", HotkeysFrame)
    padH.PaddingTop = UDim.new(0,4)
    padH.PaddingLeft = UDim.new(0,6)

    local function UpdateHUD()
        Watermark.Visible = Settings.showWatermark
        if not Settings.showHotkeys then
            HotkeysFrame.Visible = false
            return
        end
        HotkeysFrame.Visible = true
        for _, child in pairs(HotkeysFrame:GetChildren()) do
            if child:IsA("TextLabel") then child:Destroy() end
        end
        local lines = {}
        if Settings.silent then table.insert(lines, "silent [" .. Keybinds.silent .. "]") end
        if Settings.forceShoot then table.insert(lines, "force shoot [" .. Keybinds.forceShoot .. "]") end
        if Settings.autoGrab then table.insert(lines, "auto grab [" .. Keybinds.autoGrab .. "]") end
        if Settings.fly then table.insert(lines, "fly [" .. Keybinds.fly .. "]") end
        if Settings.noclip then table.insert(lines, "noclip [" .. Keybinds.noclip .. "]") end
        if Settings.spin then table.insert(lines, "spin [" .. Keybinds.spin .. "]") end
        if Settings.infJump then table.insert(lines, "inf jump [" .. Keybinds.infJump .. "]") end
        if Settings.autoFarm then table.insert(lines, "auto farm [on]") end
        if Settings.bhopEnabled then table.insert(lines, "bhop [on]") end
        if Settings.autoEZ then table.insert(lines, "auto ez [on]") end
        if Settings.antiFling then table.insert(lines, "anti-fling [on]") end
        if Settings.wallbang then table.insert(lines, "wallbang [on]") end
        if Settings.bulletTracer then table.insert(lines, "bullet tracer [on]") end
        if Settings.realisticShaders then table.insert(lines, "realistic shaders [on]") end
        if Settings.selfChamsOutline then table.insert(lines, "chams outline [on]") end
        if Settings.tpToolEnabled then table.insert(lines, "tp tool [on]") end
        if Settings.showLocalPlayer then table.insert(lines, "show self [on]") end
        if #lines == 0 then
            HotkeysFrame.Visible = false
            return
        end
        for _, line in ipairs(lines) do
            local lbl = Instance.new("TextLabel", HotkeysFrame)
            lbl.Size = UDim2.new(1,0,0,16)
            lbl.BackgroundTransparency = 1
            lbl.Text = line
            lbl.TextColor3 = ACCENT_LIGHT
            lbl.Font = Enum.Font.GothamMedium
            lbl.TextSize = 11
            lbl.TextXAlignment = Enum.TextXAlignment.Left
        end
        HotkeysFrame.Size = UDim2.fromOffset(180, #lines * 18 + 8)
    end

    RunService.RenderStepped:Connect(UpdateHUD)

    -- Mini Icon
    local isVisible = true
    local MiniIcon = Instance.new("ImageButton", ScreenGui)
    MiniIcon.Size = UDim2.fromOffset(50, 50)
    MiniIcon.Position = UDim2.new(0.9, 0, 0.1, 0)
    MiniIcon.BackgroundColor3 = Color3.fromRGB(20,20,25)
    MiniIcon.BorderSizePixel = 0
    MiniIcon.Visible = false
    Instance.new("UICorner", MiniIcon).CornerRadius = UDim.new(1,0)
    local iconStroke = Instance.new("UIStroke", MiniIcon)
    iconStroke.Color = ACCENT
    iconStroke.Thickness = 2
    MiniIcon.Image = LOGO_ASSET_ID
    MiniIcon.ImageColor3 = Color3.fromRGB(255,255,255)

    local dragIcon, iconDragStart, iconStartPos
    MiniIcon.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragIcon = true
            iconDragStart = i.Position
            iconStartPos = MiniIcon.Position
        end
    end)
    MiniIcon.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragIcon = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragIcon and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - iconDragStart
            MiniIcon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + delta.X,
                                           iconStartPos.Y.Scale, iconStartPos.Y.Offset + delta.Y)
        end
    end)

    MiniIcon.MouseButton1Click:Connect(function()
        if not isVisible then
            isVisible = true
            Main.Visible = true
            MiniIcon.Visible = false
        end
    end)

    UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.LeftControl then
            if isVisible then
                isVisible = false
                Main.Visible = false
                MiniIcon.Visible = true
            else
                isVisible = true
                Main.Visible = true
                MiniIcon.Visible = false
            end
        end
    end)

end -- end of CreateGUI

-- ============================================================
-- 20. INITIALIZATION
-- ============================================================
task.spawn(function()
    while not ReplicatedStorage:FindFirstChild("Remotes", true) do
        task.wait(0.5)
    end
    UpdateRoles()
    while true do
        task.wait(1.5)
        UpdateRoles()
    end
end)

task.spawn(function()
    while not getgenv().Library do
        task.wait(0.1)
    end
    ExtendESP()
    if Settings.showLocalPlayer then
        ESPLib:AddTarget(LocalPlayer)
    else
        ESPLib:RemoveTarget(LocalPlayer)
    end
end)

ApplyRealisticShaders()
SetupAntiFling()
ApplySelfChams()
CreateTPTool()
CreateGUI()

print("Wizard Hub loaded (FULL ULTIMATE v28.19). Press Left Control to toggle menu. | Bragao")

end)()
