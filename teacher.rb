require_relative './person'

class Teacher < Person
  def initialize(specialization)
    @specialization = specialization
    super(name: 'Unknown', age)
  end

  def can_use_services?
    true
  end
end
