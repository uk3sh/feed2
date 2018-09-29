class Answer < ApplicationRecord  

  belongs_to :question
  belongs_to :submission, inverse_of: :answers
  
  
end
