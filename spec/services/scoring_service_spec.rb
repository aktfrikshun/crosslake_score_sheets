require 'rails_helper'

RSpec.describe ScoringService, type: :service do
  let(:subject) { ScoringService.new(scoring_sheet) }
  let(:scoring_sheet) { ScoringSheet.create(name: 'TestCompany') }
  let(:report) { Report.create(scoring_sheet: scoring_sheet, external_id: 'R1') }
  let(:track1) { Track.create(report: report, external_id: 'T1') }
  let(:track2) { Track.create(report: report, external_id: 'T2') }

  describe 'import' do

    it "can compute scores" do
      Indicator.create(track: track1, external_id: 'I1', weight: 1, score: 100)
      Indicator.create(track: track1, external_id: 'I2', weight: 5, score: 100)
      Indicator.create(track: track1, external_id: 'I3', weight: 3, score: 50)
      Indicator.create(track: track2, external_id: 'I4', weight: 1, score: 90)
      expect(scoring_sheet.indicators.count).to eq(4)          
      subject.run
      expected_track1_score = (((1 * 100) + (5 * 100) + (3 * 50)) / 9).round(2)
      expect(scoring_sheet.tracks.find_by(external_id: 'T1').score).to eq(expected_track1_score)
      expected_track2_score = (1 * 90).round(2)      
      expect(scoring_sheet.tracks.find_by(external_id: 'T2').score).to eq(expected_track2_score)
      expected_report_score = ((expected_track1_score + expected_track2_score) / 2.0).round(2)
      expect(scoring_sheet.reports.find_by(external_id: 'R1').score).to eq(expected_report_score)      
    end
  end
end