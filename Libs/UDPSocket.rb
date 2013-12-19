require "socket"

class UDPServer

	def initialize(port, host)
		@server_socket = Socket.new(Socket::AF_INET, Socket::SOCK_DGRAM, 0)
    @server_socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, true)
    sockaddr = Socket.sockaddr_in(port, host)
    @server_socket.bind(sockaddr)
    return @server_socket
	end

	def server_socket
		return @server_socket
	end

	def close
		@server_socket.close
	end

end

class UDPClient

	def initialize(port, host)
    @client_socket = Socket.new(Socket::AF_INET, Socket::SOCK_DGRAM, 0)
    @client_socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, true)
    return @client_socket
	end

	def client_socket
		return @client_socket
	end

	def close
		@client_socket.close
	end

	def connect(port, host)
		@client_socket.connect(Socket.sockaddr_in(port, host))
	end

end
