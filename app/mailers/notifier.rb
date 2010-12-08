class Notifier < ActionMailer::Base
  default :from => "no-reply@isotope11.com"

  def daily(client)
    @client = client
    @hours = WorkUnit.for_client(@client).sum(:hours)
    @uninvoiced_hours = WorkUnit.for_client(@client).not_invoiced.sum(:hours)
    mail(:to => Contact.for_client(client).receives_email.map(&:email_address),
         :bcc => ["bcc@isotope11.com"],
         :subject => 'Daily Hours Summary') {|f| f.text}
  end
end
