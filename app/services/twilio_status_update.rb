# service class to send activity status update
class TwilioStatusUpdate
  ACCOUNT_SID = Rails.application.credentials.twilio.account_sid
  AUTH_TOKEN = Rails.application.credentials.twilio.auth_token
  FROM = Rails.application.credentials.twilio.from
  WEBHOOK_URL = Rails.application.credentials.twilio.webhook_url

  attr_reader :from, :to, :body

  def initialize(activity:)
    @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    @activity = activity
    @from = FROM
    @body = "Hi, your order status has changed to #{@activity.status}"
    @to = @activity.phone
  end

  def self.call(**args)
    new(**args).send
  end

  def send
    return unless @activity.text_messages_enabled?

    begin
      message = @client.messages.create(from:, body:, to:, status_callback: WEBHOOK_URL)
      Rails.logger.info(message)
    rescue StandardError => e
      @error_message = e
      Rails.logger.error(e)
      @activity.update(text_messages_enabled: false)
    end
    @activity.text_messages.create(attributes(message))
  end

  def attributes(message)
    { sid: message&.sid,
      body: message&.body || body,
      from:,
      to:,
      status: message&.status || :error,
      error_message: message&.error_message || @error_message,
      error_code: message&.error_code }
  end
end
