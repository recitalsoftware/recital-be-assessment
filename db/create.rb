# typed: true
# No need to run this yourself unless you want to re-create the database from
# scratch. In that case, delete db/sqlite.db then run:
# `bundle exec ruby db/create.rb`
require "./db/connect"

class CreateAssessmentTables < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.references :email, null: false, foreign_key: true
      t.references :contract, null: false, foreign_key: true
      t.integer :external_id
    end
    add_index :attachments, :external_id, unique: true

    create_table :emails do |t|
      t.references :conversation, null: false, foreign_key: true
      t.integer :external_id
    end
    add_index :emails, :external_id, unique: true

    create_table :conversations do |t|
      t.references :contract, null: false, foreign_key: true
      t.integer :external_id
    end
    add_index :conversations, :external_id, unique: true

    create_table :contracts do |t|
      t.string :contract_type
      t.string :parties
    end
  end
end

# Create the table
CreateAssessmentTables.migrate(:up)
