require "account"

RSpec.describe "Bank account" do
  it "can deposit, withdraw and print a statement" do
    account = Account.new

    account.deposit(1000, Date.new(2012, 1, 10))
    account.deposit(2000, Date.new(2012, 1, 13))
    account.withdraw(500, Date.new(2012, 1, 14))

    expect { account.print_statement }.to output(<<~STATEMENT
    date || credit || debit || balance
    14/01/2012 || || 500.00 || 2500.00
    13/01/2012 || 2000.00 || || 3000.00
    10/01/2012 || 1000.00 || || 1000.00
    STATEMENT
    ).to_stdout
  end
end
