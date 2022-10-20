class ScoringSheet < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_many :tracks, through: :reports
  has_many :indicators, through: :tracks
end
