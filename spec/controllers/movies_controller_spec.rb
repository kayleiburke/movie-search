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

      it "displays a flash message prompting the user to enter a search term" do
        get :index
        expect(flash[:success]).to eq('Please enter a movie to search for')
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

    context "with valid params that yield no results" do
      let(:params) { { movie: "lkjlkj;klj;;k", page: 1 } }

      it "renders the :index view" do
        get :index, params: params
        response.should render_template :index
      end

      it "returns no results" do
        get :index, params: params
        expect(assigns(:movies).size).to eq(0)
      end

      it "displays a flash message" do
        get :index, params: params
        expect(flash[:alert]).to eq("Movie not found")
      end
    end
  end

  describe "GET /show" do
    context "with valid id" do
      let(:params) { { id: 'tt0460792' } }

      it "renders the :show page" do
        get :show, params: params
        response.should render_template :show
      end

      it "returns a Movie object" do
        get :show, params: params
        expect(assigns(:movie)).to be_a(Movie)
      end

      it "has a movie poster" do
        get :show, params: params
        expect(assigns(:movie).poster).to be_a(String)
      end
    end

    context "with invalid id" do
      let(:params) { { id: 'bad_id' } }

      it "renders the :show page" do
        get :show, params: params
        response.should render_template :show
      end

      it "returns an empty movie object" do
        get :show, params: params
        expect(assigns(:movie).is_empty?).to eq(true)
      end

      it "returns a movie with a title of 'Title not found'" do
        get :show, params: params
        expect(assigns(:movie).title).to eq("Title not found")
      end
    end
  end
end
