class CreateAttentionDesks < ActiveRecord::Migration[5.1]
  def change
    create_table :attention_desks do |t|
      t.string :name

      t.timestamps
    end
  end
end
