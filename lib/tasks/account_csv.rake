require 'csv'

namespace :account_csv do
  task :import => :environment do
    puts 'Importing accounts from accounts.csv to database . . .'
    accounts_csv = CSV.read("lib/tasks/accounts.csv")

    accounts_csv.each do |account|
      if Account.find_by(number: account[0])
        puts "Conta #{account[0]} já encontra-se em nossa base de dados"
        next
      end

      new_account = Account.new(number: account[0], amount: account[1])

      new_account.save!

      puts "CONTA: #{new_account.number} cadastrada com sucesso"
    rescue ActiveRecord::RecordInvalid
      puts "Não foi possível cadastrar conta: #{account[0]}"
      puts 'ERROS:'
      new_account.errors.full_messages.each do |error|
        puts "- #{error}"
      end
    end
  end
end
