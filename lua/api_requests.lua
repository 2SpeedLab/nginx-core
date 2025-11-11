-- api_requests.lua
-- Request statistics endpoint

local cjson = require("cjson.safe")
local shared_stats = ngx.shared.stats_cache

-- Try to get cached stats
local cached_data = shared_stats:get("request_stats")
local response

if cached_data then
    response = cjson.decode(cached_data)
    response.cached = true
else
    local stats = ngx.stat()
    
    response = {
        total = stats and stats.requests or 0,
        current = (stats and stats.reading or 0) + (stats and stats.writing or 0),
        timestamp = ngx.time(),
        cached = false
    }
    
    -- Cache for 5 seconds
    local encoded = cjson.encode(response)
    if encoded then
        shared_stats:set("request_stats", encoded, 5)
    end
end

local json_response, err = cjson.encode(response)
if not json_response then
    ngx.status = 500
    ngx.say('{"error":"Failed to encode JSON"}')
    return
end

ngx.say(json_response)
