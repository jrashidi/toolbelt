class AddConfirmationToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :confirmation, :boolean, :default => false
  end
end
