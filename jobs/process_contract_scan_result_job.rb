class ProcessContractScanResultJob
  def self.perform(result)
    contreact_info = ContractScanResult.new(result)

    return unless contract_info.full_contract_info?

    SaveDetectedContractService.run(contract_info)
  end
end
