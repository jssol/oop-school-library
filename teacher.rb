require_relative './person'

class Teacher < Person
  def initialize(specialization)
    @specialization = specialization
    super()
  end

  def can_use_services?
    true
  end
end
