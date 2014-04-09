class Task < ActiveRecord::Base
  belongs_to :assignee, class_name: User
  belongs_to :project

  validates_presence_of :name, :description

end
