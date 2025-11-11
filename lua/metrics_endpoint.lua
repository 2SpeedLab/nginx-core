-- metrics_endpoint.lua
-- Serve Prometheus metrics

ngx.header["Content-Type"] = "text/plain; version=0.0.4"
_G.prometheus:collect()
