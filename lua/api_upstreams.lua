-- api_upstreams.lua
-- Upstream statistics endpoint

local cjson = require("cjson.safe")

-- This is a basic implementation
-- For more advanced upstream stats, you'd need to integrate with
-- lua-resty-upstream-healthcheck or similar modules

local response = {
    upstreams = {
        backend_servers = {
            peers = {},
            keepalive = 0,
            zombies = 0
        },
        api_backend = {
            peers = {},
            keepalive = 0,
            zombies = 0
        }
    },
    timestamp = ngx.time(),
    note = "For detailed upstream health checks, integrate lua-resty-upstream-healthcheck"
}

local json_response, err = cjson.encode(response)
if not json_response then
    ngx.status = 500
    ngx.say('{"error":"Failed to encode JSON"}')
    return
end

ngx.say(json_response)
