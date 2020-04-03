require "statement_printer"
require "transaction"

RSpec.describe StatementPrinter do
  it "can print an empty statement" do
    expect { subject.print([]) }
      .to output("date || credit || debit || balance\n").to_stdout

    expect(subject.print([])).to be_nil
  end

  it "can print a deposit" do
    deposit = instance_double(
      Transaction,
      date: Date.new(2012, 1, 10),
      credit: 1000,
      debit: 0,
      balance: 1000
    )

    expect { subject.print([deposit]) }
      .to output(<<~STATEMENT
      date || credit || debit || balance
      10/01/2012 || 1000.00 || || 1000.00
      STATEMENT
      ).to_stdout
  end

  it "can print two deposits" do
    deposit_1 = instance_double(
      Transaction,
      date: Date.new(2012, 1, 10),
      credit: 1000,
      debit: 0,
      balance: 1000
    )
    deposit_2 = instance_double(
      Transaction,
      date: Date.new(2012, 1, 13),
      credit: 2000,
      debit: 0,
      balance: 3000
    )

    expect { subject.print([deposit_1, deposit_2]) }
      .to output(<<~STATEMENT
      date || credit || debit || balance
      13/01/2012 || 2000.00 || || 3000.00
      10/01/2012 || 1000.00 || || 1000.00
      STATEMENT
      ).to_stdout
  end

  it "can print a withdrawal" do
    withdrawal = instance_double(
      Transaction,
      date: Date.new(2012, 1, 14),
      credit: 0,
      debit: 500,
      balance: 2500
    )

    expect { subject.print([withdrawal]) }
      .to output(<<~STATEMENT
      date || credit || debit || balance
      14/01/2012 || || 500.00 || 2500.00
      STATEMENT
      ).to_stdout
  end

  it "can print a zero balance" do
    withdrawal = instance_double(
      Transaction,
      date: Date.new(2012, 1, 14),
      credit: 0,
      debit: 500,
      balance: 0
    )

    expect { subject.print([withdrawal]) }
      .to output(<<~STATEMENT
      date || credit || debit || balance
      14/01/2012 || || 500.00 || 0.00
      STATEMENT
      ).to_stdout
  end
end
