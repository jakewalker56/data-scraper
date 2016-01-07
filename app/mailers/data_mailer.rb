class DataMailer < ApplicationMailer
  default from: "datascraper.heroku@gmail.com"

  def self.bccs
    ENV["BCC_MAILS"]
  end

  def self.email
    ENV["DEFAULT_MAIL"]
  end

  def send_error_report(error)
    puts "sending error report..."
    @error = error
    puts error.inspect
    mail to: DataMailer.email, subject: 'Data-Scraper Error Report', bcc: DataMailer.bccs
    puts "successfully mailed!"
  end

  def send_job_posting_report(email)
    #TODO: could try to fix this, but not really much of a point.  Anything too big to dynamically generate is
    #probably too big to email.

    ##It would be nice to fix for future reuse purposes though.

    #first generate the file
    #file = open(UniversalEmployeeForm.new(electronic_signature.plan_period, @employee, true).export, type: 'application/xlsx').read 

    #then save it to S3
    

    #then send a link to the file
    #attachments["medical_sbc_" + i.to_s + ext] = open(document.content.url).read
  end

end
