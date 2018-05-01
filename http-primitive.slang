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
        body: OStream
    end

    unit Response is
        status: HTTPStatusCode
        header: Header
        body: IStream
    end

    unit Header is

        // Get Header value for given key
        routine get(key: String): String is
        end

        // Insert key-value pair in Header,
        // replaces old value if given key already exists
        routine put(key: String, value: String): String is
        end
    end
end
