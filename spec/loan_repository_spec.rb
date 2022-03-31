# frozen_string_literal: true

require_relative '../lib/loan_repository'
require_relative '../lib/loan'

RSpec.describe LoanRepository do
  let(:repo) { LoanRepository.new }
  it 'should register a load' do
    repo.register(bank_name: 'BANK', borrower_name: 'ME', principal: 1000, number_of_years: 5, rate_of_interest: 5)
    expect(repo.get_loan_for(bank_name: 'BANK', borrower_name: 'ME')).to be_kind_of(Loan)
  end
end
