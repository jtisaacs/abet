FactoryGirl.define do
  factory :course do
    sequence(:number) { |i| i.to_s }
    name { "Course #{number} Name" }
    department
  end

  factory :department do
    sequence :name do |n|
      "Department #{n} Name"
    end

    sequence :slug do |n|
      "D_#{n}XX"
    end
  end

  factory :direct_assessment do
    actual_percentage 82
    assignment_description "Integration"
    assignment_name "Problem Set 1"
    minimum_grade "7 points out of 10"
    outcome
    problem_description "Question 3, Integration by parts"
    semester "2015FA"
    subject_description "Calculus"
    subject_number "18.01"
    target_percentage 80
  end

  factory :other_assessment do
    actual_percentage 78
    assessment_description "Senior Thesis Completion"
    assessment_name "Percent of students who complete a senior thesis"
    outcome
    target_percentage 80
    type "OtherAssessment"
    year 2014
  end

  factory :outcome do
    sequence :name do |i|
      ("a".."z").to_a[i - 1]
    end

    description { "description for custom #{name}" }
    course
  end

  factory :participation do
    actual_percentage 78
    assessment_description "Undergraduation Research Project"
    assessment_name "UROP"
    outcome
    target_percentage 80
    type "Participation"
    year 2014
  end

  factory :standard_outcome do
    sequence :name do |i|
      ("a".."z").to_a[i - 1]
    end

    description { "description for default #{name}" }
  end

  factory :survey do
    actual_percentage 78
    assessment_description "Biennial survey administered to graduating seniors"
    assessment_name "Senior Survey"
    minimum_category "Somewhat satisfied"
    outcome
    survey_question "How satisfied are you with advising in your major?"
    target_percentage 80
    type "Survey"
    year 2014
  end

  factory :user do
    sequence :email do |n|
      "user-#{n}@example.com"
    end
  end
end