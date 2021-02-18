# frozen_string_literal: true

require "./spec/spec_helper"
require "./jobs/process_contract_scan_result_job"

RSpec.describe ProcessContractScanResultJob do
  let(:result_text) { FactoryBot.build(:contract_scan_result).raw_result }
  let(:attachment) { FactoryBot.build(:attachment) }

  it "caches the attachment" do
    expect {
      described_class.perform(result_text, attachment)
    }.to change { Attachment.count }.by(1)
  end

  it "caches the email" do
    expect {
      described_class.perform(result_text, attachment)
    }.to change { Email.count }.by(1)
  end

  it "caches the conversation" do
    expect {
      described_class.perform(result_text, attachment)
    }.to change { Conversation.count }.by(1)
  end

  context "when no type is detected" do
    let(:result_text) { FactoryBot.build(:contract_scan_result, :no_contract_type).raw_result }

    it "caches the attachment" do
      expect {
        described_class.perform(result_text, attachment)
      }.to change { Attachment.count }.by(1)
    end

    it "caches the email" do
      expect {
        described_class.perform(result_text, attachment)
      }.to change { Email.count }.by(1)
    end

    it "caches the conversation" do
      expect {
        described_class.perform(result_text, attachment)
      }.to change { Conversation.count }.by(1)
    end
  end

  context "when no parties are detected" do
    let(:result_text) { FactoryBot.build(:contract_scan_result, :no_parties).raw_result }

    it "does not cache the attachment" do
      expect {
        described_class.perform(result_text, attachment)
      }.not_to change { Attachment.count }
    end

    it "does not cache the email" do
      expect {
        described_class.perform(result_text, attachment)
      }.not_to change { Email.count }
    end

    it "does not cache the conversation" do
      expect {
        described_class.perform(result_text, attachment)
      }.not_to change { Conversation.count }
    end
  end
end
