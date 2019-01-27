class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :receipient_one
      t.integer :receipient_two
      t.text :context
      t.integer :lock_version

      t.timestamps
    end
  end
end
