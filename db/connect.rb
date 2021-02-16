require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/sqlite.db",
)

class Attachment < ActiveRecord::Base
  belongs_to :email
  belongs_to :contract
end

class Email < ActiveRecord::Base
  belongs_to :conversation
end

class Conversation < ActiveRecord::Base
  belongs_to :contract
end

class Contract < ActiveRecord::Base
  has_many :conversations
  has_many :attachments
end
