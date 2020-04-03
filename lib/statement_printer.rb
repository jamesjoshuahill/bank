class StatementPrinter
  def print(transactions)
    puts "date || credit || debit || balance"

    transactions.each do |transaction|
      date = transaction.fetch(:date).strftime("%d/%m/%Y")
      credit = "%<amount>.2f" % { amount: transaction.fetch(:credit) }

      puts "#{date} || #{credit} || || #{credit}"
    end
  end
end
