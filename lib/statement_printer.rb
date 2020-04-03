class StatementPrinter
  def print(transactions)
    puts "date || credit || debit || balance"

    transactions.reverse_each do |transaction|
      date = transaction.fetch(:date).strftime("%d/%m/%Y")
      credit = format_amount(transaction.fetch(:credit, 0))
      debit = format_amount(transaction.fetch(:debit, 0))
      balance = format_amount(transaction.fetch(:balance))

      puts [date, credit, debit, balance].join(" ||")
    end
  end

  private

  def format_amount(amount)
    return "" if amount.zero?

    " %<amount>.2f" % { amount: amount }
  end
end
