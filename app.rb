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
    recover_books(book_file)
    recover_people(people_file)
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

  def recover_books(hash)
    hash.each do |book|
      current_book = book['value']
      title = current_book['title']
      author = current_book['author']
      add_book(title, author)
    end
  end

  def recover_people(hash)
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
      current_rental = rental['value']
      rental_date = current_rental['date']
      rental_person = current_rental['person']
      rental_book = current_rental['book']
      saved_book = book_file.find { |book| book['ref'] == rental_book }
      saved_person = people_file.find { |person| person['ref'] == rental_person }
      saved_book_value = saved_book['value']
      saved_person_value = saved_person['value']
      saved_book_title = saved_book_value['title']
      saved_book_author = saved_book_value['author']
      saved_person_name = saved_person_value['name']
      saved_person_age = saved_person_value['age']
      book_index = find_book_index(saved_book_title, saved_book_author)
      person_index = find_person_index(saved_person_name, saved_person_age)
      add_rental(rental_date, book_index, person_index)
    end
  end

  def find_book_index(title, author)
    book = @book_list.find { |b| b.title == title && b.author == author }
    @book_list.find_index(book) + 1
  end

  def find_person_index(name, age)
    person = @people_list.find { |p| p.name == name && p.age == age }
    @people_list.find_index(person) + 1
  end
end
