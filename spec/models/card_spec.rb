require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @card = FactoryBot.build(:card)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'card_tokenとcustomer_tokenが存在すれば登録できる' do
        expect(@card).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'card_tokenが空では登録できない' do
        @card.card_token = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "カード番号を入力してください"
      end
      it 'customer_tokenが空では登録できない' do
        @card.customer_token = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "Customer tokenを入力してください"
      end
    end
  end
end