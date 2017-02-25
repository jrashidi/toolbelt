# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete


  config.secret_key = '3f8531b66f6fa7a172e3ccccffbadcc60f107605ce7fb7c12f5012bcf7779a55143251da58120f61226208e9d908525199a9141770fea81859c78c50fffba555'

  require 'omniauth-facebook'
  config.omniauth :facebook, '262935874139930', '21ccc40ee2a0fb0cd31704170879ceff', scope: 'email', info_fields: 'email, first_name, last_name'
end
