require 'csv'

namespace :account_csv do
  task :import, [:account_file] => :environment do |i, param|
    puts "Importando contas de #{param[:account_file]} para base de dados... \n\n"

    csv_accounts = Rails.root.join('db', param[:account_file])
    CSV.read(csv_accounts).each do |account|
      if Account.find_by(number: account[0])
        puts "Conta #{account[0]} já encontra-se em nossa base de dados \n\n"
        next
      end

      new_account = Account.new(number: account[0], amount: account[1])

      new_account.save!
    rescue ActiveRecord::RecordInvalid
      puts "Não foi possível cadastrar conta: #{account[0]}"
      puts 'ERROS:'
      new_account.errors.full_messages.each do |error|
        puts "- #{error}"
      end
    end

    puts "Importação finalizada.\n\n"
  end

  task :show_all_amounts => :environment do
    accounts = Account.all

    accounts.each do |account|
      puts "- Saldo atual da conta #{account.number}: " +
           "R$ #{account.amount/100} \n\n"
    end
  end
end
