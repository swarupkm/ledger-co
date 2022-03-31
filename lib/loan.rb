# frozen_string_literal: true

require_relative 'loan_calculator'

class Loan
  attr_reader :id, :calculated_amount, :emi_amount, :paid, :emis_paid
  def initialize(id:, principal:, number_of_years:, rate_of_interest:)
    @id = id
    @calculated_amount = LoanCalculator.amount(principal: principal,
                                               number_of_years: number_of_years,
                                               rate_of_interest: rate_of_interest)
    @paid = 0
    @emis_paid = 0
    @emi_amount = (@calculated_amount / (number_of_years * 12)).ceil
  end

  def pay(lumpsum: 0, emis: 0)
    to_be_paid = lumpsum + (emis * emi_amount)
    raise StandardError, 'Extra amount to be paid' if @paid + to_be_paid > @calculated_amount

    @paid += to_be_paid
    @emis_paid += emis
  end

  def balance(emis:)
    amount_paid = calculate_balance_amount(emis)
    remaining_emis = ((@calculated_amount - amount_paid) / @emi_amount).ceil
    { amount_paid: amount_paid.ceil, remaining_emis: remaining_emis }
  end

  private

  def calculate_balance_amount(emis)
    amount_paid = 0
    amount_paid = emis * @emi_amount if emis < @emis_paid
    amount_paid = @paid + (emis - @emis_paid) * @emi_amount if emis >= @emis_paid
    amount_paid = @calculated_amount.ceil if amount_paid > @calculated_amount
    amount_paid
  end
end
