class CreateJobExchanges < ActiveRecord::Migration
  def change
    create_table :job_exchanges do |t|
      t.string :name
      t.datetime :last_scraped_time
      t.timestamps null: false
    end

    add_column :job_postings, :job_exchange_id, :integer
    add_column :job_postings, :job_posted_date, :date
    add_column :job_postings, :last_active_date, :date
    add_column :job_postings, :external_unique_identifier, :string

    add_column :companies, :last_scraped_time, :datetime
  end
end
