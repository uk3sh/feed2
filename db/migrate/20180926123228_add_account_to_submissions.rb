class AddAccountToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_reference :submissions, :account, foreign_key: true
  end
end
