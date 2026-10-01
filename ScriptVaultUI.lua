--[[
    ============================================================
    ScriptVault UI Library
    Version: 1.0.0
    Style: Modern Dark Navy (Blox Fruits tarzı)
    Features: Tabs, Toggle, Button, Slider, Dropdown,
              Input, Label, Section, Keybind, Notify
    Compatible: PC + Mobile (Touch drag supported)
    ============================================================

    USAGE:
        local SV = loadstring(game:HttpGet("URL"))()
        local Window = SV:CreateWindow({ Name = "My Script", Theme = "Dark" })
        local FarmTab = Window:CreateTab("Farm")
        FarmTab:CreateToggle({ Name = "Auto Farm", Default = false, Callback = function(v) end })
]]

-- ==================== SERVICES ====================
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")
local RunService       = game:GetService("RunService")
local LP               = Players.LocalPlayer

-- ==================== THEMES ====================
local Themes = {
    Dark = {
        Background  = Color3.fromRGB(18, 20, 30),
        Sidebar     = Color3.fromRGB(14, 16, 24),
        Card        = Color3.fromRGB(28, 32, 46),
        CardHover   = Color3.fromRGB(36, 42, 58),
        Accent      = Color3.fromRGB(88, 130, 255),
        AccentDark  = Color3.fromRGB(60, 90, 190),
        Text        = Color3.fromRGB(235, 240, 250),
        SubText     = Color3.fromRGB(130, 138, 160),
        Outline     = Color3.fromRGB(42, 48, 66),
        ToggleOff   = Color3.fromRGB(55, 60, 80),
        Success     = Color3.fromRGB(72, 199, 116),
        Danger      = Color3.fromRGB(230, 74, 74),
        Warning     = Color3.fromRGB(240, 180, 60),
    },
    Blood = {
        Background  = Color3.fromRGB(24, 12, 14),
        Sidebar     = Color3.fromRGB(18, 8, 10),
        Card        = Color3.fromRGB(38, 18, 22),
        CardHover   = Color3.fromRGB(52, 24, 30),
        Accent      = Color3.fromRGB(220, 60, 70),
        AccentDark  = Color3.fromRGB(160, 40, 50),
        Text        = Color3.fromRGB(250, 235, 235),
        SubText     = Color3.fromRGB(170, 130, 130),
        Outline     = Color3.fromRGB(60, 26, 30),
        ToggleOff   = Color3.fromRGB(70, 40, 45),
        Success     = Color3.fromRGB(120, 200, 120),
        Danger      = Color3.fromRGB(255, 90, 90),
        Warning     = Color3.fromRGB(240, 180, 60),
    },
    Ocean = {
        Background  = Color3.fromRGB(12, 22, 34),
        Sidebar     = Color3.fromRGB(8, 16, 26),
        Card        = Color3.fromRGB(20, 36, 52),
        CardHover   = Color3.fromRGB(28, 48, 68),
        Accent      = Color3.fromRGB(60, 180, 220),
        AccentDark  = Color3.fromRGB(40, 130, 170),
        Text        = Color3.fromRGB(230, 245, 252),
        SubText     = Color3.fromRGB(130, 160, 180),
        Outline     = Color3.fromRGB(30, 52, 72),
        ToggleOff   = Color3.fromRGB(40, 62, 82),
        Success     = Color3.fromRGB(80, 200, 160),
        Danger      = Color3.fromRGB(230, 90, 90),
        Warning     = Color3.fromRGB(240, 190, 70),
    },
}

-- ==================== UTILITIES ====================
local function newInstance(className, properties, children)
    local obj = Instance.new(className)
    if properties then
        for k, v in pairs(properties) do
            obj[k] = v
        end
    end
    if children then
        for _, child in ipairs(children) do
            child.Parent = obj
        end
    end
    return obj
end

local function corner(parent, radius)
    return newInstance("UICorner", {
        CornerRadius = UDim.new(0, radius or 8),
        Parent = parent
    })
end

local function stroke(parent, color, thickness)
    return newInstance("UIStroke", {
        Color = color or Color3.fromRGB(50, 50, 60),
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent
    })
end

local function padding(parent, px)
    return newInstance("UIPadding", {
        PaddingTop    = UDim.new(0, px or 8),
        PaddingBottom = UDim.new(0, px or 8),
        PaddingLeft   = UDim.new(0, px or 8),
        PaddingRight  = UDim.new(0, px or 8),
        Parent = parent
    })
end

local function tween(obj, time, props, style, dir)
    local info = TweenInfo.new(
        time or 0.2,
        style or Enum.EasingStyle.Quad,
        dir or Enum.EasingDirection.Out
    )
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function getGuiParent()
    if gethui then
        local ok, hui = pcall(gethui)
        if ok and hui then return hui end
    end
    local ok, cg = pcall(function() return CoreGui end)
    if ok and cg then return cg end
    return LP:WaitForChild("PlayerGui")
end

-- ==================== LIBRARY ====================
local Library = {}
Library.__index = Library

-- ==================== NOTIFICATIONS ====================
local NotifyHolder
local function getNotifyHolder()
    if NotifyHolder and NotifyHolder.Parent then return NotifyHolder end
    NotifyHolder = newInstance("ScreenGui", {
        Name = "SV_Notifications",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = getGuiParent()
    })
    return NotifyHolder
end

function Library:Notify(config)
    config = config or {}
    local title    = config.Title or "Notification"
    local text     = config.Text or ""
    local duration = config.Duration or 4

    local holder = getNotifyHolder()

    local frame = newInstance("Frame", {
        Size = UDim2.new(0, 300, 0, 70),
        Position = UDim2.new(1, 20, 0, 20),
        BackgroundColor3 = self.Theme.Card,
        BorderSizePixel = 0,
        Parent = holder
    })
    corner(frame, 10)
    stroke(frame, self.Theme.Outline, 1)

    local accent = newInstance("Frame", {
        Size = UDim2.new(0, 4, 1, -16),
        Position = UDim2.new(0, 6, 0, 8),
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Parent = frame
    })
    corner(accent, 2)

    newInstance("TextLabel", {
        Size = UDim2.new(1, -24, 0, 20),
        Position = UDim2.new(0, 18, 0, 8),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = self.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = frame
    })

    newInstance("TextLabel", {
        Size = UDim2.new(1, -24, 0, 30),
        Position = UDim2.new(0, 18, 0, 30),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = self.Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = frame
    })

    -- Stacking
    local existing = {}
    for _, child in ipairs(holder:GetChildren()) do
        if child:IsA("Frame") then table.insert(existing, child) end
    end
    table.sort(existing, function(a, b) return a.Position.Y.Offset < b.Position.Y.Offset end)
    local yOffset = 20
    for _, f in ipairs(existing) do
        tween(f, 0.25, { Position = UDim2.new(1, -320, 0, yOffset) })
        yOffset = yOffset + 80
    end

    -- Slide in
    tween(frame, 0.35, { Position = UDim2.new(1, -320, 0, (yOffset - 80)) },
        Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    task.delay(duration, function()
        if frame and frame.Parent then
            tween(frame, 0.3, { Position = UDim2.new(1, 20, 0, frame.Position.Y.Offset) })
            task.wait(0.35)
            frame:Destroy()
        end
    end)
end

-- ==================== WINDOW ====================
local Window = {}
Window.__index = Window

function Library:CreateWindow(config)
    config = config or {}
    local title = config.Name or "ScriptVault"
    local themeName = config.Theme or "Dark"
    self.Theme = Themes[themeName] or Themes.Dark

    local T = self.Theme

    local gui = newInstance("ScreenGui", {
        Name = "SV_" .. title,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = getGuiParent()
    })

    -- Main window
    local main = newInstance("Frame", {
        Name = "Main",
        Size = UDim2.new(0, 620, 0, 420),
        Position = UDim2.new(0.5, -310, 0.5, -210),
        BackgroundColor3 = T.Background,
        BorderSizePixel = 0,
        Active = true,
        Parent = gui
    })
    corner(main, 12)
    stroke(main, T.Outline, 1)

    -- Top bar
    local topBar = newInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = T.Sidebar,
        BorderSizePixel = 0,
        Parent = main
    })
    corner(topBar, 12)
    -- Square bottom corners of topbar
    newInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 1, -12),
        BackgroundColor3 = T.Sidebar,
        BorderSizePixel = 0,
        Parent = topBar
    })

    newInstance("TextLabel", {
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = "  " .. title,
        TextColor3 = T.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = topBar
    })

    local function iconBtn(emoji, xPos, hoverColor, callback)
        local btn = newInstance("TextButton", {
            Size = UDim2.new(0, 28, 0, 28),
            Position = UDim2.new(1, xPos, 0, 6),
            BackgroundColor3 = T.Card,
            Text = emoji,
            TextColor3 = T.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Parent = topBar
        })
        corner(btn, 6)
        btn.MouseEnter:Connect(function()
            tween(btn, 0.15, { BackgroundColor3 = hoverColor })
        end)
        btn.MouseLeave:Connect(function()
            tween(btn, 0.15, { BackgroundColor3 = T.Card })
        end)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    local closeBtn = iconBtn("X", -36, T.Danger, function()
        gui:Destroy()
    end)

    local minBtn = iconBtn("-", -70, T.Accent, function() end)

    -- Sidebar
    local sidebar = newInstance("Frame", {
        Size = UDim2.new(0, 150, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = T.Sidebar,
        BorderSizePixel = 0,
        Parent = main
    })

    local sidebarLayout = newInstance("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = sidebar
    })
    padding(sidebar, 8)

    -- Content area
    local content = newInstance("Frame", {
        Size = UDim2.new(1, -150, 1, -40),
        Position = UDim2.new(0, 150, 0, 40),
        BackgroundTransparency = 1,
        Parent = main
    })

    -- Window object
    local self = setmetatable({}, Window)
    self.Gui = gui
    self.Main = main
    self.Sidebar = sidebar
    self.Content = content
    self.Theme = T
    self.Tabs = {}
    self.ActiveTab = nil

    -- Minimize
    local minimized = false
    local normalSize = UDim2.new(0, 620, 0, 420)
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            tween(main, 0.25, { Size = UDim2.new(0, 620, 0, 40) })
            minBtn.Text = "+"
        else
            tween(main, 0.25, { Size = normalSize })
            minBtn.Text = "-"
        end
    end)

    -- ==================== DRAG ====================
    local dragging, dragStart, startPos
    local function beginDrag(input)
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            beginDrag(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- ==================== TAB CREATION ====================
    function self:CreateTab(name, icon)
        icon = icon or "•"
        local tabBtn = newInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, 34),
            BackgroundColor3 = T.Sidebar,
            Text = "",
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Parent = sidebar
        })
        corner(tabBtn, 6)

        local accent = newInstance("Frame", {
            Size = UDim2.new(0, 3, 0, 0),
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = T.Accent,
            BorderSizePixel = 0,
            Parent = tabBtn
        })
        corner(accent, 2)

        newInstance("TextLabel", {
            Size = UDim2.new(1, -20, 1, 0),
            Position = UDim2.new(0, 14, 0, 0),
            BackgroundTransparency = 1,
            Text = icon .. "   " .. name,
            TextColor3 = T.SubText,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tabBtn
        })

        -- Content page
        local page = newInstance("ScrollingFrame", {
            Size = UDim2.new(1, -16, 1, -16),
            Position = UDim2.new(0, 8, 0, 8),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = T.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
            Parent = content
        })

        local pageLayout = newInstance("UIListLayout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = page
        })

        local Tab = {}
        Tab.Page = page
        Tab.Layout = pageLayout
        Tab.Button = tabBtn
        Tab.Accent = accent
        Tab.Theme = T
        Tab.Library = self

        -- Select function
        local function selectThis()
            for _, otherTab in pairs(self.Tabs) do
                otherTab.Page.Visible = false
                otherTab.Button.BackgroundColor3 = T.Sidebar
                tween(otherTab.Accent, 0.2, { Size = UDim2.new(0, 3, 0, 0) })
                for _, c in ipairs(otherTab.Button:GetChildren()) do
                    if c:IsA("TextLabel") then
                        tween(c, 0.2, { TextColor3 = T.SubText })
                    end
                end
            end
            page.Visible = true
            tween(tabBtn, 0.2, { BackgroundColor3 = T.Card })
            tween(accent, 0.2, { Size = UDim2.new(0, 3, 1, -16) })
            for _, c in ipairs(tabBtn:GetChildren()) do
                if c:IsA("TextLabel") then
                    tween(c, 0.2, { TextColor3 = T.Text })
                end
            end
            self.ActiveTab = Tab
        end

        tabBtn.MouseButton1Click:Connect(selectThis)
        tabBtn.MouseEnter:Connect(function()
            if self.ActiveTab ~= Tab then
                tween(tabBtn, 0.15, { BackgroundColor3 = T.CardHover })
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if self.ActiveTab ~= Tab then
                tween(tabBtn, 0.15, { BackgroundColor3 = T.Sidebar })
            end
        end)

        self.Tabs[name] = Tab

        if not self.ActiveTab then selectThis() end
        return Tab
    end

    -- ==================== COMPONENTS ====================
    local function createCard(parent, height)
        local card = newInstance("Frame", {
            Size = UDim2.new(1, 0, 0, height or 38),
            BackgroundColor3 = T.Card,
            BorderSizePixel = 0,
            Parent = parent
        })
        corner(card, 8)
        stroke(card, T.Outline, 1)
        return card
    end

    -- Toggle
    function Tab:CreateToggle(cfg)
        local card = createCard(self.Page, 38)
        newInstance("TextLabel", {
            Size = UDim2.new(1, -60, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            BackgroundTransparency = 1,
            Text = cfg.Name or "Toggle",
            TextColor3 = T.Text,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = card
        })

        local track = newInstance("Frame", {
            Size = UDim2.new(0, 38, 0, 20),
            Position = UDim2.new(1, -48, 0.5, -10),
            BackgroundColor3 = cfg.Default and T.Accent or T.ToggleOff,
            BorderSizePixel = 0,
            Parent = card
        })
        corner(track, 10)

        local knob = newInstance("Frame", {
            Size = UDim2.new(0, 16, 0, 16),
            Position = cfg.Default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            Parent = track
        })
        corner(knob, 8)

        local state = cfg.Default or false
        local btn = newInstance("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "",
            Parent = card
        })

        btn.MouseButton1Click:Connect(function()
            state = not state
            tween(track, 0.2, { BackgroundColor3 = state and T.Accent or T.ToggleOff })
            tween(knob, 0.2, {
                Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            })
            if cfg.Callback then
                pcall(cfg.Callback, state)
            end
        end)
        return card
    end

    -- Button
    function Tab:CreateButton(cfg)
        local btn = newInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = T.Card,
            Text = cfg.Name or "Button",
            TextColor3 = T.Text,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Parent = self.Page
        })
        corner(btn, 8)
        stroke(btn, T.Outline, 1)

        btn.MouseEnter:Connect(function()
            tween(btn, 0.15, { BackgroundColor3 = T.CardHover })
        end)
        btn.MouseLeave:Connect(function()
            tween(btn, 0.15, { BackgroundColor3 = T.Card })
        end)
        btn.MouseButton1Click:Connect(function()
            if cfg.Callback then pcall(cfg.Callback) end
        end)
        return btn
    end

    -- Slider
    function Tab:CreateSlider(cfg)
        local card = createCard(self.Page, 56)

        newInstance("TextLabel", {
            Size = UDim2.new(1, -20, 0, 18),
            Position = UDim2.new(0, 12, 0, 6),
            BackgroundTransparency = 1,
            Text = cfg.Name or "Slider",
            TextColor3 = T.Text,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = card
        })

        local valueLbl = newInstance("TextLabel", {
            Size = UDim2.new(0, 60, 0, 18),
            Position = UDim2.new(1, -72, 0, 6),
            BackgroundTransparency = 1,
            Text = tostring(cfg.Default or cfg.Min or 0),
            TextColor3 = T.Accent,
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Right,
            Parent = card
        })

        local track = newInstance("Frame", {
            Size = UDim2.new(1, -24, 0, 6),
            Position = UDim2.new(0, 12, 0, 34),
            BackgroundColor3 = T.ToggleOff,
            BorderSizePixel = 0,
            Parent = card
        })
        corner(track, 3)

        local min = cfg.Min or 0
        local max = cfg.Max or 100
        local value = cfg.Default or min
        local ratio = (value - min) / (max - min)

        local fill = newInstance("Frame", {
            Size = UDim2.new(ratio, 0, 1, 0),
            BackgroundColor3 = T.Accent,
            BorderSizePixel = 0,
            Parent = track
        })
        corner(fill, 3)

        local knob = newInstance("Frame", {
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(ratio, -7, 0.5, -7),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            ZIndex = 2,
            Parent = track
        })
        corner(knob, 7)

        local dragging = false
        local function update(input)
            local pos = math.clamp(
                (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1
            )
            value = math.floor(min + (max - min) * pos + 0.5)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            knob.Position = UDim2.new(pos, -7, 0.5, -7)
            valueLbl.Text = tostring(value)
            if cfg.Callback then pcall(cfg.Callback, value) end
        end

        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                update(input)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
                update(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        return card
    end

    -- Dropdown
    function Tab:CreateDropdown(cfg)
        local options = cfg.Options or {}
        local multi = cfg.Multi or false
        local selected = {}
        if cfg.Default then
            if type(cfg.Default) == "table" then selected = cfg.Default
            else selected = { cfg.Default } end
        end

        local card = createCard(self.Page, 38)
        local header = newInstance("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "",
            Parent = card
        })

        newInstance("TextLabel", {
            Size = UDim2.new(1, -80, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            BackgroundTransparency = 1,
            Text = cfg.Name or "Dropdown",
            TextColor3 = T.Text,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = card
        })

        local arrow = newInstance("TextLabel", {
            Size = UDim2.new(0, 20, 1, 0),
            Position = UDim2.new(1, -32, 0, 0),
            BackgroundTransparency = 1,
            Text = "▼",
            TextColor3 = T.SubText,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            Parent = card
        })

        local list = newInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.new(0, 0, 1, 4),
            BackgroundColor3 = T.CardHover,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Visible = false,
            ZIndex = 5,
            Parent = card
        })
        corner(list, 8)
        stroke(list, T.Outline, 1)

        local listLayout = newInstance("UIListLayout", {
            Padding = UDim.new(0, 2),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = list
        })
        padding(list, 4)

        local open = false
        local function refreshSize()
            local count = #listLayout:GetChildren() - 1
            local h = math.min(count * 28 + 8, 150)
            tween(list, 0.2, { Size = UDim2.new(1, 0, 0, h) })
        end

        local function toggleOption(opt)
            if multi then
                local idx = table.find(selected, opt)
                if idx then table.remove(selected, idx)
                else table.insert(selected, opt) end
            else
                selected = { opt }
                open = false
                list.Visible = false
                arrow.Text = "▼"
                card.Size = UDim2.new(1, 0, 0, 38)
            end
            if cfg.Callback then
                pcall(cfg.Callback, multi and selected or selected[1])
            end
        end

        for i, opt in ipairs(options) do
            local optBtn = newInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 26),
                BackgroundColor3 = T.Card,
                Text = tostring(opt),
                TextColor3 = T.Text,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Parent = list
            })
            corner(optBtn, 4)
            optBtn.MouseEnter:Connect(function()
                tween(optBtn, 0.12, { BackgroundColor3 = T.Accent })
            end)
            optBtn.MouseLeave:Connect(function()
                tween(optBtn, 0.12, { BackgroundColor3 = T.Card })
            end)
            optBtn.MouseButton1Click:Connect(function()
                toggleOption(opt)
            end)
        end

        header.MouseButton1Click:Connect(function()
            open = not open
            list.Visible = open
            arrow.Text = open and "▲" or "▼"
            card.Size = UDim2.new(1, 0, 0, open and 38 or 38)
            if open then refreshSize() end
        end)
        return card
    end

    -- Input
    function Tab:CreateInput(cfg)
        local card = createCard(self.Page, 38)
        local input = newInstance("TextBox", {
            Size = UDim2.new(1, -20, 1, -12),
            Position = UDim2.new(0, 10, 0, 6),
            BackgroundColor3 = T.Background,
            Text = "",
            PlaceholderText = cfg.PlaceholderText or "Type here...",
            PlaceholderColor3 = T.SubText,
            TextColor3 = T.Text,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            BorderSizePixel = 0,
            ClearTextOnFocus = false,
            Parent = card
        })
        corner(input, 6)
        stroke(input, T.Outline, 1)
        padding(input, 6)

        if cfg.Name and cfg.Name ~= "" then
            input.PlaceholderText = cfg.Name .. " | " .. (cfg.PlaceholderText or "")
        end

        input.FocusLost:Connect(function(enter)
            if enter and cfg.Callback then
                pcall(cfg.Callback, input.Text)
                if cfg.RemoveTextAfter then input.Text = "" end
            end
        end)
        return card
    end

    -- Section
    function Tab:CreateSection(title)
        local sec = newInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 22),
            BackgroundTransparency = 1,
            Parent = self.Page
        })
        newInstance("TextLabel", {
            Size = UDim2.new(0.5, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "  " .. title,
            TextColor3 = T.Accent,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = sec
        })
        local line = newInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, -2),
            BackgroundColor3 = T.Outline,
            BorderSizePixel = 0,
            Parent = sec
        })
        return sec
    end

    -- Label
    function Tab:CreateLabel(text)
        return newInstance("TextLabel", {
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = T.SubText,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = self.Page
        })
    end

    -- Divider
    function Tab:CreateDivider()
        return newInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            BackgroundColor3 = T.Outline,
            BorderSizePixel = 0,
            Parent = self.Page
        })
    end

    return self
end

return Library
