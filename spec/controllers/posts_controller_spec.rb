require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  describe 'POST #create' do
    context 'correct post' do
      it 'return 200 status' do
        params = { login: 'login1', post: { title: 'title1', text: 'text1', author_ip: '192.168.0.5' } }
        post :create, params

        expect(response).to have_http_status(200)
      end

      it 'return new post id' do
        params = { login: 'login1', post: { title: 'title1', text: 'text1', author_ip: '192.168.0.5' } }
        post :create, params

        body = JSON.parse(response.body)
        expect(body).to include('id')
      end
    end

    context 'missing one of post params' do
      it 'return 422 status' do
        params = { login: 'login1', post: { title: 'title1' } }

        post :create, params

        expect(response).to have_http_status(422)
      end

      it 'return error message' do
        params = { login: 'login1', post: { title: 'title1' } }

        post :create, params

        body = JSON.parse(response.body)
        expect(body).to include('errors')
      end
    end
  end

  context 'missing post param' do
    it 'return 500 status' do
      params = { login: 'login1' }

      post :create, params

      expect(response).to have_http_status(500)
    end

    it 'return error message' do
      params = { login: 'login1' }

      post :create, params

      body = JSON.parse(response.body)
      expect(body).to include('error')
    end
  end

  describe 'POST #set_rate' do
    let(:post1) { create(:post) }

    context 'valid rate' do
      it 'return 200 status' do
        params = { id: post1.id, value: 5}

        post :set_rate, params

        expect(response).to have_http_status(200)
      end

      it 'return new post rating' do
        post1 = create(:post)
        params = { id: post1.id, value: 5}

        post :set_rate, params

        body = JSON.parse(response.body)
        expect(body).to include('rate')
      end

      it 'return correct new post rating' do
        post1 = create(:post)
        params1 = { id: post1.id, value: 2}
        params2 = { id: post1.id, value: 5}

        20.times do
          post :set_rate, params1
        end
        40.times do
          post :set_rate, params2
        end

        body = JSON.parse(response.body)
        expect(body['rate']).to eq 4.0
      end
    end

    context 'when post not found' do
      it 'return 422 status' do
        params = { id: 2, value: 5}

        post :set_rate, params

        expect(response).to have_http_status(422)
      end

      it 'return error message' do
        params = { id: 2, value: 5}

        post :set_rate, params

        body = JSON.parse(response.body)
        expect(body).to include('errors')
      end
    end
  end

  describe 'GET #index' do
    it 'responds successfully with 200 status' do
      get :index, format: :json

      expect(response).to have_http_status(200)
    end
  end
end