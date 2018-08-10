# Load the Rails application.
require_relative 'application'

envi = File.join(Rails.root, 'config', 'envi.rb')
load(envi) if File.exists?(envi)

# Initialize the Rails application.
Rails.application.initialize!
