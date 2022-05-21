require_relative './app'

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

def create_book(app)
  print "\nTitle: "
  title = gets.chomp
  print "\nAuthor: "
  author = gets.chomp
  app.add_book(title, author)
  puts 'Book created successfully'
end

def create_rental(app)
  app.choose_book_to_create_rental
  book_num = gets.chomp
  app.choose_person_to_create_rental
  person_num = gets.chomp
  print "\nDate: "
  date = gets.chomp
  app.add_rental(date, book_num.to_i, person_num.to_i)
  puts 'Rental created successfully'
end

def handle_rental(app)
  app.people_list.length.positive? && app.book_list.length.positive? && create_rental(app)
end

