require "transaction_repository"

RSpec.describe TransactionRepository do
  let(:transaction_class) { class_double(Transaction) }
  subject { described_class.new(transaction_class) }

  it "can create a deposit transaction" do
    transaction = instance_double(Transaction)
    allow(transaction_class).to receive(:new).with(
      date: Date.new(2012, 1, 10),
      credit: 1000,
      debit: 0,
      balance: 1000
    ).and_return(transaction)

    deposit = subject.create(
      date: Date.new(2012, 1, 10),
      credit: 1000,
      balance: 1000
    )

    expect(deposit).to eq(transaction)
    expect(subject.all).to contain_exactly(deposit)
  end

  it "can create a withdrawal transaction" do
    transaction = instance_double(Transaction)
    allow(transaction_class).to receive(:new).with(
      date: Date.new(2012, 1, 14),
      credit: 0,
      debit: 500,
      balance: 1500
    ).and_return(transaction)

    withdrawal = subject.create(
      date: Date.new(2012, 1, 14),
      debit: 500,
      balance: 1500
    )

    expect(withdrawal).to eq(transaction)
    expect(subject.all).to contain_exactly(withdrawal)
  end

  it "can list all transactions" do
    transaction_1 = instance_double(Transaction)
    transaction_2 = instance_double(Transaction)
    allow(transaction_class).to receive(:new).and_return(transaction_1, transaction_2)

    subject.create(date: Date.new(2012, 1, 10), credit: 1000, balance: 1000)
    subject.create(date: Date.new(2012, 1, 10), credit: 1000, balance: 1000)

    expect(subject.all).to eq([transaction_1, transaction_2])
  end
end
