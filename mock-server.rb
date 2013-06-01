require 'sinatra'
require 'json'
require 'yaml'

VALID_HTTP_VERBS = %w(get post put delete patch)

config = YAML.load(File.read('config.yml'))

config['endpoints'].each do |endpoint, options|
  method = options['method'].to_s.downcase

  raise "Invalid or missing HTTP verb for endpoint #{endpoint}" unless VALID_HTTP_VERBS.include?(method)

  send(method, endpoint) do
    content_type :json
    options['response']
  end
end
