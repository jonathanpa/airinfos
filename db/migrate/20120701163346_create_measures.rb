class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.datetime :date
      t.integer :pm25
      t.integer :city_id

      t.timestamps
    end
  end
end
