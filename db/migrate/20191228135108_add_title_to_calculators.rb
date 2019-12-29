class AddTitleToCalculators < ActiveRecord::Migration[5.1]
  def change
    add_column :calculators, :title, :text
  end
end
