class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.string :status, null: false, default: "unstarted"
      t.belongs_to :board, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
