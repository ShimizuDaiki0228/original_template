class CreateContributions < ActiveRecord::Migration[6.1]
  def change
    create_table :contributions do |t|
      t.string :body
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
