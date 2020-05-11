require 'csv'

namespace :transaction_csv do
  task :import, [:transaction_file] => :environment do |i, param|
    puts "Importando transações de 'transactions.csv' para base de dados...\n\n"

    csv_transactions = Rails.root.join('db', param[:transaction_file])
    CSV.read(csv_transactions).each do |transaction|
      account = Account.find_by!(number: transaction[0])
      new_transaction = Transaction.new(
        account: account,
        amount: transaction[1]
      )

      account.amount += transaction[1].to_i

      penalty_value = 300
      if transaction[1].to_i < 0 && account.amount < 0
        account.amount -= penalty_value
        new_transaction.amount -= penalty_value
      end

      new_transaction.save!
      account.save!
    rescue ActiveRecord::RecordInvalid
      puts "- Não foi possível realizar transação para conta: #{transaction[0]}"
      puts '  ERROS:'
      new_transaction.errors.full_messages.each do |error|
        puts "    > #{error}"
      end
    rescue ActiveRecord::RecordNotFound
      puts "- Ops! Conta #{transaction[0]} informada não existe. \n\n"
    end

    puts "Importação finalizada.\n\n"
  end
end
