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
      save_file("./data/#{file_name}.json", file) if var.size.positive?
    end
  end

  def recover_files
    book_file = get_file('./data/book_list.json')
    people_file = get_file('./data/people_list.json')
    rental_file = get_file('./data/rental_list.json')
    book_to_object(book_file)
    people_to_object(people_file)
    recover_rentals(rental_file, book_file, people_file)
  end

  def add_book(title, author)
    book = Book.new(title.to_s, author.to_s)
    @book_list.push(book)
  end

  def add_student(classroom, age, name, parent_permission)
    student = Student.new(classroom.to_s, age.to_i, name.to_s, parent_permission)
    @people_list.push(student)
  end

  def add_teacher(specialization, age, name)
    teacher = Teacher.new(specialization.to_s, age.to_i, name.to_s)
    @people_list.push(teacher)
  end

  def add_rental(date, book_num, person_num)
    book = @book_list[book_num - 1]
    person = @people_list[person_num - 1]
    rental = Rental.new(date.to_s, book, person)
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
      puts "#{i + 1}) [#{person.type}] Name: #{person.name}"
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
    hash.each do |book|
      current_book = book['value']
      title = current_book['title']
      author = current_book['author']
      add_book(title, author)
    end
  end

  def people_to_object(hash)
    hash.each do |person|
      current_person = person['value']
      case current_person['type']
      when 'Student'
        add_student(current_person['classroom'], current_person['age'], current_person['name'],
                    current_person['parent_permission'])
      when 'Teacher'
        add_teacher(current_person['specialization'], current_person['age'], current_person['name'])
      end
    end
  end

 def recover_rentals(rental_file, book_file, people_file)
  rental_file.each do |rental|
    p rental
  end
 end
end
