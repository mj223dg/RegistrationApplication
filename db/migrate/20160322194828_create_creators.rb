class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :email, null: false
      t.string :password_digest, null:false

      t.timestamps null: false
    end
  end
end
