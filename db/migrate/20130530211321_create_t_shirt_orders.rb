class CreateTShirtOrders < ActiveRecord::Migration
  def change
    create_table :t_shirt_orders do |t|
      t.timestamps
      t.references :event, null: false
      t.references :person, null: false
      t.string :model, null: false
      t.string :size, null: false
      t.datetime :picked_up_at
    end

    add_index :t_shirt_orders, :event_id
    add_index :t_shirt_orders, :person_id
  end
end
