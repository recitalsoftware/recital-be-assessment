# frozen_string_literal: true

require "./spec/spec_helper"
require "./jobs/process_email_webhook_job"

RSpec.describe ProcessEmailWebhookJob do
  let(:attachment) { FactoryBot.build(:message) }

  subject(:result) do
    described_class.perform(message)
  end

  it "does not cache the message by default"
  it "scans the attachment"

  context "when the conversation is already cached" do
    before do
      attachment.conversation_id = FactoryBot.create(:conversation)
    end
    it "caches the email"
  end
end
