unit Http
    unit Client

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

        routine init() is
        end
    end
end
