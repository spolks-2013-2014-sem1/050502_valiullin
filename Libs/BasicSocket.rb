require "socket"

class BasicSocket
  def listen
  end

  def connect
  end

  def close
  end

  def accept
  end

  def get_information (addrinfo)
    Socket.getnameinfo(addrinfo).each { |line| p line }
  end
end