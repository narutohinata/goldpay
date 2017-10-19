require 'openssl'
require 'base64'

module Goldpay
  module Sign
    class RSA
      def self.sign(key, data)
        rsa = OpenSSL::PKey::RSA.new(key)
        Base64.strict_encode64(rsa.sign('sha1', data))
      end

      def self.verify?(key, data, sign)
        rsa = OpenSSL::PKey::RSA.new(key)
        rsa.verify('sha1', Base64.strict_decode64(sign), data)
      end
    end
  end
end