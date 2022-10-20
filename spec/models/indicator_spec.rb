require 'rails_helper'

RSpec.describe Indicator, type: :model do
  subject { indicator }
  let(:indicator) { Indicator.new }

  describe :validations do

    before do
      indicator.track = Track.new
      indicator.external_id = 'T1'
      indicator.weight = 5
      indicator.score = 99      
    end

    it "can be valid" do
      expect(subject).to be_valid
    end

    it "flags task as required" do
      indicator.track = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "Track must exist"
    end

    it "flags external_id as required" do
      indicator.external_id = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "External can't be blank"
    end

    it "flags invalid scores" do
      indicator.score = -1
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "Score must be greater than or equal to 1"      
      indicator.score = 101
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "Score must be less than or equal to 100"       
    end

    it "flags invalid weights" do
      indicator.weight = 0
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "Weight must be greater than or equal to 1" 
      indicator.weight = 6
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include "Weight must be less than or equal to 5"            
    end
  end
end