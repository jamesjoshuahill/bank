class Account
  def initialize(statement_printer)
    @statement_printer = statement_printer
  end

  def print_statement
    @statement_printer.print([])
  end
end
