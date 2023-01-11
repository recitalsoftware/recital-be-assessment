# typed: true
# frozen_string_literal: true

require "json"

class ContractScanResult
  # There are two scores included in the results: a sentencecore and a
  # extraction score.
  #
  # The first score (at the sentence / phrase level, listed on each `result`
  # object) is the “sentence score” – the strength of the sentence / phrase.
  # I.e. how likely is it that this span of text CONTAINS the right,
  # relevant information? The second score (at the extraction level, listed on
  # each `extracted-value` object) is the “extraction score” – the strength of
  # that specific potential extraction. I.e. how likely is it that
  # this span of text IS the right extraction value?
  #
  # **Results should be ranked first by sentence score, then by extraction
  # score.**

  # The minimum score that we will accept to be a valid result
  # These are not true confidence values, just a relative score
  # that we require a given sentence to match
  MIN_SCORE_FOR_RESULTS = 0.25
  # Score that we require for a value within a sentence
  MIN_SCORE_FOR_VALUES = 0.25

  # Strings are downcased for this comparison, so only lowercase letters here
  PARTY_NAME_BLACKLIST = ["", "signed", "delivered"].freeze

  attr_accessor :raw_result

  # For an exmaple of how the data looks, see spec/factories.rb
  def initialize(opts)
    @raw_result = opts[:raw_result]
  end

  def parsed_result
    @parsed_result ||= JSON.parse(raw_result)
  end

  def type
    # If no contract type is detected, we default to Contract so that a contract
    # is still created when there's parties detected
    @type ||= best_title_result || "Contract"
  end

  def parties
    @parties ||= party_results
  end

  def full_contract_info?
    type.present? && parties.present?
  end

  def best_title_result
    best_result = filtered_results.
      select { |r| r["scan-key"] == "ContractTitle" }.
      max_by { |r| r["score"] }

    return if best_result.blank?

    best_result["extracted-values"].
      max_by { |v| v["score"] }["normalized-value"]
  end

  def party_results
    filtered_results.
      select { |r| r["scan-key"] == "PartyName" }.
      pluck("extracted-values").
      flatten.
      pluck("normalized-value").
      uniq.
      reject { |p| PARTY_NAME_BLACKLIST.include?(p.downcase) }
  end

  def filtered_results
    @filtered_results ||= parsed_result["results"].
      reject { |r| r["score"] < MIN_SCORE_FOR_RESULTS }.
      each do |result|
      result["extracted-values"].reject! do |v|
        v["score"] < MIN_SCORE_FOR_VALUES
      end
    end
  end
end
