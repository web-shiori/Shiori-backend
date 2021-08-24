class V1::ApplicationController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

end
