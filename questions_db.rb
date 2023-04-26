require "sqlite3"
require "singleton"

class QuestionsDatabase < SQLite::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class Users 
    attr_accessor :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| Users.new(datum) }
    end

  def self.find_by_id(id)
    id = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    return nil unless users.length > 0

    Question.new(users.first) 
  end

  def self.find_by_fname(fname, lname)
    fname = QuestionsDatabase.instance.execute(<<-SQL, fname)
    lname = QuestionsDatabase.instance.execute(<<-SQL, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    return nil unless users.length > 0

    Question.new(users.first) 
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

end

class Questions
    attr_accessor :id, :title, :body, :author_id

    def self.find_by_id(id)
        id = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          questions 
        WHERE
          id = ?
      SQL
      return nil unless questions.length > 0
  
      Question.new(questions.first) 
    end

    def self.find_by_title(title)
        title = QuestionsDatabase.instance.execute(<<-SQL, title)
        SELECT
          *
        FROM
          questions 
        WHERE
          title = ?
      SQL
      return nil unless questions.length > 0
  
      Question.new(questions.first) 
    end 

    

end

