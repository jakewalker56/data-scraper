class Indeed < JobExchange
	def get_jobs(search_term)
		#https://ads.indeed.com/jobroll/xmlfeed
		#http://api.indeed.com/ads/apisearch?publisher=3945288973969687&q=java&l=austin%2C+tx&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2
		params = {}
		params["publisher"] = self.primary_token
		params["q"] = search_term
		params["l"] = location
		#sort = ""
		params["radius"]= "25" #distance from search location
		#st= ""
		#jt= ""
		#start= ""
		params["limit"]="1000" #return the first 1000 listings
		params["fromage"]="1" #search back 1 day
		#filter=""
		params["latlong"] = "1" #return lat and long of job posting
		#co=us
		#chnl=""
		#userip="1.2.3.4"
		#useragent= "Mozilla/%2F4.0%28Firefox%29"
		params["v"] = "2"
		url = self.primary_api_url + "?" + params.keys.collect{|k| k + "=" + params[k]}.join('&')
		puts url
	end
end
