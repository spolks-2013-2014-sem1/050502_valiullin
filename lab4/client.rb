require "../Libs/TCPSocket.rb"

class TCPClient
  def initialize(socket, filepath)
    @socket = socket
    @file = File.open(filepath, "w")
    @received_data = 0
  end
  def connect(port_number, host_name)
    sockaddr = Socket.sockaddr_in(port_number, host_name)
          @socket.connect(sockaddr)
          self.receive_file {|chunk| @file.write(chunk)}
    @file.close
  end
  def receive_file
          loop do
            rs, _, us = IO.select([@socket.socket], nil, [@socket.socket], 10)

      us.each do |s|
        begin
          puts s.recv(1, Socket::MSG_OOB)  
          puts @received_data
        rescue Exception => e
          next
        end
      end

      rs.each do |s|
        data = s.recv(1024*64)
              return if data.empty?
        @received_data += data.length
              if block_given?
                      yield data
              end
            end
          end
  end
end
