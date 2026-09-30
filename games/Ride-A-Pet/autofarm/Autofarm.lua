local Autofarm = {}
Autofarm.__index = Autofarm

function Autofarm.new(adapter)
    assert(type(adapter) == "table", "Ride-A-Pet adapter is required")
    local self = setmetatable({}, Autofarm)
    self.Adapter = adapter
    self.Enabled = false
    self.Interval = 0.75
    self._busy = false
    return self
end

local function call(adapter, name, ...)
    local fn = adapter[name]
    if type(fn) ~= "function" then return false, name .. " is not implemented" end
    local ok, a, b = pcall(fn, adapter, ...)
    if not ok then return false, tostring(a) end
    if a == false then return false, b or (name .. " failed") end
    return true, a
end

function Autofarm:SetInterval(seconds)
    self.Interval = math.clamp(tonumber(seconds) or 0.75, 0.15, 10)
end

function Autofarm:Step()
    if self._busy then return end
    self._busy = true
    local ok, state = call(self.Adapter, "getState")
    if not ok then self._busy = false; return false, state end
    local actions = {"collectPets", "feedPets", "collectEggs", "buyUpgrades", "rebirth"}
    for _, action in ipairs(actions) do call(self.Adapter, action, state) end
    self._busy = false
    return true
end

function Autofarm:Start()
    if self.Enabled then return end
    self.Enabled = true
    task.spawn(function()
        while self.Enabled do
            self:Step()
            task.wait(self.Interval)
        end
    end)
end

function Autofarm:Stop()
    self.Enabled = false
end

function Autofarm:Destroy()
    self:Stop()
end

return Autofarm
