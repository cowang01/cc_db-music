require('pg')
require_relative('../db/sql_runner.rb')
require_relative('./artist.rb')

class Album

  attr_accessor :title, :release_date, :genre, :artist_id
  attr_reader :id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @release_date = options['release_date'].to_i
    @genre = options['genre']
    @artist_id = options['artist_id']
  end

  def save()
    sql = "INSERT INTO album (title, release_date, genre, artist_id) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@title, @release_date, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM album;"
    SqlRunner.run(sql)
  end

  def self.view_all()
    sql = "SElECT * FROM album;"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end

  def artist()
    sql = "SELECT * FROM artist WHERE id = $1;"
    values = [@artist_id]
    artist = SqlRunner.run(sql, values)[0]
    return Artist.new(artist)
  end

  def change_details()
    sql = "UPDATE album SET (title, release_date, genre, artist_id) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@title, @release_date, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM album WHERE id = $1;"
    value = [@id]
    SqlRunner.run(sql, value)
  end

  def find(id)
    sql = "SELECT * FROM album WHERE id = $1"
    values = [id]
    album = SqlRunner.run(sql, values)[0]
    return Album.new(album)
  end
end
