class StatementPrinter
  def print(transactions)
    puts "date || credit || debit || balance"

    transactions.each do |transaction|
      date = transaction.fetch(:date).strftime("%d/%m/%Y")
      credit = format_amount(transaction.fetch(:credit))
      balance = format_amount(transaction.fetch(:balance))

      puts "#{date} || #{credit} || || #{balance}"
    end
  end

  private

  def format_amount(amount)
    "%<amount>.2f" % { amount: amount }
  end
end
