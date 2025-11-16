local maxminddb = require "resty.maxminddb"

local function get_geo_info(ip)
    local geo = maxminddb.new("/usr/local/share/GeoIP/GeoLite2-City.mmdb")
    if not geo then
        ngx.log(ngx.ERR, "failed to open maxminddb")
        return nil
    end

    local res, err = geo:lookup(ip)
    if not res then
        ngx.log(ngx.ERR, "failed to lookup ip: ", err)
        return nil
    end

    return res
end

return {
    get_geo_info = get_geo_info
}