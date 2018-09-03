class Question < ApplicationRecord

  validates :question_text, presence: true

  belongs_to :form
  has_many :answers

  
end
