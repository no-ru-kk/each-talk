require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @room = FactoryBot.build(:room)
  end

  describe 'room出品機能' do
    context 'room出品できるとき' do
      it 'nameとrexplain,dayotw_id,rtime_id,htime_id,mtime_id,price,imageが存在すれば出品できる' do
        expect(@room).to be_valid
      end
      it 'imageが空でも出品できる' do
        @room.image = nil
        expect(@room).to be_valid
      end
      it 'priceが500円以上10000以下であれば出品できる' do
        @room.price = 500
        expect(@room).to be_valid
      end
    end
    context 'room出品できないとき' do
      it 'nameが空では出品できない' do
        @room.name = ''
        @room.valid?
        expect(@room.errors.full_messages).to include "Roomの名前を入力してください"
      end
      it 'nameが17文字以上では出品できない' do
        @room.name = 'あああああああああああああああああ'
        @room.valid?
        expect(@room.errors.full_messages).to include "Roomの名前は16文字以内で入力してください"
      end
      it 'rexplainが空では出品できない' do
        @room.rexplain = ''
        @room.valid?
        expect(@room.errors.full_messages).to include "Roomの紹介を入力してください"
      end
      it 'rexplainが300文字以上では出品できない' do
        @room.rexplain = 'あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ'
        @room.valid?
        expect(@room.errors.full_messages).to include "Roomの紹介は300文字以内で入力してください"
      end
      it 'dayotw_idが「---」では出品できない' do
        @room.dayotw_id = 1
        @room.valid?
        expect(@room.errors.full_messages).to include "トーク可能日は「---」以外を選択してください"
      end
      it 'rtime_idが「---」では出品できない' do
        @room.rtime_id = 1
        @room.valid?
        expect(@room.errors.full_messages).to include "トーク時間は「---」以外を選択してください"
      end
      it 'htime_idが「---」では出品できない' do
        @room.htime_id = 1
        @room.valid?
        expect(@room.errors.full_messages).to include "時間は「---」以外を選択してください"
      end
      it 'mtime_idが「---」では出品できない' do
        @room.mtime_id = 1
        @room.valid?
        expect(@room.errors.full_messages).to include "分は「---」以外を選択してください"
      end
      it 'priceが空では出品できない' do
        @room.price = ''
        @room.valid?
        expect(@room.errors.full_messages).to include "価格を入力してください"
      end
      it 'priceが全角文字では出品できない' do
        @room.price = '３０００'
        @room.valid?
        expect(@room.errors.full_messages).to include "価格は数値で入力してください"
      end
      it 'priceが半角英数混合では出品できない' do
        @room.price = '1kk9'
        @room.valid?
        expect(@room.errors.full_messages).to include "価格は数値で入力してください"
      end
      it 'priceが半角英語だけでは出品できない' do
        @room.price = 'kkkk'
        @room.valid?
        expect(@room.errors.full_messages).to include "価格は数値で入力してください"
      end
      it 'priceが500未満では出品できない' do
        @room.price = 499
        @room.valid?
        expect(@room.errors.full_messages).to include "価格は500以上の値にしてください"
      end
      it 'priceが10,000以上では出品できない' do
        @room.price = 10001
        @room.valid?
        expect(@room.errors.full_messages).to include "価格は10000以下の値にしてください"
      end
      it 'userが紐づいていないと出品できない' do
        @room.user = nil
        @room.valid?
        expect(@room.errors.full_messages).to include "Userを入力してください"
      end
    end
  end
end