require 'bundler'
Bundler.require

$LOAD_PATH << '.'
require 'models/hacktive_record/base'
require 'models/artist'
require 'models/album'

DB = SQLite3::Database.new('db/music.db')
DB.results_as_hash = true
