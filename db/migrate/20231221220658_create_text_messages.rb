class CreateTextMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :text_messages do |t|
      t.string :sid
      t.string :activity_type
      t.integer :activity_id
      t.text :body
      t.string :from
      t.string :to
      t.string :status
      t.string :error_message
      t.string :error_code
      t.timestamps
      t.index :sid, unique: true
      t.index %i[activity_type activity_id], unique: true
    end
  end
end
