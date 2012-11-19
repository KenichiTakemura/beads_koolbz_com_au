module MessageHelper
  def form_error_messages!(resource)
    if resource.errors.empty?
      return ""
    end

    messages = resource.errors.full_messages.map { |msg|
      show_alert(msg)
    }.join

    messages.gsub!('Email',I18n.t("contact.email"))
    messages.gsub!('User name',I18n.t("contact.user_name"))
    messages.gsub!('Phone',I18n.t("contact.phone"))
    messages.gsub!('Body',I18n.t("contact.content"))
    messages.gsub!('Subject',I18n.t("contact.subject"))

    html = <<-HTML
      #{messages}
    HTML

    html.html_safe
  end
end