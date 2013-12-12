require "../Libs/UserOption.rb"
require "../Libs/TCPSocket.rb"

require_relative 'module'

begin
	options = UserOptionsParser.new
	options.parseCmd

	server = TCPServer.new(options.get_port_number, options.get_host_name)
	file = File.open(options.get_filepath, "r") 
	client, = server.accept
	OobModule.sendFile(file, client)

	rescue Interrupt => e
	  puts " Exit"
	rescue Errno::EPIPE => e
	  puts "!! Client was disconnect, file didn't send fully !!!"
	rescue Errno::ECONNREFUSED => e
	  puts "Server is disable =("
	rescue Errno::ENOENT => e
	  puts "No such file or directory"
	ensure
	  file.close unless file.nil? || file.closed?
	  #server.close unless server.nil? || server.closed?
end