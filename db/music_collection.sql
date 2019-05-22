DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS album;

CREATE TABLE artist(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  label VARCHAR(255)
);

CREATE TABLE album(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  release_date INT8,
  artist_id INT4 REFERENCES artist(id)
);
