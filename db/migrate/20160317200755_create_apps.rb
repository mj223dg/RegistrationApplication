class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, null: false
      t.string :apikey, null: false
      t.timestamps null: false
    end
  end
end
