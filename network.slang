unit ServerExample is
    conn: Socket
    conn := Network.listen("tcp", ":80")
    output: String
    output := conn.read()
    conn.close()
end

unit ClientExample is
    conn: Socket
    conn := Network.connect("tcp", "localhost:80")
    conn.write("Hello, World!")
    conn.close()
end

unit Network is

    conn: Connection 
    listener: Listener

    connect(protocol: String, hostname: String): Socket is
        if protocol = "tcp" || protocol = "TCP" then
            conn := TCPConnection
            tcpsock: TCPSocket
            tcpsock := conn.connect(hostname)
            return tcpsock
        else if protocol = "udp" || protocol = "UDP" then
            conn := UDPConnection
            udpsock: UDPSocket
            udpsock := conn.connect(hostname)
            return udpsock
        end
    end

    listen(protocol: String, port: String): Socket is 
         if protocol = "tcp" || protocol = "TCP" then
            listener := TCPListener
            tcpsock: TCPSocket
            tcpsock := listener.listen(hostname)
            return tcpsock
        else if protocol = "udp" || protocol = "UDP" then
            listener := UDPListener
            udpsock: UDPSocket
            udpsock := listener.listen(hostname)
            return udpsock
        end
    end

end

abstract unit Connection 
    fd: Integer 

    sockaddr: SockAddr
    sockaddrlen: SockAddrLen
end 

abstract unit Listener 
    fd: Integer 

    sockaddr: SockAddr
    sockaddrlen: SockAddrLen
end

unit TCPConnection extend Connection is

    connection_status: Integer

    init() is
        super.fd is SocketSystemCalls.socket("TCP")
    end

    connect(hostname: String): TCPSocket is 
        super.sockaddr := parseAddress(hostname)
        super.sockaddrlen := SockAddrLen(super.sockaddr)

        connection_status := connectSocket(super.fd, super.sockaddr, super.sockaddrlen.size())

        tcpsock := TCPSocket(super.fd)
        return tcpsock
    end
end

unit TCPListener extend Listener is

    client_fd: Integer

    // Statuses
    bind_status: Integer
    listen_status: Integer

    init() is
        super.fd is SocketSystemCalls.socket("TCP")
    end

    listen(hostname: String): TCPSocket is
        super.sockaddr := parseAddress(hostname)
        super.sockaddrlen := SockAddrLen(super.sockaddr)

        // Listen to port for client connection 
        bind_status := SocketSystemCalls.bindSocket(super.fd, super.sockaddr, super.sockaddr.size())
        listen_status := SocketSystemCalls.listenSocket(super.fd, 10)
        client_fd := acceptSocket(super.fd, super.sockaddr, super.sockaddrlen)

        tcpsock := TCPSocket(client_fd)

        return tcpsock
    end

end

unit UDPConnection extend Connection is
    
    bind_status: Integer
    
    init() is
        super.fd is SocketSystemCalls.socket("UDP")
    end

    listen(hostname: String): UDPSocket is
        super.sockaddr := parseAddress(hostname)

        udpsock := UDPSocket(super.fd, super.sockaddr)
        return udpsock
    end
end

unit UDPListener extend Listener is
        
    bind_status: Integer
    
    init() is
        super.fd is SocketSystemCalls.socket("UDP")
    end

    listen(hostname: String): UDPSocket is
        super.sockaddr := parseAddress(hostname)
        super.sockaddrlen := SockAddrLen(super.sockaddr)

        bind_status := bindSocket(super.fd, super.sockaddr, super.sockaddrlen)

        udpsock := UDPSocket(super.fd)
        return udpsock
    end
end
