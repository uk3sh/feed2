class AddContactToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :contact, :string
  end
end
