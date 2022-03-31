# frozen_string_literal: true

require_relative '../lib/loan_calculator'

RSpec.describe LoanCalculator do
  it 'caluculates interest' do
    interest = LoanCalculator.interest(principal: 1000, number_of_years: 5, rate_of_interest: 10.0)
    expect(interest).to eq(500)
  end

  it 'caluculates amount' do
    amount = LoanCalculator.amount(principal: 1000, number_of_years: 5, rate_of_interest: 10.0)
    expect(amount).to eq(1500)
  end
end
