# typed: strict
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/sqlite.db",
)

require "./models/db"
