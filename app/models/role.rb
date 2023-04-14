class Role < ApplicationRecord
  
  belongs_to :resource

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify
end
