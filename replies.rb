require_relative "questions_db"
require "sqlite3"
require "singleton"

class Replies 
    attr_accessor :id, :question_id, :parent_reply_id, :author_id, :body 
  
    def self.all
      data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
      data.map { |datum| Replies.new(datum) }
  end
  
      def self.find_by_id(id)
          id = QuestionsDatabase.instance.execute(<<-SQL, id)
          SELECT
            *
          FROM
            replies  
          WHERE
            id = ?
        SQL
        return nil unless id.length > 0
    
        Replies.new(id.first) 
      end
  
      def self.find_by_author_id(author_id)
          author_id = QuestionsDatabase.instance.execute(<<-SQL, author_id)
          SELECT
            *
          FROM
            replies
          WHERE
            author_id = ?
        SQL
        return nil unless author_id.length > 0
    
        Replies.new(author_id.first) 
      end 
  
  
    def self.find_by_question_id(question_id)
      question_id = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies 
      WHERE
        question_id = ?
      SQL
      return nil unless question_id.length > 0
  
      Replies.new(question_id.first) 
    end 
  
    def self.find_by_body(body)
      body = QuestionsDatabase.instance.execute(<<-SQL, body)
      SELECT
        *
      FROM
        replies
      WHERE
        body = ?
    SQL
    return nil unless body.length > 0
  
    Replies.new(body.first) 
   end 
  
   def self.find_by_parent_reply_id(parent_reply_id)
    parent_reply_id = QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_reply_id = ?
    SQL
    return nil unless parent_reply_id.length > 0
  
    Replies.new(parent_reply_id.first) 
    end   
  
    def initialize(options)
      @id = options['id']
      @parent_reply_id = options['parent_reply_id']
      @question_id = options['question_id']
      @author_id = options['author_id']
      @body = options['body']
    end

    def author
      Users.find_by_id(self.author_id)
    end

    def question
      Questions.find_by_author_id(self.author_id)
    end

    def parent_reply
      Replies.find_by_parent_reply_id(self.parent_reply_id)
    end

    def child_replies
      Replies.find_by_parent_reply_id(self.id)
    end
  
  end 