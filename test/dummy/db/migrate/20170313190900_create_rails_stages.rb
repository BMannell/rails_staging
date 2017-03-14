class CreateRailsStages < ActiveRecord::Migration

  def change
    create_table :rails_stages do |t|
      t.string :uuid, null: false, default: ""
      t.integer :stageable_id, null: false
      t.string :stageable_type, null: false
      t.string :column, null: false
      t.string :predecessor, default: ""
      t.text :value, null: false, default: ""
      t.string :type, null: false, default: ""
      t.string :creator, default: ""
      t.string :authorizer, default: ""
      t.boolean :reversion, default: ""

      t.datetime :applied_at

      t.timestamps null: false

    end
    add_index :rails_stages, [:uuid]
  end


end
