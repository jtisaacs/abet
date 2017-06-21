module ManageAssignments
  class CoveragesController < ApplicationController
    def new
      @coverage = course.coverages.build
      @coverage.outcome_coverages.build(outcome_id: params[:outcome_id])
      authorize(@coverage)
    end

    def edit
      @coverage = Coverage.find(params[:id])
      @coverage.outcome_coverages.build
      authorize(@coverage)
    end

    def create
      @coverage = course.coverages.build(coverage_params)
      authorize(@coverage)

      if @coverage.save
        redirect_to manage_assignments_course_path(course)
      else
        render :new
      end
    end

    def update
      @coverage = Coverage.find(params[:id])
      authorize(@coverage)

      if @coverage.update_attributes(update_coverage_params)
        redirect_to manage_assignments_course_path(@coverage.course)
      else
        render :edit
      end
    end

    private

    def course
      @_course ||= policy_scope(Course).find(params[:course_id])
    end

    def coverage_params
      params.
        require(:coverage).
        permit(
          :subject_id,
          attachments_attributes: [:id, :file, :_destroy],
          outcome_coverages_attributes: [:outcome_id, :_destroy]
        )
    end

    def update_coverage_params
      params.
        require(:coverage).
        permit(outcome_coverages_attributes: [:outcome_id, :_destroy])
    end
  end
end