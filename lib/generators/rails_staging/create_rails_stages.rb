class CreateRailsStages < ActiveRecord::Migration

  def change
    create_table :rails_stages do |t|
      t.string :uuid
      t.string :table
      t.integer :row_id
      t.string :from
      t.string :to
      t.string :creator, default: ""
      t.boolean :reversion, default: false
      t.boolean :applied, default: false
      t.datetime :created_at
      t.datetime :edited_at
    end
    add_index :rails_stages, [:uuid]
  end


end
