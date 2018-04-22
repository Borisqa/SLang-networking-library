unit Server

unit Server

    port_: Integer

    handlers: Map<String, http.Handler>

    init(port: Integer) is
        port_ = port
    end

    setHandler(path: String, handler: Http.Handler) is
        handlers.add(path, handler)
    end

    start() is
    end

end
