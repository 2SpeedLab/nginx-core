-- api_stats.lua
-- Complete statistics API endpoint (Nginx Plus style)

local cjson = require("cjson.safe")

-- Get current connection stats
local stats = ngx.stat()

-- Build response
local response = {
    version = ngx.config.nginx_version,
    nginx_build = ngx.config.ngx_lua_version,
    timestamp = ngx.time(),
    generation = os.time(),
    
    connections = {
        active = stats and stats.active or 0,
        reading = stats and stats.reading or 0,
        writing = stats and stats.writing or 0,
        waiting = stats and stats.waiting or 0,
        accepted = stats and stats.accepted or 0,
        handled = stats and stats.handled or 0,
        requests = stats and stats.requests or 0
    },
    
    server_zones = {},
    upstreams = {},
    
    load = {
        timestamp = ngx.time(),
        generation = os.time()
    }
}

-- Encode and send response
local json_response, err = cjson.encode(response)
if not json_response then
    ngx.status = 500
    ngx.say('{"error":"Failed to encode JSON: ' .. (err or "unknown error") .. '"}')
    return
end

ngx.say(json_response)
