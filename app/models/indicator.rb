class Indicator < ApplicationRecord
  belongs_to :track
  validates_presence_of :external_id
  validates :score, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100 }
  validates :weight, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5 }
end
