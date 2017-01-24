class CreateTools < ActiveRecord::Migration[5.0]
  def change
    create_table :tools do |t|
      t.string :tool_type
      t.string :model_type
      t.string :listing_name
      t.text :summary
      t.string :address
      t.string :extra_tools
      t.string :dimensions
      t.string :voltage
      t.boolean :is_battery
      t.boolean :is_bag
      t.boolean :is_cordless
      t.boolean :is_blades
      t.boolean :is_bits
      t.int :price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
