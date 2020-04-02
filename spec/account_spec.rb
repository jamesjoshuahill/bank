require "account"

RSpec.describe Account do
  it "can print an empty statement" do
    expect(subject.print_statement).to eq("date || credit || debit || balance")
  end
end
