class Submission < ApplicationRecord

  has_many :answers, inverse_of: :submission
  
  belongs_to :form

  accepts_nested_attributes_for :answers
  
  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }
  
  scope :today, lambda { where('DATE(created_at) = ?', Date.today)}

end
