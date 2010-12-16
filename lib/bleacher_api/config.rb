class BleacherApi
  module Config
    class <<self
      
      def url(url=nil)
        @url = url unless url.nil?
        @url || 'http://bleacherreport.com'
      end
      
      def token(token=nil)
        @token = token unless token.nil?
        @token
      end
    end
  end
end