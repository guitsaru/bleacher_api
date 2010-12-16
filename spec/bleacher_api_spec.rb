require 'spec_helper'

describe BleacherApi do
  
  before(:all) do
    @user_keys = %w(id email first_name last_name permalink token)
  end
  
  if only?(:Authenticate)
    describe :Authenticate do
      describe 'success' do
        before(:all) do
          @response = BleacherApi::Authenticate.login(ENV['LOGIN'], ENV['PASSWORD'])
        end
    
        it "should return a hash with valid keys" do
          @response.keys.length.should == @user_keys.length
          (@response.keys - @user_keys).should == []
        end
      
        it "should set Config.token" do
          BleacherApi::Config.token.should == @response['token']
        end
      end
    
      describe 'failure' do
        before(:all) do
          @response = BleacherApi::Authenticate.login('fail', 'fail')
        end
    
        it "should return false" do
          @response.should == false
        end
      end
    end
  end
  
  if only?(:Geolocation)
    describe :Geolocation do
      before(:all) do
        @response = BleacherApi::Geolocation.teams('Dallas')
        @permalinks = ["texas-rangers", "dallas-stars", "dallas-cowboys", "dallas-mavericks", "fc-dallas", "oklahoma-sooners-basketball", "texas-longhorns-basketball", "texas-am-basketball", "texas-tech-basketball", "oklahoma-state-basketball", "baylor-basketball", "oklahoma-sooners-football", "texas-longhorns-football", "texas-am-football", "texas-tech-football", "oklahoma-state-football", "baylor-football", "tcu-football", "smu-mustangs-football", "north-texas-mean-green-football"]
      end
  
      it "should return permalinks" do
        @response.length.should == @permalinks.length
        (@response - @permalinks).should == []
      end
    end
  end
  
  if only?(:Stream)
    describe :Stream do
      before(:all) do
        @response = BleacherApi::Stream.first('san-francisco-49ers')
        @keys = %w(title published_at image)
      end
  
      it "should return hash with valid keys" do
        @response.keys.should == [ 'san-francisco-49ers' ]
        @response['san-francisco-49ers'].keys.should == @keys
      end
    end
  end
  
  if only?(:User)
    describe :User do
      describe 'success' do
        before(:all) do
          BleacherApi::Authenticate.login(ENV['LOGIN'], ENV['PASSWORD'])
          @response = BleacherApi::User.user
        end
  
        it "should return a hash with valid keys" do
          @response.keys.length.should == @user_keys.length
          (@response.keys - @user_keys).should == []
        end
      end
      
      describe 'failure' do
        before(:all) do
          @response = BleacherApi::User.user('fail')
        end
    
        it "should return false" do
          @response.should == false
        end
      end
    end
  end
end