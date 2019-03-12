# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'foosball@boost.com'
  layout 'mailer'
end
