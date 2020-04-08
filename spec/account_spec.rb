require "account"

RSpec.describe Account do
  let(:statement_printer) { instance_double(StatementPrinter, print: nil) }
  let(:transaction_repository) { instance_double(TransactionRepository) }
  subject { described_class.new(statement_printer, transaction_repository) }

  it "can print an empty statement" do
    allow(transaction_repository).to receive(:all).and_return([])

    subject.print_statement

    expect(statement_printer).to have_received(:print).with([])
  end

  it "can deposit an amount" do
    deposit = instance_double(Transaction)
    allow(transaction_repository).to receive(:create)
      .with(date: Date.new(2012, 1, 10), credit: 1000, balance: 1000)
      .and_return(deposit)
    allow(transaction_repository).to receive(:current_balance).and_return(0)

    transaction = subject.deposit(1000, Date.new(2012, 1, 10))

    expect(transaction).to eq(deposit)
  end

  it "can deposit twice" do
    deposit_1 = instance_double(Transaction)
    deposit_2 = instance_double(Transaction)
    allow(transaction_repository).to receive(:create).and_return(deposit_1, deposit_2)
    allow(transaction_repository).to receive(:current_balance).and_return(0, 1000)

    subject.deposit(1000, Date.new(2012, 1, 10))
    subject.deposit(2000, Date.new(2012, 1, 13))
  end

  it "can withdraw less than the balance" do
    withdrawal = instance_double(Transaction)
    allow(transaction_repository).to receive(:create)
      .with(date: Date.new(2012, 1, 14), debit: 500, balance: 1500)
      .and_return(withdrawal)
    allow(transaction_repository).to receive(:current_balance).and_return(2000)

    transaction = subject.withdraw(500, Date.new(2012, 1, 14))

    expect(transaction).to eq(withdrawal)
  end

  it "fails to deposit a zero amount" do
    expect { subject.deposit(0, Date.new(2012, 1, 10)) }
      .to raise_error(Account::InvalidAmountError)
  end

  it "fails to deposit a negative amount" do
    expect { subject.deposit(-1, Date.new(2012, 1, 10)) }
      .to raise_error(Account::InvalidAmountError)
  end

  it "fails to withdraw a zero amount" do
    expect { subject.withdraw(0, Date.new(2012, 1, 10)) }
      .to raise_error(Account::InvalidAmountError)
  end

  it "fails to withdraw a negative amount" do
    expect { subject.withdraw(-1, Date.new(2012, 1, 10)) }
      .to raise_error(Account::InvalidAmountError)
  end

  it "fails to withdraw more than the balance" do
    allow(transaction_repository).to receive(:current_balance).and_return(0)

    expect { subject.withdraw(1, Date.new(2012, 1, 10)) }
      .to raise_error(Account::InsufficientFundsError)
  end
end
