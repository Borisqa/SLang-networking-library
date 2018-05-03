unit Http
    unit HTTPMethod is
        GET: string = "GET"
        POST: string = "POST"
        PUT: string = "PUT"
        DELETE: string = "DELETE"
    end

    unit Request is
        url: string
        method: HTTPMethod
        header: Header
        body: IOStream
    end

    unit Response is
        status: HTTPStatusCode
        header: Header
        body: IOStream
    end

    unit Header is

        headers: Map<String, String>

        // Get Header value for given key
        routine get(key: String): String is
            return headers[key]
        end

        // Insert key-value pair in Header,
        // replaces old value if given key already exists
        routine put(key: String, value: String) is
            headers[key] = value
        end
    end
end
