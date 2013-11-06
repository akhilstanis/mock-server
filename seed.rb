require 'yaml'
require File.join(File.dirname(__FILE__), 'boot')

config = YAML.load(File.read('seed.yml'))

config['endpoints'].each do |endpoint, options|
  verb = options['verb'].to_s.downcase

  raise "Invalid or missing HTTP verb for endpoint #{endpoint}" unless ApiMockServer::Endpoint::VALID_HTTP_VERBS.include?(verb)

  ep = ApiMockServer::Endpoint.where(verb: verb, pattern: endpoint).
         find_or_initialize_by(response: options['response'], 
                               status: (options['status']||200).to_i,
                               params: options['params'])

  ep.save!
end
