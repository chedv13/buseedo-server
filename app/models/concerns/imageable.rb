require 'active_support/concern'

module Imageable
  extend ActiveSupport::Concern

  included do
    def full_attachment_url(base_url, attachment_field, style = nil)
      attachment = self.send(attachment_field)
      "#{base_url}#{style ? attachment.url(style) : attachment.url}"
    end
  end
end