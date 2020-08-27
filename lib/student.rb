require_relative "../config/environment.rb"

class Student
  
  attr_accessor :name, :grade, :id

  def initialize(id=nil, name, grade)
    @id = id
    @name = name 
    @grade = grade
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
  
  def self.new_from_db(row)
    id = row[0]
    name =  row[1]
    grade = row[2]
    self.new(id, name, grade)
  end
  
  def self.find_by_name(name)
    sql = <<-SQL
    Select *From students Where name = ?
    SQL
    
    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end
  
  def update
    
  end

end
