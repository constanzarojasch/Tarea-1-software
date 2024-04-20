class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :stadium
      t.integer :capacity
      t.string :city

      t.timestamps
    end
  end
end
