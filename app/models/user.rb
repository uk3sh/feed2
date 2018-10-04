class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable  

  belongs_to :account, inverse_of: :users

  before_validation :create_account, on: :create

  private

  def create_account    
    self.account = Account.create!
  end
  
end
