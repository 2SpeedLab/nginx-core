-- metrics_endpoint.lua
-- Serve Prometheus metrics

ngx.header["Content-Type"] = "text/plain; version=0.0.4"

-- Use the global prometheus object initialized in init_metrics.lua
if _G.prometheus then
    _G.prometheus:collect()
else
    ngx.log(ngx.ERR, "Prometheus not initialized! Check init_worker_by_lua_file")
    ngx.status = 500
    ngx.say("# ERROR: Prometheus not initialized")
end