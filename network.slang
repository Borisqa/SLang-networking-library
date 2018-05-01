unit ServerExample is
    conn: Socket
    conn := Network.listen("tcp", "localhost:80")
    output: String
    output := conn.read()
end

unit ClientExample is
    conn: Socket
    conn := Network.connect("tcp", "localhost:80")
    conn.write("Hello, World!")
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
end 

abstract unit Listener 
end

unit TCPConnection extend Connection is

    fd: Integer 

    sockaddr: SockAddr
    sockaddrlen: SockAddrLen

    connection_status: Integer

    init() is
        fd is SocketSystemCalls.socket("TCP")
    end

    connect(hostname: String): TCPSocket is 
        sockaddr := parseAddress(hostname)
        sockaddrlen := SockAddrLen(sockaddr)

        connection_status := connectSocket(fd, sockaddr, sockaddrlen.size())

        tcpsock := TCPSocket(fd)
        return tcpsock
    end
end

unit TCPListener extend Listener is

    listener_fd: Integer
    client_fd: Integer
    tcpaddr: TCPAddr

    sockaddr: SockAddr
    sockaddrlen: SockAddrLen

    // Statuses
    bind_status: Integer
    listen_status: Integer

    init() is
        fd is SocketSystemCalls.socket("TCP")
    end

    listen(hostname: String): TCPSocket is
        sockaddr := parseAddress(hostname)
        sockaddrlen := SockAddrLen(sockaddr)

        // Listen to port for client connection 
        bind_status := SocketSystemCalls.bindSocket(fd, sockaddr, sockaddr.size())
        listen_status := SocketSystemCalls.listenSocket(fd, 10)
        client_fd := acceptSocket(fd, sockaddr, sockaddrlen)

        tcpsock := TCPSocket(client_fd)

        return tcpsock
    end

end

unit UDPConnection extend Connection is
    fd: Integer
    
    sockaddr: SockAddr
    sockaddrlen: SockAddrLen

    bind_status: Integer
    
    init() is
        fd is SocketSystemCalls.socket("UDP")
    end

    listen(hostname: String): UDPSocket is
        sockaddr := parseAddress(hostname)

        udpsock := UDPSocket(fd, sockaddr)
        return udpsock
    end
end

unit UDPListener extend Listener is
    
    fd: Integer
    
    sockaddr: SockAddr
    sockaddrlen: SockAddrLen

    bind_status: Integer
    
    init() is
        fd is SocketSystemCalls.socket("UDP")
    end

    listen(hostname: String): UDPSocket is
        sockaddr := parseAddress(hostname)
        sockaddrlen := SockAddrLen(sockaddr)

        bind_status := bindSocket(fd, sockaddr, sockaddrlen)

        udpsock := UDPSocket(fd)
        return udpsock
    end
end
