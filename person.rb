require_relative './nameable'
require_relative './rental'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :rentals, :type

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand 1..1_000
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    @type = 'Person'
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
