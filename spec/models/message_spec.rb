require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe '#create' do
    context 'messageが保存できるとき' do
      it 'contentとimageが存在していれば保存できること' do
        expect(@message).to be_valid
      end
      it 'contentが空でも保存できること' do
        @message.content = ''
        expect(@message).to be_valid
      end
      it 'imageが空でも保存できること' do
        @message.image = nil
        expect(@message).to be_valid
      end
    end
    
    context 'messageが保存できないとき' do
      it 'contentとimageが空では保存できないこと' do
        @message.content = ''
        @message.image = nil
        @message.valid?
        expect(@message.errors.full_messages).to include "Contentを入力してください"
      end
      it 'troomが紐付いていないと保存できないこと' do
        @message.troom = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Troomを入力してください')
      end
      it 'userが紐付いていないと保存できないこと' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
