class Report < ApplicationRecord
  has_many :tracks, dependent: :destroy
  belongs_to :scoring_sheet
  validates_presence_of :external_id
  validates :score, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }   
end
