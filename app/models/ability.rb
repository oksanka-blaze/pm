class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :create], Project
    can [:update, :destroy], Project, owner: user
  end
end
