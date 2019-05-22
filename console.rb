require('pry')
require_relative('./models/artist.rb')
require_relative('./models/albums.rb')

Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  "name" => "Smithy",
  "label" => "Quick-Records"
  })

artist1.save()

artist2 = Artist.new({
  "name" => "Cool and the Gang",
  "label" => "Mo-Town"
  })
artist2.save()

album1 = Album.new({
  "title" => "Why, Why, Why",
  "release_date" => 1982,
  "artist_id" => artist1.id
  })
album1.save()

album2 = Album.new({
  "title" => "Nope",
  "release_date" => 1988,
  "artist_id" => artist1.id
  })
album2.save()

album3 = Album.new({
  "title" => "Blue Saturdays",
  "release_date" => 2005,
  "artist_id" => artist2.id
  })
album3.save()

binding.pry
nil
