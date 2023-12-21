# Stores customer orders
class Order < ApplicationRecord
  validates :item, presence: true
  validates :name, presence: true
  validates :phone,
            format: { with: /\A\+?1?-?([0-9]\s?|[0-9]?)([(][0-9]{3}[)]\s?|[0-9]{3}[-\s.]?)[0-9]{3}[-\s.]?[0-9]{4,6}\z/,
                      message: 'must be a US phone number' }, if: :text_messages_enabled?

  after_create :notify
  after_save :notify, if: :saved_change_to_status?

  enum :item, {
    cheese: 0,
    pepperoni: 1,
    hawaian: 2
  }

  enum :status, {
    created: 0,
    processing: 1,
    ready: 2,
    canceled: 99
  }

  def notify
    # TODO: implement notofications
  end
end
