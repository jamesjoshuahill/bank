require "account"
require "statement_printer"

RSpec.describe "Bank account" do
  it "can deposit and print a statement" do
    statement_printer = StatementPrinter.new
    account = Account.new(statement_printer)

    account.deposit(1000, Date.new(2012, 1, 10))

    expect { account.print_statement }.to output(<<~STATEMENT
    date || credit || debit || balance
    10/01/2012 || 1000.00 || || 1000.00
    STATEMENT
    ).to_stdout
  end
end
