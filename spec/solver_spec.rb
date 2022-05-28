require_relative '../solver'

describe Solver do
  before :each do
    @solver = Solver.new
  end

  context 'testing the factorial method' do
    it 'should return "Please use a positive number" when N is inferior to 0' do
      value = @solver.factorial(-2)
      expect(value).to match('Please use a positive number')
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

  context 'testing the reverse method' do
    it 'when given string is empty' do
      expect(@solver.reverse('')).to eql ''
    end

    it 'should return "olleH" when the given word is "Hello"' do
      expect(@solver.reverse('Hello')).to eql 'olleH'
    end
  end

  context 'testing the fizzbuzz method' do
    it 'When N is divisible by 3, return "fizz"' do
      expect(@solver.fizzbuzz(3)).to eql 'fizz'
    end
    it 'When N is divisible by 5, return "buzz"' do
      expect(@solver.fizzbuzz(5)).to eql 'buzz'
    end
    it 'When N is divisible by 3 and 5, return "fizzbuzz"' do
      expect(@solver.fizzbuzz(15)).to eql 'fizzbuzz'
    end
    it 'Any other case, return N as a string' do
      expect(@solver.fizzbuzz(7)).to eql '7'
    end
  end
end
