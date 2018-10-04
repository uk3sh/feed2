class Account < ApplicationRecord
  has_many :users, inverse_of: :account
  has_many :forms
  has_many :questions
  has_many :submissions
  has_many :answers

  validates :sender_id, presence: true, length: { is: 6 }, :on => :update
  
  
end
