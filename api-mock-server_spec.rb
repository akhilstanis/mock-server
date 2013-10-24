ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), 'boot')
require 'rspec'
require 'rack/test'

describe 'The ApiMockServer App' do
  include Rack::Test::Methods

  def app
    ApiMockServer::App
  end

  it "should halt when username or password is not right" do
    authorize 'admin', 'wrong password'
    get "/admin"
    expect(last_response.status).to eq(401)
  end

  it "should render halt when username or password is not right" do
    authorize 'admin', 'admin'
    get "/admin"
    expect(last_response.status).to eq 200
    expect(last_response.body).to match("Select an API endpoint on the left to get started")
  end
end
