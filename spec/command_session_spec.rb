# frozen_string_literal: true

require_relative '../lib/command_session'
require_relative '../lib/loan_repository'

RSpec.describe CommandSession do
  let(:session) { CommandSession.new }
  it 'should initialize with a loan repository' do
    expect(session.loan_repository).to be_kind_of(LoanRepository)
  end

  it 'should give loan' do
    expect { session.loan(%w[IDIDI Dale 5000 1 6]) }.not_to raise_error
  end
  it 'should do payment' do
    session.loan(%w[IDIDI Dale 5000 1 6])
    expect { session.payment(%w[IDIDI Dale 500 6]) }.not_to raise_error
  end
  it 'should get balance' do
    session.loan(%w[IDIDI Dale 5000 1 6])
    expect { session.balance(%w[IDIDI Dale 6]) }.not_to raise_error
  end
end
