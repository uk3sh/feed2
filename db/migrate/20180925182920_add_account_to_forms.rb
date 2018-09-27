class AddAccountToForms < ActiveRecord::Migration[5.0]
  def change
    add_reference :forms, :account, foreign_key: true
  end
end
