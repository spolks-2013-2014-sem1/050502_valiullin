require "../Libs/UserOption.rb"
require './client.rb'
require "../Libs/TCPSocket.rb"
require "socket"
options = UserOptionsParser.new
options.parseCmd

socket = TCPSocket.new(options.get_port_number, options.get_host_name)
client = Client.new(socket, options.get_filepath)
client.connect(options.get_server_port_number, options.get_host_name)