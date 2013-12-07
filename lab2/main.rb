require "../Libs/UserOption.rb"
require "../Libs/TCPSocket.rb"
require "socket"
require './TcpChat.rb'

option = UserOptionsParser.new
option.parseCmd

socket = TCPSocket.new( option.get_port_number, option.get_host_name)
chat = TcpChat.new(socket)
chat.start
chat.stop