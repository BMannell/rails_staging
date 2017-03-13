class CreateRailsStages < ActiveRecord::Migration

  def change
    create_table :rails_stages do |t|
      t.string :uuid, null: false
      t.integer :stageable_id, null: false
      t.string :stageable_type, null: false
      t.string :column, null: false
      t.string :predecessor, null: false
      t.text :value, null: false
      t.string :type, null: false
      t.string :creator, default: ""
      t.string :authorizer, default: ""
      t.boolean :reversion, default: false
      t.boolean :applied, default: false
      t.datetime :created_at
      t.datetime :edited_at
    end
    add_index :rails_stages, [:uuid]
  end


end
