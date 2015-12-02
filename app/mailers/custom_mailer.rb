class CustomMailer < ActionMailer::Base
  default from: "lumii@lumiihealth.com"

  def self.bccs
    ENV["BCC_MAILS"]
  end

  def self.email
    ENV["DEFAULT_MAIL"]
  end

  def send_error_report(error)
    @error = error
    mail to: CustomMailer.email, subject: 'Data-Scraper Error Report', bcc: CustomMailer.bccs
  end

end