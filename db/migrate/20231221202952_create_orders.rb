class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.boolean :text_messages_enabled
      t.integer :item
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
