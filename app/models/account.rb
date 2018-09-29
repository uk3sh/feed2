class Account < ApplicationRecord
  has_many :users, inverse_of: :account
  has_many :forms
  has_many :questions
  has_many :submissions
  
  
end
