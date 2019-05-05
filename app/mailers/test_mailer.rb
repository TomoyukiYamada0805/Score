class TestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.authenticate.subject
  #
  def authenticate
    @greeting = "Hi"

    mail to: "tomoyuki.yamada.0805@gmail.com"
  end
end
