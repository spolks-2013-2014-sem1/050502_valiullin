require "../Libs/UserOption.rb"
require './server.rb'
require "../Libs/TCPSocket.rb"
require "socket"

options = UserOptionsParser.new
options.parseCmd
socket = TCPSocket.new(options.get_port_number, options.get_host_name)
server = TCPServer.new(socket, options.get_filepath)
server.start
server.stop