require 'resque-integration'
require 'resque/reports'
require 'ruby/reports'
require 'ruby/reports/patches/base_report'
require 'resque/reports/extensions'
require_relative '../app/jobs/resque/reports/report_job'

Ruby::Reports::Config.prepend Resque::Reports::Extensions::Config
