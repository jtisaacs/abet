class Coverage < ApplicationRecord
  belongs_to :course
  belongs_to :subject, required: true

  has_one :department, through: :course
  has_many :outcome_coverages, -> { where archived: false }
  has_many :outcomes, through: :outcome_coverages
  has_many :attachments, as: :attachable

  delegate :department, to: :course, prefix: true
  delegate :department, to: :subject, prefix: true

  accepts_nested_attributes_for :outcome_coverages,
    reject_if: :all_blank

  accepts_nested_attributes_for :attachments,
    allow_destroy: true,
    reject_if: :all_blank

  validates :subject_id,
    presence: true,
    uniqueness: { scope: [:course_id, :archived], unless: :archived }
  validate :must_have_outcomes

  def attachment
    attachments.first
  end

  private

  def must_have_outcomes
    if outcome_coverages.empty? || all_outcome_coverages_marked_for_destruction?
      outcome_coverage = outcome_coverages.build
      outcome_coverage.errors.add(:outcome_id, :blank)
      errors.add(:base, :outcomes_required)
    end
  end

  def all_outcome_coverages_marked_for_destruction?
    outcome_coverages.all? do |outcome_coverage|
      outcome_coverage.marked_for_destruction?
    end
  end
end
