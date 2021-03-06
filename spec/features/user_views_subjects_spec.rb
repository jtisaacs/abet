require "rails_helper"

feature "User views list of subjects" do
  scenario "and only sees permitted subjects with assignments" do
    assignment = create(:assignment)
    department = assignment.subject_department
    permitted_subject = assignment.subject
    unpermitted_subject = create(:assignment).subject
    subject_without_assessment = create(:subject, department_number: department.number)
    user = user_with_admin_access_to(department)

    visit manage_results_subjects_path(as: user)

    expect(page).to have_content permitted_subject.number
    expect(page).not_to have_content unpermitted_subject.title
    expect(page).not_to have_content subject_without_assessment.title
  end
end
