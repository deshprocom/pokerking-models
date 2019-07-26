##
# 用户查找方法
#
#  User.by_uuid('adfbdd32rfsfa32424')
#
#  User.by_mobile('18620011234')
#
#  User.by_uname('echoflying')
#
#  User.by_email('hello@qq.com')
#
#  先在二级缓存中尝试, 已存在数据, 则直接从缓存加载; 否则尝试从数据库查找
#  如果数据库中查到记录, 自动写入二级缓存并返回该数据
#  如果数据库中没有记录, 则返回 nil
module UserFinders
  extend ActiveSupport::Concern

  module ClassMethods
    ##
    # 查找指定uuid的用户, 支持二级缓存
    def by_uuid(user_uuid)
      fetch_by_uniq_keys(user_uuid: user_uuid)
    end

    ##
    # 查找指定手机号的用户, 支持二级缓存
    def by_mobile(mobile, country_code = '86')
      fetch_by_uniq_keys(mobile: mobile, country_code: country_code)
    end

    ##
    #  查找指定的用户 不需要验证区号
    def by_mobile_without_code(mobile)
      fetch_by_uniq_keys(mobile: mobile)
    end

    ##
    # 查找指定用户名的用户, 支持二级缓存
    def by_nickname(nickname)
      fetch_by_uniq_keys(nickname: nickname)
    end

    ##
    # 查找指定邮箱的用户, 支持二级缓存
    def by_email(email)
      fetch_by_uniq_keys(email: email)
    end

    ##
    #  查找指定账户的用户，支持二级缓存
    def by_account(account_id)
      fetch_by_uniq_keys(account_id: account_id)
    end
  end
end
