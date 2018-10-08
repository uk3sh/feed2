class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable  

  belongs_to :account, inverse_of: :users 

  enum role: [:admin, :user]

  before_validation :create_account, on: :create  

  after_initialize :add_role

  private

  def create_account    
    self.account = Account.create!
  end

  def add_role
    if self.new_record?
      self.role ||= :admin
    end
  end
  
end
