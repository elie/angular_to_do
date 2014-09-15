class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :thing
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
