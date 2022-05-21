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
end