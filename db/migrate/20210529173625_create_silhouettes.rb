class CreateSilhouettes < ActiveRecord::Migration[6.1]
  def change
    create_table :silhouettes do |t|
      t.integer :material_person_id
      t.integer :material_top_id
      t.integer :material_bottom_id
      t.integer :contribution_id
      t.timestamps null: false
    end
  end
end
