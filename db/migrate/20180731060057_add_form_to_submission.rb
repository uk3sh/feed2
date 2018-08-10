class AddFormToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_reference :submissions, :form, foreign_key: true
  end
end
