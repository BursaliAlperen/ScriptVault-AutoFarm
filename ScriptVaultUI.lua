--[[
=====================================================
  ScriptVault UI Library v5.0.0
  Modern, responsive Roblox UI framework
  Author: BursaliAlperen

  Backwards-compatible core API:
    local SV = loadstring(game:HttpGet("RAW_URL"))()
    local Window = SV:CreateWindow({ Name = "My Script" })
    local Tab = Window:CreateTab("Main")
    Tab:CreateButton({ Name = "Click", Callback = function() end })
=====================================================
]]

local SV = {}
SV.__index = SV
SV._VERSION = "5.1.0"
SV._BUILD = "20261002"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer

SV.Icons = {
    Logo="rbxassetid://111637853140695", Home="rbxassetid://6031075931",
    Player="rbxassetid://6031225389", Stats="rbxassetid://6031279000",
    Combat="rbxassetid://6031094678", Tools="rbxassetid://6035067834",
    Misc="rbxassetid://6031154871", Shop="rbxassetid://6034280643",
    Visual="rbxassetid://6031302945", Key="rbxassetid://6031265976",
    Lock="rbxassetid://6031216977", Script="rbxassetid://6034277377",
    Debug="rbxassetid://6031090990", Folder="rbxassetid://6034982098",
    Info="rbxassetid://17829948066", Settings="rbxassetid://9405931578",
    Teleport="rbxassetid://16538185173", Farm="rbxassetid://11330204834",
    Star="rbxassetid://138880939782808", Check="rbxassetid://122032243989747"
}

local Themes = {}
local function theme(name, values) Themes[name] = values end

local function palette(bg, panel, card, hover, accent, text, muted)
    return {
        Background=bg, Sidebar=panel, TopBar=panel, Element=card, ElementHover=hover,
        Accent=accent, AccentHover=accent:Lerp(Color3.new(1,1,1), .16),
        Text=text, TextMuted=muted, TextDark=muted:Lerp(bg, .35),
        ToggleOn=accent, ToggleOff=card:Lerp(bg, .5), Success=Color3.fromRGB(55,210,130),
        Warning=Color3.fromRGB(245,180,55), Error=Color3.fromRGB(235,80,90),
        Slider=card:Lerp(bg,.35), SliderFill=accent, Input=card:Lerp(bg,.2),
        Border=accent, Separator=card:Lerp(bg,.18), Overlay=Color3.new(0,0,0)
    }
end

theme("DarkBlue", palette(Color3.fromRGB(11,13,21),Color3.fromRGB(17,20,31),Color3.fromRGB(25,29,43),Color3.fromRGB(34,39,57),Color3.fromRGB(55,130,255),Color3.fromRGB(242,245,255),Color3.fromRGB(157,165,190)))
theme("Midnight", palette(Color3.fromRGB(9,9,14),Color3.fromRGB(14,14,21),Color3.fromRGB(22,22,32),Color3.fromRGB(32,31,46),Color3.fromRGB(177,103,255),Color3.fromRGB(246,241,255),Color3.fromRGB(163,154,185)))
theme("Ocean", palette(Color3.fromRGB(8,17,24),Color3.fromRGB(13,25,34),Color3.fromRGB(21,37,50),Color3.fromRGB(31,52,68),Color3.fromRGB(0,205,225),Color3.fromRGB(235,251,255),Color3.fromRGB(151,179,195)))
theme("Light", palette(Color3.fromRGB(244,246,250),Color3.fromRGB(235,239,245),Color3.fromRGB(255,255,255),Color3.fromRGB(245,248,252),Color3.fromRGB(30,120,230),Color3.fromRGB(28,31,42),Color3.fromRGB(101,107,126)))
theme("Monochrome", palette(Color3.fromRGB(17,17,17),Color3.fromRGB(23,23,23),Color3.fromRGB(31,31,31),Color3.fromRGB(43,43,43),Color3.fromRGB(235,235,235),Color3.fromRGB(245,245,245),Color3.fromRGB(158,158,158)))
theme("Sunset", palette(Color3.fromRGB(24,14,20),Color3.fromRGB(32,19,28),Color3.fromRGB(43,25,38),Color3.fromRGB(57,34,49),Color3.fromRGB(255,104,130),Color3.fromRGB(255,241,245),Color3.fromRGB(202,166,178)))
theme("Forest", palette(Color3.fromRGB(11,21,15),Color3.fromRGB(17,29,21),Color3.fromRGB(26,42,31),Color3.fromRGB(38,57,43),Color3.fromRGB(77,218,119),Color3.fromRGB(232,251,237),Color3.fromRGB(151,181,160)))

local function safe(fn,...)
    if type(fn) ~= "function" then return end
    local ok, err = pcall(fn,...)
    if not ok then warn("[ScriptVault] "..tostring(err)) end
end

local function create(class, props, parent)
    local obj = Instance.new(class)
    for k,v in pairs(props or {}) do pcall(function() obj[k]=v end) end
    obj.Parent = parent
    return obj
end

local function corner(radius, parent)
    return create("UICorner",{CornerRadius=UDim.new(0,radius)},parent)
end

local function stroke(color, thickness, transparency, parent)
    return create("UIStroke",{Color=color,Thickness=thickness or 1,Transparency=transparency or 0,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},parent)
end

local function padding(parent, top, bottom, left, right)
    return create("UIPadding",{PaddingTop=UDim.new(0,top),PaddingBottom=UDim.new(0,bottom),PaddingLeft=UDim.new(0,left),PaddingRight=UDim.new(0,right)},parent)
end

local function layout(parent, gap)
    return create("UIListLayout",{Padding=UDim.new(0,gap or 8),SortOrder=Enum.SortOrder.LayoutOrder},parent)
end

local function tween(obj, props, duration, style)
    if not obj or not obj.Parent then return end
    local info=TweenInfo.new(duration or .18,style or Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    return TweenService:Create(obj,info,props):Play()
end

local function icon(asset, size, color, parent)
    if not asset then return nil end
    local i=create("ImageLabel",{BackgroundTransparency=1,Size=size or UDim2.fromOffset(20,20),Image=asset,ImageColor3=color or Color3.new(1,1,1),ScaleType=Enum.ScaleType.Fit},parent)
    return i
end

local function getPing()
    local ok,v=pcall(function() return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
    return ok and v or 0
end

local function getMemory()
    local ok,v=pcall(function() return math.floor(Stats:GetTotalMemoryUsageMb()) end)
    return ok and v or 0
end

local function isTouch()
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

local function fmt(n)
    if n>=1000000 then return string.format("%.1fM",n/1000000) end
    if n>=1000 then return string.format("%.1fK",n/1000) end
    return tostring(math.floor(n))
end

local function getGuiParent()
    local ok,hui=pcall(function() return gethui and gethui() end)
    if ok and hui then return hui end
    return CoreGui
end

function SV:CreateWindow(options)
    options=options or {}
    local Colors=Themes[options.Theme or "DarkBlue"] or Themes.DarkBlue
    local WindowName=options.Name or "ScriptVault"
    local Width=options.Width or 900
    local Height=options.Height or 570
    local MinWidth=options.MinWidth or 640
    local MinHeight=options.MinHeight or 420
    local SidebarWidth=options.SidebarWidth or 190
    local ToggleKeybind=options.ToggleKeybind or Enum.KeyCode.RightShift
    local reducedMotion=options.ReducedMotion or false

    local connections={}
    local function connect(signal, fn)
        local c=signal:Connect(fn)
        table.insert(connections,c)
        return c
    end
    local function disconnectAll()
        for _,c in ipairs(connections) do pcall(function() c:Disconnect() end) end
        table.clear(connections)
    end

    local ScreenGui=create("ScreenGui",{Name="ScriptVaultUI",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true},getGuiParent())
    local Shadow=create("Frame",{Size=UDim2.fromOffset(Width+28,Height+28),Position=UDim2.new(.5,-Width/2-14,.5,-Height/2-4),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=.65,BorderSizePixel=0},ScreenGui)
    corner(22,Shadow)

    local Window=create("Frame",{Size=UDim2.fromOffset(Width,Height),Position=UDim2.new(.5,-Width/2,.5,-Height/2),BackgroundColor3=Colors.Background,BorderSizePixel=0,ClipsDescendants=true},ScreenGui)
    corner(18,Window)
    local outerStroke=stroke(Colors.Border,1,0.72,Window)

    local Top=create("Frame",{Size=UDim2.new(1,0,0,58),BackgroundColor3=Colors.TopBar,BorderSizePixel=0},Window)
    local topLine=create("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=Colors.Separator,BorderSizePixel=0},Top)

    local logoWrap=create("Frame",{Size=UDim2.fromOffset(36,36),Position=UDim2.fromOffset(12,11),BackgroundColor3=Colors.Accent,BorderSizePixel=0},Top)
    corner(11,logoWrap)
    local logo=icon(options.Icon or SV.Icons.Logo,UDim2.fromScale(.68,.68),Color3.new(1,1,1),logoWrap)
    if logo then logo.AnchorPoint=Vector2.new(.5,.5);logo.Position=UDim2.fromScale(.5,.5) end

    create("TextLabel",{Size=UDim2.new(0,260,0,22),Position=UDim2.fromOffset(58,8),BackgroundTransparency=1,Text=WindowName,TextColor3=Colors.Text,TextSize=15,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},Top)
    create("TextLabel",{Size=UDim2.new(0,260,0,16),Position=UDim2.fromOffset(58,30),BackgroundTransparency=1,Text="ScriptVault • v"..SV._VERSION,TextColor3=Colors.TextMuted,TextSize=10,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},Top)

    local search=create("TextBox",{Size=UDim2.fromOffset(210,34),Position=UDim2.new(1,-318,.5,-17),BackgroundColor3=Colors.Input,BorderSizePixel=0,PlaceholderText="Search tabs  •  Ctrl+K",PlaceholderColor3=Colors.TextDark,Text="",TextColor3=Colors.Text,TextSize=11,Font=Enum.Font.Gotham,ClearTextOnFocus=false},Top)
    corner(10,search)
    local searchStroke=stroke(Colors.Separator,1,0,search)
    padding(search,0,0,34,10)
    local searchIcon=icon("rbxassetid://6031154871",UDim2.fromOffset(16,16),Colors.TextMuted,search)
    if searchIcon then searchIcon.Position=UDim2.fromOffset(10,9) end

    local function windowButton(x, bg, glyph)
        local b=create("TextButton",{Size=UDim2.fromOffset(32,32),Position=UDim2.new(1,x,.5,-16),BackgroundColor3=bg,BorderSizePixel=0,Text=glyph,TextColor3=Color3.new(1,1,1),TextSize=16,Font=Enum.Font.GothamBold,AutoButtonColor=false},Top)
        corner(9,b)
        return b
    end
    local minimize=windowButton(-98,Colors.Warning,"—")
    local close=windowButton(-58,Colors.Error,"×")

    local Sidebar=create("Frame",{Size=UDim2.new(0,SidebarWidth,1,-58),Position=UDim2.fromOffset(0,58),BackgroundColor3=Colors.Sidebar,BorderSizePixel=0},Window)
    local Content=create("Frame",{Size=UDim2.new(1,-SidebarWidth,1,-58),Position=UDim2.new(0,SidebarWidth,0,58),BackgroundColor3=Colors.Background,BorderSizePixel=0},Window)
    local TabList=create("ScrollingFrame",{Size=UDim2.new(1,0,1,-82),Position=UDim2.fromOffset(0,76),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Colors.Accent,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new()},Sidebar)
    layout(TabList,5)
    padding(TabList,6,12,10,10)

    local brand=create("Frame",{Size=UDim2.new(1,0,0,70),BackgroundTransparency=1},Sidebar)
    create("TextLabel",{Size=UDim2.new(1,-24,0,20),Position=UDim2.fromOffset(12,10),BackgroundTransparency=1,Text="NAVIGATION",TextColor3=Colors.TextDark,TextSize=9,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},brand)
    local collapse=create("TextButton",{Size=UDim2.fromOffset(26,26),Position=UDim2.new(1,-36,0,7),BackgroundColor3=Colors.Element,BorderSizePixel=0,Text="‹",TextColor3=Colors.TextMuted,TextSize=17,Font=Enum.Font.GothamBold,AutoButtonColor=false},brand)
    corner(8,collapse)

    local tabs, contents, current = {}, {}, nil
    local searchResults={}
    local sidebarCollapsed=false

    local function activate(tab)
        for _,t in ipairs(tabs) do
            local active=t==tab
            t.Content.Visible=active
            tween(t.Button,{BackgroundColor3=active and Colors.ElementHover or Colors.Element},reducedMotion and 0 or .16)
            tween(t.Label,{TextColor3=active and Colors.Text or Colors.TextMuted},reducedMotion and 0 or .16)
            if t.Icon then tween(t.Icon,{ImageColor3=active and Colors.Accent or Colors.TextMuted},reducedMotion and 0 or .16) end
            t.Indicator.Visible=active
        end
        current=tab
    end

    local function makeStat(parent, title, value, accent)
        local card=create("Frame",{Size=UDim2.new(1,0,0,82),BackgroundColor3=Colors.Element,BorderSizePixel=0},parent)
        corner(12,card)
        stroke(Colors.Separator,1,.25,card)
        create("TextLabel",{Size=UDim2.new(1,-24,0,18),Position=UDim2.fromOffset(12,10),BackgroundTransparency=1,Text=title,TextColor3=Colors.TextMuted,TextSize=10,Font=Enum.Font.GothamMedium,TextXAlignment=Enum.TextXAlignment.Left},card)
        local v=create("TextLabel",{Size=UDim2.new(1,-24,0,28),Position=UDim2.fromOffset(12,30),BackgroundTransparency=1,Text=value,TextColor3=accent or Colors.Text,TextSize=20,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},card)
        return v
    end

    local function makeTab(name, iconId, opts)
        opts=opts or {}
        local button=create("TextButton",{Size=UDim2.new(1,0,0,42),BackgroundColor3=Colors.Element,BorderSizePixel=0,Text="",AutoButtonColor=false,LayoutOrder=opts.Order or #tabs+1},TabList)
        corner(10,button)
        local indicator=create("Frame",{Size=UDim2.fromOffset(3,22),Position=UDim2.fromOffset(0,10),BackgroundColor3=Colors.Accent,BorderSizePixel=0,Visible=false},button)
        corner(3,indicator)
        local i=icon(iconId or SV.Icons.Home,UDim2.fromOffset(18,18),Colors.TextMuted,button)
        if i then i.Position=UDim2.fromOffset(13,12) end
        local label=create("TextLabel",{Size=UDim2.new(1,-54,1,0),Position=UDim2.fromOffset(43,0),BackgroundTransparency=1,Text=name,TextColor3=Colors.TextMuted,TextSize=12,Font=Enum.Font.GothamMedium,TextXAlignment=Enum.TextXAlignment.Left},button)
        if opts.Badge then
            local badge=create("TextLabel",{Size=UDim2.fromOffset(22,18),Position=UDim2.new(1,-30,.5,-9),BackgroundColor3=Colors.Accent,BorderSizePixel=0,Text=tostring(opts.Badge),TextColor3=Color3.new(1,1,1),TextSize=9,Font=Enum.Font.GothamBold},button)
            corner(9,badge)
        end
        local content=create("ScrollingFrame",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),ScrollBarThickness=3,ScrollBarImageColor3=Colors.Accent},Content)
        layout(content,10)
        padding(content,18,20,18,18)
        local tab={Name=name,Button=button,Content=content,Icon=i,Label=label,Indicator=indicator,_order=0}
        table.insert(tabs,tab)
        contents[name]=content
        connect(button.MouseButton1Click,function() activate(tab) end)
        connect(button.MouseEnter,function() if current~=tab then tween(button,{BackgroundColor3=Colors.ElementHover},.1) end end)
        connect(button.MouseLeave,function() if current~=tab then tween(button,{BackgroundColor3=Colors.Element},.1) end end)
        if not current then activate(tab) end

        function tab:CreateSection(title)
            self._order+=1
            local f=create("Frame",{Size=UDim2.new(1,0,0,28),BackgroundTransparency=1,LayoutOrder=self._order},self.Content)
            local bar=create("Frame",{Size=UDim2.fromOffset(3,15),Position=UDim2.fromOffset(0,7),BackgroundColor3=Colors.Accent,BorderSizePixel=0},f);corner(2,bar)
            create("TextLabel",{Size=UDim2.new(1,-12,1,0),Position=UDim2.fromOffset(11,0),BackgroundTransparency=1,Text=string.upper(tostring(title)),TextColor3=Colors.TextMuted,TextSize=10,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},f)
            return f
        end

        function tab:CreateDivider()
            self._order+=1
            return create("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=Colors.Separator,BorderSizePixel=0,LayoutOrder=self._order},self.Content)
        end

        function tab:CreateLabel(text)
            self._order+=1
            return create("TextLabel",{Size=UDim2.new(1,0,0,28),BackgroundTransparency=1,Text=tostring(text),TextColor3=Colors.Text,TextSize=14,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=self._order},self.Content)
        end

        function tab:CreateParagraph(o)
            o=o or {}; self._order+=1
            local f=create("Frame",{Size=UDim2.new(1,0,0,78),BackgroundColor3=Colors.Element,BorderSizePixel=0,LayoutOrder=self._order},self.Content);corner(12,f);stroke(Colors.Separator,1,.3,f)
            local ii=icon(o.Icon or SV.Icons.Info,UDim2.fromOffset(20,20),Colors.Accent,f);if ii then ii.Position=UDim2.fromOffset(13,13) end
            create("TextLabel",{Size=UDim2.new(1,-52,0,20),Position=UDim2.fromOffset(40,9),BackgroundTransparency=1,Text=o.Title or "Info",TextColor3=Colors.Text,TextSize=13,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},f)
            local body=create("TextLabel",{Size=UDim2.new(1,-26,0,38),Position=UDim2.fromOffset(13,34),BackgroundTransparency=1,Text=o.Content or "",TextColor3=Colors.TextMuted,TextSize=11,Font=Enum.Font.Gotham,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top},f)
            task.defer(function() f.Size=UDim2.new(1,0,0,48+math.max(22,body.TextBounds.Y)) end)
            return f
        end

        function tab:CreateButton(o)
            o=o or {}; self._order+=1
            local variants={
                Primary={Colors.Accent,Colors.AccentHover},Success={Colors.Success,Color3.fromRGB(70,230,145)},
                Warning={Colors.Warning,Color3.fromRGB(255,195,75)},Error={Colors.Error,Color3.fromRGB(250,95,105)},
                Ghost={Colors.Element,Colors.ElementHover}
            }
            local vc=variants[o.Variant or "Primary"] or variants.Primary
            local b=create("TextButton",{Size=UDim2.new(1,0,0,44),BackgroundColor3=vc[1],BorderSizePixel=0,Text=o.Name or "Button",TextColor3=Colors.Text,TextSize=12,Font=Enum.Font.GothamBold,AutoButtonColor=false,LayoutOrder=self._order},self.Content)
            corner(10,b)
            stroke(Colors.Separator,1,.55,b)
            connect(b.MouseEnter,function() tween(b,{BackgroundColor3=vc[2]},.1) end)
            connect(b.MouseLeave,function() tween(b,{BackgroundColor3=vc[1]},.1) end)
            connect(b.MouseButton1Click,function() safe(o.Callback) end)
            return b
        end

        function tab:CreateToggle(o)
            o=o or {}; self._order+=1
            local f=create("Frame",{Size=UDim2.new(1,0,0,o.Description and 62 or 46),BackgroundColor3=Colors.Element,BorderSizePixel=0,LayoutOrder=self._order},self.Content);corner(10,f)
            local b=create("TextButton",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text="",AutoButtonColor=false},f)
            create("TextLabel",{Size=UDim2.new(1,-76,0,20),Position=UDim2.fromOffset(13,o.Description and 8 or 13),BackgroundTransparency=1,Text=o.Name or "Toggle",TextColor3=Colors.Text,TextSize=12,Font=Enum.Font.GothamMedium,TextXAlignment=Enum.TextXAlignment.Left},f)
            if o.Description then create("TextLabel",{Size=UDim2.new(1,-76,0,16),Position=UDim2.fromOffset(13,31),BackgroundTransparency=1,Text=o.Description,TextColor3=Colors.TextDark,TextSize=10,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},f) end
            local value=o.CurrentValue==true
            local track=create("Frame",{Size=UDim2.fromOffset(44,24),Position=UDim2.new(1,-58,.5,-12),BackgroundColor3=value and Colors.ToggleOn or Colors.ToggleOff,BorderSizePixel=0},f);corner(12,track)
            local knob=create("Frame",{Size=UDim2.fromOffset(18,18),Position=value and UDim2.new(1,-21,.5,-9) or UDim2.fromOffset(3,3),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0},track);corner(9,knob)
            local function set(v,callback) value=not not v;tween(track,{BackgroundColor3=value and Colors.ToggleOn or Colors.ToggleOff},.15);tween(knob,{Position=value and UDim2.new(1,-21,.5,-9) or UDim2.fromOffset(3,3)},.15);if callback~=false then safe(o.Callback,value) end end
            connect(b.MouseButton1Click,function() set(not value) end)
            return {Container=f,SetValue=function(v) set(v,false) end,GetValue=function() return value end,Set=set}
        end

        function tab:CreateSlider(o)
            o=o or {}; self._order+=1
            local range=o.Range or {0,100};local mn,mx=range[1] or 0,range[2] or 100;local step=o.Increment or 1;local value=math.clamp(o.CurrentValue or mn,mn,mx)
            local f=create("Frame",{Size=UDim2.new(1,0,0,66),BackgroundColor3=Colors.Element,BorderSizePixel=0,LayoutOrder=self._order},self.Content);corner(10,f)
            create("TextLabel",{Size=UDim2.new(1,-90,0,20),Position=UDim2.fromOffset(13,8),BackgroundTransparency=1,Text=o.Name or "Slider",TextColor3=Colors.Text,TextSize=12,Font=Enum.Font.GothamMedium,TextXAlignment=Enum.TextXAlignment.Left},f)
            local val=create("TextLabel",{Size=UDim2.fromOffset(70,20),Position=UDim2.new(1,-82,0,8),BackgroundTransparency=1,Text=tostring(value)..(o.Suffix or ""),TextColor3=Colors.Accent,TextSize=12,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Right},f)
            local track=create("Frame",{Size=UDim2.new(1,-28,0,7),Position=UDim2.fromOffset(14,47),BackgroundColor3=Colors.Slider,BorderSizePixel=0},f);corner(4,track)
            local fill=create("Frame",{Size=UDim2.new((value-mn)/(mx-mn),0,1,0),BackgroundColor3=Colors.SliderFill,BorderSizePixel=0},track);corner(4,fill)
            local knob=create("Frame",{Size=UDim2.fromOffset(15,15),Position=UDim2.new((value-mn)/(mx-mn),-7.5,.5,-7.5),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=2},track);corner(8,knob)
            local dragging=false
            local function set(v,callback)
                v=math.clamp(v,mn,mx);v=math.floor(v/step+.5)*step;value=v;local p=(v-mn)/(mx-mn)
                fill.Size=UDim2.new(p,0,1,0);knob.Position=UDim2.new(p,-7.5,.5,-7.5);val.Text=tostring(v)..(o.Suffix or "");if callback~=false then safe(o.Callback,v) end
            end
            connect(track.InputBegan,function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true;set((mn+(mx-mn)*math.clamp((input.Position.X-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1))) end end)
            connect(UserInputService.InputChanged,function(input) if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then set(mn+(mx-mn)*math.clamp((input.Position.X-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)) end end)
            connect(UserInputService.InputEnded,function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
            return {Container=f,SetValue=function(v)set(v,false)end,GetValue=function()return value end}
        end

        function tab:CreateInput(o)
            o=o or {};self._order+=1
            local f=create("Frame",{Size=UDim2.new(1,0,0,68),BackgroundColor3=Colors.Element,BorderSizePixel=0,LayoutOrder=self._order},self.Content);corner(10,f)
            create("TextLabel",{Size=UDim2.new(1,-28,0,18),Position=UDim2.fromOffset(13,7),BackgroundTransparency=1,Text=o.Name or "Input",TextColor3=Colors.Text,TextSize=12,Font=Enum.Font.GothamMedium,TextXAlignment=Enum.TextXAlignment.Left},f)
            local box=create("TextBox",{Size=UDim2.new(1,-28,0,34),Position=UDim2.fromOffset(14,28),BackgroundColor3=Colors.Input,BorderSizePixel=0,Text=o.Default or "",PlaceholderText=o.Placeholder or "Type here...",PlaceholderColor3=Colors.TextDark,TextColor3=Colors.Text,TextSize=11,Font=Enum.Font.Gotham,ClearTextOnFocus=o.ClearOnFocus or false},f);corner(8,box);padding(box,0,0,10,10)
            local s=stroke(Colors.Separator,1,0,box)
            connect(box.Focused,function() tween(s,{Color=Colors.Accent},.12) end)
            connect(box.FocusLost,function(enter) tween(s,{Color=Colors.Separator},.12);if enter then safe(o.Callback,box.Text) end end)
            return {Container=f,Input=box,GetValue=function()return box.Text end,SetValue=function(v)box.Text=tostring(v)end}
        end

        function tab:CreateDropdown(o)
            o=o or {};self._order+=1
            local options=o.Options or {};local multiple=o.MultipleOptions==true;local selected=o.CurrentOption
            if selected==nil then selected=multiple and {} or options[1] end
            local f=create("Frame",{Size=UDim2.new(1,0,0,70),BackgroundColor3=Colors.Element,BorderSizePixel=0,LayoutOrder=self._order,ClipsDescendants=false},self.Content);corner(10,f)
            create("TextLabel",{Size=UDim2.new(1,-28,0,18),Position=UDim2.fromOffset(13,6),BackgroundTransparency=1,Text=o.Name or "Dropdown",TextColor3=Colors.Text,TextSize=12,Font=Enum.Font.GothamMedium,TextXAlignment=Enum.TextXAlignment.Left},f)
            local select=create("TextButton",{Size=UDim2.new(1,-28,0,36),Position=UDim2.fromOffset(14,28),BackgroundColor3=Colors.Input,BorderSizePixel=0,Text="",AutoButtonColor=false},f);corner(8,select)
            local textLabel=create("TextLabel",{Size=UDim2.new(1,-38,1,0),Position=UDim2.fromOffset(10,0),BackgroundTransparency=1,Text="",TextColor3=Colors.Text,TextSize=11,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},select)
            create("TextLabel",{Size=UDim2.fromOffset(22,1),Position=UDim2.new(1,-26,.5,0),BackgroundTransparency=1,Text="⌄",TextColor3=Colors.TextMuted,TextSize=14,Font=Enum.Font.GothamBold},select)
            local open=false
            local popup=create("ScrollingFrame",{Size=UDim2.fromOffset(200,10),BackgroundColor3=Colors.Input,BorderSizePixel=0,Visible=false,ZIndex=5000,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),ScrollBarThickness=2,ScrollBarImageColor3=Colors.Accent},ScreenGui);corner(9,popup);stroke(Colors.Border,1,.35,popup);layout(popup,3);padding(popup,5,5,5,5)
            local chosen={}
            local function refresh()
                if multiple then local a={};for k in pairs(chosen)do table.insert(a,k)end;table.sort(a);textLabel.Text=#a==0 and "None" or (#a<=2 and table.concat(a,", ") or a[1].." +"..(#a-1))
                else textLabel.Text=tostring(selected or "None") end
            end
            if multiple and type(selected)=="table" then for _,v in ipairs(selected)do chosen[v]=true end end
            refresh()
            for _,opt in ipairs(options)do
                local ob=create("TextButton",{Size=UDim2.new(1,0,0,31),BackgroundColor3=Colors.Input,BorderSizePixel=0,Text=tostring(opt),TextColor3=Colors.Text,TextSize=11,Font=Enum.Font.Gotham,AutoButtonColor=false,ZIndex=5001},popup);corner(7,ob)
                connect(ob.MouseEnter,function()tween(ob,{BackgroundColor3=Colors.ElementHover},.08)end);connect(ob.MouseLeave,function()tween(ob,{BackgroundColor3=Colors.Input},.08)end)
                connect(ob.MouseButton1Click,function()
                    if multiple then chosen[opt]=not chosen[opt] and true or nil;refresh();local a={};for k in pairs(chosen)do table.insert(a,k)end;safe(o.Callback,a)
                    else selected=opt;refresh();popup.Visible=false;open=false;safe(o.Callback,opt) end
                end)
            end
            connect(select.MouseButton1Click,function()
                open=not open
                if open then popup.Size=UDim2.new(0,select.AbsoluteSize.X,0,math.min(#options*34+12,230));popup.Position=UDim2.fromOffset(select.AbsolutePosition.X,select.AbsolutePosition.Y+select.AbsoluteSize.Y+4);popup.Visible=true else popup.Visible=false end
            end)
            connect(UserInputService.InputBegan,function(input)
                if open and (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch) then
                    local p=UserInputService:GetMouseLocation();local q=popup.AbsolutePosition;local s=popup.AbsoluteSize
                    if p.X<q.X or p.X>q.X+s.X or p.Y<q.Y or p.Y>q.Y+s.Y then popup.Visible=false;open=false end
                end
            end)
            connect(f.Destroying,function()if popup.Parent then popup:Destroy()end end)
            return {Container=f,SetValue=function(v)if multiple then chosen={};for _,x in ipairs(v or {})do chosen[x]=true end else selected=v end;refresh()end,GetValue=function()if multiple then local a={};for k in pairs(chosen)do table.insert(a,k)end;return a end;return selected end}
        end

        function tab:CreateKeybind(o)
            o=o or {};self._order+=1
            local f=create("Frame",{Size=UDim2.new(1,0,0,50),BackgroundColor3=Colors.Element,BorderSizePixel=0,LayoutOrder=self._order},self.Content);corner(10,f)
            create("TextLabel",{Size=UDim2.new(1,-100,1,0),Position=UDim2.fromOffset(13,0),BackgroundTransparency=1,Text=o.Name or "Keybind",TextColor3=Colors.Text,TextSize=12,Font=Enum.Font.GothamMedium,TextXAlignment=Enum.TextXAlignment.Left},f)
            local key=o.CurrentKeybind or Enum.KeyCode.Unknown
            local b=create("TextButton",{Size=UDim2.fromOffset(82,30),Position=UDim2.new(1,-94,.5,-15),BackgroundColor3=Colors.Input,BorderSizePixel=0,Text=key.Name,TextColor3=Colors.Accent,TextSize=10,Font=Enum.Font.GothamBold,AutoButtonColor=false},f);corner(8,b)
            local listening=false
            connect(b.MouseButton1Click,function()listening=true;b.Text="Press key..." end)
            connect(UserInputService.InputBegan,function(input,gp)if listening and not gp then listening=false;if input.KeyCode~=Enum.KeyCode.Unknown then key=input.KeyCode;b.Text=key.Name;safe(o.Callback,key)end end end)
            return {Container=f,GetValue=function()return key end,SetValue=function(v)key=v;b.Text=v.Name end}
        end

        return tab
    end

    -- Dashboard / home
    local home=makeTab("Dashboard",SV.Icons.Home,{Order=0})
    home:CreateSection("Overview")
    local statsRow=create("Frame",{Size=UDim2.new(1,0,0,82),BackgroundTransparency=1,LayoutOrder=1},home.Content)
    local grid=create("UIGridLayout",{CellSize=UDim2.new(.25,-8,1,0),CellPadding=UDim2.fromOffset(10,0),SortOrder=Enum.SortOrder.LayoutOrder},statsRow)
    local fpsLabel=makeStat(statsRow,"FPS","--",Colors.Accent)
    local pingLabel=makeStat(statsRow,"PING","-- ms",Colors.Success)
    local memLabel=makeStat(statsRow,"MEMORY","-- MB",Colors.Warning)
    local sessionLabel=makeStat(statsRow,"SESSION","00:00",Colors.Text)
    home:CreateParagraph({Title="Welcome to ScriptVault",Content="A refreshed control center with faster navigation, cleaner component states, responsive layout, command search and improved window management.",Icon=SV.Icons.Star})
    home:CreateSection("Quick Start")
    home:CreateLabel("Use the sidebar to switch sections. Press Ctrl+K to search tabs or "..ToggleKeybind.Name.." to hide/show the window.")
    activate(home)

    -- command palette
    local overlay=create("Frame",{Size=UDim2.fromScale(1,1),BackgroundColor3=Colors.Overlay,BackgroundTransparency=.35,BorderSizePixel=0,Visible=false,ZIndex=9000},ScreenGui)
    local paletteFrame=create("Frame",{Size=UDim2.new(0,480,0,370),Position=UDim2.new(.5,-240,.5,-185),BackgroundColor3=Colors.Sidebar,BorderSizePixel=0,ZIndex=9001},overlay);corner(16,paletteFrame);stroke(Colors.Border,1,.35,paletteFrame)
    local paletteSearch=create("TextBox",{Size=UDim2.new(1,-24,0,44),Position=UDim2.fromOffset(12,12),BackgroundColor3=Colors.Input,BorderSizePixel=0,PlaceholderText="Search pages...",PlaceholderColor3=Colors.TextDark,TextColor3=Colors.Text,Text="",TextSize=12,Font=Enum.Font.Gotham,ClearTextOnFocus=false,ZIndex=9002},paletteFrame);corner(10,paletteSearch);padding(paletteSearch,0,0,12,12)
    local results=create("ScrollingFrame",{Size=UDim2.new(1,-24,1,-68),Position=UDim2.fromOffset(12,64),BackgroundTransparency=1,BorderSizePixel=0,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),ScrollBarThickness=2,ZIndex=9002},paletteFrame);layout(results,5);padding(results,2,4,2,2)

    local function rebuildResults(query)
        for _,c in ipairs(results:GetChildren())do if c:IsA("TextButton") then c:Destroy() end end
        query=string.lower(query or "")
        for _,t in ipairs(tabs)do
            if query=="" or string.find(string.lower(t.Name),query,1,true) then
                local b=create("TextButton",{Size=UDim2.new(1,0,0,42),BackgroundColor3=Colors.Element,BorderSizePixel=0,Text=t.Name,TextColor3=Colors.Text,TextSize=12,Font=Enum.Font.GothamMedium,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false,ZIndex=9003},results);corner(9,b);padding(b,0,0,12,12)
                connect(b.MouseButton1Click,function()activate(t);overlay.Visible=false;paletteSearch.Text=""end)
            end
        end
    end
    connect(paletteSearch:GetPropertyChangedSignal("Text"),function()rebuildResults(paletteSearch.Text)end)
    rebuildResults("")

    connect(search:GetPropertyChangedSignal("Text"),function()
        local q=string.lower(search.Text)
        for _,t in ipairs(tabs)do t.Button.Visible=(q=="" or string.find(string.lower(t.Name),q,1,true)~=nil) end
    end)
    connect(search.Focused,function()tween(searchStroke,{Color=Colors.Accent},.12)end)
    connect(search.FocusLost,function()tween(searchStroke,{Color=Colors.Separator},.12)end)

    local minimized=false
    local restore=create("TextButton",{Size=UDim2.fromOffset(58,58),Position=UDim2.new(1,-78,.5,-29),BackgroundColor3=Colors.Accent,BorderSizePixel=0,Text="SV",TextColor3=Color3.new(1,1,1),TextSize=15,Font=Enum.Font.GothamBold,Visible=false,ZIndex=8000,AutoButtonColor=false},ScreenGui);corner(18,restore);stroke(Colors.AccentHover,2,.1,restore)

    local function setMin(v)
        minimized=v
        if v then
            Window.Visible=false;Shadow.Visible=false;restore.Visible=true
        else
            restore.Visible=false;Window.Visible=true;Shadow.Visible=true
        end
    end
    connect(minimize.MouseButton1Click,function()setMin(true)end)
    connect(restore.MouseButton1Click,function()setMin(false)end)
    connect(close.MouseButton1Click,function()
        disconnectAll()
        ScreenGui:Destroy()
    end)

    -- Dragging
    local dragging=false;local dragStart;local startPos
    connect(Top.InputBegan,function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true;dragStart=input.Position;startPos=Window.Position
        end
    end)
    connect(UserInputService.InputChanged,function(input)
        if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
            local d=input.Position-dragStart
            Window.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
            Shadow.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X-14,startPos.Y.Scale,startPos.Y.Offset+d.Y+10)
        end
    end)
    connect(UserInputService.InputEnded,function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end end)

    -- Resize handle
    local handle=create("TextButton",{Size=UDim2.fromOffset(24,24),Position=UDim2.new(1,-24,1,-24),BackgroundTransparency=1,Text="⋰",TextColor3=Colors.TextMuted,TextSize=15,Font=Enum.Font.GothamBold,AutoButtonColor=false},Window)
    local resizing=false;local resizeStart;local resizeSize
    connect(handle.InputBegan,function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then resizing=true;resizeStart=input.Position;resizeSize=Window.AbsoluteSize end end)
    connect(UserInputService.InputChanged,function(input)if resizing and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then local d=input.Position-resizeStart;local w=math.max(MinWidth,resizeSize.X+d.X);local h=math.max(MinHeight,resizeSize.Y+d.Y);Window.Size=UDim2.fromOffset(w,h);Shadow.Size=UDim2.fromOffset(w+28,h+28)end end)
    connect(UserInputService.InputEnded,function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then resizing=false end end)

    local collapsed=false
    connect(collapse.MouseButton1Click,function()
        collapsed=not collapsed
        sidebarCollapsed=collapsed
        local target=collapsed and 62 or SidebarWidth
        tween(Sidebar,{Size=UDim2.new(0,target,1,-58)},.22)
        tween(Content,{Position=UDim2.new(0,target,0,58),Size=UDim2.new(1,-target,1,-58)},.22)
        tween(Shadow,{Size=UDim2.fromOffset(Window.AbsoluteSize.X+28,Window.AbsoluteSize.Y+28)},.12)
        collapse.Text=collapsed and "›" or "‹"
        for _,t in ipairs(tabs)do
            t.Label.Visible=not collapsed
            for _,c in ipairs(t.Button:GetChildren())do if c:IsA("TextLabel") and c.Text~=tostring(t.Name) then end end
        end
    end)

    -- keyboard
    connect(UserInputService.InputBegan,function(input,gp)
        if gp then return end
        if input.KeyCode==ToggleKeybind then setMin(not minimized) end
        if (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) and input.KeyCode==Enum.KeyCode.K then
            overlay.Visible=true;rebuildResults("");paletteSearch:CaptureFocus()
        elseif input.KeyCode==Enum.KeyCode.Escape then
            overlay.Visible=false
        end
    end)
    connect(overlay.InputBegan,function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then local p=input.Position;local q=paletteFrame.AbsolutePosition;local s=paletteFrame.AbsoluteSize;if p.X<q.X or p.X>q.X+s.X or p.Y<q.Y or p.Y>q.Y+s.Y then overlay.Visible=false end end end)

    local startTime=tick()
    connect(RunService.RenderStepped,function()
        local elapsed=tick()-startTime
        local fps=0
    end)
    task.spawn(function()
        local frames=0;local last=tick()
        while ScreenGui.Parent do
            task.wait(1)
            frames=0
            local now=tick()
            local start=now
            while tick()-start<.15 do
                frames+=1
                RunService.RenderStepped:Wait()
            end
            local fps=math.floor(frames/math.max(tick()-start,.001))
            fpsLabel.Text=tostring(fps)
            pingLabel.Text=tostring(getPing()).." ms"
            memLabel.Text=tostring(getMemory()).." MB"
            sessionLabel.Text=string.format("%02d:%02d",math.floor((tick()-startTime)/60)%60,math.floor(tick()-startTime)%60)
        end
    end)

    -- AutoFarm-focused UX layer
    local farmTab=makeTab("AutoFarm",SV.Icons.Farm,{Order=1})
    farmTab:CreateSection("Control Center")
    local farmEnabled=false
    local farmMode="Balanced"
    local target="Nearest"
    local farmStatus=farmTab:CreateParagraph({Title="AutoFarm Status",Content="Ready • Configure the options below and connect your callbacks.",Icon=SV.Icons.Farm})
    farmTab:CreateToggle({Name="Enable AutoFarm",Description="Master switch for the automation layer.",Callback=function(v) farmEnabled=v; farmStatus= farmStatus end})
    farmTab:CreateDropdown({Name="Farm Mode",Options={"Balanced","Fast","Safe","Custom"},CurrentOption="Balanced",Callback=function(v) farmMode=v end})
    farmTab:CreateDropdown({Name="Target Selection",Options={"Nearest","Lowest HP","Highest Value","Selected Zone"},CurrentOption="Nearest",Callback=function(v) target=v end})
    farmTab:CreateSlider({Name="Action Delay",Range={0,5000},CurrentValue=500,Increment=50,Suffix=" ms"})
    farmTab:CreateSection("Automation")
    farmTab:CreateToggle({Name="Auto Collect",Description="Enable automatic collection when your script provides the action callback."})
    farmTab:CreateToggle({Name="Auto Sell",Description="Enable automatic selling through your connected farm logic."})
    farmTab:CreateToggle({Name="Auto Reconnect",Description="Expose a reconnect state for your own connection handler."})
    farmTab:CreateToggle({Name="Anti-AFK",Description="UI control only; connect the callback to your own implementation."})
    farmTab:CreateSection("Session")
    farmTab:CreateButton({Name="Start / Stop Session",Variant="Primary",Callback=function() farmEnabled=not farmEnabled end})
    farmTab:CreateButton({Name="Emergency Stop",Variant="Error",Callback=function() farmEnabled=false end})
    farmTab:CreateParagraph({Title="Integration API",Content="Use the returned control objects and callbacks to connect this interface to your existing AutoFarm logic. The UI itself does not assume a specific game mechanic."})

    local monitorTab=makeTab("Monitor",SV.Icons.Stats,{Order=2})
    monitorTab:CreateSection("Live Metrics")
    monitorTab:CreateParagraph({Title="Runtime Monitor",Content="Use Dashboard for FPS, ping, memory and session time. Add game-specific counters here through your own callbacks."})
    monitorTab:CreateSlider({Name="Update Interval",Range={100,5000},CurrentValue=1000,Increment=100,Suffix=" ms"})

    local settingsTab=makeTab("Settings",SV.Icons.Settings,{Order=99})
    settingsTab:CreateSection("Interface")
    settingsTab:CreateToggle({Name="Reduced Motion",Description="Prefer minimal UI animation for lower visual overhead."})
    settingsTab:CreateToggle({Name="Compact Sidebar",Description="Keep navigation condensed for smaller screens."})
    settingsTab:CreateKeybind({Name="Toggle Window",CurrentKeybind=ToggleKeybind})
    settingsTab:CreateSection("Safety")
    settingsTab:CreateButton({Name="Emergency UI Hide",Variant="Warning",Callback=function() setMin(true) end})

    -- Public window API
    local api={}\n    api.Farm={GetEnabled=function() return farmEnabled end,GetMode=function() return farmMode end,GetTarget=function() return target end,Stop=function() farmEnabled=false end}
    api.Instance=Window
    api.ScreenGui=ScreenGui
    api.Tabs=tabs
    api.Theme=Colors
    api.IsMinimized=function()return minimized end
    api.Toggle=function()setMin(not minimized)end
    api.Minimize=function()setMin(true)end
    api.Restore=function()setMin(false)end
    api.Destroy=function()if ScreenGui.Parent then disconnectAll();ScreenGui:Destroy()end end
    api.SelectTab=function(name)for _,t in ipairs(tabs)do if t.Name==name then activate(t);return t end end end
    api.OpenCommandPalette=function()overlay.Visible=true;rebuildResults("");paletteSearch:CaptureFocus()end
    api.SetTheme=function(name)
        if not Themes[name] then return false end
        -- Theme hot-swap is exposed for future component instances; current controls retain their created palette.
        api.ThemeName=name
        return true
    end
    function api:CreateTab(name,iconId,opts) return makeTab(name,iconId,opts) end
    api.CreateTab=api.CreateTab
    api.Notify=function(o)
        o=o or {}
        local holder=ScreenGui:FindFirstChild("Notifications") or create("Frame",{Name="Notifications",Size=UDim2.fromOffset(330,1),Position=UDim2.new(1,-346,0,20),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y,ZIndex=7000},ScreenGui)
        if not holder:FindFirstChildOfClass("UIListLayout") then layout(holder,8) end
        local n=create("Frame",{Size=UDim2.new(1,0,0,68),BackgroundColor3=Colors.Element,BorderSizePixel=0,ZIndex=7001},holder);corner(12,n);stroke(Colors.Separator,1,.2,n)
        local bar=create("Frame",{Size=UDim2.fromOffset(3,44),Position=UDim2.fromOffset(8,12),BackgroundColor3=o.Color or Colors.Accent,BorderSizePixel=0,ZIndex=7002},n);corner(2,bar)
        create("TextLabel",{Size=UDim2.new(1,-34,0,20),Position=UDim2.fromOffset(20,8),BackgroundTransparency=1,Text=o.Title or "ScriptVault",TextColor3=Colors.Text,TextSize=12,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=7002},n)
        create("TextLabel",{Size=UDim2.new(1,-34,0,30),Position=UDim2.fromOffset(20,29),BackgroundTransparency=1,Text=o.Content or "",TextColor3=Colors.TextMuted,TextSize=10,Font=Enum.Font.Gotham,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=7002},n)
        task.delay(o.Duration or 3,function()if n.Parent then n:Destroy()end end)
        return n
    end

    if options.LoadingScreen~=false then
        Window.Visible=false;Shadow.Visible=false
        task.delay(options.LoadingDuration or .45,function()if ScreenGui.Parent then Window.Visible=true;Shadow.Visible=true end end)
    end

    return api
end

SV.Themes=Themes
SV.GetTheme=function(name)return Themes[name]end
SV.IsTouchDevice=isTouch
SV.FormatNumber=fmt
SV.GetPing=getPing
SV.GetMemory=getMemory

return SV
