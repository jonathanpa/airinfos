class AddCodeToCities < ActiveRecord::Migration
  def change
    add_column :cities, :code, :string
  end
end
