require_relative "questions_db"
require "sqlite3"
require "singleton"

class Questions
    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Questions.new(datum) }
    end

    def self.find_by_id(id)
        id = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          questions 
        WHERE
          id = ?
      SQL
      return nil unless id.length > 0
  
      Questions.new(id.first) 
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
      return nil unless title.length > 0
  
      Questions.new(title.first) 
    end 

    def self.find_by_body(body)
      body = QuestionsDatabase.instance.execute(<<-SQL, body)
      SELECT
        *
      FROM
        questions 
      WHERE
        body = ?
    SQL
    return nil unless body.length > 0

    Questions.new(body.first) 
  end 

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions 
    WHERE
      author_id = ?
    SQL
    return nil unless data.length > 0

    data.map { |question| Questions.new(question) }
    
  end 

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
  #   execute(<<-SQL)
  #   SELECT
      
  #   FROM
      
  #   WHERE
      
  # SQL
    Users.find_by_id(self.author_id)
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

end