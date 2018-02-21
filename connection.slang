unit Connection extend IOStream
    socket: Socket  // Connection socket

    // Constructor that creates socket that tries to connect to another socket by address
    init(address: String, protocol: Protocol) is
        socket = Socket(protocol)
        socket.connect(address)
    end

    // allows Connection to read from input stream
    override read(bytes: Array[Byte]): Integer is
        return socket.read(bytes)
    end
    // allows Connection to write to output stream
    override write(bytes: Array[Byte]): Integer is
        return socket.write(bytes)
    end
    // allows Connection to close itself
    override close() is
        return socket.close()
    end
end 