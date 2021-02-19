# typed: strict
# The auto-created attributes come from database inspection by ActiveRecord. You
# can see them in db/create.rb

class Attachment < ActiveRecord::Base
  belongs_to :email
  belongs_to :contract
  # also has auto-created attributes:
  # email_id, contract_id, and external_id
end

class Email < ActiveRecord::Base
  belongs_to :conversation
  has_many :attachments
  # also has auto-created attributes:
  # conversation_id and external_id
end

class Conversation < ActiveRecord::Base
  belongs_to :contract
  # also has auto-created attributes:
  # contract_id and external_id
end

class Contract < ActiveRecord::Base
  has_many :conversations
  has_many :attachments
  # also has auto-created attributes:
  # contract_type and parties
end
