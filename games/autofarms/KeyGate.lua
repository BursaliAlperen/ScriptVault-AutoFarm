-- Shared key gate for every auto-farm.
-- The backend must be deployed separately and configured with Linkvertise secrets.
-- Replace BACKEND_URL with your deployed HTTPS backend URL.

local HttpService = game:GetService("HttpService")

local KeyGate = {}

KeyGate.BACKEND_URL = "https://YOUR-BACKEND.example.com"

local function requestJson(method, path, body)
    local url = KeyGate.BACKEND_URL .. path
    local ok, response = pcall(function()
        if method == "GET" then
            return HttpService:GetAsync(url)
        end
        return HttpService:PostAsync(
            url,
            HttpService:JSONEncode(body or {}),
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

function KeyGate.Verify(key, userId)
    if type(key) ~= "string" or key == "" then
        return false, "Key is required"
    end

    local ok, result = requestJson("POST", "/api/verify", {
        key = key,
        userId = tostring(userId or "")
    })

    if not ok then
        return false, result
    end

    if result.success then
        return true, result
    end

    return false, result.error or "Key rejected"
end

function KeyGate.Unlock(hash, userId)
    if type(hash) ~= "string" or hash == "" then
        return false, "Linkvertise hash is required"
    end

    local ok, result = requestJson("POST", "/api/unlock", {
        hash = hash,
        userId = tostring(userId or "")
    })

    if not ok then
        return false, result
    end

    if result.success and result.key then
        return true, result
    end

    return false, result.error or "Unlock failed"
end

return KeyGate
