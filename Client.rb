require 'socket'

s = TCPSocket.new 'localhost',9001

while line = s.gets
  puts line
end

s.close