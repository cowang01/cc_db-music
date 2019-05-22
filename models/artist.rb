require('pg')
require_relative('../db/sql_runner.rb')
require_relative('./albums.rb')

class Artist

  attr_reader :id, :name, :label
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @label = options['label']
  end

  def save()
    sql = "INSERT INTO artist (name, label) VALUES ($1, $2) RETURNING id;"
    values = [@name, @label]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artist;"
    SqlRunner.run(sql)
  end


end
