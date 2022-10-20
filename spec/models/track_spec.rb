require 'rails_helper'

RSpec.describe Track, type: :model do
  subject { track }
  let(:track) { Track.new }

  describe :validations do

    before do
      track.report = Report.new
      track.external_id = 'T1'
    end

    it "can be valid" do
      expect(subject).to be_valid
    end

    it "flags report as required" do
      track.report = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "Report must exist"
    end

    it "flags external_id as required" do
      track.external_id = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "External can't be blank"
    end
  end
end