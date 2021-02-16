# frozen_string_literal: true

require "factory_bot"
require "./models/contract_scan_result"

RSpec.describe ContractScanResult do
  subject(:result) do
    described_class.new(raw_result: contract_scan_result.raw_result)
  end

  let(:contract_scan_result) { FactoryBot.build(:contract_scan_result) }

  it "sets the contract type" do
    expect(result.type).to eq "Non-Disclosure Agreement"
  end

  it "sets the list of parties" do
    expect(result.parties).to contain_exactly("NEWCO, INC.", "Second Co.")
  end

  it "is full contract info" do
    expect(result).to be_full_contract_info
  end

  context "when contract scan returns the same party twice" do
    let(:contract_scan_result) do
      FactoryBot.build(:contract_scan_result, :duplicated_party)
    end

    it "de-duplicates parties" do
      expect(result.parties).to contain_exactly("NEWCO, INC.", "Second Co.")
    end

    it "is still full contract info" do
      expect(result).to be_full_contract_info
    end
  end

  context "when a blacklisted party name is detected" do
    let(:contract_scan_result) do
      FactoryBot.build(:contract_scan_result, :blacklisted_party)
    end

    it "ignores the party name" do
      expect(result.parties).to contain_exactly("NEWCO, INC.")
    end

    it "is still full contract info" do
      expect(result).to be_full_contract_info
    end
  end

  context "when no contract type is detected" do
    let(:contract_scan_result) do
      FactoryBot.build(:contract_scan_result, :no_contract_type)
    end

    it "defaults to Contract" do
      expect(result.type).to eq "Contract"
    end

    it "is still full contract info" do
      expect(result).to be_full_contract_info
    end
  end

  context "when no parties are detected" do
    let(:contract_scan_result) do
      FactoryBot.build(:contract_scan_result, :no_parties)
    end

    it "returns no parties" do
      expect(result.parties).to eq []
    end

    it "is not full contract info" do
      expect(result).not_to be_full_contract_info
    end
  end
end
