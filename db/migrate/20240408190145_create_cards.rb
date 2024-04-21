class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.references :cover, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.date :date_joined
      t.date :date_of_expiry

      t.timestamps
    end
  end
end
