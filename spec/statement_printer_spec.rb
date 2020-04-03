require "statement_printer"

RSpec.describe StatementPrinter do
  it "can print an empty statement" do
    expect { subject.print([]) }
      .to output("date || credit || debit || balance\n").to_stdout
  end

  it "can print a deposit" do
    transactions = [{ date: Date.new(2012, 1, 10), credit: 1000 }]
    expect { subject.print(transactions) }
      .to output(<<~STATEMENT
      date || credit || debit || balance
      10/01/2012 || 1000.00 || || 1000.00
      STATEMENT
      ).to_stdout
  end
end
