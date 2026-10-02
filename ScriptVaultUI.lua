--[[
========================================================
  ScriptVault UI Library v7.0.0
  AAA Blue Edition
  Fixed visual language • Animated • Responsive
  Logo: rbxassetid://93348253170824
========================================================
]]

local SV = {}
SV.__index = SV
SV._VERSION = "7.0.0"
SV._BUILD = "20261002"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer

local BLUE = {
    Background = Color3.fromRGB(4, 8, 20),
    Sidebar = Color3.fromRGB(7, 14, 32),
    TopBar = Color3.fromRGB(8, 17, 39),
    Panel = Color3.fromRGB(10, 21, 45),
    Element = Color3.fromRGB(13, 28, 58),
    ElementHover = Color3.fromRGB(18, 42, 82),
    Accent = Color3.fromRGB(38, 145, 255),
    AccentBright = Color3.fromRGB(86, 181, 255),
    AccentDeep = Color3.fromRGB(18, 93, 190),
    Text = Color3.fromRGB(242, 248, 255),
    TextMuted = Color3.fromRGB(137, 169, 214),
    TextDark = Color3.fromRGB(83, 111, 153),
    Success = Color3.fromRGB(55, 214, 137),
    Warning = Color3.fromRGB(246, 181, 58),
    Error = Color3.fromRGB(238, 77, 96),
    Border = Color3.fromRGB(38, 100, 175),
    Separator = Color3.fromRGB(24, 53, 91),
    Input = Color3.fromRGB(8, 19, 42),
    Track = Color3.fromRGB(9, 20, 42),
    Overlay = Color3.fromRGB(0, 4, 12),
}

SV.Colors = BLUE
SV.Icons = {
    Logo = "rbxassetid://93348253170824",
    Home = "rbxassetid://6031075931",
    Player = "rbxassetid://6031225389",
    Stats = "rbxassetid://6031279000",
    Combat = "rbxassetid://6031094678",
    Tools = "rbxassetid://6035067834",
    Misc = "rbxassetid://6031154871",
    Shop = "rbxassetid://6034280643",
    Visual = "rbxassetid://6031302945",
    Key = "rbxassetid://6031265976",
    Lock = "rbxassetid://6031216977",
    Script = "rbxassetid://6034277377",
    Info = "rbxassetid://17829948066",
    Settings = "rbxassetid://9405931578",
    Teleport = "rbxassetid://16538185173",
    Star = "rbxassetid://138880939782808",
    Check = "rbxassetid://122032243989747",
}

local function safe(fn, ...)
    if type(fn) ~= "function" then return end
    local ok, err = pcall(fn, ...)
    if not ok then warn("[ScriptVault] " .. tostring(err)) end
end

local function create(className, props, parent)
    local object = Instance.new(className)
    for key, value in pairs(props or {}) do
        pcall(function() object[key] = value end)
    end
    object.Parent = parent
    return object
end

local function corner(radius, parent)
    return create("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function addStroke(parent, color, thickness, transparency)
    return create("UIStroke", {
        Color = color or BLUE.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, parent)
end

local function addPadding(parent, top, bottom, left, right)
    return create("UIPadding", {
        PaddingTop = UDim.new(0, top),
        PaddingBottom = UDim.new(0, bottom),
        PaddingLeft = UDim.new(0, left),
        PaddingRight = UDim.new(0, right),
    }, parent)
end

local function addList(parent, gap, horizontal)
    return create("UIListLayout", {
        Padding = UDim.new(0, gap or 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = horizontal and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical,
    }, parent)
end

local function animate(object, properties, duration, style)
    if not object or not object.Parent then return end
    local info = TweenInfo.new(
        duration or 0.18,
        style or Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )
    TweenService:Create(object, info, properties):Play()
end

local function icon(asset, size, color, parent)
    if not asset then return nil end
    return create("ImageLabel", {
        BackgroundTransparency = 1,
        Size = size or UDim2.fromOffset(20, 20),
        Image = asset,
        ImageColor3 = color or Color3.new(1, 1, 1),
        ScaleType = Enum.ScaleType.Fit,
    }, parent)
end

local function getGuiParent()
    local ok, hui = pcall(function()
        return gethui and gethui()
    end)
    if ok and hui then return hui end
    return CoreGui
end

local function getPing()
    local ok, value = pcall(function()
        return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    return ok and value or 0
end

local function getMemory()
    local ok, value = pcall(function()
        return math.floor(Stats:GetTotalMemoryUsageMb())
    end)
    return ok and value or 0
end

local function isTouch()
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

local function formatNumber(number)
    number = tonumber(number) or 0
    if number >= 1000000 then return string.format("%.1fM", number / 1000000) end
    if number >= 1000 then return string.format("%.1fK", number / 1000) end
    return tostring(math.floor(number))
end

local function ripple(button, position)
    if not button or not button.Parent then return end
    local holder = create("Frame", {
        Name = "Ripple",
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 0.78,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromOffset(position.X - button.AbsolutePosition.X, position.Y - button.AbsolutePosition.Y),
        Size = UDim2.fromOffset(0, 0),
        ZIndex = button.ZIndex + 5,
    }, button)
    corner(999, holder)
    local diameter = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 1.8
    animate(holder, {
        Size = UDim2.fromOffset(diameter, diameter),
        BackgroundTransparency = 1,
    }, 0.42, Enum.EasingStyle.Quad)
    task.delay(0.45, function()
        if holder.Parent then holder:Destroy() end
    end)
end

function SV:CreateWindow(options)
    options = options or {}

    local width = options.Width or 940
    local height = options.Height or 600
    local minWidth = options.MinWidth or 650
    local minHeight = options.MinHeight or 430
    local sidebarWidth = options.SidebarWidth or 198
    local windowName = options.Name or "ScriptVault"
    local toggleKey = options.ToggleKeybind or Enum.KeyCode.RightShift
    local reducedMotion = options.ReducedMotion == true

    local connections = {}
    local tabs = {}
    local currentTab
    local destroyed = false
    local minimized = false
    local sidebarCollapsed = false
    local notificationHolder
    local tooltipFrame

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local function disconnectAll()
        for _, connection in ipairs(connections) do
            pcall(function() connection:Disconnect() end)
        end
        table.clear(connections)
    end

    local screen = create("ScreenGui", {
        Name = "ScriptVaultUI",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
    }, getGuiParent())

    local shadow = create("Frame", {
        Size = UDim2.fromOffset(width + 34, height + 34),
        Position = UDim2.new(0.5, -width / 2 - 17, 0.5, -height / 2 - 5),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.55,
        BorderSizePixel = 0,
        ZIndex = 0,
    }, screen)
    corner(24, shadow)

    local aura = create("Frame", {
        Size = UDim2.fromOffset(width + 18, height + 18),
        Position = UDim2.new(0.5, -width / 2 - 9, 0.5, -height / 2 - 9),
        BackgroundColor3 = BLUE.Accent,
        BackgroundTransparency = 0.94,
        BorderSizePixel = 0,
        ZIndex = 1,
    }, screen)
    corner(24, aura)

    local window = create("Frame", {
        Size = UDim2.fromOffset(width, height),
        Position = UDim2.new(0.5, -width / 2, 0.5, -height / 2),
        BackgroundColor3 = BLUE.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 10,
    }, screen)
    corner(20, window)

    local outerGlow = addStroke(window, BLUE.Accent, 1, 0.35)
    local innerStroke = addStroke(window, BLUE.AccentBright, 1, 0.78)

    local top = create("Frame", {
        Size = UDim2.new(1, 0, 0, 66),
        BackgroundColor3 = BLUE.TopBar,
        BorderSizePixel = 0,
        ZIndex = 11,
    }, window)

    local topGradient = create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, BLUE.TopBar),
            ColorSequenceKeypoint.new(0.5, BLUE.Panel),
            ColorSequenceKeypoint.new(1, BLUE.TopBar),
        }),
        Rotation = 0,
    }, top)

    local topLine = create("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = BLUE.Accent,
        BorderSizePixel = 0,
        ZIndex = 15,
    }, top)

    local logoWrap = create("Frame", {
        Size = UDim2.fromOffset(44, 44),
        Position = UDim2.fromOffset(12, 11),
        BackgroundColor3 = BLUE.AccentDeep,
        BorderSizePixel = 0,
        ZIndex = 14,
    }, top)
    corner(14, logoWrap)
    addStroke(logoWrap, BLUE.AccentBright, 1, 0.35)

    local logo = icon(SV.Icons.Logo, UDim2.fromScale(0.82, 0.82), Color3.new(1, 1, 1), logoWrap)
    if logo then
        logo.AnchorPoint = Vector2.new(0.5, 0.5)
        logo.Position = UDim2.fromScale(0.5, 0.5)
    end

    local title = create("TextLabel", {
        Size = UDim2.new(0, 310, 0, 22),
        Position = UDim2.fromOffset(68, 10),
        BackgroundTransparency = 1,
        Text = windowName,
        TextColor3 = BLUE.Text,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 14,
    }, top)

    local subtitle = create("TextLabel", {
        Size = UDim2.new(0, 310, 0, 18),
        Position = UDim2.fromOffset(68, 33),
        BackgroundTransparency = 1,
        Text = "SCRIPT VAULT  •  BLUE EDITION  •  v" .. SV._VERSION,
        TextColor3 = BLUE.TextMuted,
        TextSize = 9,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 14,
    }, top)

    local statusPill = create("Frame", {
        Size = UDim2.fromOffset(88, 28),
        Position = UDim2.new(1, -198, 0.5, -14),
        BackgroundColor3 = BLUE.Element,
        BorderSizePixel = 0,
        ZIndex = 14,
    }, top)
    corner(14, statusPill)
    addStroke(statusPill, BLUE.Border, 1, 0.35)
    local statusDot = create("Frame", {
        Size = UDim2.fromOffset(7, 7),
        Position = UDim2.fromOffset(10, 10),
        BackgroundColor3 = BLUE.Success,
        BorderSizePixel = 0,
        ZIndex = 15,
    }, statusPill)
    corner(99, statusDot)
    create("TextLabel", {
        Size = UDim2.new(1, -26, 1, 0),
        Position = UDim2.fromOffset(24, 0),
        BackgroundTransparency = 1,
        Text = "ONLINE",
        TextColor3 = BLUE.TextMuted,
        TextSize = 9,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 15,
    }, statusPill)

    local function topButton(x, color, glyph)
        local b = create("TextButton", {
            Size = UDim2.fromOffset(34, 34),
            Position = UDim2.new(1, x, 0.5, -17),
            BackgroundColor3 = color,
            BorderSizePixel = 0,
            Text = glyph,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            AutoButtonColor = false,
            ZIndex = 14,
        }, top)
        corner(10, b)
        return b
    end

    local minimize = topButton(-92, BLUE.Warning, "—")
    local close = topButton(-50, BLUE.Error, "×")

    local search = create("TextBox", {
        Size = UDim2.fromOffset(188, 34),
        Position = UDim2.new(1, -394, 0.5, -17),
        BackgroundColor3 = BLUE.Input,
        BorderSizePixel = 0,
        PlaceholderText = "Search  •  Ctrl+K",
        PlaceholderColor3 = BLUE.TextDark,
        Text = "",
        TextColor3 = BLUE.Text,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false,
        ZIndex = 14,
    }, top)
    corner(10, search)
    local searchStroke = addStroke(search, BLUE.Separator, 1, 0)
    addPadding(search, 0, 0, 32, 9)
    local searchIcon = icon(SV.Icons.Home, UDim2.fromOffset(15, 15), BLUE.TextMuted, search)
    if searchIcon then searchIcon.Position = UDim2.fromOffset(9, 9) end

    local sidebar = create("Frame", {
        Size = UDim2.new(0, sidebarWidth, 1, -66),
        Position = UDim2.fromOffset(0, 66),
        BackgroundColor3 = BLUE.Sidebar,
        BorderSizePixel = 0,
        ZIndex = 11,
    }, window)

    local content = create("Frame", {
        Size = UDim2.new(1, -sidebarWidth, 1, -66),
        Position = UDim2.new(0, sidebarWidth, 0, 66),
        BackgroundColor3 = BLUE.Background,
        BorderSizePixel = 0,
        ZIndex = 11,
    }, window)

    local sidebarHeader = create("Frame", {
        Size = UDim2.new(1, 0, 0, 70),
        BackgroundTransparency = 1,
        ZIndex = 12,
    }, sidebar)

    create("TextLabel", {
        Size = UDim2.new(1, -54, 0, 16),
        Position = UDim2.fromOffset(14, 13),
        BackgroundTransparency = 1,
        Text = "WORKSPACE",
        TextColor3 = BLUE.TextDark,
        TextSize = 9,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
    }, sidebarHeader)

    local collapse = create("TextButton", {
        Size = UDim2.fromOffset(28, 28),
        Position = UDim2.new(1, -38, 0, 7),
        BackgroundColor3 = BLUE.Element,
        BorderSizePixel = 0,
        Text = "‹",
        TextColor3 = BLUE.TextMuted,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        ZIndex = 14,
    }, sidebarHeader)
    corner(9, collapse)

    local tabList = create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -72),
        Position = UDim2.fromOffset(0, 70),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = BLUE.Accent,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        ZIndex = 12,
    }, sidebar)
    addList(tabList, 6)
    addPadding(tabList, 4, 12, 10, 10)

    local function selectTab(tab)
        for _, item in ipairs(tabs) do
            local active = item == tab
            item.Content.Visible = active
            item.Indicator.Visible = active
            animate(item.Button, { BackgroundColor3 = active and BLUE.ElementHover or BLUE.Element }, reducedMotion and 0 or 0.16)
            animate(item.Label, { TextColor3 = active and BLUE.Text or BLUE.TextMuted }, reducedMotion and 0 or 0.16)
            if item.Icon then
                animate(item.Icon, { ImageColor3 = active and BLUE.AccentBright or BLUE.TextMuted }, reducedMotion and 0 or 0.16)
            end
        end
        currentTab = tab
    end

    local function makeTab(name, iconId, opts)
        opts = opts or {}
        local button = create("TextButton", {
            Size = UDim2.new(1, 0, 0, 44),
            BackgroundColor3 = BLUE.Element,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = opts.Order or (#tabs + 1),
            ZIndex = 13,
        }, tabList)
        corner(11, button)

        local indicator = create("Frame", {
            Size = UDim2.fromOffset(3, 24),
            Position = UDim2.fromOffset(0, 10),
            BackgroundColor3 = BLUE.AccentBright,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 15,
        }, button)
        corner(3, indicator)

        local i = icon(iconId or SV.Icons.Home, UDim2.fromOffset(19, 19), BLUE.TextMuted, button)
        if i then i.Position = UDim2.fromOffset(13, 12) end

        local label = create("TextLabel", {
            Size = UDim2.new(1, -52, 1, 0),
            Position = UDim2.fromOffset(43, 0),
            BackgroundTransparency = 1,
            Text = tostring(name),
            TextColor3 = BLUE.TextMuted,
            TextSize = 11,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 14,
        }, button)

        local badge
        if opts.Badge then
            badge = create("TextLabel", {
                Size = UDim2.fromOffset(24, 18),
                Position = UDim2.new(1, -31, 0.5, -9),
                BackgroundColor3 = BLUE.Accent,
                BorderSizePixel = 0,
                Text = tostring(opts.Badge),
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 8,
                Font = Enum.Font.GothamBold,
                ZIndex = 15,
            }, button)
            corner(9, badge)
        end

        local page = create("ScrollingFrame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Visible = false,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(),
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = BLUE.Accent,
            ZIndex = 12,
        }, content)
        addList(page, 10)
        addPadding(page, 20, 24, 20, 20)

        local tab = {
            Name = tostring(name),
            Button = button,
            Content = page,
            Icon = i,
            Label = label,
            Indicator = indicator,
            Badge = badge,
            _order = 0,
        }
        table.insert(tabs, tab)

        connect(button.MouseButton1Click, function()
            selectTab(tab)
        end)
        connect(button.MouseButton1Click, function(input)
            ripple(button, input.Position)
        end)
        connect(button.MouseEnter, function()
            if currentTab ~= tab then animate(button, { BackgroundColor3 = BLUE.ElementHover }, 0.1) end
        end)
        connect(button.MouseLeave, function()
            if currentTab ~= tab then animate(button, { BackgroundColor3 = BLUE.Element }, 0.1) end
        end)

        function tab:CreateSection(textValue)
            self._order += 1
            local holder = create("Frame", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 1,
                LayoutOrder = self._order,
            }, self.Content)
            local bar = create("Frame", {
                Size = UDim2.fromOffset(3, 16),
                Position = UDim2.fromOffset(0, 7),
                BackgroundColor3 = BLUE.Accent,
                BorderSizePixel = 0,
            }, holder)
            corner(3, bar)
            create("TextLabel", {
                Size = UDim2.new(1, -14, 1, 0),
                Position = UDim2.fromOffset(11, 0),
                BackgroundTransparency = 1,
                Text = string.upper(tostring(textValue)),
                TextColor3 = BLUE.TextMuted,
                TextSize = 9,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, holder)
            return holder
        end

        function tab:CreateDivider()
            self._order += 1
            return create("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = BLUE.Separator,
                BorderSizePixel = 0,
                LayoutOrder = self._order,
            }, self.Content)
        end

        function tab:CreateLabel(textValue)
            self._order += 1
            return create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1,
                Text = tostring(textValue),
                TextColor3 = BLUE.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = self._order,
            }, self.Content)
        end

        function tab:CreateParagraph(o)
            o = o or {}
            self._order += 1
            local frame = create("Frame", {
                Size = UDim2.new(1, 0, 0, 78),
                BackgroundColor3 = BLUE.Element,
                BorderSizePixel = 0,
                LayoutOrder = self._order,
            }, self.Content)
            corner(13, frame)
            addStroke(frame, BLUE.Separator, 1, 0.15)
            local accent = create("Frame", {
                Size = UDim2.fromOffset(3, 48),
                Position = UDim2.fromOffset(8, 15),
                BackgroundColor3 = BLUE.Accent,
                BorderSizePixel = 0,
            }, frame)
            corner(2, accent)
            local ii = icon(o.Icon or SV.Icons.Info, UDim2.fromOffset(20, 20), BLUE.AccentBright, frame)
            if ii then ii.Position = UDim2.fromOffset(20, 11) end
            create("TextLabel", {
                Size = UDim2.new(1, -62, 0, 20),
                Position = UDim2.fromOffset(47, 9),
                BackgroundTransparency = 1,
                Text = o.Title or "Information",
                TextColor3 = BLUE.Text,
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, frame)
            local body = create("TextLabel", {
                Size = UDim2.new(1, -26, 0, 36),
                Position = UDim2.fromOffset(13, 35),
                BackgroundTransparency = 1,
                Text = o.Content or "",
                TextColor3 = BLUE.TextMuted,
                TextSize = 10,
                Font = Enum.Font.Gotham,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
            }, frame)
            task.defer(function()
                if frame.Parent then frame.Size = UDim2.new(1, 0, 0, math.max(78, body.TextBounds.Y + 48)) end
            end)
            return frame
        end

        function tab:CreateButton(o)
            o = o or {}
            self._order += 1
            local variants = {
                Primary = { BLUE.Accent, BLUE.AccentBright },
                Success = { BLUE.Success, Color3.fromRGB(82, 232, 157) },
                Warning = { BLUE.Warning, Color3.fromRGB(255, 202, 93) },
                Error = { BLUE.Error, Color3.fromRGB(255, 103, 119) },
                Ghost = { BLUE.Element, BLUE.ElementHover },
            }
            local pair = variants[o.Variant or "Primary"] or variants.Primary
            local b = create("TextButton", {
                Size = UDim2.new(1, 0, 0, 46),
                BackgroundColor3 = pair[1],
                BorderSizePixel = 0,
                Text = o.Name or "Button",
                TextColor3 = BLUE.Text,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                AutoButtonColor = false,
                LayoutOrder = self._order,
            }, self.Content)
            corner(11, b)
            addStroke(b, BLUE.Border, 1, 0.5)
            connect(b.MouseEnter, function() animate(b, { BackgroundColor3 = pair[2], Size = UDim2.new(1, 0, 0, 48) }, 0.12) end)
            connect(b.MouseLeave, function() animate(b, { BackgroundColor3 = pair[1], Size = UDim2.new(1, 0, 0, 46) }, 0.12) end)
            connect(b.MouseButton1Click, function(input)
                ripple(b, input.Position)
                safe(o.Callback)
            end)
            return b
        end

        function tab:CreateToggle(o)
            o = o or {}
            self._order += 1
            local frame = create("Frame", {
                Size = UDim2.new(1, 0, 0, o.Description and 64 or 48),
                BackgroundColor3 = BLUE.Element,
                BorderSizePixel = 0,
                LayoutOrder = self._order,
            }, self.Content)
            corner(11, frame)
            addStroke(frame, BLUE.Separator, 1, 0.25)
            create("TextLabel", {
                Size = UDim2.new(1, -84, 0, 20),
                Position = UDim2.fromOffset(13, o.Description and 9 or 14),
                BackgroundTransparency = 1,
                Text = o.Name or "Toggle",
                TextColor3 = BLUE.Text,
                TextSize = 11,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, frame)
            if o.Description then
                create("TextLabel", {
                    Size = UDim2.new(1, -84, 0, 17),
                    Position = UDim2.fromOffset(13, 34),
                    BackgroundTransparency = 1,
                    Text = o.Description,
                    TextColor3 = BLUE.TextDark,
                    TextSize = 9,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, frame)
            end

            local value = o.CurrentValue == true
            local track = create("Frame", {
                Size = UDim2.fromOffset(48, 26),
                Position = UDim2.new(1, -62, 0.5, -13),
                BackgroundColor3 = BLUE.Track,
                BorderSizePixel = 0,
            }, frame)
            corner(13, track)
            addStroke(track, BLUE.Separator, 1, 0.2)
            local knob = create("Frame", {
                Size = UDim2.fromOffset(20, 20),
                Position = UDim2.new(0, 3, 0.5, -10),
                BackgroundColor3 = BLUE.TextMuted,
                BorderSizePixel = 0,
            }, track)
            corner(10, knob)

            local function setValue(next)
                value = next == true
                animate(track, { BackgroundColor3 = value and BLUE.AccentDeep or BLUE.Track }, 0.15)
                animate(knob, {
                    Position = value and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10),
                    BackgroundColor3 = value and Color3.new(1,1,1) or BLUE.TextMuted,
                }, 0.16)
                safe(o.Callback, value)
            end
            setValue(value)
            connect(frame.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    setValue(not value)
                end
            end)

            return {
                Container = frame,
                SetValue = setValue,
                GetValue = function() return value end,
            }
        end

        function tab:CreateSlider(o)
            o = o or {}
            self._order += 1
            local min = (o.Range and o.Range[1]) or 0
            local max = (o.Range and o.Range[2]) or 100
            local increment = o.Increment or 1
            local value = tonumber(o.CurrentValue) or min
            local frame = create("Frame", {
                Size = UDim2.new(1, 0, 0, 66),
                BackgroundColor3 = BLUE.Element,
                BorderSizePixel = 0,
                LayoutOrder = self._order,
            }, self.Content)
            corner(11, frame)
            addStroke(frame, BLUE.Separator, 1, 0.25)
            create("TextLabel", {
                Size = UDim2.new(1, -90, 0, 20),
                Position = UDim2.fromOffset(13, 8),
                BackgroundTransparency = 1,
                Text = o.Name or "Slider",
                TextColor3 = BLUE.Text,
                TextSize = 11,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, frame)
            local valueLabel = create("TextLabel", {
                Size = UDim2.fromOffset(75, 20),
                Position = UDim2.new(1, -88, 0, 8),
                BackgroundTransparency = 1,
                TextColor3 = BLUE.AccentBright,
                TextSize = 10,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, frame)
            local track = create("Frame", {
                Size = UDim2.new(1, -26, 0, 7),
                Position = UDim2.fromOffset(13, 42),
                BackgroundColor3 = BLUE.Track,
                BorderSizePixel = 0,
            }, frame)
            corner(4, track)
            local fill = create("Frame", {
                Size = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = BLUE.Accent,
                BorderSizePixel = 0,
            }, track)
            corner(4, fill)

            local function setValue(next)
                local number = math.clamp(tonumber(next) or min, min, max)
                number = math.floor(number / increment + 0.5) * increment
                value = number
                local alpha = (number - min) / math.max(max - min, 1)
                fill.Size = UDim2.new(alpha, 0, 1, 0)
                valueLabel.Text = tostring(number) .. (o.Suffix or "")
                safe(o.Callback, number)
            end

            local function updateFromInput(input)
                local alpha = math.clamp((input.Position.X - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
                setValue(min + (max - min) * alpha)
            end

            connect(track.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    updateFromInput(input)
                    local moving = true
                    local c1, c2
                    c1 = UserInputService.InputChanged:Connect(function(changed)
                        if moving and (changed.UserInputType == Enum.UserInputType.MouseMovement or changed.UserInputType == Enum.UserInputType.Touch) then
                            updateFromInput(changed)
                        end
                    end)
                    c2 = UserInputService.InputEnded:Connect(function(ended)
                        if ended.UserInputType == Enum.UserInputType.MouseButton1 or ended.UserInputType == Enum.UserInputType.Touch then
                            moving = false
                            c1:Disconnect()
                            c2:Disconnect()
                        end
                    end)
                end
            end)
            setValue(value)
            return { Container = frame, SetValue = setValue, GetValue = function() return value end }
        end

        function tab:CreateDropdown(o)
            o = o or {}
            self._order += 1
            local frame = create("Frame", {
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = BLUE.Element,
                BorderSizePixel = 0,
                LayoutOrder = self._order,
            }, self.Content)
            corner(11, frame)
            addStroke(frame, BLUE.Separator, 1, 0.25)
            create("TextLabel", {
                Size = UDim2.new(0.42, 0, 1, 0),
                Position = UDim2.fromOffset(13, 0),
                BackgroundTransparency = 1,
                Text = o.Name or "Dropdown",
                TextColor3 = BLUE.Text,
                TextSize = 11,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, frame)

            local selected = o.CurrentOption or (o.Options and o.Options[1]) or "Select"
            local open = false
            local button = create("TextButton", {
                Size = UDim2.new(0.5, -10, 0, 34),
                Position = UDim2.new(0.5, 0, 0.5, -17),
                BackgroundColor3 = BLUE.Input,
                BorderSizePixel = 0,
                Text = tostring(selected) .. "  ▾",
                TextColor3 = BLUE.TextMuted,
                TextSize = 10,
                Font = Enum.Font.GothamMedium,
                AutoButtonColor = false,
            }, frame)
            corner(9, button)

            local popup = create("Frame", {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 1, 5),
                BackgroundColor3 = BLUE.Sidebar,
                BorderSizePixel = 0,
                Visible = false,
                ZIndex = 5000,
            }, frame)
            corner(10, popup)
            addStroke(popup, BLUE.Border, 1, 0.25)
            local list = create("ScrollingFrame", {
                Size = UDim2.new(1, -8, 1, -8),
                Position = UDim2.fromOffset(4, 4),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(),
                ScrollBarThickness = 2,
                ZIndex = 5001,
            }, popup)
            addList(list, 4)
            addPadding(list, 2, 2, 2, 2)

            local function rebuild()
                for _, child in ipairs(list:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                for _, option in ipairs(o.Options or {}) do
                    local item = create("TextButton", {
                        Size = UDim2.new(1, 0, 0, 34),
                        BackgroundColor3 = option == selected and BLUE.ElementHover or BLUE.Element,
                        BorderSizePixel = 0,
                        Text = tostring(option),
                        TextColor3 = option == selected and BLUE.AccentBright or BLUE.TextMuted,
                        TextSize = 10,
                        Font = Enum.Font.GothamMedium,
                        AutoButtonColor = false,
                        ZIndex = 5002,
                    }, list)
                    corner(8, item)
                    connect(item.MouseButton1Click, function()
                        selected = option
                        button.Text = tostring(selected) .. "  ▾"
                        open = false
                        popup.Visible = false
                        safe(o.Callback, selected)
                    end)
                end
            end

            connect(button.MouseButton1Click, function()
                open = not open
                popup.Visible = open
                if open then
                    rebuild()
                    local count = math.min(#(o.Options or {}), 6)
                    popup.Size = UDim2.new(0.5, -10, 0, math.max(40, count * 38 + 8))
                end
            end)
            rebuild()

            return {
                Container = frame,
                SetValue = function(value)
                    selected = value
                    button.Text = tostring(selected) .. "  ▾"
                    rebuild()
                end,
                GetValue = function() return selected end,
            }
        end

        function tab:CreateInput(o)
            o = o or {}
            self._order += 1
            local frame = create("Frame", {
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = BLUE.Element,
                BorderSizePixel = 0,
                LayoutOrder = self._order,
            }, self.Content)
            corner(11, frame)
            addStroke(frame, BLUE.Separator, 1, 0.25)
            create("TextLabel", {
                Size = UDim2.new(0.34, 0, 1, 0),
                Position = UDim2.fromOffset(13, 0),
                BackgroundTransparency = 1,
                Text = o.Name or "Input",
                TextColor3 = BLUE.Text,
                TextSize = 11,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, frame)
            local box = create("TextBox", {
                Size = UDim2.new(0.58, 0, 0, 34),
                Position = UDim2.new(0.42, 0, 0.5, -17),
                BackgroundColor3 = BLUE.Input,
                BorderSizePixel = 0,
                PlaceholderText = o.Placeholder or "Enter value...",
                PlaceholderColor3 = BLUE.TextDark,
                Text = o.CurrentValue or "",
                TextColor3 = BLUE.Text,
                TextSize = 10,
                Font = Enum.Font.Gotham,
                ClearTextOnFocus = false,
            }, frame)
            corner(9, box)
            addPadding(box, 0, 0, 10, 10)
            connect(box.FocusLost, function()
                safe(o.Callback, box.Text)
            end)
            return { Container = frame, SetValue = function(v) box.Text = tostring(v) end, GetValue = function() return box.Text end }
        end

        function tab:CreateKeybind(o)
            o = o or {}
            self._order += 1
            local frame = create("Frame", {
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = BLUE.Element,
                BorderSizePixel = 0,
                LayoutOrder = self._order,
            }, self.Content)
            corner(11, frame)
            addStroke(frame, BLUE.Separator, 1, 0.25)
            create("TextLabel", {
                Size = UDim2.new(0.5, 0, 1, 0),
                Position = UDim2.fromOffset(13, 0),
                BackgroundTransparency = 1,
                Text = o.Name or "Keybind",
                TextColor3 = BLUE.Text,
                TextSize = 11,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, frame)
            local key = o.CurrentKeybind or Enum.KeyCode.RightShift
            local binding = false
            local button = create("TextButton", {
                Size = UDim2.fromOffset(116, 32),
                Position = UDim2.new(1, -129, 0.5, -16),
                BackgroundColor3 = BLUE.Input,
                BorderSizePixel = 0,
                Text = key.Name,
                TextColor3 = BLUE.AccentBright,
                TextSize = 10,
                Font = Enum.Font.GothamBold,
                AutoButtonColor = false,
            }, frame)
            corner(9, button)
            connect(button.MouseButton1Click, function()
                binding = true
                button.Text = "PRESS KEY"
                button.TextColor3 = BLUE.Warning
            end)
            connect(UserInputService.InputBegan, function(input, gameProcessed)
                if binding and not gameProcessed and input.KeyCode ~= Enum.KeyCode.Unknown then
                    key = input.KeyCode
                    binding = false
                    button.Text = key.Name
                    button.TextColor3 = BLUE.AccentBright
                    safe(o.Callback, key)
                end
            end)
            return { Container = frame, SetValue = function(v) if typeof(v) == "EnumItem" then key = v; button.Text = v.Name end end, GetValue = function() return key end }
        end

        function tab:CreateProgressBar(o)
            o = o or {}
            self._order += 1
            local frame = create("Frame", {
                Size = UDim2.new(1, 0, 0, 70),
                BackgroundColor3 = BLUE.Element,
                BorderSizePixel = 0,
                LayoutOrder = self._order,
            }, self.Content)
            corner(11, frame)
            addStroke(frame, BLUE.Separator, 1, 0.25)
            create("TextLabel", {
                Size = UDim2.new(1, -90, 0, 20),
                Position = UDim2.fromOffset(13, 8),
                BackgroundTransparency = 1,
                Text = o.Name or "Progress",
                TextColor3 = BLUE.Text,
                TextSize = 11,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, frame)
            local percent = create("TextLabel", {
                Size = UDim2.fromOffset(72, 20),
                Position = UDim2.new(1, -85, 0, 8),
                BackgroundTransparency = 1,
                Text = "0%",
                TextColor3 = BLUE.AccentBright,
                TextSize = 10,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, frame)
            local track = create("Frame", {
                Size = UDim2.new(1, -26, 0, 8),
                Position = UDim2.fromOffset(13, 42),
                BackgroundColor3 = BLUE.Track,
                BorderSizePixel = 0,
            }, frame)
            corner(4, track)
            local fill = create("Frame", {
                Size = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = BLUE.Accent,
                BorderSizePixel = 0,
            }, track)
            corner(4, fill)
            local function setValue(value)
                value = math.clamp(tonumber(value) or 0, 0, 100)
                animate(fill, { Size = UDim2.new(value / 100, 0, 1, 0) }, reducedMotion and 0 or 0.25)
                percent.Text = string.format("%d%%", value)
                safe(o.Callback, value)
            end
            setValue(o.CurrentValue or 0)
            return { Container = frame, SetValue = setValue, GetValue = function() return tonumber(percent.Text:match("%d+")) or 0 end }
        end

        function tab:CreateColorPicker(o)
            o = o or {}
            self._order += 1
            local frame = create("Frame", {
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = BLUE.Element,
                BorderSizePixel = 0,
                LayoutOrder = self._order,
            }, self.Content)
            corner(11, frame)
            addStroke(frame, BLUE.Separator, 1, 0.25)
            create("TextLabel", {
                Size = UDim2.new(1, -78, 1, 0),
                Position = UDim2.fromOffset(13, 0),
                BackgroundTransparency = 1,
                Text = o.Name or "Color",
                TextColor3 = BLUE.Text,
                TextSize = 11,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, frame)
            local current = o.CurrentColor or BLUE.Accent
            local swatch = create("TextButton", {
                Size = UDim2.fromOffset(46, 30),
                Position = UDim2.new(1, -59, 0.5, -15),
                BackgroundColor3 = current,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
            }, frame)
            corner(9, swatch)
            local popup = create("Frame", {
                Size = UDim2.fromOffset(206, 40),
                Position = UDim2.new(1, -215, 1, 5),
                BackgroundColor3 = BLUE.Sidebar,
                BorderSizePixel = 0,
                Visible = false,
                ZIndex = 6000,
            }, frame)
            corner(10, popup)
            addStroke(popup, BLUE.Border, 1, 0.25)
            local grid = create("UIGridLayout", {
                CellSize = UDim2.fromOffset(28, 28),
                CellPadding = UDim2.fromOffset(5, 5),
            }, popup)
            for _, colorValue in ipairs(o.Colors or {
                BLUE.Accent, BLUE.AccentBright, BLUE.Success, BLUE.Warning, BLUE.Error,
                Color3.fromRGB(255,255,255), Color3.fromRGB(150,170,200), Color3.fromRGB(60,80,110),
            }) do
                local item = create("TextButton", {
                    BackgroundColor3 = colorValue,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 6001,
                }, popup)
                corner(7, item)
                connect(item.MouseButton1Click, function()
                    current = colorValue
                    swatch.BackgroundColor3 = current
                    popup.Visible = false
                    safe(o.Callback, current)
                end)
            end
            connect(swatch.MouseButton1Click, function() popup.Visible = not popup.Visible end)
            return { Container = frame, SetValue = function(v) if typeof(v) == "Color3" then current = v; swatch.BackgroundColor3 = v end end, GetValue = function() return current end }
        end

        function tab:CreateBadge(textValue, colorValue)
            self._order += 1
            local badge = create("TextLabel", {
                Size = UDim2.fromOffset(76, 25),
                BackgroundColor3 = colorValue or BLUE.Accent,
                BorderSizePixel = 0,
                Text = tostring(textValue),
                TextColor3 = Color3.new(1,1,1),
                TextSize = 9,
                Font = Enum.Font.GothamBold,
                LayoutOrder = self._order,
            }, self.Content)
            corner(13, badge)
            return badge
        end

        function tab:SetVisible(value)
            self.Content.Visible = value ~= false
            return self
        end

        function tab:Select()
            selectTab(self)
            return self
        end

        function tab:SetBadge(value)
            if self.Badge then
                self.Badge.Text = tostring(value)
            elseif value then
                local badgeObject = create("TextLabel", {
                    Size = UDim2.fromOffset(24, 18),
                    Position = UDim2.new(1, -31, 0.5, -9),
                    BackgroundColor3 = BLUE.Accent,
                    BorderSizePixel = 0,
                    Text = tostring(value),
                    TextColor3 = Color3.new(1,1,1),
                    TextSize = 8,
                    Font = Enum.Font.GothamBold,
                    ZIndex = 15,
                }, self.Button)
                corner(9, badgeObject)
                self.Badge = badgeObject
            end
            return self
        end

        return tab
    end

    local function createStatCard(parent, labelText, valueText, accentColor)
        local card = create("Frame", {
            BackgroundColor3 = BLUE.Element,
            BorderSizePixel = 0,
        }, parent)
        corner(12, card)
        addStroke(card, BLUE.Separator, 1, 0.25)
        create("TextLabel", {
            Size = UDim2.new(1, -24, 0, 18),
            Position = UDim2.fromOffset(12, 10),
            BackgroundTransparency = 1,
            Text = labelText,
            TextColor3 = BLUE.TextMuted,
            TextSize = 9,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, card)
        local value = create("TextLabel", {
            Size = UDim2.new(1, -24, 0, 28),
            Position = UDim2.fromOffset(12, 31),
            BackgroundTransparency = 1,
            Text = valueText,
            TextColor3 = accentColor or BLUE.Text,
            TextSize = 19,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, card)
        return value
    end

    local dashboard = makeTab("Dashboard", SV.Icons.Home, { Order = 0 })
    dashboard:CreateSection("Overview")

    local statRow = create("Frame", {
        Size = UDim2.new(1, 0, 0, 82),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
    }, dashboard.Content)
    local statGrid = create("UIGridLayout", {
        CellPadding = UDim2.fromOffset(10, 0),
        CellSize = UDim2.new(0.25, -8, 1, 0),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, statRow)

    local fpsValue = createStatCard(statRow, "FPS", "--", BLUE.AccentBright)
    local pingValue = createStatCard(statRow, "PING", "-- ms", BLUE.Success)
    local memoryValue = createStatCard(statRow, "MEMORY", "-- MB", BLUE.Warning)
    local sessionValue = createStatCard(statRow, "SESSION", "00:00", BLUE.Text)

    dashboard:CreateParagraph({
        Title = "ScriptVault Blue Edition",
        Content = "A premium fixed-blue UI system with animated glow, responsive navigation, clean controls, command search and reusable components.",
        Icon = SV.Icons.Star,
    })
    dashboard:CreateSection("Library")
    dashboard:CreateLabel("Use Window:CreateTab(...) to build your own pages. No theme switcher is included; the Blue visual system is intentionally fixed.")
    dashboard:CreateButton({
        Name = "Open Command Palette",
        Variant = "Primary",
        Callback = function()
            paletteOverlay.Visible = true
            paletteSearch.Text = ""
            paletteSearch:CaptureFocus()
        end,
    })

    local monitor = makeTab("Monitor", SV.Icons.Stats, { Order = 1 })
    monitor:CreateSection("Runtime")
    monitor:CreateParagraph({
        Title = "Live Runtime Monitor",
        Content = "Dashboard metrics update automatically. Use this page for your own live counters and status widgets.",
        Icon = SV.Icons.Stats,
    })
    monitor:CreateProgressBar({ Name = "Example Load", CurrentValue = 72 })

    local settings = makeTab("Settings", SV.Icons.Settings, { Order = 99 })
    settings:CreateSection("Interface")
    settings:CreateToggle({
        Name = "Reduced Motion",
        Description = "Reduce decorative animation while keeping the same Blue design.",
        CurrentValue = reducedMotion,
        Callback = function(value) reducedMotion = value end,
    })
    settings:CreateKeybind({
        Name = "Toggle Window",
        CurrentKeybind = toggleKey,
    })
    settings:CreateParagraph({
        Title = "Fixed Blue System",
        Content = "ScriptVault uses one cohesive blue visual identity. Theme changing and theme registration APIs are intentionally not part of v7.",
        Icon = SV.Icons.Info,
    })

    local paletteOverlay = create("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = BLUE.Overlay,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 9000,
    }, screen)

    local paletteFrame = create("Frame", {
        Size = UDim2.new(0, 500, 0, 390),
        Position = UDim2.new(0.5, -250, 0.5, -195),
        BackgroundColor3 = BLUE.Sidebar,
        BorderSizePixel = 0,
        ZIndex = 9001,
    }, paletteOverlay)
    corner(17, paletteFrame)
    addStroke(paletteFrame, BLUE.Accent, 1, 0.22)

    local paletteSearch = create("TextBox", {
        Size = UDim2.new(1, -28, 0, 46),
        Position = UDim2.fromOffset(14, 14),
        BackgroundColor3 = BLUE.Input,
        BorderSizePixel = 0,
        PlaceholderText = "Search pages...",
        PlaceholderColor3 = BLUE.TextDark,
        Text = "",
        TextColor3 = BLUE.Text,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false,
        ZIndex = 9002,
    }, paletteFrame)
    corner(11, paletteSearch)
    addPadding(paletteSearch, 0, 0, 12, 12)

    local results = create("ScrollingFrame", {
        Size = UDim2.new(1, -28, 1, -76),
        Position = UDim2.fromOffset(14, 66),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = BLUE.Accent,
        ZIndex = 9002,
    }, paletteFrame)
    addList(results, 5)
    addPadding(results, 2, 5, 2, 2)

    local function rebuildResults(query)
        for _, child in ipairs(results:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        query = string.lower(query or "")
        for _, tab in ipairs(tabs) do
            if query == "" or string.find(string.lower(tab.Name), query, 1, true) then
                local item = create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 43),
                    BackgroundColor3 = BLUE.Element,
                    BorderSizePixel = 0,
                    Text = tab.Name,
                    TextColor3 = BLUE.Text,
                    TextSize = 11,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutoButtonColor = false,
                    ZIndex = 9003,
                }, results)
                corner(10, item)
                addPadding(item, 0, 0, 13, 13)
                connect(item.MouseEnter, function() animate(item, { BackgroundColor3 = BLUE.ElementHover }, 0.1) end)
                connect(item.MouseLeave, function() animate(item, { BackgroundColor3 = BLUE.Element }, 0.1) end)
                connect(item.MouseButton1Click, function()
                    selectTab(tab)
                    paletteOverlay.Visible = false
                    paletteSearch.Text = ""
                end)
            end
        end
    end

    connect(paletteSearch:GetPropertyChangedSignal("Text"), function()
        rebuildResults(paletteSearch.Text)
    end)
    rebuildResults("")

    connect(search:GetPropertyChangedSignal("Text"), function()
        local query = string.lower(search.Text)
        for _, tab in ipairs(tabs) do
            tab.Button.Visible = query == "" or string.find(string.lower(tab.Name), query, 1, true) ~= nil
        end
    end)
    connect(search.Focused, function() animate(searchStroke, { Color = BLUE.Accent }, 0.12) end)
    connect(search.FocusLost, function() animate(searchStroke, { Color = BLUE.Separator }, 0.12) end)

    local restore = create("TextButton", {
        Size = UDim2.fromOffset(62, 62),
        Position = UDim2.new(1, -84, 0.5, -31),
        BackgroundColor3 = BLUE.AccentDeep,
        BorderSizePixel = 0,
        Text = "",
        Visible = false,
        ZIndex = 8000,
        AutoButtonColor = false,
    }, screen)
    corner(19, restore)
    addStroke(restore, BLUE.AccentBright, 2, 0.1)
    local restoreLogo = icon(SV.Icons.Logo, UDim2.fromScale(0.72, 0.72), Color3.new(1,1,1), restore)
    if restoreLogo then restoreLogo.AnchorPoint = Vector2.new(0.5,0.5); restoreLogo.Position = UDim2.fromScale(0.5,0.5) end

    local function setMinimized(value)
        minimized = value == true
        window.Visible = not minimized
        shadow.Visible = not minimized
        aura.Visible = not minimized
        restore.Visible = minimized
    end

    connect(minimize.MouseButton1Click, function() setMinimized(true) end)
    connect(restore.MouseButton1Click, function() setMinimized(false) end)
    connect(close.MouseButton1Click, function()
        destroyed = true
        disconnectAll()
        if screen.Parent then screen:Destroy() end
    end)

    connect(paletteOverlay.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local p = input.Position
            local q = paletteFrame.AbsolutePosition
            local s = paletteFrame.AbsoluteSize
            if p.X < q.X or p.X > q.X + s.X or p.Y < q.Y or p.Y > q.Y + s.Y then
                paletteOverlay.Visible = false
            end
        end
    end)

    connect(UserInputService.InputBegan, function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == toggleKey then
            setMinimized(not minimized)
        elseif (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) and input.KeyCode == Enum.KeyCode.K then
            paletteOverlay.Visible = true
            rebuildResults("")
            paletteSearch:CaptureFocus()
        elseif input.KeyCode == Enum.KeyCode.Escape then
            paletteOverlay.Visible = false
        end
    end)

    -- Drag
    local dragging = false
    local dragStart
    local startPosition
    connect(top.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = window.Position
        end
    end)
    connect(UserInputService.InputChanged, function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
            shadow.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X - 17, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y + 12)
            aura.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X - 9, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y - 9)
        end
    end)
    connect(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)

    -- Resize
    local resizeHandle = create("TextButton", {
        Size = UDim2.fromOffset(26, 26),
        Position = UDim2.new(1, -26, 1, -26),
        BackgroundTransparency = 1,
        Text = "⋰",
        TextColor3 = BLUE.TextMuted,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        ZIndex = 30,
    }, window)
    local resizing = false
    local resizeStart
    local resizeSize
    connect(resizeHandle.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            resizeStart = input.Position
            resizeSize = window.AbsoluteSize
        end
    end)
    connect(UserInputService.InputChanged, function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - resizeStart
            local w = math.max(minWidth, resizeSize.X + delta.X)
            local h = math.max(minHeight, resizeSize.Y + delta.Y)
            window.Size = UDim2.fromOffset(w, h)
            shadow.Size = UDim2.fromOffset(w + 34, h + 34)
            aura.Size = UDim2.fromOffset(w + 18, h + 18)
        end
    end)
    connect(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then resizing = false end
    end)

    connect(collapse.MouseButton1Click, function()
        sidebarCollapsed = not sidebarCollapsed
        local target = sidebarCollapsed and 64 or sidebarWidth
        animate(sidebar, { Size = UDim2.new(0, target, 1, -66) }, 0.22)
        animate(content, { Position = UDim2.new(0, target, 0, 66), Size = UDim2.new(1, -target, 1, -66) }, 0.22)
        collapse.Text = sidebarCollapsed and "›" or "‹"
        for _, tab in ipairs(tabs) do
            tab.Label.Visible = not sidebarCollapsed
        end
    end)

    -- Decorative animation loop
    task.spawn(function()
        local elapsed = 0
        while not destroyed and screen.Parent do
            elapsed += task.wait(0.035)
            if not reducedMotion then
                local pulse = (math.sin(elapsed * 2.4) + 1) / 2
                outerGlow.Transparency = 0.30 + pulse * 0.34
                innerStroke.Transparency = 0.68 + pulse * 0.17
                aura.BackgroundTransparency = 0.955 - pulse * 0.035
                topLine.BackgroundTransparency = 0.08 + pulse * 0.28
                logoWrap.Rotation = math.sin(elapsed * 0.7) * 1.5
            end
        end
    end)

    -- FPS and runtime metrics
    local startTime = os.clock()
    local frameCount = 0
    local fpsClock = os.clock()
    connect(RunService.RenderStepped, function()
        frameCount += 1
        if os.clock() - fpsClock >= 1 then
            local elapsed = os.clock() - fpsClock
            fpsValue.Text = tostring(math.floor(frameCount / elapsed + 0.5))
            frameCount = 0
            fpsClock = os.clock()
            pingValue.Text = tostring(getPing()) .. " ms"
            memoryValue.Text = tostring(getMemory()) .. " MB"
            local total = math.floor(os.clock() - startTime)
            sessionValue.Text = string.format("%02d:%02d", math.floor(total / 60) % 60, total % 60)
        end
    end)

    -- Toast notifications
    local function getNotifications()
        if notificationHolder and notificationHolder.Parent then return notificationHolder end
        notificationHolder = create("Frame", {
            Name = "Notifications",
            Size = UDim2.fromOffset(340, 1),
            Position = UDim2.new(1, -356, 0, 20),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 7000,
        }, screen)
        addList(notificationHolder, 8)
        return notificationHolder
    end

    local api = {}
    api.Version = SV._VERSION
    api.Build = SV._BUILD
    api.Colors = BLUE
    api.Theme = BLUE
    api.ThemeName = "Blue"
    api.Instance = window
    api.ScreenGui = screen
    api.Tabs = tabs
    api.GetTabs = function() return tabs end
    api.GetCurrentTab = function() return currentTab end
    api.IsMinimized = function() return minimized end
    api.IsReducedMotion = function() return reducedMotion end
    api.SetReducedMotion = function(value) reducedMotion = value == true; return api end
    api.Toggle = function() setMinimized(not minimized); return api end
    api.Minimize = function() setMinimized(true); return api end
    api.Restore = function() setMinimized(false); return api end
    api.SelectTab = function(name)
        for _, tab in ipairs(tabs) do
            if tab.Name == name then selectTab(tab); return tab end
        end
    end
    api.OpenCommandPalette = function()
        paletteOverlay.Visible = true
        rebuildResults("")
        paletteSearch:CaptureFocus()
    end
    api.SetPosition = function(x, y)
        window.Position = UDim2.fromOffset(tonumber(x) or 0, tonumber(y) or 0)
        return api
    end
    api.SetSize = function(w, h)
        local newW = math.max(minWidth, tonumber(w) or width)
        local newH = math.max(minHeight, tonumber(h) or height)
        window.Size = UDim2.fromOffset(newW, newH)
        shadow.Size = UDim2.fromOffset(newW + 34, newH + 34)
        aura.Size = UDim2.fromOffset(newW + 18, newH + 18)
        return api
    end
    api.Notify = function(o)
        o = o or {}
        local holder = getNotifications()
        local item = create("Frame", {
            Size = UDim2.new(1, 0, 0, 76),
            BackgroundColor3 = BLUE.Element,
            BorderSizePixel = 0,
            ZIndex = 7001,
        }, holder)
        corner(13, item)
        addStroke(item, BLUE.Border, 1, 0.2)
        local bar = create("Frame", {
            Size = UDim2.fromOffset(3, 52),
            Position = UDim2.fromOffset(8, 12),
            BackgroundColor3 = o.Color or BLUE.Accent,
            BorderSizePixel = 0,
            ZIndex = 7002,
        }, item)
        corner(2, bar)
        create("TextLabel", {
            Size = UDim2.new(1, -38, 0, 20),
            Position = UDim2.fromOffset(20, 8),
            BackgroundTransparency = 1,
            Text = o.Title or "ScriptVault",
            TextColor3 = BLUE.Text,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 7002,
        }, item)
        create("TextLabel", {
            Size = UDim2.new(1, -38, 0, 34),
            Position = UDim2.fromOffset(20, 30),
            BackgroundTransparency = 1,
            Text = o.Content or "",
            TextColor3 = BLUE.TextMuted,
            TextSize = 9,
            Font = Enum.Font.Gotham,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            ZIndex = 7002,
        }, item)
        task.delay(o.Duration or 3, function()
            if item.Parent then
                animate(item, { BackgroundTransparency = 1 }, 0.18)
                task.wait(0.2)
                if item.Parent then item:Destroy() end
            end
        end)
        return item
    end
    api.ClearNotifications = function()
        if notificationHolder then
            for _, child in ipairs(notificationHolder:GetChildren()) do
                if child:IsA("Frame") then child:Destroy() end
            end
        end
    end
    api.Destroy = function()
        if destroyed then return end
        destroyed = true
        disconnectAll()
        if screen.Parent then screen:Destroy() end
    end
    api.CreateTab = function(name, iconId, opts)
        return makeTab(name, iconId, opts)
    end

    selectTab(dashboard)

    if options.LoadingScreen ~= false then
        window.Visible = false
        shadow.Visible = false
        aura.Visible = false
        task.delay(options.LoadingDuration or 0.5, function()
            if screen.Parent and not destroyed then
                window.Visible = true
                shadow.Visible = true
                aura.Visible = true
            end
        end)
    end

    return api
end

SV.IsTouchDevice = isTouch
SV.FormatNumber = formatNumber
SV.GetPing = getPing
SV.GetMemory = getMemory

return SV
