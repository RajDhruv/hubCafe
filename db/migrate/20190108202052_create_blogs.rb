class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.integer :lock_version
      t.integer :cafe_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
