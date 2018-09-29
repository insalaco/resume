class Skill < ApplicationRecord
  validate_presence_of :title, :percent
end
