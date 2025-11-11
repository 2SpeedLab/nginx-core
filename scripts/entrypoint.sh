#!/bin/bash
set -e

# Function to handle signals
trap_signals() {
    echo "Received signal, shutting down gracefully..."
    nginx -s quit
    wait $NGINX_PID
    kill $EXPORTER_PID 2>/dev/null || true
    exit 0
}

trap trap_signals SIGTERM SIGINT

# Start nginx-prometheus-exporter in background if enabled
if [ "${ENABLE_EXPORTER}" = "true" ] || [ "${ENABLE_EXPORTER}" = "1" ]; then
    echo "Starting nginx-prometheus-exporter..."
    /usr/local/bin/nginx-prometheus-exporter \
        -nginx.scrape-uri="${SCRAPE_URI:-http://127.0.0.1:8080/stub_status}" \
        -web.listen-address="${EXPORTER_LISTEN:-:9113}" \
        -web.telemetry-path="${EXPORTER_PATH:-/metrics}" &
    EXPORTER_PID=$!
    echo "Exporter started with PID $EXPORTER_PID"
fi

# Test NGINX configuration
echo "Testing NGINX configuration..."
nginx -t

# Start NGINX
if [ "$1" = "nginx" ]; then
    echo "Starting NGINX..."
    nginx -g 'daemon off;' &
    NGINX_PID=$!
    echo "NGINX started with PID $NGINX_PID"

    # Wait for NGINX process
    wait $NGINX_PID
else
    # Execute custom command
    exec "$@"
fi