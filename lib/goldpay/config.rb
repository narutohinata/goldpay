module Goldpay
  class << self
    def configure
      yield config
    end

    def config
      @_config ||= Config.new
    end
  end
  class Config
    attr_accessor :public_key, :private_key, :mchnt_cd

    def initialize
      @public_key = nil
      @private_key = nil
      @mchnt_cd = nil
    end
  end
end