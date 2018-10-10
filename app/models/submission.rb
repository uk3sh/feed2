class Submission < ApplicationRecord

  has_many :answers, inverse_of: :submission  
  belongs_to :form
  belongs_to :account

  accepts_nested_attributes_for :answers

  after_commit :send_email, :on => :create
  
  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }  
  scope :today, lambda { where('DATE(created_at) = ?', Date.today)}

  private

  def send_email    
    email_id = User.find_by(account_id: self.account_id, role: "admin").email  
    SubmissionMailer.submission_notification(email_id).deliver
  end

end
