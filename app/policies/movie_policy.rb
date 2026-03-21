class MoviePolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def edit?
    record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
