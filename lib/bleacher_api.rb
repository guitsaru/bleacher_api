require File.dirname(__FILE__) + '/bleacher_api/gems'

BleacherApi::Gems.activate %w(httparty)

require 'httparty'

$:.unshift File.dirname(__FILE__)

require 'bleacher_api/config'

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
  
  class Article
    class <<self
      def article(id, options={})
        BleacherApi.call(:get, 'article/article', options.merge(:id => id))
      end
    end
  end

  class Authenticate
    class <<self
      def login(email, password, redirect=nil)
        result = BleacherApi.call(:post, 'authenticate/login', {
          'user[email]' => email,
          'user[password]' => password,
          'redirect' => nil
        })
        if result
          BleacherApi::Config.token result['token']
        end
        result
      end

      def logout
        BleacherApi.call(:get, 'authenticate/logout')
      end
    end
  end
  
  class Front
    class <<self
      def lead_articles(options)
        BleacherApi.call(:get, 'front/lead_articles', options)
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
  
  class Related
    class <<self
      def channel(options)
        BleacherApi.call(:get, 'related/channel', options)
      end
      
      def channel_next(options)
        BleacherApi.call(:get, 'related/channel_next', options)
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
