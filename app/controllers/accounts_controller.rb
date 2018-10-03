class AccountsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:edit, :update]
  before_action :authenticate_user!

  before_action :set_account, only: [:edit, :update]

  def edit    
    if params[:id].to_i == current_user.account_id         
    else
      redirect_to root_path
    end
  end 

  def update    
    @account.update(account_params)
    redirect_back(fallback_location: edit_account_path, notice: "Updated successfully!")    
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:sender_id, :sender_email)
  end

end
