require 'rails_helper'

RSpec.describe 'Webhooks::TextMessagesController', type: :request do
  describe 'POST /webhooks/text_messages' do
    context 'when the text message exists' do
      let!(:text_message) { FactoryBot.create(:text_message, sid: '12345') }

      it 'updates the status of the text message' do
        post webhooks_text_messages_path, params: { MessageSid: '12345', MessageStatus: 'delivered' }
        expect(response).to have_http_status(:ok)
        text_message.reload
        expect(text_message.status).to eq('delivered')
      end
    end

    context 'when the text message does not exist' do
      it 'returns a not found status' do
        post webhooks_text_messages_path, params: { MessageSid: 'nonexistent', MessageStatus: 'delivered' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
