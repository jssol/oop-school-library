require_relative '../solver'

# Create a method called factorial that takes one argument, an integer N, and returns the factorial for that number. The factorial is the multiplication of all integers from 1 to N and has the special case that the factorial of 0 is 1. This method only accepts 0 and positive integers, so if a negative integer is given it should raise an exception.
# Create a method called reverse that takes one argument, a string word, and returns word reversed (e.g. if word is "hello" it returns "olleh").
# Create a method called fizzbuzz that takes one argument, an integer N, and returns a string. The returned string is constructed following these rules:
# When N is divisible by 3, return "fizz".
# When N is divisible by 5, return "buzz".
# When N is divisible by 3 and 5, return "fizzbuzz".
# Any other case, return N as a string (e.g. say N is 7 then return "7").

describe Solver do
  before :each do
    @solver = Solver.new
  end

  context 'testing the factorial method' do
    it 'should return "Please use a positive number" when N is inferior to 0' do
      value = @solver.factorial(-2)
      expect(value).to match("Please use a positive number")
    end

    it 'should return 1 when N equals 0' do
      value = @solver.factorial(0)
      expect(value).to eql(1)
    end

    it 'should return 120 when N equals 5' do
      value = @solver.factorial(5)
      expect(value).to eql(120)
    end
  end
end
