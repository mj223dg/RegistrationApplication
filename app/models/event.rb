class Event < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :creator
  belongs_to :position

  validates :name, presence: true
  validates :description, presence: true


end
