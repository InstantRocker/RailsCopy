class CreatePeers < ActiveRecord::Migration[5.2]
  def change
    create_table :peers do |t|

      t.timestamps
    end
  end
end
