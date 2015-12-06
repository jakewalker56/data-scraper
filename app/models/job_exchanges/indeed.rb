require 'xmlsimple'
class Indeed < JobExchange
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
			"jobkey" => "external_unique_identifier",
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
			"limit" => "10000", #return the first n listings
			"fromage" => "365", #search back 1 day
			"latlong" => "1", #return lat and long of job posting
			"v" => "2"
			#sort = ""
			#st= ""
			#jt= ""
			#start= ""
			#filter=""
			#co=us
			#chnl=""
			#userip="1.2.3.4"
			#useragent= "Mozilla/%2F4.0%28Firefox%29"
		}
		

		url = URI.escape(self.primary_api_url) + "?" + URI.escape(params.keys.collect{|k| k + "=" + params[k]}.join('&'))
		jobs = []
	    begin 
  		  puts "querying for " + url
	  	  xml_data = Net::HTTP.get_response(URI.parse(url)).body
		  job = {}

		  puts xml_data.inspect
		  data = XmlSimple.xml_in(xml_data)
		  #puts data.inspect
		  data['results'].each do |xml_jobs_wrapper|
		  	xml_jobs_wrapper["result"].each do |xml_job|
			  	Indeed.attribute_hash_map.keys.each do |k|
			  		if xml_job.has_key?(k)
			  			job[Indeed.attribute_hash_map[k]] = xml_job[k][0]
			  		end
			  	end
			  end
		  end
		  job["job_exchange_id"] = self.id
		  job["company_id"] = nil
		  jobs << job
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
