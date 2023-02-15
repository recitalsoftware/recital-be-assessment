# typed: strict

require "sorbet-runtime"
require "./models/contract_scan_result"
require "./models/email_provider"

class ProcessContractScanResultJob
  extend ::T::Sig

  sig { params(result: String, attachment: EmailProvider::Attachment).void }
  def self.perform(result, attachment)
    contract_info = ContractScanResult.new(raw_result: result)

    return unless contract_info.full_contract_info?

    save_detected_contract_and_cache_attachment(contract_info, attachment)
  end

  sig do
    params(contract_info: ContractScanResult,
           attachment: EmailProvider::Attachment).void
  end
  def self.save_detected_contract_and_cache_attachment(
    contract_info, attachment
  )
    # Exclamation marks mean an error will be thrown if the operation fails
    Attachment.create!(
      external_id: attachment.id,
      email: Email.create!(
        external_id: attachment.message.id,
        conversation: Conversation.create!(
          external_id: attachment.message.conversation_id,
        ),
      ),
      contract: Contract.create!
    )
  end
end
