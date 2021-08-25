class V1::ContentController < ApplicationController
  def index
    # @content = Content.order('created_at DESC')
    #                   # .where(user_id: current_user.id)
    #                   # .search_by_keyword(query)
    #                   # .page(page)
    #                   # .per(params[per_page)
    @content = Content.order('created_at DESC')
                      .where('LOWER(title) LIKE ?', "%#{params[:q]}%")
                      .page(params[:page])
                      .per(params[:per_page])
    render json: @content
  end


end
