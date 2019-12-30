class AddLoansToPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :loans, :float
  end
end
