class DashboardController < ApplicationController

  skip_after_action :verify_policy_scoped, only: [:index]
  before_action :authenticate_user!

  def index
    @today = policy_scope(Submission).where("submissions.created_at >= ?", Time.zone.now.beginning_of_day)     
  end
  
end