require_relative './person'

class Student < Person
  def initialize(classroom)
    @classroom = classroom
    super()
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end


student = Student.new('5')