namespace :csv_import do
  task :files, [:account_file, :transaction_file] do |i, params|
    account_file = params[:account_file]
    transaction_file = params[:transaction_file]

    Rake.application.invoke_task("account_csv:import[#{account_file}]")
    puts "------------------------------- \n\n"
    Rake.application.invoke_task("transaction_csv:import[#{transaction_file}]")
    puts "------------------------------- \n\n"
    Rake.application.invoke_task(
      "account_csv:show_all_amounts[#{transaction_file}]"
    )
  end
end
