unit Listener extend IOStream
    /*
        Listener unit. It should have wrapper methods of listen(...), accept(...) and close()
    */

    port: Integer   // port number of listener
    protocol: Protocol  // protocol type that listener uses
    socketListener: Socket  // listener socket

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

    // accept incoming connections
    acceptConnections(): Socket is
        clientSocket = socketListener.accept()
        return clientSocket
    end

    // allows to close Listener
    override close() is
        return socketListener.close()
    end

    // Methods for retrieving fields of unit
    // get protocol type of listener
    getProtocol(): Protocol is
        return this.protocol
    end

    // get port number of listener
    getPort(): Integer is
        return this.port
    end

end