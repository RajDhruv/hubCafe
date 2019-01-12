class AddCafeLogoToCafes < ActiveRecord::Migration[5.0]
  def change
    add_column :cafes, :cafe_logo, :string
  end
end
