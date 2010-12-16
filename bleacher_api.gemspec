# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bleacher_api/gems'
require 'bleacher_api/version'

Gem::Specification.new do |s|
  s.name = "bleacher_api"
  s.version = BleacherApi::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Winton Welsh"]
  s.email = ["wwelsh@bleacherreport.com"]
  s.homepage = "http://github.com/winton/bleacher_api"
  s.summary = ""
  s.description = ""

  BleacherApi::Gems::TYPES[:gemspec].each do |g|
    s.add_dependency g.to_s, BleacherApi::Gems::VERSIONS[g]
  end
  
  BleacherApi::Gems::TYPES[:gemspec_dev].each do |g|
    s.add_development_dependency g.to_s, BleacherApi::Gems::VERSIONS[g]
  end

  s.files = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.executables = Dir.glob("{bin}/*").collect { |f| File.basename(f) }
  s.require_path = 'lib'
end