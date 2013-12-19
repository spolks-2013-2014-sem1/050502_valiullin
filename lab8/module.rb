require "../Libs/UDPSocket.rb"
require "../Libs/TCPSocket.rb"
require 'fileutils'
require 'socket'
require 'securerandom'
require 'process_shared'

module TCP_UDP_Module
  
	module_function	
  MSG = '*'
  def start_tcp_server(port, host, file_name)
    processes = []

    FileUtils.mkdir_p(file_name)
    dir = Dir.new(file_name)


    server = TCPServer.new(port, host)
    Signal.trap 'CLD' do
      pid = Process.wait(-1)
      processes.delete(pid)
    end
    loop do
      reader, _ = IO.select([server.server_soket], nil, nil, 10)
      break unless reader

      socket, = server.accept

      processes << fork do
        begin
          file_path = dir.path + "/#{SecureRandom.hex}.txt"
          file = File.open(file_path, 'w+')

          data_counter = 0

          loop do
            reader, _, us = IO.select([socket], nil, [socket], 10)
            break unless reader or us

            us.each do |s|
              s.recv(1, IO::MSG_OOB)
            end

            reader.each do |s|
              data = s.recv(4096)
              return if data.empty?
              data_counter += data.length
              file.write(data)
            end
          end

        ensure
          file.close if file
        end
      end
      socket.close if socket
    end

  ensure
    server.server_soket.close if server.server_soket
  end



  def start_tcp_client(port, host, file_name)
    file = File.open(file_name, 'r')
    client = TCPClient.new(port, host)

    pack_counter = 0
    data_counter = 0

    loop do
      _, writer, = IO.select(nil, [client.client_socket], nil, 10)

      break unless writer
      data = file.read(4096)

      writer.each do |s|
        return unless data
        sleep(0.0005)
        s.send(data, 0)
        pack_counter += 1
        data_counter += data.length
        puts data_counter

        if pack_counter % 64 == 0
          s.send(MSG, IO::MSG_OOB)
        end
      end
    end
  ensure
    file.close if file
    client.client_socket.close if client.client_socket
  end

end

