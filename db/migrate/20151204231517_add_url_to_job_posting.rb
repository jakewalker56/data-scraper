class AddUrlToJobPosting < ActiveRecord::Migration
  def change		
		add_column :job_postings, :job_posted_time, :datetime
		add_column :job_postings, :city, :string
		add_column :job_postings, :state, :string
		add_column :job_postings, :url, :string
  end
end
