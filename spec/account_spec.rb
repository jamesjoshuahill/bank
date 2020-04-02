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
      credit: 1000
    }])
  end
end
