class CreateMods < ActiveRecord::Migration[7.1]
  def change
    create_table :mods do |t|
      t.string :name

      t.timestamps
    end
  end
end
