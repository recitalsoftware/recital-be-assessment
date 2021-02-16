require "./jobs/process_email_webhook_job"
require "./jobs/process_contract_scan_result_job"

# an easy way to create fake data for the contract scan result
require "factory_bot"
require "./spec/factories"

# Normally these calls would come from external services/triggers. Obviously we
# don't want external dependencies for this assessment, so this file
# co-ordinates the "faking" of these processes.

# STEP 1: Incoming Email Webhook
# ------------------------------

# This would actually be data fetched from their email
message = OpenStruct.new({
  id: 10,
  conversation_id: 3,
  attachments: [OpenStruct.new({ id: 5 })],
})

ProcessEmailWebhookJob.perform(message)

# End result is that processing the email creates jobs to scan all message
# attachments. When those are done, they fire hooks that we trigger manually:

# STEP 2: Notification that contract scan is complete
# ---------------------------------------------------

attachment = OpenStruct.new({
  id: message.attachments.first.id,
  message: message,
})

ProcessContractScanResultJob.perform(FactoryBot.build(:contract_scan_result).raw_result, attachment)
