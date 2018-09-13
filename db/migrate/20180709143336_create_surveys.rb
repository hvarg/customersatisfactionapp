class CreateSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :surveys do |t|
      t.integer :score
      t.references :attention_desk, foreign_key: true

      t.timestamps
    end
  end
end
