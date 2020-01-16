class CreateTrusts < ActiveRecord::Migration[5.0]
  def change
    create_table :trusts do |t|

      t.references :valuer, foreign_key:  { to_table: :users }, null: false
      t.references :good_user, foreign_key:  { to_table: :users }, null: false

      t.timestamps
    end
  end
end
