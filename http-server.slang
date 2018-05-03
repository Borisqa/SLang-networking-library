unit Http
    abstract unit Server

        routine setHandler(path: String, handler: routine (Request): Response) is
        end

        routine start() is
        end

    end

    unit DefaultServer extend Server is
        port_: Integer
        handlers: Map<String, routine (Request): Response>
        conn: TCPConnection


        routine init(port: Integer) is
            port_ = port
        end


        routine setHandler(path: String, handler: routine (Request): Response) is
            handlers.add(path, handler)
        end

        routine start() is
            while true loop
                conn = Network.listen("tcp", "localhost:80")
                request = Http.Parser.parseRequest(conn.read())
                path = Http.Parser.getURLPath(request.url)
                response = handlers[path](request)
                conn.write(Http.Parser.parseResponse(response))
                conn.close()
            end
        end
    end
end
