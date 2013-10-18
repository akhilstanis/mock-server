require 'json'

module ApiMockServer

  class Endpoint
    include Mongoid::Document

    field :verb, type: String
    field :pattern, type: String
    field :response, type: String
    field :status, type: Integer
    field :params, type: Hash

    VALID_HTTP_VERBS = %w{get post put delete patch}

    validates_presence_of :response, :status, message: "不能为空"
    validates_inclusion_of :verb, in: VALID_HTTP_VERBS , message: "目前只支持以下方法: #{VALID_HTTP_VERBS.join(", ")}"
    validates_format_of :pattern, with: /\A\/\S*\Z/, message: "必须为 / 开头的合法 url"
    validates_uniqueness_of :pattern, scope: [:verb], message: "和 verbs 该组合已经存在"

  end

  class App < Sinatra::Base
    register Sinatra::Partial

    configure :development do
      set :partial_template_engine, :erb

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
      @route = Endpoint.new
      erb :new
    end

    post "/admin/new" do
      ps ||= {}
      params["params_key"].each_with_index do |params_name, index|
        ps[params_name] = params["params_value"][index]
      end
      @route = Endpoint.new(verb: params["verb"],
                            pattern: params["pattern"],
                            status: params["status"].blank? ? 200 : params["status"].to_i,
                            response: params["response"],
                            params: ps)
      if @route.save
        restart_server
        erb :show
      else
        @error = @route.errors.full_messages
        erb :new
      end
    end

    get "/admin/:id" do
      @route = Endpoint.find params[:id]
      erb :show
    end

    #binding.pry
    #use ApiAPP
    Endpoint.each do |endpoint|
      p endpoint
      #binding.pry
      send(endpoint.verb, endpoint.pattern) do
        content_type :json
        status endpoint.status
        endpoint.response
      end
    end
    #binding.pry
  end

end
