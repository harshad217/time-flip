class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
