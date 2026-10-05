local BASE_URL = "https://raw.githubusercontent.com/voidzep/cerium-config/main/"

local http_service = game:GetService("HttpService")

local lib = {
    version      = "0.0.0",
    items        = {},

    valid_items  = {},
    sell_skip    = {},

    blacklist    = {},
    quest        = {},

    sell         = { texts = {} },
    combat_rotation = {},

    defaults     = {},
    locations    = {},

    idle_points  = {},
}

function lib.reload()
    local url = BASE_URL .. "config.json?t=" .. math.floor(tick())
    local ok, raw = pcall(function() return game:HttpGet(url) end)

    if not ok or not raw or raw == "" then
        lib._error = "http failed"
        return false
    end

    local ok2, data = pcall(function() return http_service:JSONDecode(raw) end)

    if not ok2 or type(data) ~= "table" then
        lib._error = "json failed"
        return false
    end

    for k, v in pairs(data) do lib[k] = v end
    lib._error = nil
    return true
end

lib.reload()
return lib
