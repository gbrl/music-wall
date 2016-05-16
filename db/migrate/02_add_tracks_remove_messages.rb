class AddTracksRemoveMessages < ActiveRecord::Migration
  def change
    drop_table :messages
    create_table :tracks do |t|
      t.string :title
      t.string :author
      t.string :url
      t.timestamps
    end
  end
end
