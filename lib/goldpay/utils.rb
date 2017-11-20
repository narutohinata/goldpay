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

    def self.verify?(params)
      p params.match(/<plain>.+<\/plain>/)[0]
      p params.match(/<signature>(.+)<\/signature>/)[1]
      ::Goldpay::Sign::RSA.verify?(::Goldpay.config.public_key, params.match(/<plain>.+<\/plain>/)[0], params.match(/<signature>(.+)<\/signature>/)[1])
    end
  end
end