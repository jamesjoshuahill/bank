require "statement_printer"

RSpec.describe StatementPrinter do
  it "can print an empty statement" do
    expect { subject.print([]) }
      .to output("date || credit || debit || balance\n").to_stdout
  end

  it "can print a deposit" do
    transactions = [
      { date: Date.new(2012, 1, 10), credit: 1000, balance: 1000 }
    ]

    expect { subject.print(transactions) }
      .to output(<<~STATEMENT
      date || credit || debit || balance
      10/01/2012 || 1000.00 || || 1000.00
      STATEMENT
      ).to_stdout
  end

  it "can print two deposits" do
    transactions = [
      { date: Date.new(2012, 1, 10), credit: 1000, balance: 1000 },
      { date: Date.new(2012, 1, 13), credit: 2000, balance: 3000 }
    ]

    expect { subject.print(transactions) }
      .to output(<<~STATEMENT
      date || credit || debit || balance
      13/01/2012 || 2000.00 || || 3000.00
      10/01/2012 || 1000.00 || || 1000.00
      STATEMENT
      ).to_stdout
  end

  it "can print a withdrawal" do
    transactions = [
      { date: Date.new(2012, 1, 14), debit: 500, balance: 2500 },
    ]

    expect { subject.print(transactions) }
      .to output(<<~STATEMENT
      date || credit || debit || balance
      14/01/2012 || || 500.00 || 2500.00
      STATEMENT
      ).to_stdout
  end
end
