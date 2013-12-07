require "../Libs/BasicSocket.rb"

class TCPSocket #< BasicSocket
	attr_accessor :client_socket, :socket

  def initialize(port_number, host_name)
    @socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
    @socket.setsockopt(:SOCKET, :REUSEADDR, true)          #no more Errno::EADDRINUSE
    @sockaddr = Socket.pack_sockaddr_in(port_number, host_name)
  end

  def bind
    @socket.bind(@sockaddr)
    @socket.listen(5)
  end

  def listen
    self.accept
  end

  def connect(sockaddr)
    @socket.connect(sockaddr)
  end

  def accept
    @client_socket, client_addrinfo = @socket.accept
    self.get_information(client_addrinfo)
  end

  def get_information (addrinfo)
    Socket.getnameinfo(addrinfo).each { |line| p line }
  end

  def close
    @client_socket.close
    @socket.close
  end
end