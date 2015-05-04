class Main_tests
  def initialize
    @usercode=[0x199,0x341]
    @users=["max","ren"]
    test
  end
  def search_username(usercode)
    snum = 0
    puts "searching for name"
    for code in @usercode
      puts "#{code}"
      if code == usercode
        puts "#{@users[snum]}"
        return @users[snum]
      else
        puts "#{num}"
        snum = snum + 1
      end
      puts "ended search for name"
    end
  end
  def test()
    raise unless search_username(0x199).is_a?(String)
  end
end

Main_tests.new