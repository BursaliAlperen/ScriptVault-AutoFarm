-- Copy this file for each new auto-farm.
-- Keep the key gate at the beginning of the script.

local Players = game:GetService("Players")
local KeyGate = require(script.Parent.KeyGate)

local player = Players.LocalPlayer
local userId = player and player.UserId

-- Example:
-- local ok, result = KeyGate.Verify(savedKey, userId)
-- if not ok then
--     warn("ScriptVault key required: " .. tostring(result))
--     return
-- end

-- Your auto-farm implementation starts here.
print("Auto-farm loaded after key verification.")
