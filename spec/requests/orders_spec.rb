require 'rails_helper'

RSpec.describe 'OrdersController', type: :request do
  let(:order) { FactoryBot.create(:order) }

  describe 'GET /orders' do
    it 'returns http success' do
      get orders_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /orders/new' do
    it 'returns http success' do
      get new_order_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /orders' do
    context 'with valid attributes' do
      it 'creates a new order and redirects to the orders path' do
        post orders_path, params: { order: { name: 'John Doe', phone: '1234567890', item: 'cheese' } }
        expect(response).to redirect_to(orders_path)
        follow_redirect!
        expect(response.body).to include('Your order is created')
      end
    end

    context 'with invalid attributes' do
      it 'renders the new template' do
        post orders_path, params: { order: { name: '', phone: '1234567890', item: 'cheese' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /orders/:id/edit' do
    it 'returns http success' do
      get edit_order_path(order)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /orders/:id' do
    it 'updates the order and redirects to the orders path' do
      patch order_path(order), params: { order: { name: 'Updated Name' } }
      expect(response).to redirect_to(orders_path)
      follow_redirect!
      expect(response.body).to include('The order is updated')
    end
  end

  describe 'DELETE /orders/:id' do
    it 'deletes the order and redirects to the orders path' do
      another_order = FactoryBot.create(:order)
      expect { delete order_path(another_order) }.to change(Order, :count).by(-1)
      expect(response).to redirect_to(orders_path)
      follow_redirect!
      expect(response.body).to include('The order is deleted')
    end
  end
end
