require "../Libs/TCPSocket.rb"

class TCPServer
  def initialize(socket, filepath)
    @socket = socket
    @file = File.open(filepath, "r")
    @oob_data = 0
    @send_data = 0
  end
  def start
    @socket.bind
          @socket.listen
          self.send_file
  end
  def send_file
    while (chunk = @file.read(1024*64))
      @socket.client_socket.send(chunk, 0)
      sleep(0.1)
      self.get_data_info(chunk)
    end
  end
  def get_data_info(chunk)
    @oob_data += 1
    STDOUT.puts @send_data
    self.send_oob_data
    @send_data += chunk.length
  end
  def send_oob_data
    if @oob_data % 32 == 0
      @oob_data = 0
      STDOUT.puts "SEND OOB MESSAGE"
      @socket.client_socket.send("#", Socket::MSG_OOB)
    end
  end
  def stop
          @socket.close
    @file.close
  end
end
