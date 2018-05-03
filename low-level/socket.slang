abstract unit Socket is 
    fd: Integer

    close(): Integer is
        return SocketSystemCalls.closeSocket(this.fd)
    end
end

unit TCPSocket extend Socket is

    send_status: Integer
    recv_status: Integer
    write_status: Integer

    init(fd: Integer) is
        super.fd := fd
    end

    send(buff: SockBuffer, nbytes: Integer): Integer is
        send_status := SocketSystemCalls.sendSocket(super.fd, buff, nbytes, 0)
        return send_status
    end

    recv(buff: SockBuffer, nbytes: Integer): Integer is
        recv_status := SocketSystemCalls.recvSocket(super.fd, buff, nbytes, 0)
        return recv_status
    end

    read(): Array[Byte] is
        return SocketSystemCalls.readSocket(super.fd)
    end

    write(bytes: Array[Byte]): Integer is
        write_status := SocketSystemCalls.writeSocket(super.fd, bytes)
        return write_status
    end

end

unit UDPSocket extend Socket is 

    sockaddr: SockAddr

    sendTo_status: Integer
    recvFrom_status: Integer

    init(fd: Integer) is
        super.fd := fd
    end

    init(fd: Integer, sockaddr: SockAddr) is
        super.fd := fd
        this.sockaddr := sockaddr
    end

    sendTo(buff: SockBuffer, nbytes: Integer): Integer is
        sendTo_status := SocketSystemCalls.sendToSocket(super.fd, buff, nbytes, 0, sockaddr, sockaddr.size())
        return sendTo_status
    end

    recvFrom(buff: SockBuffer, nbytes: Integer): Integer is
        recvFrom_status := SocketSystemCalls.recvFromSocket(super.fd, buff, nbytes, 0, sockaddr, sockaddr.size())
        return recvFrom_status
    end

end