class Project < ActiveRecord::Base
  belongs_to :owner, class_name: User

  validates :name, length: { in: 4..30 }
  validates :owner, presence: true

end
