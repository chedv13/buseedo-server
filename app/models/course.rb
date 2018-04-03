class Course < ApplicationRecord
  # TODO: В будущем отрефакторить
  has_attached_file :cover,
                    default_url: '/images/courses/covers/:style/missing.png',
                    styles: { common_60: '60x60>' },
                    url: '/system/courses/covers/:id/:style/:basename',
                    use_timestamp: false
  validates_attachment_content_type :cover,
                                    content_type: %r{^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$},
                                    message: 'file type is not allowed (only jpeg/png/gif images)'
  has_attached_file :background_image,
                    default_url: '/images/courses/background_images/:style/missing.png',
                    styles: { ios_max: '414x414#' },
                    url: '/system/courses/background_images/:id/:style/:basename',
                    use_timestamp: false
  validates_attachment_content_type :background_image,
                                    content_type: %r{^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$},
                                    message: 'file type is not allowed (only jpeg/png/gif images)'

  has_many :course_users, dependent: :destroy
  has_many :days, dependent: :destroy
  has_many :tasks, through: :days
  has_many :course_teachers
  has_many :teachers, through: :course_teachers
  has_many :users, through: :course_users

  before_save :set_published_at_and_unpublished_at

  scope :published, -> { where(is_published: true) }

  def self.cover_styles_hash
    hash = {}
    Course.new.cover.styles.values.each { |s| hash[s.name.to_s] = s.geometry }
    hash
  end

  private

  def set_published_at_and_unpublished_at
    self.published_at = (is_published ? Time.zone.now : nil)
    self.unpublished_at = (is_published ? nil : Time.zone.now) if id
  end
end