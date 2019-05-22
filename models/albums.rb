require('pg')
require_relative('../db/sql_runner.rb')
require_relative('./artist.rb')

class Album

  attr_reader :id, :title, :release_date, :genre, :artist_id
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
    sql = "SELECT * FROM artist WHERE id = $1"
    values = [@artist_id]
    artist = SqlRunner.run(sql, values)[0]
    return Artist.new(artist)
  end

end
