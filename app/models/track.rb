class Track < ApplicationRecord
  has_many :indicators, dependent: :destroy
  belongs_to :report
  validates_presence_of :external_id
  validates :score, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
end
