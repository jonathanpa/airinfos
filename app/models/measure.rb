class Measure < ActiveRecord::Base
  attr_accessible :date, :pm25

  validates :date, presence: true,
                   uniqueness: { scope: :city_id }

  validates :pm25, presence: true

  belongs_to :city
end
