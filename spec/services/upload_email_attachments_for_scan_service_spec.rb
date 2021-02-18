# frozen_string_literal: true

require "./spec/spec_helper"
require "./services/upload_email_attachments_for_scan_service"

RSpec.describe UploadEmailAttachmentsForScanService do
  let(:attachment) { FactoryBot.build(:message) }

  subject(:result) do
    described_class.run(message)
  end

  it "creates a scan for the attachment"
  
  context "multiple attachments" do
    it "scans all attchments"
  end

  context "no attachments" do
    it "runs no scan"
  end
end
