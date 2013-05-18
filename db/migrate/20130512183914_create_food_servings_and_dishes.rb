class CreateFoodServingsAndDishes < ActiveRecord::Migration
  def change
    create_table :food_services do |t|
      t.timestamps
      t.references :event, null: false
      t.datetime :opens_at
      t.datetime :closes_at
    end

    add_index :food_services, :event_id
    add_index :food_services, [ :opens_at, :closes_at ]
    add_index :food_services, :closes_at

    create_table :dishes do |t|
      t.timestamps
      t.references :food_service
      t.string :description
      t.boolean :vegetarian, null: false, default: false
      t.boolean :lactose_free, null: false, default: false
      t.boolean :gluten_free, null: false, default: false
    end

    add_index :dishes, :food_service_id
  end
end
