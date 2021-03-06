require "spec_helper"

require 'goldpay'
require 'goldpay/web/service'

RSpec.describe Goldpay do
  it "has a version number" do
    expect(Goldpay::VERSION).not_to be nil
  end

  it "does something useful" do
    PUBLIC_KEY = <<EOF
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDcp9NU29EfqPReJLGBS0WZwCKxORrc4IQpKbup1cF4KzQnpMCwcJXF9KW1vJ/ZzOMwAlGfhq2V96MGPOO6T/Zkesasjdmy19wnOdzDxGXu2pEMbFMDOonYxf1m5/VNs2+TZ18eyW585XefXoNlYCzg6RJmXK0fZ1UPAU9ZxgocEQIDAQAB



    
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDcp9NU29EfqPReJLGBS0WZwCKx
ORrc4IQpKbup1cF4KzQnpMCwcJXF9KW1vJ/ZzOMwAlGfhq2V96MGPOO6T/Zkesas
jdmy19wnOdzDxGXu2pEMbFMDOonYxf1m5/VNs2+TZ18eyW585XefXoNlYCzg6RJm
XK0fZ1UPAU9ZxgocEQIDAQAB
-----END PUBLIC KEY-----
EOF
    PRIVATE_KEY = <<EOF
MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAO2u+9vkuQGYwe2Yw0XFXRdhCkvwY4328H2STJjeW2LGDJqYYQVbpw1CNwJ0hKKcpk1/APENbdv84RP7x3YEkQVNoB0uSj8qnpUsnuyBdxLdToohikvOrNRWgQx/ZvgFE+rWjka9wVaKqLUbUWxpq9GiUAPFa78kYOABD8dIMtg9AgMBAAECgYEAgpNzQiaxjLMDNyiJfrcioUlqgrWZu9BB5nqNIh5mTilHm1bDVlI3wAz0c6DXjQ5KPqDbP5KFHCoc7QGRXsC7egNBX9kNtL7ZCuYw78pE5sNM4+885fgoqaBCbnc+PxgyAqQ+ZIO5u6QKXQpEoe7PpvxCVBAGyn/1klaQVidUivECQQD87PnV05v8ibOv0N6cSpEZ8s/mdFVDSw0sFBdxMseFGY/WjDl1g9ZQCuwjrcT5S/mnYgb6MzRJn+s0rfCFlImLAkEA8JKURMVg6GqIleQq4e03uqEZ6AgErBlh2e+1/T9vgij6n/ueZysamHydZAupk3Wsfn1bkmdA4zqOCf7UZueOVwJAHDwIF8qrmyF0IahbcW8Ri6gDdWJ/MifqrIUBqO1WQJF98SFuOKQjBIRzn/gCCSJmGD1lMgENUTq88wCH3SGbyQJBAJzEuDAUe3EZM0aSOEufvQg2QV6OExVfOP+/ENYmB3FHaQLmAjRyx1MFKb9vRiMctLp80DaYaJVqq/Lhh+JDFOMCQQCXrBhjTx4KfLzfUhOVzm5D8w5sAn9Sg1jDeMwe8tyiyUBbbkw+k9qK0YLOfnwKuC3MNI5URjaKyLzilPDZZkrs

    
-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQDtrvvb5LkBmMHtmMNFxV0XYQpL8GON9vB9kkyY3ltixgyamGEF
W6cNQjcCdISinKZNfwDxDW3b/OET+8d2BJEFTaAdLko/Kp6VLJ7sgXcS3U6KIYpL
zqzUVoEMf2b4BRPq1o5GvcFWiqi1G1FsaavRolADxWu/JGDgAQ/HSDLYPQIDAQAB
AoGBAIKTc0ImsYyzAzcoiX63IqFJaoK1mbvQQeZ6jSIeZk4pR5tWw1ZSN8AM9HOg
140OSj6g2z+ShRwqHO0BkV7Au3oDQV/ZDbS+2QrmMO/KRObDTOPvPOX4KKmgQm53
Pj8YMgKkPmSDubukCl0KRKHuz6b8QlQQBsp/9ZJWkFYnVIrxAkEA/Oz51dOb/Imz
r9DenEqRGfLP5nRVQ0sNLBQXcTLHhRmP1ow5dYPWUArsI63E+Uv5p2IG+jM0SZ/r
NK3whZSJiwJBAPCSlETFYOhqiJXkKuHtN7qhGegIBKwZYdnvtf0/b4Io+p/7nmcr
Gph8nWQLqZN1rH59W5JnQOM6jgn+1GbnjlcCQBw8CBfKq5shdCGoW3FvEYuoA3Vi
fzIn6qyFAajtVkCRffEhbjikIwSEc5/4AgkiZhg9ZTIBDVE6vPMAh90hm8kCQQCc
xLgwFHtxGTNGkjhLn70INkFejhMVXzj/vxDWJgdxR2kC5gI0csdTBSm/b0YjHLS6
fNA2mGiVaqvy4YfiQxTjAkEAl6wYY08eCny831ITlc5uQ/MObAJ/UoNYw3jMHvLc
oslAW25MPpPaitGCzn58CrgtzDSOVEY2isi84pTw2WZK7A==
-----END RSA PRIVATE KEY-----
EOF
    Goldpay.configure do |config|
      config.private_key = PRIVATE_KEY
      config.public_key  = PUBLIC_KEY
      config.mchnt_cd    = "0002900F0006944"
    end
    # p Goldpay::Web::Service.web_reg(
    # ver: '0.44',
    # certif_tp: '1',
    # certif_id: '340200199007191103',
    # page_notify_url:'http://www.happysong.com.cn')
    # p Goldpay::Web::Service.web_artifreg({ver: '0.44', page_notify_url:'http://www.happysong.com.cn'})
    # p Goldpay::Web::Service.no_login_fast_recharge(login_id: '13678424821', amt: '10000', page_notify_url: 'http://www.happysong.com.cn')
    # p Goldpay::Service.reg(ver: '0.44', certif_tp: '1', certif_id: '340200199007191103', cust_nm: '麻美',  page_notify_url:'http://www.happysong.com.cn', mobile_no: "13265666809", city_id: 1000, parent_bank_id: 0102, capAcntNo: "1234567689")
    xml = <<-XML
      <?xml version=\"1.0\" encoding=\"UTF-8\"?><ap><plain><resp_code>5019</resp_code><resp_desc>\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81\xE8\xAF\xA5\xE9\x93\xB6\xE8\xA1\x8C\xE5\xBC\x80\xE6\x88\xB7</resp_desc><mchnt_cd>0002900F0006944</mchnt_cd><mchnt_txn_ssn>201711201411425210160000</mchnt_txn_ssn></plain><signature>zbWeeVPLDsEjfw5FfnfaYQzZ8JnHzh5GSq9PdtYrDgT3YznNncRVpfqmWMZbUutS2JJoec4/tp6cJN9uaLP3MeujI45PaekoTqHjHln3G+EMzOcUDMRJABs/CRtQ62MhctrX+Rz7uPMdxqiKUSgO723urOycSzJZZcbwK3MkT14=</signature></ap>
    XML
    keys = %w(bank_nm capAcntNo certif_id  city_id cust_nm email mchnt_cd mchnt_txn_ssn mobile_no parent_bank_id resp_code user_id_from)
    data = {"capAcntNo"=>"", "user_id_from"=>"1", "city_id"=>"", "artif_nm"=>"", "email"=>"", "resp_code"=>"5002", "mchnt_cd"=>"0002900F0006944", "cust_nm"=>"储亮", "certif_id"=>"342921199412231510", "parent_bank_id"=>"", "signature"=>"aMJ7dy7M01LtAyTSGqpzYdyYO+haVu/22CHJiWGmCVVjACWyy0MDhSv9+Hpw5MNxDBqtm0mXF5zvajfacPnZPtMtINUki0JKO+xrqgGlMAIN6uUmq4vK6hxX8gNq35mxCXOodyq5KzyXnl25FFKKQs7E0BA459TfSaPd2+gEf+s=", "mchnt_txn_ssn"=>"201711201530402759500001", "mobile_no"=>"15665666809", "bank_nm"=>"", "controller"=>"api/v1/accounts", "action"=>"page_notify", "id"=>"1"}
    # p Goldpay::Utils.json_verify?(data, keys )
    # p Goldpay::Web::Service.no_login_fast_recharge(login_id: '13678424821', amt: '10000', page_notify_url: 'http://www.happysong.com.cn')
    a = Goldpay::Utils.generate_batch_no
    p a
    p Goldpay::Web::Service.web_reg(
        mchnt_txn_ssn: a,
        ver: ' 0.44',
        user_id_from: '1',
        mobile_no: '15665666809',
        cust_nm: '出量',
        certif_tp: '0',
        certif_id: '34292119412231510',
        page_notify_url: 'http://localhost/api/v1/accounts/1',
    )
  end
end
