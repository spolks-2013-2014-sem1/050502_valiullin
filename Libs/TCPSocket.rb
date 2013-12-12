require "socket"

#class for TCPServer
class TCPServer #< Socket

  def initialize(port, host)
    socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
    socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, true)
    sockaddr = Socket.sockaddr_in(port, host)
    socket.bind(sockaddr)
    socket.listen(5)
  end

end

#class for TCP client
class TCPClient #< Socket

  def initialize(port, host)
    socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
    socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, true)
    sockaddr = Socket.sockaddr_in(port, host)
    socket.connect(sockaddr)
    return socket
  end

end

