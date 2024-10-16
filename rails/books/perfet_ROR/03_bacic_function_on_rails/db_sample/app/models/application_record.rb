class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  connection_to database: {
    writing: :primary,
    reading: :primary_replica
  }
end
