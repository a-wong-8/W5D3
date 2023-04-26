require_relative "questions_db"
require "sqlite3"
require "singleton"

class QuestionTags 
    attr_accessor :question_id, :id, :tag_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_tags")
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