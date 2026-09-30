-- Ride-A-Pet Auto-Farm loader
-- Intended for a game you own/control.
--
-- Place Autofarm.lua and Adapter.lua as ModuleScripts in the same Roblox
-- container, then require this loader from your own server/client code.
--
-- Example:
-- local Loader = require(path.To.Loader)
-- local farm = Loader.Start(path.To.Adapter)
-- farm:SetInterval(0.75)
--
-- This intentionally does not use loadstring/game:HttpGet or undocumented
-- third-party RemoteEvents.

local Loader = {}

function Loader.Start(adapterModule)
    assert(adapterModule, "Adapter ModuleScript is required")

    local Autofarm = require(script.Parent.Autofarm)
    local Adapter = require(adapterModule)

    local adapter = Adapter.new()
    local farm = Autofarm.new(adapter)
    farm:Start()

    return farm
end

return Loader
