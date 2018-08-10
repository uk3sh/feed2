class AddSubmissionToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_reference :answers, :submission, foreign_key: true
  end
end
