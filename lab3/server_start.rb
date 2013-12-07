require "../Libs/UserOption.rb"
require './server.rb'
require "../Libs/TCPSocket.rb"
require "socket"

option = UserOptionsParser.new
option.parseCmd
p option.get_filepath
socket = TCPSocket.new( option.get_port_number, option.get_host_name)
server = Server.new(socket, option.get_filepath)
server.start
server.stop