module Goldpay
  module Service
    # GATEWAY_URL = 'https://jzh-test.fuiou.com/jzh/'
    # http直连 开户注册
    HTTP_REG_SIGN_PARAMS = %w(bank_nm capAcntNm capAcntNo certif_id city_id cust_nm email lpassword mchnt_cd mchnt_txn_ssn mobile_no parent_bank_id password rem ver)
    def self.reg(params)
      params = perpare_params(params, HTTP_REG_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(reg.action)
      Net::HTTP.post_form(URI(url), params).body
      # Hash.from_xml(res)
    end

    # http直连 法人开户注册
    HTTP_ARTIFREG_SIGN_PARAMS = %w(artif_nm bank_nm capAcntNo certif_id city_id cust_nm email lpassword mchnt_cd mchnt_txn_ssn mobile_no parent_bank_id password rem ver)
    def self.artifReg(params)
      params = perpare_params(params, HTTP_ARTIFREG_SIGN_PARAMS)
      url = GATEWAY_URL + %Q("artifReg.action")
      Net::HTTP.post_form(URI(url), params).body
    end

    # Http直连 预授权接口
    HTTP_PRE_AUTH_SIGN_PARAMS = %w(amt in_cust_no mchnt_cd mchnt_txn_ssn out_cust_no rem ver)
    def self.perAuth(params)
      params = perpare_params(params, HTTP_PRE_AUTH_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(preAuth.action)
      Net::HTTP.post_form(URI(url), params).body
    end

    # HTTP直连 预授权撤销接口
    HTTP_PRE_AUTH_CANCEL_SIGN_PARAMS = %w(contract_no in_cust_no mchnt_cd mchnt_txn_ssn out_cust_no rem ver)
    def self.perAuthCancel(params)
      params = perpare_params(params, HTTP_PRE_AUTH_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(preAuthCancel.action)
      Net::HTTP.post_form(URI(url), params).body
    end

    # HTTP直连 转账(商户与个人之间)
    HTTP_TRANSFERBMU_SIGN_PARAMS = %w(amt contract_no in_cust_no mchnt_cd mchnt_txn_ssn out_cust_no rem ver)
    def self.transferBmu(params)
      params = perpare_params(params, HTTP_TRANSFERBMU_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(transferBmu.action)
      Net::HTTP.post_form(URI(url), params).body
    end

    # HTTP直连 划拨(个人与个人之间)
    HTTP_TRANSFERBU_SIGN_PARAMS = %w(amt contract_no in_cust_no mchnt_cd mchnt_txn_ssn out_cust_no rem ver)
    def self.transferBu(params)
      params = perpare_params(params, HTTP_TRANSFERBU_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(transferBu.action)
      Net::HTTP.post_form(URI(url), HTTP_TRANSFERBU_SIGN_PARAMS).body
    end

    # HTTP直连 冻结
    HTTP_FREEZE_SIGN_PARAMS = %w(amt cust_no mchnt_cd mchnt_txn_ssn rem ver)
    def self.freezeAccount(params)
      params = perpare_params(params, HTTP_FREEZE_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(freeze.action)
      Net::HTTP.post_form(URI(url), HTTP_FREEZE_SIGN_PARAMS).body
    end

    # HTTP直连 转账预冻结
    HTTP_TRANSFERBMU_ADN_FREEZE_SIGN_PARAMS = %w(amt in_cust_no mchnt_cd mchnt_txn_ssn out_cust_no rem ver)
    def self.transferBmuAndFreeze(params)
      params = perpare_params(params, HTTP_TRANSFERBMU_ADN_FREEZE_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(transferBmuAndFreeze.action)
      Net::HTTP.post_form(URI(url), HTTP_TRANSFERBMU_ADN_FREEZE_SIGN_PARAMS).body
    end

    # HTTP直连划拨预冻结
    HTTP_TRANSFERBU_AND_FREEZE_SIGN_PARMS = %w(amt in_cust_no mchnt_cd mchnt_txn_ssn out_cust_no rem ver)
    def self.transferBuAndFreeze(params)
      params = perpare_params(params, HTTP_TRANSFERBU_AND_FREEZE_SIGN_PARMS)
      url = GATEWAY_URL + %Q(transferBuAndFreeze.action)
      Net::HTTP.post_form(URI(url), HTTP_TRANSFERBU_AND_FREEZE_SIGN_PARMS).body
    end

    # HTTP直连冻结到冻结接口
    HTTP_TRANSFERBU_AND_FREEZE_TO_FREEZE_SIGN_PARAMS = %w(amt in_cust_no mchnt_cd mchnt_txn_ssn out_cust_no rem ver)
    def self.transferBuAndFreeze2Freeze(params)
      params = perpare_params(params, HTTP_TRANSFERBU_AND_FREEZE_TO_FREEZE_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(transferBuAndFreeze2Freeze.action)
      Net::HTTP.post_form(URI(url), HTTP_TRANSFERBU_AND_FREEZE_TO_FREEZE_SIGN_PARAMS).body
    end

    # HTTP直连 资金解冻
    HTTP_UN_FREEZE_SIGN_PARAMS = %w(amt cust_no mchnt_cd mchnt_txn_ssn rem ver)
    def self.unFreeze(params)
      params = perpare_params(params, HTTP_UN_FREEZE_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(unFreeze.action)
      Net::HTTP.post_form(URI(url), HTTP_UN_FREEZE_SIGN_PARAMS).body
    end

    # HTTP直连 用户更换银行卡接口
    HTTP_USER_CHANGECARD_SIGN_PARAMS = %w(bank_cd card_no city_id login_id mchnt_cd mchnt_txn_ssn)
    def self.userChangeCard(params)
      params = perpare_params(params, HTTP_USER_CHANGECARD_SIGN_PARAMS)
      url = GATEWAY_URL + %Q(userChangeCard.action)
      Net::HTTP.post_form(URI(url), HTTP_UN_FREEZE_SIGN_PARAMS).body
    end

    def self.perpare_params(params, keys)
      params = {
          'mchnt_cd' =>  ::Goldpay.config.mchnt_cd,
          'mchnt_txn_ssn' => Utils.generate_batch_no
      }.merge(Utils.stringify_keys(params))
      params['signature'] = sign(params, keys)
      params
    end

    def self.sign(params, keys)
      string = params_to_string(params, keys)
      ::Goldpay::Sign::RSA.sign(::Goldpay.config.private_key, string)
    end

    def self.params_to_string(params, keys)
      keys.sort.map{|key| params[key]}.join('|')
    end
  end
end