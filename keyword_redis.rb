class KeywordRedis
  class << self
    def store_keyword(type, keyword)
      old_keyword = read_keyword(type)
      new_keyword = keyword.blank? ? old_keyword : keyword + '|'+ old_keyword
      Rails.cache.write type, new_keyword, expires_in: 30.days
    end

    def read_keyword(type)
      Rails.cache.read type
    end

    def remove_keyword(type)
      Rails.cache.delete type
    end

    private

    def vcode_cache_key(type, account)
      "pokerking:v1:keyword:#{type}"
    end
  end
end
