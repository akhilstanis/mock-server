# Mock API Server

A simple mock API server written in ruby. Just configure the endpoints in the config yaml file and start the server.

## Installation

    bundle install --path=vendor/bundle

## Usage
A sample config yaml looks like below:


    endpoints:
      '/':
        method:   'GET'
        response: '{"hello": "world"}'

      '/user':
        method:   'GET'
        response: '{"hello": "user"}'

The server is a simple sinatra app, so simply run mock-server.rb using ruby

    bundle exec ruby mock-server.rb

Test the service using a curl or your favourite tool

    curl http://localhost:4567
    { "hello": "world" }


