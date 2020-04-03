require "transaction"

RSpec.describe Transaction do
  it "can represent a credit" do
    transaction = described_class.new(
      date: Date.new(2012, 1, 10),
      credit: 10,
      debit: 0,
      balance: 30
    )

    expect(transaction).to have_attributes(
      date: Date.new(2012, 1, 10),
      credit: 10,
      debit: 0,
      balance: 30
    )
  end

  it "can represent a debit" do
    transaction = described_class.new(
      date: Date.new(2012, 1, 13),
      credit: 0,
      debit: 5,
      balance: 20
    )

    expect(transaction).to have_attributes(
      date: Date.new(2012, 1, 13),
      credit: 0,
      debit: 5,
      balance: 20
    )
  end
end
