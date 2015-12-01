class JobPostingsController < ApplicationController
	def download
	    request.format = :xlsx
	    respond_to do |format|
	      format.xlsx { 
	       response.headers['Content-Disposition'] = 'attachment; filename=job_postings.xlsx'
	      }
	    end
	end
end
