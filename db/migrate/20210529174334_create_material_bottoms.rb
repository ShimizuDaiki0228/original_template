class CreateMaterialBottoms < ActiveRecord::Migration[6.1]
  def change
    create_table :material_bottoms do |t|
      t.string :material_bottom_url
      t.timestamps null: false
    end
  end
end
