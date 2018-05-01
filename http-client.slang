unit Http
    abstract unit Client is

        // Send given request over the network
        routine send(request: Request): Response is
        end

        // Send GET request on a given URL
        routine get(url: String): Response is

        end

        // Send POST request on a given URL, with content from IStream
        routine post(url: String, body: IStream) is
        end

        // Send POST request on a given URL, with content from IStream
        routine put(url: String, body: IStream) is
        end

        // Send DELETE request on a given URL, with content from IStream
        routine delete(url: String) is
        end
    end

    unit DefaultClient extend Client is

        // Send given request over the network
        routine send(request: Request): Response is
            body = Http.Parser.parseRequest(request)
            conn = Network.connect("tcp", request.url)
            conn.write(body)
            response = conn.read()
            return Http.Parser.parseResponse(response)
        end

        // Send GET request on a given URL
        routine get(url: String): Response is
            req is Request
            req.url = url
            request.method = HTTPMethod.GET
            return send(request)
        end

        // Send POST request on a given URL, with content from IStream
        routine post(url: String, body: IStream) is
            req is Request
            req.url = url
            req.body = body
            request.method = HTTPMethod.POST
            return send(request)
        end

        // Send POST request on a given URL, with content from IStream
        routine put(url: String, body: IStream) is
            req is Request
            req.url = url
            req.body = body
            request.method = HTTPMethod.PUT
            return send(request)
        end

        // Send DELETE request on a given URL, with content from IStream
        routine delete(url: String) is
            req is Request
            req.url = url
            req.body = body
            request.method = HTTPMethod.DELETE
            return send(request)
        end

        routine init() is
        end
    end
end
