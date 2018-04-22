#HTTP Library design

![HTTP Diagram](/docs/http-design.png)

## Library Purpose

Main interfaces which library offers are HTTP Server and HTTP Client. They allow to listen and send HTTP messages to hosts on various machines. It is important that implementation conforms to HTTP 1.1 standard, so that interoperability with other programming languages is possible.

## HTTP Client

HTTP Client is an entity which allows to send http request to various resources. It provides access to configuring http request by providing http method, url and body if needed.

Example of a GET request

```
c = Client()
req = Request("www.example.com", HTTPMethod.GET)

res = req.send(req)

body = res.body.read()
```

## HTTP Server

HTTP Server is an entity which allows to listen to incoming http request on a certain port. Its implementation is intended to be multithreaded and allows programmer to provide custom handler to each url route.

```

HelloHandler(req: Request) : Response is
    return http.createResponse("Hello World\n")
end

server = Server(8080)

s.setHandler("/hello", helloHandler)

server.start()
```

## Request and Response

HTTP is a request-response protocol, so request and response are the main entities of interaction.

Request consists of the following fields:

* url - resource we are interested in, "http://www.example.com".
* method - which method we would like to invoke, such as GET, POST etc.
* headers - set of key-value pairs which provide additional information about request.
* body - optional payload we want to deliver, for example it may be JSON for POST request.

Response consists of the following fields:

* status - code which indicates status of request, for example 404 means that resource is not found
* headers - set of key-value pairs returned by the server
* body - result of the request, e.g page content when accessing website.

HTTP Client accepts request objects which it sends on the wire, HTTP Server allows populating response object inside handler function.

## HTTP Parsing

Since HTTP is text protocol, we must use some sort of parser to transform to and from request and response objects. HTTP/2 is not supported, since it is much harder to parse.

## Examples
