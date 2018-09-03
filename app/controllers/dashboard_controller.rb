class DashboardController < ApplicationController

  before_action :authenticate_user!

  def index
    @today = Submission.today
    @good_counts = Answer.group(:answer_text).count["Good"]
    @bad_counts = Answer.group(:answer_text).count["Bad"]
    @neutral_counts = Answer.group(:answer_text).count["Neutral"]
  end
  
end