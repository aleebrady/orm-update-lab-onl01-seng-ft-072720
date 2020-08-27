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
  
  def self.drop_table
    sql = <<-SQL
    Drop Table students
    SQL
    DB[:conn].execute(sql)
  end
  
  def save
    if self.id
      self.update
    else
      sql = <<-SQL
      Insert Into students(name, grade)
      Values(?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("Select last_insert_rowid() From students")[0][0]
    end
  end
  
  def self.create(name, grade)
    student = Student.new(name, grade)
    student.save
    student
  end
  
  def self.new_from_db()
    
  end
  
  

end
