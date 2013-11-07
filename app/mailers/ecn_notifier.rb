class EcnNotifier < ActionMailer::Base
  default from: "engineering_notices@wilfley.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ecn_notifier.closed.subject
  #
  #------------------------------------------------#
  #The following methods are for submit ecn emails #
  def submit_engineering(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Engineering").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail to: to, subject: 'ECN approval', template_name: 'submitted'
  end
  
  def submit_purchasing(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Purchasing").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail to: to, subject: 'ECN approval', template_name: 'submitted'
  end
  
  def submit_planning(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Planning").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail to: to, subject: 'ECN approval', template_name: 'submitted'
  end
  
  def submit_manufacturing(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Manufacturing").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail to: to, subject: 'ECN approval', template_name: 'submitted'
  end
    
  def submit_qantel(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Qantel").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail to: to, subject: 'ECN approval', template_name: 'submitted'
  end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ecn_notifier.submitted.subject
  #
  
  #------------------------------------------------#
  #The following methods are for closing ecn emails#
  def close_engineering(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Engineering").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
  def close_purchasing(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Purchasing").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
  def close_planning(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Planning").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
  def close_manufacturing(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Manufacturing").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
  def close_qantel(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Qantel").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
  def close_sales(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Sales").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
  def close_inventory(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Inventory").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
  def close_quality(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Quality").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
  def close_india(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "India").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
  def close_finance(ecn)
    @ecn = ecn
    @email = EmailList.where(department: "Finance").all
    to = []
    @email.each do |e|
      to.push e.email
    end
    mail(to: to, subject: 'ECN released', template_name: 'closed')
  end
  
end