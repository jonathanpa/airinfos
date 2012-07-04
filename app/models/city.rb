class City < ActiveRecord::Base
  attr_accessible :code, :name

  validates :code, presence: true
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false, scope: :code }

  has_many :measures, dependent: :destroy
end
