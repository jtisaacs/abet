require "rails_helper"

describe Subject do
  describe ".sorted_by_number" do
    it "orders by the number before the dot" do
      subject_ten = create(:subject, number: "10.036")
      subject_two = create(:subject, number: "2.51")

      expect(Subject.sorted_by_number).to eq [subject_two, subject_ten]
    end

    it "sorts course numbers with letter suffixes alphabetically" do
      subject_xyz = create(:subject, number: "1.XYZ")
      subject_abc = create(:subject, number: "1.ABC")

      expect(Subject.sorted_by_number).to eq [subject_abc, subject_xyz]
    end
  end

  describe ".with_assessments" do
    it "returns subjects with associated unarchived assessments" do
      subject_ = create(:assessment).subject
      create(:assessment, archived: true)
      create(:subject)

      expect(Subject.with_assessments).to eq [subject_]
    end
  end

  describe "#to_s" do
    it "combines number and title" do
      the_subject = Subject.new(number: 1.234, title: "Test")

      expect(the_subject.to_s).to eq "1.234 - Test"
    end
  end

  describe "#department" do
    it "returns the subject's department" do
      department = create(:department)
      the_subject = create(:subject, department_number: department.number)

      expect(the_subject.department).to eq department
    end
  end

  describe "#assessments" do
    it "includes only unarchived assessments" do
      subject_ = create(:subject)
      unarchived_assessment = create(:assessment, subject: subject_)
      create(:assessment, subject: subject_, archived: true)

      expect(subject_.assessments).to eq [unarchived_assessment]
    end
  end
end
