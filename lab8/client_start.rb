require "../Libs/UserOption.rb"
require "../Libs/TCPSocket.rb"
require "../Libs/UDPSocket.rb"
require_relative 'module'

options = UserOptionsParser.new
options.parseCmd
begin
	TCP_UDP_Module.start_tcp_client(options.get_port_number, options.get_host_name, options.get_filepath)

rescue Interrupt => e
  puts " Exit"
rescue Errno::EPIPE => e
  puts "!! Client was disconnect, file didn't send fully !!!"
rescue Errno::ECONNREFUSED => e
  puts "socket is disable =("
rescue Errno::ENOENT => e
  puts "No such file or directory"
end