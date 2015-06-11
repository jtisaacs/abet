FactoryGirl.define do
  sequence(:label) { |n| ("a".."zzz").to_a[n - 1] }
  sequence(:name) { |n| "The #{n.ordinalize} Name" }
  sequence(:number) { |n| n.to_s }

  factory :course do
    name
    number
    department

    trait :with_unaligned_outcome do
      has_custom_outcomes true

      after(:create) do |course|
        create(:standard_outcome)
        create(:outcome, course: course)
      end
    end
  end

  factory :department do
    sequence :slug do |n|
      "D_#{n}XX"
    end

    name
    number
  end

  factory :direct_assessment do
    description "Integration"
    minimum_requirement "7 points out of 10"
    name "Problem Set 1"
    outcome
    problem_description "Question 3, Integration by parts"
    target_percentage 80

    after(:build) do |assessment|
      unless assessment.subject.present?
        assessment.subject = build(
          :subject,
          department_number: assessment.department.number
        )
      end
    end
  end

  factory :other_assessment do
    description "Senior Thesis Completion"
    name "Percent of students who complete a senior thesis"
    outcome
    target_percentage 80
    type "OtherAssessment"
  end

  factory :outcome do
    name { generate(:label) }
    description { "description for custom #{name}" }
    course
  end

  factory :outcome_alignment do
    alignment_level "Moderate alignment"
    outcome
    standard_outcome
  end

  factory :participation do
    description "Undergraduation Research Project"
    name "UROP"
    outcome
    target_percentage 80
    type "Participation"
  end

  factory :standard_outcome do
    name { generate(:label) }
    description { "description for default #{name}" }
  end

  factory :subject do
    department_number { generate(:number) }
    number
    title { generate(:name) }
  end

  factory :survey do
    description "Biennial survey administered to graduating seniors"
    minimum_requirement "Somewhat satisfied"
    name "Senior Survey"
    outcome
    survey_question "How satisfied are you with advising in your major?"
    target_percentage 80
    type "Survey"
  end

  factory :user do
    sequence :email do |n|
      "user-#{n}@example.com"
    end
  end
end
