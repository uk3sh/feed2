class Form < ApplicationRecord  

  validates :name, presence: true
  validates :sender_ID, presence: true, length: { is: 6 }
  validates :message, presence: true

  has_many :questions
  has_many :submissions 

  def generate_url(subdomain, domain)
    x = 'http://' + subdomain + '.' + domain + '/' + 'forms/' + self.id.to_s + '/' + 'submissions/new'
    self.url = x    
  end
  

  
end
