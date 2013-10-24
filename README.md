# Mock API Server

A Fully Functional API Mock Server

## Installation

### Install Mongodb

   [Install MongoDB](http://docs.mongodb.org/manual/installation/)

### Clone the Project

    git clone git@github.com:zlx/API-mock-server.git

### Install Dependancy

    bundle install --path=vendor/bundle


## Usage

### Mongodb Config

Configurate mongodb in mongoid.yml like below:
   
    development:
      sessions:
        default:
          database: api_mock_server
          hosts: 
            - localhost:27017

### Start Server

    bundle exec rerun "bundle exec rackup -p 4000"

### Visit

    http://localhost:4000/admin

## Test

### Mock Data

    ruby seed.rb

### Test the service using a curl or your favourite tool

    curl http://localhost:4000
    { "hello": "world" }

### Postman

[source code](https://github.com/a85/POSTMan-Chrome-Extension)

## Deploy on Server

### work with unicorn

[Guide for setup unicorn for rack app](http://recipes.sinatrarb.com/p/deployment/nginx_proxied_to_unicorn)
