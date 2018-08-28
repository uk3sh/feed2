class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_account, :create_tenant

  private

  def create_account
    account = Account.new(:email => email, :subdomain => subdomain)
    account.save
  end

  def create_tenant
    Apartment::Tenant.create(subdomain)
    Apartment::Tenant.switch!(subdomain)
  end
end
