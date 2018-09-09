class AddOptionToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :option, :text
  end
end
