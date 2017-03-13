class CreateRailsStages < ActiveRecord::Migration

  def change
    create_table :rails_stages do |t|
      t.string :uuid, null: false
      t.string :table, null: false
      t.string :column, null: false
      t.integer :row_id, null: false
      t.string :predecessor, null: false
      t.text :text_value, null: false
      t.string :type, null: false
      t.string :creator, default: ""
      t.string :authorizer, default: ""
      t.boolean :reversion, default: false
      t.boolean :applied, default: false
      t.datetime :created_at
      t.datetime :edited_at
    end
    add_index :rails_stages, :uuid
    add_index :rails_stages, [:table, :column, :row_id]
  end


end
