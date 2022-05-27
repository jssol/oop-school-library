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
    book_file = get_file('./data/book_list.json')
    people_file = get_file('./data/people_list.json')
    rental_file = get_file('./data/rental_list.json')
    book_to_object(book_file)
    people_to_object(people_file)
    rental_to_object(rental_file, people_file, book_file)
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
    hash.each do |book|
      current_book = book['value']
      add_book(current_book['title'], current_book['author'])
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

  def rental_to_object(rental_list, people_list, book_list)
    rental_list.each do |rental|
      current_rental = rental['value']
      date = current_rental['date']
      actual_book_num = ''
      actual_person_num = ''
      book_ref = current_rental['book']
      person_ref = current_rental['person']
      people_list.each do |person|
        next unless person_ref == person['ref']

        current_person = person['value']
        current_person_name = current_person['name']
        current_person_age = current_person['age']
        @people_list.each_with_index do |p, idx|
          actual_person_num = idx + 1 if (p.name = current_person_name && p.age == current_person_age)
        end
      end
      book_list.each do |book|
        next unless book_ref == book['ref']

        current_book = book['value']
        current_book_title = current_book['title']
        current_book_author = current_book['author']
        @book_list.each_with_index do |b, idx|
          actual_book_num = idx + 1 if (b.author = current_book_author && b.title == current_book_title)
        end
      end
      add_rental(date, actual_book_num, actual_person_num)
    end
  end
end
