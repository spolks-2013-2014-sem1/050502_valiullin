require "../Libs/UDPSocket.rb"

module UDPModule
  
	module_function	
  # Send file
  def start_udp_client(port, host, file_name)
    puts "UDP CLIENT"
    file = File.open(file_name, 'r')
    client = UDPClient.new(port, host)
    client.connect(port, host)
    loop do
      _, writer = IO.select(nil,[client.client_socket], nil, 10)
      break unless writer
      if io = writer[0]
        package = file.read(1024)
        if (package.nil? || package.empty?)
          io.send("END", 0) #signal, that file was sent
          break
        end
        io.send(package, 0)
      end
    end

    file.close if file
    client.client_socket.close if client.client_socket
  end


  # Recive file
  def start_udp_server(port, host, file_name)
    puts "UDP SERVER"
    file = File.open(file_name, 'w+')
    server = UDPServer.new(port, host)

    loop do
      reader, _ = IO.select([server.server_socket], nil, nil, 10)
      break unless reader
      if io = reader[0]
        package = io.recv(1024)
        if (package.nil? || package.empty? || package == "END")
          break
        end
        file.write(package)
      end
    end

    file.close if file
    server.close if server.server_socket
  end
end

