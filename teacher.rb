require_relative './person'

class Teacher < Person
  def initialize(specialization, age, name)
    super(age, name)
    @specialization = specialization
    @type = 'Teacher'
  end

  def can_use_services?
    true
  end
end
