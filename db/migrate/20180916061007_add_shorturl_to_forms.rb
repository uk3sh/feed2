class AddShorturlToForms < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :short_url, :string
  end
end
