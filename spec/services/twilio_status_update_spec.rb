RSpec.describe TwilioStatusUpdate do
  describe '.call' do
    let(:activity) { FactoryBot.create(:order, text_messages_enabled: true) }
    let(:logger) { Logger.new("#{Rails.root}/log/test_async.log") }
    let(:twilio_response) do
      double('Twilio Message', sid: '12345', body: 'Message sent', status: 'sent', error_message: nil, error_code: nil)
    end
    let(:mock_twilio) { double(Twilio::REST::Client) }
    before do
      allow(Twilio::REST::Client).to receive(:new).and_return(mock_twilio)
      allow(mock_twilio).to receive_message_chain(:messages, :create).and_return(twilio_response)
      allow(logger).to receive(:info)
      allow(logger).to receive(:error)
    end

    context 'when text messages are enabled' do
      it 'logs the message' do
        described_class.call(activity:, logger:)
        expect(logger).to have_received(:info).with(twilio_response)
      end

      it 'creates a text message record' do
        expect { described_class.call(activity:, logger:) }.to change {
                                                                 activity.text_messages.count
                                                               }.by(1)
      end
    end

    context 'when there is an error' do
      let(:twilio_response) { nil }
      let(:error) { StandardError.new('some error') }

      before do
        allow(Twilio::REST::Client).to receive_message_chain(:new, :messages, :create).and_raise(error)
      end

      it 'logs the error' do
        described_class.call(activity:, logger:)
        expect(logger).to have_received(:error).with(error)
      end

      it 'updates text_messages_enabled to false' do
        described_class.call(activity:, logger:)
        activity.reload
        expect(activity.text_messages_enabled).to be_falsey
      end

      it 'creates a text message record with error status' do
        expect { described_class.call(activity:, logger:) }.to change {
                                                                 activity.text_messages.count
                                                               }.by(1)
        expect(activity.text_messages.last.status).to eq('error')
      end
    end
  end
end
