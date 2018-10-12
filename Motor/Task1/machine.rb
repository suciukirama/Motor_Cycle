class Machine
  @@users = {}
  
  def initialize(merk, nama)
    @merk = merk
    @nama = nama
    @@users[nama] = merk
    @@users[nama] = nama
    @files = {}
  end
  
  def create(filename)
    time = Time.now
    @files[filename] = time
    puts "#{filename} was created by #{@username} at #{time}."
  end
  
  def Machine.get_users
    @@users
  end
end

# my_machine = Machine.new("eric", 01234)
# your_machine = Machine.new("you", 56789)

# my_machine.create("groceries.txt")
# your_machine.create("todo.txt")

# puts "Users: #{Machine.get_users}"