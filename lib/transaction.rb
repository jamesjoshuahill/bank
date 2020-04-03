class Transaction
  attr_reader :date, :credit, :debit, :balance

  def initialize(date:, credit:, debit:, balance:)
    @date, @credit, @debit, @balance = date, credit, debit, balance
  end
end
