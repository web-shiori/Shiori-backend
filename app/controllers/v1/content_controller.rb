class V1::ContentController < V1::ApplicationController
  before_action :authenticate_v1_user!
  skip_before_action :verify_authenticity_token

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

  def create
    @content = current_v1_user.content.build(content_params)
    # TODO: サムネイルのurlを追加
    # TODO: typeを設定
    if @content.save
      render json: {
        data: @content
      }
    else
      render status: :bad_request, json: { "message": 'content creation faild' }
    end
  end

  private def content_params
    params.permit(
      :title,
      :url,
      :scroll_position_x,
      :scroll_position_y,
      :max_scroll_position_x,
      :max_scroll_position_y,
      :video_playback_position,
      :specified_text,
      :specified_dom_class,
      :specified_dom_id,
      :specified_dom_tag
    )
  end
end
