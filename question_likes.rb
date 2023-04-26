require_relative "questions_db"
require "sqlite3"
require "singleton"

class QuestionLikes
    attr_accessor :id, :user_id, :question_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map { |datum| QuestionLikes.new(datum) }
    end
  
      def self.find_by_id(id)
          id = QuestionsDatabase.instance.execute(<<-SQL, id)
          SELECT
            *
          FROM
            question_likes 
          WHERE
            id = ?
        SQL
        return nil unless id.length > 0
    
        QuestionLikes.new(id.first) 
      end
  
      def self.find_by_user_id(user_id)
          user_id = QuestionsDatabase.instance.execute(<<-SQL, user_id)
          SELECT
            *
          FROM
            question_likes
          WHERE
            user_id = ?
        SQL
        return nil unless user_id.length > 0
    
        QuestionLikes.new(user_id.first) 
      end 
  
  
    def self.find_by_question_id(question_id)
      question_id = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        questions_likes
      WHERE
        question_id = ?
      SQL
      return nil unless question_id.length > 0
  
      QuestionLikes.new(question_id.first) 
    end 
  
    def initialize(options)
      @id = options['id']
      @user_id = options['user_id']
      @question_id = options['question_id']
    end
  
end 