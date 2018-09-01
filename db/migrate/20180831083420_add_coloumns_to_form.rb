class AddColoumnsToForm < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :sender_ID, :string
    add_column :forms, :message, :text
  end
end
