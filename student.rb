require_relative './person.rb'

class Student < Person
  def initialize(classroom)
    @classroom = classroom
    super(name: 'Unknown', age, parent_permission: true)
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
