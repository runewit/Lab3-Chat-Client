require 'socket'

class Server
  def initialize()
    @server = TCPServer.new 9001 #port 9001
    @disconnect = false
    @users = []
    @usercode = []
    run_server(@server)
  end
  def run_server(server)
    loop do
      Thread.start(server.accept) do |client|
        client.puts "Hello there, what is your name?"
        name = client.gets
        puts "#{name.strip} connected"
        if @users != []
          for person in @usercode
            person.puts "#{name.strip} has connected"
          end
        end
        @users<<name.strip
        @usercode<<client
        client.puts "Hi #{name.strip} The time is #{Time.now}"
        client.puts "You are now connected the chat service."
        while @disconnect == false
          interperate(client)
        end
      end
    end
  end
  def search_username(usercode)
    snum = 0
    print "searching for name: "
    for code in @usercode
      if code == usercode
        puts "#{@users[snum]}"
        return @users[snum]
      else
        snum = snum + 1
      end
    end
  end
  def search_usercode(reciever_name)
    num = 0
    puts "searching for code"
    for name in @users
      if name.strip == reciever_name.strip
        return @usercode[num]
      else
        num = num + 1
      end
    end
  end
  def interperate(client)
    message = client.gets
    case message.strip
    when "DISCONNECT"
      @newlista=[]
      @newlistb=[]
      client_name = search_username(client)
      for user in @usercode
        user.puts "#{client_name} has disconnected"
      end
      remove_from_lists(client_name,client)
      client.close
      puts "#{client_name} disconnected"
    when "USERLIST"
      n=0
      client.puts "#{@users}"
      puts "#{@users[0]}: #{@usercode[0]}"
      puts "#{@users[1]}: #{@usercode[1]}"
      puts "#{@users[2]}: #{@usercode[2]}"
    when "BROADCAST"
      client.puts "What message would you like to broadcast? Enter below."
      message = client.gets
      name = search_username(client)
      for user in @usercode
        user.puts "Global Broadast from #{name}: #{message}"
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
        reciever_code = search_usercode(reciever)
        puts "#{client} sending a message to #{reciever.strip}"
        client_name = search_username(client)
        
        reciever_code.puts "Message from #{client_name}: #{message}"
        client.puts "Message sent."
      end
    else
      client.puts "You gave the command: #{message}"
      client.puts "This is not an accepted command."
      client.puts "The possible commands are: DISCONNECT, USERLIST, BROADCAST, SEND"
    end
  end
  def remove_from_lists(user, id)
    for name in @users
      if name != user
        @newlista<<name
      end
    end
    @users = @newlista
    for code in @usercode
      if code != id
        @newlistb<<code
      end
    end
    @usercode = @newlistb
  end
end

Server.new