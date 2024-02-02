# typed: strict

require "sorbet-runtime"
require "./models/email_provider"

class CreateAttachmentScanService
  extend ::T::Sig

  sig { params(attachment: EmailProvider::Attachment).void }
  def self.run(attachment)
    # Intentionally blank - this would be the logic that kicks off the scan
    # But that has side effects and this is just a sample project, so we're
    # faking it
    #
    # Uploads file to Attachment Scanning Service, returns metadata about
    # inferred attachment info
    # Example in: assessment.rb:51
    #
    # If `Email` doesn't exist, would create an `Email` object for the attachment
    # to belong to
  end
end
