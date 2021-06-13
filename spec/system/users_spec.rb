require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができる時' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに遷移する' do
      # トップページに移動する
      basic_pass root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[name]', with: @user.name
      fill_in 'user[introduction]', with: @user.introduction
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      # ログインボタンをクリックする
      click_on('Next')
      # トップページにカード情報が表示されていることを確認する
      expect(page).to have_content('カード情報')
      # カード情報を入力する
      fill_in 'number', with: "4242424242424242"
      fill_in 'cvc', with: '123'
      find("#exp_month").find("option[value='1']").select_option
      find("#exp_year").find("option[value='24']").select_option
      # 登録するボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができない時' do
    it 'ユーザー情報が誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # 間違ったユーザー情報を入力する
      fill_in 'user[name]', with: '1234'
      fill_in 'user[introduction]', with: '1234'
      fill_in 'user[email]', with: 'sample@gmail.com'
      fill_in 'user[password]', with: '1223'
      fill_in 'user[password_confirmation]', with: '1234'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
    it 'カード情報が誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      basic_pass root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[name]', with: @user.name
      fill_in 'user[introduction]', with: @user.introduction
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      # ログインボタンをクリックする
      click_on('Next')
      # トップページにカード情報が表示されていることを確認する
      expect(page).to have_content('カード情報')
      # 間違ったカード情報を入力する
      fill_in 'number', with: "hohohho"
      fill_in 'cvc', with: 'fufufu'
      find("#exp_month").find("option[value='1']").select_option
      find("#exp_year").find("option[value='22']").select_option
      # 登録するボタンを押すとユーザーモデルのカウントが上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # トップページにカード情報が表示されていることを確認する
      expect(page).to have_content('カード情報')
    end
  end
end

RSpec.describe "ログイン", type: :system do
  it 'ログインしていない状態で「room作成」にアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    basic_pass new_room_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # サインインページへ移動する
    basic_pass new_user_session_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    # ログインボタンをクリックする
    click_on('ログイン')
    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # トップページに遷移する
    basic_pass root_path
    # ログインボタンをクリックする
    click_on "ログイン"
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # 誤ったユーザー情報を入力する
    fill_in 'user[email]', with: "test@gmail.com"
    fill_in 'user[password]', with: 'test'
    # ログインボタンをクリックする
    click_on "ログイン"
    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
end
