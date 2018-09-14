class RemoveAttentionDeskFromSurveys < ActiveRecord::Migration[5.1]
  def change
    remove_reference :surveys, :attention_desk, foreign_key: true
  end
end
