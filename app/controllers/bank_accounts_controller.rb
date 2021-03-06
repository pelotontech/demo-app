class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:show, :edit, :update, :destroy]

  # GET /bank_accounts
  def index
    @bank_accounts = BankAccount.all
  end

  # GET /bank_accounts/1
  def show
  end

  # GET /bank_accounts/new
  def new
    @bank_account = BankAccount.new
  end

  # GET /bank_accounts/1/edit
  def edit
  end

  # POST /bank_accounts
  def create
    @bank_account = BankAccount.new(bank_account_params)
    if @bank_account.save
      redirect_to @bank_account, notice: 'Bank account was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bank_accounts/1
  def update
    if bank_account_params[:add_bank_account] == 'true'
      peloton  = Pelokit::BankAccount.new @bank_account.api_properties
      response = peloton.add
      if peloton.success  # Save the generated bank account ID.
        @bank_account.bank_account_id = response[:bank_account_id]
        @bank_account.save!
      end
      redirect_to @bank_account, notice: JSON.pretty_generate(response)

    elsif bank_account_params[:deposit_funds] == 'true'
      peloton = Pelokit::ElectronicFundsTransfer.new bank_account_id: @bank_account.bank_account_id,
                                                     amount:          bank_account_params[:amount],
                                                     transfer_date:   Date.tomorrow.iso8601
      response = peloton.deposit
      redirect_to @bank_account, notice: JSON.pretty_generate(response)

    elsif bank_account_params[:delete_bank_account] == 'true'

      peloton  = Pelokit::BankAccount.new bank_account_id: @bank_account.bank_account_id
      response = peloton.remove
      response = response.marshal_dump if response.is_a? OpenStruct
      redirect_to @bank_account, notice: JSON.pretty_generate(response)

    elsif @bank_account.update(bank_account_params)
      # Handle a regular PUT.
      redirect_to @bank_account, notice: 'Bank account was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bank_accounts/1
  def destroy
    @bank_account.destroy
    redirect_to bank_accounts_url, notice: 'Bank account was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bank_account_params
      params.require(:bank_account).permit(:bank_account_id, :bank_account_name, :bank_account_owner, :bank_account_type_code, :financial_insitution_number, :branch_transit_number, :account_number, :add_bank_account, :deposit_funds, :amount, :delete_bank_account)
    end
end
