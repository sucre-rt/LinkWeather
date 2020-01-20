require 'rails_helper'

RSpec.describe TrustsController, type: :controller do

  describe 'ログインしているユーザー' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    describe 'POST #create' do
      it '@tweet_userに期待する値が入っている' do
        another_user = FactoryBot.create(:email_user)
        post :create, params: { tweet_user: another_user.id }, format: :js
        expect(assigns(:tweet_user)).to eq another_user
      end

      it '@trust_idに期待する値が入っている' do
        another_user = FactoryBot.create(:email_user)
        post :create, params: { tweet_user: another_user.id }, format: :js
        expect(assigns(:trust_id)).to eq ".trust-link-#{ another_user.id}"
      end

      it 'レコードの登録に失敗した場合、フラッシュメッセージが生成される' do
        post :create, params: { tweet_user: @user.id }, format: :js
        expect(flash[:alert]).not_to be_empty
      end

      it '正常に動作が行われた場合、trustテーブルのレコードが１増える' do
        another_user = FactoryBot.create(:email_user)
        expect{
          post :create,
          params: { tweet_user: another_user.id },
          format: :js
        }.to change(Trust, :count).by(1)
      end
    end

    describe 'DELETE #delete' do
      it '@tweet_userに期待する値が入っている' do
        another_user = FactoryBot.create(:email_user)
        create(:trust, good_user: another_user, valuer: @user )
        delete :delete, params: { tweet_user: another_user.id }, format: :js
        expect(assigns(:tweet_user)).to eq another_user
      end

      it '@trust_idに期待する値が入っている' do
        another_user = FactoryBot.create(:email_user)
        create(:trust, good_user: another_user, valuer: @user )
        delete :delete, params: { tweet_user: another_user.id }, format: :js
        expect(assigns(:trust_id)).to eq ".trust-link-#{ another_user.id}"
      end

      it '正常に動作が行われた場合、trustテーブルのレコードが１減る' do
        another_user = FactoryBot.create(:email_user)
        create(:trust, good_user: another_user, valuer: @user)
        expect{
          delete :delete, 
          params: { tweet_user: another_user.id }, 
          format: :js
        }.to change(Trust, :count).by(-1)
      end
    end
  end

  describe 'ログインしていないユーザー' do
    
    describe 'POST #create' do
      it 'ログインページにリダイレクトする' do
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'DELETE #delete' do
      it 'ログインページにリダイレクトする' do
        delete :delete
        expect(response).to redirect_to new_user_session_path
      end
    end

  end
end
