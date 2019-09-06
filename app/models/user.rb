class User < ActiveRecord::Base
  has_many produts
  has_secure_password
end