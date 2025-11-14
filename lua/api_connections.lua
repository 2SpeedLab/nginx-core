-- api_connections.lua
-- Connections statistics endpoint

local cjson = require("cjson.safe")

-- Try to get stats with error handling
local stats = nil
local ok, result = pcall(function()
    return ngx.stat()
end)

if ok then
    stats = result
else
    ngx.log(ngx.WARN, "ngx.stat() not available: ", result)
end

local response = {
    active = stats and stats.active or 0,
    reading = stats and stats.reading or 0,
    writing = stats and stats.writing or 0,
    waiting = stats and stats.waiting or 0,
    accepted = stats and stats.accepted or 0,
    handled = stats and stats.handled or 0,
    requests = stats and stats.requests or 0,
    dropped = stats and ((stats.accepted or 0) - (stats.handled or 0)) or 0,
    timestamp = ngx.time()
}

if not stats then
    response.warning = "Connection statistics not available (ngx.stat() unsupported)"
end

local json_response, err = cjson.encode(response)
if not json_response then
    ngx.log(ngx.ERR, "Failed to encode JSON: ", err)
    ngx.status = 500
    ngx.header["Content-Type"] = "application/json"
    ngx.say('{"error":"Failed to encode JSON"}')
    return
end

ngx.header["Content-Type"] = "application/json"
ngx.say(json_response)