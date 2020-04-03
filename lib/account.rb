class Account
  def initialize(statement_printer)
    @statement_printer = statement_printer
    @transactions = []
  end

  def print_statement
    @statement_printer.print(@transactions)
  end

  def deposit(amount, date)
    balance = current_balance + amount
    @transactions.push({ date: date, credit: amount, balance: balance })
  end

  def withdraw(amount, date)
    balance = current_balance - amount
    @transactions.push({ date: date, debit: amount, balance: balance })
  end

  private

  def current_balance
    @transactions.any? ? @transactions.last.fetch(:balance) : 0
  end
end
