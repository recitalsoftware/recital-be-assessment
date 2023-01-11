# typed: strict

require "sorbet-runtime"
require "./db/connect"
require "./services/create_attachment_scan_service"

class UploadEmailAttachmentsForScanService
  extend T::Sig

  sig { params(message: EmailProvider::Message).void }
  def self.run(message)
    return if message_already_scanned?(message)

    message.attachments.each do |attachment|
      CreateAttachmentScanService.run(attachment)
    end
  end

  sig { params(message: EmailProvider::Message).returns(T::Boolean) }
  def self.message_already_scanned?(message)
    # Ruby returns the value of the last command in a method, without an
    # explicit return keyword
    Email.exists?(external_id: message.id)
  end
end
