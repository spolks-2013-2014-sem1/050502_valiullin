require "../Libs/TCPSocket.rb"

class Server

  def initialize(socket, filepath)
    @socket = socket
    @file = File.open(filepath, 'r')
  end

  def start
    @socket.bind
    @socket.listen
    self.send_file
  end

  def send_file
    while (chunk = @file.read(64))
      @socket.client_socket.send(chunk, 0)
    end
  end
  def stop
          @socket.close
    @file.close
  end
end