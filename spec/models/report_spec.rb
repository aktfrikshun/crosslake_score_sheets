require 'rails_helper'

RSpec.describe Report, type: :model do
  subject { report }
  let(:report) { Report.new }

  describe :validations do

    before do
      report.scoring_sheet = ScoringSheet.new
      report.external_id = 'R1'
    end

    it "can be valid" do
      expect(subject).to be_valid
    end

    it "flags scoring_sheet as required" do
      report.scoring_sheet = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "Scoring sheet must exist"
    end

    it "flags external_id as required" do
      report.external_id = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "External can't be blank"
    end
  end
end