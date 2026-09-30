-- ==========================================
-- ScriptVault UI Library v1.0
-- GitHub: github.com/ScriptVault/UI-Library
-- Usage: loadstring(game:HttpGet("RAW_URL"))()
-- ==========================================

local ScriptVaultUI = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")

local LP = Players.LocalPlayer

-- ==========================================
-- MAIN LIBRARY
-- ==========================================

function ScriptVaultUI:CreateWindow(options)
    options = options or {}
    local WindowName = options.Name or "ScriptVault"
    local WindowIcon = options.Icon or 0
    local LoadingTitle = options.LoadingTitle or "ScriptVault"
    local LoadingSubtitle = options.LoadingSubtitle or "UI Library"
    local Theme = options.Theme or "DarkBlue"
    
    -- Theme colors
    local Colors = {
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
    }
    
    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ScriptVaultUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = LP.PlayerGui
    
    -- Loading Screen
    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Size = UDim2.new(0, 350, 0, 200)
    LoadingFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
    LoadingFrame.BackgroundColor3 = Colors.Background
    LoadingFrame.BorderSizePixel = 0
    LoadingFrame.ZIndex = 100
    LoadingFrame.Parent = ScreenGui
    
    local LFCorner = Instance.new("UICorner")
    LFCorner.CornerRadius = UDim.new(0, 12)
    LFCorner.Parent = LoadingFrame
    
    local LFStroke = Instance.new("UIStroke")
    LFStroke.Color = Colors.Accent
    LFStroke.Thickness = 2
    LFStroke.Parent = LoadingFrame
    
    -- Loading Logo
    local LoadLogo = Instance.new("Frame")
    LoadLogo.Size = UDim2.new(0, 70, 0, 70)
    LoadLogo.Position = UDim2.new(0.5, -35, 0, 25)
    LoadLogo.BackgroundColor3 = Colors.Accent
    LoadLogo.BorderSizePixel = 0
    LoadLogo.Parent = LoadingFrame
    
    local LLCorner = Instance.new("UICorner")
    LLCorner.CornerRadius = UDim.new(1, 0)
    LLCorner.Parent = LoadLogo
    
    -- Loading ripple
    for i = 1, 3 do
        local Ripple = Instance.new("Frame")
        Ripple.Size = UDim2.new(1, 0, 1, 0)
        Ripple.BackgroundColor3 = Colors.Accent
        Ripple.BackgroundTransparency = 0.6
        Ripple.BorderSizePixel = 0
        Ripple.Parent = LoadLogo
        
        local RC = Instance.new("UICorner")
        RC.CornerRadius = UDim.new(1, 0)
        RC.Parent = Ripple
        
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
    
    local LoadLogoText = Instance.new("TextLabel")
    LoadLogoText.Size = UDim2.new(1, 0, 1, 0)
    LoadLogoText.BackgroundTransparency = 1
    LoadLogoText.Text = "SV"
    LoadLogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadLogoText.TextSize = 32
    LoadLogoText.Font = Enum.Font.GothamBlack
    LoadLogoText.Parent = LoadLogo
    
    -- Loading Title
    local LoadTitle = Instance.new("TextLabel")
    LoadTitle.Size = UDim2.new(1, 0, 0, 25)
    LoadTitle.Position = UDim2.new(0, 0, 0, 105)
    LoadTitle.BackgroundTransparency = 1
    LoadTitle.Text = LoadingTitle
    LoadTitle.TextColor3 = Colors.Text
    LoadTitle.TextSize = 18
    LoadTitle.Font = Enum.Font.GothamBold
    LoadTitle.Parent = LoadingFrame
    
    -- Loading Subtitle
    local LoadSub = Instance.new("TextLabel")
    LoadSub.Size = UDim2.new(1, 0, 0, 18)
    LoadSub.Position = UDim2.new(0, 0, 0, 130)
    LoadSub.BackgroundTransparency = 1
    LoadSub.Text = LoadingSubtitle
    LoadSub.TextColor3 = Colors.Accent
    LoadSub.TextSize = 13
    LoadSub.Font = Enum.Font.Gotham
    LoadSub.Parent = LoadingFrame
    
    -- Loading bar
    local LoadBarBg = Instance.new("Frame")
    LoadBarBg.Size = UDim2.new(0.7, 0, 0, 6)
    LoadBarBg.Position = UDim2.new(0.15, 0, 0, 160)
    LoadBarBg.BackgroundColor3 = Colors.ToggleOff
    LoadBarBg.BorderSizePixel = 0
    LoadBarBg.Parent = LoadingFrame
    
    local LBBgC = Instance.new("UICorner")
    LBBgC.CornerRadius = UDim.new(1, 0)
    LBBgC.Parent = LoadBarBg
    
    local LoadBarFill = Instance.new("Frame")
    LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
    LoadBarFill.BackgroundColor3 = Colors.Accent
    LoadBarFill.BorderSizePixel = 0
    LoadBarFill.Parent = LoadBarBg
    
    local LBFillC = Instance.new("UICorner")
    LBFillC.CornerRadius = UDim.new(1, 0)
    LBFillC.Parent = LoadBarFill
    
    -- Animate loading bar
    task.spawn(function()
        for i = 0, 1, 0.02 do
            LoadBarFill.Size = UDim2.new(i * 0.7, 0, 1, 0)
            task.wait(0.02)
        end
        task.wait(0.3)
        
        -- Fade out loading screen
        LoadingFrame:TweenPosition(UDim2.new(0.5, -175, 0.5, -150), "Out", "Quad", 0.3, true)
        TweenService:Create(LoadingFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        for _, child in ipairs(LoadingFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            end
        end
        task.wait(0.3)
        LoadingFrame:Destroy()
    end)
    
    -- ==========================================
    -- MAIN WINDOW
    -- ==========================================
    
    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Size = UDim2.new(0, 720, 0, 480)
    Window.Position = UDim2.new(0.5, -360, 0.5, -240)
    Window.BackgroundColor3 = Colors.Background
    Window.BorderSizePixel = 0
    Window.Active = true
    Window.Visible = false
    Window.Parent = ScreenGui
    
    local WCorner = Instance.new("UICorner")
    WCorner.CornerRadius = UDim.new(0, 10)
    WCorner.Parent = Window
    
    local WStroke = Instance.new("UIStroke")
    WStroke.Color = Colors.Accent
    WStroke.Thickness = 1.5
    WStroke.Parent = Window
    
    -- Show window after loading
    task.delay(1.2, function()
        Window.Visible = true
        Window:TweenPosition(UDim2.new(0.5, -360, 0.5, -240), "Out", "Back", 0.4, true)
    end)
    
    -- TOP BAR
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 42)
    TopBar.BackgroundColor3 = Colors.TopBar
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Window
    
    local TBCorner = Instance.new("UICorner")
    TBCorner.CornerRadius = UDim.new(0, 10, 0, 10)
    TBCorner.Parent = TopBar
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -120, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = WindowName
    Title.TextColor3 = Colors.Text
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    -- Minimize Button
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 32, 0, 28)
    MinBtn.Position = UDim2.new(1, -72, 0, 7)
    MinBtn.BackgroundColor3 = Colors.Warning
    MinBtn.BorderSizePixel = 0
    MinBtn.Text = "—"
    MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinBtn.TextSize = 18
    MinBtn.Font = Enum.Font.GothamBlack
    MinBtn.Parent = TopBar
    
    local MinC = Instance.new("UICorner")
    MinC.CornerRadius = UDim.new(0, 5)
    MinC.Parent = MinBtn
    
    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 32, 0, 28)
    CloseBtn.Position = UDim2.new(1, -36, 0, 7)
    CloseBtn.BackgroundColor3 = Colors.Error
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
    CloseBtn.Font = Enum.Font.GothamBlack
    CloseBtn.Parent = TopBar
    
    local CC = Instance.new("UICorner")
    CC.CornerRadius = UDim.new(0, 5)
    CC.Parent = CloseBtn
    
    -- SIDEBAR
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 200, 1, -42)
    Sidebar.Position = UDim2.new(0, 0, 0, 42)
    Sidebar.BackgroundColor3 = Colors.Sidebar
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Window
    
    local SBCorner = Instance.new("UICorner")
    SBCorner.CornerRadius = UDim.new(0, 0, 0, 10)
    SBCorner.Parent = Sidebar
    
    -- Separator
    local Separator = Instance.new("Frame")
    Separator.Size = UDim2.new(0, 1, 1, 0)
    Separator.Position = UDim2.new(1, 0, 0, 0)
    Separator.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Separator.BorderSizePixel = 0
    Separator.Parent = Sidebar
    
    -- LOGO AREA
    local LogoArea = Instance.new("Frame")
    LogoArea.Size = UDim2.new(1, 0, 0, 140)
    LogoArea.BackgroundTransparency = 1
    LogoArea.Parent = Sidebar
    
    local LogoCircle = Instance.new("Frame")
    LogoCircle.Size = UDim2.new(0, 80, 0, 80)
    LogoCircle.Position = UDim2.new(0.5, -40, 0, 10)
    LogoCircle.BackgroundColor3 = Colors.Accent
    LogoCircle.BorderSizePixel = 0
    LogoCircle.Parent = LogoArea
    
    local LCCorner = Instance.new("UICorner")
    LCCorner.CornerRadius = UDim.new(1, 0)
    LCCorner.Parent = LogoCircle
    
    for i = 1, 3 do
        local Ripple = Instance.new("Frame")
        Ripple.Size = UDim2.new(1, 0, 1, 0)
        Ripple.BackgroundColor3 = Colors.Accent
        Ripple.BackgroundTransparency = 0.6
        Ripple.BorderSizePixel = 0
        Ripple.Parent = LogoCircle
        
        local RC = Instance.new("UICorner")
        RC.CornerRadius = UDim.new(1, 0)
        RC.Parent = Ripple
        
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
    
    local SVText = Instance.new("TextLabel")
    SVText.Size = UDim2.new(1, 0, 1, 0)
    SVText.BackgroundTransparency = 1
    SVText.Text = "SV"
    SVText.TextColor3 = Color3.fromRGB(255, 255, 255)
    SVText.TextSize = 36
    SVText.Font = Enum.Font.GothamBlack
    SVText.Parent = LogoCircle
    
    local GameTitle = Instance.new("TextLabel")
    GameTitle.Size = UDim2.new(1, 0, 0, 22)
    GameTitle.Position = UDim2.new(0, 0, 0, 95)
    GameTitle.BackgroundTransparency = 1
    GameTitle.Text = WindowName
    GameTitle.TextColor3 = Colors.Text
    GameTitle.TextSize = 16
    GameTitle.Font = Enum.Font.GothamBold
    GameTitle.TextXAlignment = Enum.TextXAlignment.Center
    GameTitle.Parent = LogoArea
    
    local VersionLabel = Instance.new("TextLabel")
    VersionLabel.Size = UDim2.new(1, 0, 0, 16)
    VersionLabel.Position = UDim2.new(0, 0, 0, 115)
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Text = "v1.0"
    VersionLabel.TextColor3 = Colors.Accent
    VersionLabel.TextSize = 12
    VersionLabel.Font = Enum.Font.Gotham
    VersionLabel.TextXAlignment = Enum.TextXAlignment.Center
    VersionLabel.Parent = LogoArea
    
    local AuthorLabel = Instance.new("TextLabel")
    AuthorLabel.Size = UDim2.new(1, 0, 0, 14)
    AuthorLabel.Position = UDim2.new(0, 0, 0, 130)
    AuthorLabel.BackgroundTransparency = 1
    AuthorLabel.Text = "by ScriptVault"
    AuthorLabel.TextColor3 = Colors.TextDark
    AuthorLabel.TextSize = 11
    AuthorLabel.Font = Enum.Font.Gotham
    AuthorLabel.TextXAlignment = Enum.TextXAlignment.Center
    AuthorLabel.Parent = LogoArea
    
    -- TAB BUTTONS
    local TabList = Instance.new("Frame")
    TabList.Size = UDim2.new(1, -10, 1, -150)
    TabList.Position = UDim2.new(0, 5, 0, 145)
    TabList.BackgroundTransparency = 1
    TabList.Parent = Sidebar
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Padding = UDim.new(0, 4)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Parent = TabList
    
    -- CONTENT AREA
    local ContentArea = Instance.new("Frame")
    ContentArea.Size = UDim2.new(1, -200, 1, -42)
    ContentArea.Position = UDim2.new(0, 200, 0, 42)
    ContentArea.BackgroundColor3 = Colors.Background
    ContentArea.BorderSizePixel = 0
    ContentArea.ClipsDescendants = true
    ContentArea.Parent = Window
    
    local CACorner = Instance.new("UICorner")
    CACorner.CornerRadius = UDim.new(0, 0, 10, 0)
    CACorner.Parent = ContentArea
    
    -- ==========================================
    -- NOTIFICATION SYSTEM (Sağ Alt)
    -- ==========================================
    
    local NotifyContainer = Instance.new("Frame")
    NotifyContainer.Name = "NotifyContainer"
    NotifyContainer.Size = UDim2.new(0, 320, 0, 0)
    NotifyContainer.Position = UDim2.new(1, -340, 1, -20)
    NotifyContainer.BackgroundTransparency = 1
    NotifyContainer.Parent = ScreenGui
    
    local NotifyLayout = Instance.new("UIListLayout")
    NotifyLayout.Padding = UDim.new(0, 8)
    NotifyLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotifyLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    NotifyLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NotifyLayout.Parent = NotifyContainer
    
    function ScriptVaultUI:Notify(options)
        options = options or {}
        local Title = options.Title or "Notification"
        local Content = options.Content or ""
        local Duration = options.Duration or 5
        local Type = options.Type or "Info" -- Info, Success, Warning, Error
        
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
        
        -- Calculate height based on content
        local ContentLines = #Content > 30 and 2 or 1
        local NotifyHeight = 60 + (ContentLines - 1) * 18
        
        -- Notification Frame
        local Notify = Instance.new("Frame")
        Notify.Size = UDim2.new(0, 320, 0, 0)
        Notify.BackgroundColor3 = Colors.Element
        Notify.BorderSizePixel = 0
        Notify.LayoutOrder = 1
        Notify.Parent = NotifyContainer
        
        local NC = Instance.new("UICorner")
        NC.CornerRadius = UDim.new(0, 8)
        NC.Parent = Notify
        
        local NS = Instance.new("UIStroke")
        NS.Color = TypeColors[Type] or Colors.Accent
        NS.Thickness = 1.5
        NS.Parent = Notify
        
        -- Color bar on left
        local ColorBar = Instance.new("Frame")
        ColorBar.Size = UDim2.new(0, 4, 1, -16)
        ColorBar.Position = UDim2.new(0, 0, 0, 8)
        ColorBar.BackgroundColor3 = TypeColors[Type] or Colors.Accent
        ColorBar.BorderSizePixel = 0
        ColorBar.Parent = Notify
        
        local CBCCorner = Instance.new("UICorner")
        CBCCorner.CornerRadius = UDim.new(0, 4)
        CBCCorner.Parent = ColorBar
        
        -- Icon
        local Icon = Instance.new("TextLabel")
        Icon.Size = UDim2.new(0, 24, 0, 24)
        Icon.Position = UDim2.new(0, 14, 0, 10)
        Icon.BackgroundTransparency = 1
        Icon.Text = TypeIcons[Type] or "ℹ"
        Icon.TextColor3 = TypeColors[Type] or Colors.Accent
        Icon.TextSize = 18
        Icon.Font = Enum.Font.GothamBold
        Icon.Parent = Notify
        
        -- Title
        local NTitle = Instance.new("TextLabel")
        NTitle.Size = UDim2.new(1, -50, 0, 20)
        NTitle.Position = UDim2.new(0, 44, 0, 8)
        NTitle.BackgroundTransparency = 1
        NTitle.Text = Title
        NTitle.TextColor3 = Colors.Text
        NTitle.TextSize = 13
        NTitle.Font = Enum.Font.GothamBold
        NTitle.TextXAlignment = Enum.TextXAlignment.Left
        NTitle.Parent = Notify
        
        -- Content
        local NContent = Instance.new("TextLabel")
        NContent.Size = UDim2.new(1, -50, 0, ContentLines * 18)
        NContent.Position = UDim2.new(0, 44, 0, 28)
        NContent.BackgroundTransparency = 1
        NContent.Text = Content
        NContent.TextColor3 = Colors.TextMuted
        NContent.TextSize = 12
        NContent.Font = Enum.Font.Gotham
        NContent.TextXAlignment = Enum.TextXAlignment.Left
        NContent.TextYAlignment = Enum.TextYAlignment.Top
        NContent.TextWrapped = true
        NContent.Parent = Notify
        
        -- Progress bar
        local ProgressBg = Instance.new("Frame")
        ProgressBg.Size = UDim2.new(1, -16, 0, 3)
        ProgressBg.Position = UDim2.new(0, 8, 1, -8)
        ProgressBg.BackgroundColor3 = Colors.ToggleOff
        ProgressBg.BorderSizePixel = 0
        ProgressBg.Parent = Notify
        
        local PBCorner = Instance.new("UICorner")
        PBCorner.CornerRadius = UDim.new(1, 0)
        PBCorner.Parent = ProgressBg
        
        local ProgressFill = Instance.new("Frame")
        ProgressFill.Size = UDim2.new(1, 0, 1, 0)
        ProgressFill.BackgroundColor3 = TypeColors[Type] or Colors.Accent
        ProgressFill.BorderSizePixel = 0
        ProgressFill.Parent = ProgressBg
        
        local PFCorner = Instance.new("UICorner")
        PFCorner.CornerRadius = UDim.new(1, 0)
        PFCorner.Parent = ProgressFill
        
        -- Animate in
        Notify.Size = UDim2.new(0, 0, 0, 0)
        Notify:TweenSize(UDim2.new(0, 320, 0, NotifyHeight), "Out", "Back", 0.35, true)
        
        -- Animate progress bar
        task.spawn(function()
            local steps = Duration * 10
            for i = steps, 0, -1 do
                ProgressFill.Size = UDim2.new(i / steps, 0, 1, 0)
                task.wait(0.1)
            end
        end)
        
        -- Auto dismiss
        task.delay(Duration, function()
            if Notify.Parent then
                Notify:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.3, true)
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
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = Name
        TabBtn.Size = UDim2.new(1, 0, 0, 40)
        TabBtn.BackgroundColor3 = Colors.Element
        TabBtn.BorderSizePixel = 0
        TabBtn.Text = ""
        TabBtn.LayoutOrder = #Tabs + 1
        TabBtn.Parent = TabList
        
        local BtnC = Instance.new("UICorner")
        BtnC.CornerRadius = UDim.new(0, 6)
        BtnC.Parent = TabBtn
        
        -- Active indicator
        local Indicator = Instance.new("Frame")
        Indicator.Name = "Indicator"
        Indicator.Size = UDim2.new(0, 3, 0, 24)
        Indicator.Position = UDim2.new(0, 0, 0.5, -12)
        Indicator.BackgroundColor3 = Colors.Accent
        Indicator.BorderSizePixel = 0
        Indicator.Visible = false
        Indicator.Parent = TabBtn
        
        local IndC = Instance.new("UICorner")
        IndC.CornerRadius = UDim.new(0, 3)
        IndC.Parent = Indicator
        
        -- Icon
        local Icon = Instance.new("ImageLabel")
        Icon.Name = "Icon"
        Icon.Size = UDim2.new(0, 22, 0, 22)
        Icon.Position = UDim2.new(0, 14, 0.5, -11)
        Icon.BackgroundTransparency = 1
        Icon.Image = "rbxassetid://" .. tostring(IconID)
        Icon.ScaleType = Enum.ScaleType.Fit
        Icon.ImageColor3 = Colors.TextMuted
        Icon.Parent = TabBtn
        
        pcall(function() ContentProvider:PreloadAsync({Icon}) end)
        
        -- Text
        local Text = Instance.new("TextLabel")
        Text.Name = "Text"
        Text.Size = UDim2.new(1, -45, 0, 20)
        Text.Position = UDim2.new(0, 44, 0.5, -10)
        Text.BackgroundTransparency = 1
        Text.Text = Name
        Text.TextColor3 = Colors.TextMuted
        Text.TextSize = 13
        Text.Font = Enum.Font.GothamMedium
        Text.TextXAlignment = Enum.TextXAlignment.Left
        Text.Parent = TabBtn
        
        -- Content
        local Content = Instance.new("ScrollingFrame")
        Content.Name = Name
        Content.Size = UDim2.new(1, 0, 1, 0)
        Content.Position = UDim2.new(0, 0, 0, 0)
        Content.BackgroundTransparency = 1
        Content.Visible = false
        Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Content.ScrollBarThickness = 4
        Content.ScrollBarImageColor3 = Colors.Accent
        Content.BorderSizePixel = 0
        Content.Parent = ContentArea
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 10)
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Parent = Content
        
        local ContentPad = Instance.new("UIPadding")
        ContentPad.PaddingTop = UDim.new(0, 15)
        ContentPad.PaddingBottom = UDim.new(0, 15)
        ContentPad.PaddingLeft = UDim.new(0, 15)
        ContentPad.PaddingRight = UDim.new(0, 15)
        ContentPad.Parent = Content
        
        TabBtn.MouseButton1Click:Connect(function()
            SwitchTab(TabBtn)
        end)
        
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
        
        return {
            CreateLabel = function(Text) return SectionLabel(Content, Text) end,
            CreateToggle = function(options) return Toggle(Content, options.Name, options.CurrentValue or false, options.Callback) end,
            CreateSlider = function(options) return Slider(Content, options.Name, options.Range[1], options.Range[2], options.CurrentValue or options.Range[1], options.Callback) end,
            CreateDropdown = function(options) return Dropdown(Content, options.Name, options.Options, options.CurrentOption or options.Options[1], options.Callback) end,
            CreateButton = function(options) return Button(Content, options.Name, options.Callback) end,
            CreateParagraph = function(options) return Paragraph(Content, options.Title, options.Content) end,
        }
    end
    
    local function SwitchTab(TabBtn)
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
            content.Visible = (name == TabBtn.Name)
        end
    end
    
    -- ==========================================
    -- UI ELEMENTS
    -- ==========================================
    
    local function SectionLabel(Parent, Text)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 28)
        Label.BackgroundTransparency = 1
        Label.Text = Text
        Label.TextColor3 = Colors.Text
        Label.TextSize = 16
        Label.Font = Enum.Font.GothamBold
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Parent
        return Label
    end
    
    local function Toggle(Parent, Name, Default, Callback)
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 0, 44)
        Container.BackgroundColor3 = Colors.Element
        Container.BorderSizePixel = 0
        Container.Parent = Parent
        
        local CC2 = Instance.new("UICorner")
        CC2.CornerRadius = UDim.new(0, 7)
        CC2.Parent = Container
        
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 1, 0)
        Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Btn.BackgroundTransparency = 1
        Btn.Text = ""
        Btn.Parent = Container
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -60, 1, 0)
        Label.Position = UDim2.new(0, 14, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = Name
        Label.TextColor3 = Color3.fromRGB(220, 220, 230)
        Label.TextSize = 13
        Label.Font = Enum.Font.GothamMedium
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Btn
        
        local Track = Instance.new("Frame")
        Track.Size = UDim2.new(0, 44, 0, 24)
        Track.Position = UDim2.new(1, -54, 0.5, -12)
        Track.BackgroundColor3 = Default and Colors.ToggleOn or Colors.ToggleOff
        Track.BorderSizePixel = 0
        Track.Parent = Btn
        
        local TC = Instance.new("UICorner")
        TC.CornerRadius = UDim.new(1, 0)
        TC.Parent = Track
        
        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0, 18, 0, 18)
        Knob.Position = Default and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Knob.BorderSizePixel = 0
        Knob.Parent = Track
        
        local KC = Instance.new("UICorner")
        KC.CornerRadius = UDim.new(1, 0)
        KC.Parent = Knob
        
        local Value = Default
        
        local function SetToggle(v)
            Value = v
            Knob:TweenPosition(v and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9), "Out", "Quad", 0.15, true)
            Track.BackgroundColor3 = v and Colors.ToggleOn or Colors.ToggleOff
            if Callback then Callback(v) end
        end
        
        Btn.MouseButton1Click:Connect(function() SetToggle(not Value) end)
        
        return Container
    end
    
    local function Slider(Parent, Name, Min, Max, Default, Callback)
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 0, 55)
        Container.BackgroundColor3 = Colors.Element
        Container.BorderSizePixel = 0
        Container.Parent = Parent
        
        local CC2 = Instance.new("UICorner")
        CC2.CornerRadius = UDim.new(0, 7)
        CC2.Parent = Container
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -70, 0, 20)
        Label.Position = UDim2.new(0, 14, 0, 8)
        Label.BackgroundTransparency = 1
        Label.Text = Name
        Label.TextColor3 = Color3.fromRGB(220, 220, 230)
        Label.TextSize = 13
        Label.Font = Enum.Font.GothamMedium
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Container
        
        local ValueLabel = Instance.new("TextLabel")
        ValueLabel.Size = UDim2.new(0, 55, 0, 20)
        ValueLabel.Position = UDim2.new(1, -65, 0, 8)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Text = tostring(Default)
        ValueLabel.TextColor3 = Colors.Accent
        ValueLabel.TextSize = 13
        ValueLabel.Font = Enum.Font.GothamBold
        ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
        ValueLabel.Parent = Container
        
        local Track = Instance.new("Frame")
        Track.Size = UDim2.new(1, -28, 0, 8)
        Track.Position = UDim2.new(0, 14, 1, -22)
        Track.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        Track.BorderSizePixel = 0
        Track.Parent = Container
        
        local TrC = Instance.new("UICorner")
        TrC.CornerRadius = UDim.new(1, 0)
        TrC.Parent = Track
        
        local Fill = Instance.new("Frame")
        Fill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
        Fill.BackgroundColor3 = Colors.Accent
        Fill.BorderSizePixel = 0
        Fill.Parent = Track
        
        local FiC = Instance.new("UICorner")
        FiC.CornerRadius = UDim.new(1, 0)
        FiC.Parent = Fill
        
        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0, 16, 0, 16)
        Knob.Position = UDim2.new((Default - Min) / (Max - Min), -8, 0.5, -8)
        Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Knob.BorderSizePixel = 0
        Knob.ZIndex = 5
        Knob.Parent = Track
        
        local KnC = Instance.new("UICorner")
        KnC.CornerRadius = UDim.new(1, 0)
        KnC.Parent = Knob
        
        local Dragging = false
        
        local function Update(Input)
            local RelX = Input.Position.X - Track.AbsolutePosition.X
            local Pos = math.clamp(RelX / Track.AbsoluteSize.X, 0, 1)
            Knob.Position = UDim2.new(Pos, -8, 0.5, -8)
            Fill.Size = UDim2.new(Pos, 0, 1, 0)
            local Val = math.floor(Pos * (Max - Min) + Min)
            ValueLabel.Text = tostring(Val)
            if Callback then Callback(Val) end
        end
        
        Knob.InputBegan:Connect(function(I) if I.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = true end end)
        Knob.InputEnded:Connect(function(I) if I.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end end)
        UserInputService.InputChanged:Connect(function(I) if Dragging and I.UserInputType == Enum.UserInputType.MouseMovement then Update(I) end end)
        
        return Container
    end
    
    local function Dropdown(Parent, Name, Options, Default, Callback)
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 0, 65)
        Container.BackgroundColor3 = Colors.Element
        Container.BorderSizePixel = 0
        Container.Parent = Parent
        
        local CC2 = Instance.new("UICorner")
        CC2.CornerRadius = UDim.new(0, 7)
        CC2.Parent = Container
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 20)
        Label.Position = UDim2.new(0, 14, 0, 6)
        Label.BackgroundTransparency = 1
        Label.Text = Name
        Label.TextColor3 = Color3.fromRGB(220, 220, 230)
        Label.TextSize = 13
        Label.Font = Enum.Font.GothamMedium
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Container
        
        local DropBtn = Instance.new("TextButton")
        DropBtn.Size = UDim2.new(1, -28, 0, 32)
        DropBtn.Position = UDim2.new(0, 14, 0, 28)
        DropBtn.BackgroundColor3 = Colors.ElementHover
        DropBtn.BorderSizePixel = 0
        DropBtn.Text = ""
        DropBtn.Parent = Container
        
        local DBC = Instance.new("UICorner")
        DBC.CornerRadius = UDim.new(0, 6)
        DBC.Parent = DropBtn
        
        local SelText = Instance.new("TextLabel")
        SelText.Size = UDim2.new(1, -30, 1, 0)
        SelText.Position = UDim2.new(0, 10, 0, 0)
        SelText.BackgroundTransparency = 1
        SelText.Text = Default
        SelText.TextColor3 = Colors.Text
        SelText.TextSize = 13
        SelText.Font = Enum.Font.GothamMedium
        SelText.TextXAlignment = Enum.TextXAlignment.Left
        SelText.Parent = DropBtn
        
        local Arrow = Instance.new("TextLabel")
        Arrow.Size = UDim2.new(0, 20, 1, 0)
        Arrow.Position = UDim2.new(1, -22, 0, 0)
        Arrow.BackgroundTransparency = 1
        Arrow.Text = "▼"
        Arrow.TextColor3 = Colors.TextDark
        Arrow.TextSize = 11
        Arrow.Font = Enum.Font.Gotham
        Arrow.Parent = DropBtn
        
        local DropList = Instance.new("Frame")
        DropList.Size = UDim2.new(1, -28, 0, 0)
        DropList.Position = UDim2.new(0, 14, 1, -32)
        DropList.BackgroundColor3 = Color3.fromRGB(30, 30, 48)
        DropList.BorderSizePixel = 0
        DropList.Visible = false
        DropList.ZIndex = 10
        DropList.Parent = Container
        
        local DLC = Instance.new("UICorner")
        DLC.CornerRadius = UDim.new(0, 6)
        DLC.Parent = DropList
        
        local DLL = Instance.new("UIListLayout")
        DLL.Parent = DropList
        
        local Open = false
        
        for _, Opt in ipairs(Options) do
            local OptBtn = Instance.new("TextButton")
            OptBtn.Size = UDim2.new(1, 0, 0, 32)
            OptBtn.BackgroundColor3 = Colors.ElementHover
            OptBtn.BorderSizePixel = 0
            OptBtn.Text = Opt
            OptBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
            OptBtn.TextSize = 12
            OptBtn.Font = Enum.Font.GothamMedium
            OptBtn.ZIndex = 11
            OptBtn.Parent = DropList
            
            OptBtn.MouseEnter:Connect(function() OptBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 70) end)
            OptBtn.MouseLeave:Connect(function() OptBtn.BackgroundColor3 = Colors.ElementHover end)
            
            OptBtn.MouseButton1Click:Connect(function()
                SelText.Text = Opt
                Open = false
                DropList:TweenSize(UDim2.new(1, -28, 0, 0), "Out", "Quad", 0.15, true)
                task.wait(0.15)
                DropList.Visible = false
                if Callback then Callback(Opt) end
            end)
        end
        
        DropBtn.MouseButton1Click:Connect(function()
            Open = not Open
            if Open then
                DropList.Visible = true
                DropList:TweenSize(UDim2.new(1, -28, 0, #Options * 32), "Out", "Quad", 0.15, true)
            else
                DropList:TweenSize(UDim2.new(1, -28, 0, 0), "Out", "Quad", 0.15, true)
                task.wait(0.15)
                DropList.Visible = false
            end
        end)
        
        return Container
    end
    
    local function Button(Parent, Name, Callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 38)
        Btn.BackgroundColor3 = Colors.Button
        Btn.BorderSizePixel = 0
        Btn.Text = Name
        Btn.TextColor3 = Colors.Text
        Btn.TextSize = 13
        Btn.Font = Enum.Font.GothamBold
        Btn.Parent = Parent
        
        local BC = Instance.new("UICorner")
        BC.CornerRadius = UDim.new(0, 7)
        BC.Parent = Btn
        
        Btn.MouseEnter:Connect(function() Btn.BackgroundColor3 = Colors.ButtonHover end)
        Btn.MouseLeave:Connect(function() Btn.BackgroundColor3 = Colors.Button end)
        Btn.MouseButton1Click:Connect(function() if Callback then Callback() end end)
        
        return Btn
    end
    
    local function Paragraph(Parent, Title, Content)
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 0, 120)
        Container.BackgroundColor3 = Colors.Element
        Container.BorderSizePixel = 0
        Container.Parent = Parent
        
        local CC2 = Instance.new("UICorner")
        CC2.CornerRadius = UDim.new(0, 7)
        CC2.Parent = Container
        
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Size = UDim2.new(1, -20, 0, 25)
        TitleLabel.Position = UDim2.new(0, 10, 0, 10)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = Title
        TitleLabel.TextColor3 = Colors.Text
        TitleLabel.TextSize = 15
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Parent = Container
        
        local ContentLabel = Instance.new("TextLabel")
        ContentLabel.Size = UDim2.new(1, -20, 1, -40)
        ContentLabel.Position = UDim2.new(0, 10, 0, 35)
        ContentLabel.BackgroundTransparency = 1
        ContentLabel.Text = Content
        ContentLabel.TextColor3 = Colors.TextMuted
        ContentLabel.TextSize = 12
        ContentLabel.Font = Enum.Font.Gotham
        ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
        ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
        ContentLabel.TextWrapped = true
        ContentLabel.Parent = Container
        
        return Container
    end
    
    -- ==========================================
    -- DRAGGABLE
    -- ==========================================
    
    local Dragging = false
    local DragStart = nil
    local StartPos = nil
    
    TopBar.InputBegan:Connect(function(I)
        if I.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = I.Position
            StartPos = Window.Position
            I.Changed:Connect(function()
                if I.UserInputState == Enum.UserInputState.End then Dragging = false end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(I)
        if Dragging and I.UserInputType == Enum.UserInputType.MouseMovement then
            local D = I.Position - DragStart
            Window.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + D.X, StartPos.Y.Scale, StartPos.Y.Offset + D.Y)
        end
    end)
    
    -- Minimize/Restore
    local isMinimized = false
    
    local MinIcon = Instance.new("TextButton")
    MinIcon.Size = UDim2.new(0, 65, 0, 65)
    MinIcon.Position = UDim2.new(1, -85, 0.5, -32)
    MinIcon.BackgroundColor3 = Colors.Accent
    MinIcon.BorderSizePixel = 0
    MinIcon.Text = "SV"
    MinIcon.TextColor3 = Colors.Text
    MinIcon.TextSize = 26
    MinIcon.Font = Enum.Font.GothamBlack
    MinIcon.Visible = false
    MinIcon.Parent = ScreenGui
    
    local MIC = Instance.new("UICorner")
    MIC.CornerRadius = UDim.new(1, 0)
    MIC.Parent = MinIcon
    
    local MIS = Instance.new("UIStroke")
    MIS.Color = Colors.AccentHover
    MIS.Thickness = 2
    MIS.Parent = MinIcon
    
    for i = 1, 2 do
        local R = Instance.new("Frame")
        R.Size = UDim2.new(1, 0, 1, 0)
        R.BackgroundColor3 = Colors.Accent
        R.BackgroundTransparency = 0.6
        R.BorderSizePixel = 0
        R.Parent = MinIcon
        
        local RC = Instance.new("UICorner")
        RC.CornerRadius = UDim.new(1, 0)
        RC.Parent = R
        
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
        Window:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true)
        Window:TweenPosition(UDim2.new(1, -85, 0.5, -32), "Out", "Quad", 0.25, true)
        task.wait(0.25)
        Window.Visible = false
        MinIcon.Visible = true
        MinIcon.Size = UDim2.new(0, 0, 0, 0)
        MinIcon:TweenSize(UDim2.new(0, 65, 0, 65), "Out", "Back", 0.35, true)
    end
    
    local function Restore()
        if not isMinimized then return end
        isMinimized = false
        MinIcon:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.2, true)
        task.wait(0.2)
        MinIcon.Visible = false
        Window.Visible = true
        Window.Size = UDim2.new(0, 0, 0, 0)
        Window.Position = UDim2.new(1, -85, 0.5, -32)
        Window:TweenSize(UDim2.new(0, 720, 0, 480), "Out", "Back", 0.35, true)
        Window:TweenPosition(UDim2.new(0.5, -360, 0.5, -240), "Out", "Back", 0.35, true)
    end
    
    MinBtn.MouseButton1Click:Connect(Minimize)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    MinIcon.MouseButton1Click:Connect(Restore)
    
    -- RightShift to close
    UserInputService.InputBegan:Connect(function(I)
        if I.KeyCode == Enum.KeyCode.RightShift then ScreenGui:Destroy() end
    end)
    
    -- Return window object
    return {
        CreateTab = CreateTab,
        Notify = function(options) ScriptVaultUI:Notify(options) end,
        Destroy = function() ScreenGui:Destroy() end,
    }
end

-- ==========================================
-- RETURN LIBRARY
-- ==========================================

return ScriptVaultUI
