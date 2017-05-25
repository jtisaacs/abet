class ManageAssessments::CoursesController < ApplicationController
  skip_after_action :verify_authorized
  after_action :verify_policy_scoped

  def index
    @courses = policy_scope(Course).includes(outcomes: :department)
  end

  def show
    @course = CourseCoverage.new(course)

    if @course.has_coverages?
      render :show
    else
      render :show_without_coverages
    end
  end

  def course
    policy_scope(Course).
      includes(outcomes: :outcome_coverages).
      includes(coverages: :subject).
      includes(outcome_coverages: [:assignment, :outcome]).
      find(params[:id])
  end
end
