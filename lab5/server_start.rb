require "../Libs/UserOption.rb"
require "../Libs/TCPSocket.rb"
require "../Libs/UDPSocket.rb"
require_relative 'module'

begin


	options = UserOptionsParser.new
	options.parseCmd

	if(options.get_udp_socket)
	  UDPModule.start_udp_server(options.get_port_number, options.get_host_name, options.get_filepath)
	else
		p "Labs for udp, dont use TCP"
	end

	rescue Interrupt => e
	  puts " Exit"
	rescue Errno::EPIPE => e
	  puts "!! Client was disconnect, file didn't send fully !!!"
	rescue Errno::ECONNREFUSED => e
	  puts "socket is disable =("
	rescue Errno::ENOENT => e
	  puts "No such file or directory"
end