class AddContactToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :contact, :string
  end
end
