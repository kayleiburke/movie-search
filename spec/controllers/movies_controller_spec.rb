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
    end
  end
end
