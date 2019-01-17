class User < ApplicationRecord
  include UserFinders
  include UserUniqueValidator
end
