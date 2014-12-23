class PelotonController < ApplicationController

  layout 'application'

  def input
  end

  def api
    account   = Peloton::BankAccount.new
    params    = { client_id:        Peloton.client_id,
                  account_name:     Peloton.account_name,
                  password:         Peloton.password,
                  application_name: Peloton.application_name }.merge(api_params)
    @response = account.add_bank_account(params)
  end

  private
  def api_params
    params.permit(:application_name,
                  :bank_account_id,
                  :bank_account_name,
                  :bank_account_owner,
                  :bank_account_type_code,
                  :financial_insitution_number,
                  :branch_transit_number,
                  :account_number,
                  :currency_code,
                  :verify_account_by_deposit,
                  :language_code)
  end

end
