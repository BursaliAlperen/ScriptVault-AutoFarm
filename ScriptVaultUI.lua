--[[
=====================================================
  ScriptVault UI Library v4.0.0
  Professional Roblox UI Library - Clean Rewrite
  Author: BursaliAlperen
  Kullanım:
    local SV = loadstring(game:HttpGet("RAW_URL"))()
    local Window = SV:CreateWindow({ Name = "My Script" })
    local Tab = Window:CreateTab("Main")
    Tab:CreateButton({ Name = "Click", Callback = function() print("hi") end })
=====================================================
]]

local SV = {}
SV.__index = SV
SV._VERSION = "4.0.0"
SV._BUILD = "20260201"

-- =====================================================
-- SERVICES
-- =====================================================
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local ContentProvider  = game:GetService("ContentProvider")
local HttpService      = game:GetService("HttpService")
local Stats            = game:GetService("Stats")
local CoreGui          = game:GetService("CoreGui")
local LP               = Players.LocalPlayer

-- =====================================================
-- ICON LIBRARY
-- =====================================================
SV.Icons = {
    Logo      = "rbxassetid://111637853140695",
    Home      = "rbxassetid://6031075931",
    Player    = "rbxassetid://6031225389",
    Stats     = "rbxassetid://6031279000",
    Combat    = "rbxassetid://6031094678",
    Tools     = "rbxassetid://6035067834",
    Misc      = "rbxassetid://6031154871",
    Shop      = "rbxassetid://6034280643",
    Visual    = "rbxassetid://6031302945",
    Key       = "rbxassetid://6031265976",
    Lock      = "rbxassetid://6031216977",
    Script    = "rbxassetid://6034277377",
    Debug     = "rbxassetid://6031090990",
    Folder    = "rbxassetid://6034982098",
    Info      = "rbxassetid://17829948066",
    Settings  = "rbxassetid://9405931578",
    Teleport  = "rbxassetid://16538185173",
    Farm      = "rbxassetid://11330204834",
    Star      = "rbxassetid://138880939782808",
    Check     = "rbxassetid://122032243989747",
}

-- =====================================================
-- THEMES
-- =====================================================
local Themes = {}
local function RegisterTheme(name, c) Themes[name] = c end

RegisterTheme("DarkBlue", {
    Background = Color3.fromRGB(15, 16, 24),
    Sidebar    = Color3.fromRGB(20, 21, 32),
    TopBar     = Color3.fromRGB(22, 23, 35),
    Element    = Color3.fromRGB(28, 29, 44),
    ElementHover = Color3.fromRGB(36, 37, 56),
    Accent     = Color3.fromRGB(0, 120, 255),
    AccentHover= Color3.fromRGB(30, 145, 255),
    Text       = Color3.fromRGB(240, 242, 255),
    TextMuted  = Color3.fromRGB(160, 165, 190),
    TextDark   = Color3.fromRGB(110, 115, 140),
    ToggleOn   = Color3.fromRGB(0, 150, 255),
    ToggleOff  = Color3.fromRGB(48, 50, 70),
    Success    = Color3.fromRGB(0, 200, 110),
    Warning    = Color3.fromRGB(230, 165, 0),
    Error      = Color3.fromRGB(225, 60, 60),
    Slider     = Color3.fromRGB(38, 40, 60),
    SliderFill = Color3.fromRGB(0, 135, 255),
    Input      = Color3.fromRGB(36, 37, 55),
    Border     = Color3.fromRGB(0, 120, 255),
    Separator  = Color3.fromRGB(40, 42, 62),
    Overlay    = Color3.fromRGB(0, 0, 0),
})

RegisterTheme("Midnight", {
    Background = Color3.fromRGB(10, 10, 15),
    Sidebar    = Color3.fromRGB(15, 15, 22),
    TopBar     = Color3.fromRGB(15, 15, 22),
    Element    = Color3.fromRGB(22, 22, 32),
    ElementHover = Color3.fromRGB(30, 30, 44),
    Accent     = Color3.fromRGB(180, 100, 255),
    AccentHover= Color3.fromRGB(200, 130, 255),
    Text       = Color3.fromRGB(245, 240, 255),
    TextMuted  = Color3.fromRGB(165, 155, 185),
    TextDark   = Color3.fromRGB(115, 105, 135),
    ToggleOn   = Color3.fromRGB(180, 100, 255),
    ToggleOff  = Color3.fromRGB(42, 38, 60),
    Success    = Color3.fromRGB(0, 200, 130),
    Warning    = Color3.fromRGB(240, 175, 0),
    Error      = Color3.fromRGB(230, 60, 80),
    Slider     = Color3.fromRGB(35, 30, 50),
    SliderFill = Color3.fromRGB(180, 100, 255),
    Input      = Color3.fromRGB(30, 28, 46),
    Border     = Color3.fromRGB(180, 100, 255),
    Separator  = Color3.fromRGB(38, 34, 55),
    Overlay    = Color3.fromRGB(0, 0, 0),
})

RegisterTheme("Ocean", {
    Background = Color3.fromRGB(12, 20, 28),
    Sidebar    = Color3.fromRGB(16, 26, 36),
    TopBar     = Color3.fromRGB(18, 28, 40),
    Element    = Color3.fromRGB(24, 36, 50),
    ElementHover = Color3.fromRGB(32, 46, 62),
    Accent     = Color3.fromRGB(0, 200, 220),
    AccentHover= Color3.fromRGB(30, 220, 240),
    Text       = Color3.fromRGB(235, 250, 255),
    TextMuted  = Color3.fromRGB(150, 175, 195),
    TextDark   = Color3.fromRGB(100, 125, 145),
    ToggleOn   = Color3.fromRGB(0, 200, 220),
    ToggleOff  = Color3.fromRGB(38, 52, 68),
    Success    = Color3.fromRGB(0, 210, 140),
    Warning    = Color3.fromRGB(245, 180, 20),
    Error      = Color3.fromRGB(235, 70, 70),
    Slider     = Color3.fromRGB(32, 46, 62),
    SliderFill = Color3.fromRGB(0, 200, 220),
    Input      = Color3.fromRGB(30, 44, 60),
    Border     = Color3.fromRGB(0, 200, 220),
    Separator  = Color3.fromRGB(38, 54, 70),
    Overlay    = Color3.fromRGB(0, 0, 0),
})

RegisterTheme("Light", {
    Background = Color3.fromRGB(245, 247, 250),
    Sidebar    = Color3.fromRGB(238, 241, 246),
    TopBar     = Color3.fromRGB(238, 241, 246),
    Element    = Color3.fromRGB(255, 255, 255),
    ElementHover = Color3.fromRGB(245, 248, 252),
    Accent     = Color3.fromRGB(0, 120, 220),
    AccentHover= Color3.fromRGB(30, 145, 245),
    Text       = Color3.fromRGB(30, 32, 45),
    TextMuted  = Color3.fromRGB(100, 105, 125),
    TextDark   = Color3.fromRGB(150, 155, 175),
    ToggleOn   = Color3.fromRGB(0, 150, 240),
    ToggleOff  = Color3.fromRGB(210, 215, 225),
    Success    = Color3.fromRGB(0, 175, 90),
    Warning    = Color3.fromRGB(220, 150, 0),
    Error      = Color3.fromRGB(220, 50, 50),
    Slider     = Color3.fromRGB(225, 230, 240),
    SliderFill = Color3.fromRGB(0, 135, 240),
    Input      = Color3.fromRGB(245, 248, 252),
    Border     = Color3.fromRGB(200, 210, 225),
    Separator  = Color3.fromRGB(220, 225, 235),
    Overlay    = Color3.fromRGB(0, 0, 0),
})

RegisterTheme("Monochrome", {
    Background = Color3.fromRGB(18, 18, 18),
    Sidebar    = Color3.fromRGB(24, 24, 24),
    TopBar     = Color3.fromRGB(24, 24, 24),
    Element    = Color3.fromRGB(32, 32, 32),
    ElementHover = Color3.fromRGB(44, 44, 44),
    Accent     = Color3.fromRGB(240, 240, 240),
    AccentHover= Color3.fromRGB(255, 255, 255),
    Text       = Color3.fromRGB(245, 245, 245),
    TextMuted  = Color3.fromRGB(160, 160, 160),
    TextDark   = Color3.fromRGB(110, 110, 110),
    ToggleOn   = Color3.fromRGB(240, 240, 240),
    ToggleOff  = Color3.fromRGB(48, 48, 48),
    Success    = Color3.fromRGB(160, 220, 160),
    Warning    = Color3.fromRGB(230, 210, 130),
    Error      = Color3.fromRGB(230, 130, 130),
    Slider     = Color3.fromRGB(44, 44, 44),
    SliderFill = Color3.fromRGB(240, 240, 240),
    Input      = Color3.fromRGB(40, 40, 40),
    Border     = Color3.fromRGB(120, 120, 120),
    Separator  = Color3.fromRGB(50, 50, 50),
    Overlay    = Color3.fromRGB(0, 0, 0),
})

RegisterTheme("Sunset", {
    Background = Color3.fromRGB(24, 15, 20),
    Sidebar    = Color3.fromRGB(32, 20, 28),
    TopBar     = Color3.fromRGB(36, 22, 32),
    Element    = Color3.fromRGB(42, 26, 38),
    ElementHover = Color3.fromRGB(56, 34, 48),
    Accent     = Color3.fromRGB(255, 100, 100),
    AccentHover= Color3.fromRGB(255, 130, 130),
    Text       = Color3.fromRGB(255, 240, 240),
    TextMuted  = Color3.fromRGB(200, 165, 175),
    TextDark   = Color3.fromRGB(140, 110, 120),
    ToggleOn   = Color3.fromRGB(255, 100, 100),
    ToggleOff  = Color3.fromRGB(60, 42, 52),
    Success    = Color3.fromRGB(200, 200, 100),
    Warning    = Color3.fromRGB(255, 190, 80),
    Error      = Color3.fromRGB(255, 80, 80),
    Slider     = Color3.fromRGB(50, 32, 42),
    SliderFill = Color3.fromRGB(255, 100, 100),
    Input      = Color3.fromRGB(44, 28, 38),
    Border     = Color3.fromRGB(255, 100, 100),
    Separator  = Color3.fromRGB(60, 40, 50),
    Overlay    = Color3.fromRGB(0, 0, 0),
})

RegisterTheme("Forest", {
    Background = Color3.fromRGB(14, 22, 16),
    Sidebar    = Color3.fromRGB(20, 30, 22),
    TopBar     = Color3.fromRGB(22, 32, 24),
    Element    = Color3.fromRGB(28, 40, 32),
    ElementHover = Color3.fromRGB(38, 52, 42),
    Accent     = Color3.fromRGB(80, 220, 120),
    AccentHover= Color3.fromRGB(110, 240, 140),
    Text       = Color3.fromRGB(230, 250, 235),
    TextMuted  = Color3.fromRGB(150, 180, 160),
    TextDark   = Color3.fromRGB(105, 130, 115),
    ToggleOn   = Color3.fromRGB(80, 220, 120),
    ToggleOff  = Color3.fromRGB(40, 55, 46),
    Success    = Color3.fromRGB(80, 240, 140),
    Warning    = Color3.fromRGB(220, 200, 80),
    Error      = Color3.fromRGB(230, 80, 80),
    Slider     = Color3.fromRGB(36, 52, 42),
    SliderFill = Color3.fromRGB(80, 220, 120),
    Input      = Color3.fromRGB(32, 48, 38),
    Border     = Color3.fromRGB(80, 220, 120),
    Separator  = Color3.fromRGB(42, 60, 48),
    Overlay    = Color3.fromRGB(0, 0, 0),
})

-- =====================================================
-- UTILITIES
-- =====================================================
local function Create(class, props, parent)
    local inst = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            if k ~= "Parent" then
                local ok = pcall(function() inst[k] = v end)
                if not ok then warn("[SV] Property '" .. tostring(k) .. "' set failed on " .. class) end
            end
        end
    end
    inst.Parent = parent or props and props.Parent
    return inst
end

local function Corner(radius, parent)
    return Create("UICorner", { CornerRadius = radius or UDim.new(0, 8) }, parent)
end

local function Stroke(color, thickness, transparency, parent)
    return Create("UIStroke", {
        Color = color or Color3.fromRGB(255,255,255),
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, parent)
end

local function Padding(parent, top, bottom, left, right)
    return Create("UIPadding", {
        PaddingTop    = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft   = UDim.new(0, left or 0),
        PaddingRight  = UDim.new(0, right or 0),
    }, parent)
end

local function ListLayout(parent, padding, direction, align)
    return Create("UIListLayout", {
        Padding = UDim.new(0, padding or 0),
        FillDirection = direction or Enum.FillDirection.Vertical,
        HorizontalAlignment = align or Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, parent)
end

local function Tween(instance, props, duration, style, direction)
    if not instance or not instance.Parent then return end
    local info = TweenInfo.new(
        duration or 0.2,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    local tw = TweenService:Create(instance, info, props)
    tw:Play()
    return tw
end

local function Safe(fn, ...)
    if type(fn) ~= "function" then return end
    local ok, err = pcall(fn, ...)
    if not ok then warn("[SV Callback Error] " .. tostring(err)) end
    return ok
end

local function FormatNumber(n)
    if type(n) ~= "number" then return tostring(n) end
    local s = tostring(math.floor(n))
    local formatted = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    formatted = formatted:gsub("^,", "")
    return formatted
end

local function FormatTime(seconds)
    seconds = math.floor(tonumber(seconds) or 0)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    if h > 0 then return string.format("%02d:%02d:%02d", h, m, s) end
    return string.format("%02d:%02d", m, s)
end

local function GetPing()
    local ok, ping = pcall(function()
        return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    return ok and ping or 0
end

local function GetMemory()
    local ok, mem = pcall(function()
        return math.floor(Stats:GetTotalMemoryUsageMb())
    end)
    return ok and mem or 0
end

local function IsTouchDevice()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

-- =====================================================
-- ICON CACHE
-- =====================================================
local IconCache = {}

local function NormalizeIconId(id)
    if not id then return nil end
    if type(id) == "number" then return "rbxassetid://" .. tostring(id) end
    if type(id) == "string" then
        if id:sub(1, 12) == "rbxassetid://" then return id end
        if id:sub(1, 4) == "rbx" then return id end
        if id:match("^%d+$") then return "rbxassetid://" .. id end
        return id
    end
    return nil
end

local function PreloadIcon(assetId)
    if not assetId or IconCache[assetId] then return end
    IconCache[assetId] = true
    task.spawn(function()
        pcall(function()
            local tmp = Instance.new("ImageLabel")
            tmp.Image = assetId
            ContentProvider:PreloadAsync({ tmp })
            tmp:Destroy()
        end)
    end)
end

local function LoadIcon(id, size, color, parent, position)
    local assetId = NormalizeIconId(id)
    if not assetId then return nil end

    local img = Create("ImageLabel", {
        BackgroundTransparency = 1,
        Size = size or UDim2.new(0, 20, 0, 20),
        Image = assetId,
        ImageColor3 = color or Color3.fromRGB(255,255,255),
        ScaleType = Enum.ScaleType.Fit,
    }, parent)
    if position then img.Position = position end
    PreloadIcon(assetId)
    return img
end

-- =====================================================
-- NOTIFICATION MANAGER
-- =====================================================
local function CreateNotificationManager(screenGui, colors, config)
    local self = { active = {}, colors = colors, limit = (config and config.Limit) or 5 }

    local container = Create("Frame", {
        Size = UDim2.new(0, 340, 1, -40),
        Position = UDim2.new(1, -360, 0, 20),
        BackgroundTransparency = 1,
        ZIndex = 1000,
    }, screenGui)
    ListLayout(container, 10, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Right)

    function self:Push(opts)
        opts = opts or {}
        local C = self.colors
        local title = opts.Title or "Notification"
        local content = opts.Content or ""
        local duration = opts.Duration or 5
        local nType = opts.Type or "Info"
        local iconId = opts.Icon

        local typeColor = C.Accent
        if nType == "Success" then typeColor = C.Success
        elseif nType == "Warning" then typeColor = C.Warning
        elseif nType == "Error" then typeColor = C.Error end

        while #self.active >= self.limit do
            local old = table.remove(self.active, 1)
            if old and old.Parent then old:Destroy() end
        end

        local n = Create("Frame", {
            Size = UDim2.new(1, 0, 0, 60),
            BackgroundColor3 = C.Element,
            BorderSizePixel = 0,
            ClipsDescendants = true,
        }, container)
        Corner(UDim.new(0, 10), n)
        Stroke(typeColor, 1.5, 0.4, n)

        Create("Frame", {
            Size = UDim2.new(0, 3, 1, -16),
            Position = UDim2.new(0, 0, 0, 8),
            BackgroundColor3 = typeColor,
            BorderSizePixel = 0,
        }, n)

        local iconCircle = Create("Frame", {
            Size = UDim2.new(0, 30, 0, 30),
            Position = UDim2.new(0, 14, 0, 12),
            BackgroundColor3 = typeColor,
            BorderSizePixel = 0,
        }, n)
        Corner(UDim.new(1, 0), iconCircle)

        if iconId then
            local img = LoadIcon(iconId, UDim2.new(0.65, 0, 0.65, 0), Color3.fromRGB(255,255,255), iconCircle)
            if img then
                img.Position = UDim2.new(0.5, 0, 0.5, 0)
                img.AnchorPoint = Vector2.new(0.5, 0.5)
            end
        else
            local icons = { Info = "i", Success = "✓", Warning = "!", Error = "×" }
            Create("TextLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = icons[nType] or "i",
                TextColor3 = Color3.fromRGB(255,255,255),
                TextSize = 14,
                Font = Enum.Font.GothamBold,
            }, iconCircle)
        end

        Create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -64, 0, 18),
            Position = UDim2.new(0, 54, 0, 10),
            Text = title,
            TextColor3 = C.Text,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, n)

        local body = Create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -64, 0, 16),
            Position = UDim2.new(0, 54, 0, 30),
            Text = content,
            TextColor3 = C.TextMuted,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
        }, n)

        task.defer(function()
            local bounds = body.TextBounds
            local h = 42 + math.max(bounds.Y, 16)
            Tween(n, { Size = UDim2.new(1, 0, 0, h) }, 0.2)
        end)

        n.Position = UDim2.new(1, 80, 0, 0)
        Tween(n, { Position = UDim2.new(0, 0, 0, 0) }, 0.35, Enum.EasingStyle.Quint)
        table.insert(self.active, n)

        task.delay(duration, function()
            if not n.Parent then return end
            Tween(n, { Position = UDim2.new(1, 80, 0, 0) }, 0.28)
            task.wait(0.3)
            for i, v in ipairs(self.active) do
                if v == n then table.remove(self.active, i) break end
            end
            if n.Parent then n:Destroy() end
        end)

        return n
    end

    return self
end

-- =====================================================
-- DIALOG MANAGER
-- =====================================================
local function CreateDialogManager(screenGui, colors)
    local self = { colors = colors, screenGui = screenGui }

    function self:Show(opts)
        opts = opts or {}
        local C = self.colors

        local overlay = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = C.Overlay,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 5000,
        }, screenGui)

        local box = Create("Frame", {
            Size = UDim2.new(0, 420, 0, 140),
            Position = UDim2.new(0.5, -210, 0.5, -70),
            BackgroundColor3 = C.Background,
            BorderSizePixel = 0,
            ZIndex = 5001,
        }, overlay)
        Corner(UDim.new(0, 14), box)
        Stroke(C.Border, 1.5, 0, box)

        Create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -32, 0, 26),
            Position = UDim2.new(0, 16, 0, 18),
            Text = opts.Title or "Dialog",
            TextColor3 = C.Text,
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 5002,
        }, box)

        local contentLbl = Create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -32, 0, 20),
            Position = UDim2.new(0, 16, 0, 50),
            Text = opts.Content or "",
            TextColor3 = C.TextMuted,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            ZIndex = 5002,
        }, box)

        local contentBounds = 20
        task.defer(function()
            contentBounds = contentLbl.TextBounds.Y
            contentLbl.Size = UDim2.new(1, -32, 0, contentBounds)
        end)

        local inputBox
        if opts.InputPlaceholder then
            inputBox = Create("TextBox", {
                Size = UDim2.new(1, -32, 0, 34),
                Position = UDim2.new(0, 16, 0, 60 + contentBounds),
                BackgroundColor3 = C.Input,
                BorderSizePixel = 0,
                Text = opts.InputDefault or "",
                TextColor3 = C.Text,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                PlaceholderText = opts.InputPlaceholder,
                PlaceholderColor3 = C.TextDark,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
                ZIndex = 5002,
            }, box)
            Corner(UDim.new(0, 6), inputBox)
            Padding(inputBox, 0, 0, 10, 10)
        end

        local function close()
            Tween(overlay, { BackgroundTransparency = 1 }, 0.2)
            Tween(box, { Size = UDim2.new(0, 420, 0, 60) }, 0.2)
            task.wait(0.22)
            if overlay.Parent then overlay:Destroy() end
        end

        local btns
        task.defer(function()
            local yOff = 70 + contentBounds + (inputBox and 46 or 0)
            btns = Create("Frame", {
                Size = UDim2.new(1, -32, 0, 40),
                Position = UDim2.new(0, 16, 0, yOff),
                BackgroundTransparency = 1,
                ZIndex = 5002,
            }, box)
            Create("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder,
            }, btns)

            local buttonList = opts.Buttons or {
                { Text = "Cancel", Variant = "Ghost" },
                { Text = "Confirm", Variant = "Primary", Callback = opts.OnConfirm },
            }

            for _, b in ipairs(buttonList) do
                local variantColors = {
                    Primary = C.Accent,
                    Success = C.Success,
                    Warning = C.Warning,
                    Error = C.Error,
                    Ghost = C.Element,
                }
                local baseColor = variantColors[b.Variant] or C.Accent

                local btn = Create("TextButton", {
                    Size = UDim2.new(0, 110, 1, 0),
                    BackgroundColor3 = baseColor,
                    BorderSizePixel = 0,
                    Text = b.Text or "OK",
                    TextColor3 = C.Text,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false,
                    ZIndex = 5003,
                }, btns)
                Corner(UDim.new(0, 6), btn)

                btn.MouseEnter:Connect(function()
                    Tween(btn, { BackgroundColor3 = C.AccentHover }, 0.1)
                end)
                btn.MouseLeave:Connect(function()
                    Tween(btn, { BackgroundColor3 = baseColor }, 0.1)
                end)
                btn.MouseButton1Click:Connect(function()
                    local val = inputBox and inputBox.Text
                    if b.Callback then Safe(b.Callback, val) end
                    close()
                end)
            end

            Tween(box, {
                Size = UDim2.new(0, 420, 0, yOff + 56),
                Position = UDim2.new(0.5, -210, 0.5, -(yOff + 56) / 2),
            }, 0.3, Enum.EasingStyle.Back)
        end)

        Tween(overlay, { BackgroundTransparency = 0.55 }, 0.2)
        return close
    end

    return self
end

-- =====================================================
-- TOOLTIP
-- =====================================================
local function AttachTooltip(target, text, colors, screenGui)
    local C = colors
    local tooltip
    local mouseMoveConn

    local function destroy()
        if tooltip and tooltip.Parent then tooltip:Destroy() end
        tooltip = nil
        if mouseMoveConn then mouseMoveConn:Disconnect() mouseMoveConn = nil end
    end

    target.MouseEnter:Connect(function()
        if not target.Parent then return end
        destroy()

        local mouse = UserInputService:GetMouseLocation()
        tooltip = Create("Frame", {
            Size = UDim2.new(0, 0, 0, 26),
            Position = UDim2.new(0, mouse.X + 12, 0, mouse.Y + 12),
            BackgroundColor3 = C.Background,
            BorderSizePixel = 0,
            ZIndex = 6000,
        }, screenGui)
        Corner(UDim.new(0, 6), tooltip)
        Stroke(C.Border, 1, 0, tooltip)

        local label = Create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -16, 1, 0),
            Position = UDim2.new(0, 8, 0, 0),
            Text = text,
            TextColor3 = C.Text,
            TextSize = 12,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = 6001,
        }, tooltip)

        task.defer(function()
            if tooltip then
                local b = label.TextBounds
                tooltip.Size = UDim2.new(0, b.X + 20, 0, 26)
            end
        end)

        mouseMoveConn = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement and tooltip then
                local m = UserInputService:GetMouseLocation()
                tooltip.Position = UDim2.new(0, m.X + 12, 0, m.Y + 12)
            end
        end)
    end)

    target.MouseLeave:Connect(destroy)
    target.Destroying:Connect(destroy)
end

-- =====================================================
-- MAIN WINDOW
-- =====================================================
function SV:CreateWindow(options)
    options = options or {}

    local WindowName      = options.Name or "ScriptVault"
    local LoadingTitle    = options.LoadingTitle or WindowName
    local LoadingSubtitle = options.LoadingSubtitle or "Yükleniyor..."
    local ThemeName       = options.Theme or "Ocean"
    local Width           = options.Width or 760
    local Height          = options.Height or 520
    local MinWidth        = options.MinWidth or 560
    local MinHeight       = options.MinHeight or 360
    local SidebarWidth    = options.SidebarWidth or 210
    local ToggleKeybind   = options.ToggleKeybind or Enum.KeyCode.RightShift
    local ShowWatermark   = options.Watermark
    if ShowWatermark == nil then ShowWatermark = true end
    local ConfigSaving    = options.ConfigurationSaving or { Enabled = false }
    local AccentIcon      = options.Icon or SV.Icons.Logo
    local Resizable       = options.Resizable
    if Resizable == nil then Resizable = true end
    local LoadingEnabled  = options.LoadingScreen
    if LoadingEnabled == nil then LoadingEnabled = true end

    local Colors = {}
    local baseColors = Themes[ThemeName] or Themes.Ocean
    for k, v in pairs(baseColors) do Colors[k] = v end

    -- --------------------------------------------------
    -- ScreenGui
    -- --------------------------------------------------
    local ScreenGui = Create("ScreenGui", {
        Name = "ScriptVaultUI_" .. tostring(math.random(100000, 999999)),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        DisplayOrder = 999999,
    })

    local parented = false
    if gethui then
        pcall(function() ScreenGui.Parent = gethui() parented = true end)
    end
    if not parented then
        pcall(function() ScreenGui.Parent = CoreGui parented = true end)
    end
    if not parented then
        pcall(function() ScreenGui.Parent = LP:WaitForChild("PlayerGui") end)
    end

    local Notify = CreateNotificationManager(ScreenGui, Colors, { Limit = 5 })
    local Dialog = CreateDialogManager(ScreenGui, Colors)

    -- --------------------------------------------------
    -- Loading Screen
    -- --------------------------------------------------
    local LoadingFrame
    if LoadingEnabled then
        LoadingFrame = Create("Frame", {
            Size = UDim2.new(0, 420, 0, 260),
            Position = UDim2.new(0.5, -210, 0.5, -130),
            BackgroundColor3 = Colors.Background,
            BorderSizePixel = 0,
            ZIndex = 100,
        }, ScreenGui)
        Corner(UDim.new(0, 16), LoadingFrame)
        Stroke(Colors.Accent, 2, 0, LoadingFrame)

        local logoWrap = Create("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 110, 0, 110),
            Position = UDim2.new(0.5, -55, 0, 22),
        }, LoadingFrame)

        local logoRing = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Colors.Accent,
            BorderSizePixel = 0,
        }, logoWrap)
        Corner(UDim.new(1, 0), logoRing)
        local img = LoadIcon(AccentIcon, UDim2.new(0.75, 0, 0.75, 0), Color3.fromRGB(255,255,255), logoRing)
        if img then
            img.Position = UDim2.new(0.5, 0, 0.5, 0)
            img.AnchorPoint = Vector2.new(0.5, 0.5)
        end

        Create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 30),
            Position = UDim2.new(0, 0, 0, 142),
            Text = LoadingTitle,
            TextColor3 = Colors.Text,
            TextSize = 24,
            Font = Enum.Font.GothamBold,
        }, LoadingFrame)

        Create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 18),
            Position = UDim2.new(0, 0, 0, 174),
            Text = LoadingSubtitle,
            TextColor3 = Colors.Accent,
            TextSize = 13,
            Font = Enum.Font.Gotham,
        }, LoadingFrame)

        local barBg = Create("Frame", {
            Size = UDim2.new(0.75, 0, 0, 6),
            Position = UDim2.new(0.125, 0, 0, 208),
            BackgroundColor3 = Colors.ToggleOff,
            BorderSizePixel = 0,
        }, LoadingFrame)
        Corner(UDim.new(1, 0), barBg)

        local barFill = Create("Frame", {
            Size = UDim2.new(0, 0, 1, 0),
            BackgroundColor3 = Colors.Accent,
            BorderSizePixel = 0,
        }, barBg)
        Corner(UDim.new(1, 0), barFill)

        local pctLbl = Create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 16),
            Position = UDim2.new(0, 0, 0, 224),
            Text = "0%",
            TextColor3 = Colors.TextMuted,
            TextSize = 11,
            Font = Enum.Font.Gotham,
        }, LoadingFrame)

        task.spawn(function()
            local steps = { 0.15, 0.35, 0.55, 0.75, 0.95, 1.0 }
            for _, p in ipairs(steps) do
                if not LoadingFrame.Parent then return end
                Tween(barFill, { Size = UDim2.new(p, 0, 1, 0) }, 0.2)
                pctLbl.Text = math.floor(p * 100) .. "%"
                task.wait(0.18)
            end
        end)
    end

    -- --------------------------------------------------
    -- Main Window
    -- --------------------------------------------------
    local Window = Create("Frame", {
        Name = "MainWindow",
        Size = UDim2.new(0, Width, 0, Height),
        Position = UDim2.new(0.5, -Width/2, 0.5, -Height/2),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        Active = true,
        Visible = not LoadingEnabled,
    }, ScreenGui)
    Corner(UDim.new(0, 14), Window)
    Stroke(Colors.Border, 1.5, 0, Window)

    Create("Frame", {
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 12, 1, 12),
        Position = UDim2.new(0, -6, 0, -6),
        ZIndex = -1,
    }, Window)

    -- TopBar
    local TopBar = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 46),
        BackgroundColor3 = Colors.TopBar,
        BorderSizePixel = 0,
    }, Window)
    Corner(UDim.new(0, 14), TopBar)

    local logoHolder = Create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(0, 12, 0.5, -14),
    }, TopBar)
    LoadIcon(AccentIcon, UDim2.new(1, 0, 1, 0), Color3.fromRGB(255,255,255), logoHolder)

    Create("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -350, 1, 0),
        Position = UDim2.new(0, 48, 0, 0),
        Text = WindowName,
        TextColor3 = Colors.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, TopBar)

    -- Search
    local searchWrap = Create("Frame", {
        Size = UDim2.new(0, 200, 0, 28),
        Position = UDim2.new(1, -310, 0.5, -14),
        BackgroundColor3 = Colors.Input,
        BorderSizePixel = 0,
    }, TopBar)
    Corner(UDim.new(0, 8), searchWrap)
    local searchStroke = Stroke(Colors.Separator, 1, 0, searchWrap)

    local searchBox = Create("TextBox", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -16, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        Text = "",
        PlaceholderText = "Ara...",
        PlaceholderColor3 = Colors.TextDark,
        TextColor3 = Colors.Text,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
    }, searchWrap)

    searchBox.Focused:Connect(function()
        Tween(searchStroke, { Color = Colors.Accent }, 0.15)
    end)
    searchBox.FocusLost:Connect(function()
        Tween(searchStroke, { Color = Colors.Separator }, 0.15)
    end)

    -- Minimize button
    local MinBtn = Create("TextButton", {
        Size = UDim2.new(0, 30, 0, 28),
        Position = UDim2.new(1, -100, 0.5, -14),
        BackgroundColor3 = Colors.Warning,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
    }, TopBar)
    Corner(UDim.new(0, 7), MinBtn)
    Create("Frame", {
        Size = UDim2.new(0, 12, 0, 2),
        Position = UDim2.new(0.5, -6, 0.5, -1),
        BackgroundColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 0,
    }, MinBtn)

    -- Close button
    local CloseBtn = Create("TextButton", {
        Size = UDim2.new(0, 30, 0, 28),
        Position = UDim2.new(1, -65, 0.5, -14),
        BackgroundColor3 = Colors.Error,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
    }, TopBar)
    Corner(UDim.new(0, 7), CloseBtn)
    for _, rot in ipairs({ 45, -45 }) do
        Create("Frame", {
            Size = UDim2.new(0, 12, 0, 2),
            Position = UDim2.new(0.5, -6, 0.5, -1),
            BackgroundColor3 = Color3.fromRGB(255,255,255),
            BorderSizePixel = 0,
            Rotation = rot,
        }, CloseBtn)
    end

    MinBtn.MouseEnter:Connect(function() Tween(MinBtn, { BackgroundColor3 = Color3.fromRGB(245,175,20) }, 0.1) end)
    MinBtn.MouseLeave:Connect(function() Tween(MinBtn, { BackgroundColor3 = Colors.Warning }, 0.1) end)
    CloseBtn.MouseEnter:Connect(function() Tween(CloseBtn, { BackgroundColor3 = Color3.fromRGB(245,80,80) }, 0.1) end)
    CloseBtn.MouseLeave:Connect(function() Tween(CloseBtn, { BackgroundColor3 = Colors.Error }, 0.1) end)

    -- Sidebar
    local Sidebar = Create("Frame", {
        Size = UDim2.new(0, SidebarWidth, 1, -46),
        Position = UDim2.new(0, 0, 0, 46),
        BackgroundColor3 = Colors.Sidebar,
        BorderSizePixel = 0,
    }, Window)

    local logoPanel = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 130),
        BackgroundTransparency = 1,
    }, Sidebar)

    local bigLogoWrap = Create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 80, 0, 80),
        Position = UDim2.new(0.5, -40, 0, 16),
    }, logoPanel)
    local bigLogoRing = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
    }, bigLogoWrap)
    Corner(UDim.new(1, 0), bigLogoRing)
    local bigImg = LoadIcon(AccentIcon, UDim2.new(0.75, 0, 0.75, 0), Color3.fromRGB(255,255,255), bigLogoRing)
    if bigImg then
        bigImg.Position = UDim2.new(0.5, 0, 0.5, 0)
        bigImg.AnchorPoint = Vector2.new(0.5, 0.5)
    end

    Create("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 0, 0, 100),
        Text = WindowName,
        TextColor3 = Colors.Text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
    }, logoPanel)

    Create("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 0, 116),
        Text = "v" .. SV._VERSION,
        TextColor3 = Colors.Accent,
        TextSize = 10,
        Font = Enum.Font.Gotham,
    }, logoPanel)

    local TabList = Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -132),
        Position = UDim2.new(0, 0, 0, 132),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Colors.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, Sidebar)
    ListLayout(TabList, 4)
    Padding(TabList, 4, 8, 8, 8)

    -- Content Area
    local ContentArea = Create("Frame", {
        Size = UDim2.new(1, -SidebarWidth, 1, -46),
        Position = UDim2.new(0, SidebarWidth, 0, 46),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
    }, Window)

    -- Watermark
    if ShowWatermark then
        local wm = Create("Frame", {
            Size = UDim2.new(0, 300, 0, 30),
            Position = UDim2.new(0, 16, 0, 16),
            BackgroundColor3 = Colors.Background,
            BackgroundTransparency = 0.15,
            BorderSizePixel = 0,
            ZIndex = 999,
        }, ScreenGui)
        Corner(UDim.new(0, 8), wm)
        Stroke(Colors.Accent, 1, 0.4, wm)

        local wmLogo = Create("Frame", {
            Size = UDim2.new(0, 22, 0, 22),
            Position = UDim2.new(0, 4, 0.5, -11),
            BackgroundColor3 = Colors.Accent,
            BorderSizePixel = 0,
        }, wm)
        Corner(UDim.new(1, 0), wmLogo)
        local wi = LoadIcon(AccentIcon, UDim2.new(0.75, 0, 0.75, 0), Color3.fromRGB(255,255,255), wmLogo)
        if wi then
            wi.Position = UDim2.new(0.5, 0, 0.5, 0)
            wi.AnchorPoint = Vector2.new(0.5, 0.5)
        end

        local wmText = Create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -38, 1, 0),
            Position = UDim2.new(0, 32, 0, 0),
            Text = "ScriptVault | -- FPS | -- ms | -- MB",
            TextColor3 = Colors.Text,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, wm)

        task.spawn(function()
            local frames, t0 = 0, tick()
            RunService.RenderStepped:Connect(function()
                frames = frames + 1
                if tick() - t0 >= 1 then
                    pcall(function()
                        wmText.Text = string.format("ScriptVault | %d FPS | %d ms | %d MB", frames, GetPing(), GetMemory())
                    end)
                    frames, t0 = 0, tick()
                end
            end)
        end)
    end

    -- --------------------------------------------------
    -- Dragging
    -- --------------------------------------------------
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
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
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
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

    -- --------------------------------------------------
    -- Resizing
    -- --------------------------------------------------
    if Resizable then
        local handle = Create("TextButton", {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -20, 1, -20),
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = 10,
        }, Window)
        for i = 1, 3 do
            local dot = Create("Frame", {
                Size = UDim2.new(0, 3, 0, 3),
                Position = UDim2.new(1, -4 - (i - 1) * 4, 1, -4),
                BackgroundColor3 = Colors.TextMuted,
                BackgroundTransparency = 0.3,
                BorderSizePixel = 0,
            }, handle)
            Corner(UDim.new(1, 0), dot)
        end

        local rDrag, rStart, rSize = false, nil, nil
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                rDrag = true
                rStart = input.Position
                rSize = Window.AbsoluteSize
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then rDrag = false end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if rDrag and (input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - rStart
                Window.Size = UDim2.new(
                    0, math.max(MinWidth, rSize.X + delta.X),
                    0, math.max(MinHeight, rSize.Y + delta.Y)
                )
            end
        end)
    end

    -- --------------------------------------------------
    -- Minimize / Restore
    -- --------------------------------------------------
    local isMinimized = false

    local MinIcon = Create("TextButton", {
        Size = UDim2.new(0, 64, 0, 64),
        Position = UDim2.new(1, -84, 0.5, -32),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
        Text = "",
        Visible = false,
        ZIndex = 500,
    }, ScreenGui)
    Corner(UDim.new(1, 0), MinIcon)
    Stroke(Colors.AccentHover, 2, 0, MinIcon)
    local mi = LoadIcon(AccentIcon, UDim2.new(0.7, 0, 0.7, 0), Color3.fromRGB(255,255,255), MinIcon)
    if mi then
        mi.Position = UDim2.new(0.5, 0, 0.5, 0)
        mi.AnchorPoint = Vector2.new(0.5, 0.5)
    end

    local function Minimize()
        if isMinimized then return end
        isMinimized = true
        Tween(Window, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(1, -84, 0.5, -32) }, 0.25)
        task.wait(0.25)
        Window.Visible = false
        MinIcon.Visible = true
        MinIcon.Size = UDim2.new(0, 0, 0, 0)
        Tween(MinIcon, { Size = UDim2.new(0, 64, 0, 64) }, 0.35, Enum.EasingStyle.Back)
    end

    local function Restore()
        if not isMinimized then return end
        isMinimized = false
        Tween(MinIcon, { Size = UDim2.new(0, 0, 0, 0) }, 0.2)
        task.wait(0.2)
        MinIcon.Visible = false
        Window.Visible = true
        Window.Size = UDim2.new(0, 0, 0, 0)
        Window.Position = UDim2.new(1, -84, 0.5, -32)
        Tween(Window, {
            Size = UDim2.new(0, Width, 0, Height),
            Position = UDim2.new(0.5, -Width/2, 0.5, -Height/2),
        }, 0.35, Enum.EasingStyle.Back)
    end

    MinBtn.MouseButton1Click:Connect(Minimize)
    MinIcon.MouseButton1Click:Connect(Restore)

    local function DestroyWindow()
        Tween(Window, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0) }, 0.25)
        task.wait(0.3)
        if ScreenGui.Parent then ScreenGui:Destroy() end
    end
    CloseBtn.MouseButton1Click:Connect(DestroyWindow)

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == ToggleKeybind then
            if isMinimized then Restore() else Minimize() end
        end
    end)

    -- --------------------------------------------------
    -- Tab System
    -- --------------------------------------------------
    local Tabs = {}
    local TabContents = {}
    local CurrentTabButton = nil
    local CurrentTabName = nil

    local function CreateTab(name, iconId, tabOptions)
        tabOptions = tabOptions or {}
        local order = tabOptions.Order or (#Tabs + 1)

        local TabBtn = Create("TextButton", {
            Size = UDim2.new(1, 0, 0, 42),
            BackgroundColor3 = Colors.Element,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = order,
        }, TabList)
        Corner(UDim.new(0, 8), TabBtn)

        local Indicator = Create("Frame", {
            Size = UDim2.new(0, 3, 0, 24),
            Position = UDim2.new(0, 0, 0.5, -12),
            BackgroundColor3 = Colors.Accent,
            BorderSizePixel = 0,
            Visible = false,
        }, TabBtn)
        Corner(UDim.new(0, 3), Indicator)

        local resolvedIcon = iconId or SV.Icons.Home
        local TabIcon = LoadIcon(resolvedIcon, UDim2.new(0, 20, 0, 20), Colors.TextMuted, TabBtn)
        if TabIcon then TabIcon.Position = UDim2.new(0, 14, 0.5, -10) end

        local TabLabel = Create("TextLabel", {
            Size = UDim2.new(1, -50, 1, 0),
            Position = UDim2.new(0, 44, 0, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = Colors.TextMuted,
            TextSize = 13,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, TabBtn)

        if tabOptions.Badge then
            local badge = Create("Frame", {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(1, -26, 0.5, -9),
                BackgroundColor3 = Colors.Accent,
                BorderSizePixel = 0,
            }, TabBtn)
            Corner(UDim.new(1, 0), badge)
            Create("TextLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = tostring(tabOptions.Badge),
                TextColor3 = Color3.fromRGB(255,255,255),
                TextSize = 10,
                Font = Enum.Font.GothamBold,
            }, badge)
        end

        local Content = Create("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Colors.Accent,
            BorderSizePixel = 0,
        }, ContentArea)
        ListLayout(Content, 10)
        Padding(Content, 16, 16, 16, 16)

        local function Activate()
            if CurrentTabButton and CurrentTabButton ~= TabBtn then
                Tween(CurrentTabButton, { BackgroundColor3 = Colors.Element }, 0.15)
                local oldInd = CurrentTabButton:FindFirstChild("Indicator")
                if oldInd then oldInd.Visible = false end
                local oldIcon = nil
                for _, c in ipairs(CurrentTabButton:GetChildren()) do
                    if c:IsA("ImageLabel") then oldIcon = c break end
                end
                if oldIcon then Tween(oldIcon, { ImageColor3 = Colors.TextMuted }, 0.15) end
                for _, c in ipairs(CurrentTabButton:GetChildren()) do
                    if c:IsA("TextLabel") then
                        Tween(c, { TextColor3 = Colors.TextMuted }, 0.15)
                        break
                    end
                end
            end

            CurrentTabButton = TabBtn
            CurrentTabName = name
            Tween(TabBtn, { BackgroundColor3 = Colors.ElementHover }, 0.15)
            Indicator.Visible = true
            if TabIcon then Tween(TabIcon, { ImageColor3 = Colors.Text }, 0.15) end
            Tween(TabLabel, { TextColor3 = Colors.Text }, 0.15)

            for tabName, tabContent in pairs(TabContents) do
                tabContent.Visible = (tabName == name)
            end
        end

        TabBtn.MouseButton1Click:Connect(Activate)
        TabBtn.MouseEnter:Connect(function()
            if CurrentTabButton ~= TabBtn then
                Tween(TabBtn, { BackgroundColor3 = Colors.ElementHover }, 0.12)
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if CurrentTabButton ~= TabBtn then
                Tween(TabBtn, { BackgroundColor3 = Colors.Element }, 0.12)
            end
        end)

        table.insert(Tabs, { name = name, button = TabBtn, content = Content })
        TabContents[name] = Content
        if not CurrentTabButton then Activate() end

        -- Element ID counter
        local ElementID = 0
        local function NextOrder()
            ElementID = ElementID + 1
            return ElementID
        end

        local Tab = {}

        -- ====================================
        -- SECTION
        -- ====================================
        function Tab:CreateSection(title)
            local c = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 32),
                BackgroundTransparency = 1,
                LayoutOrder = NextOrder(),
            }, Content)
            Create("Frame", {
                Size = UDim2.new(0, 3, 0, 16),
                Position = UDim2.new(0, 0, 0.5, -8),
                BackgroundColor3 = Colors.Accent,
                BorderSizePixel = 0,
            }, c)
            Create("TextLabel", {
                Size = UDim2.new(1, -10, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = string.upper(tostring(title)),
                TextColor3 = Colors.TextMuted,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, c)
            return c
        end

        -- ====================================
        -- DIVIDER
        -- ====================================
        function Tab:CreateDivider()
            return Create("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = Colors.Separator,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            }, Content)
        end

        -- ====================================
        -- LABEL
        -- ====================================
        function Tab:CreateLabel(text)
            return Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 26),
                BackgroundTransparency = 1,
                Text = tostring(text),
                TextColor3 = Colors.Text,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = NextOrder(),
            }, Content)
        end

        -- ====================================
        -- PARAGRAPH
        -- ====================================
        function Tab:CreateParagraph(opts)
            opts = opts or {}
            local c = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 80),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            }, Content)
            Corner(UDim.new(0, 8), c)
            Stroke(Colors.Separator, 1, 0, c)

            local icon = LoadIcon(SV.Icons.Info, UDim2.new(0, 18, 0, 18), Colors.Accent, c)
            if icon then icon.Position = UDim2.new(0, 12, 0, 12) end

            Create("TextLabel", {
                Size = UDim2.new(1, -50, 0, 22),
                Position = UDim2.new(0, 38, 0, 10),
                BackgroundTransparency = 1,
                Text = opts.Title or "Info",
                TextColor3 = Colors.Text,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, c)

            local body = Create("TextLabel", {
                Size = UDim2.new(1, -24, 0, 30),
                Position = UDim2.new(0, 12, 0, 38),
                BackgroundTransparency = 1,
                Text = opts.Content or "",
                TextColor3 = Colors.TextMuted,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
            }, c)

            task.defer(function()
                local b = body.TextBounds.Y
                c.Size = UDim2.new(1, 0, 0, 50 + b)
                body.Size = UDim2.new(1, -24, 0, b)
            end)

            return c
        end

        -- ====================================
        -- TOGGLE
        -- ====================================
        function Tab:CreateToggle(opts)
            opts = opts or {}
            local hasDesc = opts.Description ~= nil

            local c = Create("Frame", {
                Size = UDim2.new(1, 0, 0, hasDesc and 58 or 44),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            }, Content)
            Corner(UDim.new(0, 8), c)

            local btn = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
            }, c)

            Create("TextLabel", {
                Size = UDim2.new(1, -75, 0, 20),
                Position = UDim2.new(0, 14, 0, hasDesc and 10 or 12),
                BackgroundTransparency = 1,
                Text = opts.Name or "Toggle",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, c)

            if hasDesc then
                Create("TextLabel", {
                    Size = UDim2.new(1, -75, 0, 16),
                    Position = UDim2.new(0, 14, 0, 30),
                    BackgroundTransparency = 1,
                    Text = opts.Description,
                    TextColor3 = Colors.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, c)
            end

            local value = opts.CurrentValue or false

            local track = Create("Frame", {
                Size = UDim2.new(0, 44, 0, 24),
                Position = UDim2.new(1, -58, 0.5, -12),
                BackgroundColor3 = value and Colors.ToggleOn or Colors.ToggleOff,
                BorderSizePixel = 0,
            }, c)
            Corner(UDim.new(1, 0), track)

            local knob = Create("Frame", {
                Size = UDim2.new(0, 18, 0, 18),
                Position = value and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
                BackgroundColor3 = Color3.fromRGB(255,255,255),
                BorderSizePixel = 0,
            }, track)
            Corner(UDim.new(1, 0), knob)

            local function setValue(v)
                value = v and true or false
                Tween(knob, { Position = value and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9) }, 0.18)
                Tween(track, { BackgroundColor3 = value and Colors.ToggleOn or Colors.ToggleOff }, 0.18)
                if opts.Callback then Safe(opts.Callback, value) end
            end

            btn.MouseButton1Click:Connect(function() setValue(not value) end)
            c.MouseEnter:Connect(function() Tween(c, { BackgroundColor3 = Colors.ElementHover }, 0.12) end)
            c.MouseLeave:Connect(function() Tween(c, { BackgroundColor3 = Colors.Element }, 0.12) end)

            if opts.Tooltip then AttachTooltip(c, opts.Tooltip, Colors, ScreenGui) end

            return {
                Container = c,
                SetValue = setValue,
                GetValue = function() return value end,
                Set = setValue,
            }
        end

        -- ====================================
        -- BUTTON
        -- ====================================
        function Tab:CreateButton(opts)
            opts = opts or {}
            local variant = opts.Variant or "Primary"
            local variantColors = {
                Primary = { base = Colors.Accent, hover = Colors.AccentHover },
                Success = { base = Colors.Success, hover = Color3.fromRGB(0, 220, 130) },
                Warning = { base = Colors.Warning, hover = Color3.fromRGB(245, 180, 20) },
                Error = { base = Colors.Error, hover = Color3.fromRGB(245, 80, 80) },
                Ghost = { base = Colors.Element, hover = Colors.ElementHover },
            }
            local vc = variantColors[variant] or variantColors.Primary

            local btn = Create("TextButton", {
                Size = UDim2.new(1, 0, 0, 42),
                BackgroundColor3 = vc.base,
                BorderSizePixel = 0,
                Text = opts.Name or "Button",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                AutoButtonColor = false,
                LayoutOrder = NextOrder(),
            }, Content)
            Corner(UDim.new(0, 8), btn)

            btn.MouseEnter:Connect(function()
                Tween(btn, { BackgroundColor3 = vc.hover }, 0.12)
            end)
            btn.MouseLeave:Connect(function()
                Tween(btn, { BackgroundColor3 = vc.base }, 0.12)
            end)
            btn.MouseButton1Click:Connect(function()
                if opts.Callback then Safe(opts.Callback) end
            end)

            if opts.Tooltip then AttachTooltip(btn, opts.Tooltip, Colors, ScreenGui) end

            return btn
        end

        -- ====================================
        -- SLIDER
        -- ====================================
        function Tab:CreateSlider(opts)
            opts = opts or {}
            local range = opts.Range or { 0, 100 }
            local mn, mx = range[1] or 0, range[2] or 100
            local step = opts.Increment or 1
            local value = math.clamp(opts.CurrentValue or mn, mn, mx)
            local suffix = opts.Suffix or ""

            local c = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 60),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            }, Content)
            Corner(UDim.new(0, 8), c)

            Create("TextLabel", {
                Size = UDim2.new(1, -80, 0, 20),
                Position = UDim2.new(0, 14, 0, 8),
                BackgroundTransparency = 1,
                Text = opts.Name or "Slider",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, c)

            local valueLabel = Create("TextLabel", {
                Size = UDim2.new(0, 60, 0, 20),
                Position = UDim2.new(1, -70, 0, 8),
                BackgroundTransparency = 1,
                Text = tostring(value) .. suffix,
                TextColor3 = Colors.Accent,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, c)

            local track = Create("Frame", {
                Size = UDim2.new(1, -28, 0, 8),
                Position = UDim2.new(0, 14, 1, -22),
                BackgroundColor3 = Colors.Slider,
                BorderSizePixel = 0,
            }, c)
            Corner(UDim.new(1, 0), track)

            local fill = Create("Frame", {
                Size = UDim2.new((value - mn) / (mx - mn), 0, 1, 0),
                BackgroundColor3 = Colors.SliderFill,
                BorderSizePixel = 0,
            }, track)
            Corner(UDim.new(1, 0), fill)

            local knob = Create("Frame", {
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new((value - mn) / (mx - mn), -8, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(255,255,255),
                BorderSizePixel = 0,
                ZIndex = 5,
            }, track)
            Corner(UDim.new(1, 0), knob)

            local dragging = false

            local function update(input)
                local relX = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                local v = mn + (mx - mn) * relX
                v = math.floor(v / step + 0.5) * step
                v = math.clamp(v, mn, mx)
                local pos = (v - mn) / (mx - mn)
                knob.Position = UDim2.new(pos, -8, 0.5, -8)
                fill.Size = UDim2.new(pos, 0, 1, 0)
                valueLabel.Text = tostring(v) .. suffix
                value = v
                if opts.Callback then Safe(opts.Callback, v) end
            end

            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    update(input)
                end
            end)

            local inputChangedConn = UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch) then
                    update(input)
                end
            end)

            local inputEndedConn = UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            c.Destroying:Connect(function()
                inputChangedConn:Disconnect()
                inputEndedConn:Disconnect()
            end)

            return {
                Container = c,
                SetValue = function(v)
                    v = math.clamp(v, mn, mx)
                    local pos = (v - mn) / (mx - mn)
                    knob.Position = UDim2.new(pos, -8, 0.5, -8)
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    valueLabel.Text = tostring(v) .. suffix
                    value = v
                    if opts.Callback then Safe(opts.Callback, v) end
                end,
                GetValue = function() return value end,
            }
        end

        -- ====================================
        -- DROPDOWN
        -- ====================================
        function Tab:CreateDropdown(opts)
            opts = opts or {}
            local options = opts.Options or {}
            local multiple = opts.MultipleOptions or false
            local selectedSet = {}
            local current = opts.CurrentOption or (multiple and {} or (options[1] or "None"))

            if type(current) == "string" then
                selectedSet[current] = true
            elseif type(current) == "table" then
                for _, v in ipairs(current) do selectedSet[v] = true end
            end

            local c = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 64),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
                ClipsDescendants = false,
            }, Content)
            Corner(UDim.new(0, 8), c)

            Create("TextLabel", {
                Size = UDim2.new(1, -30, 0, 18),
                Position = UDim2.new(0, 14, 0, 6),
                BackgroundTransparency = 1,
                Text = opts.Name or "Dropdown",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, c)

            local selectBtn = Create("TextButton", {
                Size = UDim2.new(1, -28, 0, 32),
                Position = UDim2.new(0, 14, 0, 26),
                BackgroundColor3 = Colors.Input,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
            }, c)
            Corner(UDim.new(0, 6), selectBtn)

            local textLabel = Create("TextLabel", {
                Size = UDim2.new(1, -40, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = "",
                TextColor3 = Colors.Text,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, selectBtn)

            Create("TextLabel", {
                Size = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -24, 0, 0),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = Colors.TextMuted,
                TextSize = 10,
                Font = Enum.Font.GothamBold,
            }, selectBtn)

            local function getDisplayText()
                if multiple then
                    local list = {}
                    for k in pairs(selectedSet) do table.insert(list, k) end
                    if #list == 0 then return "None"
                    elseif #list <= 2 then return table.concat(list, ", ")
                    else return list[1] .. " +" .. (#list - 1) end
                else
                    return tostring(current)
                end
            end

            textLabel.Text = getDisplayText()

            local listFrame = Create("ScrollingFrame", {
                Size = UDim2.new(0, 200, 0, 100),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = Colors.Input,
                BorderSizePixel = 0,
                Visible = false,
                ZIndex = 30000,
                ScrollBarThickness = 3,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ClipsDescendants = true,
            }, ScreenGui)
            Corner(UDim.new(0, 6), listFrame)
            Stroke(Colors.Border, 1, 0.3, listFrame)
            ListLayout(listFrame, 2)
            Padding(listFrame, 4, 4, 4, 4)

            local optionButtons = {}
            for _, optText in ipairs(options) do
                local ob = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = Colors.Input,
                    BorderSizePixel = 0,
                    Text = tostring(optText),
                    TextColor3 = Colors.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    AutoButtonColor = false,
                    ZIndex = 30001,
                }, listFrame)
                Corner(UDim.new(0, 5), ob)
                Padding(ob, 0, 0, 10, 10)

                ob.MouseEnter:Connect(function()
                    Tween(ob, { BackgroundColor3 = Colors.ElementHover }, 0.1)
                end)
                ob.MouseLeave:Connect(function()
                    Tween(ob, { BackgroundColor3 = Colors.Input }, 0.1)
                end)

                ob.MouseButton1Click:Connect(function()
                    if multiple then
                        if selectedSet[optText] then
                            selectedSet[optText] = nil
                        else
                            selectedSet[optText] = true
                        end
                        textLabel.Text = getDisplayText()
                        local list = {}
                        for k in pairs(selectedSet) do table.insert(list, k) end
                        if opts.Callback then Safe(opts.Callback, list) end
                    else
                        current = optText
                        selectedSet = { [optText] = true }
                        textLabel.Text = getDisplayText()
                        listFrame.Visible = false
                        if opts.Callback then Safe(opts.Callback, optText) end
                    end
                end)

                table.insert(optionButtons, ob)
            end

            selectBtn.MouseButton1Click:Connect(function()
                if listFrame.Visible then
                    listFrame.Visible = false
                else
                    local h = math.min(#options * 32 + 8, 220)
                    listFrame.Size = UDim2.new(0, selectBtn.AbsoluteSize.X, 0, h)
                    listFrame.Position = UDim2.new(
                        0,
                        selectBtn.AbsolutePosition.X,
                        0,
                        selectBtn.AbsolutePosition.Y + selectBtn.AbsoluteSize.Y + 2
                    )
                    listFrame.Visible = true
                end
            end)

            local outsideConn = UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    if listFrame.Visible then
                        local mouse = UserInputService:GetMouseLocation()
                        local listPos = listFrame.AbsolutePosition
                        local listSize = listFrame.AbsoluteSize
                        if not (mouse.X >= listPos.X and mouse.X <= listPos.X + listSize.X
                            and mouse.Y >= listPos.Y and mouse.Y <= listPos.Y + listSize.Y) then
                            listFrame.Visible = false
                        end
                    end
                end
            end)

            c.Destroying:Connect(function()
                outsideConn:Disconnect()
                if listFrame.Parent then listFrame:Destroy() end
            end)

            return {
                Container = c,
                SetValue = function(v)
                    if multiple and type(v) == "table" then
                        selectedSet = {}
                        for _, k in ipairs(v) do selectedSet[k] = true end
                    else
                        current = v
                        selectedSet = { [v] = true }
                    end
                    textLabel.Text = getDisplayText()
                end,
                GetValue = function()
                    if multiple then
                        local list = {}
                        for k in pairs(selectedSet) do table.insert(list, k) end
                        return list
                    end
                    return current
                end,
            }
        end

        -- ====================================
        -- INPUT
        -- ====================================
        function Tab:CreateInput(opts)
            opts = opts or {}
            local c = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 64),
                BackgroundColor3 = Colors.Element,
                BorderSizePixel = 0,
                LayoutOrder = NextOrder(),
            }, Content)
            Corner(UDim.new(0, 8), c)

            Create("TextLabel", {
                Size = UDim2.new(1, -30, 0, 18),
                Position = UDim2.new(0, 14, 0, 6),
                BackgroundTransparency = 1,
                Text = opts.Name or "Input",
                TextColor3 = Colors.Text,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, c)

            local inputBox = Create("TextBox", {
                Size = UDim2.new(1, -28, 0, 32),
                Position = UDim2.new(0, 14, 0, 26),
                BackgroundColor3 = Colors.Input,
                BorderSizePixel = 0,
                Text = opts.Default or "",
                TextColor3 = Colors.Text,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                PlaceholderText = opts.Placeholder or "Yaz...",
                PlaceholderColor3 = Colors.TextDark,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = opts.ClearOnFocus or false,
            }, c)
            Corner(UDim.new(0, 6), inputBox)
            Padding(inputBox, 0, 0, 10, 10)
            local inputStroke = Stroke(Colors.Separator, 1, 0, inputBox)

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
                Container
