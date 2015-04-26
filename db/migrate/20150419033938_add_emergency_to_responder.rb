class AddEmergencyToResponder < ActiveRecord::Migration
  def change
    add_reference :responders, :emergency, index: true, foreign_key: true
    # Do a bit of index optimization:
    add_index :responders, [:type, :emergency_id, :on_duty, :capacity],
              # Workaround for auto-generated name being too long (> 62 chars):
              name: 'responders_multi_column_index'
  end
end
