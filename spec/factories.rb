require 'json'

FactoryBot.define do
  factory :contract_scan_result do
    raw_result do
      <<-CONTRACT_SCAN_RESULT
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
    end

    trait :duplicated_party do
      after(:build) do |result|
        parsed_result = JSON.parse(result.raw_result)
        parsed_result["results"] << parsed_result["results"][1]
        result.raw_result = parsed_result.to_json
      end
    end

    trait :blacklisted_party do
      after(:build) do |result|
        parsed_result = JSON.parse(result.raw_result)
        parsed_result["results"][1]["extracted-values"][0]["normalized-value"] = "DELIVERED"
        result.raw_result = parsed_result.to_json
      end
    end

    trait :no_contract_type do
      after(:build) do |result|
        parsed_result = JSON.parse(result.raw_result)
        parsed_result["results"].reject! { |result| result["scan-key"] == "ContractTitle" }
        result.raw_result = parsed_result.to_json
      end
    end

    trait :no_parties do
      after(:build) do |result|
        parsed_result = JSON.parse(result.raw_result)
        parsed_result["results"].reject! { |result| result["scan-key"] == "PartyName" }
        result.raw_result = parsed_result.to_json
      end
    end
  end
end
