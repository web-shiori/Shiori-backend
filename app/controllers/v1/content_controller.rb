class V1::ContentController < ApplicationController
  def index
    render json: {
        "hello": "world"
    }
  end
end
