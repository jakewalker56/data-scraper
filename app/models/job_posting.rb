class JobPosting < ActiveRecord::Base
	belongs_to :company
	belongs_to :job_exchange

	before_validation :rectify_time_and_date

	def rectify_time_and_date
		if job_posted_time.present? && job_posted_date.present?
			#do nothing
		elsif job_posted_time.present?
			job_posted_date = job_posted_time.to_date
		elsif job_posted_date.present?
			job_posted_time = job_posted_date.to_date_time
		end
	end

	def self.find_duplicate(job_hash)
		return JobPosting.where(external_unique_identifier: job_hash["external_unique_identifier"]).where(job_exchange_id: job_hash["job_exchange_id"]).where(company_id: job_hash["company_id"]).first
	end

	def self.xlsx_export(wb)
		wb.add_worksheet(name: "data") do |ws|
      		ws.add_row JobPosting.column_names
      		JobPosting.all.each do |jp|
      			ws.add_row jp.attributes.values_at(*JobPosting.column_names)
      		 end
      	end
      	return wb
    end 
    def self.create_from_job(job_hash)
		#parse the job hash into db format
		job_posting = JobPosting.new(job_hash)
		if !job_posting.save
			raise "Failed to save job posting! " + job_posting.errors.full_messages.join("; ")
		end
		#job_posting.attributes = job_hash.slice(*JobPosting.attribute_names())
      
	end
	def update_from_job(job_hash)
		#update self to reflect changes in job, especially any date changes
		#update salary, because of the way Indeed hanldes salary searching
		if self.salary_range_low < job_hash["salary_range_low"].to_i || self.salary_range_high < job_hash["salary_range_high"].to_i
			if self.salary_range_low < job_hash["salary_range_low"].to_i
				self.salary_range_low = job_hash["salary_range_low"].to_i
			end
			if self.salary_range_high < job_hash["salary_range_high"].to_i
				self.salary_range_high = job_hash["salary_range_high"].to_i
			end
			self.save
		end
	end  
end
