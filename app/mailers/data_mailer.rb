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

end
