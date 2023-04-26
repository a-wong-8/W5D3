require "sqlite3"
require "singleton"

class QuestionsDatabase < SQLite3::Database
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
    return nil unless id.length > 0

    Users.new(id.first) 
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)

      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    return nil unless user.length > 0  

    Users.new(user.first) 
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

end

class Questions
    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
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
    author_id = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions 
    WHERE
      author_id = ?
    SQL
    return nil unless author_id.length > 0

    Questions.new(author_id.first) 
  end 

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

end

class QuestionLikes
  attr_accessor :id, :user_id, :question_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
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
    question_id = QuestionsDatabase.instance.execute(<<-SQL, title)
    SELECT
      *
    FROM
      questions_follows
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

class Replies 
  attr_accessor :id, :question_id, :parent_reply_id, :author_id, :body 

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
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
    question_id = QuestionsDatabase.instance.execute(<<-SQL, title)
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

end 

class QuestionLikes
    attr_accessor :id, :user_id, :question_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
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
        questions_follows
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

  class Tags 
    attr_accessor :id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| Tags.new(datum) }
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
    return nil unless id.length > 0

    Tags.new(id.first) 
  end

  def initialize(options)
    @id = options['id']
  end

end

class QuestionTags 
    attr_accessor :question_id, :id, :tag_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| QuestionTags.new(datum) }
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
    return nil unless id.length > 0

    QuestionTags.new(id.first) 
  end

  def self.find_by_question_id(question_id)
    question_id = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      question_tags
    WHERE
      question_id = ?
    SQL
    return nil unless question_id.length > 0

    QuestionTags.new(question_id.first) 
  end 

  def self.find_by_tag_id(tag_id)
    tag_id = QuestionsDatabase.instance.execute(<<-SQL, tag_id)
    SELECT
      *
    FROM
      question_tags
    WHERE
      tag_id = ?
    SQL
    return nil unless tag_id.length > 0

    QuestionTags.new(tag_id.first) 
  end 

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @tag_id = options['tag_id']
  end

end