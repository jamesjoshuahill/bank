require "account"

RSpec.describe Account do
  let(:statement_printer) { double(:statement_printer, print: nil) }
  subject { described_class.new(statement_printer) }

  it "can print an empty statement" do
    subject.print_statement

    expect(statement_printer).to have_received(:print).with([])
  end

  it "can deposit an amount" do
    subject.deposit(1000, Date.new(2012, 1, 10))

    subject.print_statement
    expect(statement_printer).to have_received(:print).with([{
      date: Date.new(2012, 1, 10),
      credit: 1000,
      balance: 1000
    }])
  end

  it "can deposit twice" do
    subject.deposit(1000, Date.new(2012, 1, 10))
    subject.deposit(2000, Date.new(2012, 1, 13))

    subject.print_statement
    expect(statement_printer).to have_received(:print).with([
      {
        date: Date.new(2012, 1, 10),
        credit: 1000,
        balance: 1000
      },
      {
        date: Date.new(2012, 1, 13),
        credit: 2000,
        balance: 3000
      }
    ])
  end

  it "can withdraw an amount" do
    subject.deposit(2000, Date.new(2012, 1, 13))
    subject.withdraw(500, Date.new(2012, 1, 14))

    subject.print_statement
    expect(statement_printer).to have_received(:print).with([
      {
        date: Date.new(2012, 1, 13),
        credit: 2000,
        balance: 2000
      },
      {
        date: Date.new(2012, 1, 14),
        debit: 500,
        balance: 1500
      }
    ])
  end
end
