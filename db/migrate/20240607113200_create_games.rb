class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
