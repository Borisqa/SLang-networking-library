# Low-level Networking Library Design

This document serves as a depiction of how network library's low-level is designed.

### Table of Contents
1. [Socket Handling](#socket)
2. [Architecture Over Sockets](#oversockets)
3. [Addressing](#addressing)
4. [Network File Descriptor](#fd)
5. [Name Resolution](#nameresolution)
6. [Low-Level Architecture Overview (with pictures)](#overview)

## Socket Handling <a name="socket"></a>
> This section describes the initial design of Sockets in SLang programming.

Socket is abstraction of communication between processes. 

We have  Socket _unit_ that wraps all important socket functions from native C library. These functions in fact have the same name and signatures. It is done so in order to be able to map
these functions to berkeley/windows sockets during compilation process. Thus, Socket _unit_, basically is container of systemcalls needed for networking library implementation. 

Currently it wraps such syscalls:
* int socket(int, int, int)
* bind()
* accept()
* listen()
* connect()
* close()

## Architecture Over Sockets <a name="oversockets"></a>

Top-level units are Listener and Connection. Both of them represent two major cases of using networking library. Listener allows user to
launch process that waits for incoming Connections and if there is such Connection it establishes connection. (In case of TCP connection)

Listener and Connection can represent either TCP or UDP. (Connection-based or Connectionless service)

Thus, we have:
* TCPListener
* TCPConnection
* UDPListener
* UDPConnection

## Addressing (Section about IP addresses) <a name="addressing"></a>
> This section will tell you about what types were defined for network adresses such as IP, socket addresses

Here we define our own types for IPv4 and IPv6. Also we have IPParser that can parse string in appropriate IP format.

## Network File Descriptor <a name="fd"></a>
> TODO
## Address Resoltion <a name="nameresolution"></a>
> Section emphasizes on what technique is used for name resolution
We implement address resolution by wrapping C functions _getaddrinfo()_ and _getnameinfo()_

## Low-Level Architecture Overview  <a name="overview"></a>
