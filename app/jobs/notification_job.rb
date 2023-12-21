# job to run all notificatios
class NotificationJob < ApplicationJob
  queue_as :default

  def perform(**args)
    activity = args[:activity]
    logger.info "NotificationJob started for #{activity}"
    TwilioStatusUpdate.call(activity:, logger:)
    logger.info "NotificationJob done for #{activity}"
  end
end
