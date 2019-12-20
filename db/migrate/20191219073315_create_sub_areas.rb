class CreateSubAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_areas do |t|
      t.string    :area
      t.references  :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
