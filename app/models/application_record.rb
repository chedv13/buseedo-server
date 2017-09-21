class ApplicationRecord < ActiveRecord::Base
  include JsonQuery::Builder

  self.abstract_class = true
end
