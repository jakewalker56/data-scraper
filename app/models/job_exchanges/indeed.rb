require 'xmlsimple'
class Indeed < JobExchange
	def self.max_results_per_query
		100
	end

	def self.max_results_per_api
		#Indeed API doesn't appear to let us page beyone page 40 (1000 results)
		1000
	end

	def self.salary_ranges
		[
			30000,
			50000,
			60000,
			70000,
			90000,
			110000,
			150000
		]
	end
	def self.attribute_hash_map
		{
			"jobtitle" => "title",
			"city" => "city",
			"company" => "company_name",
			"state" => "state",
			"source" => "source",
			"date" => "job_posted_time",
			"snippet" => "content",
			"url" => "url",
			"latitude" => "latitude",
			"longitude" => "longitude",
			"jobkey" => "external_unique_identifier"
		}
	end

	def get_jobs(search_term, location)
		#https://ads.indeed.com/jobroll/xmlfeed
		#http://api.indeed.com/ads/apisearch?publisher=3945288973969687&q=java&l=austin%2C+tx&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2

		params = {
			"publisher" => self.primary_token,
			"q" => search_term,
			"l" => location,
			"radius" => "25000", #distance from search location
			"limit" => Indeed.max_results_per_query, #return the first n listings
			"fromage" => "1", #search back 1 day
			"latlong" => "1", #return lat and long of job posting
			"v" => "2",
			"sort" => "date"
			#st= ""
			#jt= ""
			#start= ""
			#filter=""
			#co=us
			#chnl=""
			#userip="1.2.3.4"
			#useragent= "Mozilla/%2F4.0%28Firefox%29"
		}
		
		jobs = []

	    begin 
		    Indeed.salary_ranges.each do |salary|
		      params["salary"] = salary
		      start_index = 0
			  end_index = 0
			  total_results = Indeed.max_results_per_query 

			  while (end_index < total_results && start_index < Indeed.max_results_per_api)
		      	params["start"] = (end_index).to_s
				url = URI.escape(self.primary_api_url) + "?" + URI.escape(params.keys.collect{|k| k.to_s + "=" + params[k].to_s}.join('&'))
				
				puts "querying for " + url
				xml_data = Net::HTTP.get_response(URI.parse(url)).body
				job = {}

				#puts xml_data.inspect
				data = XmlSimple.xml_in(xml_data)

				total_results = data["totalresults"][0].to_i
				start_index = data["start"][0].to_i
				end_index = data["end"][0].to_i

				puts "total: " + total_results.to_s
				puts "start: " + start_index.to_s
				puts "end: " + end_index.to_s
				puts "retrieved " + (end_index - start_index + 1).to_s + " out of " + total_results.to_s + " results"

				#puts data.inspect
				data['results'].each do |xml_jobs_wrapper|
					xml_jobs_wrapper["result"].each do |xml_job|
						Indeed.attribute_hash_map.keys.each do |k|
							if xml_job.has_key?(k)
								job[Indeed.attribute_hash_map[k]] = xml_job[k][0]
							end
						end
						job["job_exchange_id"] = self.id
						job["company_id"] = nil
						job["salary_range_low"] = salary
						job["salary_range_high"] = salary
						jobs << job
					end	
				end
			  end
			end
	    rescue Exception => e 
	  	  puts "caught exception..."
	  	  puts e.inspect
	  	  puts e.backtrace
	    end

		puts "got result!"
		puts jobs.inspect
		return jobs
	end
end
