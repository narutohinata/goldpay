module Goldpay
  module Web
    module Service
      # GATEWAY_URL = 'https://jzh-test.fuiou.com/jzh/'

      # 个人用户自助开户
      WEBREG_SIGN_PARAMS = %w(back_notify_url bank_nm capAcntNo certif_id city_id cust_nm email mchnt_cd mchnt_txn_ssn mobile_no page_notify_url parent_bank_id user_id_from ver)
      def self.web_reg(params)
        # params = Utils.stringify_keys(params)
        params = perpare_params(params, WEBREG_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(webReg.action)
        gen_html(url, params)
      end

      # 法人用户自助开户
      WEBARTIFREG_SIGN_PARAMS = %w(artif_nm back_notify_url bank_nm capAcntNo certif_id city_id cust_nm email mchnt_cd mchnt_txn_ssn mobile_no page_notify_url parent_bank_id user_id_from ver)
      def self.web_artifreg(params)
        params = perpare_params(params, WEBARTIFREG_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(webArtifReg.action)
        gen_html(url, params)
      end

      #商户P2P网站免登录快速充值接口
      NO_LOGIN_FAST_RECHARGE_SIGN_PARAMS = %w(amt back_notify_url login_id mchnt_cd mchnt_txn_ssn page_notify_url)
      def self.no_login_fast_recharge(params)
        params = perpare_params(params, NO_LOGIN_FAST_RECHARGE_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(500001.action)
        gen_html(url, params)
      end

      # 商户P2P网站免登录网银充值接口
      NO_LOGIN_ONLINE_BANK_RECHARGE_SIGN_PARAMS = %w(amt login_id mchnt_cd mchnt_txn_ssn rem resp_code)
      def self.no_login_online_bank_recharge(params)
        params = perpare_params(params, NO_LOGIN_ONLINE_BANK_RECHARGE_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(500002.action)
        gen_html(url, params)
      end

      # P2P免登录直接跳转网银界面充值接口
      NO_LOGIN_ONLINE_BANK_VIEW_RECHARGE_SIGN_PARAMS = %w(amt back_notify_url iss_ins_cd login_id mchnt_cd mchnt_txn_ssn order_pay_type page_nofity_url)
      def self.no_login_online_bank_view_recharge(params)
        params = perpare_params(params, NO_LOGIN_ONLINE_BANK_VIEW_RECHARGE_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(500012.action)
        gen_html(url, params)
      end

      #商户P2P网站免登录提现接口
      NO_LOGIN_WITHDRAWALS_SIGN_PARAMS = %w(amt back_notify_url login_id mchnt_cd mchnt_txn_ss page_notify_url)
      def self.no_login_withdrawals(params)
        params = perpare_params(params, NO_LOGIN_WITHDRAWALS_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(50003.action)
        gen_html(url, params)
      end

      #用户密码修改重置免登陆接口(网页版)
      USER_RESET_PASSWORD_SIGN_PARAMS = %w(busi_tp login_id mchnt_cd mchnt_txn_ssn)
      def self.user_reset_password(params)
        params = perpare_params(params, USER_RESET_PASSWORD_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(resetPassWord.action)
        gen_html(url, params)
      end

      #个人PC端更换手机号
      USER_PC_SIDE_UPDATE_PHONE_SIGN_PARAMS = %w(login_id mchnt_cd mchnt_txn_ssn page_notify_url)
      def self.user_pc_side_update_phone(params)
        params = perpare_params(params, USER_PC_SIDE_UPDATE_PHONE_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(400101.action)
        get_html(url, params)
      end

      #商户P2P网站免登录用户更换银行卡接口

      # PC端个人用户免登录快捷充值
      USER_NOT_LOGIN_FAST_RECHARGE_SIGN_PARAMS = %w(amt back_notify_url login_id mchnt_cd mchnt_txn_ssn page_notify_url)
      def self.user_not_login_fast_recharge_sign_params(params)
        params = perpare_params(params, USER_NOT_LOGIN_FAST_RECHARGE_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(500405.action)
        get_html(url, params)
      end

      #PC金账户免登陆授权配置
      GOLDPAY_NOT_LOGIN_AUTH_SET_SIGN_PARAMS = %w(page_notify_url busi_tp login_id mchnt_cd mchnt_txn_ssn)
      def self.gold_not_login_auth_set_sign_params
        params = perpare_params(params, GOLDPAY_NOT_LOGIN_AUTH_SET_SIGN_PARAMS)
        url = GATEWAY_URL << %Q(authConfig.action)
        get_html(url, params)
      end


      def self.perpare_params(params, keys)
        params = {
            'mchnt_cd' => ::Goldpay.config.mchnt_cd,
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

      def self.gen_html(url, params)
        html = %Q(<form id='goldpaysubmit' name='goldpaysubmit' action='#{url}' method='post'>)
        params.each do |key, value|
          html << %Q(<input type='hidden' name='#{key}' value='#{value.gsub("'", "&apos;")}'/>)
        end
        html << %Q(<input type='submit' value='ok' style='display:none'></form>)
        html << "<script>document.forms['goldpaysubmit'].submit();</script>"
        html
      end
    end
  end
end