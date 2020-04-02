class Account
  def initialize(statement_printer)
    @statement_printer = statement_printer
    @transactions = []
  end

  def print_statement
    @statement_printer.print(@transactions)
  end

  def deposit(amount, date)
    @transactions.push({ date: date, credit: amount })
  end
end
