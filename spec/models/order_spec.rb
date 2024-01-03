require 'rails_helper'
RSpec.describe Order, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      order = FactoryBot.build(:order)
      expect(order).to be_valid
    end

    it 'is not valid without an item' do
      order = FactoryBot.build(:order, item: nil)
      expect(order).not_to be_valid
    end

    it 'is not valid without a name' do
      order = FactoryBot.build(:order, name: nil)
      expect(order).not_to be_valid
    end

    context 'when text messages are enabled' do
      it 'is not valid with an invalid phone number' do
        order = FactoryBot.build(:order, phone: '123', text_messages_enabled: true)
        expect(order).not_to be_valid
      end

      it 'is valid with a valid US phone number' do
        order = FactoryBot.build(:order, phone: '(123)456-7890', text_messages_enabled: true)
        expect(order).to be_valid
      end
    end
  end

  describe 'callbacks' do
    it 'calls notify after create' do
      order = FactoryBot.build(:order)
      expect(order).to receive(:notify)
      order.save
    end

    it 'calls notify after save if status changed' do
      order = FactoryBot.create(:order)
      expect(order).to receive(:notify)
      order.update(status: :processing)
    end
  end
end
