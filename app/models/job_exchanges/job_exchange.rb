require 'uri'
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
			"associate",
			"customer service",
			"RN MSN"
		]
	end

	def self.locations
		[
			"Chicago, IL",
			"San Francisco, CA",
			"Boston, MA",
			"New York, NY",
			"Seattle, WA",
			"Austin, TX",
			"Washington DC",
			"Los Angeles, CA",
			"San Jose, CA"
		]
	end

	def scrape_job_postings
		self.last_scraped_time = Time.zone.now
		puts "Scraping " + self.name + " Exchange at " + self.last_scraped_time.to_s
		#have a different method for each 
		JobExchange.search_terms.each do |search_term|
			JobExchange.locations.each do |location|
				jobs = self.get_jobs(search_term, location)
				if jobs.present?
					jobs.each do |job| 
						old_job = JobPosting.find_duplicate(job)
						if old_job.present?
							#old_job.update_from_job(job)
						else
							JobPosting.create_from_job(job)
						end
					end
				else
					#temporary for now
					return
				end
			end
		end
		self.save
	end

end
