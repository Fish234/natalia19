class CreateFriiends < ActiveRecord::Migration[5.2]
  def change
    create_table :friiends do |t|

      t.timestamps
    end
  end
end
