# typed: true
# This file is the code that executes when Recital receives (via a webhook) a
# notification of a new email to process.

require "./db/connect"
require "./services/upload_email_attachments_for_scan_service"

class ProcessEmailWebhookJob
  def self.perform(message)
    save_to_email_cache(message) if conversation_already_cached?(message)

    # If there's no attachments then there's nothing to scan
    return if message.attachments.blank?

    # Here is where the message would be uploaded
    UploadEmailAttachmentsForScanService.run(message)
  end

  def self.save_to_email_cache(message)
    # Exclamation marks mean an error will be thrown if the operation fails
    Email.create!(
      external_id: message.id,
      conversation: Conversation.find_by!(external_id: message.conversation_id),
    )
  end

  def self.conversation_already_cached?(message)
    Conversation.where(external_id: message.conversation_id).exists?
  end
end
