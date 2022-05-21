require_relative './student'
require_relative './teacher'
require_relative './rental'
require_relative './book'

class App
  attr_reader :book_list, :people_list

  def initialize
    @book_list = []
    @people_list = []
    @rental_list = []
  end

  def add_book(title, author)
    book = Book.new(title, author)
  end

  def add_student(classroom, age, name, parent_permission)
    student = Student.new(classroom, age, name, parent_permission)
    @people_list.push({ value: student, type: 'Student' })
  end

  def add_teacher(specialization, age, name)
    teacher = Teacher.new(specialization, age, name)
    @people_list.push({ value: teacher, type: 'Teacher' })
  end
end
