require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Rooms", type: :system do
  before do
    @room = FactoryBot.create(:room)
  end

  context 'roomが出品できる時' do
    it '正しい情報を入力すればroomが出品ができてトップページに遷移する' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに移動する
      basic_pass root_path
      # サインインする
      sign_in(@room.user)
      # トップページにroom作成へ遷移するボタンがあることを確認する
      expect(page).to have_content('room作成')
      # room作成ボタンをクリックする
      click_on('room作成')
      # 新規room出品ページへ移動する
      visit new_room_path
      #room情報を入力する
      fill_in 'room[name]', with: @room.name
      fill_in 'room[rexplain]', with: @room.rexplain
      find("#room[dayotw_id]").find("option[value='1']").select_option
      find("#room[rtime_id]").find("option[value='1']").select_option
      find("#room[htime_id]").find("option[value='1']").select_option
      find("#room[mtime_id]").find("option[value='1']").select_option
      fill_in 'room[price]', with: @room.price
      # 作成するボタンをクリックする
      click_on('作成する')
      # 登録するボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Room.count }.by(1)
      # トップページに出品したroom情報が表示されていることを確認する
      expect(page).to have_content(@room.name)
    end
    it '間違った情報を入力するとroomが出品ができない' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに移動する
      basic_pass root_path
      # サインインする
      sign_in(@user)
      # トップページにroom作成へ遷移するボタンがあることを確認する
      expect(page).to have_content('room作成')
      # room作成ボタンをクリックする
      click_on('room作成')
      # 新規room出品ページへ移動する
      visit new_room_path
      #room情報を入力する
      fill_in 'room[name]', with: ""
      fill_in 'room[rexplain]', with: ""
      find("#room[dayotw_id]").find("option[value='']").select_option
      find("#room[rtime_id]").find("option[value='']").select_option
      find("#room[htime_id]").find("option[value='']").select_option
      find("#room[mtime_id]").find("option[value='']").select_option
      fill_in 'room[price]', with: "３０００"
      # 作成するボタンをクリックする
      click_on('作成する')
      # 登録するボタンを押すとユーザーモデルのカウントが上がらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Room.count }.by(0)
      # 新規room出品ページのままであることを確認する
      expect(page).to have_content("Roomの情報を入力")
    end
  end

  context 'room編集ができるとき' do
    it 'ログインしたユーザーは自分が出品したroomの編集ができる' do
      # roomを出品したユーザーでログインする
      sign_in(@room.user)
      # room詳細ページへ遷移する
      visit room_path(@room)
      # 遷移したページに「編集」へのリンクがあることを確認する
      expect(page).to have_link 'Edit', href: edit_room_path(@room)
      # 編集ページへ遷移する
      visit edit_room_path(@room)
      # すでに出品済みの内容がフォームに入っていることを確認する
      expect(
        find('#room_name').value
      ).to eq(@room.name)
      expect(
        find('#room_price').value
      ).to eq @room.price.to_s
      # room内容を編集する
      fill_in 'room[name]', with: "#{@room.name}+編集した内容"
      fill_in 'room[rexplain]', with: "#{@room.rexplain}+編集した内容"
      # 編集してもRoomモデルのカウントは変わらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Room.count }.by(0)
      # room詳細ページに遷移したことを確認する
      expect(current_path).to eq(room_path(@room))
      # 「編集が完了しました」の文字があることを確認する
      expect(page).to have_content("#{@room.name}+編集した内容")
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のroomが存在することを確認する
      expect(page).to have_content(@room.name)
    end
  end
  context '編集ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した投稿の編集画面には遷移できない' do
      # 予め、room2をDBに保存する
      @room2 = FactoryBot.create(:room)
      # roomを出品したユーザーでログインする
      sign_in(@room.user)
      # roomを出品したユーザーでログインする
      sign_in(@room.user)
      # room2の詳細ページへ遷移する
      visit post_path(@post2)
      # room2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_post_path(@post2)
    end
    it 'ログインしていないと投稿の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # room1の詳細ページへ遷移する
      visit post_path(@post1)
      # room1に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_post_path(@post1)
      # room2の詳細ページへ遷移する
      visit post_path(@post2)
      # room2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_post_path(@room2)
    end
  end
  context 'room削除ができるとき' do
    it 'ログインしたユーザーは自らが出品したroomの削除ができる' do
      # room1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @room1.user.email
      fill_in 'パスワード', with: @room1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # room1の詳細ページへ遷移する
      visit room_path(@room1)
      # room1に「編集」へのリンクがあることを確認する
      expect(page).to have_link 'Edit', href: edit_room_path(@room1)
      # room編集ページへ遷移する
      visit edit_room_path(@room1)
      # room1の編集ページに「削除」へのリンクがあることを確認する
      expect(page).to have_link '投稿を削除する', href: room_path(@room1)
      # roomを削除するとレコードの数が1減ることを確認する
      find('#destroy_room_btn').click
      expect do
        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_content '投稿を削除しました'
      end.to change { Room.count }.by(-1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 「roomを削除しました」の文字があることを確認する
      expect(page).to have_content('投稿を削除しました')
      # トップページにはroom1の内容が存在しないことを確認する（ユーザーネーム）
      expect(page).to have_no_content(@room1.user.nickname)
    end
  end
  context 'roomの削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した投稿の削除ができない' do
      # 事前にroom1、room2を作成する
      @room1 = FactoryBot.create(:room)
      @room2 = FactoryBot.create(:room)
      # room1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @room1.user.email
      fill_in 'パスワード', with: @room1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # room2の詳細ページへ遷移する
      visit post_path(@post2)
      # room2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_room_path(@room2)
    end
    it 'ログインしていないと投稿の削除ボタンがない' do
      # 事前にroom1、room2を作成する
      @room1 = FactoryBot.create(:room)
      @room2 = FactoryBot.create(:room)
      # トップページに移動する
      visit root_path
      # room1の詳細ページへ遷移する
      visit room_path(@room1)
      # room1に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_room_path(@room1)
      # トップページに移動する
      visit root_path
      # room2の詳細ページへ遷移する
      visit room_path(@post2)
      # room2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_room_path(@room2)
    end
  end
end