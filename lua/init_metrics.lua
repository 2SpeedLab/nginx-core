-- init_metrics.lua
-- Initialize Prometheus metrics on worker start

local prometheus = require("prometheus").init("prometheus_metrics")

-- Global metrics objects
_G.prometheus = prometheus

-- Counter: Total HTTP requests
_G.metric_requests = prometheus:counter(
    "nginx_http_requests_total", 
    "Total number of HTTP requests", 
    {"host", "status", "method"}
)

-- Counter: Total requests by upstream
_G.metric_upstream_requests = prometheus:counter(
    "nginx_upstream_requests_total",
    "Total requests to upstream",
    {"upstream", "status"}
)

-- Gauge: Current connections
_G.metric_connections = prometheus:gauge(
    "nginx_connections_current",
    "Current number of connections",
    {"state"}
)

-- Histogram: Request duration
_G.metric_request_duration = prometheus:histogram(
    "nginx_http_request_duration_seconds",
    "HTTP request latency in seconds",
    {"host"},
    {0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10}
)

-- Histogram: Request size
_G.metric_request_size = prometheus:histogram(
    "nginx_http_request_size_bytes",
    "HTTP request size in bytes",
    {"host"},
    {10, 100, 1000, 10000, 100000, 1000000, 10000000}
)

-- Histogram: Response size
_G.metric_response_size = prometheus:histogram(
    "nginx_http_response_size_bytes",
    "HTTP response size in bytes",
    {"host"},
    {10, 100, 1000, 10000, 100000, 1000000, 10000000}
)

-- Histogram: Upstream response time
_G.metric_upstream_time = prometheus:histogram(
    "nginx_http_upstream_response_time_seconds",
    "Upstream response time in seconds",
    {"upstream"},
    {0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10}
)

-- Counter: Status codes
_G.metric_status_codes = prometheus:counter(
    "nginx_http_status_codes_total",
    "HTTP status codes",
    {"code", "host"}
)

-- Gauge: Nginx info
_G.metric_nginx_info = prometheus:gauge(
    "nginx_info",
    "Nginx information",
    {"version"}
)

-- Set nginx version info
_G.metric_nginx_info:set(1, {ngx.config.nginx_version})

ngx.log(ngx.INFO, "Prometheus metrics initialized successfully")
