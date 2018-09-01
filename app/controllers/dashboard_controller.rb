class DashboardController < ApplicationController

  def index
    @today = Submission.today
    @good_counts = Answer.group(:answer_text).count["good"]
    @bad_counts = Answer.group(:answer_text).count["bad"]
  end
  
end