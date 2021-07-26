require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe "GET /index" do
    context "with empty params" do
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end

      it "returns an empty result set" do
        get :index
        expect(assigns(:movies)).to eq([])
      end

      it "displays a flash message" do
        get :index
        expect(flash[:alert]).to eq('Movie not found')
      end
    end

    context "with valid params" do
      let(:params) { { movie: "food", page: 2 } }

      it "renders the :index view" do
        get :index, params: params
        response.should render_template :index
      end

      it "returns 10 results" do
        get :index, params: params
        expect(assigns(:movies).size).to eq(10)
      end

      it "does not display a flash message" do
        get :index, params: params
        expect(flash[:alert]).to eq(nil)
      end

      it 'does paginate records' do
        get :index, params: params
        expect(assigns(:total_movies)).to be > 10
      end
    end
  end
end