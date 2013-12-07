require "../Libs/TCPSocket.rb"
SIZE = 64
class Client

  def initialize(socket, filepath)
    @socket = socket
    @file = File.open(filepath, 'w')
  end

  def connect(port_number, host_name)
    sockaddr = Socket.sockaddr_in(port_number, host_name)
    @socket.connect(sockaddr)
    self.receive_file {|chunk| @file.write(chunk)}
    @file.close
  end

  def receive_file
    loop do
      rs, _ = IO.select([@socket.socket], nil, nil, 10)


      rs.each do |s|
        data = s.recv(SIZE)
        return if data.empty?
        if block_given?
          yield data
        end
      end 
    end
  end
end