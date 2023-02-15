# typed: true
# No need to run this yourself unless you want to re-create the database from
# scratch. In that case, delete db/sqlite.db then run:
# `bundle exec ruby db/create.rb`
require "./db/connect"

class CreateAssessmentTables < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.reference :email_id
      t.reference :contract_id
      t.reference :external_id
    end
    create_table :emails do |t|
      t.reference :conversation_id
      t.reference :external_id
    end
    create_table :conversations do |t|
      t.reference :contract_id
      t.reference :external_id
    end
    create_table :contracts do |t|
      t.string :contract_type
      t.string :parties
    end
  end
end

# Create the table
CreateAssessmentTables.migrate(:up)
