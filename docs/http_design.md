#HTTP Library design

![HTTP Diagram](/docs/http-design.png)

## Library Purpose

Main interfaces which library offers are HTTP Server and HTTP Client. They allow to listen and send HTTP messages to hosts on various machines. It is important that implementation conforms to HTTP 1.1 standard, so that interoperability with other programming languages is possible.

## Implementation

HTTP is a request-response protocol, so primary entities are Request and Response units. Since HTTP are text based protocol, parser is needed to transform incoming messages to internal format.
