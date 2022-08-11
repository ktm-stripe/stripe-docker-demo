# frozen_string_literal: true

require 'bundler'
require 'json'
require 'pp'
require 'rubygems'
require 'sinatra/reloader'

Bundler.require(:default, ENV['APPLICATION_ENVIRONMENT'] || :development)
Dotenv.load

Stripe.api_key = ENV['STRIPE_API_KEY']

configure :development do
  register Sinatra::Reloader
  set :server, :puma
  set :bind, '0.0.0.0'
end

get '/' do
  "Hello World"
end
