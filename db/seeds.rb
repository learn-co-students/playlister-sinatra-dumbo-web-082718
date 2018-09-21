# Add seed data here. Seed your database with `rake db:seed`
SongGenre.destroy_all
Song.destroy_all
Genre.destroy_all
Artist.destroy_all


LibraryParser.parse
