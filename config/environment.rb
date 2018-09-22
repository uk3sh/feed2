# Load the Rails application.
require_relative 'application'

envi = File.join(Rails.root, 'config', 'envi.rb')
load(envi) if File.exists?(envi)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SG_USER_NAME'],
  :password => ENV['SG_PASSWORD'],
  :domain => ENV['SG_DOMAIN'],
  :address => ENV['SG_ADDRESS'],
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
