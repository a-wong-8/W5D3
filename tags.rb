require_relative "questions_db"
require "sqlite3"
require "singleton"

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
