class TransactionRepository
  def initialize(transaction_class)
    @transaction_class = transaction_class
    @transactions = []
  end

  def create(date:, credit: 0, debit: 0, balance:)
    @transaction_class.new(
      date: date,
      credit: credit,
      debit: debit,
      balance: balance
    ).tap do |transaction|
      @transactions.push(transaction)
    end
  end

  def all
    @transactions
  end
end
