class UserTask < ApplicationRecord
  SYSTEM_DATETIME_FIELDS = %i[finished_at started_at].freeze

  belongs_to :day_task
  belongs_to :user
  has_many :intervals, class_name: 'UserTaskInterval', dependent: :destroy, inverse_of: :user_task

  validates :day_task_id, uniqueness: { scope: :user_id }
  validate :finished_at_should_be_more_than_started_at, if: -> { started_at }

  after_create :create_default_interval

  UserTask::SYSTEM_DATETIME_FIELDS.each do |timestamp_field_name|
    define_method("#{timestamp_field_name}_seconds_since_1970") do
      timestamp_field = send(timestamp_field_name)
      timestamp_field ? timestamp_field.strftime('%s').to_i : nil
    end
  end

  private

  def create_default_interval
    intervals.create
  end

  def finished_at_should_be_more_than_started_at
    errors.add(:finished_at, 'should be more than started_at') if started_at > finished_at
  end
end
