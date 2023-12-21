# Message history
class TextMessage < ApplicationRecord
  belongs_to :activity, polymorphic: true
end
