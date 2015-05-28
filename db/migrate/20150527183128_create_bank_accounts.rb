class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :bank_account_id
      t.string :bank_account_name
      t.string :bank_account_owner
      t.string :bank_account_type_code
      t.string :financial_insitution_number
      t.string :branch_transit_number
      t.string :account_number
      t.string :currency_code
      t.string :verify_account_by_deposit

      t.timestamps null: false
    end
  end
end
