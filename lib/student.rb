require_relative "../config/environment.rb"

class Student
  
  attr_accessor :name, :grade, :id

  def initialize(name, grade, id=nil)
    @name = name 
    @grade = grade
    @id = id
  end
  
  def self.create_table
    sql = <<-SQL
    Create Table If Not Exists students (
    id Integer Primary Key,
    name Text,
    grade Text)
    SQL
    DB[:conn].execute(sql)
  end

end
