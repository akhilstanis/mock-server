require 'json'

module ApiMockServer

  class Endpoint
    include Mongoid::Document

    field :method, type: String
    field :pattern, type: String
    field :response, type: String
    field :status, type: Integer
    field :params, type: Hash

  end

  #class ApiApp < Sinatra::Base
    #Endpoint.each do |endpoint|
      #send(endpoint.method.downcase, endpoint.pattern) do
        #content_type :json
        #status endpoint.status
        #endpoint.response
      #end
    #end
  #end

  class App < Sinatra::Base
    # for partial
    #binding.pry
    register Sinatra::Partial

    configure :development do
      set :partial_template_engine, :erb

      #Mongoid.configure do |config|
        #name = "api-mock"
        #host = "localhost"
        #config.master = Mongo::Connection.new.db(name)
        ##config.logger = Logger.new($stdout, :warn) 
        #config.logger = logger
        #config.persist_in_safe_mode = false
      #end
      Mongoid.load!("mongoid.yml")
    end

    helpers do
      def restart_server
        File.open("rerun.rb", "w") do |file|
          file.write Time.now
        end
      end
    end

    # remove it
    require 'seed'

    get "/admin" do
      erb :index
    end

    get "/admin/new" do
      #@route = Endpoint.new
      erb :new
    end

    post "/admin/new" do
      ps ||= {}
      params["params_key"].each_with_index do |params_name, index|
        ps[params_name] = params["params_value"][index]
      end
      @route = Endpoint.create(method: params["method"],
                               pattern: params["pattern"],
                               status: params["status"] || 200,
                               response: params["response"],
                               params: ps)
      restart_server
      erb :show
    end

    get "/admin/:id" do
      @route = Endpoint.find params[:id]
      erb :show
    end

    #binding.pry
    #use ApiAPP
    Endpoint.each do |endpoint|
      send(endpoint.method.downcase, endpoint.pattern) do
        content_type :json
        status endpoint.status
        endpoint.response
      end
    end
    #binding.pry
  end

end
