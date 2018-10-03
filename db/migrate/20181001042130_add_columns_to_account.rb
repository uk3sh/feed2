class AddColumnsToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :sender_id, :string
    add_column :accounts, :sender_email, :string
  end
end
