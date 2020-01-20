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

      it 'レコードの登録に失敗した場合、フラッシュメッセージが生成される' do
        post :create, params: { tweet_user: @user.id }, format: :js
        expect(flash[:alert]).not_to be_empty
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
