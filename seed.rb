require 'yaml'
VALID_HTTP_VERBS = %w(get post put delete patch)
config = YAML.load(File.read('config.yml'))

config['endpoints'].each do |endpoint, options|
  method = options['method'].to_s.downcase

  raise "Invalid or missing HTTP verb for endpoint #{endpoint}" unless VALID_HTTP_VERBS.include?(method)

  ep = ApiMockServer::Endpoint.find_or_initialize_by(method: method, pattern: endpoint, response: options['response'], status: (options['status']||200).to_i)

  ep.save!
end

