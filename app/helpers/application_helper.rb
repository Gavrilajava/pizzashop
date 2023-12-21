# frozen_string_literal: true

module ApplicationHelper
  def flash_alert_css(type)
    case type.to_sym
    when :error
      :danger
    else
      :success
    end
  end

  def format_errors(object)
    object.errors.messages.map do |key, values|
      "#{key.to_s.titleize}: #{values.join(', ')}"
    end.join(', <br>')
  end
end
