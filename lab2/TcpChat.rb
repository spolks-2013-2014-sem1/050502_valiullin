require "../Libs/TCPSocket.rb"

class TcpChat

  def initialize(server_socket)
    @server = server_socket
  end

  def start
    begin
      loop do
        @server.accept
      end
    rescue Interrupt
      puts " Exit"
    ensure
      @server.close
      client.close unless client.nil?
    end
  end

end
