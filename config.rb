ApiMockServer.setup do |config|
  # set top namespace for your API, default is /
  # config.top_namespace = "/api/v1"
  config.top_namespace = "/api/v1" unless ENV['RACK_ENV'] == 'test'

  # set admin username and password, default: admin/admin
  # config.admin_user = 'admin'
  # config.admin_password = 'admin'
end
