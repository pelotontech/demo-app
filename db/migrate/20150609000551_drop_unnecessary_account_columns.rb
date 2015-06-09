class DropUnnecessaryAccountColumns < ActiveRecord::Migration
  def change
    remove_column :bank_accounts, :currency_code
    remove_column :bank_accounts, :verify_account_by_deposit
    BankAccount.connection.schema_cache.clear!
    BankAccount.reset_column_information
  end
end
