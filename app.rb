require_relative './student'
require_relative './teacher'
require_relative './rental'
require_relative './book'
require_relative './file_manager'

class App
  attr_reader :book_list, :people_list

  def initialize
    @book_list = []
    @people_list = []
    @rental_list = []
  end

  def save_files
    instance_variables.each do |var|
      file = []
      file_name = var.to_s.delete('@')
      instance_variable_get(var).each do |obj|
        file.push({ ref: obj, value: to_hash(obj) })
      end
      save_file("./data/#{file_name}.json", file)
    end
  end

  def recover_files
    instance_variables.each do |var|
      file_name = var.to_s.delete('@')
      file = get_file("./data/#{file_name}.json")
      p file
    end
  end

  def add_book(title, author)
    book = Book.new(title, author)
    @book_list.push(book)
  end

  def add_student(classroom, age, name, parent_permission)
    student = Student.new(classroom, age, name, parent_permission)
    @people_list.push(student)
  end

  def add_teacher(specialization, age, name)
    teacher = Teacher.new(specialization, age, name)
    @people_list.push(teacher)
  end

  def add_rental(date, book_num, person_num)
    book = @book_list[book_num - 1]
    person = @people_list[person_num - 1]
    rental = Rental.new(date, book, person)
    @rental_list.push(rental)
  end

  def display_books
    @book_list.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def display_people
    @people_list.each do |person|
      puts "[#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def display_rental_for_id(id)
    @rental_list.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}" if rental.person.id == id
    end
  end

  def choose_person_to_create_rental
    puts 'Select a person from the following list by number (not id)'
    @people_list.each_with_index do |person, i|
      puts "#{i + 1}) [#{person.type}] Name: #{person.name},"
      + " ID: #{person.id}, Age: #{person.age}"
    end
  end

  def choose_book_to_create_rental
    puts 'Select a book from the following list by number'
    @book_list.each_with_index do |book, i|
      puts "#{i + 1}) Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  private

  def to_hash(object)
    hash = {}
    object.instance_variables.each do |var|
      hash[var.to_s.delete('@')] = object.instance_variable_get(var)
    end
    hash
  end
   
  def book_to_object(hash)
    add_book(hash[:value][:title], hash[:value][:author])
  end

  def people_to_object(hash)
    case hash[:value][:type]
              when 'Student'
              add_student(hash[:value][:classroom], hash[:value][:age], hash[:value][:name], hash[:value][:parent_permission])
              when 'Teacher'
               add_teacher(hash[:value][:specialization], hash[:value][:age],hash[:value][:name])
              end
  end
end
