unit Http
    unit Request
        url: string
        method: HTTPMethod
        header: Header
        body: OStream
    end

    unit Response
        status: HTTPStatusCode
        header: Header
        body: IStream
    end

    unit Header

        // Get Header value for given key
        routine get(key: String): String is
        end

        // Insert key-value pair in Header,
        // replaces old value if given key already exists
        routine put(key: String, value: String): String is
        end
    end
end
