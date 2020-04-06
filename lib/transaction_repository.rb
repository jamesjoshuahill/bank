require "transaction"

class TransactionRepository
  def initialize(transaction_class = Transaction, transactions = [])
    @transaction_class = transaction_class
    @transactions = transactions
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

  def current_balance
    @transactions.any? ? @transactions.last.balance : 0
  end
end
