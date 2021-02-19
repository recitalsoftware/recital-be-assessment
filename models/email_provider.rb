# typed: true
# In recital, these classes are actually provided by the gem that we use to
# integrate with email providers.

module EmailProvider
  # Yes, the class provided is called Message instead of Email. Recital uses
  # Email as a term internally instead of Message because in future it's likely
  # that we'll connect to other message types, e.g. Slack, Teams.
  class Message
    attr_accessor :id, :conversation_id, :attachments

    def initialize(id: nil, conversation_id: nil, attachments: nil)
      @id = id
      @conversation_id = conversation_id
      @attachments = attachments
    end
  end

  class Attachment
    attr_accessor :id, :message

    def initialize(id: nil, message: nil)
      @id = id
      @message = message
    end
  end
end
