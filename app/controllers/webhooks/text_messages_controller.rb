module Webhooks
  class TextMessagesController < ApplicationController
    def update
      text_message = TextMessage.find_by(sid: params[:MessageSid])
      return render status: :not_found, json: { status: :not_found } unless text_message

      text_message.update(status: params[:MessageStatus])
      render status: :ok, json: { status: :ok }
    end
  end
end
