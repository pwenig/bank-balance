require 'spec_helper'
require 'checking_statement'

describe CheckingStatement do

  it 'reads a file and returns an array' do
    statement = CheckingStatement.new('/Users/paulwenig/gSchoolWork/bank-balance/spec/fixtures/statement-checking.csv')
    expect(statement.read_lines).to eq([
                                         "2014-04-27,Check #1089,,$60.00",
                                         "2014-04-27,Check #1090,,$120.00",
                                         "2014-04-27,Check #1091,,$74.00",
                                         '2014-04-30,Deposit ATM,"$3,000.00"'
                                       ])
  end
end