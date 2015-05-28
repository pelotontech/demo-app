class BankAccount < ActiveRecord::Base
  validates :bank_account_id, presence: true
  validates :bank_account_name, presence: true
  validates :bank_account_owner, presence: true
  validates :bank_account_type_code, presence: true
  validates :financial_insitution_number, presence: true
  validates :branch_transit_number, presence: true
  validates :account_number, presence: true
  validates :currency_code, presence: true, inclusion: %w(USD CAD)
  validates :verify_account_by_deposit, presence: true, inclusion: %w(0 1)
end
