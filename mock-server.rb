require 'sinatra'
require 'json'
require 'yaml'
require 'mongoid'
require 'pry'

Mongoid.load!("mongoid.yml")

class Endpoint
  include Mongoid::Document

  field :method, type: String
  field :pattern, type: String
  field :response, type: String
  field :status, type: Integer

end

VALID_HTTP_VERBS = %w(get post put delete patch)

config = YAML.load(File.read('config.yml'))

config['endpoints'].each do |endpoint, options|
  method = options['method'].to_s.downcase

  raise "Invalid or missing HTTP verb for endpoint #{endpoint}" unless VALID_HTTP_VERBS.include?(method)

  ep = Endpoint.find_or_initialize_by(method: method, pattern: endpoint, response: options['response'], status: (options['status']||200).to_i)

  ep.save!
end


Endpoint.each do |endpoint|
  send(endpoint.method, endpoint.pattern) do
    content_type :json
    status endpoint.status
    endpoint.response
  end
end
