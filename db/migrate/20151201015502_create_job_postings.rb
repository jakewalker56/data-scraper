class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.text :content
      t.integer :salary_range_low
      t.integer :salary_range_high
      t.integer :years_experience
      t.integer :company_id
      t.timestamps null: false
    end
  end
end
