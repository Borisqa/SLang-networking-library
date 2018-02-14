unit Listener extend IOStream
    /*
        Listener unit. It should have wrapper methods of listen(...), accept(...) and close()
    */

    port: Integer
    protocol: Protocol
    socketListener: Socket

    init(port: Integer, protocol: Protocol) is 
        this.port = port
        this.protocol = protocol
        this.socketListener = Socket(protocol)
        this.socketListener.bind(port)
    end

    // enables connection requests on this 'socket'
    listenConnections(): Integer is
        err: Integer = socketListener.listen(socketListener) // ?? listen method take listener's socket as argument
        return err
    end

    acceptConnections(): Socket is
        clientSocket = socketListener.accept()
        return clientSocket
    end

    override close() is
        return socketListener.close()
    end

    // Methods for retrieving fields of unit
    getProtocol(): Protocol is
        return this.protocol
    end

    getPort(): Integer is
        return this.port
    end

end