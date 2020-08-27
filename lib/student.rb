require_relative "../config/environment.rb"

class Student

  def initialize(name, grade, id=nil)
    @name = name 
    @grade = grade
    @id = id
  end

end
