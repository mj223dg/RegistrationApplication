class AddUserReferenceToApp < ActiveRecord::Migration
  def change
    add_reference :apps, :user, index: true
  end
end
