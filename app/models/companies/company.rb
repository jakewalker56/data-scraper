class Company < ActiveRecord::Base
	has_many :job_postings
	def scrape_job_postings
		self.last_scraped_time = Time.zone.now
		puts "Scraping " + self.name + " Company at " + self.last_scraped_time.to_s
		#have a different method for each 

		self.save
	end
end
