require('pg')
require_relative('../db/sql_runner.rb')
require_relative('./albums.rb')

class Artist

  attr_accessor :name, :label
  attr_reader :id
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

  def self.view_all()
    sql = "SElECT * FROM artist;"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Album.new(artist) }
  end

  def all_albums()
    sql = "SELECT * FROM album WHERE artist_id = $1"
    values = [@id]
    albums =  SqlRunner.run(sql, values)
    return albums.map { |album| Album.new(album) }
  end

  def change_details()
    sql = "UPDATE artist SET (name, label) = ($1, $2) WHERE id = $3;"
    values = [@name, @label, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artist WHERE id = $1;"
    value = [@id]
    SqlRunner.run(sql, value)
  end

  def find(id)
    sql = "SELECT * FROM artist WHERE id = $1"
    values = [id]
    artist = SqlRunner.run(sql, values)[0]
    return Album.new(artist)
  end


end
