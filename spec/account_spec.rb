require "account"

RSpec.describe Account do
  let(:statement_printer) { instance_double(StatementPrinter, print: nil) }
  let(:transaction_class) { class_double(Transaction) }
  subject { described_class.new(statement_printer, transaction_class) }

  it "can print an empty statement" do
    subject.print_statement

    expect(statement_printer).to have_received(:print).with([])
  end

  it "can deposit an amount" do
    deposit = instance_double(Transaction)
    allow(transaction_class).to receive(:new)
      .with(date: Date.new(2012, 1, 10), credit: 1000, balance: 1000)
      .and_return(deposit)

    subject.deposit(1000, Date.new(2012, 1, 10))

    subject.print_statement
    expect(statement_printer).to have_received(:print).with([deposit])
  end

  it "can deposit twice" do
    deposit_1 = instance_double(Transaction, balance: 1000)
    deposit_2 = instance_double(Transaction)
    allow(transaction_class).to receive(:new).and_return(deposit_1, deposit_2)

    subject.deposit(1000, Date.new(2012, 1, 10))
    subject.deposit(2000, Date.new(2012, 1, 13))

    subject.print_statement
    expect(statement_printer).to have_received(:print).with([deposit_1, deposit_2])
  end

  it "can withdraw less than the balance" do
    deposit = instance_double(Transaction, balance: 2000)
    allow(transaction_class).to receive(:new).and_return(deposit)
    withdrawal = instance_double(Transaction)
    allow(transaction_class).to receive(:new)
      .with(date: Date.new(2012, 1, 14), debit: 500, balance: 1500)
      .and_return(withdrawal)

    subject.deposit(2000, Date.new(2012, 1, 13))
    subject.withdraw(500, Date.new(2012, 1, 14))

    subject.print_statement
    expect(statement_printer).to have_received(:print).with([deposit, withdrawal])
  end

  it "fails to withdraw more than the balance" do
    expect { subject.withdraw(1, Date.new(2012, 1, 10)) }
      .to raise_error(Account::InsufficientFundsError)
  end
end
