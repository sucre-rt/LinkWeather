require 'rails_helper'

describe SubAreasController do

  describe 'ログインしているユーザー' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    describe 'POST #create' do
      it '@areaに期待する値が入っている' do
        post :create, params: { area: "東京都"}, format: :js
        expect(assigns(:area)).to eq "東京都"
      end

      it 'params[:area]がなければアラートメッセージが生成される' do
        post :create, params: { area: "" }, format: :js
        expect(flash[:alert]).not_to be_empty
      end

      it '@areaがあればサブエリアのレコード数が１つ増える' do
        expect{
          post :create,
          params: { area: "東京都" }, 
          format: :js 
        }.to change(SubArea, :count).by(1)
      end
    end

    describe 'DELETE #delete' do
      it '@areaに期待する値が入っている' do
        create(:sub_area, area: "東京都", user: @user)
        delete :delete, params: { area: "東京都"}, format: :js
        expect(assigns(:area)).to eq "東京都"
      end

      it '@sub_areaに期待する値が入っている' do
        area = create(:sub_area, area: "東京都", user: @user)
        delete :delete, params: { area: "東京都"}, format: :js
        expect(assigns[:sub_area]).to eq area
      end

      it 'params[:area]がなければアラートメッセージが生成される' do
        create(:sub_area, area: "東京都", user: @user)
        delete :delete, params: { area: "" }, format: :js
        expect(flash[:alert]).not_to be_empty
      end

      it '@areaがあればサブエリアのレコード１つが減る' do
        create(:sub_area, area: "東京都", user: @user)
        expect{
          delete :delete,
          params: { area: "東京都" }, 
          format: :js 
        }.to change(SubArea, :count).by(-1)
      end
    end
  end

  describe 'ログインしていないユーザー' do

    describe "POST #create" do
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