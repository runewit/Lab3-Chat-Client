require 'socket'

server=TCPServer.new 9001 #port 9001

loop do
  client = server.accept
  client.puts "Hello there!"
  client.puts "Time is #{Time.now}"
  client.close
end