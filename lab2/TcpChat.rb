require "../Libs/TCPSocket.rb"

class TcpChat

	def initialize(server_socket)
		@server = server_socket
	end

	def start_receiving_thread(client_socket)
    @receivingThread = Thread.new do
      while(true)
        message = client_socket.readline.chomp
        puts message
      end
    end
  end

  def start_sending_thread(client_socket)
    @sendingThread = Thread.new do
      while(true)
        message = gets
        if (message.chomp == "quit")
          @should_continue = false
          client_socket.puts("Server is offline")
          self.stop_receiving_thread
          break
        end
        client_socket.puts message
      end
    end
  end

  def stop_receiving_thread
    @receivingThread.exit
  end

  def stop_sending_thread
    @sendingThread.exit
  end

  def join_threads
    @sendingThread.join
    @receivingThread.join
  end

  def start
    @server.listen(5)
    self.start_sending_thread(@server.client_socket)
    self.start_receiving_thread(@server.client_socket)
    begin
            self.join_threads        
    rescue Interrupt
            self.stop_receiving_thread
            self.stop_sending_thread
    end     
  end

  def stop
    @server.close
  end

end
