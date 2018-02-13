unit IO
    unit Closeable
        close()
    end Closeable

    unit IStream extend Closeable
        read(bytes: Array[Byte]): Integer
    end IStream

    unit OStream extend Closeable
        write(bytes: Array[Byte]): Integer
    end OStream

    unit IOStream extend IStream, OStream

    unit FileDescriptor
end IO

unit Socket extend IOStream
    fd: FileDescriptor
    init(domain: Domain, protocol: Protocol) is
        fd := socket(domain, protocol, 0)
        if fd < 0 then
            // handle error
        end
    end

    bind(port: Integer)

    connect(address: String)

    listen(maxConnections: Integer)

    accept(): Socket

    override read(bytes: Array[Byte]): Integer
    
    override write(bytes: Array[Byte]): Integer

    override close()
end Socket