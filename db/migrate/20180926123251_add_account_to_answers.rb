class AddAccountToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_reference :answers, :account, foreign_key: true
  end
end
