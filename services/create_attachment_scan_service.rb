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
  end
end
