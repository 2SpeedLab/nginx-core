-- status_page.lua
-- Simple HTML status page

local stats = ngx.stat()

local html = [[
<!DOCTYPE html>
<html>
<head>
    <title>Nginx Monitoring Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 30px;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
        }
        .subtitle {
            color: #666;
            margin-bottom: 30px;
        }
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .metric-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 6px;
            border-left: 4px solid #007bff;
        }
        .metric-card h3 {
            color: #666;
            font-size: 14px;
            margin-bottom: 8px;
            text-transform: uppercase;
        }
        .metric-card .value {
            color: #333;
            font-size: 32px;
            font-weight: bold;
        }
        .api-links {
            background: #e9ecef;
            padding: 20px;
            border-radius: 6px;
        }
        .api-links h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
        }
        .api-links a {
            display: inline-block;
            margin: 5px 10px 5px 0;
            padding: 8px 16px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }
        .api-links a:hover {
            background: #0056b3;
        }
        .timestamp {
            text-align: center;
            color: #999;
            margin-top: 20px;
            font-size: 12px;
        }
    </style>
    <script>
        // Auto-refresh every 5 seconds
        setTimeout(function() {
            location.reload();
        }, 5000);
    </script>
</head>
<body>
    <div class="container">
        <h1>Nginx Monitoring Dashboard</h1>
        <div class="subtitle">Version: ]] .. ngx.config.nginx_version .. [[</div>
        
        <div class="metrics-grid">
            <div class="metric-card">
                <h3>Active Connections</h3>
                <div class="value">]] .. (stats and stats.active or 0) .. [[</div>
            </div>
            <div class="metric-card">
                <h3>Reading</h3>
                <div class="value">]] .. (stats and stats.reading or 0) .. [[</div>
            </div>
            <div class="metric-card">
                <h3>Writing</h3>
                <div class="value">]] .. (stats and stats.writing or 0) .. [[</div>
            </div>
            <div class="metric-card">
                <h3>Waiting</h3>
                <div class="value">]] .. (stats and stats.waiting or 0) .. [[</div>
            </div>
            <div class="metric-card">
                <h3>Total Requests</h3>
                <div class="value">]] .. (stats and stats.requests or 0) .. [[</div>
            </div>
            <div class="metric-card">
                <h3>Accepted</h3>
                <div class="value">]] .. (stats and stats.accepted or 0) .. [[</div>
            </div>
        </div>
        
        <div class="api-links">
            <h2>API Endpoints</h2>
            <a href="/metrics">Prometheus Metrics</a>
            <a href="/api/stats">Complete Stats (JSON)</a>
            <a href="/api/health">Health Check</a>
            <a href="/api/connections">Connections</a>
            <a href="/api/requests">Requests</a>
            <a href="/api/upstreams">Upstreams</a>
        </div>
        
        <div class="timestamp">
            Last updated: ]] .. os.date("%Y-%m-%d %H:%M:%S") .. [[ | Auto-refresh in 5s
        </div>
    </div>
</body>
</html>
]]

ngx.header["Content-Type"] = "text/html"
ngx.say(html)
