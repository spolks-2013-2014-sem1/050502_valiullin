require "optparse"

class UserOptionsParser
  
  def initialize
  	@options = Hash.new 
  end

  #parse our cmd
  def parseCmd
      OptionParser.new do |opts|
 	      opts.on("-n HostName", "Hostname for creating socket.") do |hostname|
          @options[:hostname] = hostname
        end

        opts.on("-u", "Use UDP socket") do
          @options[:udp] = true
        end

        opts.on("-p Portnumber", "Port number for creating socket.") do |portname|
          @options[:portnumber] = portname
        end

        opts.on("-f FilePath", "FilePath of file") do |filepath|
          @options[:filepath] = filepath
        end

        opts.on("-c PORT", "Server's port number to connect. By default: nil") do |s|
          @options[:connectport] = s
        end
  	  end.parse!
  end


  def get_port_number
      return @options[:portnumber]
  end

  def get_host_name
    return @options[:hostname]
  end

  def get_filepath
    return @options[:filepath]
  end

  def get_server_port_number
    return @options[:serverport]
  end
  def get_udp_socket
    return @options[:udp]
  end
end