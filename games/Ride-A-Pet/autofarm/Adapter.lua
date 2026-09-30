local Adapter = {}
Adapter.__index = Adapter

function Adapter.new()
    return setmetatable({}, Adapter)
end

function Adapter:getState()
    return {}
end

function Adapter:collectPets(_state)
    return true
end

function Adapter:feedPets(_state)
    return true
end

function Adapter:collectEggs(_state)
    return true
end

function Adapter:buyUpgrades(_state)
    return true
end

function Adapter:rebirth(_state)
    return true
end

return Adapter
