# HTTP Library Reference

Below you will find reference for units of HTTP Library.

1. [Request](#request)
2. [Response](#response)
3. [Header](#header)
4. [Client](#client)
5. [Server](#server)

## Request <a name="request"></a>

Fields:

* url: string - requested resource link, example: "http://www.google.com"
* method: HTTPMethod - one of the HTTP methods
* header: Header - key value pairs which will be included in HTTP header. Used for authentication and other various purposes
* body: IOStream - optional payload, which can be used to send various information, for example JSON or XML objects

## Response <a name="response"></a>

Fields:

* status: HTTPStatusCode - one of the HTTP status codes returned by server
* header: Header - key value pairs used for example for authentication and other various purposes
* body: IOStream - payload returned by the server. It might be for example contents of a webpage or JSON objects

## Header <a name="header"></a>

Header is a String -> String map of keys and values

Routines:

* get(key: String): String - get value for a given key
* put(key: String, value: String) - insert value for a given key. Replaces old value.


## Client <a name="client"></a>

Routines:

* send(request: Request): Response - Send given request and return response returned by the server.
* get(url: String): Response - send GET request for a given URL
* post(url: String, body: IStream) - send POST request for a given url with a given body
* put(url: String, body: IStream) - send PUT request for a given url with a given body
* delete(url: String) - - send DELETE request for a given url with a given body

## Server <a name="server"></a>

Routines:

* start() - Blocking call which starts server listening for incoming connections. Connections are then handled to designated handlers.

* setHandler(path: String, handler: routine (Request): Response) - for a given url path, this function will be executed. The function must accept request object and return response, which will be passed to the client on the other end.
