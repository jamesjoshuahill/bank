require "statement_printer"

RSpec.describe StatementPrinter do
  it "can print an empty statement" do
    expect { subject.print([]) }
      .to output("date || credit || debit || balance\n").to_stdout
  end
end
