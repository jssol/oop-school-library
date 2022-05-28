require './book'
require './student'

describe Book do
  before :each do
    @book = Book.new('title', 'author' )
  end

  context '#new' do
    it 'should return a book obj' do
      expect(@book).to be_instance_of Book
    end
  end

 context '#title' do
    it 'should return the right title' do
      expect(@book.title).to eql 'title'
    end
  end

 context '#author' do
    it 'should return the required author' do
      expect(@book.author).to eql 'author'
    end
  end

  it 'should put rental to be empty' do
    expect(@book.rentals).to eql []
  end

  it 'should add a rental' do
    @student = Student.new('basic4', 16, 'pako', true)
    expect(@book.rentals.length).to eql(0)

    @book.rentals.push(@student)
    expect(@book.rentals.length).to eql(1)
  end
end