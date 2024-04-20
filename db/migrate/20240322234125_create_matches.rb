class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :teamA, null: false, foreign_key: {to_table: :teams}
      t.references :teamB, null: false, foreign_key: {to_table: :teams}
      t.boolean :state
      t.string :result

      t.timestamps
    end
  end
end
