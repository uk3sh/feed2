class Question < ApplicationRecord

  serialize :option, Array

  validates :question_text, presence: true
  
  validate :check_option_array_for_nil



  belongs_to :form
  has_many :answers

  private

  def check_option_array_for_nil
    self.option.split(",").each do |x|
      if x.nil?
      errors.add(:option, "nil in option array")
      end
    end
  end
end
