-- Rayfield-style UI example for a Roblox experience you own/control.
-- Uses the repository's ScriptVaultUI library and does not invoke undocumented
-- third-party RemoteEvents.

local ScriptVaultUI = require(script.Parent.Parent.Parent.Parent.ScriptVaultUI)

local Window = ScriptVaultUI:CreateWindow({
    Name = "Ride-A-Pet",
    LoadingTitle = "Ride-A-Pet",
    LoadingSubtitle = "Auto-Farm Control Panel",
    Theme = "DarkBlue",
})

local Main = Window:CreateTab("Main", 0)

Main:SectionLabel("Automation")
Main:Paragraph({
    Title = "Server-authoritative scaffold",
    Content = "Connect these controls to your own documented game systems."
})

Main:Toggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(value)
        ScriptVaultUI:Notify({
            Title = "Auto Farm",
            Content = value and "Enabled" or "Disabled",
            Duration = 2
        })
    end
})

Main:Slider({
    Name = "Interval",
    Min = 0.15,
    Max = 10,
    Default = 0.75,
    Increment = 0.05,
    Suffix = "s",
    Flag = "Interval",
    Callback = function(value)
        -- Bind this value to your own server-authoritative farm controller.
    end
})

Main:Button({
    Name = "Run One Step",
    Callback = function()
        ScriptVaultUI:Notify({
            Title = "Auto Farm",
            Content = "Step requested.",
            Duration = 2
        })
    end
})

local Settings = Window:CreateTab("Settings", 0)

Settings:SectionLabel("Interface")
Settings:Dropdown({
    Name = "Theme",
    Options = {"DarkBlue", "Dark", "Light"},
    CurrentOption = "DarkBlue",
    Flag = "Theme",
    Callback = function(option)
        -- Theme selection can be wired to the UI library when supported.
    end
})

Settings:Paragraph({
    Title = "Note",
    Content = "This example intentionally contains no executor loader or undocumented remote calls."
})

return Window
