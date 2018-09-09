class Question < ApplicationRecord

  serialize :option, Array

  validates :question_text, presence: true

  belongs_to :form
  has_many :answers

  
end
