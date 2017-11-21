module Goldpay
  class Utils
    def self.stringify_keys(hash)
      new_hash = {}
      hash.each do |k, v|
        new_hash[(k.to_s rescue k) || k] = v
      end
      new_hash
    end

    def self.generate_batch_no
       t = Time.now
       batch_no = t.strftime('%Y%m%d%H%M%S') + t.nsec.to_s
       batch_no.ljust(24, rand(10).to_s)
    end

    def self.xml_verify?(xml)
      ::Goldpay::Sign::RSA.verify?(::Goldpay.config.public_key, xml.match(/<plain>.+<\/plain>/)[0], xml.match(/<signature>(.+)<\/signature>/)[1])
    end

    def self.json_verify?(params, keys)
      string = keys.sort.map{|key| params[key]}.join('|')
      ::Goldpay::Sign::RSA.verify?(::Goldpay.config.public_key, string, params["signature"])
    end

    def self.sign(params, keys)
      string = keys.sort.map{|key| params[key]}.join('|')
     ::Goldpay::Sign::RSA.sign(::Goldpay.config.private_key, string)
    end
  end
end