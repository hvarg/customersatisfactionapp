class AddFieldToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :country, :string
  end
end
