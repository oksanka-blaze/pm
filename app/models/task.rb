class Task < ActiveRecord::Base
  belongs_to :assignee, class_name: User
  belongs_to :project

  validates_presence_of :name, :description

  delegate :email, to: :assignee, prefix: true, allow_nil: true

  alias_attribute :title, :name
end
