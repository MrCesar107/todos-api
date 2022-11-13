class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.belongs_to :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
