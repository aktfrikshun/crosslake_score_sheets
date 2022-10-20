require 'rails_helper'

RSpec.describe ImportService, type: :service do
  subject { ImportService.new(scoring_sheet, score_file) }
  let(:scoring_sheet) { ScoringSheet.create(name: 'TestCompany') }
  let(:score_file) { Rails.root.join('spec','test_files','score_sample.txt').to_s }

  describe 'import' do

    it "can import a valid file" do
      subject.run
      expect(scoring_sheet.reports.count).to eq(2)
      expect(scoring_sheet.tracks.count).to eq(6)
      expect(scoring_sheet.indicators.count).to eq(17)
    end

    it "can maintain object ordering" do
      subject.run
      expect(scoring_sheet.reports.find_by(external_id: 'R1').id < scoring_sheet.reports.find_by(external_id: 'R2').id)
      expect(scoring_sheet.tracks.find_by(external_id: 'T1').id < scoring_sheet.tracks.find_by(external_id: 'T2').id)
    end

    it "throws an error if the input file cannot be found" do
      expect { ImportService.new(scoring_sheet, "/someboguspath/file.txt").run }.to raise_error(/No such file or directory/)
    end
  end
end