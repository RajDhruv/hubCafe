class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :description
      t.integer :created_by
      t.integer :post_id
      t.integer :lock_version

      t.timestamps
    end
  end
end
