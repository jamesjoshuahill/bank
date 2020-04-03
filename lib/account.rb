require_relative "statement_printer"
require_relative "transaction"

class Account
  class InsufficientFundsError < StandardError; end

  def initialize(statement_printer = StatementPrinter.new, transaction_class = Transaction)
    @statement_printer = statement_printer
    @transaction_class = transaction_class
    @transactions = []
  end

  def print_statement
    @statement_printer.print(@transactions)
  end

  def deposit(amount, date)
    balance = current_balance + amount
    @transactions.push(@transaction_class.new(date: date, credit: amount, balance: balance))
  end

  def withdraw(amount, date)
    balance = current_balance - amount
    raise InsufficientFundsError if balance.negative?

    @transactions.push(@transaction_class.new(date: date, debit: amount, balance: balance))
  end

  private

  def current_balance
    @transactions.any? ? @transactions.last.balance : 0
  end
end
