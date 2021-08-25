class V1::ContentController < V1::ApplicationController
  before_action :authenticate_v1_user!

  def index
    @content = Content.order('created_at DESC')
                      .where(user_id: current_v1_user.id)
                      .where('LOWER(title) LIKE ?', "%#{params[:q]}%")
                      .page(params[:page])
                      .per(params[:per_page])

    @meta = {
      q: params[:q],
      page: params[:page],
      per_page: params[:per_page],
      netxPage: @content.next_page
    }

    render json: {
      meta: @meta,
      data: {
        content: @content
      }
    }
  end


end
