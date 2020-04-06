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

  context "with no transactions" do
    it "can list all transactions" do
      expect(subject.all).to be_empty
    end

    it "knows the current balance is zero" do
      expect(subject.current_balance).to be_zero
    end
  end

  context "with three transactions" do
    let(:transactions) {
      [
        instance_double(Transaction, balance: 10),
        instance_double(Transaction, balance: 100),
        instance_double(Transaction, balance: 1000)
      ]
    }
    subject { described_class.new(transaction_class, transactions) }

    it "can list all transactions" do
      expect(subject.all).to eq(transactions)
    end

    it "knows the current balance" do
      expect(subject.current_balance).to eq(1000)
    end
  end
end
