class Form < ApplicationRecord  

  validates :name, presence: true  
  validates :message, presence: true

  

  

  has_many :questions
  has_many :submissions 

  belongs_to :account

  def generate_url   

    x = 'https://app.feedyfy.com' + '/' + 'forms/' + self.id.to_s + '/' + 'submissions/new'
    self.url = x  
    
    chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map { |range| range.to_a }.flatten
    random = 6.times.map { chars.sample }.join    
    slug = random
    puts slug
    self.short_url = slug
     
  end
  
  
  
end
