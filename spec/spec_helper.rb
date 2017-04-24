# coding: utf-8
require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler/setup'
require 'pry-byebug'
require 'rspec'
require 'timecop'

require 'resque-reports'

require 'mock_redis'
Resque.redis = MockRedis.new

RSpec.configure do |config|
  config.before do
    Resque.redis.flushdb
  end
end
