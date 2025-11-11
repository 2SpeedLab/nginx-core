# Dockerfile - OpenResty 1.27.1.2 on Ubuntu Jammy
# Using official OpenResty image with OpenResty pre-installed

FROM openresty/openresty:1.27.1.2-0-jammy

# Metadata
LABEL description="OpenResty with nginx-lua-prometheus"
LABEL version="1.0"

# Install additional dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install nginx-lua-prometheus
RUN cd /usr/local/openresty/lualib && \
    git clone https://github.com/knyar/nginx-lua-prometheus.git prometheus

# Create necessary directories
RUN mkdir -p /etc/nginx/lua \
    /etc/nginx/conf.d/servers \
    /etc/nginx/conf.d/upstreams \
    /var/log/nginx \
    /var/cache/nginx

# Copy configuration files
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d/monitoring.conf /etc/nginx/conf.d/monitoring.conf
COPY nginx/conf.d/upstreams.conf /etc/nginx/conf.d/upstreams.conf
COPY nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# Copy Lua scripts
COPY lua/*.lua /etc/nginx/lua/

# Set proper permissions
RUN chmod 644 /etc/nginx/nginx.conf \
    /etc/nginx/conf.d/*.conf \
    /etc/nginx/lua/*.lua

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:9145/api/health || exit 1

# Expose ports
EXPOSE 80 9145

# Start OpenResty
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]