# CDN JSON Log Structure
# Complete metadata for Content Delivery Network scenarios

## 1. CDN Edge Request/Response Log (Complete)

```json
{
  "log_version": "1.0",
  "log_type": "cdn_edge",
  "timestamp": "2024-11-15T12:34:56.789Z",
  "timestamp_unix": 1700057696.789,
  
  "request": {
    "id": "req_abc123xyz789",
    "method": "GET",
    "url": "https://cdn.example.com/images/hero.jpg?version=2&quality=high",
    "uri": "/images/hero.jpg",
    "query_string": "version=2&quality=high",
    "protocol": "HTTP/2.0",
    "scheme": "https",
    
    "headers": {
      "host": "cdn.example.com",
      "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
      "accept": "image/webp,image/apng,image/*,*/*;q=0.8",
      "accept-encoding": "gzip, deflate, br",
      "accept-language": "en-US,en;q=0.9",
      "referer": "https://example.com/homepage",
      "origin": "https://example.com",
      "cookie": "[REDACTED]",
      "authorization": "[REDACTED]",
      "cache-control": "no-cache",
      "if-modified-since": "Wed, 01 Nov 2024 10:00:00 GMT",
      "if-none-match": "\"686897696a7c876b7e\"",
      "range": "bytes=0-1023",
      "x-forwarded-for": "203.0.113.1, 198.51.100.1",
      "x-real-ip": "203.0.113.1",
      "x-forwarded-proto": "https",
      "x-request-id": "req_abc123xyz789",
      "cdn-loop": "cloudfront",
      "cloudfront-viewer-country": "US",
      "cloudfront-is-mobile-viewer": "false",
      "cloudfront-is-tablet-viewer": "false",
      "cloudfront-is-desktop-viewer": "true"
    },
    
    "client": {
      "ip": "203.0.113.1",
      "port": 54321,
      "ip_version": "ipv4",
      "asn": 15169,
      "asn_org": "Google LLC",
      "country": "US",
      "country_name": "United States",
      "region": "CA",
      "region_name": "California",
      "city": "Mountain View",
      "postal_code": "94043",
      "latitude": 37.4056,
      "longitude": -122.0775,
      "timezone": "America/Los_Angeles",
      "continent": "NA",
      "isp": "Google Fiber",
      "device_type": "desktop",
      "is_mobile": false,
      "is_tablet": false,
      "is_desktop": true,
      "is_bot": false,
      "bot_name": null,
      "os": "Windows",
      "os_version": "10",
      "browser": "Chrome",
      "browser_version": "119.0.6045.159"
    },
    
    "tls": {
      "version": "TLSv1.3",
      "cipher": "TLS_AES_128_GCM_SHA256",
      "protocol": "h2",
      "sni": "cdn.example.com",
      "client_cert_present": false,
      "client_cert_verified": null,
      "session_reused": true,
      "early_data": false
    }
  },
  
  "response": {
    "status_code": 200,
    "status_text": "OK",
    
    "headers": {
      "content-type": "image/jpeg",
      "content-length": "245678",
      "content-encoding": "gzip",
      "cache-control": "public, max-age=31536000, immutable",
      "etag": "\"686897696a7c876b7e\"",
      "last-modified": "Wed, 01 Nov 2024 10:00:00 GMT",
      "expires": "Thu, 31 Dec 2025 23:59:59 GMT",
      "age": "3600",
      "vary": "Accept-Encoding",
      "x-cache": "HIT",
      "x-cache-hits": "127",
      "x-served-by": "cache-sjc10045-SJC",
      "x-cdn-pop": "SJC",
      "x-edge-location": "San Jose",
      "access-control-allow-origin": "https://example.com",
      "access-control-allow-credentials": "true",
      "strict-transport-security": "max-age=31536000; includeSubDomains",
      "x-content-type-options": "nosniff",
      "x-frame-options": "SAMEORIGIN",
      "x-xss-protection": "1; mode=block"
    },
    
    "body": {
      "bytes_sent": 245678,
      "bytes_sent_original": 487356,
      "compression_ratio": 0.504,
      "compression_type": "gzip"
    },
    
    "content": {
      "type": "image/jpeg",
      "size": 245678,
      "size_original": 487356,
      "hash_md5": "5d41402abc4b2a76b9719d911017c592",
      "hash_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    }
  },
  
  "cache": {
    "status": "HIT",
    "key": "/images/hero.jpg?version=2&quality=high",
    "ttl": 31532400,
    "age": 3600,
    "hits": 127,
    "lookup_time_ms": 0.5,
    "tier": "memory",
    "pop": "SJC",
    "revalidated": false,
    "stale_served": false,
    "bypass_reason": null
  },
  
  "origin": {
    "requested": false,
    "host": null,
    "ip": null,
    "port": null,
    "protocol": null,
    "connect_time_ms": null,
    "first_byte_time_ms": null,
    "response_time_ms": null,
    "status_code": null,
    "bytes_received": null,
    "retries": null,
    "failure_reason": null
  },
  
  "edge": {
    "pop": "SJC",
    "pop_name": "San Jose",
    "datacenter": "us-west-1",
    "server_id": "edge-sjc-001",
    "server_ip": "198.51.100.50",
    "location": {
      "city": "San Jose",
      "region": "California",
      "country": "US",
      "latitude": 37.3382,
      "longitude": -121.8863
    }
  },
  
  "timing": {
    "request_start": "2024-11-15T12:34:56.789Z",
    "request_end": "2024-11-15T12:34:56.825Z",
    "total_time_ms": 36,
    "dns_lookup_ms": 0,
    "tcp_connect_ms": 0,
    "tls_handshake_ms": 0,
    "request_processing_ms": 1.2,
    "cache_lookup_ms": 0.5,
    "origin_time_ms": 0,
    "response_generation_ms": 0.3,
    "response_send_ms": 34,
    "waiting_time_ms": 0,
    "ttfb_ms": 1.7,
    "download_time_ms": 34
  },
  
  "bandwidth": {
    "bytes_in": 1456,
    "bytes_out": 245678,
    "bytes_total": 247134,
    "bandwidth_mbps": 54.72,
    "cost_estimate_usd": 0.00001234
  },
  
  "security": {
    "waf_action": "allow",
    "waf_rule_matched": null,
    "waf_score": 0,
    "ddos_action": "allow",
    "ddos_score": 0,
    "bot_score": 0,
    "bot_detected": false,
    "bot_type": null,
    "rate_limit_hit": false,
    "rate_limit_remaining": 9985,
    "ip_reputation": "good",
    "threat_level": "none",
    "geo_blocked": false,
    "hotlink_protected": false
  },
  
  "performance": {
    "tcp_rtt_ms": 45,
    "connection_reused": true,
    "compression_enabled": true,
    "http2_pushed": false,
    "early_hints_sent": false,
    "quic_used": false
  },
  
  "analytics": {
    "session_id": "sess_xyz789abc123",
    "page_view_id": "pv_123456",
    "user_id": null,
    "referrer_domain": "example.com",
    "referrer_url": "https://example.com/homepage",
    "campaign_source": null,
    "campaign_medium": null,
    "campaign_name": null
  },
  
  "metadata": {
    "log_id": "log_unique_id_12345",
    "edge_version": "nginx/1.25.3",
    "lua_version": "LuaJIT 2.1.0",
    "cdn_provider": "custom",
    "environment": "production",
    "worker_pid": 12345,
    "worker_id": 0
  }
}
```

## 2. CDN Cache MISS - Origin Fetch Log

```json
{
  "log_version": "1.0",
  "log_type": "cdn_origin_fetch",
  "timestamp": "2024-11-15T12:35:10.123Z",
  "timestamp_unix": 1700057710.123,
  
  "request": {
    "id": "req_def456uvw012",
    "method": "GET",
    "url": "https://cdn.example.com/api/data.json",
    "uri": "/api/data.json",
    "query_string": "",
    "protocol": "HTTP/2.0",
    
    "client": {
      "ip": "198.51.100.25",
      "country": "GB",
      "city": "London"
    }
  },
  
  "response": {
    "status_code": 200,
    "headers": {
      "content-type": "application/json",
      "content-length": "15678"
    },
    "body": {
      "bytes_sent": 15678
    }
  },
  
  "cache": {
    "status": "MISS",
    "key": "/api/data.json",
    "ttl": 3600,
    "reason": "not_found",
    "will_cache": true,
    "cacheable": true
  },
  
  "origin": {
    "requested": true,
    "host": "origin.example.com",
    "ip": "203.0.113.100",
    "port": 443,
    "protocol": "https",
    
    "request": {
      "method": "GET",
      "uri": "/api/data.json",
      "headers": {
        "host": "origin.example.com",
        "user-agent": "EdgeServer/1.0",
        "x-forwarded-for": "198.51.100.25",
        "x-cdn-request-id": "req_def456uvw012"
      }
    },
    
    "response": {
      "status_code": 200,
      "headers": {
        "content-type": "application/json",
        "cache-control": "public, max-age=3600",
        "x-origin-server": "backend-01"
      },
      "bytes_received": 15678
    },
    
    "timing": {
      "dns_lookup_ms": 5.2,
      "tcp_connect_ms": 45.3,
      "tls_handshake_ms": 78.4,
      "connect_time_ms": 128.9,
      "first_byte_time_ms": 256.7,
      "response_time_ms": 312.5,
      "total_time_ms": 312.5
    },
    
    "connection": {
      "reused": false,
      "pooled": true,
      "protocol": "h2",
      "tls_version": "TLSv1.3"
    },
    
    "retries": 0,
    "failure_reason": null,
    "success": true
  },
  
  "edge": {
    "pop": "LHR",
    "pop_name": "London",
    "datacenter": "eu-west-2"
  },
  
  "timing": {
    "total_time_ms": 325.8,
    "cache_lookup_ms": 0.8,
    "origin_time_ms": 312.5,
    "response_send_ms": 12.5,
    "ttfb_ms": 257.5
  },
  
  "metadata": {
    "log_id": "log_unique_id_67890",
    "cache_stored": true,
    "cache_key_generated": "/api/data.json"
  }
}
```

## 3. CDN Error Response Log

```json
{
  "log_version": "1.0",
  "log_type": "cdn_error",
  "timestamp": "2024-11-15T12:35:45.678Z",
  
  "request": {
    "id": "req_error_789",
    "method": "GET",
    "url": "https://cdn.example.com/missing.jpg",
    "client": {
      "ip": "192.0.2.50",
      "country": "DE"
    }
  },
  
  "response": {
    "status_code": 404,
    "error": {
      "type": "not_found",
      "message": "Resource not found",
      "code": "CDN_404"
    }
  },
  
  "cache": {
    "status": "MISS",
    "negative_cache": true,
    "negative_cache_ttl": 60
  },
  
  "origin": {
    "requested": true,
    "response": {
      "status_code": 404
    },
    "timing": {
      "response_time_ms": 125.3
    }
  },
  
  "edge": {
    "pop": "FRA",
    "error_page_served": true,
    "custom_error_page": false
  }
}
```

## 4. CDN Purge/Invalidation Log

```json
{
  "log_version": "1.0",
  "log_type": "cdn_purge",
  "timestamp": "2024-11-15T12:36:00.000Z",
  
  "purge": {
    "id": "purge_abc123",
    "type": "single",
    "method": "api",
    "requested_by": "user_id_789",
    "api_key_id": "key_xyz123",
    
    "target": {
      "type": "url",
      "url": "https://cdn.example.com/images/hero.jpg",
      "pattern": null,
      "tags": null
    },
    
    "result": {
      "success": true,
      "items_purged": 127,
      "pops_affected": ["SJC", "LAX", "SEA", "DFW"],
      "processing_time_ms": 450,
      "errors": []
    }
  },
  
  "metadata": {
    "initiator": "dashboard",
    "reason": "content_update"
  }
}
```

## Field Descriptions

### Request Fields
- `id`: Unique request identifier
- `method`: HTTP method (GET, POST, etc.)
- `url`: Complete URL including query
- `uri`: Path only
- `query_string`: Query parameters
- `protocol`: HTTP version
- `scheme`: http/https
- `headers`: All request headers (sensitive ones redacted)

### Client Fields
- `ip`: Client IP address
- `port`: Client port
- `ip_version`: IPv4/IPv6
- `asn`: Autonomous System Number
- `country`: ISO country code
- `city`, `region`: Geolocation
- `device_type`: mobile/tablet/desktop/bot
- `os`, `browser`: User agent parsed

### Response Fields
- `status_code`: HTTP status
- `headers`: All response headers
- `bytes_sent`: Total bytes transferred
- `compression_*`: Compression details

### Cache Fields
- `status`: HIT, MISS, BYPASS, EXPIRED, STALE, UPDATING
- `key`: Cache key used
- `ttl`: Time to live in seconds
- `age`: How old the cached object is
- `hits`: Number of times served from cache
- `tier`: memory, disk, or cold storage

### Origin Fields
- `requested`: Whether origin was contacted
- `host`, `ip`, `port`: Origin server details
- `timing`: Detailed origin response timing
- `retries`: Number of retry attempts
- `failure_reason`: Why origin fetch failed

### Edge Fields
- `pop`: Point of Presence code
- `datacenter`: Datacenter location
- `server_id`: Specific edge server

### Timing Fields (all in milliseconds)
- `total_time_ms`: End-to-end request time
- `ttfb_ms`: Time to first byte
- `dns_lookup_ms`: DNS resolution time
- `tcp_connect_ms`: TCP handshake time
- `tls_handshake_ms`: TLS negotiation time
- `cache_lookup_ms`: Cache lookup time
- `origin_time_ms`: Time spent fetching from origin

### Security Fields
- `waf_action`: allow, block, challenge
- `bot_score`: 0-100 bot detection score
- `rate_limit_*`: Rate limiting status
- `threat_level`: Security threat assessment