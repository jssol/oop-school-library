class Person
  attr_accessor :name
  attr_accessor :age
  attr_reader :id

  def initialize(name: 'Unknown', age, parent_permission: true)
    @id = Random.rand 1..10000
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  private
  def is_of_age?
    response = false
    response = true if @age >= 18
    response
  end

  def can_use_services? 
    response = false
    response = true if self.is_of_age? || @parent_permission == true
    response
  end
end
