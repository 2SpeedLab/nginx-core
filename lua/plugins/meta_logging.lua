--- collect HTTP request/response metadata

local cjson = require "cjson.safe"
local _M = {}

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

local function safe_get(func, ...)
    local success, result = pcall(func, ...)
    if success then
        return result
    end
    return nil
end

local function headers_to_table(headers)
    if not headers then return {} end
    local result = {}
    for k, v in pairs(headers) do
        result[k] = v
    end
    return result
end

local function get_client_ip()
    local headers = ngx.req.get_headers()
    return headers["X-Real-IP"]
        or headers["X-Forwarded-For"]
        or ngx.var.remote_addr
end

local function parse_user_agent(ua_string)
    if not ua_string then return {} end

    return {
        raw = ua_string,
        browser = "Unknown",
        browser_version = "Unknown",
        os = "Unknown",
        os_version = "Unknown",
        is_mobile = ua_string:match("Mobile") ~= nil,
        is_tablet = ua_string:match("Tablet") or ua_string:match("iPad") ~= nil,
        is_desktop = not (ua_string:match("Mobile") or ua_string:match("Tablet")),
        is_bot = ua_string:match("[Bb]ot") or ua_string:match("[Ss]pider") or ua_string:match("[Cc]rawler") ~= nil
    }
end

local function generate_trace_id()
    return string.format("trace_%s-%s-%s-%s-%s",
        ngx.var.pid,
        ngx.now(),
        ngx.var.connection,
        ngx.var.connection_requests,
        ngx.var.msec)
end

local function generate_span_id()
    return string.format("span_%s", ngx.md5(tostring(ngx.now())))
end

local function parse_query_params(query_string)
    if not query_string or query_string == "" then
        return {}
    end

    local params = {}
    for pair in query_string:gmatch("[^&]+") do
        local key, value = pair:match("([^=]+)=?(.*)")
        if key then
            params[key] = value
        end
    end
    return params
end

local function calculate_compression_ratio(original, compressed)
    if not original or not compressed or original == 0 then
        return 0
    end
    return compressed / original
end

-- ============================================================================
-- METADATA FOR LOG
-- ============================================================================
function _M.log()
    local ngx.now()


