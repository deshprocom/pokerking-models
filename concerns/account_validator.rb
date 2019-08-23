# 手机格式验证器
module AccountValidator
  # 有效手机号格式
  ACCOUNT_VALID_FORMAT_REGEX = /^[a-zA-Z][a-zA-z0-9_@]{4,15}$/

  extend ActiveSupport::Concern

  module ClassMethods
    def account_valid?(account)
      account =~ AccountValidator::ACCOUNT_VALID_FORMAT_REGEX ? true : false
    end
  end
end
