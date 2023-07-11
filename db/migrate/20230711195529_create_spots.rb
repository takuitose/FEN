class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.integer :member_id,       null: false
      t.integer :tag_id,          null: false
      t.string  :title,           null: false
      t.text    :description,     null: false
      t.float   :latitude,        null: false
      t.float   :longitude,       null: false
      t.timestamps
    end
  end
end
