class CreateIndeeds < ActiveRecord::Migration
  def change
  	add_column :job_postings, :title, :string
  	add_column :job_postings, :company_name, :string
  	add_column :job_postings, :address, :string
  	add_column :job_postings, :latitude, :string
  	add_column :job_postings, :longitude, :string
  	add_column :job_postings, :source, :string
  end
end
