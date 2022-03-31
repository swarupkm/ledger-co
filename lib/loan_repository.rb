# frozen_string_literal: true

require 'securerandom'
require_relative 'loan'

LoanRecord = Struct.new(:bank_name, :borrower_name, :loan) do
  def match_bank_burrower(bank, burrower)
    bank_name == bank && burrower == burrower
  end
end

class LoanRepository
  def initialize
    @loans = []
  end

  def register(bank_name:, borrower_name:, principal:, number_of_years:, rate_of_interest:)
    id = SecureRandom.alphanumeric
    record = LoanRecord.new(bank_name,
                            borrower_name,
                            Loan.new(id: id,
                                     principal: principal,
                                     number_of_years: number_of_years,
                                     rate_of_interest: rate_of_interest))
    @loans.push(record)
  end

  def get_loan_for(bank_name:, borrower_name:)
    loan_found = @loans.find { |loan| loan.match_bank_burrower(bank_name, borrower_name) }
    loan_found.loan
  end
end
