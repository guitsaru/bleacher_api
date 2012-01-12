require 'spec_helper'

describe BleacherApi do
  
  before(:all) do
    @user_keys = %w(id email first_name last_name permalink token api)
  end

  if only?(:Article)
    describe :Article do
      describe :article do
        
        describe 'success' do
          before(:all) do
            @response = BleacherApi::Article.article(1020834, :article => true)
          end

          it "should return a hash with valid keys" do
            @response.keys.should == ["article"]
          end
        end
      end
    end
  end
  
  if only?(:Authenticate)
    describe :Authenticate do
      describe :login do
        
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

      describe :logout do

        before(:all) do
          @response = BleacherApi::Authenticate.logout
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
        @keys = [
          "Dallas Mavericks",
          "Texas Tech Football",
          "Dallas Cowboys",
          "Texas Rangers",
          "TCU Football"
        ]
        @child_keys = [ "shortName", "displayName", "logo", "uniqueName" ]
      end
      
      describe :city do
        before(:all) do
          @response = BleacherApi::Geolocation.teams(:city => 'Dallas')
        end
      
        it "should return a hash with the proper keys" do
          (@response.keys - @keys).should == []
        end
      
        it "should return a hash of hashes with the proper keys" do
          @keys.each do |key|
            (@response[key].keys - @child_keys).should == []
          end
        end
      end
      
      describe 'lat/long' do
        before(:all) do
          @response = BleacherApi::Geolocation.teams(:lat => "32.778155", :long => "-96.795404")
        end
      
        it "should return a hash with the proper keys" do
          (@response.keys - @keys).should == []
        end
      
        it "should return a hash of hashes with the proper keys" do
          @keys.each do |key|
            (@response[key].keys - @child_keys).should == []
          end
        end
      end
    end
  end
  
  if only?(:Stream)
    describe :Stream do
      before(:all) do
        @response = BleacherApi::Stream.first('san-francisco-49ers')
        @keys = %w(label title published_at image)
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
