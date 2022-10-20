require 'rails_helper'

RSpec.describe ScoringSheet, type: :model do
  subject { scoring_sheet }
  let(:scoring_sheet) { ScoringSheet.new }

  describe :validations do
    it "has no required fields" do
      expect(subject).to be_valid
    end
  end
end