# This file is the code that executes when Recital receives (via a webhook) a
# notification of a new email to process.

class ProcessEmailWebhookJob
  def self.perform(message)
    save_to_email_cache(message) if emails_conversation_cached?(message)

    # If there's no attachments then there's nothing to scan
    return if message.attachments.blank?

    UploadEmailAttachmentsForContractScanService.run(message)
  end
end
