class JobPostingsController < ApplicationController
	def download
		#This currently times out because we're processing waaaay too much data.  An email won't work either,
		#because the 20MB limit on file size imposed by (SMTP?  Google?  Most providers?)

		#long term solution is to either generate the file and throw it up on S3 for later download, or connect directly
		#to the database in R to do the analysis
		
		#DataMailer.send_job_posting_report(current_user.email)
	    request.format = :xlsx
	    respond_to do |format|
	      	format.xlsx { 
	       		response.headers['Content-Disposition'] = 'attachment; filename=job_postings.xlsx'
	      	}
	    	#redirect_to :back, notice: "Generating file in background.  You will recieve a download link in an email when the file is complete"
	    end
	end
end
