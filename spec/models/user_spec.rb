require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '次のページ進めるとき' do
      it 'nameとintroduction,email,password,password_confirmationが存在すれば次のページ進める' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上で半角英数どちらも含めてあれば次のページ進める' do
        @user.password ='2021te'
        @user.password_confirmation = '2021te'
        expect(@user).to be_valid
      end
    end
    context '次のページ進めないとき' do
      it 'nameが空では次のページ進めない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前を入力してください"
      end
      it 'introductionが空では次のページ進めない' do
        @user.introduction = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "自己紹介を入力してください"
      end
      it 'emailが空では次のページ進めない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it '重複したemailが存在する場合次のページ進めない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
      end
      it 'emailには「@」を含めないと次のページ進めない' do
        @user.email = 'samplegmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールは不正な値です"
      end
      it 'passwordが空では次のページ進めない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'passwordが存在してもpassword_confirmationが空では次のページ進めない' do
        @user.password_confirmation =''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it 'passwordが5文字以下では次のページ進めない' do
        @user.password = 't0000'
        @user.password_confirmation = 't0000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'passwordが英語のみでは次のページ進めない' do
        @user.password = 'techca'
        @user.password_confirmation = 'techca'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数含めた半角6文字以上で入力ください")
      end
      it 'passwordが数字のみでは次のページ進めない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数含めた半角6文字以上で入力ください")
      end
      it 'passwordが全角では次のページ進めない' do
        @user.password = 'てっくきゃん'
        @user.password_confirmation = 'てっくきゃん'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数含めた半角6文字以上で入力ください")
      end
    end
  end
end
