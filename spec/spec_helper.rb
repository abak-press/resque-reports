# coding: utf-8
require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler/setup'
require 'pry-byebug'
require 'rspec'
require 'timecop'

require 'resque-reports'

Resque.redis = Redis.new(host: ENV['TEST_REDIS_HOST'])

RSpec.configure do |config|
  config.before do
    Resque.redis.flushdb
  end
end
