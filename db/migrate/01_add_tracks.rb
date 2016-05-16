class AddTracks < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.string :author
      t.string :url
      t.timestamps
    end
  end
end
