require 'socket'

s = TCPSocket.new 'localhoast', 9001

while line = s.gets
  puts line
end

s.close