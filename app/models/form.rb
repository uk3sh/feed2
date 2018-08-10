class Form < ApplicationRecord

  has_many :questions
  has_many :submissions

  after_save :generate_url

  private

  def generate_url
    x = ENV['ROOT_URL'] + '/' + 'forms/' + self.id.to_s + '/' + 'submissions/new'
    self.url = x
    self.update_column(:url, x)
  end
  

  
end
