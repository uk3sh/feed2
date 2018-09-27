class FormPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:account).where(account_id: user.account_id)
    end
  end  
end