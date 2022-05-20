class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(name: 'Unknown', age, parent_permission: true)
    @id = Random.rand 1..10_000
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    response = false
    response = true if o_age? || @parent_permission == true
    response
  end

  private

  def of_age?
    response = false
    response = true if @age >= 18
    response
  end
end

person = Person.new('Anderson', 85, parent_permission: true)
