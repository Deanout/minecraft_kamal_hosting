class CreateCommands < ActiveRecord::Migration[7.1]
  def change
    create_table :commands do |t|
      t.text :body

      t.timestamps
    end
  end
end
