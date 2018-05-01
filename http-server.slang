unit Http
    unit Server

        routine setHandler(path: String, handler: routine (Request): Response) is
        end

        start() is
        end

    end

    unit DefaultServer extend Server
        port_: Integer
        handlers: Map<String, http.Handler>
        

        routine init(port: Integer) is
            port_ = port
        end


        routine setHandler(path: String, handler: routine (Request): Response) is
            handlers.add(path, handler)
        end

        start() is
        end
    end
end
