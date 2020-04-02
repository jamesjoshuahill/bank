require "account"

RSpec.describe Account do
  let(:statement_printer) { double(:statement_printer) }
  subject { described_class.new(statement_printer) }

  it "can print an empty statement" do
    allow(statement_printer).to receive(:print)

    subject.print_statement

    expect(statement_printer).to have_received(:print).with([])
  end
end
