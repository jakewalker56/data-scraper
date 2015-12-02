class JobPosting < ActiveRecord::Base
	belongs_to :company
	belongs_to :job_exchange

	def self.xlsx_export(wb)
		wb.add_worksheet(name: "data") do |ws|
      		ws.add_row JobPosting.column_names
      		JobPosting.all.each do |jp|
      			ws.add_row jp.attributes.values_at(*JobPosting.column_names)
      		 	csv << column_names
      		 end
      	end
      	return wb
    end 
    def self.create_from_job(job)
		#parse the job hash into db format
	end
	def update_from_job(job)
		#update self to reflect changes in job, especially any date changes
	end  
end
