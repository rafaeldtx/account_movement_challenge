require 'csv'

namespace :transaction_csv do
  task :import => :environment do
    puts "Importando transações de 'transactions.csv' para base de dados...\n\n"

    CSV.read("lib/tasks/transactions.csv").each do |transaction|
      account = Account.find_by!(number: transaction[0])
      new_transaction = Transaction.new(
        account: account,
        amount: transaction[1]
      )
      penalty_value = 300

      account.amount += transaction[1].to_i


      penalty = ''
      if transaction[1].to_i < 0 && account.amount < 0
        account.amount -= penalty_value
        new_transaction.amount -= penalty_value

        penalty = "(Multa R$ #{penalty_value/100} aplicada)"
      end

      new_transaction.save!
      account.save!

      puts "- Transação: R$ #{new_transaction.amount/100}."
      puts "  Saldo atual da conta #{account.number}: " +
           "R$ #{account.amount/100} #{penalty} \n\n"

    rescue ActiveRecord::RecordInvalid
      puts "- Não foi possível realizar transação para conta: #{transaction[0]}"
      puts '  ERROS:'
      new_transaction.errors.full_messages.each do |error|
        puts "    > #{error}"
      end
    rescue ActiveRecord::RecordNotFound
      puts "- Ops! Conta #{transaction[0]} informada não existe. \n\n"
    end
  end
end
