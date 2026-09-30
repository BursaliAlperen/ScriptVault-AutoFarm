-- =====================================================
-- ScriptVault UI Library v2.0
-- Professional Roblox UI Library - 55x Enhanced
-- GitHub: github.com/ScriptVault/UI-Library
-- Usage: local SV = loadstring(game:HttpGet("RAW_URL"))()
-- =====================================================

local SV = {}
SV.__index = SV
SV._VERSION = "2.0.0"

-- =====================================================
-- SERVICES
-- =====================================================
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContentProvider  = game:GetService("ContentProvider")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")
local Stats            = game:GetService("Stats")

local LP = Players.LocalPlayer

-- =====================================================
-- THEMES
-- =====================================================
local Themes = {}

Themes.DarkBlue = {
    Background        = Color3.fromRGB(15, 16, 24),
    Sidebar           = Color3.fromRGB(20, 21, 32),
    TopBar            = Color3.fromRGB(22, 23, 35),
    Element           = Color3.fromRGB(28, 29, 44),
    ElementHover      = Color3.fromRGB(36, 37, 56),
    ElementActive     = Color3.fromRGB(42, 44, 66),
    Accent            = Color3.fromRGB(0, 120, 255),
    AccentHover       = Color3.fromRGB(30, 145, 255),
    AccentDark        = Color3.fromRGB(0, 90, 200),
    Text              = Color3.fromRGB(240, 242, 255),
    TextMuted         = Color3.fromRGB(160, 165, 190),
    TextDark          = Color3.fromRGB(110, 115, 140),
    ToggleOn          = Color3.fromRGB(0, 150, 255),
    ToggleOff         = Color3.fromRGB(48, 50, 70),
    Button            = Color3.fromRGB(0, 110, 220),
    ButtonHover       = Color3.fromRGB(0, 135, 255),
    Success           = Color3.fromRGB(0, 200, 110),
    Warning           = Color3.fromRGB(230, 165, 0),
    Error             = Color3.fromRGB(225, 60, 60),
    Slider            = Color3.fromRGB(38, 40, 60),
    SliderFill        = Color3.fromRGB(0, 135, 255),
    Dropdown          = Color3.fromRGB(32, 33, 50),
    DropdownHover     = Color3.fromRGB(48, 50, 74),
    Input             = Color3.fromRGB(36, 37, 55),
    InputFocus        = Color3.fromRGB(42, 44, 66),
    Border            = Color3.fromRGB(0, 120, 255),
    Separator         = Color3.fromRGB(40, 42, 62),
    Shadow            = Color3.fromRGB(0, 0, 0),
}

Themes.Midnight = {
    Background        = Color3.fromRGB(10, 10, 15),
    Sidebar           = Color3.fromRGB(15, 15, 22),
    TopBar            = Color3.fromRGB(15, 15, 22),
    Element           = Color3.fromRGB(22, 22, 32),
    ElementHover      = Color3.fromRGB(30, 30, 44),
    ElementActive     = Color3.fromRGB(38, 38, 55),
    Accent            = Color3.fromRGB(180, 100, 255),
    AccentHover       = Color3.fromRGB(200, 130, 255),
    AccentDark        = Color3.fromRGB(140, 70, 220),
    Text              = Color3.fromRGB(245, 240, 255),
    TextMuted         = Color3.fromRGB(165, 155, 185),
    TextDark          = Color3.fromRGB(115, 105, 135),
    ToggleOn          = Color3.fromRGB(180, 100, 255),
    ToggleOff         = Color3.fromRGB(42, 38, 60),
    Button            = Color3.fromRGB(150, 80, 240),
    ButtonHover       = Color3.fromRGB(175, 105, 255),
    Success           = Color3.fromRGB(0, 200, 130),
    Warning           = Color3.fromRGB(240, 175, 0),
    Error             = Color3.fromRGB(230, 60, 80),
    Slider            = Color3.fromRGB(35, 30, 50),
    SliderFill        = Color3.fromRGB(180, 100, 255),
    Dropdown          = Color3.fromRGB(26, 24, 40),
    DropdownHover     = Color3.fromRGB(42, 38, 62),
    Input             = Color3.fromRGB(30, 28, 46),
    InputFocus        = Color3.fromRGB(40, 36, 60),
    Border            = Color3.fromRGB(180, 100, 255),
    Separator         = Color3.fromRGB(38, 34, 55),
    Shadow            = Color3.fromRGB(0, 0, 0),
}

Themes.Ocean = {
    Background        = Color3.fromRGB(12, 20, 28),
    Sidebar           = Color3.fromRGB(16, 26, 36),
    TopBar            = Color3.fromRGB(18, 28, 40),
    Element           = Color3.fromRGB(24, 36, 50),
    ElementHover      = Color3.fromRGB(32, 46, 62),
    ElementActive     = Color3.fromRGB(40, 56, 74),
    Accent            = Color3.fromRGB(0, 200, 220),
    AccentHover       = Color3.fromRGB(30, 220, 240),
    AccentDark        = Color3.fromRGB(0, 160, 180),
    Text              = Color3.fromRGB(235, 250, 255),
    TextMuted         = Color3.fromRGB(150, 175, 195),
    TextDark          = Color3.fromRGB(100, 125, 145),
    ToggleOn          = Color3.fromRGB(0, 200, 220),
    ToggleOff         = Color3.fromRGB(38, 52, 68),
    Button            = Color3.fromRGB(0, 170, 190),
    ButtonHover       = Color3.fromRGB(0, 200, 220),
    Success           = Color3.fromRGB(0, 210, 140),
    Warning           = Color3.fromRGB(245, 180, 20),
    Error             = Color3.fromRGB(235, 70, 70),
    Slider            = Color3.fromRGB(32, 46, 62),
    SliderFill        = Color3.fromRGB(0, 200, 220),
    Dropdown          = Color3.fromRGB(26, 40, 54),
    DropdownHover     = Color3.fromRGB(42, 58, 76),
    Input             = Color3.fromRGB(30, 44, 60),
    InputFocus        = Color3.fromRGB(40, 56, 74),
    Border            = Color3.fromRGB(0, 200, 220),
    Separator         = Color3.fromRGB(38, 54, 70),
    Shadow            = Color3.fromRGB(0, 0, 0),
}

Themes.Monochrome = {
    Background        = Color3.fromRGB(18, 18, 18),
    Sidebar           = Color3.fromRGB(24, 24, 24),
    TopBar            = Color3.fromRGB(24, 24, 24),
    Element           = Color3.fromRGB(32, 32, 32),
    ElementHover      = Color3.fromRGB(44, 44, 44),
    ElementActive     = Color3.fromRGB(56, 56, 56),
    Accent            = Color3.fromRGB(240, 240, 240),
    AccentHover       = Color3.fromRGB(255, 255, 255),
    AccentDark        = Color3.fromRGB(180, 180, 180),
    Text              = Color3.fromRGB(245, 245, 245),
    TextMuted         = Color3.fromRGB(160, 160, 160),
    TextDark          = Color3.fromRGB(110, 110, 110),
    ToggleOn          = Color3.fromRGB(240, 240, 240),
    ToggleOff         = Color3.fromRGB(48, 48, 48),
    Button            = Color3.fromRGB(200, 200, 200),
    ButtonHover       = Color3.fromRGB(230, 230, 230),
    Success           = Color3.fromRGB(160, 220, 160),
    Warning           = Color3.fromRGB(230, 210, 130),
    Error             = Color3.fromRGB(230, 130, 130),
    Slider            = Color3.fromRGB(44, 44, 44),
    SliderFill        = Color3.fromRGB(240, 240, 240),
    Dropdown          = Color3.fromRGB(36, 36, 36),
    DropdownHover     = Color3.fromRGB(52, 52, 52),
    Input             = Color3.fromRGB(40, 40, 40),
    InputFocus        = Color3.fromRGB(52, 52, 52),
    Border            = Color3.fromRGB(120, 120, 120),
    Separator         = Color3.fromRGB(50, 50, 50),
    Shadow            = Color3.fromRGB(0, 0, 0),
}

Themes.Light = {
    Background        = Color3.fromRGB(245, 247, 250),
    Sidebar           = Color3.fromRGB(238, 241, 246),
    TopBar            = Color3.fromRGB(238, 241, 246),
    Element           = Color3.fromRGB(255, 255, 255),
    ElementHover      = Color3.fromRGB(245, 248, 252),
    ElementActive     = Color3.fromRGB(235, 240, 248),
    Accent            = Color3.fromRGB(0, 120, 220),
    AccentHover       = Color3.fromRGB(30, 145, 245),
    AccentDark        = Color3.fromRGB(0, 90, 180),
    Text              = Color3.fromRGB(30, 32, 45),
    TextMuted         = Color3.fromRGB(100, 105, 125),
    TextDark          = Color3.fromRGB(150, 155, 175),
    ToggleOn          = Color3.fromRGB(0, 150, 240),
    ToggleOff         = Color3.fromRGB(210, 215, 225),
    Button            = Color3.fromRGB(0, 110, 210),
    ButtonHover       = Color3.fromRGB(0, 135, 245),
    Success           = Color3.fromRGB(0, 175, 90),
    Warning           = Color3.fromRGB(220, 150, 0),
    Error             = Color3.fromRGB(220, 50, 50),
    Slider            = Color3.fromRGB(225, 230, 240),
    SliderFill        = Color3.fromRGB(0, 135, 240),
    Dropdown          = Color3.fromRGB(245, 248, 252),
    DropdownHover     = Color3.fromRGB(235, 240, 248),
    Input             = Color3.fromRGB(245, 248, 252),
    InputFocus        = Color3.fromRGB(235, 240, 248),
    Border            = Color3.fromRGB(200, 210, 225),
    Separator         = Color3.fromRGB(220, 225, 235),
    Shadow            = Color3.fromRGB(0, 0, 0),
}

-- =====================================================
-- UTILITY FUNCTIONS
-- =====================================================
local function Create(instanceType, properties, parent)
    local instance = Instance.new(instanceType)
    for prop, value in pairs(properties or {}) do
        pcall(function() instance[prop] = value end)
    end
    if parent then
        instance.Parent = parent
    end
    return instance
end

local function Tween(instance, properties, duration, style, direction)
    if not instance then return end
    local info = TweenInfo.new(
        duration or 0.2,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(instance, info, properties)
    tween:Play()
    return tween
end

local function Safe(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then
        warn("[SV] Error: " .. tostring(err))
    end
    return ok
end

local function Lerp(a, b, t)
    return a + (b - a) * t
end

local function FormatNumber(n)
    if type(n) ~= "number" then return tostring(n) end
    local formatted = tostring(math.floor(n))
    local k
    while true do
        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return formatted
end

local function FormatTime(seconds)
    seconds = math.floor(seconds or 0)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    if h > 0 then
        return string.format("%02d:%02d:%02d", h, m, s)
    else
        return string.format("%02d:%02d", m, s)
    end
end

local function RoundTo(n, decimals)
    local mult = 10 ^ (decimals or 0)
    return math.floor(n * mult + 0.5) / mult
end

local function GetFPS()
    return math.floor(1 / math.max(RunService.RenderStepped:Wait(), 0.0001))
end

local function GetPing()
    local ok, ping = pcall(function()
        return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    return ok and ping or 0
end

-- =====================================================
-- CUSTOM SV LOGO (Frame-drawn)
-- =====================================================
local function DrawSVLogo(parent, size, colors)
    size = size or 60
    colors = colors or { primary = Color3.fromRGB(0, 120, 255), accent = Color3.fromRGB(139, 92, 246) }

    local wrap = Create("Frame", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, size, 0, size),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
    })

    local hex = Create("Frame", {
        Parent = wrap,
        BackgroundColor3 = colors.primary,
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })
    Create("UICorner", { Parent = hex, CornerRadius = UDim.new(0.28, 0) })
    Create("UIGradient", {
        Parent = hex,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, colors.primary),
            ColorSequenceKeypoint.new(0.5, colors.accent),
            ColorSequenceKeypoint.new(1, colors.primary),
        }),
        Rotation = 45,
    })

    -- Inner glow
    Create("Frame", {
        Parent = hex,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.82,
        Size = UDim2.new(0.85, 0, 0.35, 0),
        Position = UDim2.new(0.5, 0, -0.05, 0),
        AnchorPoint = Vector2.new(0.5, 0),
        BorderSizePixel = 0,
    })

    -- S shape (5 bars)
    local function bar(pos, sz, rot)
        local f = Create("Frame", {
            Parent = hex,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Size = sz,
            Position = pos,
            BorderSizePixel = 0,
            Rotation = rot or 0,
        })
        Create("UICorner", { Parent = f, CornerRadius = UDim.new(1, 0) })
    end

    bar(UDim2.new(0.24, 0, 0.26, 0), UDim2.new(0.42, 0, 0.10, 0))
    bar(UDim2.new(0.24, 0, 0.26, 0), UDim2.new(0.10, 0, 0.20, 0))
    bar(UDim2.new(0.28, 0, 0.45, 0), UDim2.new(0.42, 0, 0.10, 0))
    bar(UDim2.new(0.62, 0, 0.55, 0), UDim2.new(0.10, 0, 0.20, 0))
    bar(UDim2.new(0.28, 0, 0.64, 0), UDim2.new(0.42, 0, 0.10, 0))
    -- V shape (2 bars)
    bar(UDim2.new(0.78, 0, 0.26, 0), UDim2.new(0.10, 0, 0.44, 0), 18)
    bar(UDim2.new(0.78, 0, 0.26, 0), UDim2.new(0.10, 0, 0.44, 0), -18)

    Create("UIStroke", {
        Parent = hex,
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 2,
        Transparency = 0.4,
    })

    return wrap
end

-- =====================================================
-- ICON LIBRARY (Roblox asset IDs)
-- =====================================================
local Icons = {
    Home       = "rbxassetid://6031075931",
    Farm       = "rbxassetid://6034277421",
    Combat     = "rbxassetid://6031094678",
    Player     = "rbxassetid://6031225389",
    Settings   = "rbxassetid://6031280882",
    Visual     = "rbxassetid://6031302945",
    Misc       = "rbxassetid://6031154871",
    Shop       = "rbxassetid://6034280643",
    Info       = "rbxassetid://6034289245",
    Debug      = "rbxassetid://6031090990",
    Tools      = "rbxassetid://6035067834",
    Folder     = "rbxassetid://6034982098",
    Stats      = "rbxassetid://6031279000",
    Script     = "rbxassetid://6034277377",
    Lock       = "rbxassetid://6031216977",
    Key        = "rbxassetid://6031265976",
}

-- =====================================================
-- MAIN WINDOW CREATOR
-- =====================================================
function SV:CreateWindow(options)
    options = options or {}

    local WindowName       = options.Name or "ScriptVault"
    local LoadingTitle     = options.LoadingTitle or WindowName
    local LoadingSubtitle  = options.LoadingSubtitle or "Loading..."
    local ThemeName        = options.Theme or "DarkBlue"
    local Icon             = options.Icon or 4483362458
    local Width            = options.Width or 720
    local Height           = options.Height or 480
    local SidebarWidth     = options.SidebarWidth or 200
    local ToggleKeybind    = options.ToggleKeybind or Enum.KeyCode.RightShift
    local ShowWatermark    = options.Watermark
    if ShowWatermark == nil then ShowWatermark = true end
    local ConfigurationSaving = options.ConfigurationSaving or { Enabled = false }

    local Colors = Themes[ThemeName] or Themes.DarkBlue
    local ScreenGui

    -- ScreenGui
    ScreenGui = Create("ScreenGui", {
        Name = "ScriptVaultUI_" .. tostring(math.random(10000, 99999)),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        DisplayOrder = 999999,
    })

    local ok = pcall(function() ScreenGui.Parent = LP:WaitForChild("PlayerGui") end)
    if not ok then
        pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    end

    -- =====================================================
    -- LOADING SCREEN
    -- =====================================================
    local LoadingFrame = Create("Frame", {
        Name = "Loading",
        Size = UDim2.new(0, 380, 0, 220),
        Position = UDim2.new(0.5, -190, 0.5, -110),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        ZIndex = 100,
        Parent = ScreenGui,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 14) }, LoadingFrame)
    Create("UIStroke", { Color = Colors.Accent, Thickness = 2 }, LoadingFrame)

    -- Outer glow ring
    local glowRing = Create("Frame", {
        Parent = LoadingFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 20, 1, 20),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 99,
    })
    Create("UICorner", { Parent = glowRing, CornerRadius = UDim.new(0, 16) })
    Create("UIStroke", { Parent = glowRing, Color = Colors.Accent, Thickness = 1, Transparency = 0.6 })

    -- Logo
    local LoadLogoWrap = Create("Frame", {
        Parent = LoadingFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 90, 0, 90),
        Position = UDim2.new(0.5, -45, 0, 20),
    })
    local logo = DrawSVLogo(LoadLogoWrap, 90, { primary = Colors.Accent, accent = Colors.AccentHover })

    -- Logo pulse
    task.spawn(function()
        while logo.Parent do
            Tween(logo, { Size = UDim2.new(0, 82, 0, 82) }, 0.6, Enum.EasingStyle.Sine)
            task.wait(0.6)
            if not logo.Parent then break end
            Tween(logo, { Size = UDim2.new(0, 90, 0, 90) }, 0.6, Enum.EasingStyle.Sine)
            task.wait(0.6)
        end
    end)

    -- Title
    Create("TextLabel", {
        Parent = LoadingFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 26),
        Position = UDim2.new(0, 0, 0, 118),
        Text = LoadingTitle,
        TextColor3 = Colors.Text,
        TextSize = 20,
        Font = Enum.Font.GothamBold,
    })

    -- Subtitle
    Create("TextLabel", {
        Parent = LoadingFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 0, 0, 148),
        Text = LoadingSubtitle,
        TextColor3 = Colors.Accent,
        TextSize = 13,
        Font = Enum.Font.Gotham,
    })

    -- Progress bar background
    local LoadBarBg = Create("Frame", {
        Parent = LoadingFrame,
        Size = UDim2.new(0.72, 0, 0, 6),
        Position = UDim2.new(0.14, 0, 0, 180),
        BackgroundColor3 = Colors.ToggleOff,
        BorderSizePixel = 0,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0) }, LoadBarBg)

    -- Progress fill
    local LoadBarFill = Create("Frame", {
        Parent = LoadBarBg,
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0) }, LoadBarFill)

    -- Percentage label
    local LoadPct = Create("TextLabel", {
        Parent = LoadingFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 0, 195),
        Text = "0%",
        TextColor3 = Colors.TextMuted,
        TextSize = 11,
        Font = Enum.Font.Gotham,
    })

    -- =====================================================
    -- MAIN WINDOW
    -- =====================================================
    local Window = Create("Frame", {
        Name = "MainWindow",
        Size = UDim2.new(0, Width, 0, Height),
        Position = UDim2.new(0.5, -Width / 2, 0.5, -Height / 2),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        Active = true,
        Visible = false,
        Parent = ScreenGui,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 12) }, Window)
    local WindowStroke = Create("UIStroke", { Color = Colors.Border, Thickness = 1.5 }, Window)

    -- Drop shadow
    local shadow = Create("Frame", {
        Parent = Window,
        BackgroundColor3 = Colors.Shadow,
        BackgroundTransparency = 0.75,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 8, 1, 8),
        Position = UDim2.new(0, -4, 0, -4),
        ZIndex = -1,
    })
    Create("UICorner", { Parent = shadow, CornerRadius = UDim.new(0, 14) })

    -- =====================================================
    -- TOP BAR
    -- =====================================================
    local TopBar = Create("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Colors.TopBar,
        BorderSizePixel = 0,
        Parent = Window,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 12, 0, 12) }, TopBar)
    Create("Frame", {
        Parent = TopBar,
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        BackgroundColor3 = Colors.TopBar,
        BorderSizePixel = 0,
    })

    -- Window title
    local TitleLabel = Create("TextLabel", {
        Parent = TopBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -320, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        Text = WindowName,
        TextColor3 = Colors.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    -- Search bar
    local SearchWrap = Create("Frame", {
        Parent = TopBar,
        Size = UDim2.new(0, 180, 0, 28),
        Position = UDim2.new(1, -290, 0.5, -14),
        BackgroundColor3 = Colors.Input,
        BorderSizePixel = 0,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8) }, SearchWrap)
    local SearchStroke = Create("UIStroke", { Parent = SearchWrap, Color = Colors.Separator, Thickness = 1 })

    local SearchIcon = Create("ImageLabel", {
        Parent = SearchWrap,
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 8, 0.5, -8),
        BackgroundTransparency = 1,
        Image = "rbxassetid://6031090990",
        ImageColor3 = Colors.TextMuted,
        ScaleType = Enum.ScaleType.Fit,
    })

    local SearchBox = Create("TextBox", {
        Parent = SearchWrap,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -32, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        Text = "",
        PlaceholderText = "Search...",
        PlaceholderColor3 = Colors.TextDark,
        TextColor3 = Colors.Text,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
    })

    SearchBox.Focused:Connect(function()
        Tween(SearchStroke, { Color = Colors.Accent }, 0.15)
    end)
    SearchBox.FocusLost:Connect(function()
        Tween(SearchStroke, { Color = Colors.Separator }, 0.15)
    end)

    -- Minimize button
    local MinBtn = Create("TextButton", {
        Parent = TopBar,
        Size = UDim2.new(0, 30, 0, 28),
        Position = UDim2.new(1, -100, 0.5, -14),
        BackgroundColor3 = Colors.Warning,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 7) }, MinBtn)
    Create("Frame", {
        Parent = MinBtn,
        Size = UDim2.new(0, 12, 0, 2),
        Position = UDim2.new(0.5, -6, 0.5, -1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
    })

    -- Close button
    local CloseBtn = Create("TextButton", {
        Parent = TopBar,
        Size = UDim2.new(0, 30, 0, 28),
        Position = UDim2.new(1, -66, 0.5, -14),
        BackgroundColor3 = Colors.Error,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 7) }, CloseBtn)
    for _, rot in ipairs({ 45, -45 }) do
        local b = Create("Frame", {
            Parent = CloseBtn,
            Size = UDim2.new(0, 12, 0, 2),
            Position = UDim2.new(0.5, -6, 0.5, -1),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            Rotation = rot,
        })
    end

    MinBtn.MouseEnter:Connect(function() Tween(MinBtn, { BackgroundColor3 = Color3.fromRGB(245, 175, 20) }, 0.1) end)
    MinBtn.MouseLeave:Connect(function() Tween(MinBtn, { BackgroundColor3 = Colors.Warning }, 0.1) end)
    CloseBtn.MouseEnter:Connect(function() Tween(CloseBtn, { BackgroundColor3 = Color3.fromRGB(245, 80, 80) }, 0.1) end)
    CloseBtn.MouseLeave:Connect(function() Tween(CloseBtn, { BackgroundColor3 = Colors.Error }, 0.1) end)

    -- =====================================================
    -- SIDEBAR
    -- =====================================================
    local Sidebar = Create("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, SidebarWidth, 1, -44),
        Position = UDim2.new(0, 0, 0, 44),
        BackgroundColor3 = Colors.Sidebar,
        BorderSizePixel = 0,
        Parent = Window,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 0, 0, 12) }, Sidebar)

    -- Logo panel at top of sidebar
    local LogoPanel = Create("Frame", {
        Parent = Sidebar,
        Size = UDim2.new(1, 0, 0, 120),
        BackgroundTransparency = 1,
    })

    local LogoHolder = Create("Frame", {
        Parent = LogoPanel,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 70, 0, 70),
        Position = UDim2.new(0.5, -35, 0, 14),
    })
    local sidebarLogo = DrawSVLogo(LogoHolder, 70, { primary = Colors.Accent, accent = Colors.AccentHover })

    Create("TextLabel", {
        Parent = LogoPanel,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 0, 0, 90),
        Text = WindowName,
        TextColor3 = Colors.Text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
    })

    Create("TextLabel", {
        Parent = LogoPanel,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 0, 106),
        Text = "v" .. SV._VERSION,
        TextColor3 = Colors.Accent,
        TextSize = 10,
        Font = Enum.Font.Gotham,
    })

    -- Tab list container
    local TabList = Create("ScrollingFrame", {
        Parent = Sidebar,
        Size = UDim2.new(1, 0, 1, -122),
        Position = UDim2.new(0, 0, 0, 122),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Colors.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    })
    Create("UIListLayout", { Parent = TabList, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder })
    Create("UIPadding", { Parent = TabList, PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 4) })

    -- =====================================================
    -- CONTENT AREA
    -- =====================================================
    local ContentArea = Create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -SidebarWidth, 1, -44),
        Position = UDim2.new(0, SidebarWidth, 0, 44),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = Window,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 0, 12, 0) }, ContentArea)

    -- =====================================================
    -- NOTIFICATIONS
    -- =====================================================
    local NotifyContainer = Create("Frame", {
        Parent = ScreenGui,
        Size = UDim2.new(0, 320, 1, -40),
        Position = UDim2.new(1, -340, 0, 20),
        BackgroundTransparency = 1,
        ZIndex = 1000,
    })
    Create("UIListLayout", {
        Parent = NotifyContainer,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
    })

    local notifyQueue = {}
    local notifyLimit = 5

    local function Notify(opts)
        opts = opts or {}
        local title = opts.Title or "Notification"
        local content = opts.Content or ""
        local duration = opts.Duration or 5
        local nType = opts.Type or "Info"

        local typeColor = Colors.Accent
        if nType == "Success" then typeColor = Colors.Success
        elseif nType == "Warning" then typeColor = Colors.Warning
        elseif nType == "Error" then typeColor = Colors.Error
        end

        local icons = { Info = "i", Success = "OK", Warning = "!", Error = "X" }

        local n = Create("Frame", {
            Parent = NotifyContainer,
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundColor3 = Colors.Element,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            LayoutOrder = #NotifyContainer:GetChildren() + 1,
        })
        Create("UICorner", { CornerRadius = UDim.new(0, 10) }, n)
        Create("UIStroke", { Parent = n, Color = typeColor, Thickness = 1.5, Transparency = 0.4 })

        Create("Frame", {
            Parent = n,
            Size = UDim2.new(0, 3, 1, -16),
            Position = UDim2.new(0, 0, 0, 8),
            BackgroundColor3 = typeColor,
            BorderSizePixel = 0,
        })

        local iconCircle = Create("Frame", {
            Parent = n,
            Size = UDim2.new(0, 26, 0, 26),
            Position = UDim2.new(0, 14, 0, 12),
            BackgroundColor3 = typeColor,
            BorderSizePixel = 0,
        })
        Create("UICorner", { Parent = iconCircle, CornerRadius = UDim.new(1, 0) })
        Create("TextLabel", {
            Parent = iconCircle,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Text = icons[nType] or "i",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 12,
            Font = Enum.Font.GothamBold,
        })

        Create("TextLabel", {
            Parent = n,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -60, 0, 18),
            Position = UDim2.new(0, 50, 0, 10),
            Text = title,
            TextColor3 = Colors.Text,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        local contentLbl = Create("TextLabel", {
            Parent = n,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -60, 0, 0),
            Position = UDim2.new(0, 50, 0, 30),
            Text = content,
            TextColor3 = Colors.TextMuted,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
        })

        -- Calculate height based on text
        task.wait(0)
        local textBounds = contentLbl.TextBounds
        local height = 30 + math.max(textBounds.Y, 16) + 12
        contentLbl.Size = UDim2.new(1, -60, 0, textBounds.Y)
        n.Size = UDim2.new(1, 0, 0, height)

        -- Animate in
        n.Position = UDim2.new(1, 60, 0, 0)
        Tween(n, { Position = UDim2.new(0, 0, 0, 0) }, 0.32, Enum.EasingStyle.Quint)

        task.delay(duration, function()
            if n.Parent then
                Tween(n, { Position = UDim2.new(1, 60, 0, 0) }, 0.28, Enum.EasingStyle.Quad)
                task.wait(0.3)
                pcall(function() n:Destroy() end)
            end
        end)

        return n
    end

    -- =====================================================
    -- WATERMARK
    -- =====================================================
    local Watermark
    if ShowWatermark then
        Watermark = Create("Frame", {
            Parent = ScreenGui,
            Size = UDim2.new(0, 260, 0, 26),
            Position = UDim2.new(0, 16, 0, 16),
            BackgroundColor3 = Colors.Background,
            BackgroundTransparency = 0.15,
            BorderSizePixel = 0,
            ZIndex = 999,
        })
        Create("UICorner", { CornerRadius = UDim.new(0, 8) }, Watermark)
        Create("UIStroke", { Parent = Watermark, Color = Colors.Accent, Thickness = 1, Transparency = 0.4 })

        local wmLogo = Create("Frame", {
            Parent = Watermark,
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 4, 0.5, -10),
            BackgroundColor3 = Colors.Accent,
            BorderSizePixel = 0,
        })
        Create("UICorner", { Parent = wmLogo, CornerRadius = UDim.new(0, 5) })
        Create("TextLabel", {
            Parent = wmLogo,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Text = "SV",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 10,
            Font = Enum.Font.GothamBlack,
        })

        local wmText = Create("TextLabel", {
            Parent = Watermark,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -34, 1, 0),
            Position = UDim2.new(0, 28, 0, 0),
            Text = "ScriptVault | -- FPS | -- ms | --:--:--",
            TextColor3 = Colors.Text,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        task.spawn(function()
            local frames, t0 = 0, tick()
            RunService.RenderStepped:Connect(function()
                frames = frames + 1
                if tick() - t0 >= 1 then
                    local fps = frames
                    local ping = GetPing()
                    local clock = os.date("%H:%M:%S")
                    pcall(function()
                        wmText.Text = string.format("ScriptVault | %d FPS | %d ms | %s", fps, ping, clock)
                    end)
                    frames, t0 = 0, tick()
                end
            end)
        end)
    end

    -- =====================================================
    -- DRAGGING
    -- =====================================================
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Window.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Window.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- =====================================================
    -- RESIZE HANDLE (bottom-right corner)
    -- =====================================================
    local ResizeHandle = Create("TextButton", {
        Parent = Window,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -20, 1, -20),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 10,
    })

    local rDragging, rStart, rSizeStart = false, nil, nil

    ResizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            rDragging = true
            rStart = input.Position
            rSizeStart = Window.AbsoluteSize
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    rDragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if rDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - rStart
            local newWidth = math.max(500, rSizeStart.X + delta.X)
            local newHeight = math.max(320, rSizeStart.Y + delta.Y)
            Window.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)

    -- =====================================================
    -- MINIMIZE / CLOSE
    -- =====================================================
    local isMinimized = false

    local MinIcon = Create("TextButton", {
        Parent = ScreenGui,
        Size = UDim2.new(0, 60, 0, 60),
        Position = UDim2.new(1, -80, 0.5, -30),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
        Text = "",
        Visible = false,
        ZIndex = 500,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0) }, MinIcon)
    Create("UIStroke", { Parent = MinIcon, Color = Colors.AccentHover, Thickness = 2 })

    local minHolder = Create("Frame", {
        Parent = MinIcon,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 42, 0, 42),
        Position = UDim2.new(0.5, -21, 0.5, -21),
    })
    DrawSVLogo(minHolder, 42, { primary = Color3.fromRGB(255, 255, 255), accent = Color3.fromRGB(220, 240, 255) })

    local function Minimize()
        if isMinimized then return end
        isMinimized = true
        Tween(Window, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(1, -80, 0.5, -30) }, 0.25)
        task.wait(0.25)
        Window.Visible = false
        MinIcon.Visible = true
        MinIcon.Size = UDim2.new(0, 0, 0, 0)
        Tween(MinIcon, { Size = UDim2.new(0, 60, 0, 60) }, 0.35, Enum.EasingStyle.Back)
    end

    local function Restore()
        if not isMinimized then return end
        isMinimized = false
        Tween(MinIcon, { Size = UDim2.new(0, 0, 0, 0) }, 0.2)
        task.wait(0.2)
        MinIcon.Visible = false
        Window.Visible = true
        Window.Size = UDim2.new(0, 0, 0, 0)
        Window.Position = UDim2.new(1, -80, 0.5, -30)
        Tween(Window, {
            Size = UDim2.new(0, Width, 0, Height),
            Position = UDim2.new(0.5, -Width / 2, 0.5, -Height / 2),
        }, 0.35, Enum.EasingStyle.Back)
    end

    MinBtn.MouseButton1Click:Connect(Minimize)
    MinIcon.MouseButton1Click:Connect(Restore)
    CloseBtn.MouseButton1Click:Connect(function()
        Tween(Window, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0) }, 0.25)
        task.wait(0.25)
        ScreenGui:Destroy()
    end)

    -- Keybind toggle
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == ToggleKeybind then
            if isMinimized then Restore() else Minimize() end
        end
    end)

    -- =====================================================
    -- TAB SYSTEM
    -- =====================================================
    local Tabs = {}
    local TabContents = {}
    local CurrentTab = nil
    local searchQuery = ""

    local function CreateTab(name, iconId, options)
        options = options or {}
        local order = options.Order or (#Tabs + 1)

        local TabBtn = Create("TextButton", {
            Parent = TabList,
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = Colors.Element,
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = order,
        })
        Create("UICorner", { CornerRadius = UDim.new(0, 8) }, TabBtn)

        local Indicator = Create("Frame", {
            Parent = TabBtn,
            Size = UDim2.new(0, 3, 0, 24),
            Position = UDim2.new(0, 0, 0.5, -12),
            BackgroundColor3 = Colors.Accent,
            BorderSizePixel = 0,
            Visible = false,
        })
        Create("UICorner", { CornerRadius = UDim.new(0, 3) }, Indicator)

        local Icon = Create("ImageLabel", {
            Parent = TabBtn,
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 14, 0.5, -10),
            BackgroundTransparency = 1,
            Image = "rbxassetid://" .. tostring(iconId or Icons.Home),
            ImageColor3 = Colors.TextMuted,
            ScaleType = Enum.ScaleType.Fit,
        })
        pcall(function() ContentProvider:PreloadAsync({ Icon }) end)

        local Text = Create("TextLabel", {
            Parent = TabBtn,
            Size = UDim2.new(1, -45, 1, 0),
            Position = UDim2.new(0, 44, 0, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = Colors.TextMuted,
            TextSize = 13,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        -- Badge
        local Badge
        if options.Badge then
            Badge = Create("Frame", {
                Parent = TabBtn,
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(1, -26, 0.5, -9),
                BackgroundColor3 = Colors.Accent,
                BorderSizePixel = 0,
            })
            Create("UICorner", { Parent = Badge, CornerRadius = UDim.new(1, 0) })
            Create("TextLabel", {
                Parent = Badge,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = tostring(options.Badge),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 10,
                Font = Enum.Font.GothamBold,
            })
        end

        -- Content
        local Content = Create("ScrollingFrame", {
            Parent = ContentArea,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Colors.Accent,
            BorderSizePixel = 0,
        })
        Create("UIListLayout", { Parent = Content, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
        Create("UIPadding", {
            Parent = Content,
            PaddingTop = UDim.new(0, 16),
            PaddingBottom = UDim.new(0, 16),
            PaddingLeft = UDim.new(0, 16),
            PaddingRight = UDim.new(0, 16),
        })

        local function Activate()
            if CurrentTab and CurrentTab ~= TabBtn then
                Tween(CurrentTab, { BackgroundColor3 = Colors.Element }, 0.15)
                local oldInd = CurrentTab:FindFirstChild("Indicator")
                if oldInd then oldInd.Visible = false end
                local oldIcon = CurrentTab:FindFirstChild("Icon")
                if oldIcon then Tween(oldIcon, { ImageColor3 = Colors.TextMuted }, 0.15) end
                local oldText = CurrentTab:FindFirstChild("Text")
                if oldText then Tween(oldText, { TextColor3 = Colors.TextMuted }, 0.15) end
            end
            CurrentTab = TabBtn
            Tween(TabBtn, { BackgroundColor3 = Colors.ElementHover }, 0.15)
            local ind = TabBtn:FindFirstChild("Indicator")
            if ind then ind.Visible = true end
            local ic = TabBtn:FindFirstChild("Icon")
            if ic then Tween(ic, { ImageColor3 = Colors.Text }, 0.15) end
            local tx = TabBtn:FindFirstChild("Text")
            if tx then Tween(tx, { TextColor3 = Colors.Text }, 0.15) end

            for tabName, tabContent in pairs(TabContents) do
                tabContent.Visible = (tabName == name)
            end
        end

        TabBtn.MouseButton1Click:Connect(Activate)
        TabBtn.MouseEnter:Connect(function()
            if CurrentTab ~= TabBtn then
                Tween(TabBtn, { BackgroundColor3 = Colors.ElementHover }, 0.12)
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if CurrentTab ~= TabBtn then
                Tween(TabBtn, { BackgroundColor3 = Colors.Element }, 0.12)
            end
        end)

        table.insert(Tabs, { name = name, button = TabBtn, content = Content })
        TabContents[name] = Content

        if not CurrentTab then Activate() end

        -- Search match test
        local function matchesSearch()
            if searchQuery == "" then return true end
            return name:lower():find(searchQuery:lower(), 1, true) ~= nil
        end

        -- =====================================================
        -- ELEMENT BUILDERS (per tab)
        -- =====================================================
        local ElementID = 0
        local function NextOrder()
            ElementID = ElementID + 1
            return ElementID
        end

        local Tab = {}

        function Tab:CreateSection(title)
            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 32),
                BackgroundTransparency = 1,
                LayoutOrder = NextOrder(),
                Name = "Section_" .. tostring(title),
            })
            Create("Frame", {
                Parent = container,
                Size = UDim2.new(0, 3, 0, 16),
                Position = UDim2.new(0, 0, 0.5, -8),
                BackgroundColor3 = Colors.Accent,
                BorderSizePixel = 0,
            })
            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -10, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = string.upper(title),
                TextColor3 = Colors.TextMuted,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            return container
        end

        function Tab:CreateDivider()
            local d = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = Colors.Separator,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            return d
        end

        function Tab:CreateLabel(text)
            local l = Create("TextLabel", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 26),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Colors.Text,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = NextOrder(),
            })
            return l
        end

        function Tab:CreateParagraph(opts)
            opts = opts or {}
            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 100),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)
            Create("UIStroke", { Parent = container, Color = Colors.Separator, Thickness = 1 })

            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -24, 0, 22),
                Position = UDim2.new(0, 12, 0, 10),
                BackgroundTransparency = 1,
                Text = opts.Title or "Title",
                TextColor3 = Colors.Text,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local body = Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -24, 1, -44),
                Position = UDim2.new(0, 12, 0, 36),
                BackgroundTransparency = 1,
                Text = opts.Content or "",
                TextColor3 = Colors.TextMuted,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
            })

            task.wait(0)
            local bounds = body.TextBounds
            container.Size = UDim2.new(1, 0, 0, 44 + bounds.Y + 6)
            body.Size = UDim2.new(1, -24, 0, bounds.Y)

            return container
        end

        function Tab:CreateToggle(opts)
            opts = opts or {}
            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, opts.Description and 58 or 44),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            local btn = Create("TextButton", {
                Parent = container,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
            })

            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -75, 0, 20),
                Position = UDim2.new(0, 14, 0, opts.Description and 10 or 12),
                BackgroundTransparency = 1,
                Text = opts.Name or "Toggle",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            if opts.Description then
                Create("TextLabel", {
                    Parent = container,
                    Size = UDim2.new(1, -75, 0, 16),
                    Position = UDim2.new(0, 14, 0, 30),
                    BackgroundTransparency = 1,
                    Text = opts.Description,
                    TextColor3 = Colors.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
            end

            local track = Create("Frame", {
                Parent = container,
                Size = UDim2.new(0, 44, 0, 24),
                Position = UDim2.new(1, -58, 0.5, -12),
                BackgroundColor3 = (opts.CurrentValue or false) and Colors.ToggleOn or Colors.ToggleOff,
                BorderSizePixel = 0,
            })
            Create("UICorner", { Parent = track, CornerRadius = UDim.new(1, 0) }, track)

            local knob = Create("Frame", {
                Parent = track,
                Size = UDim2.new(0, 18, 0, 18),
                Position = (opts.CurrentValue or false) and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
            })
            Create("UICorner", { Parent = knob, CornerRadius = UDim.new(1, 0) }, knob)

            local value = opts.CurrentValue or false

            local function setValue(v)
                value = v
                Tween(knob, { Position = v and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9) }, 0.18)
                Tween(track, { BackgroundColor3 = v and Colors.ToggleOn or Colors.ToggleOff }, 0.18)
                if opts.Callback then Safe(opts.Callback, v) end
            end

            btn.MouseButton1Click:Connect(function() setValue(not value) end)

            container.MouseEnter:Connect(function() Tween(container, { BackgroundColor3 = Colors.ElementHover }, 0.12) end)
            container.MouseLeave:Connect(function() Tween(container, { BackgroundColor3 = Colors.Element }, 0.12) end)

            return {
                Container = container,
                SetValue = setValue,
                GetValue = function() return value end,
                Set = setValue,
            }
        end

        function Tab:CreateButton(opts)
            opts = opts or {}
            local variant = opts.Variant or "Primary"

            local variantColors = {
                Primary = { base = Colors.Button, hover = Colors.ButtonHover },
                Success = { base = Colors.Success, hover = Color3.fromRGB(0, 220, 130) },
                Warning = { base = Colors.Warning, hover = Color3.fromRGB(245, 180, 20) },
                Error   = { base = Colors.Error, hover = Color3.fromRGB(245, 80, 80) },
                Ghost   = { base = Colors.Element, hover = Colors.ElementHover },
            }

            local vc = variantColors[variant] or variantColors.Primary

            local btn = Create("TextButton", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = vc.base,
                BorderSizePixel = 0,
                Text = opts.Name or "Button",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                AutoButtonColor = false,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 8) }, btn)

            btn.MouseEnter:Connect(function()
                Tween(btn, { BackgroundColor3 = vc.hover, Size = UDim2.new(1, 2, 0, 40) }, 0.12)
            end)
            btn.MouseLeave:Connect(function()
                Tween(btn, { BackgroundColor3 = vc.base, Size = UDim2.new(1, 0, 0, 40) }, 0.12)
            end)

            btn.MouseButton1Click:Connect(function()
                if opts.Callback then Safe(opts.Callback) end
            end)

            return btn
        end

        function Tab:CreateSlider(opts)
            opts = opts or {}
            local range = opts.Range or { 0, 100 }
            local min, max = range[1], range[2]
            local step = opts.Increment or 1
            local currentValue = opts.CurrentValue or min

            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 60),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -80, 0, 20),
                Position = UDim2.new(0, 14, 0, 8),
                BackgroundTransparency = 1,
                Text = opts.Name or "Slider",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local valueLabel = Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(0, 60, 0, 20),
                Position = UDim2.new(1, -70, 0, 8),
                BackgroundTransparency = 1,
                Text = tostring(currentValue),
                TextColor3 = Colors.Accent,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Right,
            })

            local track = Create("Frame", {
                Parent = container,
                Size = UDim2.new(1, -28, 0, 8),
                Position = UDim2.new(0, 14, 1, -22),
                BackgroundColor3 = Colors.Slider,
                BorderSizePixel = 0,
            })
            Create("UICorner", { Parent = track, CornerRadius = UDim.new(1, 0) }, track)

            local fill = Create("Frame", {
                Parent = track,
                Size = UDim2.new((currentValue - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Colors.SliderFill,
                BorderSizePixel = 0,
            })
            Create("UICorner", { Parent = fill, CornerRadius = UDim.new(1, 0) }, fill)

            local knob = Create("Frame", {
                Parent = track,
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new((currentValue - min) / (max - min), -8, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ZIndex = 5,
            })
            Create("UICorner", { Parent = knob, CornerRadius = UDim.new(1, 0) }, knob)

            local dragging = false

            local function updateFromInput(input)
                local relX = input.Position.X - track.AbsolutePosition.X
                local pos = math.clamp(relX / track.AbsoluteSize.X, 0, 1)
                local val = min + (max - min) * pos
                val = math.floor(val / step + 0.5) * step
                val = math.clamp(val, min, max)

                knob.Position = UDim2.new(pos, -8, 0.5, -8)
                fill.Size = UDim2.new(pos, 0, 1, 0)
                valueLabel.Text = tostring(val)
                currentValue = val
                if opts.Callback then Safe(opts.Callback, val) end
            end

            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateFromInput(input)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateFromInput(input)
                end
            end)

            return {
                Container = container,
                SetValue = function(v)
                    v = math.clamp(v, min, max)
                    currentValue = v
                    local pos = (v - min) / (max - min)
                    knob.Position = UDim2.new(pos, -8, 0.5, -8)
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    valueLabel.Text = tostring(v)
                    if opts.Callback then Safe(opts.Callback, v) end
                end,
                GetValue = function() return currentValue end,
            }
        end

        function Tab:CreateDropdown(opts)
            opts = opts or {}
            local options = opts.Options or {}
            local multiple = opts.MultipleOptions or false
            local selected = {}
            local current = opts.CurrentOption or (multiple and {} or (options[1] or "None"))

            if type(current) == "string" then
                selected[current] = true
            elseif type(current) == "table" then
                for _, v in ipairs(current) do selected[v] = true end
            end

            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 62),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -30, 0, 18),
                Position = UDim2.new(0, 14, 0, 6),
                BackgroundTransparency = 1,
                Text = opts.Name or "Dropdown",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local selectBtn = Create("TextButton", {
                Parent = container,
                Size = UDim2.new(1, -28, 0, 32),
                Position = UDim2.new(0, 14, 0, 26),
                BackgroundColor3 = Colors.Input,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
            })
            Create("UICorner", { Parent = selectBtn, CornerRadius = UDim.new(0, 6) }, selectBtn)

            local displayText
            local function updateDisplay()
                if multiple then
                    local list = {}
                    for k in pairs(selected) do table.insert(list, k) end
                    if #list == 0 then displayText = "None"
                    elseif #list <= 2 then displayText = table.concat(list, ", ")
                    else displayText = list[1] .. " +" .. (#list - 1) end
                else
                    displayText = current
                end
            end
            updateDisplay()

            local textLabel = Create("TextLabel", {
                Parent = selectBtn,
                Size = UDim2.new(1, -40, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = tostring(displayText),
                TextColor3 = Colors.Text,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local arrow = Create("TextLabel", {
                Parent = selectBtn,
                Size = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -24, 0, 0),
                BackgroundTransparency = 1,
                Text = "v",
                TextColor3 = Colors.TextMuted,
                TextSize = 12,
                Font = Enum.Font.GothamBold,
            })

            local listFrame = Create("ScrollingFrame", {
                Parent = container,
                Size = UDim2.new(1, -28, 0, 0),
                Position = UDim2.new(0, 14, 0, 60),
                BackgroundColor3 = Colors.Dropdown,
                BorderSizePixel = 0,
                Visible = false,
                ZIndex = 20,
                ScrollBarThickness = 3,
                ScrollBarImageColor3 = Colors.Accent,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
            })
            Create("UICorner", { Parent = listFrame, CornerRadius = UDim.new(0, 6) }, listFrame)
            Create("UIListLayout", { Parent = listFrame, Padding = UDim.new(0, 2) })
            Create("UIPadding", {
                Parent = listFrame,
                PaddingTop = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 4),
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4),
            })

            local isOpen = false

            local function toggleList()
                isOpen = not isOpen
                if isOpen then
                    listFrame.Visible = true
                    local h = math.min(#options * 32 + 8, 200)
                    Tween(listFrame, { Size = UDim2.new(1, -28, 0, h) }, 0.2)
                    Tween(arrow, { Rotation = 180 }, 0.2)
                else
                    Tween(listFrame, { Size = UDim2.new(1, -28, 0, 0) }, 0.2)
                    Tween(arrow, { Rotation = 0 }, 0.2)
                    task.wait(0.2)
                    listFrame.Visible = false
                end
            end

            selectBtn.MouseButton1Click:Connect(toggleList)

            for _, opt in ipairs(options) do
                local optBtn = Create("TextButton", {
                    Parent = listFrame,
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = Colors.DropdownHover,
                    BorderSizePixel = 0,
                    Text = opt,
                    TextColor3 = Colors.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    AutoButtonColor = false,
                    ZIndex = 21,
                })
                Create("UICorner", { Parent = optBtn, CornerRadius = UDim.new(0, 5) }, optBtn)

                optBtn.MouseEnter:Connect(function()
                    Tween(optBtn, { BackgroundColor3 = Colors.ElementHover }, 0.1)
                end)
                optBtn.MouseLeave:Connect(function()
                    Tween(optBtn, { BackgroundColor3 = Colors.DropdownHover }, 0.1)
                end)

                optBtn.MouseButton1Click:Connect(function()
                    if multiple then
                        selected[opt] = not selected[opt] or nil
                        updateDisplay()
                        textLabel.Text = tostring(displayText)
                        local list = {}
                        for k in pairs(selected) do table.insert(list, k) end
                        if opts.Callback then Safe(opts.Callback, list) end
                    else
                        current = opt
                        selected = { [opt] = true }
                        updateDisplay()
                        textLabel.Text = tostring(displayText)
                        toggleList()
                        if opts.Callback then Safe(opts.Callback, opt) end
                    end
                end)
            end

            return {
                Container = container,
                SetValue = function(v)
                    current = v
                    updateDisplay()
                    textLabel.Text = tostring(displayText)
                end,
                GetValue = function() return multiple and selected or current end,
            }
        end

        function Tab:CreateInput(opts)
            opts = opts or {}

            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 62),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -30, 0, 18),
                Position = UDim2.new(0, 14, 0, 6),
                BackgroundTransparency = 1,
                Text = opts.Name or "Input",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local inputBox = Create("TextBox", {
                Parent = container,
                Size = UDim2.new(1, -28, 0, 30),
                Position = UDim2.new(0, 14, 0, 26),
                BackgroundColor3 = Colors.Input,
                BorderSizePixel = 0,
                Text = opts.Default or "",
                TextColor3 = Colors.Text,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                PlaceholderText = opts.Placeholder or "Enter...",
                PlaceholderColor3 = Colors.TextDark,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = opts.ClearOnFocus or false,
            })
            Create("UICorner", { Parent = inputBox, CornerRadius = UDim.new(0, 6) }, inputBox)
            local inputStroke = Create("UIStroke", { Parent = inputBox, Color = Colors.Separator, Thickness = 1 })

            inputBox.Focused:Connect(function()
                Tween(inputStroke, { Color = Colors.Accent }, 0.15)
            end)
            inputBox.FocusLost:Connect(function(enterPressed)
                Tween(inputStroke, { Color = Colors.Separator }, 0.15)
                if enterPressed and opts.Callback then
                    Safe(opts.Callback, inputBox.Text)
                end
            end)

            return {
                Container = container,
                SetText = function(t) inputBox.Text = t end,
                GetText = function() return inputBox.Text end,
            }
        end

        function Tab:CreateKeybind(opts)
            opts = opts or {}
            local currentKey = opts.Default or "None"

            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 44),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -80, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = opts.Name or "Keybind",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local keyBtn = Create("TextButton", {
                Parent = container,
                Size = UDim2.new(0, 60, 0, 28),
                Position = UDim2.new(1, -72, 0.5, -14),
                BackgroundColor3 = Colors.Input,
                BorderSizePixel = 0,
                Text = currentKey,
                TextColor3 = Colors.Text,
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                AutoButtonColor = false,
            })
            Create("UICorner", { Parent = keyBtn, CornerRadius = UDim.new(0, 6) }, keyBtn)

            local recording = false
            local conn

            keyBtn.MouseButton1Click:Connect(function()
                if recording then return end
                recording = true
                keyBtn.Text = "..."
                keyBtn.BackgroundColor3 = Colors.Accent
                conn = UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode.Name
                        keyBtn.Text = currentKey
                        keyBtn.BackgroundColor3 = Colors.Input
                        recording = false
                        if conn then conn:Disconnect() end
                        if opts.Callback then Safe(opts.Callback, input.KeyCode) end
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.MouseButton2 then
                        currentKey = input.UserInputType.Name:gsub("MouseButton", "Mouse")
                        keyBtn.Text = currentKey
                        keyBtn.BackgroundColor3 = Colors.Input
                        recording = false
                        if conn then conn:Disconnect() end
                        if opts.Callback then Safe(opts.Callback, input.UserInputType) end
                    end
                end)
            end)

            return {
                Container = container,
                GetValue = function() return currentKey end,
                SetValue = function(v)
                    currentKey = v
                    keyBtn.Text = v
                end,
            }
        end

        function Tab:CreateColorPicker(opts)
            opts = opts or {}
            local currentColor = opts.Default or Color3.fromRGB(255, 255, 255)

            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 180),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -60, 0, 20),
                Position = UDim2.new(0, 14, 0, 8),
                BackgroundTransparency = 1,
                Text = opts.Name or "Color Picker",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local preview = Create("Frame", {
                Parent = container,
                Size = UDim2.new(0, 40, 0, 24),
                Position = UDim2.new(1, -54, 0, 8),
                BackgroundColor3 = currentColor,
                BorderSizePixel = 0,
            })
            Create("UICorner", { Parent = preview, CornerRadius = UDim.new(0, 6) }, preview)

            -- R/G/B sliders
            local sliders = {}
            local names = { "R", "G", "B" }
            local startY = 38

            for i = 1, 3 do
                local label = Create("TextLabel", {
                    Parent = container,
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(0, 14, 0, startY + (i - 1) * 40),
                    BackgroundTransparency = 1,
                    Text = names[i],
                    TextColor3 = Colors.TextMuted,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left,
                })

                local track = Create("Frame", {
                    Parent = container,
                    Size = UDim2.new(1, -80, 0, 8),
                    Position = UDim2.new(0, 40, 0, startY + (i - 1) * 40 + 6),
                    BackgroundColor3 = Colors.Slider,
                    BorderSizePixel = 0,
                })
                Create("UICorner", { Parent = track, CornerRadius = UDim.new(1, 0) }, track)

                local fill = Create("Frame", {
                    Parent = track,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Colors.SliderFill,
                    BorderSizePixel = 0,
                })
                Create("UICorner", { Parent = fill, CornerRadius = UDim.new(1, 0) }, fill)

                local knob = Create("Frame", {
                    Parent = track,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(1, -7, 0.5, -7),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    ZIndex = 5,
                })
                Create("UICorner", { Parent = knob, CornerRadius = UDim.new(1, 0) }, knob)

                local val = math.floor(currentColor[names[i] == "R" and "R" or names[i] == "G" and "G" or "B"] * 255)

                local drag = false
                local function update(input)
                    local relX = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                    knob.Position = UDim2.new(relX, -7, 0.5, -7)
                    fill.Size = UDim2.new(relX, 0, 1, 0)
                    val = math.floor(relX * 255)
                    local r = sliders[1] and sliders[1].value or 0
                    local g = sliders[2] and sliders[2].value or 0
                    local b = sliders[3] and sliders[3].value or 0
                    if i == 1 then r = val elseif i == 2 then g = val elseif i == 3 then b = val end
                    currentColor = Color3.fromRGB(r, g, b)
                    preview.BackgroundColor3 = currentColor
                    if opts.Callback then Safe(opts.Callback, currentColor) end
                end

                track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch then
                        drag = true
                        update(input)
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch then
                        drag = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if drag and (input.UserInputType == Enum.UserInputType.MouseMovement
                        or input.UserInputType == Enum.UserInputType.Touch) then
                        update(input)
                    end
                end)

                sliders[i] = { track = track, fill = fill, knob = knob, value = val }
            end

            return {
                Container = container,
                GetValue = function() return currentColor end,
                SetValue = function(c)
                    currentColor = c
                    preview.BackgroundColor3 = c
                end,
            }
        end

        function Tab:CreateStatRow(opts)
            opts = opts or {}
            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            local colorBar = Create("Frame", {
                Parent = container,
                Size = UDim2.new(0, 3, 1, -14),
                Position = UDim2.new(0, 0, 0, 7),
                BackgroundColor3 = opts.Color or Colors.Accent,
                BorderSizePixel = 0,
            })

            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(0.6, 0, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = opts.Label or "Stat",
                TextColor3 = Colors.TextMuted,
                TextSize = 12,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local valueLabel = Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(0.4, -14, 1, 0),
                Position = UDim2.new(0.6, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = tostring(opts.Value or "0"),
                TextColor3 = Colors.Text,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Right,
            })

            task.spawn(function()
                while container.Parent do
                    if opts.Update then
                        local ok, v = pcall(opts.Update)
                        if ok then valueLabel.Text = tostring(v) end
                    end
                    task.wait(0.5)
                end
            end)

            return {
                Container = container,
                SetValue = function(v) valueLabel.Text = tostring(v) end,
            }
        end

        function Tab:CreateProgressBar(opts)
            opts = opts or {}
            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -100, 0, 16),
                Position = UDim2.new(0, 14, 0, 6),
                BackgroundTransparency = 1,
                Text = opts.Name or "Progress",
                TextColor3 = Colors.Text,
                TextSize = 12,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local track = Create("Frame", {
                Parent = container,
                Size = UDim2.new(1, -28, 0, 6),
                Position = UDim2.new(0, 14, 1, -16),
                BackgroundColor3 = Colors.Slider,
                BorderSizePixel = 0,
            })
            Create("UICorner", { Parent = track, CornerRadius = UDim.new(1, 0) }, track)

            local fill = Create("Frame", {
                Parent = track,
                Size = UDim2.new(opts.Value or 0, 0, 1, 0),
                BackgroundColor3 = opts.Color or Colors.Accent,
                BorderSizePixel = 0,
            })
            Create("UICorner", { Parent = fill, CornerRadius = UDim.new(1, 0) }, fill)

            return {
                Container = container,
                SetValue = function(v)
                    v = math.clamp(v, 0, 1)
                    Tween(fill, { Size = UDim2.new(v, 0, 1, 0) }, 0.3)
                end,
            }
        end

        function Tab:CreateCodeBlock(opts)
            opts = opts or {}
            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, 60),
                BackgroundColor3 = Color3.fromRGB(15, 15, 22),
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            local codeText = Create("TextLabel", {
                Parent = container,
                Size = UDim2.new(1, -20, 1, -20),
                Position = UDim2.new(0, 10, 0, 10),
                BackgroundTransparency = 1,
                Text = opts.Code or "print('Hello')",
                TextColor3 = Color3.fromRGB(150, 255, 180),
                TextSize = 11,
                Font = Enum.Font.Code,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
            })

            task.wait(0)
            local bounds = codeText.TextBounds
            container.Size = UDim2.new(1, 0, 0, bounds.Y + 24)
            codeText.Size = UDim2.new(1, -20, 0, bounds.Y)

            return container
        end

        function Tab:CreateImageLabel(opts)
            opts = opts or {}
            local container = Create("Frame", {
                Parent = Content,
                Size = UDim2.new(1, 0, 0, opts.Height or 100),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
                ClipsDescendants = true,
            })
            Create("UICorner", { Parent = container, CornerRadius = UDim.new(0, 8) }, container)

            local img = Create("ImageLabel", {
                Parent = container,
                Size = UDim2.new(1, -20, 1, -20),
                Position = UDim2.new(0, 10, 0, 10),
                BackgroundTransparency = 1,
                Image = opts.Image or "",
                ScaleType = Enum.ScaleType.Fit,
            })
            pcall(function() ContentProvider:PreloadAsync({ img }) end)

            return container
        end

        -- Store in local tab map for search
        Tabs[#Tabs].elements = {}
        Tabs[#Tabs].matchesSearch = matchesSearch

        return Tab
    end

    -- =====================================================
    -- SEARCH FUNCTIONALITY
    -- =====================================================
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        searchQuery = SearchBox.Text
        for _, tab in ipairs(Tabs) do
            if tab.matchesSearch then
                tab.button.Visible = tab.matchesSearch()
            end
        end
    end)

    -- =====================================================
    -- CONFIG SYSTEM
    -- =====================================================
    local ConfigData = {}

    local function SaveConfig(name)
        if not ConfigurationSaving.Enabled then return end
        local fileName = (ConfigurationSaving.FileName or "sv_config") .. "_" .. (name or "default") .. ".json"
        local ok, encoded = pcall(function() return HttpService:JSONEncode(ConfigData) end)
        if ok and writefile then
            pcall(writefile, fileName, encoded)
            Notify({ Title = "Config Saved", Content = fileName, Type = "Success", Duration = 3 })
        end
    end

    local function LoadConfig(name)
        if not ConfigurationSaving.Enabled then return end
        local fileName = (ConfigurationSaving.FileName or "sv_config") .. "_" .. (name or "default") .. ".json"
        if readfile and isfile and isfile(fileName) then
            local ok, data = pcall(function() return HttpService:JSONDecode(readfile(fileName)) end)
            if ok and data then
                ConfigData = data
                Notify({ Title = "Config Loaded", Content = fileName, Type = "Success", Duration = 3 })
            end
        end
    end

    -- =====================================================
    -- SHOW WINDOW AFTER LOADING
    -- =====================================================
    task.spawn(function()
        local steps = { 0.15, 0.35, 0.55, 0.75, 0.95, 1.0 }
        for _, pct in ipairs(steps) do
            Tween(LoadBarFill, { Size = UDim2.new(pct, 0, 1, 0) }, 0.25)
            LoadPct.Text = math.floor(pct * 100) .. "%"
            task.wait(0.22)
        end
        task.wait(0.35)

        Tween(LoadingFrame, {
            Size = UDim2.new(0, 380, 0, 0),
            BackgroundTransparency = 1,
        }, 0.4, Enum.EasingStyle.Quint)
        Tween(glowRing, { BackgroundTransparency = 1 }, 0.35)

        for _, child in ipairs(LoadingFrame:GetDescendants()) do
            if child:IsA("GuiObject") then
                pcall(function() Tween(child, { BackgroundTransparency = 1, TextTransparency = 1, ImageTransparency = 1 }, 0.35) end)
            end
        end

        task.wait(0.5)
        pcall(function() LoadingFrame:Destroy() end)

        Window.Visible = true
        Window.Size = UDim2.new(0, 0, 0, 0)
        Tween(Window, {
            Size = UDim2.new(0, Width, 0, Height),
        }, 0.45, Enum.EasingStyle.Back)
    end)

    -- =====================================================
    -- WINDOW API RETURN
    -- =====================================================
    local WindowAPI = {}

    function WindowAPI:CreateTab(name, iconId, options)
        return CreateTab(name, iconId, options)
    end

    function WindowAPI:Notify(opts)
        return Notify(opts)
    end

    function WindowAPI:SaveConfig(name)
        SaveConfig(name)
    end

    function WindowAPI:LoadConfig(name)
        LoadConfig(name)
    end

    function WindowAPI:SetTheme(themeName)
        local newColors = Themes[themeName]
        if not newColors then return end
        for k, v in pairs(newColors) do Colors[k] = v end
        Notify({ Title = "Theme Changed", Content = themeName, Type = "Success", Duration = 2 })
    end

    function WindowAPI:Destroy()
        pcall(function() ScreenGui:Destroy() end)
    end

    function WindowAPI:Minimize() Minimize() end
    function WindowAPI:Restore() Restore() end

    function WindowAPI:GetWindow() return Window end
    function WindowAPI:GetSidebar() return Sidebar end
    function WindowAPI:GetContentArea() return ContentArea end
    function WindowAPI:GetConfig() return ConfigData end

    -- Initial notification
    task.delay(1.6, function()
        Notify({
            Title = "ScriptVault Loaded",
            Content = "UI Library v" .. SV._VERSION .. " ready. Right Shift to toggle.",
            Type = "Success",
            Duration = 5,
        })
    end)

    return WindowAPI
end

-- =====================================================
-- RETURN LIBRARY
-- =====================================================
return SV
