require 'sqlite3'

db = SQLite3::Database.new("lib/db/jukebox.sqlite")
rows = db.execute("SELECT * FROM artists LIMIT 3")

def artist_count(db)
  # TODO: use `db` to execute an SQL query against the database.
  results = db.execute("SELECT COUNT(*) FROM artists;").flatten.first
end

def number_of_rows(db, table_name)
  # TODO: count number of rows in table table_name
  result = db.execute("SELECT COUNT(*) FROM #{table_name};").first.first
end

def sorted_artists(db)
  # TODO: return array of artists' names sorted alphabetically
  result = db.execute("SELECT artists.name FROM artists ORDER BY artists.name").flatten
end

def love_tracks(db)
  # TODO: return array of love songs' names
  result = db.execute("SELECT name FROM tracks WHERE name like '%love%'")
  result.flatten
end

def long_tracks(db, min_length)
  # TODO: return an array of tracks' names verifying: duration > min_length (minutes) sorted by length (ascending)
  min_length = (min_length * 60000)
  # TODO: return an array of tracks' names verifying: duration > min_length (minutes) sorted by length (ascending)
    result = db.execute("SELECT name, milliseconds/60000 from tracks WHERE milliseconds > '#{min_length}'")
  result.flatten
end
