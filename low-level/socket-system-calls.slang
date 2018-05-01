// Unit that wraps C socket system calls
unit SocketSystemCalls extend IOStream

    socket(type: String): Integer is
        if type = "TCP" || type = "tcp" then
            return socket(AF_INET, SOCK_STREAM, 0)  
        else if type = "UDP" || type = "udp" then 
            return socket(AF_INET, SOCK_DGRAM, 0)
        else
            raise "Unsupported protocol" 
        end
    end

    bindSocket(sockfd: Integer, myaddr: SockAddr, addrlen: Integer): Integer is
        return bind(sockfd, myaddr, addrlen)
    end

    connectSocket(sockfd: Integer, servaddr: SockAddr, addrlen: Integer): Integer is
        return connect(sockfd, servaddr, addrlen)
    end

    listenSocket(sockfd: Integer, maxConnections: Integer): Integer is
        return listen(sockfd, maxConnections)
    end

    acceptSocket(sockfd: Integer, peer: SockAddr, addrlen: SockAddrLen): Integer is
        return accept(sockfd, peer, addrlen)
    end

    sendToSocket(sockfd: Integer, buff: SockBuffer, nbytes: Integer, flags: Integer, to: SockAddr, addrlen: Integer): Integer is
        return sendto(sockfd, buff, nbytes, flags, to, addrlen)
    end

    recvFromSocket(sockfd: Integer, buff: SockBuffer, nbytes: Integer, flags: Integer, from: SockAddr, addrlen: SockAddrLen): Integer is
        return recvfrom(sockfd, buff, nbytes, flags, from, addrlen)
    end

    sendSocket(sockfd: Integer, buff: SockBuff, nbytes: Integer, flags: Integer): Integer is
        return send(sockfd, buff, nbytes, flags)
    end

    recv(sockfd: Integer, buff: SockBuff, nbytes: Integer, flags: Integer) is 
        return recv(sockfd, buff, nbytes, flags)
    end

    // Native IO read
    readSocket(fd: Integer): bytes: Array[Byte] is
        return IOStream.read(fd)
    end
    
    // IO write
    writeSocket(fd: Integer, bytes: Array[Byte]): Integer is
        return IOstream.write(fd, bytes)
    end

    closeSocket(fd: Integer): Integer is
        return close(fd)
    end

end 

unit SocketConstants is

    // Socket Types
    const SOCK_STREAM is    1		/* stream socket */
    const SOCK_DGRAM is     2		/* datagram socket */
    const SOCK_RAW is       3		/* raw-protocol interface */
    const SOCK_RDM is       4		/* reliably-delivered message */
    const SOCK_SEQPACKET is 5		/* sequenced packet stream */

    // Address Families
    const AF_UNSPEC	is  0		/* unspecified */
    const AF_UNIX is	1		/* local to host (pipes, portals) */
    const AF_INET is	2		/* internetwork: UDP, TCP, etc. */
    const AF_IMPLINK is	3		/* arpanet imp addresses */
    const AF_NS is		6		/* XEROX NS protocols */
end

ref unit SockBuffer is 
    buffer: Character
end