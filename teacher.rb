require_relative './person.rb'

class Teacher < Person
  def initialize(specialization)
    @specialization = specialization
    super(name: 'Unknown', age)
  end

  def can_use_services? 
    response = true
    response
  end
end
