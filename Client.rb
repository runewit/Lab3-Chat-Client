require 'socket'

s = TCPSocket.new 'localhost',9001

while true == true
  if (from_server = s.gets) != nil
    puts from_server
  end
  thr = nil
  if(thr == nil)
    thr = Thread.new{
        stuff = gets.chomp
        if stuff == "DISCONNECT"
          s.puts stuff
          s.close
          exit
        else
          s.puts stuff
        end
    }
  end
end