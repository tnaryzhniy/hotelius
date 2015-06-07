require 'rails_helper'

describe HotelsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:hotel) { FactoryGirl.create(:hotel, user_id: user.id) }

  context 'route' do

    it 'should generate index params' do
      { get: '/hotels' }.should route_to(controller: 'hotels', action: 'index')
      response.status.should be(200)
    end

    it 'should generate show params' do
      { get: '/hotels/1' }.should route_to(controller: 'hotels', action: 'show', id: '1')
      response.status.should be(200)
    end

    it 'should generate new params' do
      { get: '/hotels/new' }.should route_to(controller: 'hotels', action: 'new')
      response.status.should be(200)
    end

    it 'should generate create params' do
      { post: '/hotels' }.should route_to(controller: 'hotels', action: 'create')
      response.status.should be(200)
    end

    it 'should generate destroy params' do
      { delete: '/hotels/1' }.should route_to(controller: 'hotels', action: 'destroy', id: '1')
      response.status.should be(200)
    end
  end

  context 'actions with autorized user' do

    before :each  do
      sign_in hotel.user
    end

    context 'index action' do
      it 'renders index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'show action' do
      it 'renders show template' do
        get :show, id: hotel.id
        expect(response).to render_template('show')
      end
    end

    context 'create action' do
      it 'creates a new Hotel' do
        expect { post :create, hotel: { title: 'test', stars: 5 , price: 100 } }.to change(Hotel,:count).by(1)
        expect(assigns(:hotel)).to eq(Hotel.last)
      end

      it 'redirects to newly created hotel if validations pass' do
        post :create, hotel: {title: 'test', stars: 3, price: 300}
        expect(response).to redirect_to(hotel_path(Hotel.last))
      end

      it 'renders new template if validations fail' do
        post :create, hotel: {title: 'Hotel', price: 300}
        expect(response).to render_template('new')
      end
    end

    context 'destroy action' do

      it 'destroys the requested hotel' do
        expect {
          delete :destroy, id: hotel.id
        }.to change(Hotel.all, :count).by(-1)
      end

      it 'redirects to the hotels list' do
        delete :destroy, id: hotel.id
        expect(response).to redirect_to(hotels_path)
      end
    end
  end
end
