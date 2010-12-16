$root = File.expand_path('../../', __FILE__)
require "#{$root}/lib/bleacher_api/gems"

BleacherApi::Gems.require(:spec)

require "#{$root}/lib/bleacher_api"
require 'pp'

BleacherApi::Config.url ENV['URL']

Spec::Runner.configure do |config|
end

# For use with rspec textmate bundle
def debug(object)
  puts "<pre>"
  puts object.pretty_inspect.gsub('<', '&lt;').gsub('>', '&gt;')
  puts "</pre>"
end

def only?(type)
  ENV['ONLY'].nil? || ENV['ONLY'].downcase == type.to_s.downcase
end