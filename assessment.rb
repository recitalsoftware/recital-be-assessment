require "./jobs/process_email_webhook_job"
require "./jobs/process_contract_scan_result_job"

# an easy way to create fake data for the contract scan result
require "factory_bot"
require "./spec/factories"

# This file isn't needed for anything, it's just here to he;p give context on
# how the project works in real life. You do not need to run or modify this
# file.

# Normally these calls would come from external services/triggers. Obviously we
# don't want external dependencies for this assessment, so this file
# co-ordinates the "faking" of these processes.

# STEP 1: Incoming Email Webhook
# ------------------------------

# This would actually be data fetched from their email
# Fake data is usually generated using FactoryBot (see spec/factories.rb), but
# we wanted to conveniently show you the data structure
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

scan_result = <<-CONTRACT_SCAN_RESULT
    {
        "results": [
            {
                "extracted-values": [
                    {
                        "normalized-value": "NEWCO, INC.",
                        "score": 0.7239318694472867,
                        "text": "NEWCO, INC."
                    }
                ],
                "score": 0.955939669149689,
                "scan-key": "PartyName",
                "text": "BYLAWS OF NEWCO, INC. A DELAWARE CORPORATION BYLAWS OF NEWCO, INC. A DELAWARE CORPORATION OFFICES Registered Office."
            },
            {
                "extracted-values": [
                    {
                        "normalized-value": "Second Co.",
                        "score": 0.5239318694472867,
                        "text": "Second Co."
                    }
                ],
                "score": 0.845939669149689,
                "scan-key": "PartyName",
                "text": "BYLAWS OF NEWCO, INC. A DELAWARE CORPORATION BYLAWS OF NEWCO, INC. A DELAWARE CORPORATION OFFICES Registered Office."
            },
            {
                "extracted-values": [
                    {
                        "normalized-value": "Non-Disclosure Agreement",
                        "score": 0.6439318694472867,
                        "text": "Non-Disclosure Agreement"
                    }
                ],
                "score": 0.955939669149689,
                "scan-key": "ContractTitle",
                "text": "This Non-Disclosure Agrement, together with..."
            }
        ]
    }
    CONTRACT_SCAN_RESULT

# See spec/factories.rb for the data
ProcessContractScanResultJob.perform(scan_result, attachment)
