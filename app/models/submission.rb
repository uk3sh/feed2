class Submission < ApplicationRecord

  has_many :answers, inverse_of: :submission
  
  belongs_to :form

  accepts_nested_attributes_for :answers
  
end
