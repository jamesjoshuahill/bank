require_relative "statement_printer"
require_relative "transaction"

class Account
  class InsufficientFundsError < StandardError; end
  class InvalidAmountError < StandardError; end

  def initialize(statement_printer = StatementPrinter.new, transaction_class = Transaction)
    @statement_printer = statement_printer
    @transaction_class = transaction_class
    @transactions = []
  end

  def print_statement
    @statement_printer.print(@transactions)
  end

  def deposit(amount, date)
    validate_amount(amount)
    balance = current_balance + amount
    create_transaction(date: date, credit: amount, balance: balance)
  end

  def withdraw(amount, date)
    validate_amount(amount)
    raise InsufficientFundsError if amount > current_balance

    balance = current_balance - amount
    create_transaction(date: date, debit: amount, balance: balance)
  end

  private

  def current_balance
    @transactions.any? ? @transactions.last.balance : 0
  end

  def validate_amount(amount)
    raise InvalidAmountError if amount < 1
  end

  def create_transaction(date:, credit: 0, debit: 0, balance:)
    transaction = @transaction_class.new(
      date: date,
      credit: credit,
      debit: debit,
      balance: balance
    )
    @transactions.push(transaction)
    return transaction
  end
end
