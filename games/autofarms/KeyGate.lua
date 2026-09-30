-- Shared key gate for every auto-farm.
-- The backend must be deployed separately and configured with Linkvertise secrets.
-- Replace BACKEND_URL with your deployed HTTPS backend URL.

local KeyGate = {}
KeyGate.BACKEND_URL = "https://YOUR-BACKEND.example.com"

local HttpService = game:GetService("HttpService")

local function requestJson(path, body)
    local ok, response = pcall(function()
        return HttpService:PostAsync(
            KeyGate.BACKEND_URL .. path,
            HttpService:JSONEncode(body),
            Enum.HttpContentType.ApplicationJson
        )
    end)

    if not ok then
        return false, tostring(response)
    end

    local decodedOk, decoded = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    if not decodedOk then
        return false, "Invalid server response"
    end

    return true, decoded
end

function KeyGate.Verify(key, userId, farmId)
    if type(key) ~= "string" or key == "" then
        return false, "Key is required"
    end

    local ok, result = requestJson("/api/verify", {
        key = key,
        userId = tostring(userId or ""),
        farmId = tostring(farmId or "")
    })

    if not ok then
        return false, result
    end

    if result.success then
        return true, result
    end

    return false, result.message or "Key rejected"
end

function KeyGate.Unlock(hash, userId, farmId)
    if type(hash) ~= "string" or hash == "" then
        return false, "Linkvertise hash is required"
    end

    local ok, result = requestJson("/api/unlock", {
        hash = hash,
        userId = tostring(userId or ""),
        farmId = tostring(farmId or "")
    })

    if not ok then
        return false, result
    end

    if result.success and result.key then
        return true, result
    end

    return false, result.message or "Unlock failed"
end

return KeyGate
