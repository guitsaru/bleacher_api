require 'pp'

$root = File.expand_path('../../', __FILE__)
require "#{$root}/lib/bleacher_api/gems"

BleacherApi::Gems.activate :rspec

require "#{$root}/lib/bleacher_api"

BleacherApi::Config.url ENV['URL']

Spec::Runner.configure do |config|
end

def only?(type)
  ENV['ONLY'].nil? || ENV['ONLY'].downcase == type.to_s.downcase
end