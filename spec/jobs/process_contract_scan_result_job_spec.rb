# frozen_string_literal: true

require "./spec/spec_helper"
require "./jobs/process_contract_scan_result_job"

RSpec.describe ProcessContractScanResultJob do
  let(:contract_scan_result) { FactoryBot.build(:contract_scan_result) }
  let(:attachment) { FactoryBot.build(:attachment) }

  subject(:result) do
    described_class.perform(contract_scan_result.raw_result, attachment)
  end

  it "caches the attachment"
  it "caches the email"
  it "caches the conversation"

  context "when no title is detected" do
    it "does not cache the attachment"
    it "does not cache the email"
    it "does not cache the conversation"
  end

  context "when no parties are detected" do
    it "does not cache the attachment"
    it "does not cache the email"
    it "does not cache the conversation"
  end
end
