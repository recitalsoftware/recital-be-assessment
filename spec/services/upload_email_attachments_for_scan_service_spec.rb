# frozen_string_literal: true

require "./spec/spec_helper"
require "./services/upload_email_attachments_for_scan_service"

RSpec.describe UploadEmailAttachmentsForScanService do
  # Yeah we really should unify the terminology, eh?
  let(:message) { FactoryBot.build(:email) }

  before do
    # This mocks out the call. Normally we'd do a more integration test, but
    # here the full class is mocked out for the assessment. So, by adding this
    # mock, we get the ability to check that it was run as an expectation below.
    allow(CreateAttachmentScanService).to receive(:run)
  end

  it "creates a scan for the attachment" do
    described_class.run(message)
    expect(CreateAttachmentScanService).to have_received(:run).once.with(
      message.attachments.first
    )
  end

  context "multiple attachments" do
    before do
      message.attachments << FactoryBot.build(:attachment)
    end

    it "scans all attchments" do
      described_class.run(message)
      expect(CreateAttachmentScanService).to have_received(:run).once.with(
        message.attachments.first
      )
      expect(CreateAttachmentScanService).to have_received(:run).once.with(
        message.attachments.last
      )
    end
  end

  context "no attachments" do
    before do
      message.attachments = []
    end

    it "runs no scan" do
      described_class.run(message)
      expect(CreateAttachmentScanService).not_to have_received(:run)
    end
  end
end
