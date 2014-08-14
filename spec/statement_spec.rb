require 'spec_helper'
require 'checking_statement'

# total up the deposits -> statement-checking
# total up the checks -> statement-checking
# total up credit card purchases -> positive amount in statement-credit-card
# Deposits - (Non-credit-card Withdrawals + Credit Card Purchases)
# balance


# 100.00 - (Non-credit-card Withdrawals + Credit Card Purchases)
# 100.00 - (20.00 + Credit Card Purchases)
# 100.00 - (20.00 + 15.00)
# 65.00


describe CheckingStatement do
  it "reads the file and returns an array" do
    statement = CheckingStatement.new('/Users/paulwenig/gSchoolWork/bank-balance/spec/fixtures/statement-checking.csv')

    expect(statement.read_lines).to eq([
                              "2014-01-05,Check #1025,,$60.00",
                              "2014-01-05,Check #1026,,$120.00",
                              "2014-01-05,Check #1027,,$74.00",
                              '2014-01-30,Deposit Bank,"$3000.00"'
                            ])
  end

  it "totals the checks in the checking account" do
    # total up the checks -> statement-checking

    statement = CheckingStatement.new('/Users/paulwenig/gSchoolWork/bank-balance/spec/fixtures/statement-checking.csv')

    expect(statement.checking_totals).to eq 254
  end

  it " totals the deposits" do
    # total up the deposits -> statement-checking
    statement = CheckingStatement.new('/Users/paulwenig/gSchoolWork/bank-balance/spec/fixtures/statement-checking.csv')
    expect(statement.deposit_total).to eq 3000
  end

end