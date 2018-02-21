// Temporary IO stub
unit IO
    unit Closeable
        close()
    end 

    unit IStream extend Closeable
        read(bytes: Array[Byte]): Integer
    end 

    unit OStream extend Closeable
        write(bytes: Array[Byte]): Integer
    end 

    unit IOStream extend IStream, OStream
    end

    // file in that sockets can read and write data
    unit FileDescriptor 
    end
end 

// Socket class that wraps C socket functionality
unit Socket extend IOStream
    fd: FileDescriptor
    init(domain: Domain, protocol: Protocol) is
        fd := socket(domain, protocol, 0)
        if fd < 0 then
            // handle error
        end
    end

    // wrapper of C bind function
    bind(port: Integer) is
    // TODO: ...
    end

    // wrapper of C connect function
    connect(address: String) is
    // TODO: ...
    end

    // wrapper of C listen function
    listen(maxConnections: Integer): Integer is
    // TODO: ...
    end

    // wrapper of C accept function
    accept(): Socket is
    // TODO: ...
    end

    // allows socket to read from input stream
    override read(bytes: Array[Byte]): Integer is
    // TODO: ...
    end
    
    // allows socket to write to output stream
    override write(bytes: Array[Byte]): Integer is
    // TODO: ...
    end

    // allows socket to close itself
    override close() is
    // TODO: ...
    end
end 