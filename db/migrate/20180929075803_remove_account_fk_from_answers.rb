class RemoveAccountFkFromAnswers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :answers, :account, index: true, foreign_key: true
  end
end
