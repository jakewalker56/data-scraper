desc "scrape job postings"
task :scrape_job_postings => :environment do
    begin
	  Company.all.each do |company|
	    company.scrape_job_postings
	  end
	  JobExchange.all.each do |job_exchange|
	  	job_exchange.scrape_job_postings
	  end
	rescue Exception => e  
		CustomMailer.delay.send_error_report(e)
	end
end

desc "create monster job exchange"
task :create_monster_job_exchange => :environment do
  Monster.create(name: "Monster")
end

desc "create indeed job exchange"

task :create_indeed_job_exchange => :environment do
	Indeed.create(name: "Indeed", primary_token: "3945288973969687", primary_api_url: "http://api.indeed.com/ads/apisearch?")
end

desc "create google company"
task :create_google_company => :environment do
  Google.create(name: "Google")
end