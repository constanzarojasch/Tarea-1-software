class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :goal
      t.integer :assist
      t.integer :card
      t.references :team, index:true, foreign_key: true

      t.timestamps
    end
  end
end
