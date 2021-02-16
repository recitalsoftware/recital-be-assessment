require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/sqlite.db",
)

class Attachment < ActiveRecord::Base
  belongs_to :email
end

class Email < ActiveRecord::Base
  belongs_to :conversation
end

class Conversation < ActiveRecord::Base
end
