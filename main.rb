require_relative './app'

def display_app
  puts "\nPlease choose an option by enter a number:"
  puts ['1 - List all books', '2 - List all people', '3 - Create a person',
        '4 - Create a book', '5 - Create a rental', '6 - List all rentals for a given person id',
        '7 - Exit']
end

def display_books(app)
  app.display_books
end

def display_people(app)
  app.display_people
end

def permission?(permission_value)
  has_permission = true
  permission = permission_value.capitalize
  has_permission = false if permission.include?('N')
  has_permission
end

def create_student(app)
  print "\nAge: "
  age = gets.chomp
  print "\nName: "
  name = gets.chomp
  print "\nHas parent permission? [y/N]: "
  permission_value = gets.chomp
  has_permission = permission?(permission_value)
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

def recover_files(app)
  app.recover_files
end

def list_rental_for_person(app)
  print "\nID of person: "
  id = gets.chomp
  puts 'Rentals:'
  app.display_rental_for_id(id.to_i)
end

def exit_program(app)
  app.save_files
  puts 'Thank you for using this app!'
  exit
end

def take_action(app)
  decision = gets.chomp
  puts 'Please choose one of the options on the list' unless '1234567'.include?(decision)
  decision == '7' && exit_program(app)
  methods = [
    method(:display_books), method(:display_people), method(:create_people),
    method(:create_book), method(:handle_rental), method(:list_rental_for_person)
  ]
  '123456'.include?(decision) && methods[decision.to_i - 1].call(app)
end

def main
  puts "\nWelcome to School Library App!\n"
  app = App.new
  recover_files(app)
  loop do
    display_app
    take_action(app)
  end
end

main
