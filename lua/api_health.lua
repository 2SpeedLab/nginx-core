-- api_health.lua
-- Health check endpoint

local cjson = require("cjson.safe")

local response = {
    status = "healthy",
    timestamp = ngx.time(),
    uptime = ngx.now() - ngx.update_time(),
    version = ngx.config.nginx_version
}

local json_response, err = cjson.encode(response)
if not json_response then
    ngx.status = 500
    ngx.say('{"error":"Failed to encode JSON"}')
    return
end

ngx.say(json_response)
