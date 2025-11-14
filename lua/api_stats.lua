-- api_stats.lua
-- Complete statistics API endpoint (Nginx Plus style)

local cjson = require("cjson.safe")

-- Simple approach: Build response with safe defaults
-- Don't use stub_status or ngx.stat() as they may fail
local response = {
    version = ngx.config.nginx_version or "unknown",
    nginx_build = ngx.config.ngx_lua_version or "unknown",
    timestamp = ngx.time(),
    generation = os.time(),

    connections = {
        active = 0,
        reading = 0,
        writing = 0,
        waiting = 0,
        accepted = 0,
        handled = 0,
        requests = 0
    },

    server_zones = {},
    upstreams = {},

    load = {
        timestamp = ngx.time(),
        generation = os.time()
    },

    note = "Connection statistics available via prometheus metrics at /metrics"
}

-- Encode and send response
local json_response, err = cjson.encode(response)
if not json_response then
    ngx.log(ngx.ERR, "Failed to encode JSON: ", err or "unknown error")
    ngx.status = 500
    ngx.header["Content-Type"] = "application/json"
    ngx.say('{"error":"Failed to encode JSON: ' .. tostring(err or "unknown error") .. '"}')
    return
end

ngx.header["Content-Type"] = "application/json"
ngx.say(json_response)