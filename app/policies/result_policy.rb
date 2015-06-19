class ResultPolicy < ApplicationPolicy
  def create?
    user.manage_results?(record.department)
  end

  def update?
    create?
  end
end
