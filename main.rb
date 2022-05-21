require './app'

def display_app
  puts "\nPlease choose an option by enter a number:"
  puts ['1 - List all books', '2 - List all people', '3 - Create a person',
        '4 - Create a book', '5 - Create a rental', '6 - List all rentals for a given person id',
        '7 - Exit']
end

def create_student(app)
  print "\nAge: "
  age = gets.chomp
  print "\nName: "
  name = gets.chomp
  print "\nHas parent permission? [y/N]: "
  has_permission = true
  permission_value = gets.chomp
  permission = permission_value.capitalize
  has_permission = false if permission.include?('N')
  print "\nClassroom: "
  classroom = gets.chomp
  app.add_student(classroom, age.to_i, name, has_permission)
end

def create_teacher(app)
  print "\nAge: "
  age = gets.chomp
  print "\nName: "
  name = gets.chomp
  print "\nSpecialization: "
  specialization = gets.chomp
  app.add_teacher(specialization, age.to_i, name)
end

def create_people(app)
  print 'Do you want to create a student (1) or a teacher (2)? [input the number]: '
  choice = gets.chomp
  create_student(app) if choice == '1'
  create_teacher(app) if choice == '2'
  puts 'Person created successfully'
end
