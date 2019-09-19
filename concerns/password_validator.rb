# 用户密码验证器
module PasswordValidator
  PWD_VALID_FORMAT_REGEX = /^[a-fA-F0-9]{32}$/
  extend ActiveSupport::Concern

  module ClassMethods
    def pwd_valid?(pwd)
      # 有效的md5格式 并且密码不能为空
      (pwd.to_s.match? PasswordValidator::PWD_VALID_FORMAT_REGEX) && !pwd.eql?('d41d8cd98f00b204e9800998ecf8427e')
    end
  end
end
