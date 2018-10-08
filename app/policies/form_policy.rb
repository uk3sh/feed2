class FormPolicy < ApplicationPolicy

  def new?
    user.role == 'admin'
  end

  def edit?
    user.role == 'admin'
  end

  class Scope < Scope
    def resolve      
      scope.joins(:account).where(account_id: user.account_id)
    end
  end  
end