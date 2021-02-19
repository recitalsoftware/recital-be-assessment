# typed: true
# No need to run this yourself unless you want to re-create the database from
# scratch. In that case, delete db/sqlite.db then run:
# `bundle exec ruby db/create.rb`
require "./db/connect"

class CreateAssessmentTables < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.integer :email_id
      t.integer :contract_id
      t.integer :external_id
    end
    create_table :emails do |t|
      t.integer :conversation_id
      t.integer :external_id
    end
    create_table :conversations do |t|
      t.integer :contract_id
      t.integer :external_id
    end
    create_table :contracts do |t|
      t.string :contract_type
      t.string :parties
    end
  end
end

# Create the table
CreateAssessmentTables.migrate(:up)
