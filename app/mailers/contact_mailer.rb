class ContactMailer < ActionMailer::Base
  default :from => "#{I18n.t("mail.mail_from")} <do_not_reply@bead.koolbz.com.au>"

  mail_config = BeadsKoolbzComAu::Application.config.contact_mailer

  @@admin_email = mail_config[:admin_email]
  @@admin_email_locale = mail_config[:admin_email_locale]
  @@is_debug = mail_config[:is_debug]
  
  def send_new_post_to_admin(heading, post)
    to = @@admin_email
    I18n.with_locale(@@admin_email_locale) do
      subject = "#{I18n.t("mail.admin.subject")}" + " [#{I18n.t("mail.admin.new_post")}] " + OzjapaneseStyle.heading_name(heading) + " ID: " + post.id.to_s
      logger.info("email is besing sent to #{to}")
      @post = post
      @heading = heading
      mail(:to => to,
         :subject => subject)
    end
  end

  def send_contact_to_admin(contact)
    to = @@admin_email
    I18n.with_locale(@@admin_email_locale) do
      subject = "#{I18n.t("mail.admin.subject")}"
      @subject = "[#{contact.title(contact.contact_type)}]"
      subject += @subject
      logger.info("email is besing sent to #{to}")
      @contact = contact
      mail(:to => to,
         :subject => subject)
    end
  end

  def send_contact_to_flyer(contact)
    to = contact.email
    if @@is_debug
      to = @@admin_email
    end
    logger.info("email is besing sent to #{to}")
    subject = "#{I18n.t("mail.flyer.subject")} "
    @subject = "[#{contact.title(contact.contact_type)}]"
    #subject += @subject
    subject += t("mail.contact.confirmation_email")
    @contact = contact
    mail(:to => to,
         :subject => subject)
  end

end
