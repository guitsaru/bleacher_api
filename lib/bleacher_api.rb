require File.dirname(__FILE__) + '/bleacher_api/gems'

BleacherApi::Gems.require(:lib)

require 'httparty'

$:.unshift File.dirname(__FILE__)

require 'bleacher_api/config'
require 'bleacher_api/version'

class BleacherApi
  include HTTParty
  
  class <<self
    def call(type, path, data=nil)
      base_uri BleacherApi::Config.url
      data, old_data = {}, data
      data[type == :get ? :query : :body] = old_data
      output = send(type, "/api/#{path}.json", data)
      if output.headers['status'].include?('200')
        output
      else
        false
      end
    end
  end
  
  class Authenticate
    class <<self
      def login(email, password)
        result = BleacherApi.call(:post, 'authenticate/login', {
          'user[email]' => email,
          'user[password]' => password
        })
        if result
          BleacherApi::Config.token result['token']
        end
        result
      end
    end
  end
  
  class Geolocation
    class <<self
      def teams(options)
        BleacherApi.call(:get, 'geolocation/teams', options)
      end
    end
  end
  
  class Stream
    class <<self
      def first(*tags)
        BleacherApi.call(:get, 'stream/first', {
          :tags => tags.join(',')
        })
      end
    end
  end
  
  class User
    class <<self
      def user(token=BleacherApi::Config.token)
        BleacherApi.call(:get, 'user/user', {
          :token => token
        })
      end
    end
  end
end