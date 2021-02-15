# Normally these calls would come from external services/triggers. Obviously we
# don't want external dependencies for this assessment, so this file
# co-ordinates the "faking" of these processes.

message = { data: "This would actually be data fetched from their email", already_exists: false }

ProcessEmailWebhookJob.perform(message)

# End result is that processing the email creates jobs to scan all message
# attachments. When those are done, they fire hooks that we trigger manually:
result = "todo"

PRocessContractScanResultJob.perform(result)
