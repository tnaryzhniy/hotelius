require 'rails_helper'

describe RaitingsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:hotel) { FactoryGirl.create(:hotel, user_id: user.id) }

  context 'route' do

    it 'should generate create params' do
      { post: '/hotels/1/raitings' }.should route_to(controller: 'raitings', action: 'create', hotel_id: '1')
      response.status.should be(200)
    end
  end

  context 'actions' do

    before { sign_in hotel.user }
    before { :hotel }
    before { :user }

    context 'create action' do

      it 'creates a new raiting' do
        expect{post :create, {:raiting => {comment: 'test', raiting: 3, user_id: user.id, commenter: user.email },
                              :hotel_id => hotel.id}}.to change(Raiting,:count).by(1)
        expect(assigns(:raiting)).to eq(Raiting.last)
      end

      it 'redirects to hotel page with new raiting if validations pass' do
        post :create, {:raiting => {comment: 'test', raiting: 3, user_id: user.id, commenter: user.email },
                       :hotel_id => hotel.id}
        response.should redirect_to(hotel_path(hotel))
      end

      it 'renders hotel page if validations fail' do
        post :create, {:raiting => {comment: 'test', raiting: nil, user_id: user.id, commenter: user.email },
                       :hotel_id => hotel.id}
        hotel.errors.should_not nil
        expect(response).to render_template('hotels/show')
      end
    end
  end
end