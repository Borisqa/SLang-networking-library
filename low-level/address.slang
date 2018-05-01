ref unit SockAddr is

    family: Integer
    addr: IP
    port: Port
    size: Integer

    init() is
        this.family := SocketConstants.AF_INET
    end

    setAddress(addr: String) is
        this.addr := IPParser.parse(addr)
    end

    getAddress(): IP is
        return this.addr
    end

    setPort(port: String) is
        this.port := PortParset.parse(port)
    end

    getPort(): Port is
        return this.port
    end

    size(): Integer is
        return this.size
    end

end

ref unit SockAddrLen is
    addrlen: Integer

    init(sockAddr: SockAddr) is
        this.addrlen := this.size(sockAddr)
    end

    size(sockAddr: SockAddr): Integer is
        currSize: Integer
        // Calculate size
        return currSize
    end
end

unit AddressParser is
    ipParser: IPParser
    PortParser: PortParser

    parseAddress(hostname: String): SockAddr is
        // parse using IP parser and Port parser
    end
end

unit TCPAddress is
end

unit UDPAddress is 
end

