class AddOnDeleteCascadeToMatches < ActiveRecord::Migration[6.0]
  def change
    # Añadir restricción ON DELETE CASCADE a la columna teamA_id
    add_foreign_key :matches, :teams, column: :teamA_id, on_delete: :cascade, name: "fk_matches_teamA_id_cascade"

    # Añadir restricción ON DELETE CASCADE a la columna teamB_id
    add_foreign_key :matches, :teams, column: :teamB_id, on_delete: :cascade, name: "fk_matches_teamB_id_cascade"
  end
end
