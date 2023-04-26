require_relative "questions_db"
require "sqlite3"
require "singleton"

class Users
    attr_accessor :id, :fname, :lname

    def authored_questions 
     Questions.find_by_author_id(self.id)
     # SELECT * FROM questions WHERE author_id = self.id
    end 

    
end 
