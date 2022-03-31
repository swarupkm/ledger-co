# frozen_string_literal: true

module LoanCalculator
  def self.interest(principal:, number_of_years:, rate_of_interest:)
    principal * number_of_years * (rate_of_interest.to_f / 100)
  end

  def self.amount(principal:, number_of_years:, rate_of_interest:)
    principal + interest(principal: principal, number_of_years: number_of_years, rate_of_interest: rate_of_interest)
  end
end
