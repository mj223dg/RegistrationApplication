class AddReferencePositionToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :position, index: true
  end
end
