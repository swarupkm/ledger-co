# frozen_string_literal: true

require_relative 'loan_repository'

class CommandSession
  attr_reader :loan_repository

  def initialize
    @loan_repository = LoanRepository.new
  end

  def loan(args)
    bank_name, borrower_name, principal, number_of_years, rate_of_interest = args
    principal = principal.to_f
    number_of_years = number_of_years.to_i
    rate_of_interest = rate_of_interest.to_f
    loan_repository.register(bank_name: bank_name,
                             borrower_name: borrower_name,
                             principal: principal,
                             number_of_years: number_of_years,
                             rate_of_interest: rate_of_interest)
  end

  def payment(args)
    bank_name, borrower_name, lumpsum, emis = args
    lumpsum = lumpsum.to_f
    emis = emis.to_i
    loan = loan_repository.get_loan_for(bank_name: bank_name,
                                        borrower_name: borrower_name)
    loan.pay(lumpsum: lumpsum, emis: emis)
  end

  def balance(args)
    bank_name, borrower_name, emis = args
    emis = emis.to_i
    loan = loan_repository.get_loan_for(bank_name: bank_name,
                                        borrower_name: borrower_name)
    balance = loan.balance(emis: emis)
    puts "#{bank_name} #{borrower_name} #{balance[:amount_paid]} #{balance[:remaining_emis]}"
  end
end
