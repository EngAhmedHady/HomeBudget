class AddKindToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_column :expenses, :kind, :integer
  end
end
