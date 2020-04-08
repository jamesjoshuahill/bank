require_relative "statement_printer"
require_relative "transaction_repository"

class Account
  class InsufficientFundsError < StandardError; end
  class InvalidAmountError < StandardError; end

  def initialize(statement_printer = StatementPrinter.new,
    transaction_repository = TransactionRepository.new)

    @statement_printer = statement_printer
    @transaction_repository = transaction_repository
  end

  def print_statement
    transactions = @transaction_repository.all
    @statement_printer.print(transactions)
  end

  def deposit(amount, date)
    validate_amount(amount)
    balance = current_balance + amount
    @transaction_repository.create(date: date, credit: amount, balance: balance)
  end

  def withdraw(amount, date)
    validate_amount(amount)
    raise InsufficientFundsError if amount > current_balance

    balance = current_balance - amount
    @transaction_repository.create(date: date, debit: amount, balance: balance)
  end

  private

  def current_balance
    @transaction_repository.current_balance
  end

  def validate_amount(amount)
    raise InvalidAmountError if amount < 1
  end
end
