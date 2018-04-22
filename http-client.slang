unit Client

    // Send given request over the network
    send(request: Request): Response is
    end

    // Send GET request on a given URL
    get(url: String): Response is

    end

    // Send POST request on a given URL, with content from IStream
    post(url: String, body: IStream) is
    end

    // Send POST request on a given URL, with content from IStream
    put(url: String, body: IStream) is
    end

    // Send DELETE request on a given URL, with content from IStream
    delete(url: String) is
    end

    init() is
    end
end
