require 'socket'

class Server
  def initialize()
    @server = TCPServer.new 9001 #port 9001
    @disconnect = false
    @users = []
    @usercode = []
    @num_users = 0
    run_server(@server)
  end
  def run_server(server)
    loop do
      Thread.start(server.accept) do |client|
        client.puts "Hello there, what is your name?"
        name = client.gets
        if @users != []
          for person in @usercode
            person.puts "#{name.strip} has connected"
          end
        end
        @users<<name.strip
        @usercode<<client
        @num_users += 1
        client.puts "Hi #{name.strip} The time is #{Time.now}"
        client.puts "You are now connected the chat service."
        while @disconnect == false
          interperate(client)
        end
        #client.close
      end
    end
  end
  def search_username(usercode)
    snum = 0
    puts "searching for name"
    for code in @usercode
      if code.strip == usercode.strip
        return @users[snum]
      else
        snum = snum + 1
      end
    end
  end
  def search_usercode(reciever)
    num = 0
    puts "searching for code"
    for name in @users
      if name.strip == reciever.strip
        return @usercode[num]
      else
        num = num + 1
      end
    end
  end
  def interperate(client)
    puts "#{client}"
    message = client.gets
    case message.strip
    when "DISCONNECT"
      client_name = search_username(client)
      for user in @usercode
#        snum = 0
#        for x in @usercode
#          if x == client
#            client_name = @users[snum]
#          else
#            snum = snum + 1
#          end
#        end
        user.puts "#{client_name} has disconnected"
      end
      client.close
    when "USERLIST"
      n=0
      client.puts "#{@users}"
      puts "#{@users[0]}: #{@usercode[0]}"
      puts "#{@users[1]}: #{@usercode[1]}"
      puts "#{@users[2]}: #{@usercode[2]}"
    when "BROADCAST"
      client.puts "What message would you like to broadcast? Enter below."
      message = client.gets
      for user in @usercode
        user.puts "Global Broadast from #{client.strip}: #{message}"
      end
    when "SEND"
      client.puts "What message would you like to send? Enter below."
      message = client.gets
      client.puts "whom should recieve this message? Enter below."
      reciever = client.gets
      is_there = @users.include? reciever.strip
      if is_there == false
        client.puts "The user #{reciever.strip} is not connected."
      else
#        num = 0
#         for l in @users  #this part should probably be done with a hash...
#          if l.strip == reciever.strip
#            #puts "is #{l} #{@usercode[num]}"
#            reciever_code = @usercode[num]
#          else
#            #puts "not #{@users[num]}: #{@usercode[num]}"
#            num = num + 1
#          end
#        end
      
        reciever_code = search_usercode(reciever)
      
#        snum = 0
#        for x in @usercode
#          if x == client
#            client_name = @users[snum]
#          else
#            snum = snum + 1
#          end
#        end
        client_name = search_username(client)
        
        reciever_code.puts "Message from #{client_name}: #{message}"
        client.puts "Message sent."
      end
    else
      client.puts "You put: #{message}"
      client.puts ""
      client.puts "The possible commands are:"
      client.puts "DISCONNECT, USERLIST, BROADCAST, SEND"
    end
  end
end

Server.new