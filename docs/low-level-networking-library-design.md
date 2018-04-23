# Low-level Networking Library Design

This document serves as a depiction of how network library's low-level is designed.

### Table of Contents
1. [Low-level Architecture Overview](#overview)
2. [Socket Wrapping](#socket)
3. [Architecture Over Sockets](#oversockets)
4. [Addressing](#addressing)
5. [Name/Address Resolution](#nameresolution)
6. [Connection-Listener Interface](#connlist)

## Low-Level Architecture Overview  <a name="overview"></a>
![Low-level Design](/docs/low-level-design.png)

Above you can see low level design of SLang networking library. It consists of several logiacal layers that we will describe more closely in sections below. Summarizing information about layers of this diagram, it consist of (bottom to top):
* **Socket system calls (Berkeley/Winsock)** - essential part of operating systems nowadays - implementation of socket system calls. They are implemented mostly in C/Assembler and already are part of the OS.
* **SLang System Call Wrapper** - This is the lowest level of SLang networking layer that basically wraps known system calls that are essential in establishing and manipulating socket connections. These wrapped system calls are later will be used by upper layers.
* **Socket Layer** - This layer represents itself as generic active established connection. We can read or write in this socket. TCPSocket and UDPSocket are derived from Socket, extending its functionality adding specific implementations for different protocols.
* **IP Layer** - This layer defines IP structure that keeps and maintains IP adresses(IPv4, IPv6). ALso this layer contains IP parser that basically parses string to the appropriate IP structure and checks whether the IP address is of the right format.
* **Address Layer** - accumulates address information(IP, ports, zones, etc.) for transport protocols.
* **Transport Protocols Layer** - this layer represents TCP's and UDP's listener and connection entities that allows us to establish connection over network with given protocol, await for connection, etc. Also this layer uses features of address resolver.
* **Name/Address Resolver** - this is also important layer that resolves IP addresses given the domain name. We chose to implement it over known __getaddrinf()__ and __getnameonfo()__ C library functions.
* **High level interface** - basically, it is highest point of low level networking library. It contains two classes: Connection and Listener. Listener is generic listener that position itself as a server that awaits for incoming sockets and then can use those sockets in order to perform transfer of data, etc. Connection is basically a client that set up the socket(connection) and sends it to the Listener. Then if it is accepted by listener, they can communicate with each other.

## Socket Handling <a name="socket"></a>
> This section describes the initial design of Sockets in SLang programming.

Socket is abstraction of communication between processes. 

We have  SocketSysCalls _unit_ that wraps all important socket functions from native C library. These functions in fact have the same name and signatures. It is done so in order to be able to map
these functions to berkeley/windows sockets during compilation process. Thus, SocketSysCalls _unit_, basically is container of systemcalls needed for networking library implementation. 

Currently it wraps such syscalls:
* **int socket(int family, int type, int protocol)** - to perform network I/O, the first thing a process must do is, call the socket function, specifying the type of communication protocol desired and protocol family, etc. This call returns a socket descriptor that you can use in later system calls or -1 on error.
* **int bind(int sockfd, struct sockaddr \*my_addr,int addrlen)** - The bind function assigns a local protocol address to a socket. With the Internet protocols, the protocol address is the combination of either a 32-bit IPv4 address or a 128-bit IPv6 address, along with a 16-bit TCP or UDP port number. This function is called by TCP server only. This call returns 0 if it successfully binds to the address, otherwise it returns -1 on error.
* **int accept(int sockfd, struct sockaddr \*cliaddr, socklen_t \*addrlen)** - The accept function is called by a TCP server to return the next completed connection from the front of the completed connection queue. This call returns a non-negative descriptor on success, otherwise it returns -1 on error. The returned descriptor is assumed to be a client socket descriptor and all read-write operations will be done on this descriptor to communicate with the client.
* **int listen(int sockfd,int backlog)** - The listen function is called only by a TCP server and it performs two actions:
  * The listen function converts an unconnected socket into a passive socket, indicating that the kernel should accept incoming connection requests directed to this socket.
  * The second argument to this function specifies the maximum number of connections the kernel should queue for this socket.
This call returns 0 on success, otherwise it returns -1 on error.
* **int connect(int sockfd, struct sockaddr \*serv_addr, int addrlen)** - the connect function is used by a TCP client to establish a connection with a TCP server. This call returns 0 if it successfully connects to the server, otherwise it returns -1 on error.
* **int recvfrom(int sockfd, void \*buf, int len, unsigned int flags struct sockaddr \*from, int \*fromlen)** - The recvfrom function is used to receive data from unconnected datagram socketst
* **int sendto(int sockfd, const void \*msg, int len, unsigned int flags, const struct sockaddr \*to, int tolen)** - the sendto function is used to send data over unconnected datagram sockets. Its signature is as follows
* **int close(int fd)** - the close function is used to close the communication between the client and the server.
## Architecture Over Sockets <a name="oversockets"></a>

So now we assume that we have all needed system calls in order to implement higher layers. Next layer is Socket layer. Socket in our diagram represents current connections. We can use this Socket to write in it and read from it.

We have three main units that make up sockets:
* **Socket** - generic unit that describes abstract methods for future implementations and wraps socket system calls and I/O system calls in its own methods that will be called or overriden from upper units.
* **TCPSocket** - socket for TCP connections.
* **UDPSocket** - socket for UDP connections.

## Addressing <a name="addressing"></a>
> This section will tell you about what types were defined for network adresses such as IP, socket addresses

Here we define our own types for IPv4 and IPv6. Also we have IPParser that can parse string in appropriate IP format.

Complete list of units of this layer:
* **IP** - main unit that describe IP data structure
* **IPv4** - unit that specifies format of IPv4 address, defines specific rules 
* **IPv6** - unit that specifies format of IPv4 address, defines specific rules 
* **IPParser** - unit that parses given string and outputs IPv4 or IPv6 structure or if the address is invalid it will return error

Next mini layer that is located right about IP layer is layer of Address units: **TCPAddress**, **UDPAddress**. These are data structures that store several information fields about network like IP address, port, zone, etc. It is then used by upper units like TCPListener, etc.

## Name/Address Resoltion <a name="nameresolution"></a>
> Section emphasizes on what technique is used for name resolution
We implement address resolution by wrapping C functions _getaddrinfo()_ and _getnameinfo()_. 

  **getaddringo()** and **getnameinfo()** convert domain names, hostnames, and IP addresses between human-readable text representations and structured binary formats for the operating system's networking API. Both functions are contained in the POSIX standard application programming interface (API).
  Also, getaddrinfo and getnameinfo are inverse functions of each other.

These functions are imporportant parts of name/address resolution. So let's describe each of them more closely:
* **int getaddrinfo(const char \*node, const char \*service, const struct addrinfo \*hints, struct addrinfo \*\*res)** - Given node and service, which identify an Internet host and a service, getaddrinfo() returns one or more addrinfo structures, each of which contains an Internet address that can be specified in a call to bind() or connect(). The getaddrinfo() function combines the functionality provided by the gethostbyname() and getservbyname() functions into a single interface, but unlike the latter functions, getaddrinfo() is reentrant and allows programs to eliminate IPv4-versus-IPv6 dependencies. 
* **int getnameinfo(const struct sockaddr \*sa, socklen_t salen, char \*host, size_t hostlen, char \*serv, size_t servlen, int flags)** - The getnameinfo() function is the inverse of getaddrinfo(): it converts a socket address to a corresponding host and service, in a protocol-independent manner. It combines the functionality of gethostbyaddr() and getservbyport(), but unlike those functions, getnameinfo() is reentrant and allows programs to eliminate IPv4-versus-IPv6 dependencies. 

## Connection-Listener Interface  <a name="connlist"></a>
Top-level units are Listener and Connection. Both of them represent two major cases of using networking library. Listener allows user to launch process that waits for incoming Connections and if there is such Connection it establishes connection. (In case of TCP connection)

Listener and Connection can represent either TCP or UDP. (Connection-based or Connectionless service)
Thus, we have get more specific units below:
* **TCPListener**
* **TCPConnection**
* **UDPListener**
* **UDPConnection**
