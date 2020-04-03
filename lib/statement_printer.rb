class StatementPrinter
  def print(transactions)
    puts "date || credit || debit || balance"

    transactions.reverse_each do |transaction|
      date = transaction.fetch(:date).strftime("%d/%m/%Y")
      credit = format_transfer(transaction.fetch(:credit, 0))
      debit = format_transfer(transaction.fetch(:debit, 0))
      balance = format_amount(transaction.fetch(:balance))

      puts [date, credit, debit, balance].join(" ||")
    end
  end

  private

  def format_transfer(amount)
    return "" if amount.zero?

    format_amount(amount)
  end

  def format_amount(amount)
    " %<amount>.2f" % { amount: amount }
  end
end
