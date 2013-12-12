require "../Libs/UserOption.rb"
require "../Libs/TCPSocket.rb"
require_relative 'module'
begin
	options = UserOptionsParser.new
	options.parseCmd

	client = TCPClient.new(options.get_port_number, options.get_host_name)
	file = File.open(options[:filepath], "w") 
	OobModule.getFile(file, client)

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
	  client.close unless client.nil? || client.closed?
	  
end