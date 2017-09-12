class AddPrimaryKey < ActiveRecord::Migration[5.1]
  def change
    add_column :product_rates, :id, :primary_key
    add_column :sales,         :id, :primary_key
  end
end
