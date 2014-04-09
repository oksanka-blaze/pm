class Project < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many   :tasks

  validates :name, length: { in: 4..30 }
  validates :owner, presence: true

  accepts_nested_attributes_for :tasks, allow_destroy: true

end
