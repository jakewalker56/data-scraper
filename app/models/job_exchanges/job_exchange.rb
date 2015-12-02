class JobExchange < ActiveRecord::Base
	has_many :job_postings

	def self.search_terms
		[
			"technology",
			"engineer",
			"developer",
			"analyst",
			"sales",
			"marketing",
			"product",
			"manager",
			"associate"
		]
	end

	def scrape_job_postings
		self.last_scraped_time = Time.zone.now
		puts "Scraping " + self.name + " Exchange at " + self.last_scraped_time.to_s
		#have a different method for each 
		JobExchange.search_terms.each do |search_term|
			jobs = self.get_jobs(search_term)
			jobs.each do |job| 
				old_job = JobPosting.find_by(external_unique_identifier: job[:unique_id])
				if old_job.present?
					old_job.update_from_job(job)
				else
					JobPosting.create_from_job(job)
				end
			end
		end
		self.save
	end

end
