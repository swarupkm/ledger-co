# frozen_string_literal: true

require_relative '../lib/loan'

RSpec.describe Loan do
  describe '#constructor' do
    let(:loan) { Loan.new(id: 'LOAN1', principal: 1000, number_of_years: 6, rate_of_interest: 2) }
    it 'should create a loan for a loan id' do
      expect(loan.id).to eq('LOAN1')
    end

    it 'should calculate loan amount to be paid' do
      expect(loan.calculated_amount).to eq(1120)
    end
    it 'should calculate emi to be paid' do
      expect(loan.emi_amount).to eq(16)
    end
  end

  describe '#payment' do
    let(:loan) { Loan.new(id: 'LOAN1', principal: 1000, number_of_years: 6, rate_of_interest: 2) }
    it 'should pay lumpsum amount' do
      loan.pay(lumpsum: 300)
      expect(loan.paid).to eq(300)
    end
    it 'should pay in emis' do
      loan.pay(emis: 3)
      expect(loan.paid).to eq(48)
    end
    it 'should pay both lumpsum and emis' do
      loan.pay(lumpsum: 300, emis: 3)
      loan.pay(lumpsum: 400, emis: 4)
      expect(loan.paid).to eq(812)
    end
    it 'should track emis paid' do
      loan.pay(lumpsum: 300, emis: 3)
      loan.pay(lumpsum: 300, emis: 3)
      expect(loan.emis_paid).to eq(6)
    end
    it 'should throw error when extra money paid' do
      expect do
        loan.pay(lumpsum: 3000, emis: 3)
      end.to raise_error(StandardError)
    end
  end

  describe '#balance' do
    let(:loan) { Loan.new(id: 'LOAN1', principal: 10_000, number_of_years: 5, rate_of_interest: 4) }
    it 'should get balance' do
      balance = loan.balance(emis: 40)
      expect(balance).to eq({ amount_paid: 8000, remaining_emis: 20 })
    end
    it 'should get balance for emis less than paid emis' do
      loan.pay(lumpsum: 3000, emis: 30)
      balance = loan.balance(emis: 10)
      expect(balance).to eq({ amount_paid: 2000, remaining_emis: 50 })
    end
    it 'should get balance for emis more than paid emis' do
      loan.pay(lumpsum: 3000, emis: 30)
      balance = loan.balance(emis: 40)
      expect(balance).to eq({ amount_paid: 11_000, remaining_emis: 5 })
    end

    it 'should get balance when amount that can be paid is more than total amount' do
      blah = Loan.new(id: 'LOAN1', principal: 10_000, number_of_years: 3, rate_of_interest: 7)
      blah.pay(lumpsum: 2000, emis: 0)
      expect(blah.balance(emis: 30)).to eq({ amount_paid: 12_100, remaining_emis: 0 })
    end
  end
end
