abstract unit IP is
end

unit IPv4 extend IP is
    address: Array[Byte, 4]
end

unit IPv6 extend IP is
    address: Array[Byte, 16]
end

unit IPParser is 

    parseIP(addr: String): IP is
        type: String
        // Check whether addr is v4 or v6
        if type == "v4" then
            return this.parseIPv4(addr)
        else if type = "v6" then
            return this.parseIPv6(addr)
        else
            raise "Wrong IP address format"
        end
    end

    parseIPv4(addr: String): IPv4 is
        ip := IPv4
        // parse address string to IP address
        return ip
    end

    parseIPv6(addr: String): IPv6 is
        ip := IPv6
        // parse address string to IP address
        return ip
    end
end

unit Port
end

unit PortParser

    parsePort(port: String): Port is
        prt := Port
        // parse port
        return prt
    end
end