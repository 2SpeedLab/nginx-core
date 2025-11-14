-- log_metrics.lua
-- Collect metrics for each request in log phase

local host = ngx.var.host or "-"
local status = ngx.var.status or "000"
local method = ngx.var.request_method or "-"

-- Track total requests
_G.metric_requests:inc(1, {host, status, method})

-- Track status codes
_G.metric_status_codes:inc(1, {status, host})

-- Track request duration
if ngx.var.request_time then
    local request_time = tonumber(ngx.var.request_time)
    if request_time then
        _G.metric_request_duration:observe(request_time, {host})
    end
end

-- Track request size
if ngx.var.request_length then
    local request_length = tonumber(ngx.var.request_length)
    if request_length then
        _G.metric_request_size:observe(request_length, {host})
    end
end

-- Track response size
if ngx.var.bytes_sent then
    local bytes_sent = tonumber(ngx.var.bytes_sent)
    if bytes_sent then
        _G.metric_response_size:observe(bytes_sent, {host})
    end
end

-- Track upstream metrics
if ngx.var.upstream_addr then
    local upstream = ngx.var.upstream_addr
    
    -- Track upstream requests
    _G.metric_upstream_requests:inc(1, {upstream, status})
    
    -- Track upstream response time
    if ngx.var.upstream_response_time then
        local upstream_time = tonumber(ngx.var.upstream_response_time)
        if upstream_time then
            _G.metric_upstream_time:observe(upstream_time, {upstream})
        end
    end
end

-- Track connections using our own metrics (no dependency on ngx.stat or stub_status)
-- These are tracked automatically by prometheus based on our counters
-- No need to query ngx.stat() or stub_status on every request