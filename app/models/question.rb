class Question < ApplicationRecord

  belongs_to :form
  has_many :answers

  
end
