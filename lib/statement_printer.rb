class StatementPrinter
  def print(transactions)
    puts "date || credit || debit || balance"

    transactions.reverse_each do |transaction|
      date = transaction.date.strftime("%d/%m/%Y")
      credit = format_transfer(transaction.credit)
      debit = format_transfer(transaction.debit)
      balance = format_amount(transaction.balance)

      puts [date, credit, debit, balance].join(" ||")
    end

    return
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
