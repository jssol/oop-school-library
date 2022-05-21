require_relative './nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand 1..10_000
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    response = false
    response = true if of_age? || @parent_permission == true
    response
  end

  private

  def of_age?
    response = false
    response = true if @age >= 18
    response
  end
end

person = Person.new(22, 'maximilianus')
  person.correct_name
  capitalizedPerson = CapitalizeDecorator.new(person)
  capitalizedPerson.correct_name
  capitalizedTrimmedPerson = TrimmerDecorator.new(capitalizedPerson)
  capitalizedTrimmedPerson.correct_name
