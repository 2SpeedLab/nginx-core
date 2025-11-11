-- api_connections.lua
-- Connections statistics endpoint

local cjson = require("cjson.safe")

local stats = ngx.stat()

local response = {
    active = stats and stats.active or 0,
    reading = stats and stats.reading or 0,
    writing = stats and stats.writing or 0,
    waiting = stats and stats.waiting or 0,
    accepted = stats and stats.accepted or 0,
    handled = stats and stats.handled or 0,
    requests = stats and stats.requests or 0,
    dropped = (stats and stats.accepted or 0) - (stats and stats.handled or 0),
    timestamp = ngx.time()
}

local json_response, err = cjson.encode(response)
if not json_response then
    ngx.status = 500
    ngx.say('{"error":"Failed to encode JSON"}')
    return
end

ngx.say(json_response)
