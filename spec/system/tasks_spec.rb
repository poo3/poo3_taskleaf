require 'rails_helper'

describe 'タスク管理機能', type: :system do
  #ユーザA,B作成の定義をしておく
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com')}
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザB', email: 'b@example.com')}
  # 作成者がユーザAであるタスクを作成しておく
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a)}

  before do
    # ログインする機能を抽象化して定義する
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  #itの内容「ユーザーAが作成したタスクが表示される」を共通化する
  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク'}
  end


  describe '一覧表示機能' do
    context 'ユーザAがログインしている時' do
      # ユーザAでログインする
      let(:login_user) {user_a}

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザBがログインしている時' do
      # ユーザーBでログインする
      let(:login_user) {user_b}

      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
        expect(page).to have_no_content '最初のタスク'
        #expect(page).not_to have_content '最初のタスク'　この書き方でもOK
      end
    end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) {user_a}

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) {user_a}

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力したとき' do
      let(:task_name){'新規作成のテストを書く'}

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      let(:task_name){''}

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end

  end
end
