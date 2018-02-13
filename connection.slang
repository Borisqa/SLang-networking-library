unit Connection extend IOStream
    socket: Socket

    init(address: String, protocol: Protocol) is
        socket = Socket(protocol)
        socket.connect(address)
    end

    override read(bytes: Array[Byte]): Integer is
        return socket.read(bytes)
    end
    
    override write(bytes: Array[Byte]): Integer is
        return socket.write(bytes)
    end
    override close() is
        return socket.close()
    end
end Connection