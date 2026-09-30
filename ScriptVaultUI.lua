-- ==========================================
-- ScriptVault UI Library v1.0
-- Professional Roblox UI Library
-- GitHub: github.com/ScriptVault/UI-Library
-- Usage: local SV = loadstring(game:HttpGet("RAW_URL"))()
-- ==========================================

local ScriptVaultUI = {}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local LP = Players.LocalPlayer

-- ==========================================
-- CONFIGURATION
-- ==========================================

local Config = {
    WindowWidth = 720,
    WindowHeight = 480,
    SidebarWidth = 200,
    AnimationsEnabled = true,
    DragSmoothness = 0.1,
    NotificationDuration = 5,
    Theme = {
        Background = Color3.fromRGB(18, 18, 28),
        Sidebar = Color3.fromRGB(22, 22, 35),
        TopBar = Color3.fromRGB(22, 22, 35),
        Element = Color3.fromRGB(28, 28, 44),
        ElementHover = Color3.fromRGB(35, 35, 55),
        Accent = Color3.fromRGB(0, 120, 255),
        AccentHover = Color3.fromRGB(0, 140, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextMuted = Color3.fromRGB(160, 160, 180),
        TextDark = Color3.fromRGB(120, 120, 140),
        ToggleOn = Color3.fromRGB(0, 150, 255),
        ToggleOff = Color3.fromRGB(50, 50, 70),
        Button = Color3.fromRGB(0, 110, 220),
        ButtonHover = Color3.fromRGB(0, 130, 255),
        Success = Color3.fromRGB(0, 200, 100),
        Warning = Color3.fromRGB(220, 160, 0),
        Error = Color3.fromRGB(220, 50, 50),
        Slider = Color3.fromRGB(40, 40, 60),
        SliderFill = Color3.fromRGB(0, 130, 255),
        Dropdown = Color3.fromRGB(30, 30, 48),
        DropdownHover = Color3.fromRGB(45, 45, 70),
        Input = Color3.fromRGB(35, 35, 55),
        InputFocus = Color3.fromRGB(40, 40, 65),
        Border = Color3.fromRGB(0, 120, 255),
        Separator = Color3.fromRGB(40, 40, 60),
    }
}

-- ==========================================
-- UTILITY FUNCTIONS
-- ==========================================

local function Create(instanceType, properties, parent)
    local instance = Instance.new(instanceType)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    if parent then
        instance.Parent = parent
    end
    return instance
end

local function LerpColor(color1, color2, alpha)
    return Color3.new(
        color1.R + (color2.R - color1.R) * alpha,
        color1.G + (color2.G - color1.G) * alpha,
        color1.B + (color2.B - color1.B) * alpha
    )
end

local function Animate(instance, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(duration, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

-- ==========================================
-- MAIN LIBRARY
-- ==========================================

function ScriptVaultUI:CreateWindow(options)
    options = options or {}
    local WindowName = options.Name or "SCRIPTVAULT - AUTO FARM SCRIPTS"
    local LoadingTitle = options.LoadingTitle or "ScriptVault"
    local LoadingSubtitle = options.LoadingSubtitle or "Auto Farm Scripts"
    local Theme = options.Theme or "DarkBlue"
    
    local Colors = Config.Theme
    
    -- ScreenGui
    local ScreenGui = Create("ScreenGui", {
        Name = "ScriptVaultUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = LP.PlayerGui
    })
    
    -- ==========================================
    -- LOADING SCREEN
    -- ==========================================
    local LoadingFrame = Create("Frame", {
        Size = UDim2.new(0, 350, 0, 200),
        Position = UDim2.new(0.5, -175, 0.5, -100),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        ZIndex = 100,
        Parent = ScreenGui
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 12)}, LoadingFrame)
    Create("UIStroke", {Color = Colors.Accent, Thickness = 2}, LoadingFrame)
    
    -- Loading Logo
    local LoadLogo = Create("Frame", {
        Size = UDim2.new(0, 70, 0, 70),
        Position = UDim2.new(0.5, -35, 0, 25),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
        Parent = LoadingFrame
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0)}, LoadLogo)
    
    -- Loading Ripple Animation
    for i = 1, 3 do
        local Ripple = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Colors.Accent,
            BackgroundTransparency = 0.6,
            BorderSizePixel = 0,
            Parent = LoadLogo
        })
        Create("UICorner", {CornerRadius = UDim.new(1, 0)}, Ripple)
        
        task.spawn(function()
            while Ripple.Parent do
                for j = 1, 1.6, 0.02 do
                    Ripple.Size = UDim2.new(j, 0, j, 0)
                    Ripple.Position = UDim2.new(0.5 - j/2, 0, 0.5 - j/2, 0)
                    Ripple.BackgroundTransparency = 0.4 + (j - 1) * 0.5
                    task.wait(0.02)
                end
                task.wait(0.3)
            end
        end)
    end
    
    -- SV Logo Text
    local LoadLogoText = Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "SV",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 32,
        Font = Enum.Font.GothamBlack,
        Parent = LoadLogo
    })
    
    -- Loading Title
    local LoadTitle = Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 25),
        Position = UDim2.new(0, 0, 0, 105),
        BackgroundTransparency = 1,
        Text = LoadingTitle,
        TextColor3 = Colors.Text,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = LoadingFrame
    })
    
    -- Loading Subtitle
    local LoadSub = Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 0, 0, 130),
        BackgroundTransparency = 1,
        Text = LoadingSubtitle,
        TextColor3 = Colors.Accent,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        Parent = LoadingFrame
    })
    
    -- Loading Bar Background
    local LoadBarBg = Create("Frame", {
        Size = UDim2.new(0.7, 0, 0, 6),
        Position = UDim2.new(0.15, 0, 0, 160),
        BackgroundColor3 = Colors.ToggleOff,
        BorderSizePixel = 0,
        Parent = LoadingFrame
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0)}, LoadBarBg)
    
    -- Loading Bar Fill
    local LoadBarFill = Create("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
        Parent = LoadBarBg
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0)}, LoadBarFill)
    
    -- Animate Loading Bar
    task.spawn(function()
        for i = 0, 1, 0.02 do
            LoadBarFill.Size = UDim2.new(i * 0.7, 0, 1, 0)
            task.wait(0.02)
        end
        task.wait(0.3)
        
        -- Fade out loading screen
        Animate(LoadingFrame, {
            Position = UDim2.new(0.5, -175, 0.5, -150),
            BackgroundTransparency = 1
        }, 0.3)
        
        for _, child in ipairs(LoadingFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                Animate(child, {BackgroundTransparency = 1, TextTransparency = 1}, 0.3)
            end
        end
        
        task.wait(0.3)
        LoadingFrame:Destroy()
    end)
    
    -- ==========================================
    -- MAIN WINDOW
    -- ==========================================
    local Window = Create("Frame", {
        Name = "Window",
        Size = UDim2.new(0, Config.WindowWidth, 0, Config.WindowHeight),
        Position = UDim2.new(0.5, -Config.WindowWidth/2, 0.5, -Config.WindowHeight/2),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        Active = true,
        Visible = false,
        Parent = ScreenGui
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10)}, Window)
    Create("UIStroke", {Color = Colors.Border, Thickness = 1.5}, Window)
    
    -- Show window after loading
    task.delay(1.2, function()
        Window.Visible = true
        Animate(Window, {Position = UDim2.new(0.5, -Config.WindowWidth/2, 0.5, -Config.WindowHeight/2)}, 0.4, Enum.EasingStyle.Back)
    end)
    
    -- ==========================================
    -- TOP BAR
    -- ==========================================
    local TopBar = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Colors.TopBar,
        BorderSizePixel = 0,
        Parent = Window
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10, 0, 10)}, TopBar)
    
    -- Window Title
    local Title = Create("TextLabel", {
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = WindowName,
        TextColor3 = Colors.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = TopBar
    })
    
    -- Minimize Button
    local MinBtn = Create("TextButton", {
        Size = UDim2.new(0, 32, 0, 28),
        Position = UDim2.new(1, -72, 0, 7),
        BackgroundColor3 = Colors.Warning,
        BorderSizePixel = 0,
        Text = "—",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        Font = Enum.Font.GothamBlack,
        Parent = TopBar
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 5)}, MinBtn)
    
    -- Close Button
    local CloseBtn = Create("TextButton", {
        Size = UDim2.new(0, 32, 0, 28),
        Position = UDim2.new(1, -36, 0, 7),
        BackgroundColor3 = Colors.Error,
        BorderSizePixel = 0,
        Text = "✕",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBlack,
        Parent = TopBar
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 5)}, CloseBtn)
    
    -- ==========================================
    -- SIDEBAR
    -- ==========================================
    local Sidebar = Create("Frame", {
        Size = UDim2.new(0, Config.SidebarWidth, 1, -42),
        Position = UDim2.new(0, 0, 0, 42),
        BackgroundColor3 = Colors.Sidebar,
        BorderSizePixel = 0,
        Parent = Window
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 0, 0, 10)}, Sidebar)
    
    -- Separator Line
    Create("Frame", {
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = Colors.Separator,
        BorderSizePixel = 0,
        Parent = Sidebar
    })
    
    -- Logo Area
    local LogoArea = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 140),
        BackgroundTransparency = 1,
        Parent = Sidebar
    })
    
    -- Logo Circle
    local LogoCircle = Create("Frame", {
        Size = UDim2.new(0, 80, 0, 80),
        Position = UDim2.new(0.5, -40, 0, 10),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
        Parent = LogoArea
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0)}, LogoCircle)
    
    -- Logo Ripple Animation
    for i = 1, 3 do
        local Ripple = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Colors.Accent,
            BackgroundTransparency = 0.6,
            BorderSizePixel = 0,
            Parent = LogoCircle
        })
        Create("UICorner", {CornerRadius = UDim.new(1, 0)}, Ripple)
        
        task.spawn(function()
            while Ripple.Parent do
                for j = 1, 1.6, 0.02 do
                    Ripple.Size = UDim2.new(j, 0, j, 0)
                    Ripple.Position = UDim2.new(0.5 - j/2, 0, 0.5 - j/2, 0)
                    Ripple.BackgroundTransparency = 0.4 + (j - 1) * 0.5
                    task.wait(0.02)
                end
                task.wait(0.4)
            end
        end)
    end
    
    -- SV Text
    Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "SV",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 36,
        Font = Enum.Font.GothamBlack,
        Parent = LogoCircle
    })
    
    -- Game Title
    Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 22),
        Position = UDim2.new(0, 0, 0, 95),
        BackgroundTransparency = 1,
        Text = WindowName,
        TextColor3 = Colors.Text,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = LogoArea
    })
    
    -- Version Label
    Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 0, 115),
        BackgroundTransparency = 1,
        Text = "v1.0",
        TextColor3 = Colors.Accent,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = LogoArea
    })
    
    -- Author Label
    Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 0, 130),
        BackgroundTransparency = 1,
        Text = "by ScriptVault",
        TextColor3 = Colors.TextDark,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = LogoArea
    })
    
    -- Tab Buttons Container
    local TabList = Create("Frame", {
        Size = UDim2.new(1, -10, 1, -150),
        Position = UDim2.new(0, 5, 0, 145),
        BackgroundTransparency = 1,
        Parent = Sidebar
    })
    Create("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = TabList
    })
    
    -- ==========================================
    -- CONTENT AREA
    -- ==========================================
    local ContentArea = Create("Frame", {
        Size = UDim2.new(1, -Config.SidebarWidth, 1, -42),
        Position = UDim2.new(0, Config.SidebarWidth, 0, 42),
        BackgroundColor3 = Colors.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = Window
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 0, 10, 0)}, ContentArea)
    
    -- ==========================================
    -- NOTIFICATION SYSTEM (Bottom Right)
    -- ==========================================
    local NotifyContainer = Create("Frame", {
        Name = "NotifyContainer",
        Size = UDim2.new(0, 320, 0, 0),
        Position = UDim2.new(1, -340, 1, -20),
        BackgroundTransparency = 1,
        Parent = ScreenGui
    })
    Create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Parent = NotifyContainer
    })
    
    -- Notification Function
    local function Notify(options)
        options = options or {}
        local Title = options.Title or "Notification"
        local Content = options.Content or ""
        local Duration = options.Duration or Config.NotificationDuration
        local Type = options.Type or "Info"
        
        local TypeColors = {
            Info = Colors.Accent,
            Success = Colors.Success,
            Warning = Colors.Warning,
            Error = Colors.Error,
        }
        
        local TypeIcons = {
            Info = "ℹ",
            Success = "✓",
            Warning = "⚠",
            Error = "✕",
        }
        
        local ContentLines = #Content > 30 and 2 or 1
        local NotifyHeight = 60 + (ContentLines - 1) * 18
        
        -- Notification Frame
        local Notify = Create("Frame", {
            Size = UDim2.new(0, 320, 0, 0),
            BackgroundColor3 = Colors.Element,
            BorderSizePixel = 0,
            LayoutOrder = 1,
            Parent = NotifyContainer
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 8)}, Notify)
        Create("UIStroke", {Color = TypeColors[Type], Thickness = 1.5}, Notify)
        
        -- Color Bar
        Create("Frame", {
            Size = UDim2.new(0, 4, 1, -16),
            Position = UDim2.new(0, 0, 0, 8),
            BackgroundColor3 = TypeColors[Type],
            BorderSizePixel = 0,
            Parent = Notify
        })
        
        -- Icon
        Create("TextLabel", {
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(0, 14, 0, 10),
            BackgroundTransparency = 1,
            Text = TypeIcons[Type],
            TextColor3 = TypeColors[Type],
            TextSize = 18,
            Font = Enum.Font.GothamBold,
            Parent = Notify
        })
        
        -- Title
        Create("TextLabel", {
            Size = UDim2.new(1, -50, 0, 20),
            Position = UDim2.new(0, 44, 0, 8),
            BackgroundTransparency = 1,
            Text = Title,
            TextColor3 = Colors.Text,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = Notify
        })
        
        -- Content
        Create("TextLabel", {
            Size = UDim2.new(1, -50, 0, ContentLines * 18),
            Position = UDim2.new(0, 44, 0, 28),
            BackgroundTransparency = 1,
            Text = Content,
            TextColor3 = Colors.TextMuted,
            TextSize = 12,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            Parent = Notify
        })
        
        -- Progress Bar Background
        local ProgressBg = Create("Frame", {
            Size = UDim2.new(1, -16, 0, 3),
            Position = UDim2.new(0, 8, 1, -8),
            BackgroundColor3 = Colors.ToggleOff,
            BorderSizePixel = 0,
            Parent = Notify
        })
        Create("UICorner", {CornerRadius = UDim.new(1, 0)}, ProgressBg)
        
        -- Progress Bar Fill
        local ProgressFill = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = TypeColors[Type],
            BorderSizePixel = 0,
            Parent = ProgressBg
        })
        Create("UICorner", {CornerRadius = UDim.new(1, 0)}, ProgressFill)
        
        -- Animate In
        Notify.Size = UDim2.new(0, 0, 0, 0)
        Animate(Notify, {Size = UDim2.new(0, 320, 0, NotifyHeight)}, 0.35, Enum.EasingStyle.Back)
        
        -- Animate Progress Bar
        task.spawn(function()
            local steps = Duration * 10
            for i = steps, 0, -1 do
                ProgressFill.Size = UDim2.new(i / steps, 0, 1, 0)
                task.wait(0.1)
            end
        end)
        
        -- Auto Dismiss
        task.delay(Duration, function()
            if Notify.Parent then
                Animate(Notify, {Size = UDim2.new(0, 320, 0, 0)}, 0.3, Enum.EasingStyle.Quad)
                task.wait(0.3)
                Notify:Destroy()
            end
        end)
        
        return Notify
    end
    
    -- ==========================================
    -- TAB SYSTEM
    -- ==========================================
    local Tabs = {}
    local TabContents = {}
    local CurrentTab = nil
    
    local function CreateTab(Name, IconID)
        -- Tab Button
        local TabBtn = Create("TextButton", {
            Name = Name,
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = Colors.Element,
            BorderSizePixel = 0,
            Text = "",
            LayoutOrder = #Tabs + 1,
            Parent = TabList
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 6)}, TabBtn)
        
        -- Active Indicator
        local Indicator = Create("Frame", {
            Name = "Indicator",
            Size = UDim2.new(0, 3, 0, 24),
            Position = UDim2.new(0, 0, 0.5, -12),
            BackgroundColor3 = Colors.Accent,
            BorderSizePixel = 0,
            Visible = false,
            Parent = TabBtn
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 3)}, Indicator)
        
        -- Icon
        local Icon = Create("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 22, 0, 22),
            Position = UDim2.new(0, 14, 0.5, -11),
            BackgroundTransparency = 1,
            Image = "rbxassetid://" .. tostring(IconID),
            ScaleType = Enum.ScaleType.Fit,
            ImageColor3 = Colors.TextMuted,
            Parent = TabBtn
        })
        
        -- Preload Icon
        pcall(function() ContentProvider:PreloadAsync({Icon}) end)
        
        -- Text
        Create("TextLabel", {
            Name = "Text",
            Size = UDim2.new(1, -45, 0, 20),
            Position = UDim2.new(0, 44, 0.5, -10),
            BackgroundTransparency = 1,
            Text = Name,
            TextColor3 = Colors.TextMuted,
            TextSize = 13,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = TabBtn
        })
        
        -- Content (ScrollingFrame)
        local Content = Create("ScrollingFrame", {
            Name = Name,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Colors.Accent,
            BorderSizePixel = 0,
            Parent = ContentArea
        })
        Create("UIListLayout", {
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = Content
        })
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            Parent = Content
        })
        
        -- Tab Click Event
        TabBtn.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.BackgroundColor3 = Colors.Element
                local oldInd = CurrentTab:FindFirstChild("Indicator")
                if oldInd then oldInd.Visible = false end
                local oldIcon = CurrentTab:FindFirstChild("Icon")
                if oldIcon then oldIcon.ImageColor3 = Colors.TextMuted end
                local oldText = CurrentTab:FindFirstChild("Text")
                if oldText then oldText.TextColor3 = Colors.TextMuted end
            end
            
            CurrentTab = TabBtn
            TabBtn.BackgroundColor3 = Colors.ElementHover
            
            local ind = TabBtn:FindFirstChild("Indicator")
            if ind then ind.Visible = true end
            
            local icon = TabBtn:FindFirstChild("Icon")
            if icon then icon.ImageColor3 = Colors.Text end
            
            local text = TabBtn:FindFirstChild("Text")
            if text then text.TextColor3 = Colors.Text end
            
            for name, content in pairs(TabContents) do
                content.Visible = (name == Name)
            end
        end)
        
        -- Hover Effects
        TabBtn.MouseEnter:Connect(function()
            if CurrentTab ~= TabBtn then
                TabBtn.BackgroundColor3 = Colors.ElementHover
            end
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if CurrentTab ~= TabBtn then
                TabBtn.BackgroundColor3 = Colors.Element
            end
        end)
        
        table.insert(Tabs, TabBtn)
        TabContents[Name] = Content
        
        -- Return Tab Object with Element Creators
        return {
            CreateLabel = function(Text)
                local Label = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundTransparency = 1,
                    Text = Text,
                    TextColor3 = Colors.Text,
                    TextSize = 16,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Content
                })
                return Label
            end,
            
            CreateToggle = function(options)
                local Container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 44),
                    BackgroundColor3 = Colors.Element,
                    BorderSizePixel = 0,
                    Parent = Content
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 7)}, Container)
                
                local Btn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = Container
                })
                
                Create("TextLabel", {
                    Size = UDim2.new(1, -60, 1, 0),
                    Position = UDim2.new(0, 14, 0, 0),
                    BackgroundTransparency = 1,
                    Text = options.Name,
                    TextColor3 = Color3.fromRGB(220, 220, 230),
                    TextSize = 13,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Btn
                })
                
                local Track = Create("Frame", {
                    Size = UDim2.new(0, 44, 0, 24),
                    Position = UDim2.new(1, -54, 0.5, -12),
                    BackgroundColor3 = (options.CurrentValue or false) and Colors.ToggleOn or Colors.ToggleOff,
                    BorderSizePixel = 0,
                    Parent = Btn
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0)}, Track)
                
                local Knob = Create("Frame", {
                    Size = UDim2.new(0, 18, 0, 18),
                    Position = (options.CurrentValue or false) and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Parent = Track
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0)}, Knob)
                
                local Value = options.CurrentValue or false
                
                local function SetToggle(v)
                    Value = v
                    Animate(Knob, {Position = v and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}, 0.15)
                    Track.BackgroundColor3 = v and Colors.ToggleOn or Colors.ToggleOff
                    if options.Callback then options.Callback(v) end
                end
                
                Btn.MouseButton1Click:Connect(function() SetToggle(not Value) end)
                
                return Container
            end,
            
            CreateSlider = function(options)
                local Container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundColor3 = Colors.Element,
                    BorderSizePixel = 0,
                    Parent = Content
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 7)}, Container)
                
                Create("TextLabel", {
                    Size = UDim2.new(1, -70, 0, 20),
                    Position = UDim2.new(0, 14, 0, 8),
                    BackgroundTransparency = 1,
                    Text = options.Name,
                    TextColor3 = Color3.fromRGB(220, 220, 230),
                    TextSize = 13,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Container
                })
                
                local ValueLabel = Create("TextLabel", {
                    Size = UDim2.new(0, 55, 0, 20),
                    Position = UDim2.new(1, -65, 0, 8),
                    BackgroundTransparency = 1,
                    Text = tostring(options.CurrentValue or options.Range[1]),
                    TextColor3 = Colors.Accent,
                    TextSize = 13,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = Container
                })
                
                local Track = Create("Frame", {
                    Size = UDim2.new(1, -28, 0, 8),
                    Position = UDim2.new(0, 14, 1, -22),
                    BackgroundColor3 = Colors.Slider,
                    BorderSizePixel = 0,
                    Parent = Container
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0)}, Track)
                
                local Fill = Create("Frame", {
                    Size = UDim2.new((options.CurrentValue or options.Range[1] - options.Range[1]) / (options.Range[2] - options.Range[1]), 0, 1, 0),
                    BackgroundColor3 = Colors.SliderFill,
                    BorderSizePixel = 0,
                    Parent = Track
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0)}, Fill)
                
                local Knob = Create("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new((options.CurrentValue or options.Range[1] - options.Range[1]) / (options.Range[2] - options.Range[1]), -8, 0.5, -8),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    ZIndex = 5,
                    Parent = Track
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0)}, Knob)
                
                local Dragging = false
                
                local function Update(Input)
                    local RelX = Input.Position.X - Track.AbsolutePosition.X
                    local Pos = math.clamp(RelX / Track.AbsoluteSize.X, 0, 1)
                    Knob.Position = UDim2.new(Pos, -8, 0.5, -8)
                    Fill.Size = UDim2.new(Pos, 0, 1, 0)
                    local Val = math.floor(Pos * (options.Range[2] - options.Range[1]) + options.Range[1])
                    ValueLabel.Text = tostring(Val)
                    if options.Callback then options.Callback(Val) end
                end
                
                Knob.InputBegan:Connect(function(I)
                    if I.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = true
                    end
                end)
                
                Knob.InputEnded:Connect(function(I)
                    if I.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(I)
                    if Dragging and I.UserInputType == Enum.UserInputType.MouseMovement then
                        Update(I)
                    end
                end)
                
                return Container
            end,
            
            CreateDropdown = function(options)
                local Container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 65),
                    BackgroundColor3 = Colors.Element,
                    BorderSizePixel = 0,
                    Parent = Content
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 7)}, Container)
                
                Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    Position = UDim2.new(0, 14, 0, 6),
                    BackgroundTransparency = 1,
                    Text = options.Name,
                    TextColor3 = Color3.fromRGB(220, 220, 230),
                    TextSize = 13,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Container
                })
                
                local DropBtn = Create("TextButton", {
                    Size = UDim2.new(1, -28, 0, 32),
                    Position = UDim2.new(0, 14, 0, 28),
                    BackgroundColor3 = Colors.ElementHover,
                    BorderSizePixel = 0,
                    Text = "",
                    Parent = Container
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6)}, DropBtn)
                
                local SelText = Create("TextLabel", {
                    Size = UDim2.new(1, -30, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = options.CurrentOption or options.Options[1],
                    TextColor3 = Colors.Text,
                    TextSize = 13,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = DropBtn
                })
                
                Create("TextLabel", {
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -22, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Colors.TextDark,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    Parent = DropBtn
                })
                
                local DropList = Create("Frame", {
                    Size = UDim2.new(1, -28, 0, 0),
                    Position = UDim2.new(0, 14, 1, -32),
                    BackgroundColor3 = Colors.Dropdown,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 10,
                    Parent = Container
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6)}, DropList)
                Create("UIListLayout", {Parent = DropList})
                
                local Open = false
                
                for _, Opt in ipairs(options.Options) do
                    local OptBtn = Create("TextButton", {
                        Size = UDim2.new(1, 0, 0, 32),
                        BackgroundColor3 = Colors.ElementHover,
                        BorderSizePixel = 0,
                        Text = Opt,
                        TextColor3 = Color3.fromRGB(200, 200, 210),
                        TextSize = 12,
                        Font = Enum.Font.GothamMedium,
                        ZIndex = 11,
                        Parent = DropList
                    })
                    
                    OptBtn.MouseEnter:Connect(function()
                        OptBtn.BackgroundColor3 = Colors.DropdownHover
                    end)
                    
                    OptBtn.MouseLeave:Connect(function()
                        OptBtn.BackgroundColor3 = Colors.ElementHover
                    end)
                    
                    OptBtn.MouseButton1Click:Connect(function()
                        SelText.Text = Opt
                        Open = false
                        Animate(DropList, {Size = UDim2.new(1, -28, 0, 0)}, 0.15)
                        task.wait(0.15)
                        DropList.Visible = false
                        if options.Callback then options.Callback(Opt) end
                    end)
                end
                
                DropBtn.MouseButton1Click:Connect(function()
                    Open = not Open
                    if Open then
                        DropList.Visible = true
                        Animate(DropList, {Size = UDim2.new(1, -28, 0, #options.Options * 32)}, 0.15)
                    else
                        Animate(DropList, {Size = UDim2.new(1, -28, 0, 0)}, 0.15)
                        task.wait(0.15)
                        DropList.Visible = false
                    end
                end)
                
                return Container
            end,
            
            CreateButton = function(options)
                local Btn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Colors.Button,
                    BorderSizePixel = 0,
                    Text = options.Name,
                    TextColor3 = Colors.Text,
                    TextSize = 13,
                    Font = Enum.Font.GothamBold,
                    Parent = Content
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 7)}, Btn)
                
                Btn.MouseEnter:Connect(function()
                    Btn.BackgroundColor3 = Colors.ButtonHover
                end)
                
                Btn.MouseLeave:Connect(function()
                    Btn.BackgroundColor3 = Colors.Button
                end)
                
                Btn.MouseButton1Click:Connect(function()
                    if options.Callback then options.Callback() end
                end)
                
                return Btn
            end,
            
            CreateParagraph = function(options)
                local Container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 120),
                    BackgroundColor3 = Colors.Element,
                    BorderSizePixel = 0,
                    Parent = Content
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 7)}, Container)
                
                Create("TextLabel", {
                    Size = UDim2.new(1, -20, 0, 25),
                    Position = UDim2.new(0, 10, 0, 10),
                    BackgroundTransparency = 1,
                    Text = options.Title,
                    TextColor3 = Colors.Text,
                    TextSize = 15,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Container
                })
                
                Create("TextLabel", {
                    Size = UDim2.new(1, -20, 1, -40),
                    Position = UDim2.new(0, 10, 0, 35),
                    BackgroundTransparency = 1,
                    Text = options.Content,
                    TextColor3 = Colors.TextMuted,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                    Parent = Container
                })
                
                return Container
            end,
            
            CreateInput = function(options)
                local Container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 45),
                    BackgroundColor3 = Colors.Element,
                    BorderSizePixel = 0,
                    Parent = Content
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 7)}, Container)
                
                Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    Position = UDim2.new(0, 14, 0, 5),
                    BackgroundTransparency = 1,
                    Text = options.Name,
                    TextColor3 = Color3.fromRGB(220, 220, 230),
                    TextSize = 13,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Container
                })
                
                local InputBox = Create("TextBox", {
                    Size = UDim2.new(1, -28, 0, 30),
                    Position = UDim2.new(0, 14, 0, 25),
                    BackgroundColor3 = Colors.Input,
                    BorderSizePixel = 0,
                    Text = options.Default or "",
                    TextColor3 = Colors.Text,
                    TextSize = 13,
                    Font = Enum.Font.Gotham,
                    PlaceholderText = options.Placeholder or "",
                    PlaceholderColor3 = Colors.TextMuted,
                    Parent = Container
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6)}, InputBox)
                
                InputBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed and options.Callback then
                        options.Callback(InputBox.Text)
                    end
                end)
                
                InputBox.Focused:Connect(function()
                    InputBox.BackgroundColor3 = Colors.InputFocus
                end)
                
                InputBox.FocusLost:Connect(function()
                    InputBox.BackgroundColor3 = Colors.Input
                end)
                
                return Container
            end,
            
            CreateColorPicker = function(options)
                local Container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 45),
                    BackgroundColor3 = Colors.Element,
                    BorderSizePixel = 0,
                    Parent = Content
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 7)}, Container)
                
                Create("TextLabel", {
                    Size = UDim2.new(1, -50, 0, 20),
                    Position = UDim2.new(0, 14, 0, 12),
                    BackgroundTransparency = 1,
                    Text = options.Name,
                    TextColor3 = Color3.fromRGB(220, 220, 230),
                    TextSize = 13,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Container
                })
                
                local ColorPreview = Create("Frame", {
                    Size = UDim2.new(0, 30, 0, 30),
                    Position = UDim2.new(1, -44, 0, 7),
                    BackgroundColor3 = options.Default or Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Parent = Container
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6)}, ColorPreview)
                
                local ColorBtn = Create("TextButton", {
                    Size = UDim2.new(0, 30, 0, 30),
                    Position = UDim2.new(1, -44, 0, 7),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = Container
                })
                
                ColorBtn.MouseButton1Click:Connect(function()
                    -- Simple color picker simulation
                    local r = math.random(0, 255)
                    local g = math.random(0, 255)
                    local b = math.random(0, 255)
                    local newColor = Color3.fromRGB(r, g, b)
                    ColorPreview.BackgroundColor3 = newColor
                    if options.Callback then options.Callback(newColor) end
                end)
                
                return Container
            end,
            
            CreateKeybind = function(options)
                local Container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 45),
                    BackgroundColor3 = Colors.Element,
                    BorderSizePixel = 0,
                    Parent = Content
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 7)}, Container)
                
                Create("TextLabel", {
                    Size = UDim2.new(1, -60, 0, 20),
                    Position = UDim2.new(0, 14, 0, 12),
                    BackgroundTransparency = 1,
                    Text = options.Name,
                    TextColor3 = Color3.fromRGB(220, 220, 230),
                    TextSize = 13,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Container
                })
                
                local KeyText = Create("TextLabel", {
                    Size = UDim2.new(0, 50, 0, 25),
                    Position = UDim2.new(1, -58, 0, 10),
                    BackgroundColor3 = Colors.Input,
                    BorderSizePixel = 0,
                    Text = options.Default or "None",
                    TextColor3 = Colors.Text,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    Parent = Container
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6)}, KeyText)
                
                local Recording = false
                
                KeyText.MouseButton1Click:Connect(function()
                    Recording = true
                    KeyText.Text = "..."
                    
                    local conn
                    conn = UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            KeyText.Text = input.KeyCode.Name
                            Recording = false
                            conn:Disconnect()
                            if options.Callback then options.Callback(input.KeyCode) end
                        end
                    end)
                end)
                
                return Container
            end
        }
    end
    
    -- ==========================================
    -- DRAGGABLE FUNCTIONALITY
    -- ==========================================
    local Dragging = false
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil
    
    TopBar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = Input.Position
            StartPosition = Window.Position
            
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement then
            DragInput = Input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging then
            local Delta = Input.Position - DragStart
            Window.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        end
    end)
    
    -- ==========================================
    -- MINIMIZE/RESTORE
    -- ==========================================
    local isMinimized = false
    
    local MinIcon = Create("TextButton", {
        Size = UDim2.new(0, 65, 0, 65),
        Position = UDim2.new(1, -85, 0.5, -32),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0,
        Text = "SV",
        TextColor3 = Colors.Text,
        TextSize = 26,
        Font = Enum.Font.GothamBlack,
        Visible = false,
        Parent = ScreenGui
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0)}, MinIcon)
    Create("UIStroke", {Color = Colors.AccentHover, Thickness = 2}, MinIcon)
    
    -- Minimize Icon Ripple
    for i = 1, 2 do
        local R = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Colors.Accent,
            BackgroundTransparency = 0.6,
            BorderSizePixel = 0,
            Parent = MinIcon
        })
        Create("UICorner", {CornerRadius = UDim.new(1, 0)}, R)
        
        task.spawn(function()
            while R.Parent do
                for j = 1, 1.5, 0.02 do
                    R.Size = UDim2.new(j, 0, j, 0)
                    R.Position = UDim2.new(0.5 - j/2, 0, 0.5 - j/2, 0)
                    R.BackgroundTransparency = 0.4 + (j - 1) * 0.6
                    task.wait(0.02)
                end
                task.wait(0.4)
            end
        end)
    end
    
    local function Minimize()
        if isMinimized then return end
        isMinimized = true
        
        Animate(Window, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(1, -85, 0.5, -32)
        }, 0.25)
        
        task.wait(0.25)
        Window.Visible = false
        MinIcon.Visible = true
        
        MinIcon.Size = UDim2.new(0, 0, 0, 0)
        Animate(MinIcon, {Size = UDim2.new(0, 65, 0, 65)}, 0.35, Enum.EasingStyle.Back)
    end
    
    local function Restore()
        if not isMinimized then return end
        isMinimized = false
        
        Animate(MinIcon, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
        
        task.wait(0.2)
        MinIcon.Visible = false
        
        Window.Visible = true
        Window.Size = UDim2.new(0, 0, 0, 0)
        Window.Position = UDim2.new(1, -85, 0.5, -32)
        
        Animate(Window, {
            Size = UDim2.new(0, Config.WindowWidth, 0, Config.WindowHeight),
            Position = UDim2.new(0.5, -Config.WindowWidth/2, 0.5, -Config.WindowHeight/2)
        }, 0.35, Enum.EasingStyle.Back)
    end
    
    MinBtn.MouseButton1Click:Connect(Minimize)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    MinIcon.MouseButton1Click:Connect(Restore)
    
    -- Close with RightShift
    UserInputService.InputBegan:Connect(function(Input)
        if Input.KeyCode == Enum.KeyCode.RightShift then
            ScreenGui:Destroy()
        end
    end)
    
    -- ==========================================
    -- RETURN WINDOW OBJECT
    -- ==========================================
    return {
        CreateTab = CreateTab,
        Notify = Notify,
        Destroy = function() ScreenGui:Destroy() end,
        Minimize = Minimize,
        Restore = Restore,
        GetWindow = function() return Window end,
        GetSidebar = function() return Sidebar end,
        GetContentArea = function() return ContentArea end
    }
end

-- ==========================================
-- RETURN LIBRARY
-- ==========================================
return ScriptVaultUI
