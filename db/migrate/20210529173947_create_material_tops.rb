class CreateMaterialTops < ActiveRecord::Migration[6.1]
  def change
    create_table :material_tops do |t|
      t.string :material_top_url
      t.timestamps null: false
    end
  end
end
