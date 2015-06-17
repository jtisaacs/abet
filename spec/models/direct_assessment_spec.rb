require "rails_helper"

describe DirectAssessment do
  describe "validations" do
    it { should validate_presence_of(:subject) }
  end

  describe "#department" do
    it "should return the department of the first associated outcome" do
      assessment = create(:direct_assessment)
      outcome = assessment.outcomes.first

      expect(assessment.department).to eq outcome.department
    end
  end
end
